unit topinfobar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,RDOInterfaces, Forms,
  Dialogs,VisualControls, StdCtrls, Buttons, ExtCtrls, MarqueeCtrl,RDOObjectProxy,WinSockRDOConnection,DateUtils,
  FramedButton,VoyagerInterfaces, VoyagerServerInterfaces,display,displaycontrol,config,
  voyagerevents,clientmls;

type
  Ttib = class(TForm)    //      TVisualControl
    Marquee1: TMarquee;
    Panel1: TPanel;
    Timer1: TTimer;
    Timer2: TTimer;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Notebook1: TNotebook;
    Panel4: TPanel;
    FramedButton1: TFramedButton;
    Label1: TLabel;
    FramedButton2: TFramedButton;
    FramedButton3: TFramedButton;
    FramedButton4: TFramedButton;
    FramedButton5: TFramedButton;
    FramedButton6: TFramedButton;
    FramedButton7: TFramedButton;
    FramedButton8: TFramedButton;
    FramedButton9: TFramedButton;
    FramedButton10: TFramedButton;
    FramedButton11: TFramedButton;
    FramedButton12: TFramedButton;
    FramedButton13: TFramedButton;
    FramedButton14: TFramedButton;
    FramedButton15: TFramedButton;
    FramedButton16: TFramedButton;
    FramedButton17: TFramedButton;
    FramedButton18: TFramedButton;
    FramedButton19: TFramedButton;
    FramedButton20: TFramedButton;
    FramedButton21: TFramedButton;
    FramedButton22: TFramedButton;
    FramedButton23: TFramedButton;
    FramedButton24: TFramedButton;
    FramedButton25: TFramedButton;
    FramedButton26: TFramedButton;
    FramedButton27: TFramedButton;
    FramedButton28: TFramedButton;
    FramedButton29: TFramedButton;
    FramedButton30: TFramedButton;
    Panel5: TPanel;
    FramedButton31: TFramedButton;
    FramedButton32: TFramedButton;
    FramedButton33: TFramedButton;
    FramedButton34: TFramedButton;
    Panel6: TPanel;
    FramedButton35: TFramedButton;
    cbRes: TComboBox;
    cbFreq: TComboBox;
    btApply: TFramedButton;
    cbLangList: TComboBox;
    btnSetLang: TFramedButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FramedButton1Click(Sender: TObject);
    procedure FramedButton2Click(Sender: TObject);
    procedure FramedButton3Click(Sender: TObject);
    procedure FramedButton4Click(Sender: TObject);
    procedure FramedButton5Click(Sender: TObject);
    procedure FramedButton6Click(Sender: TObject);
    procedure FramedButton7Click(Sender: TObject);
    procedure FramedButton8Click(Sender: TObject);
    procedure FramedButton9Click(Sender: TObject);
    procedure FramedButton10Click(Sender: TObject);
    procedure FramedButton11Click(Sender: TObject);
    procedure FramedButton12Click(Sender: TObject);
    procedure FramedButton13Click(Sender: TObject);
    procedure FramedButton14Click(Sender: TObject);
    procedure FramedButton15Click(Sender: TObject);
    procedure FramedButton16Click(Sender: TObject);
    procedure FramedButton17Click(Sender: TObject);
    procedure FramedButton18Click(Sender: TObject);
    procedure FramedButton19Click(Sender: TObject);
    procedure FramedButton20Click(Sender: TObject);
    procedure FramedButton21Click(Sender: TObject);
    procedure FramedButton22Click(Sender: TObject);
    procedure FramedButton23Click(Sender: TObject);
    procedure FramedButton24Click(Sender: TObject);
    procedure FramedButton25Click(Sender: TObject);
    procedure FramedButton26Click(Sender: TObject);
    procedure FramedButton28Click(Sender: TObject);
    procedure FramedButton29Click(Sender: TObject);
    procedure FramedButton30Click(Sender: TObject);
    procedure FramedButton33Click(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure cbResChange(Sender: TObject);
    procedure btnSetLangClick(Sender: TObject);
  private
    { Private declarations }
    fClientView       : IClientView;
    fMasterURLHandler : IMasterURLHandler;
    fConfigHolder     : IConfigHolder;
    fLangList         : TStringList;
  public
    { Public declarations }
    ccur:extended;
    clast:extended;
    cfunc:integer;
    cclearcur:boolean;
  private
        procedure SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
      public
        property ClientView       : IClientView       read fClientView write fClientView;
        property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
    function docalc:integer;
  end;

var
  tib: Ttib;
  DateTime : TDateTime;
  dsupdate:integer;
  dsnews: string;
  dsver,cliver: string;
  tbshow:integer;
const
  DSTimeout = 20000;

implementation

{$R *.dfm}

procedure Ttib.BitBtn2Click(Sender: TObject);
begin
notebook1.ActivePage:= 'calc';
panel3.Visible := true;
tib.Height:=100 + tbshow;
end;

procedure Ttib.btApplyClick(Sender: TObject);
var
    i : integer;
    s : string;
    result: integer;
    Sel, Bi: integer;
  begin
  {$ifDef NotChangeDisplay}
    Sel := -1;
    Bi := 0;
    for I := 0 to DisplayManager.SupportedModeCount-1 do
      begin
        with DisplayManager.DispMode[i] do
          if (inttostr(DisplayFrequency)=cbFreq.Text)
            then
              begin
                s := inttostr(PelsWidth)+'x'+inttostr(PelsHeight);
                if (s=cbRes.Text) and (Bi<BitsPerPel)
                  then
                    begin
                      Sel := i;
                      Bi := BitsPerPel;
                    end;
              end;
      end;
    if sel>=0
      then
        begin
          DisplayControl.SetMode(Sel);
          fMasterURLHandler.HandleEvent(evnRedrawWindows, sel);
          fConfigHolder.WriteInteger(true, '', 'Display', sel);
        end;
   {$endif}
   end;

  procedure Ttib.btnSetLangClick(Sender: TObject);
var
      langid : string;
    begin
      langid := fLangList.Values[cbLangList.Text];
      fClientView.SetLanguage( langid );
      ClientMLS.SetLanguage( langid );
    end;

procedure Ttib.cbResChange(Sender: TObject);
  var
    i : integer;
    s : string;
  begin
    cbFreq.Items.Clear;
    for I := 0 to DisplayManager.SupportedModeCount-1 do
      begin
        with DisplayManager.DispMode[i] do
          begin
            s := inttostr(PelsWidth)+'x'+inttostr(PelsHeight);
            if (DisplayFrequency>30) and (s=cbRes.Text)
               then
                 begin
                   s := inttostr(DisplayFrequency);
                    with cbFreq.Items do
                      if (IndexOf(s)<0)
                        then Add(s);
                 end;
          end;
      end;
    if cbFreq.Items.Count>0
      then cbFreq.ItemIndex := 0;
  end;


procedure Ttib.FramedButton10Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 9;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton11Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10);
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton12Click(Sender: TObject);
var
  i:integer;
