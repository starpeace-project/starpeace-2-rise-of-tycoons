/* Microsoft SQL Server - Scripting			*/
/* Server: (LOCAL)					*/
/* Database: FiveDS					*/
/* Creation Date 3/19/2001 1:16 PM  			*/


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* priv_InsertKey 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE priv_InsertKey
 
  @full_path VARCHAR(1024)
AS
  BEGIN
    EXEC proc_InsertKey @full_path
  END
GO
  
  
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_InsertKey    												   */	
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_InsertKey
 
  @full_path VARCHAR(1024)
 
AS
  BEGIN
    SELECT @full_path = LOWER(@full_path)

    IF @full_path IS NOT NULL
      BEGIN
        DECLARE @pos	INTEGER
		DECLARE @key_id	UNIQUEIDENTIFIER
 
        SELECT @pos = CHARINDEX('/', REVERSE(@full_path))
        IF @pos > 0
          BEGIN
            DECLARE @parent_path VARCHAR(128)
            SELECT  @parent_path = LEFT(@full_path, LEN(@full_path) - @pos)
 
            DECLARE @parent_id		UNIQUEIDENTIFIER
            DECLARE @parent_depth	INTEGER
 
            SELECT @parent_id = key_id, @parent_depth = depth FROM tbl_KeyPaths WHERE full_path = @parent_path
            IF @parent_id IS NULL
              BEGIN
                EXEC priv_InsertKey @parent_path
                SELECT @parent_id = key_id, @parent_depth = depth FROM tbl_KeyPaths WHERE full_path = @parent_path
              END
 
            DECLARE @key_name VARCHAR(128)
            SELECT
              @key_id   = NEWID(),
              @key_name = RIGHT(@full_path, @pos - 1)

            INSERT INTO tbl_Keys			VALUES (@key_id, @parent_id, @key_name, 0)
            INSERT INTO tbl_KeyPaths		VALUES (@key_id, @full_path, @parent_depth + 1)
            INSERT INTO tbl_KeyAncestors	VALUES (@key_id, @parent_id)
            INSERT INTO tbl_KeyAncestors	SELECT @key_id, ancestor_key FROM tbl_KeyAncestors WHERE key_id = @parent_id
          END
        ELSE
          BEGIN
            SELECT @key_id = NEWID()
            INSERT INTO tbl_Keys		VALUES (@key_id, @key_id, @full_path, 0)
            INSERT INTO tbl_KeyPaths	VALUES (@key_id, @full_path, 0)
          END
      END
  END
GO
  

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_DeleteKey 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE PROCEDURE proc_DeleteKey
 
  @full_path VARCHAR(1024)
 
AS
  BEGIN
    IF EXISTS (SELECT * FROM tbl_KeyPaths WHERE full_path = @full_path)
      BEGIN
        DECLARE @key_id    UNIQUEIDENTIFIER
        DECLARE @key_depth SMALLINT
        SELECT
          @key_id    = key_id,
          @key_depth = depth
        FROM
          tbl_KeyPaths
        WHERE
          full_path = @full_path
    
        CREATE TABLE #drop_list
        (
          key_id UNIQUEIDENTIFIER PRIMARY KEY,
          depth  SMALLINT
        )
    
        INSERT INTO #drop_list VALUES (@key_id, @key_depth)
    
        INSERT
          INTO #drop_list
          SELECT key_id, depth FROM tbl_KeyPaths WHERE key_id IN
          (
            SELECT key_id FROM tbl_KeyAncestors WHERE ancestor_key = @key_id
          )
    
        DECLARE @d INTEGER
        SELECT @d = MAX (depth) FROM #drop_list
        WHILE (@d >= @key_depth)
          BEGIN
            DELETE FROM tbl_KeyPaths     WHERE key_id IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            DELETE FROM tbl_KeyAncestors WHERE key_id IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            DELETE FROM tbl_Values       WHERE parent_key_id IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            DELETE FROM tbl_Keys         WHERE id  IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            SELECT @d = @d - 1
          END
    
        DROP TABLE #drop_list
      END
    ELSE
      RAISERROR ('No such a key (%s) exists in the directory.', 16, 1, @full_path)
  END
GO  
  
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_DeleteValue 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_DeleteValue

	  @key_path     VARCHAR (1024),
	  @value_name	VARCHAR	(128)
	  
