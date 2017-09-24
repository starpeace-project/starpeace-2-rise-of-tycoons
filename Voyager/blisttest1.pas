unit blisttest1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, buildlist, StdCtrls, ExtCtrls,blisttest2,flatsb, commctrl;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Button2: TButton;
    Frame11: TFrame1;
    ScrollBox1: TScrollBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  

  private
    { Private declarations }
  public
    { Public declarations }
    m1: tframe1;
    f: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  //test create
  //frame11.Name:='t1';
  //m1.Name:='t2';
  m1:= tframe1.Create(panel1);
  m1.Parent := panel1;
  m1.Align:=altop;
  m1.Name:='fff' + inttostr(f);
  f := f+1;
  panel1.Refresh;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  frame11.panel3.Visible:=false;
  frame11.panel4.Visible:=false;
  frame11.Height:=20;

end;



procedure TForm1.FormShow(Sender: TObject);
begin
 InitializeFlatSB (scrollbox1.Handle);
  FlatSB_SetScrollProp(scrollbox1.Handle,WSB_PROP_HSTYLE or WSB_PROP_VSTYLE, FSB_FLAT_MODE,True);
  FlatSB_SetScrollProp(scrollbox1.Handle,WSB_PROP_HBKGCOLOR, ColorToRGB(clRed), True);
  FlatSB_SetScrollProp(scrollbox1.Handle,WSB_PROP_VBKGCOLOR, ColorToRGB(clBlue), True);
end;

end.
