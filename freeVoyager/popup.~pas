unit popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, FramedButton, ExtCtrls;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    popupc: TTimer;
    pupupclose: TFramedButton;
    procedure popupcTimer(Sender: TObject);
    procedure pupupcloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.popupcTimer(Sender: TObject);
begin
pupupclose.Visible:=true;
popupc.Enabled:=false;
end;

procedure TForm1.pupupcloseClick(Sender: TObject);
begin
form1.Visible:=false;
end;

end.
