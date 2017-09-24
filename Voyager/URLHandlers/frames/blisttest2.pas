unit blisttest2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, jpeg, ExtCtrls, FramedButton, GIFImg, StdCtrls,VisualControls,logs,
   VoyagerInterfaces;

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
    bname: TFramedButton;
    disc: TLabel;
    procedure bnameClick(Sender: TObject);
    procedure FramedButton2Click(Sender: TObject);
    procedure FramedButton1Click(Sender: TObject);
  private
    fMasterURLHandler : IMasterURLHandler;
    procedure SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
    { Private declarations }
  public
    { Public declarations }
    id:string;
    vid:string;
    property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
    function clickit: integer;
  published
  end;

  var
  Frame1: Tframe1;

implementation


{$R *.dfm}
function TFrame1.clickit: integer;
  begin
    //bname.click;
  end;

procedure TFrame1.bnameClick(Sender: TObject);
var
  x:integer;
begin
  if panel3.Visible then
    begin
      Panel3.Visible:=false;
      panel1.height:= 20;
      //x:=220;
      //if panel4.Visible = false then x:= x - 92;
      //Frame1.Parent.Height:=Frame1.Parent.Height -x;
    end
    else
      begin
        panel3.Visible:=true;
        panel1.height:=240;
        //x:=220;
        if panel4.Visible = false then
          begin
           panel1.height:= panel1.height - 92;
           //x:=x -92;
          end;
       // Frame1.Parent.Height:=Frame1.Parent.Height + x;

      end;
   {frame1.Parent.Parent.Visible:=false;
   frame1.Parent.Parent.Realign;
   frame1.Parent.Parent.Align:=altop;
   frame1.Parent.Parent.Align:=alclient;
   frame1.Parent.Parent.Visible:=true; }
end;

procedure TFrame1.FramedButton1Click(Sender: TObject);
var
    url: string;
  begin                                                             //  buildfaclist.Values['id' + inttostr(bselect)]     buildfaclist.Values['tvc' + inttostr(bselect)]
    //build road
    url:= '?frame_Id=MapIsoView&frame_Action=Build&FacilityClass=' + id + '&VisualClassId=' + vid;
    //logs.Log('buildmenu','build fac' + url);
    fMasterURLHandler.HandleURL(url);
  end;

procedure TFrame1.FramedButton2Click(Sender: TObject);
begin
  if panel4.Visible then
    begin
      Panel4.Visible:=false;
      panel1.height:= panel1.height - 92
    end
    else
      begin
        panel4.Visible:=true;
        panel1.height:= panel1.height + 92 
      end;
end;

procedure TFrame1.SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
    var
      CachePath : string;
    begin
      fMasterURLHandler := aMasterURLHandler;
      //fMasterURLHandler.HandleEvent( evnAnswerConfigHolder, fConfigHolder );
     // fMasterURLHandler.HandleEvent( evnAnswerPrivateCache, CachePath );
     // fLangList := TStringList.Create;
     // try
     //   fLangList.LoadFromFile( CachePath + 'lang.dat' );
     // except
     // end;
    end;

end.



