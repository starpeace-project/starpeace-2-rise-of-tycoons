unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure WebBrowser1NavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  a1: textfile;
  b1,b2: string;
begin
  //do task
  //load webpage to show
  b2:= ParamStr(1);
  if b2 = '' then
    begin
      b2:= ParamStr(0);
      b2 := StringReplace(b2,'sheduleit.exe','',[rfReplaceAll, rfIgnoreCase]);
    end;
  AssignFile(a1, b2 + 'sheduleit.txt');
  Reset(a1);
  ReadLn(a1, b1);
  CloseFile(a1);
  webbrowser1.Navigate(b1);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  close;
end;

procedure TForm1.WebBrowser1NavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
   //done
end;

end.
