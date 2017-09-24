unit fvlaunch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, FramedButton,HTTPGet, StdCtrls, jpeg, ExtCtrls;

type
  TForm3 = class(TForm)
    FramedButton8: TFramedButton;
    FramedButton1: TFramedButton;
    HTTPGet1: THTTPGet;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FramedButton8Click(Sender: TObject);
    procedure FramedButton1Click(Sender: TObject);
    procedure HTTPGet1DoneFile(Sender: TObject; FileName: string;
      FileSize: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  gf:integer;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
var
  t1:textfile;
  t2:string;
begin
  label1.Caption:= 'Please wait while we check if an update is available';
  AssignFile(t1, ExtractFilePath( paramstr(0) ) + 'update.txt');
        reset(t1);
        readln(t1,t2);
        CloseFile(t1);
  HTTPGet1.URL:=t2 + 'version.txt';
  httpget1.FileName:= 'v1.txt';
  gf:=1;
  httpget1.GetFile;
end;

procedure TForm3.FramedButton1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'FIVEVoyager2.exe', nil, nil, SW_SHOWNORMAL) ;
Close;
end;

procedure TForm3.FramedButton8Click(Sender: TObject);
begin
close;
end;

procedure TForm3.HTTPGet1DoneFile(Sender: TObject; FileName: string;
  FileSize: Integer);
var
  t1:textfile;
  t2,t3:string;
begin
  // check
          AssignFile(t1, ExtractFilePath( paramstr(0) ) + 'version.txt');
        reset(t1);
        readln(t1,t2);
        CloseFile(t1);
        AssignFile(t1, ExtractFilePath( paramstr(0) ) + 'v1.txt');
        reset(t1);
        readln(t1,t3);
        CloseFile(t1);
        deletefile('v1.txt');
        if t2 = t3 then
          begin
             label1.Caption:= 'Game up to date - Launching client';
             ShellExecute(Handle, 'open', 'FIVEVoyager2.exe', nil, nil, SW_SHOWNORMAL) ;
             close;
          end
        else
          begin
             gf:=2;
             label1.Caption:= 'Update available - Launching updater';
             ShellExecute(Handle, 'open', 'Voyager.exe', nil, nil, SW_SHOWNORMAL) ;
             close;
          end;

end;

end.