begin
  //do calc then show
  i:= docalc;
  label1.Caption:= floattostr(clast);
end;

procedure Ttib.FramedButton13Click(Sender: TObject);
var
  i:integer;
begin
  //do calc then show
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  i:= docalc;
  label1.Caption:= floattostr(clast);
  cfunc:=1;
end;

procedure Ttib.FramedButton14Click(Sender: TObject);
var
  i:integer;
begin
  //do calc then show
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  i:= docalc;
  label1.Caption:= floattostr(clast);
  cfunc:=2;
end;

procedure Ttib.FramedButton15Click(Sender: TObject);
var
  i:integer;
begin
  //do calc then show
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  i:= docalc;
  label1.Caption:= floattostr(clast);
  cfunc:=3;
end;

procedure Ttib.FramedButton16Click(Sender: TObject);
var
  i:integer;
begin
  //do calc then show
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  i:= docalc;
  label1.Caption:= floattostr(clast);
  cfunc:=4;
end;

procedure Ttib.FramedButton17Click(Sender: TObject);
begin
  //clear
  ccur:=0;
  clast:=0;
  cfunc:=0;
  label1.Caption:='0';
end;

procedure Ttib.FramedButton18Click(Sender: TObject);
begin
  // /hr to /d
  if cclearcur then
    begin   //clast
      clast:= clast * 24;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur * 24;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton19Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast * 24 * 30;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur * 24 * 30;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton1Click(Sender: TObject);
begin
panel3.Visible:=false;
tib.Height:=tbshow ;
end;

procedure Ttib.FramedButton20Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast * 24 * 365;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur * 24 * 365;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton21Click(Sender: TObject);
begin
   if cclearcur then
    begin   //clast
      clast:= clast / 24 ;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur / 24 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton22Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast * 30 ;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur * 30 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton23Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast * 365;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur * 365;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton24Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast / 30 /24;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur / 30 /24 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton25Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast / 30 ;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur / 30 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton26Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast * 12 ;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur * 12 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton28Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast /365 /24 ;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur /365 /24 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton29Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast / 365 ;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur / 365 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton2Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 1;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton30Click(Sender: TObject);
begin
  if cclearcur then
    begin   //clast
      clast:= clast / 30 ;
      label1.Caption:= floattostr(clast);
    end
  else
    begin   //ccur
      ccur:= ccur / 30 ;
      label1.Caption:= floattostr(ccur);
    end;
end;

procedure Ttib.FramedButton33Click(Sender: TObject);
var
  i,j, selected : integer;
  s: string;
