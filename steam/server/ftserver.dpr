program ftserver;

uses
  Forms,
  ftservermain in 'ftservermain.pas' {Form2},
  engine in 'engine.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
