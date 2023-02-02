declare @key_path varchar(1024)

declare cur cursor for
select  entry from tbl_Imported where kind = 0 order by entry

open cur
fetch next from cur into @key_path
 
while @@FETCH_STATUS = 0
  begin
    exec proc_InsertKey @key_path
    fetch next from cur into @key_path
  end

close cur
deallocate cur

