unit tycoonshow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StrUtils,logs,VisualControls, protocol,SHDocVw, ActiveX,
  VoyagerInterfaces, VoyagerServerInterfaces, OleCtrls, StdCtrls, GIFImg,
  ExtCtrls, FramedButton, Grids, ComCtrls, jpeg, ImgList, ValEdit, PDTabControl,
  loans,CoolSB,math, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP;

type
  Ttycoonshower = class(TVisualControl)
    Notebook1: TNotebook;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    currpf: TLabel;
    currap: TLabel;
    currtp: TLabel;
    currnob: TLabel;
    reset: TFramedButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    currimg1: TImage;
    currimg2: TImage;
    currinfo1: TLabel;
    currinfo2: TLabel;
    Label10: TLabel;
    currrequires: TLabel;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Label11: TLabel;
    FramedButton1: TFramedButton;
    FramedButton2: TFramedButton;
    FramedButton3: TFramedButton;
    Panel4: TPanel;
    Label12: TLabel;
    Panel5: TPanel;
    Image6: TImage;
    Label13: TLabel;
    companylist: TListView;
    FramedButton4: TFramedButton;
    companyimage: TImageList;
    Label16: TLabel;
    Panel6: TPanel;
    clusn: TPDTabControl;
    Panel7: TPanel;
    Image4: TImage;
    Label14: TLabel;
    fb2: TFramedButton;
    lab7: TValueListEditor;
    Panel8: TPanel;
    Image5: TImage;
    Panel9: TPanel;
    FramedButton5: TFramedButton;
    Label15: TLabel;
    comperror: TLabel;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Image1: TImage;
    Panel10: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    FramedButton6: TFramedButton;
    FramedButton7: TFramedButton;
    resetdone: TLabel;
    Panel11: TPanel;
    Label19: TLabel;
    cballab1: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Edit2: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    FramedButton8: TFramedButton;
    Label25: TLabel;
    Label26: TLabel;
    Panel12: TPanel;
    plbrowser: TWebBrowser;
    Panel13: TPanel;
    isbrowser: TWebBrowser;
    Panel14: TPanel;
    stratbrowser: TWebBrowser;
    Image2: TImage;
    WebBrowser1: TWebBrowser;
    ScrollBox1: TScrollBox;
    Image3: TImage;
    Image7: TImage;
    Image8: TImage;
    Panel15: TPanel;
    ScrollBox2: TScrollBox;
    Panel16: TPanel;
    ScrollBox3: TScrollBox;
    Panel17: TPanel;
    Label27: TLabel;
    Edit3: TEdit;
    Label28: TLabel;
    Edit4: TEdit;
    Label29: TLabel;
    FramedButton9: TFramedButton;
    Label30: TLabel;
    rimg1: TImage;
    rimg2: TImage;
    rimg3: TImage;
    ScrollBox4: TScrollBox;
    rl1: TLabel;
    rl2: TLabel;
    rl0: TLabel;
    rg: TStringGrid;
    rv0: TLabel;
    rv1: TLabel;
    rv2: TLabel;
    rtn: TLabel;
    IdHTTP1: TIdHTTP;
    procedure companylistClick(Sender: TObject);
    procedure FramedButton4Click(Sender: TObject);
    procedure clusnTabChange(Sender: TObject);
    procedure FramedButton5Click(Sender: TObject);
    procedure FramedButton1Click(Sender: TObject);
    procedure FramedButton2Click(Sender: TObject);
    procedure FramedButton3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FramedButton7Click(Sender: TObject);
    procedure FramedButton6Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure plbrowserBeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure FramedButton8Click(Sender: TObject);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image3Click(Sender: TObject);
    procedure FramedButton9Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    bloanp,plpanel: TPanel;
    companycount : integer;
    currentlevel : integer;
    blbud:int64;
    blbud2:int64;
    fcompname : array[0..100] of string;
    fcomprole : array[0..100] of string;
    fcompid : array[0..100] of integer;
    fcompcluster : array[0..100] of string;
  private
    { Private declarations }
    fClientView       : IClientView;
    fMasterURLHandler : IMasterURLHandler;
    currinfo,bankinfo,plinfo          : tstringlist;
    panelb1:TPanel;
    panelb2:TPanel;
  private
    procedure SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
  public
    { Public declarations }
    fCache            : string ;
    property ClientView       : IClientView       write fClientView;
    property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
    property Cache            : string            write fCache;
  published
    function ncompany: integer;
    function scurr: integer;
    function bankpage: integer;
    function plpage: integer;
    function ispage: integer;
    function stratpage: integer;
    function webpage: integer;
    function rank(rid:widestring): integer;
  protected
        procedure SetParent(which : TWinControl);  override;
  end;

var
  tycoonshower: Ttycoonshower;
const
  compl  : array  [0..4] of string = ('Dissident','PGI','Mariko','Moab','Magna');
  currimga: array  [0..6] of string = ('levelApprentice.gif','levelEntrepreneur.gif','levelTycoon.gif','levelMaster.gif','levelParadigm.gif','levelLegend.gif','levelLegendX.gif');
  currimgd: array  [0..6] of string = ('levelApprenticeDisabled.gif','levelEntrepreneurDisabled.gif','levelTycoonDisabled.gif','levelMasterDisabled.gif','levelParadigmDisabled.gif','levelLegendDisabled.gif','levelLegendXDisabled.gif');

implementation

{$R *.dfm}
procedure Ttycoonshower.CheckBox1Click(Sender: TObject);
var
  i:integer;
begin
  //temp
   CheckBox1.Caption:='Upgrade To Next Level - ' + booltostr(checkbox1.Checked);
   if checkbox1.Checked = true then i:= fClientView.Advancelevel(1) else i:= fClientView.Advancelevel(0);
end;

