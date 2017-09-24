program Project1;

uses
  Forms,
  blisttest1 in 'blisttest1.pas' {Form1},
  blisttest2 in 'blisttest2.pas' {Frame1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
