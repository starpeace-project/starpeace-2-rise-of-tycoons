unit footballmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ftconnection, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    splash: TPanel;
    logon: TPanel;
    uname: TEdit;
    password: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    logonbut: TButton;
    logonerror: TLabel;
    mainpanel: TPanel;
    newuser: TPanel;
    newusererror: TLabel;
    newusername: TEdit;
    newuserpass: TEdit;
    newuseremail: TEdit;
    newusercountry: TComboBox;
    newusersubmit: TButton;
    newuserpanel: TButton;
    newusercancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure logonbutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure newusersubmitClick(Sender: TObject);
    procedure newuserpanelClick(Sender: TObject);
    procedure newusercancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fconn : Tftconnection;
    fconnection : olevariant;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   fconnection:= fconn.connect;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  x1:string;
begin
  x1:=fconnection.rdotest(1);
  label1.Caption:= x1;
end;

procedure TForm1.logonbutClick(Sender: TObject);
 var
  x1:integer;
  a1,a2:string;
begin
  a2:=password.Text;
  a1:=uname.Text;
  x1:=fconnection.RDOlogon(a1,a2);
  if x1 = -2 then logonerror.Caption:='Username not found';
  if x1 = -1 then logonerror.Caption:='Password and Username Incorrect';
  if x1 >= 0 then
    begin
      mainpanel.bringtofront;
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fconnection:= null;
end;

procedure TForm1.newusersubmitClick(Sender: TObject);
var
  x1:integer;
begin
  x1:=fconnection.RDOnewuser(newusername.text,newuserpass.text,newuseremail.text, newusercountry.ItemIndex);
  if x1 = 1 then
    begin
      logonerror.Caption := 'New user created';
      logon.BringToFront;
    end
  else newusererror.Caption:= 'Username already exists';

end;

procedure TForm1.newuserpanelClick(Sender: TObject);
var
  x1:tstrings;
begin
  x1.Text:=fconnection.RDOgetcountries;
  newusercountry.Clear;
  newusercountry.Items:=x1;
  newuser.BringToFront;
end;

procedure TForm1.newusercancelClick(Sender: TObject);
begin
  newuser.SendToBack;
end;

end.