procedure Ttycoonshower.clusnTabChange(Sender: TObject);
begin
//clusn.CurrentTab:=0;
    label14.Caption:=lab7.Cells[1,clusn.CurrentTab+1];
    label14.Transparent := true;
    fb2.Text:=lab7.Cells[1,clusn.CurrentTab+1];
   { image2.Picture := nil;
    image2.Picture.Create;
    image2.Picture.Bitmap.Canvas.Font.Name := 'arial black';
    image2.Picture.Bitmap.Canvas.Font.Color := rgb(255,255,255);
    image2.Picture.Bitmap.Canvas.TextOut(5,5,lab7.Cells[1,clusn.CurrentTab+1]); }
    //clusi.GetBitmap(clusn.CurrentTab,image5.Picture.Bitmap);
    //load image from file
    image5.Picture.LoadFromFile(ExtractFilePath( paramstr(0) ) + 'Cache\OtherImages\' + compl[clusn.CurrentTab] + '-cp.jpg');
end;

procedure Ttycoonshower.companylistClick(Sender: TObject);
var
    url,x9: string;
    i: integer;
begin
   i:=companylist.ItemIndex;
  //logs.log('wlogin','click - '+ inttostr(i));

  //logs.log('wlogin','click3 - '+ fcompname[i]);
  url:= '?frame_Action=SetCompany&frame_Id=CnxHandler&cluster=' + fcompcluster[i] + '&listid=' + inttostr(i) + '&Name=' + fcompname[i] + '&OwnerRole=' + fcomprole[i] + '&Id=' + inttostr(fcompid[i]);
  //logs.log('wlogin','click2 - '  + '   ' + fcomprole[i]);
  fMasterURLHandler.HandleURL(url);
  x9:= '' ;
end;

procedure Ttycoonshower.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  // numbers only
  {case Key of
  '0'..'9'  : ;
   else
    Key:=#0;
  end;   }
  if (not (Key in ['0'..'9', #8])) then  Key := #0;
  //adjust figures
end;

procedure Ttycoonshower.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:int64;
begin
  if edit2.Text = '' then edit2.Text:='0';
  if strtoint64(edit2.Text)< 0 then  edit2.Text:='0';

  if strtoint64(edit2.Text) > blbud then edit2.Text:= inttostr(blbud);
  //logs.log('bank','2');
  i:= (strtoint64(edit2.Text) + blbud2) div 100000000;
  label25.Caption:= inttostr(i) + '%';
  i:= 200-i;
  if i<5 then i:=5;
  label26.Caption:= inttostr(i) + ' years';
  //logs.log('bank','3');
end;

procedure Ttycoonshower.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
   if (not (Key in ['0'..'9', #8])) then  Key := #0;
end;

procedure Ttycoonshower.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:int64;
begin
  if edit3.Text = '' then edit3.Text:='0';
  if strtoint64(edit3.Text)< 0 then  edit3.Text:='0';

end;

procedure Ttycoonshower.FramedButton1Click(Sender: TObject);
begin
  panel2.BringToFront;
end;

procedure Ttycoonshower.FramedButton2Click(Sender: TObject);
begin
 panel3.BringToFront;
end;

procedure Ttycoonshower.FramedButton3Click(Sender: TObject);
begin
 panel4.BringToFront;
end;

procedure Ttycoonshower.FramedButton4Click(Sender: TObject);
begin
clusn.CurrentTab:=0;
    label14.Caption:=lab7.Cells[1,0];
    label14.Transparent := true;
    image5.Picture.LoadFromFile(ExtractFilePath( paramstr(0) ) + 'Cache\OtherImages\' + compl[clusn.CurrentTab] + '-cp.jpg');
    //clusi.GetBitmap(0,image5.Picture.Bitmap);
    label14.Caption:=lab7.Cells[1,clusn.CurrentTab+1];
    Notebook1.ActivePage:='newcomp';
end;

procedure Ttycoonshower.FramedButton5Click(Sender: TObject);
var
  x2: string;
  ErrorCode : TErrorCode;
  p: pchar;
  url:string;
begin
  //check if name = '', then send new company command, if result =numerical then error else goto company
  if edit1.Text <> '' then
    begin
      //x2.Create('',0);
      x2:= fClientView.NewCompany2( edit1.Text, compl[clusn.CurrentTab],ErrorCode );
      //p:=pchar(string(x2));
      //logs.log('tshow', inttostr(errorcode) + ' - ' + compl[clusn.CurrentTab] + ' - ' + edit1.Text + ' -x2 ' + x2);
      if x2<> '' then
        begin
          //company created, goto company, kill proxy
          url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=comp&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
          //url:= '?frame_Action=SetCompany&frame_Id=CnxHandler&Name=' + edit1.Text +'&cluster=' + compl[clusn.CurrentTab] + '&listid=' + inttostr(companylist.Items.Count) + '&Id=' + inttostr(ErrorCode);
          //logs.log('tshow',url);
          fMasterURLHandler.HandleURL(url);
          end
      else
        begin
          //error, show error info
          comperror.Caption:= 'an error occured' + inttostr(ErrorCode) + ' - ' + clusn.TabNames.ValueFromIndex[clusn.CurrentTab];
        end;  
    end;
end;

procedure Ttycoonshower.FramedButton6Click(Sender: TObject);
var
  i:integer;
begin
  //reset account
  i:= fClientView.resetaccount;

  resetdone.Visible:=true;
end;

procedure Ttycoonshower.FramedButton7Click(Sender: TObject);
begin
   Notebook1.ActivePage:='curr';
end;

procedure Ttycoonshower.FramedButton8Click(Sender: TObject);
var
  i:int64;
  url:string;
begin
  //make loan
  //i:=strtoint();
  i:=fClientView.bankloanget(edit2.Text);
  url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=bank&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
end;

procedure Ttycoonshower.FramedButton9Click(Sender: TObject);
var
  i:integer;
begin
  //send money
  i:=fClientView.banksend(edit4.Text,edit3.Text);
  if i=24 then label30.Visible:=true else label30.Visible:=false;
  
end;

procedure Ttycoonshower.Image3Click(Sender: TObject);
var
  s1,s2,url:string;
begin
  //show chart
  s1:=timage(sender).name;
  s2:=StringReplace(s1,'chartim','',[rfReplaceAll, rfIgnoreCase]);
  url:='?frame_Id=AppHandler&frame_Action=ShowChart&ChartTitle=' + plinfo.Values['AccountName' + s2] + '&ChartInfo=' + plinfo.Values['AccountHistory' + s2];
      fMasterURLHandler.HandleURL(url);
end;

function Ttycoonshower.ncompany: integer;
  var
    i : integer;
    canplay: boolean;
  begin
      //logs.log('tshow','normal');
      companylist.Items.Clear;
      companylist.ViewStyle := vsIcon;
      //logs.log('tshow','clear');
      companycount := fClientView.GetCompanyCount;
      //logs.log('tshow','c count ' + inttostr(companycount));
      for i  := 0 to companycount - 1 do
        with companylist.Items.add do
          begin
            //logs.log('tshow','cadd' + fClientView.GetCompanyName2(i));
            caption := fClientView.GetCompanyName2(i);    //   efcompname   efcomprole  efcompid
            fcompname[i] :=fClientView.GetCompanyName2(i);
            fcomprole[i] :=fClientView.GetCompanyOwnerRole(i);
            fcompid[i]:=fClientView.GetCompanyId2(i);
            fcompcluster[i] := fClientView.GetCompanyCluster(i);
            case AnsiIndexText(fcompcluster[i],['pgi','dissidents','mariko','moab','magna']) of
               0:  ImageIndex:=0;
               1:  ImageIndex:=1;
               2:  ImageIndex:=2;
               3:  ImageIndex:=3;
               4:  ImageIndex:=4;
            else ImageIndex:=0;
            {  := efcompname;
             :=efcomprole;
             :=efcompid;}
            end;
          end;

      //logs.log('tshow','show');
      Notebook1.ActivePage:='comp';
      result:=1;
  end;

procedure Ttycoonshower.resetClick(Sender: TObject);
begin
 resetdone.Visible:=false;
 Notebook1.ActivePage:='reset';
end;

function Ttycoonshower.scurr: integer;
  var
    i,j,k,rcount,ccount:integer;
    x2:int64;
    x1:string;
    tlb1: tlabel;
  begin
    //show curriculum info
    currinfo := nil;
    //logs.Log('buildmenu','startkind - 1.2');
    currinfo := tstringlist.Create;
    currinfo.Text := fclientview.currinfo;
    //got info, now show
    x2:=round(strtofloat(currinfo.Values['ProfitAverage']));
    if x2>1000000 then x1:='$' + inttostr(x2 div 1000) + ' k/hr' else x1:= '$' + inttostr(x2) + ' /hr';
    currap.Caption:=x1;
    checkbox1.Checked:=strtobool(currinfo.Values['AdvanceToNextLevel']);
    x2:=round(strtofloat(currinfo.Values['Budget']));
    if x2>1000000000 then x1:= '$' + inttostr(x2 div 1000000) + ' Mil' else x1:= '$' + inttostr(x2);
    
    currpf.Caption:= x1;
    currtp.Caption:=  inttostr(round(strtofloat(currinfo.Values['Prestige'])));
    currnob.Caption:=  currinfo.Values['Nobility'];
    //levels info
    currentlevel := strtoint(currinfo.Values['CurrLevel']);
    if currentlevel < 6 then    //current and next level image
      begin
        currimg1.Picture.LoadFromFile('Cache\misc\' + currimga[currentlevel]);
        if currentlevel < 5 then
          begin
             currimg2.Picture.LoadFromFile('Cache\misc\' + currimgd[currentlevel + 1]);
          end
        else
          begin
             currimg2.Picture.LoadFromFile('Cache\misc\' + currimgd[6]);
          end;
      end
    else
      begin
        currimg1.Picture.LoadFromFile('Cache\misc\' + currimga[6]);
        currimg2.Picture.LoadFromFile('Cache\misc\' + currimgd[6]);
      end;
    label8.Caption := currinfo.Values['LevelName'];
    currinfo1.Caption:= currinfo.Values['LevelDesc'];
    label9.Caption:= currinfo.Values['NextLevelName'];
    currinfo2.Caption:= currinfo.Values['NextLevelDesc'];
    currrequires.Caption :=  currinfo.Values['NextLevelCond'];
    // rankings
    if assigned(panelb2) then             //.
              begin
                panelb2.Free;
                //panelb1.Destroy;
              end;
    panelb2:= tpanel.Create(scrollbox3);
    panelb2.Parent:=scrollbox3;
    panelb2.Top:=0;
    panelb2.Left:=0;
    //panelb1.Width:=209;
    panelb2.Align:=altop;
    panelb2.Color:=clblack;
    panelb2.AutoSize:= true;
    panelb2.BorderStyle:=bsnone;
    panelb2.BevelOuter:=bvnone;
    rcount:= strtoint(currinfo.Values['RankCount']);
    j:=0;
    k:=0;
    stringgrid1.ColWidths[0] := 140;
    stringgrid1.ColWidths[1] := 50;
    stringgrid1.ColWidths[2] := 140;
    stringgrid1.ColWidths[3] := 50;
    stringgrid1.ColWidths[4] := 140;
    stringgrid1.ColWidths[5] := 50;
    stringgrid1.ColWidths[6] := 140;
    stringgrid1.ColWidths[7] := 50;
    for i := 0 to rcount - 1 do
        begin
           stringgrid1.Cells[j,k] := currinfo.Values['RankName' + inttostr(i)];
           stringgrid1.Cells[j+1,k] := currinfo.Values['RankPos' + inttostr(i)];
           tlb1:=tlabel.Create(panelb2);
         tlb1.Parent:=panelb2;
         tlb1.Top:=5 + (k*20);
         tlb1.Left:=10 + (j*200);
         tlb1.Caption:= currinfo.Values['RankName' + inttostr(i)];
         tlb1.Font.Color:=$007DAC02;
          tlb1.Font.Size:=11;
          tlb1.Transparent:=true;
          tlb1.Name:='ranktopname1' + inttostr(i);
         //stringgrid2.Cells[1,i] := currinfo.Values['curPrestige' + inttostr(i)];
         tlb1:=tlabel.Create(panelb2);
         tlb1.Parent:=panelb2;
         tlb1.Top:=5 + (k*20);
         tlb1.Left:=175 + (j*200);
         tlb1.Caption:= currinfo.Values['RankPos' + inttostr(i)];
         tlb1.Font.Color:=$007DAC02;
          tlb1.Font.Size:=11;
          tlb1.Transparent:=true;
          tlb1.Name:='ranktopname2' + inttostr(i);

           j:= j+1;
           if j>2 then
            begin
              j:=0;
              k:=k+1;
            end;
        end;
    //curr
    if assigned(panelb1) then             //.
              begin
                panelb1.Free;
                //panelb1.Destroy;
              end;
    panelb1:= tpanel.Create(scrollbox2);
    panelb1.Parent:=scrollbox2;
    panelb1.Top:=0;
    panelb1.Left:=0;
    //panelb1.Width:=209;
    panelb1.Align:=altop;
    panelb1.Color:=clblack;
    panelb1.AutoSize:= true;
    panelb1.BorderStyle:=bsnone;
    panelb1.BevelOuter:=bvnone;
    j:=5;

    //stringgrid2.ColWidths[0] := 540;
    //stringgrid2.ColWidths[1] := 50;
    ccount:=strtoint(currinfo.Values['curritemcount']);
    for i := 0 to ccount - 1 do
      begin
         //stringgrid2.Cells[0,i] := currinfo.Values['curDesc' + inttostr(i)];
         tlb1:=tlabel.Create(panelb1);
         tlb1.Parent:=panelb1;
         tlb1.Top:=j;
         tlb1.Left:=10;
         tlb1.Caption:= currinfo.Values['curDesc' + inttostr(i)];
         tlb1.Font.Color:=$007DAC02;
          tlb1.Font.Size:=11;
          tlb1.Transparent:=true;
          tlb1.Name:='currtopname1' + inttostr(i);
         //stringgrid2.Cells[1,i] := currinfo.Values['curPrestige' + inttostr(i)];
         tlb1:=tlabel.Create(panelb1);
         tlb1.Parent:=panelb1;
         tlb1.Top:=j;
         tlb1.Left:=700;
         tlb1.Caption:= currinfo.Values['curPrestige' + inttostr(i)];
         tlb1.Font.Color:=$007DAC02;
          tlb1.Font.Size:=11;
          tlb1.Transparent:=true;
          tlb1.Name:='currtopname2' + inttostr(i);
          j:=j+20;
      end;




    //show page
    Notebook1.ActivePage:='curr';
    panel2.BringToFront;
    result:=1;
  end;

function Ttycoonshower.bankpage: integer;
  var
    i,top1:integer;
    url:string;
    m1:tframe2;
    x:int64;
  begin
    //set up bank page
    //show curriculum info
    //logs.log('bank','1');
    if assigned(bloanp) then  bloanp.Free;
    bloanp:= tpanel.Create(panel11);
    bloanp.Parent:=panel11;
    bloanp.Top:=220;
    bloanp.Left:=5;
    bloanp.Width:=590;
    bloanp.AutoSize:=true;
    bloanp.BorderStyle:=bsnone;
    bloanp.BevelInner:=bvnone;
    bloanp.BevelOuter:=bvnone;
    bloanp.BorderWidth:=0;
    //logs.log('bank','2');
    m1:= tframe2.Create(bloanp);
    m1.parent:=bloanp;
    m1.top:=0;
    m1.left:=0;
    m1.Align:=altop;
    m1.Panel1.Color:= $00496501;
    m1.bname.caption:= 'Bank Name';
    m1.bdate.caption:= 'Date';
    m1.bamount.caption := 'Amount';
    m1.brate.caption:='Rate';
    m1.bterm.caption:='Term';
    m1.bnext.caption:='Next';
    m1.bname.Font.Color:= clwhite;
    m1.bdate.Font.Color:= clwhite;
    m1.bamount.Font.Color:= clwhite;
    m1.brate.Font.Color:= clwhite;
    m1.bterm.Font.Color:= clwhite;
    m1.bnext.Font.Color:= clwhite;
    m1.brepay.visible:=false;
    m1.bid:=0;
    //logs.log('bank','3');
    m1.name:='loanlisttop';
    //next part
    bankinfo := nil;
    bankinfo := tstringlist.Create;
    //logs.log('bank','3-1');
    bankinfo.Text := fclientview.bankinfo;
    //logs.log('bank','3-2');
    blbud:= Trunc(strtofloat(bankinfo.Values['IFELLoanEstimated']));
    edit2.Text:=inttostr(blbud);
    blbud2:= Trunc(strtofloat(bankinfo.Values['LoanAmount']));
    //logs.log('bank','3-3');
    //label22.Caption:= bankinfo.Values['Budget'];
    CurrencyString := '';
    x:=Trunc(strtofloat(bankinfo.Values['Budget']));
              if x < 0 then
                begin             //Format('%.0m',[ + 0.0]));
                   label22.Caption:=('-$' + Format('%.0m',[x-2*x + 0.0]));
                   label22.Font.Color:=clred;
                end
              else
                begin
                  label22.Caption:=('$' + Format('%.0m',[x + 0.0]));
                  label22.Font.Color:=clwhite;
                end;
    top1:=0;
    //logs.log('bank','4');
    for i := 0 to strtoint(bankinfo.Values['LoanCount'])-1 do
      begin
          top1:=top1 + 27;
          m1:= tframe2.Create(bloanp);
          m1.parent:=bloanp;
          m1.top:=top1;
          m1.left:=0;
          m1.Align:=altop;
          m1.bname.caption:= bankinfo.Values['LoanBankName' + inttostr(i)];
          m1.bdate.caption:= bankinfo.Values['PayDate' + inttostr(i)];
          m1.bamount.caption := bankinfo.Values['LoanAmount' + inttostr(i)];
          m1.brate.caption:=bankinfo.Values['LoanInterest' + inttostr(i)];
          m1.bterm.caption:=bankinfo.Values['LoanTerm' + inttostr(i)];
          m1.bnext.caption:=bankinfo.Values['LoanSlice' + inttostr(i)];
          //m1.brepay.visible:=false;
          m1.bid:=i;
          m1.MasterURLHandler := fMasterURLHandler;
          m1.clientview:=fclientview;
          m1.name:='loanlist' + inttostr(i);
      end;
    //logs.log('bank','5');
    ///+ '/Five/'<%= LangId %>                                                                       <%= Request("Tycoon")%>                   <%= UCase(Request("Password"))%><%= Request("Company")%>                          <%= Request("WorldName")%>   <%= Request("DAAddr")%>             <%= Request("DAPort")%>                        <%= Request("ISAddr")%>              <%= Request("ISPort")%>                        <%= Request("ClientViewId")%>&RIWS=<%= Request("RIWS") %>
    //url:= fClientView.getWorldURL  +  'Visual/Voyager/NewTycoon/TycoonBankAccount.asp?Tycoon=' + fClientView.getUserName + '&Password=' + fClientView.getUserPassword  + '&Company=' + fClientView.getCompanyName + '&WorldName=' + fClientView.getWorldName + '&DAAddr=' + fClientView.getDAAddr + '&DAPort=' + inttostr(fClientView.getDAPort) + '&ISAddr=' + fClientView.getISAddr + '&ISPort=' + inttostr(fClientView.getISPort) + '&ClientViewId=' + inttostr(fClientView.getClientViewId);
    //logs.log('tshow','bankurl ' + url);
   // bankbrowser.Navigate(url);
   // bankbrowser.Align :=  alclient;
    panel11.BringToFront;
    Notebook1.ActivePage:='bank';
    {bloanp.Update;
    bloanp.SetFocus;
    bloanp.Refresh;
    bloanp.Repaint;
    bloanp.Realign;
    bloanp.CleanupInstance; }
  end;

procedure Ttycoonshower.plbrowserBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
    var t1:string;
begin
  // cancel if utl contails local.asp
  if AnsiContainsStr(url,'http://local.asp') then
    begin
       t1:= AnsiReplaceStr(url,'http://local.asp','');
       fMasterURLHandler.HandleURL(t1);
       cancel:= true;
    end;
  
end;

function Ttycoonshower.plpage: integer;
  var
    i,tp:integer;
    x:int64;
    url:string;
    lab1,lab2,lab3,lab4:tlabel;
    img1,img2:timage;
    prevam:string;
    previd:integer;
    prevshow:bool;

   function endlist():integer;
    begin
      //create end listing
      img1:=timage.Create(plpanel);  //bar image
              img1.Parent:=plpanel;
              img1.Top:=tp;
              img1.Left:=300;
              img1.Height:=2;
              img1.Width:=400;
              img1.Picture:=image8.Picture;
              img1.Stretch:=true;
              img1.Name:= 'chartim2x'+inttostr(previd);
      lab1:=tlabel.Create(plpanel);  //amount
              lab1.Parent:=plpanel;
              lab1.Top:=tp+2;
              lab1.Left:=300;
              lab1.Width:=100;
              lab1.Alignment:=taRightJustify;
              x:=Trunc(strtofloat(plinfo.Values['AccountValue' + inttostr(previd)]));
              if x < 0 then
                begin
                   lab1.Caption:=('-$' + inttostr(x-2*x));
                   lab1.Font.Color:=clred;
                end
              else
                begin
                  lab1.Caption:=('$' + inttostr(x));
                  lab1.Font.Color:=$007DAC02;
                end;
              lab1.Font.Size:=12;
              lab1.Transparent:=true;
              lab1.Name:='lab2x' + inttostr(previd);
              img1:=timage.Create(plpanel);  //chart image
              img1.Parent:=plpanel;
              img1.Top:=tp+8;
              img1.Left:=410;
              img1.Picture:=image3.Picture;
              img1.AutoSize:=true;
              img1.OnClick:= Image3Click;
              img1.Name:= 'chartim'+inttostr(previd);
              tp:=tp+22;
              prevshow:=false;
    end;
   function formatnum(g1:string):string;
    begin
       x:=Trunc(strtofloat(g1));
       if x < 0 then result:=('-$' + inttostr(x-2*x)) else  result:=('$' + inttostr(x))

    end;
  begin
    //show curriculum info
   { bankinfo := nil;
    bankinfo := tstringlist.Create;
    bankinfo.Text := fclientview.bankinfo;
    label22.Caption:= bankinfo.Values['Budget'];  }
    CurrencyString := '';
    scrollbox1.Visible:=false;
    logs.log('pandl','1');
    prevshow:=false;
    tp:=15;
    plinfo := nil;
    plinfo := tstringlist.Create;
    plinfo.Text := fclientview.plinfo;
    if assigned(plpanel) then  plpanel.Free;
    plpanel:= tpanel.Create(scrollbox1);
    plpanel.Parent:=scrollbox1;
    plpanel.Top:=1;
    plpanel.left:=1;
    plpanel.AutoSize:=true;
    plpanel.Color:=clblack;
    plpanel.BorderStyle:=bsnone;
    plpanel.BevelInner:=bvnone;
    plpanel.BevelOuter:=bvnone;
    plpanel.BorderWidth:=0;
    lab1:=tlabel.Create(plpanel);
    lab1.Parent:=plpanel;
    lab1.Top:=tp;
    lab1.Left:=10;
    lab1.Caption:='Profit and Loss';
    lab1.Font.Color:=$00124EFE;
    lab1.Font.Size:=12;
    lab1.Transparent:=true;
    lab1.Name:='pltopname1';
    tp:=tp+20;
    logs.log('pandl','2');
    // do eac account
    for I := 0 to strtoint(plinfo.Values['AccountCount']) - 1 do
      begin
        logs.log('pandl','2-2');
        case strtoint(plinfo.Values['AccountLevel' + inttostr(i)]) of
          0:  //net profit
            begin
              logs.log('pandl','3 '+(plinfo.Values['AccountName' + inttostr(i)]));
              lab1:=tlabel.Create(plpanel);  //name
              lab1.Parent:=plpanel;
              logs.log('pandl','3-2');
              lab1.Top:=tp;
              lab1.Left:=10;
              logs.log('pandl','3-3');
              lab1.Caption:=(plinfo.Values['AccountName' + inttostr(i)]);
              lab1.Font.Color:=$007DAC02;
              lab1.Font.Size:=14;
              logs.log('pandl','3-4');
              lab1.Transparent:=true;
              lab1.Name:='lab5x' + inttostr(i);
              logs.log('pandl','4');
              lab1:=tlabel.Create(plpanel);  //amount
              lab1.Parent:=plpanel;
              lab1.Top:=tp;
              lab1.Left:=300;
              lab1.Width:=100;
              lab1.Alignment:=taRightJustify;
              x:=Trunc(strtofloat(plinfo.Values['AccountValue' + inttostr(i)]));
              if x < 0 then
                begin             //Format('%.0m',[ + 0.0]));
                   lab1.Caption:=('-$' + Format('%.0m',[x-2*x + 0.0]));
                   lab1.Font.Color:=clred;
                end
              else
                begin
                  lab1.Caption:=('$' + Format('%.0m',[x + 0.0]));
                  lab1.Font.Color:=$007DAC02;
                end;
              lab1.Font.Size:=16;
              lab1.Transparent:=true;
              lab1.Name:='lab2x' + inttostr(i);
              logs.log('pandl','5');
              img1:=timage.Create(plpanel);  //chart image
              img1.Parent:=plpanel;
              img1.Top:=tp+8;
              img1.Left:=410;
              img1.Picture:=image3.Picture;
              img1.AutoSize:=true;
              img1.OnClick:= Image3Click;
              img1.Name:= 'chartim2x'+inttostr(i);
              tp:=tp+25;
              logs.log('pandl','6');
            end;
          1:   //main listing
            begin
              if prevshow then x:= endlist;
              prevshow:=false;
              img1:=timage.Create(plpanel);  //bar image
              img1.Parent:=plpanel;
              img1.Top:=tp;
              img1.Left:=10;
              img1.Height:=20;
              img1.Width:=641;
              img1.Picture:=image8.Picture;
              img1.Stretch:=true;
              img1.Name:= 'chartim2x'+inttostr(i);
              img1:=timage.Create(plpanel);  //corner image
              img1.Parent:=plpanel;
              img1.Top:=tp;
              img1.Left:=10;
              img1.Height:=20;
              img1.Width:=20;
              img1.Picture:=image7.Picture;
              img1.Transparent:=true;
              img1.Name:= 'chartim3x'+inttostr(i);

              lab1:=tlabel.Create(plpanel);  //name
              lab1.Parent:=plpanel;
              lab1.Top:=tp;
              lab1.Left:=35;
              lab1.Font.Color:=$00003300;
              lab1.Font.Size:=13;
              lab1.Font.Style:= [fsBOLD];
              lab1.Caption:=plinfo.Values['AccountName' + inttostr(i)];
              lab1.Transparent:=true;
              lab1.Name:='lab1x' + inttostr(i);
              lab1:=tlabel.Create(plpanel);  //amount
              lab1.Parent:=plpanel;
              lab1.Top:=tp;
              lab1.Left:=300;
              lab1.Width:=100;
              lab1.Alignment:=taRightJustify;
              x:=Trunc(strtofloat(plinfo.Values['AccountValue' + inttostr(i)]));
              if x < 0 then
                begin
                   lab1.Caption:=('-$' + Format('%.0m',[x-2*x + 0.0]));
                   lab1.Font.Color:=clred;
                end
              else
                begin
                  lab1.Caption:=('$' + Format('%.0m',[x + 0.0]));
                  lab1.Font.Color:=$007DAC02;
                end;
              lab1.Font.Size:=14;
              lab1.Transparent:=true;
              lab1.Name:='lab2x' + inttostr(i);
              img1:=timage.Create(plpanel);  //chart image
              img1.Parent:=plpanel;
              img1.Top:=tp+8;
              img1.Left:=410;
              img1.Picture:=image3.Picture;
              img1.AutoSize:=true;
              img1.OnClick:= Image3Click;
              img1.Name:= 'chartim'+inttostr(i);
              tp:=tp+25;
            end;
          2:  //individual listing
            begin
              if prevshow then x:= endlist;
              //show begining, set up end
              lab1:=tlabel.Create(plpanel);  //name
              lab1.Parent:=plpanel;
              lab1.Top:=tp;
              lab1.Left:=45;
              lab1.Caption:=plinfo.Values['AccountName' + inttostr(i)];
              lab1.Font.Color:=$007DAC02;
              lab1.Font.Size:=12;
              lab1.Transparent:=true;
              lab1.Name:='lab1x' + inttostr(i);
              previd:=i;
              prevshow:=true;
              //if tax
              if strtobool(plinfo.Values['AccountIsTax' + inttostr(i)]) then
                begin
                    lab1:=tlabel.Create(plpanel);  //name
                    lab1.Parent:=plpanel;  
                    lab1.Alignment:=taRightJustify;
                    lab1.Top:=tp;
                    lab1.Left:=435;
                    lab1.Width:=100;
                    lab1.Caption:='Town';
                    lab1.Font.Color:=$007DAC02;
                    lab1.Font.Size:=12;
                    lab1.Transparent:=true;
                    lab1.Name:='lab3x' + inttostr(i);

                    lab1:=tlabel.Create(plpanel);  //name
                    lab1.Parent:=plpanel;
                    lab1.Alignment:=taRightJustify;
                    lab1.Top:=tp;
                    lab1.Left:=535;
                    lab1.Width:=100;
                    lab1.Caption:='IFEL';
                    lab1.Font.Color:=$007DAC02;
                    lab1.Font.Size:=12;
                    lab1.Transparent:=true;
                    lab1.Name:='lab4x' + inttostr(i);
                end;

              tp:=tp+20;
            end;
          3: //listing details
            begin
              lab1:=tlabel.Create(plpanel);  //name
              lab1.Parent:=plpanel;
              lab1.Top:=tp;
              lab1.Left:=55;
              lab1.Caption:=plinfo.Values['AccountName' + inttostr(i)];
              lab1.Font.Color:=$007DAC02;
              lab1.Font.Size:=10;
              lab1.Transparent:=true;
              lab1.Name:='lab1x' + inttostr(i);
              lab1:=tlabel.Create(plpanel);  //amount
              lab1.Parent:=plpanel;
              lab1.Alignment:=taRightJustify;
              lab1.Top:=tp;
              lab1.Left:=300;
              lab1.Width:=100;
              x:=Trunc(strtofloat(plinfo.Values['AccountValue' + inttostr(i)]));
              if x < 0 then
                begin
                   lab1.Caption:=('-$' + Format('%.0m',[x-2*x + 0.0]));
                   lab1.Font.Color:=$007DAC02;
                end
              else
                begin
                  lab1.Caption:=('$' + Format('%.0m',[x + 0.0]));
                  lab1.Font.Color:=$007DAC02;
                end;
              lab1.Font.Size:=10;
              lab1.Transparent:=true;
              lab1.Name:='lab2x' + inttostr(i);
              img1:=timage.Create(plpanel);  //chart image
              img1.Parent:=plpanel;
              img1.Top:=tp + 4;
              img1.Left:=410;
              img1.Picture:=image3.Picture;
              img1.AutoSize:=true;
              img1.OnClick:= Image3Click;
              img1.Name:= 'chartim'+inttostr(i);
              //if tax
              if strtobool(plinfo.Values['AccountIsTax' + inttostr(i)]) then
                begin
                    lab1:=tlabel.Create(plpanel);  //name
                    lab1.Parent:=plpanel;
                    lab1.Alignment:=taRightJustify;
                    lab1.Top:=tp;
                    lab1.Left:=435;
                    lab1.Width:=100;
                    x:=Trunc((strtofloat(plinfo.Values['AccountValue' + inttostr(i)])-strtofloat(plinfo.Values['AccountSecValue' + inttostr(i)])));
                    if x < 0 then
                      begin
                        lab1.Caption:=('-$' + Format('%.0m',[x-2*x + 0.0]));
                        lab1.Font.Color:=$007DAC02;
                      end
                    else
                      begin
                        lab1.Caption:=('$' + Format('%.0m',[x + 0.0]));
                        lab1.Font.Color:=$007DAC02;
                      end;

                    lab1.Font.Color:=$007DAC02;
                    lab1.Font.Size:=10;
                    lab1.Transparent:=true;
                    lab1.Name:='lab3x' + inttostr(i);

                    lab1:=tlabel.Create(plpanel);  //name
                    lab1.Parent:=plpanel;
                    lab1.Alignment:=taRightJustify;
                    lab1.Top:=tp;
                    lab1.Left:=535;
                    lab1.Width:=100;
                    x:=Trunc((strtofloat(plinfo.Values['AccountSecValue' + inttostr(i)])));
                    if x < 0 then
                      begin
                        lab1.Caption:=('-$' + Format('%.0m',[x-2*x + 0.0]));
                        lab1.Font.Color:=$007DAC02;
                      end
                    else
                      begin
                        lab1.Caption:=('$' + Format('%.0m',[x + 0.0]));
                        lab1.Font.Color:=$007DAC02;
                      end;
                    lab1.Font.Color:=$007DAC02;
                    lab1.Font.Size:=10;
                    lab1.Transparent:=true;
                    lab1.Name:='lab4x' + inttostr(i);
                end;

              tp:=tp+20;
            end;
        end;
            
      end;
    if prevshow then x:= endlist;  
    scrollbox1.Visible:=true;

    //old stuff
    //url:= fClientView.getWorldURL  +  'Visual/Voyager/NewTycoon/TycoonProfitAndLoses.asp?Tycoon=' + fClientView.getUserName + '&Password=' + fClientView.getUserPassword  + '&Company=' + fClientView.getCompanyName + '&WorldName=' + fClientView.getWorldName + '&DAAddr=' + fClientView.getDAAddr + '&DAPort=' + inttostr(fClientView.getDAPort) + '&ISAddr=' + fClientView.getISAddr + '&ISPort=' + inttostr(fClientView.getISPort) + '&ClientViewId=' + inttostr(fClientView.getClientViewId);
    //logs.log('tshow','plurl ' + url);
    //plbrowser.Navigate(url);
   // plbrowser.Align :=  alclient;
    panel12.BringToFront;
    Notebook1.ActivePage:='pl';
    //plbrowser.Top:=-2;
    //plbrowser.Left:=-2;
    //plbrowser.Width:=panel12.Width+4;
    //plbrowser.Height:= panel12.Height+4;
  end;

function Ttycoonshower.ispage: integer;
  var
    i:integer;
    url:string;
  begin
    //set up bank page
    //show curriculum info
   { bankinfo := nil;
    bankinfo := tstringlist.Create;
    bankinfo.Text := fclientview.bankinfo;
    label22.Caption:= bankinfo.Values['Budget'];  }
    ///+ '/Five/'<%= LangId %>                                                                       <%= Request("Tycoon")%>                   <%= UCase(Request("Password"))%><%= Request("Company")%>                          <%= Request("WorldName")%>   <%= Request("DAAddr")%>             <%= Request("DAPort")%>                        <%= Request("ISAddr")%>              <%= Request("ISPort")%>                        <%= Request("ClientViewId")%>&RIWS=<%= Request("RIWS") %>
    url:= fClientView.getWorldURL  +  'Visual/Voyager/NewTycoon/TycoonAutoConnections.asp?Tycoon=' + fClientView.getUserName + '&Password=' + fClientView.getUserPassword  + '&Company=' + fClientView.getCompanyName + '&WorldName=' + fClientView.getWorldName + '&DAAddr=' + fClientView.getDAAddr + '&DAPort=' + inttostr(fClientView.getDAPort) + '&ISAddr=' + fClientView.getISAddr + '&ISPort=' + inttostr(fClientView.getISPort) + '&ClientViewId=' + inttostr(fClientView.getClientViewId);
    //logs.log('tshow','isurl ' + url);
    isbrowser.Navigate(url);
    isbrowser.Align :=  alclient;
    panel13.BringToFront;
    Notebook1.ActivePage:='is';
  end;

function Ttycoonshower.stratpage: integer;
  var
    i:integer;
    url:string;
  begin
    //set up bank page
    //show curriculum info
   { bankinfo := nil;
    bankinfo := tstringlist.Create;
    bankinfo.Text := fclientview.bankinfo;
    label22.Caption:= bankinfo.Values['Budget'];  }
    ///+ '/Five/'<%= LangId %>                                                                       <%= Request("Tycoon")%>                   <%= UCase(Request("Password"))%><%= Request("Company")%>                          <%= Request("WorldName")%>   <%= Request("DAAddr")%>             <%= Request("DAPort")%>                        <%= Request("ISAddr")%>              <%= Request("ISPort")%>                        <%= Request("ClientViewId")%>&RIWS=<%= Request("RIWS") %>
    url:= fClientView.getWorldURL  +  'Visual/Voyager/NewTycoon/TycoonPolicy.asp?Tycoon=' + fClientView.getUserName + '&Password=' + fClientView.getUserPassword  + '&Company=' + fClientView.getCompanyName + '&WorldName=' + fClientView.getWorldName + '&DAAddr=' + fClientView.getDAAddr + '&DAPort=' + inttostr(fClientView.getDAPort) + '&ISAddr=' + fClientView.getISAddr + '&ISPort=' + inttostr(fClientView.getISPort) + '&ClientViewId=' + inttostr(fClientView.getClientViewId);
    //logs.log('tshow','straturl ' + url);
    stratbrowser.Navigate(url);
    stratbrowser.Align :=  alclient;
    panel14.BringToFront;
    Notebook1.ActivePage:='strat';
  end;

function Ttycoonshower.webpage: integer;
  var
    i:integer;
    url:string;
  begin
    //set up bank page
    //show curriculum info
   { bankinfo := nil;
    bankinfo := tstringlist.Create;
    bankinfo.Text := fclientview.bankinfo;
    label22.Caption:= bankinfo.Values['Budget'];  }
    ///+ '/Five/'<%= LangId %>                                                                       <%= Request("Tycoon")%>                   <%= UCase(Request("Password"))%><%= Request("Company")%>                          <%= Request("WorldName")%>   <%= Request("DAAddr")%>             <%= Request("DAPort")%>                        <%= Request("ISAddr")%>              <%= Request("ISPort")%>                        <%= Request("ClientViewId")%>&RIWS=<%= Request("RIWS") %>
    url:= 'http://www.starpeacelive.com/?Alias=' + fClientView.getUserName + '&Password=' + fClientView.getUserPassword;
    //logs.log('tshow','straturl ' + url);
    WebBrowser1.Navigate(url);
    WebBrowser1.Align :=  alclient; 
    Notebook1.ActivePage:='web';
  end;

function Ttycoonshower.rank(rid:widestring): integer;
  var
     i:integer;
     m:tstringlist;
     noimage: boolean;
     r1:string;
     v: OleVariant;
    memStream: TMemoryStream;
      jpegimg: TJPEGImage;
      bitmp: tbitmap;
  begin
    //show ranks
    logs.Log('loadrank','1');
    for i := 0 to rg.ColCount - 1 do rg.Cols[i].Clear;
    rimg1.Visible:=false;
    rl0.Visible:=false;
    rv0.Visible:=false;
    rimg2.Visible:=false;
    rl1.Visible:=false;
    rv1.Visible:=false;
    rimg3.Visible:=false;
    rl2.Visible:=false;
    rv2.Visible:=false;
    m:=tstringlist.create;//clear all first
    m.Text := fclientview.getrank(rid); // m.Values['level' + inttostr(i)]
    rtn.Caption:= m.Values['RankingName0'];
    rg.RowCount:= max(1,strtoint(m.Values['count']) - 3);
    for I := 0 to strtoint(m.Values['count']) - 1 do
      begin
        case i of
          0: begin
            rimg1.Visible:=true;
            rl0.Visible:=true;
            rv0.Visible:=true;
            rl0.Caption:= '1. ' +  m.Values['name' + inttostr(i)];
            rv0.Caption:= m.Values['value' + inttostr(i)];
            //update image
            try

           
            r1:= fClientView.getWorldAbsURL + 'fivedata/userinfo/' + fClientView.getWorldName + '/' + m.Values['name' + inttostr(i)] + '/largephoto.jpg';
            noimage:= false;
            try

        memStream := TMemoryStream.Create;

        idhttp1.Get(r1,memStream);

      except
        on e: EIdHTTPProtocolException do begin
          noimage:= true;
          //logs.log('objectviewer','error code - ' + inttostr(e.ErrorCode));
        end;
    end;
    if noimage = false then
        begin

          jpegimg   := TJPEGImage.Create;
          //logs.log('objectviewer','lmg - 5');
          try
            //memStream.Write(strStream[1], Length(strStream));
            memStream.Seek(0,soFromBeginning);//.Position := 0;
            //logs.log('objectviewer','lmg - 6');
            jpegimg.LoadFromStream(memStream);
            //logs.log('objectviewer','lmg - 6.1');
            jpegimg.PixelFormat := jf8Bit;
            //logs.log('objectviewer','lmg - 6.2');
            //jpegimg.Grayscale := True;
            //logs.log('objectviewer','lmg - 7');
            jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
            //logs.log('objectviewer','lmg - 8');
            rimg1.Picture.Assign(jpegimg);
            //logs.log('objectviewer','lmg - 9');
            //logs.log('objectviewer','show user pic');
          finally
            memStream.Free;
            jpegimg.Free;
          end;
        end
      else
        begin
          jpegimg   := TJPEGImage.Create;
          jpegimg.LoadFromFile('cache\misc\nopicture2.jpg');
          jpegimg.PixelFormat := jf8Bit;
         // jpegimg.Grayscale := True;
          jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
          rimg1.Picture.Assign(jpegimg);
          //logs.log('objectviewer','show nopic2');
        end;
          except
              begin
          jpegimg   := TJPEGImage.Create;
          jpegimg.LoadFromFile('cache\misc\nopicture2.jpg');
          jpegimg.PixelFormat := jf8Bit;
         // jpegimg.Grayscale := True;
          jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
          rimg1.Picture.Assign(jpegimg);
          //logs.log('objectviewer','show nopic2');
        end;
            end;
          end;
          1: begin
            rimg2.Visible:=true;
            rl1.Visible:=true;
            rv1.Visible:=true;
            rl1.Caption:= '2. ' +  m.Values['name' + inttostr(i)];
            rv1.Caption:= m.Values['value' + inttostr(i)];
            //update image
            try

            r1:= fClientView.getWorldAbsURL + 'fivedata/userinfo/' + fClientView.getWorldName + '/' + m.Values['name' + inttostr(i)] + '/largephoto.jpg';
            noimage:= false;
            try

        memStream := TMemoryStream.Create;

        idhttp1.Get(r1,memStream);

      except
        on e: EIdHTTPProtocolException do begin
          noimage:= true;
          //logs.log('objectviewer','error code - ' + inttostr(e.ErrorCode));
        end;
    end;
    if noimage = false then
        begin

          jpegimg   := TJPEGImage.Create;
          //logs.log('objectviewer','lmg - 5');
          try
            //memStream.Write(strStream[1], Length(strStream));
            memStream.Seek(0,soFromBeginning);//.Position := 0;
            //logs.log('objectviewer','lmg - 6');
            jpegimg.LoadFromStream(memStream);
            //logs.log('objectviewer','lmg - 6.1');
            jpegimg.PixelFormat := jf8Bit;
            //logs.log('objectviewer','lmg - 6.2');
            //jpegimg.Grayscale := True;
            //logs.log('objectviewer','lmg - 7');
            jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
            //logs.log('objectviewer','lmg - 8');
            rimg2.Picture.Assign(jpegimg);
            //logs.log('objectviewer','lmg - 9');
            //logs.log('objectviewer','show user pic');
          finally
            memStream.Free;
            jpegimg.Free;
          end;
        end
      else
        begin
          jpegimg   := TJPEGImage.Create;
          jpegimg.LoadFromFile('cache\misc\nopicture2.jpg');
          jpegimg.PixelFormat := jf8Bit;
         // jpegimg.Grayscale := True;
          jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
          rimg2.Picture.Assign(jpegimg);
          //logs.log('objectviewer','show nopic2');
        end;
            except
            begin
          jpegimg   := TJPEGImage.Create;
          jpegimg.LoadFromFile('cache\misc\nopicture2.jpg');
          jpegimg.PixelFormat := jf8Bit;
         // jpegimg.Grayscale := True;
          jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
          rimg2.Picture.Assign(jpegimg);
          //logs.log('objectviewer','show nopic2');
        end;

            end;
          end;
          2: begin
            rimg3.Visible:=true;
            rl2.Visible:=true;
            rv2.Visible:=true;
            rl2.Caption:= '3. ' +  m.Values['name' + inttostr(i)];
            rv2.Caption:= m.Values['value' + inttostr(i)];
            //update image
            try

            r1:= fClientView.getWorldAbsURL + 'fivedata/userinfo/' + fClientView.getWorldName + '/' + m.Values['name' + inttostr(i)] + '/largephoto.jpg';
            noimage:= false;
            try

        memStream := TMemoryStream.Create;

        idhttp1.Get(r1,memStream);

      except
        on e: EIdHTTPProtocolException do begin
          noimage:= true;
          //logs.log('objectviewer','error code - ' + inttostr(e.ErrorCode));
        end;
    end;
    if noimage = false then
        begin

          jpegimg   := TJPEGImage.Create;
          //logs.log('objectviewer','lmg - 5');
          try
            //memStream.Write(strStream[1], Length(strStream));
            memStream.Seek(0,soFromBeginning);//.Position := 0;
            //logs.log('objectviewer','lmg - 6');
            jpegimg.LoadFromStream(memStream);
            //logs.log('objectviewer','lmg - 6.1');
            jpegimg.PixelFormat := jf8Bit;
            //logs.log('objectviewer','lmg - 6.2');
            //jpegimg.Grayscale := True;
            //logs.log('objectviewer','lmg - 7');
            jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
            //logs.log('objectviewer','lmg - 8');
            rimg3.Picture.Assign(jpegimg);
            //logs.log('objectviewer','lmg - 9');
            //logs.log('objectviewer','show user pic');
          finally
            memStream.Free;
            jpegimg.Free;
          end;
        end
      else
        begin
          jpegimg   := TJPEGImage.Create;
          jpegimg.LoadFromFile('cache\misc\nopicture2.jpg');
          jpegimg.PixelFormat := jf8Bit;
         // jpegimg.Grayscale := True;
          jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
          rimg3.Picture.Assign(jpegimg);
          //logs.log('objectviewer','show nopic2');
        end;
            except
              begin
          jpegimg   := TJPEGImage.Create;
          jpegimg.LoadFromFile('cache\misc\nopicture2.jpg');
          jpegimg.PixelFormat := jf8Bit;
         // jpegimg.Grayscale := True;
          jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
          rimg3.Picture.Assign(jpegimg);
          //logs.log('objectviewer','show nopic2');
        end;
            end;
          end;
          else
            begin
               rg.Cells[0,i-3] := inttostr(i+1) + '. ' + m.Values['name' + inttostr(i)];
               rg.Cells[1,i-3] := m.Values['value' + inttostr(i)];
               //rg.Cells[i-3,0]
            end;
        end;
      rg.Height:= strtoint(m.Values['count'])*24+15;
      //rg.
      end;
    Notebook1.ActivePage:='rank';
  end;

procedure Ttycoonshower.SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
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

procedure Ttycoonshower.SetParent(which: TWinControl);
  begin
    inherited;
    //logs.log('wlogin','setparent');
    if which<>nil
      then
        begin
          //RulesTicker.Visible := false;
          if InitSkinImage
            then
              begin
                InitializeCoolSB(scrollbox1.Handle);
                if hThemeLib <> 0
                  then
                    SetWindowTheme(scrollbox1.Handle, ' ', ' ');
                CoolSBEnableBar(scrollbox1.Handle, false, true);
                InitializeCoolSB(scrollbox2.Handle);
                if hThemeLib <> 0
                  then
                    SetWindowTheme(scrollbox2.Handle, ' ', ' ');
                CoolSBEnableBar(scrollbox2.Handle, false, true);
                InitializeCoolSB(scrollbox3.Handle);
                if hThemeLib <> 0
                  then
                    SetWindowTheme(scrollbox3.Handle, ' ', ' ');
                CoolSBEnableBar(scrollbox3.Handle, false, true);
              end;
        end;
  end;

end.
