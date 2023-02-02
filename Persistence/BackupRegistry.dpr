library BackupRegistry;

uses
  ShareMem,
  SysUtils,
  Classes,
  BackupAgentRegistry in 'BackupAgentRegistry.pas',
  MapStringToObject in '..\Utils\Misc\MapStringToObject.pas',
  DataRegistry in '..\Utils\Misc\DataRegistry.pas';

exports
  RegisterBackupAgent,
  GetClassAgent;

begin                  
  IsMultiThread := true;    
end.
