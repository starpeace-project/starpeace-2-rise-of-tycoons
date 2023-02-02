-- Todos los valores deben estar dentro de Root pues si no explota

declare
  @key_path   VARCHAR (1024),
  @value_name VARCHAR  (128),
  @value_kind TINYINT       ,
  @value      varchar  (128)

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
    if @value <> NULL	
    	exec proc_WriteValue @key_path, @value_name, @value_kind, @value, 0
    fetch next from cur into @key_path, @value_name, @value_kind, @value
  end
 
close cur
deallocate cur
