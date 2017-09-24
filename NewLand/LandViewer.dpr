program LandViewer;

uses
  Forms,
  MapViewerWindow in 'MapViewerWindow.pas' {LandViewerWin},
  newLand in 'newLand.pas',
  LandGenerator in 'LandGenerator.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TLandViewerWin, LandViewerWin);
  Application.Run;
end.