AS
	BEGIN
		DELETE	
			FROM	tbl_Values
			WHERE	parent_key_id = 
			( 
				SELECT key_id 
					FROM  tbl_KeyPaths 
					WHERE full_path = @key_path AND name = @value_name 
			)
	END
GO
 

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_RenameKey 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_RenameKey
 
  @full_path		VARCHAR(1024),
  @new_key_name		VARCHAR (128),
  @old_key_name		VARCHAR (128),
  @is_secured		BIT
 
AS
  BEGIN
    SET @full_path	  = LOWER(@full_path)
    SET @new_key_name = LOWER(@new_key_name)
    SET @old_key_name = LOWER(@old_key_name)

    EXEC proc_SetSecurityOfKey @full_path, @is_secured	

    
    DECLARE @key_id UNIQUEIDENTIFIER
    DECLARE @idx	INT
    
    SELECT 
      @key_id = key_id 
    FROM 
      tbl_KeyPaths 
    WHERE 
      full_path = @full_path   	
      
    IF @key_id IS NOT NULL
      BEGIN

        UPDATE tbl_keys
          SET  rel_name = @new_key_name, is_secured = @is_secured
        WHERE id = @key_id 

        SELECT @idx = CHARINDEX( '/' + @old_key_name + '/', @full_path )
        IF @idx <> 0
          SELECT @full_path = STUFF( @full_path, @idx + 1, LEN(@old_key_name), @new_key_name )
        ELSE  
          BEGIN
            SELECT @idx = CHARINDEX('/'+ @old_key_name, @full_path)
            IF @idx <> 0
              SELECT @full_path = STUFF( @full_path, @idx + 1, LEN(@old_key_name), @new_key_name )
            ELSE
              BEGIN
                SELECT @idx = CHARINDEX  (@old_key_name, @full_path)
                SELECT @full_path = STUFF( @full_path, @idx, LEN(@old_key_name), @new_key_name )
              END   
          END

        UPDATE tbl_keyPaths
          SET   full_path = @full_path
		  WHERE key_id = @key_id 
 
        DECLARE cur CURSOR FOR
        SELECT
          p.full_path, p.key_id
        FROM 
          tbl_KeyPaths     p,
          tbl_KeyAncestors a
        WHERE  
          ancestor_key = @key_id and p.key_id = a.key_id
		    
        OPEN cur
        FETCH NEXT FROM cur INTO @full_path, @key_id		 
        WHILE @@FETCH_STATUS = 0
          BEGIN
            SELECT @idx = CHARINDEX( '/' + @old_key_name + '/', @full_path )
            IF @idx <> 0
              SELECT @full_path = STUFF( @full_path, @idx + 1, LEN(@old_key_name), @new_key_name )
            ELSE  
              BEGIN
                SELECT @idx = CHARINDEX('/'+ @old_key_name, @full_path)
                IF @idx <> 0
                  SELECT @full_path = STUFF( @full_path, @idx + 1, LEN(@old_key_name), @new_key_name )
                ELSE
                  BEGIN
                    SELECT @idx = CHARINDEX(@old_key_name, @full_path)
                    SELECT @full_path = STUFF( @full_path, @idx, LEN(@old_key_name), @new_key_name )
                  END   
              END  
		
            UPDATE tbl_keyPaths
                SET   full_path = @full_path
				WHERE key_id    = @key_id 
		    
            FETCH NEXT FROM cur INTO @full_path, @key_id 
          END
		 
        CLOSE cur
        DEALLOCATE cur
      END
  END
GO


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_WriteValue 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_WriteValue
 
  @key_path     VARCHAR (1024),
  @value_name	VARCHAR (128),
  @value_kind	TINYINT,
  @value        VARCHAR (500),
  @is_Secured	BIT
  
