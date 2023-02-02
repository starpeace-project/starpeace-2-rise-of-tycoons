________________
Insert KEYS
________________

declare @key_name        VARCHAR(128)
declare @parent_key_name VARCHAR(128)

declare cur cursor for
select
  [key_name] = RIGHT(Entry, CHARINDEX('/', REVERSE(Entry))-1),
  [parent_key_name] = LEFT(Entry, LEN(Entry) - CHARINDEX('/', REVERSE(Entry)))
from 
  tbl_Imported
where
  Kind = 0
order by [parent_key_name]

open cur
fetch next from cur into @key_name, @parent_key_name

while @@FETCH_STATUS = 0
  begin
    print '-> ' + @parent_key_name + '/' + @key_name + '.'
    exec proc_InsertKey @key_name, @parent_key_name
    fetch next from cur into @key_name, @parent_key_name
  end

close cur
deallocate cur

_________________________
INSERT VALUES
_________________________
 
declare @value_name varchar(128)
declare @k tinyint
declare @pID uniqueidentifier

declare cur cursor for
select
  [value_name] = RIGHT(Entry, CHARINDEX('/', REVERSE(Entry))-1),
  [pID] = t1.key_id,
  [k]   = t2.Kind
from 
  tbl_KeyPaths AS t1,
  tbl_Imported AS t2 
where
  Kind <> 0 and ( t1.full_path + '/' + RIGHT(Entry, CHARINDEX('/', REVERSE(Entry))-1) = t2.Entry)
order by pID

open cur
fetch next from cur into @value_name, @pID, @k

while @@FETCH_STATUS = 0
  begin
    INSERT INTO tbl_Values(parent_key_id, rel_name, Kind, theValue) VALUES( @pID, @value_name, @k, '0')
    fetch next from cur into @value_name, @pID, @k
  end

close cur
deallocate cur

_________________________
PARSER VALUES
_________________________

/*
declare @key_path varchar(1024)

declare cur cursor for
select  entry from tbl_Imported where kind = 0 order by entry

open cur
fetch next from cur into @key_path
 
while @@FETCH_STATUS = 0
  begin
    print @key_path
    exec proc_InsertKey @key_path
    fetch next from cur into @key_path
  end

close cur
deallocate cur
*/

declare
  @key_path   VARCHAR (1024),
  @value_name VARCHAR  (128),
  @value_kind TINYINT       ,
  @value      varchar (8000)
 
declare cur cursor for
select 
  LEFT  (Entry, LEN(Entry)- CHARINDEX('/', REVERSE(Entry))),
  RIGHT (Entry, CHARINDEX('/', REVERSE(Entry))-1),
  kind, value
from tbl_Imported
where Kind <> 0
order by Entry
 
open cur
fetch next from cur into @key_path, @value_name, @value_kind, @value
 
while @@FETCH_STATUS = 0
  begin
    exec proc_InsertValue @key_path, @value_name, @value_kind, @value
    fetch next from cur into @key_path, @value_name, @value_kind, @value
  end
 
close cur
deallocate cur

_________________________
TEST
_________________________

--select * from tbl_Values where size = 8000
--select * from tbl_Keys order by rel_name
--select * from tbl_KeyPaths where full_path = 'root/root' order by full_path
--select * from tbl_KeyAncestors
--select Entry from tbl_Imported

--exec proc_DeleteKey 'zorro1zorro'

--delete from tbl_Values

/*
select 
  rel_name, full_path
from 
  tbl_KeyAncestors  a,
  tbl_Keys          k,
  tbl_KeyPaths	    p
where 
  a.key_id = k.id and
  p.key_id = k.id

*/

/*
DECLARE @key_id    UNIQUEIDENTIFIER
DECLARE @full_path VARCHAR(900)

SELECT @key_id = NEWID()
SELECT @full_path = 'root'

INSERT INTO tbl_Keys     VALUES (@key_id, @key_id, @full_path, 0)
INSERT INTO tbl_KeyPaths VALUES (@key_id, @full_path, 0)
*/














