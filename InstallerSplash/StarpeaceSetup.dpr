program StarpeaceSetup;

uses
  Forms,
  frmSplash in 'frmSplash.pas' {SPSplash},
  DirectDraw in '..\DirectX Sources\DirectDraw.pas',
  DXCommon in '..\DirectX Sources\DXCommon.pas',
  DirectInput in '..\DirectX Sources\DirectInput.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSPSplash, SPSplash);
  Application.Run;
end.