AS
  BEGIN
    SELECT @value_name	= LOWER(@value_name)
    SELECT @key_path	= LOWER(@key_path)

    DECLARE @key_id		UNIQUEIDENTIFIER
    SELECT  @key_id = key_id FROM tbl_KeyPaths WHERE full_path = @key_path
    IF @key_id IS NULL
      BEGIN
        EXECUTE proc_InsertKey @key_path
        SELECT  @key_id = key_id FROM tbl_KeyPaths WHERE full_path = @key_path
      END

    DECLARE @value_id	UNIQUEIDENTIFIER
    DECLARE @kind		TINYINT
      
	SELECT 
		@value_id = v.id, 
		@kind	  = v.kind
	FROM   
		tbl_Values		v,      
		tbl_keyPaths	p
	WHERE
		p.key_id = v.parent_key_id AND v.name = @value_name AND p.full_path = @key_path
		
	IF @value_id IS NOT NULL
		BEGIN	
			IF @kind = 7 
				BEGIN
					UPDATE	tbl_Values
					SET		kind = @value_kind, value = @value, is_secured = @is_secured, bigText = NULL
					WHERE	id = @value_id
				END	
			ELSE
				BEGIN
					UPDATE	tbl_Values
					SET		kind = @value_kind, value = @value, is_secured = @is_secured
					WHERE	id = @value_id
				END
		END
	ELSE
		BEGIN
			SELECT  @value_id = NEWID()
				INSERT
					INTO tbl_Values ( id, parent_key_id, name, kind, value, is_Secured  )
					VALUES (@value_id, @key_id, @value_name, @value_kind, @value, @is_Secured )
		END
  END
GO
  

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_WriteBigValue 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

  
CREATE PROCEDURE proc_WriteBigValue
 
  @key_path     VARCHAR (1024),
  @value_name	VARCHAR (128),
  @value        TEXT,
  @is_Secured	BIT
  
AS
  BEGIN
    SELECT @value_name	= LOWER(@value_name)
    SELECT @key_path	= LOWER(@key_path)

    DECLARE @key_id		UNIQUEIDENTIFIER
    SELECT  @key_id = key_id FROM tbl_KeyPaths WHERE full_path = @key_path
    IF @key_id IS NULL
      BEGIN
        EXECUTE proc_InsertKey @key_path
        SELECT  @key_id = key_id FROM tbl_KeyPaths WHERE full_path = @key_path
      END

    DECLARE @value_id	UNIQUEIDENTIFIER
    DECLARE @kind		TINYINT
    DECLARE @len		INTEGER
    
	DECLARE @db_name   CHAR(30)
	SELECT  @db_name = DB_Name()
      
	SELECT 
		@value_id = v.id, 
		@kind	  = v.kind
	FROM   
		tbl_Values		v,      
		tbl_keyPaths	p
	WHERE
		p.key_id = v.parent_key_id AND v.name = @value_name AND p.full_path = @key_path
		

    SET @len = DATALENGTH(@value)
	IF @value_id IS NOT NULL
		BEGIN	
			IF @kind <> 7
				BEGIN
					UPDATE	tbl_Values
					SET		value = '', bigText = '', kind = 7, is_secured = @is_secured, size = @len
					WHERE	id = @value_id
				END
			ELSE
				BEGIN			  
					UPDATE	tbl_Values
					SET		kind = 7, is_secured = @is_secured, size = @len
					WHERE	id = @value_id
				END
			
			EXEC sp_dboption @db_name, 'select into/bulkcopy' , 'true'
			
            DECLARE @ptrval VARBINARY (16)
            
            SELECT	@ptrval = TEXTPTR ( bigText )
            FROM	tbl_Values v
            WHERE	v.id = @value_id
            
            WRITETEXT tbl_values.bigText @ptrval @value
			
			EXEC sp_dboption @db_name, 'select into/bulkcopy' , 'false'
		END
	ELSE
		BEGIN
			SELECT  @value_id = NEWID()
			INSERT
				INTO tbl_Values ( id, parent_key_id, name, kind, value, is_Secured, bigText, size  )
				VALUES (@value_id, @key_id, @value_name, 7, '', @is_Secured, '', @len )
				
			EXEC sp_dboption @db_name, 'select into/bulkcopy' , 'true'
			
            SELECT	@ptrval = TEXTPTR ( bigText )
            FROM	tbl_Values v
            WHERE	v.id = @value_id
            
            WRITETEXT tbl_values.bigText @ptrval @value
			
			EXEC sp_dboption @db_name, 'select into/bulkcopy' , 'false'
		END
  END
GO


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_ReadValue 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_ReadValue
 
  @key_path     VARCHAR (1024),
  @value_name	VARCHAR (128),
  @is_Secured	BIT,
  
  @value        VARCHAR (500) OUTPUT
  
AS
	BEGIN
		SELECT @value = value 
		FROM   tbl_Values 
		WHERE  parent_key_id = 
		(
			SELECT	key_id 
			FROM	tbl_KeyPaths
			WHERE	full_path = @key_path AND name = @value_name AND is_secured <= @is_Secured
		)
  END
