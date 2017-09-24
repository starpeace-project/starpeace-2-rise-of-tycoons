program football;

uses
  Forms,
  footballmain in 'footballmain.pas' {Form1},
  ftconnection in 'ftconnection.pas',
  stm1 in 'stm1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
