/* Microsoft SQL Server - Scripting			*/
/* Server: (LOCAL)					*/
/* Database: FiveDS					*/
/* Creation Date 12/8/2000 10:02:01 AM 			*/

/****** Object:  Stored Procedure dbo.proc_InsertValue    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[proc_InsertValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_InsertValue]
GO

/****** Object:  Stored Procedure dbo.proc_DeleteKey    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[proc_DeleteKey]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_DeleteKey]
GO

/****** Object:  Stored Procedure dbo.proc_InsertKey    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[proc_InsertKey]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_InsertKey]
GO

/****** Object:  Stored Procedure dbo.proc_RenameKey    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[proc_RenameKey]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[proc_RenameKey]
GO

/****** Object:  Stored Procedure dbo.pxy_InsertKey    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[pxy_InsertKey]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[pxy_InsertKey]
GO

/****** Object:  Table [dbo].[Results]    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[Results]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Results]
GO

/****** Object:  Table [dbo].[tbl_Imported]    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[tbl_Imported]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbl_Imported]
GO

/****** Object:  Table [dbo].[tbl_KeyAncestors]    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[tbl_KeyAncestors]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbl_KeyAncestors]
GO

/****** Object:  Table [dbo].[tbl_KeyPaths]    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[tbl_KeyPaths]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbl_KeyPaths]
GO

/****** Object:  Table [dbo].[tbl_Keys]    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[tbl_Keys]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbl_Keys]
GO

/****** Object:  Table [dbo].[tbl_Values]    Script Date: 12/8/2000 10:00:23 AM ******/
if exists (select * from sysobjects where id = object_id(N'[dbo].[tbl_Values]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbl_Values]
GO

/****** Object:  Table [dbo].[Results]    Script Date: 12/8/2000 10:00:29 AM ******/
CREATE TABLE [dbo].[Results] (
	[value_name] [varchar] (8000) NULL ,
	[key_id] [uniqueidentifier] NOT NULL ,
	[Kind] [tinyint] NULL ,
	[Value] [text] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tbl_Imported]    Script Date: 12/8/2000 10:00:30 AM ******/
CREATE TABLE [dbo].[tbl_Imported] (
	[ID] [int] NULL ,
	[ParentID] [int] NULL ,
	[Kind] [tinyint] NULL ,
	[Entry] [varchar] (255) NULL ,
	[Value] [text] NULL ,
	[Security] [tinyint] NULL ,
	[ValueSize] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tbl_KeyAncestors]    Script Date: 12/8/2000 10:00:30 AM ******/
CREATE TABLE [dbo].[tbl_KeyAncestors] (
	[key_id] [uniqueidentifier] NOT NULL ,
	[ancestor_key] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tbl_KeyPaths]    Script Date: 12/8/2000 10:00:30 AM ******/
CREATE TABLE [dbo].[tbl_KeyPaths] (
	[key_id]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[full_path] [varchar] (900) NOT NULL ,
	[depth] [smallint] NOT NULL 
)
GO

/****** Object:  Table [dbo].[tbl_Keys]    Script Date: 12/8/2000 10:00:30 AM ******/
CREATE TABLE [dbo].[tbl_Keys] (
	[id] [uniqueidentifier] NOT NULL ,
	[parent_key] [uniqueidentifier] NOT NULL ,
	[rel_name] [varchar] (128) NOT NULL ,
	[is_secured] [bit] NOT NULL 
)
GO

/****** Object:  Table [dbo].[tbl_Values]    Script Date: 12/8/2000 10:00:31 AM ******/
CREATE TABLE [dbo].[tbl_Values] (
	[id] [uniqueidentifier] NOT NULL ,
	[parent_key_id] [uniqueidentifier] NOT NULL ,
	[Name] [varchar] (128) NOT NULL ,
	[Kind] [tinyint] NOT NULL ,
	[Value] [varchar] (500) NOT NULL ,
	[bigText] [text] NULL ,
	[size] [int] NOT NULL ,
	[is_Secured] [bit] NOT NULL 
)
GO

ALTER TABLE [dbo].[tbl_KeyPaths] WITH NOCHECK ADD 
	CONSTRAINT [PK_KeyPaths] PRIMARY KEY  CLUSTERED 
	(
		[key_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tbl_Keys] WITH NOCHECK ADD 
	CONSTRAINT [PK_Keys] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tbl_Values] WITH NOCHECK ADD 
	CONSTRAINT [PK_Values] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tbl_KeyPaths] WITH NOCHECK ADD 
	CONSTRAINT [DF_tbl_KeyPaths_depth] DEFAULT (0) FOR [depth],
	CONSTRAINT [AK_KeyPaths] UNIQUE  NONCLUSTERED 
	(
		[full_path]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tbl_Keys] WITH NOCHECK ADD 
	CONSTRAINT [DF_Keys_is_secured] DEFAULT (0) FOR [is_secured],
	CONSTRAINT [AK_Keys] UNIQUE  NONCLUSTERED 
	(
		[parent_key],
		[rel_name]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tbl_Values] WITH NOCHECK ADD 
	CONSTRAINT [DF_tbl_Values_bigText] DEFAULT (null) FOR [bigText],
	CONSTRAINT [DF_tbl_Values_size] DEFAULT (0) FOR [size],
	CONSTRAINT [DF_tbl_Values_Security] DEFAULT (0) FOR [is_Secured],
	CONSTRAINT [AK_Values] UNIQUE  NONCLUSTERED 
	(
		[parent_key_id],
		[Name]
	)  ON [PRIMARY] 
GO

 CREATE  UNIQUE  INDEX [IX_tbl_KeyAncestors] ON [dbo].[tbl_KeyAncestors]([key_id], [ancestor_key]) ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

/****** Object:  Stored Procedure dbo.pxy_InsertKey    Script Date: 12/8/2000 10:00:31 AM ******/
CREATE PROCEDURE pxy_InsertKey
 
  @full_path VARCHAR(900)
 
AS
  BEGIN
    EXEC proc_InsertKey @full_path
  END

GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

/****** Object:  Stored Procedure dbo.proc_DeleteKey    Script Date: 12/8/2000 10:00:31 AM ******/
CREATE PROCEDURE proc_DeleteKey
 
  @full_path VARCHAR(900)
 
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
            DELETE FROM tbl_KeyPaths        WHERE key_id IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            DELETE FROM tbl_KeyAncestors WHERE key_id IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            DELETE FROM tbl_Values            WHERE parent_key_id IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            DELETE FROM tbl_Keys               WHERE id  IN (SELECT key_id FROM #drop_list WHERE depth = @d)
            SELECT @d = @d - 1
          END
    
        DROP TABLE #drop_list
      END
    ELSE
      RAISERROR ('No such a key (%s) exists in the directory.', 16, 1, @full_path)
  END


GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

/****** Object:  Stored Procedure dbo.proc_InsertKey    Script Date: 12/8/2000 10:00:31 AM ******/
CREATE PROCEDURE proc_InsertKey
 
  @full_path VARCHAR(900)
 
AS
  BEGIN
    SELECT @full_path = LOWER(@full_path)

    IF @full_path IS NOT NULL
      BEGIN
        DECLARE @key_id  UNIQUEIDENTIFIER
        DECLARE @pos       INTEGER
 
        SELECT @pos = CHARINDEX('/', REVERSE(@full_path))
        IF @pos > 0
          BEGIN
            DECLARE @parent_path VARCHAR(128)
            SELECT    @parent_path = LEFT(@full_path, LEN(@full_path) - @pos)
 
            DECLARE @parent_id       UNIQUEIDENTIFIER
            DECLARE @parent_depth INTEGER
 
            SELECT @parent_id = key_id, @parent_depth = depth FROM tbl_KeyPaths WHERE full_path = @parent_path
            IF @parent_id IS NULL
              BEGIN
                EXEC pxy_InsertKey @parent_path
                SELECT @parent_id = key_id, @parent_depth = depth FROM tbl_KeyPaths WHERE full_path = @parent_path
              END
 
            DECLARE @key_name VARCHAR(128)
            SELECT
              @key_id       = NEWID(),
              @key_name = RIGHT(@full_path, @pos - 1)

            INSERT INTO tbl_Keys                VALUES (@key_id, @parent_id, @key_name, 0)
            INSERT INTO tbl_KeyPaths         VALUES (@key_id, @full_path, @parent_depth + 1)
            INSERT INTO tbl_KeyAncestors  VALUES (@key_id, @parent_id)
            INSERT INTO tbl_KeyAncestors  SELECT @key_id, ancestor_key FROM tbl_KeyAncestors WHERE key_id = @parent_id
          END
        ELSE
          BEGIN
            SELECT @key_id = NEWID()
            INSERT INTO tbl_Keys        VALUES (@key_id, @key_id, @full_path, 0)
            INSERT INTO tbl_KeyPaths VALUES (@key_id, @full_path, 0)
          END
      END
  END









GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

/****** Object:  Stored Procedure dbo.proc_RenameKey    Script Date: 12/8/2000 10:00:31 AM ******/
CREATE PROCEDURE proc_RenameKey
 
  @full_path             VARCHAR(900),
  @new_key_name VARCHAR(250),
  @old_key_name   VARCHAR(250),
  @is_secured         BIT
 
AS
  BEGIN
    SET @full_path              = LOWER(@full_path)
    SET @new_key_name  = LOWER(@new_key_name)
    SET @old_key_name    = LOWER(@old_key_name)
    
    DECLARE @key_id UNIQUEIDENTIFIER
    DECLARE @idx       INT
    
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
                SELECT @idx = CHARINDEX(@old_key_name, @full_path)
                SELECT @full_path = STUFF( @full_path, @idx, LEN(@old_key_name), @new_key_name )
              END   
          END

        UPDATE tbl_keyPaths
          SET  full_path = @full_path
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
              SET full_path = @full_path
            WHERE key_id = @key_id 
		    
            FETCH NEXT FROM cur INTO @full_path, @key_id 
          END
		 
        CLOSE cur
        DEALLOCATE cur
      END
  END







GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

SET QUOTED_IDENTIFIER  ON    SET ANSI_NULLS  ON 
GO

/****** Object:  Stored Procedure dbo.proc_InsertValue    Script Date: 12/8/2000 10:00:31 AM ******/
CREATE PROCEDURE proc_InsertValue
 
  @key_path      VARCHAR (1024),
  @value_name VARCHAR (128),
  @value_kind   TINYINT,
  @value            VARCHAR (8000)
 
AS
  BEGIN
    SELECT @value_name = LOWER(@value_name)
  
    DECLARE @key_id UNIQUEIDENTIFIER
    SELECT  @key_id = key_id FROM tbl_KeyPaths WHERE full_path = @key_path
    IF @key_id IS NULL
      BEGIN
        EXECUTE proc_InsertKey @key_path
        SELECT  @key_id = key_id FROM tbl_KeyPaths WHERE full_path = @key_path
      END
 
    DECLARE @value_id UNIQUEIDENTIFIER
    SELECT  @value_id = NEWID()
 
    IF @value_kind <> 7
        BEGIN
            INSERT
               INTO tbl_Values ([id], parent_key_id, name, kind, value)
               VALUES (@value_id, @key_id, @value_name, @value_kind, @value)
        END
    ELSE
        BEGIN
           DECLARE @len INTEGER
           SET @len = LEN(@value)
            INSERT
               INTO tbl_Values ([id], parent_key_id, name, kind, value, bigText, size)
               VALUES (@value_id, @key_id, @value_name, @value_kind, '', @value, @len)
        END
  END






GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