GO

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_ReadBigValue 											           */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE PROCEDURE proc_ReadBigValue
 
  @key_path     VARCHAR (1024),
  @value_name	VARCHAR  (128),
  @is_Secured	BIT
  
AS
	BEGIN
		DECLARE @value_id	UNIQUEIDENTIFIER
		DECLARE @size		INTEGER				
		
        SELECT 
			@value_id	= v.id, 
			@size		= v.size		
        FROM 
			tbl_values		v, 
			tbl_KeyPaths	p
        WHERE 
			p.key_id = v.parent_key_id AND v.name = @value_name AND p.full_path = @key_path
                
		IF @value_id IS NOT NULL
			BEGIN
                DECLARE @ptrval varbinary(16)
                
                SELECT @ptrval = TEXTPTR(bigText)
                FROM   tbl_values v
                WHERE  v.id = @value_id AND is_secured <= @is_Secured 
					
                READTEXT tbl_values.bigText @ptrval 0 @size 
			END
  END
GO
  
  
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_KeyCounts 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_keyCounts
 
  @key_path     VARCHAR (1024),
  @is_Secured	TINYINT,
  
  @counter INTEGER OUTPUT
  
AS
	BEGIN
		SELECT
			@counter = COUNT(*) 	
			FROM  tbl_Keys
			WHERE parent_key = 
			( 
				SELECT key_id 
					FROM  tbl_KeyPaths 
					WHERE full_path = @key_path AND is_secured <= @is_Secured 
			)
	END			
GO


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_valuesCount 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_valuesCount

  @key_path     VARCHAR (1024),
  @is_Secured	BIT,
  
  @counter		INTEGER OUTPUT
 
AS
	BEGIN
		SELECT @counter = COUNT(*) 	
			FROM tbl_Values
			WHERE parent_key_id = 
			( 
				SELECT key_id 
					FROM  tbl_KeyPaths 
					WHERE full_path = @key_path AND is_secured <= @is_Secured 
			)
	END			
GO	
	
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_GetKeyNames 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
	

CREATE PROCEDURE proc_GetKeyNames

	  @key_path     VARCHAR(1024),
	  @is_secured	BIT
	  
AS
	BEGIN
		IF @key_path <> ''
			BEGIN
				SELECT	rel_name
				FROM	tbl_Keys	
				WHERE	parent_key = 
				( 
					SELECT	key_id 
						FROM  tbl_KeyPaths 
						WHERE full_Path = @key_path AND key_id <> id AND is_secured <= @is_secured 
				)
				ORDER BY rel_name
			END
		ELSE
			BEGIN
				SELECT	rel_name
					FROM  tbl_Keys	
					WHERE parent_key = 
					( 
						SELECT key_id 
							FROM  tbl_KeyPaths 
							WHERE key_id = id AND is_secured <= @is_secured 
					)
				ORDER BY rel_name
			END
	END
GO	
	
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_GetValueNames 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_GetValueNames

	  @key_path     VARCHAR (1024),
	  @is_Secured	BIT
	  
AS
	BEGIN
		SELECT	name
		FROM	tbl_Values	
		WHERE	parent_key_id = 
		( 
			SELECT	key_id 
				FROM  tbl_KeyPaths 
				WHERE full_Path = @key_path AND is_secured <= @is_Secured 
		)
		ORDER BY name
	END
GO

	
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_SetSecurityOfKey 											   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_SetSecurityOfKey

	  @key_path     VARCHAR (1024),
	  @is_secured	BIT
	  
AS
	BEGIN
		DECLARE @key_id UNIQUEIDENTIFIER
		 
		SET @key_id = ( SELECT key_id FROM tbl_KeyPaths WHERE full_path = @key_path )
		
		IF @key_id IS NOT NULL
			BEGIN
				UPDATE	tbl_Keys
					SET	 is_secured = @is_secured
					WHERE	 id IN 
					(
						SELECT key_id 
							FROM  tbl_KeyPaths   
							WHERE full_path = @key_path OR full_path LIKE @key_path + '/%'
					)
				UPDATE	tbl_Values
					SET	is_secured = @is_secured
					WHERE	parent_key_id IN 
					(
						SELECT key_id 
							FROM  tbl_KeyPaths 
							WHERE full_path = @key_path OR full_path LIKE @key_path + '/%'
					) 
			END
	END
