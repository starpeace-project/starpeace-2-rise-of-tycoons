program LandMapGenerator;

uses
  Forms,
  LandGenWindow in 'LandGenWindow.pas' {LandGenWin},
  newLand in 'newLand.pas',
  LandGenerator in 'LandGenerator.pas',
  LandInfo in 'LandInfo.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TLandGenWin, LandGenWin);
  Application.Run;
end.
