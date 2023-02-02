/* Microsoft SQL Server - Scripting	*/
/* Server: (LOCAL)			*/
/* Database: FiveDS			*/
/* Creation Date 3/19/2001 1:16 PM  	*/



/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* Keys Table 													   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE TABLE tbl_Keys
(
	id			UNIQUEIDENTIFIER	NOT NULL PRIMARY KEY NONCLUSTERED,
	parent_key		UNIQUEIDENTIFIER	NOT NULL,
	rel_name		VARCHAR(128)		NOT NULL,
	is_secured		BIT			NOT NULL DEFAULT (1)
)
GO

CREATE INDEX Key_parentkey ON tbl_keys (parent_key)
CREATE INDEX Key_relname   ON tbl_keys (rel_name)
GO


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* KeyPaths Table  												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE TABLE tbl_KeyPaths
(
	key_id			UNIQUEIDENTIFIER	NOT NULL  PRIMARY KEY NONCLUSTERED,
	full_path		VARCHAR	(900)		NOT NULL  UNIQUE  CLUSTERED,
	depth			SMALLINT		NOT NULL  DEFAULT (0),

	CONSTRAINT FK_key_keyPaths FOREIGN KEY (key_id) REFERENCES tbl_Keys(id)
)
GO


/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/* Values Table 												   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE TABLE tbl_Values
(
	id			UNIQUEIDENTIFIER	NOT NULL PRIMARY KEY NONCLUSTERED,
	parent_key_id		UNIQUEIDENTIFIER	NOT NULL,
	name			VARCHAR (128)		NOT NULL,
	Kind			TINYINT			NOT NULL,
	Value			VARCHAR (7801)		NOT NULL,
	bigText			TEXT			NULL,
	size			INT			NOT NULL DEFAULT (0),
	is_Secured		BIT			NOT NULL DEFAULT (1), 
	
	CONSTRAINT FK_Values_Keys FOREIGN KEY (parent_key_id) REFERENCES tbl_Keys(id)
)
GO


CREATE INDEX value_parentkeyid ON tbl_values (parent_key_id)
CREATE INDEX value_name        ON tbl_values (name)
CREATE INDEX value_kind        ON tbl_values (kind)
GO



/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */
/*  Keys and Ancestors table   											   */
/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE TABLE tbl_KeyAncestors
(
	key_id			UNIQUEIDENTIFIER	NOT NULL,
	ancestor_key		UNIQUEIDENTIFIER	NOT NULL, 
	
	CONSTRAINT IX_tbl_KeyAncestors PRIMARY KEY ( key_id, ancestor_key ),

	CONSTRAINT FK_KeyAncestors_KeyID FOREIGN KEY       (key_id) REFERENCES tbl_Keys(id),
	CONSTRAINT FK_KeyAncestors_AncID FOREIGN KEY (ancestor_key) REFERENCES tbl_Keys(id)
) 
GO
