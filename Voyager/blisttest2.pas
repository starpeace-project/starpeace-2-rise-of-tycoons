unit blisttest2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, jpeg, ExtCtrls, FramedButton, GIFImg, StdCtrls,VisualControls,logs;

type
  TFrame1 = class(TFrame)
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Panel3: TPanel;
    Image3: TImage;
    bi: TImage;
    zi: TImage;
    bcost: TLabel;
    FramedButton1: TFramedButton;
    FramedButton2: TFramedButton;
    bsize: TLabel;
    Panel4: TPanel;
    Image4: TImage;
    disc: TLabel;
    bname: TFramedButton;
    procedure bnameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  var
  Frame1: Tframe1;

implementation


{$R *.dfm}

procedure TFrame1.bnameClick(Sender: TObject);
begin
  if panel3.Visible then
    begin
      Panel3.Visible:=false;
      panel1.height:= 20;
    end
    else
      begin
        panel3.Visible:=true;
        panel1.height:=240;
      end;
end;

end.