begin
  //options tab
  notebook1.ActivePage:= 'options';
  panel3.Visible := true;
  tib.Height:=60 + tbshow;
  //get lang
  selected:=0;
  for i := 0 to pred(fLangList.count) do
        begin
          cbLangList.Items.Add( fLangList.Names[i] );
          if fLangList.Values[fLangList.Names[i]] = ActiveLanguage
            then selected := i;
        end;
      cbLangList.ItemIndex := selected;
  //get display
  CreateDisplay( true );
  //      Display.DisplayManager.GetCurrentModeIndex(OriginalMode);
      j := GetPreferredDispInfoIndex;
      for I := 0 to DisplayManager.SupportedModeCount-1 do
        begin
          with DisplayManager.DispMode[i]  do
            begin
              s := inttostr(PelsWidth)+'x'+inttostr(PelsHeight);
              with cbRes.Items do
                if (IndexOf(s)<0) and (PelsWidth>=800) and (BitsPerPel>=16)
                  then Add(s);
              if i=j
                then
                  begin
                    cbRes.ItemIndex := cbRes.Items.Count -1;
                    cbResChange(nil);
                  end;
            end;
        end;
end;

procedure Ttib.FramedButton3Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 2;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton4Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 3;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton5Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 4;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton6Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 5;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton7Click(Sender: TObject);
begin
  ccur:= (ccur * 10) + 6;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton8Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 7;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.FramedButton9Click(Sender: TObject);
begin
  if cclearcur then
    begin
      cclearcur:=false;
      ccur:=0;
    end;
  ccur:= (ccur * 10) + 8;
  label1.Caption:= floattostr(ccur);
end;

procedure Ttib.Image1Click(Sender: TObject);
begin
// show bar
panel1.Visible:= true;
panel2.Visible:= false;
tbshow:=20;
tib.Height:=tib.Height + 13;
panel1.Align:= altop;
panel2.Align:=albottom;
end;

procedure Ttib.Timer1Timer(Sender: TObject);
var
      DSCnx     : IRDOConnectionInit;
      DSProxy   : OleVariant;
      session   : integer;
      thefile :  textfile;
begin

if ((dsupdate>30) or (dsupdate=0))then
  begin
   dsupdate:=0;
   try
        DSCnx        := TWinSockRDOConnection.Create('Directory Server');
        DSCnx.Server := 'starpeacelive.com';
        DSCnx.Port   := 1111;
        DSProxy      := TRDOObjectProxy.Create as IDispatch;
        try
          if DSCnx.Connect( DSTimeOut )
            then
              begin
                DSProxy.SetConnection( DSCnx );
                DSProxy.BindTo( 'DirectoryServer' );
                DSProxy.TimeOut := 20000;
                DSProxy.WaitForAnswer := true;
                session  := DSProxy.RDOOpenSession;
                if session <> 0
                  then
                    begin
                      try
                        DSProxy.BindTo( session );
                         DSProxy.RDOCurrentKey := 'root/mediainfo/english';
                         DSProxy.WaitForAnswer := true;
                         dsnews:= DSProxy.RDOReadString( 'clientnews' );
                         dsver:= DSProxy.RDOReadString( 'clientver' );
                         AssignFile(thefile, ExtractFilePath( paramstr(0) ) + 'version.txt');
                         reset(thefile);
                         readln(thefile,cliver);
                         CloseFile(thefile);
                         if dsver <> cliver then
                          begin
                          dsnews:= 'WARNING: THE CLIENT IS NOT UP TO DATE, PLEASE PATCH THE CLIENT     ' + dsnews;
                          MARQUEE1.ForeColor:=clred;
                          end;
                       except
                         dsnews:='Could not get information from server';
                       end;
                    end
                    else dsnews:='Could not get information from server';
               DSProxy.RDOEndSession;
              end
              else dsnews:='Could not get information from server';
        except
        dsnews:='Could not get information from server';
        end;
   except
   dsnews:='test of the system, adding time online and news later on       ' ;
   end;
   {update news  info}
  end;
dsupdate:=dsupdate + 1;
marquee1.Caption:= dsnews + '        client version ' + dsver + '    ' + inttostr(MinutesBetween(now , DateTime)) + ' minutes online';
marquee1.Hint:=marquee1.Caption;
//marquee1.
end;

procedure Ttib.Timer2Timer(Sender: TObject);
begin
marquee1.Tick;
end;

procedure Ttib.BitBtn1Click(Sender: TObject);
begin
  panel1.Visible:=false;
  panel2.Visible:=true;
  tbshow:=7;
  tib.Height:=tib.Height - 13;
end;

function Ttib.docalc:integer;
  begin
    //do calculations
    case cfunc of
      0:
        begin
          clast:= ccur;
        end;
      1:   //plus
        begin
          clast:= clast + ccur;
        end;
      2:  //minus
        begin
          clast:= clast - ccur;
        end;
      3:  //time
        begin
          clast:= clast * ccur;
        end;
      4:  //divide
        begin
          if ccur <> 0 then
            begin
               clast:= clast / ccur;
            end;          
        end;
    end;
    cclearcur:=true;

  end;

procedure Ttib.SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
    var
      CachePath : string;
    begin
      fMasterURLHandler := aMasterURLHandler;
      fMasterURLHandler.HandleEvent( evnAnswerConfigHolder, fConfigHolder );
      fMasterURLHandler.HandleEvent( evnAnswerPrivateCache, CachePath );
      fLangList := TStringList.Create;
      try
        fLangList.LoadFromFile( 'cache\lang.dat' );
      except
      end;
    end;

end.
