program ExplorerPrj;

uses
  Forms,
  Explorer in 'Explorer.pas' {SQLExplorer},
  Configuration in 'Configuration.pas' {ConfigurationFrm},
  EditKeyFrm in 'EditKeyFrm.pas' {Form1},
  NewKeyFrm in 'NewKeyFrm.pas' {NewKeyForm},
  EditValueFrm in 'EditValueFrm.pas' {editValueForm},
  TypInfo in '..\Utils\VCL\TypInfo.pas',
  DirectoryRegistry in 'DirectoryRegistry.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TSQLExplorer, SQLExplorer);
  Application.CreateForm(TConfigurationFrm, ConfigurationFrm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TNewKeyForm, NewKeyForm);
  Application.CreateForm(TeditValueForm, editValueForm);
  Application.Run;
end.
