unit buildlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, FramedButton, GIFImg, StdCtrls,VisualControls,logs;

type
  Tblist = class(Tform)
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Panel3: TPanel;
    Image3: TImage;
    bi: TImage;
    zi: TImage;
    bcost: TLabel;
    FramedButton1: TFramedButton;
    FramedButton2: TFramedButton;
    bsize: TLabel;
    Panel4: TPanel;
    Label2: TLabel;
    Image4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  blist: Tblist;

implementation

{$R *.dfm}

procedure Tblist.FormCreate(Sender: TObject);
begin
  logs.Log('blist','formcreate');
  panel3.Visible:=false;
  panel4.Visible:=false;
end;

procedure Tblist.Label1Click(Sender: TObject);
begin
  if panel3.Visible then Panel3.Visible:=false else panel3.Visible:=true;
end;

end.