GO
	

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_SetSecurityOfValue 											   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_SetSecurityOfValue

	  @key_path     VARCHAR (1024),
	  @value_name	VARCHAR	(128),
	  @is_Secured	BIT
AS
	BEGIN
		UPDATE	tbl_Values
		SET		is_Secured	= @is_Secured
		WHERE	parent_key_id = ( SELECT Key_id FROM tbl_KeyPaths WHERE full_path = @key_path AND name = @value_name )
	END
GO	



/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_IsSecurityKey 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_IsSecurityKey

	  @key_path     VARCHAR (1024),
	  
	  @is_secured	BIT OUTPUT
	  
AS
	BEGIN
		SELECT	@is_secured = is_secured
		FROM	tbl_Keys
		WHERE	id = ( SELECT key_id FROM tbl_KeyPaths WHERE full_path = @key_path )
	END
GO	
	

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_IsSecurityKey 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_IsSecurityValue

	  @key_path     VARCHAR (1024),
	  @value_name	VARCHAR	 (128),
	  
	  @is_secured	BIT OUTPUT
	  
AS
	BEGIN
		SELECT	@is_secured = is_secured
		FROM	tbl_Values
		WHERE	parent_key_id = ( SELECT key_id FROM tbl_KeyPaths WHERE full_path = @key_path AND name = @value_name )
	END
GO	


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_TypeOf 													   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_TypeOf

	  @key_path     VARCHAR (1024),
	  @value_name	VARCHAR	(128),
	  
	  @kind_of		TINYINT OUTPUT
AS
	BEGIN
		SELECT	@kind_of = kind
		FROM	tbl_Values
		WHERE	parent_key_id = ( SELECT key_id FROM tbl_KeyPaths WHERE full_path = @key_path AND name = @value_name )
	END
GO	


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_FullPathKeyExists 											   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_FullPathKeyExists

	  @key_path     VARCHAR (1024),
	  
	  @key_exist	BIT OUTPUT
	  
AS
	BEGIN
		DECLARE @counter INTEGER	

		SELECT	@counter = COUNT(*)
		FROM	tbl_Keys
		WHERE	id = ( SELECT key_id FROM tbl_KeyPaths WHERE full_path = @key_path ) 

		IF @counter > 0
			SET @key_exist = 1
		ELSE 
			SET @key_exist = 0
	END
GO
	

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_FullPathValueExists 											   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE PROCEDURE proc_FullPathValueExists

	  @key_path     VARCHAR (1024),
	  @value_name	VARCHAR	 (128),
	  
	  @value_exist	BIT OUTPUT
	  
AS
	BEGIN
		DECLARE @counter INTEGER	
	
		SELECT	@counter = COUNT(*) 
		FROM	tbl_Values
		WHERE	parent_key_id = ( SELECT key_id FROM tbl_KeyPaths WHERE full_path = @key_path AND name = @value_name ) 

		IF @counter > 0
			SET @value_exist = 1
		ELSE 
			SET @value_exist = 0
	END
GO


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_IntegrateValues 											   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE PROCEDURE proc_IntegrateValues

	  @key_path     VARCHAR (1024),
	  
	  @result		FLOAT OUTPUT
	  
AS
	BEGIN
		SELECT 
			@result = SUM ( CAST( value AS FLOAT ) ) 
		FROM 
			tbl_Values
		WHERE 
			(kind = 2 or kind = 3) AND parent_key_id IN 
		(
			SELECT key_id 
				FROM  tbl_KeyPaths   
				WHERE full_path = @key_path OR full_path LIKE @key_path + '/%'
		)		
	END
GO
	
	
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* proc_IsOrHaveKeySecured 											   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
	
	
CREATE PROCEDURE proc_IsOrHaveKeySecured

	@full_path		VARCHAR(1024),

	@result			BIT
	
AS
	BEGIN
		DECLARE @counter INTEGER
		
		SELECT @counter = COUNT(*) 
			FROM  tbl_KeyAncestors a, tbl_KeyPaths p, tbl_Keys k
			WHERE a.ancestor_key = p.key_id AND p.full_path = @full_path AND k.id = a.key_id AND k.is_secured = 1
			
		IF @counter	> 0
			SET @result = 1
		ELSE
			SET @result = 0
	END
GO
