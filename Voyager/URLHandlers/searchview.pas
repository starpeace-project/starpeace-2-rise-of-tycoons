unit searchview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StrUtils,logs,VisualControls, protocol,SHDocVw, ActiveX,MSHTML,
  VoyagerInterfaces, VoyagerServerInterfaces, OleCtrls, StdCtrls, GIFImg,
  ExtCtrls, FramedButton, jpeg,towns, ComCtrls,coolsb;

type
  Tsearchviewf = class(TVisualControl)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    FramedButton4: TFramedButton;
    FramedButton1: TFramedButton;
    Notebook1: TNotebook;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    WebBrowser1: TWebBrowser;
    ScrollBox1: TScrollBox;
    Panel4: TPanel;
    rlist: TListView;
    Label7: TLabel;
    procedure Image9Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure FramedButton1Click(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure rlistClick(Sender: TObject);
  private
    { Private declarations }
    fClientView       : IClientView;
    fMasterURLHandler : IMasterURLHandler;
    capitol           : tstringlist;
    cx,cy             : string;
    m1: tframe3;
    panelb1:TPanel;
    ranklist:tstringlist;
  private
    procedure SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
  public
    { Public declarations }
    fCache            : string ;
    property ClientView       : IClientView       write fClientView;
    property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
    property Cache            : string            write fCache;
  protected
        procedure SetParent(which : TWinControl);  override;
  published
    function reset:integer;
  end;

var
  searchviewf: Tsearchviewf;

implementation

{$R *.dfm}

 procedure Tsearchviewf.FramedButton1Click(Sender: TObject);
begin
  notebook1.ActivePage:='front';
end;

procedure Tsearchviewf.Image4Click(Sender: TObject);
 var
  limg:string;
  towns1:tstringlist;
  i,z: integer;
begin
  //show towns       fClientView.getWorldURL  +  'Visual/Voyager/NewTycoon/TycoonAutoConnections.asp?Tycoon='
  //url:=fClientView.getWorldURL  + 'Visual/Voyager/New Directory/Towns.asp?Tycoon=' + fClientView.getUserName + '&WorldName=' + fClientView.getWorldName;
  //webbrowser1.Navigate(url);
  

  // do proper list
  towns1 := nil;
  towns1 := tstringlist.Create;
  towns1.Text := fclientview.gettowns;
  if assigned(panelb1) then             //.
    begin
      panelb1.Free;
                //panelb1.Destroy;
    end;
  //scrollbox1.Visible:=false;
  panelb1:= tpanel.Create(scrollbox1);
  panelb1.Parent:=scrollbox1;
  panelb1.AutoSize:= true;

           panelb1.Align:=altop;
           panelb1.Top:=0;
           panelb1.Left:=0;
           panelb1.Color:=clblack;
           panelb1.BorderStyle:=bsnone;
           panelb1.BevelOuter:=bvnone;
  for i := 0 to strtoint(towns1.Values['count']) - 1 do
    begin
      //make new
      m1:= tframe3.Create(panelb1);
      m1.Parent := panelb1;
      m1.Align:=altop;
      m1.label1.caption:= towns1.Values['tname' + inttostr(i)];
      m1.x:=towns1.Values['x' + inttostr(i)];
      m1.y:=towns1.Values['y' + inttostr(i)];
      z:= strtoint(towns1.Values['hpop' + inttostr(i)]) + strtoint(towns1.Values['mpop' + inttostr(i)]) + strtoint(towns1.Values['lpop' + inttostr(i)]);
      m1.label2.caption:= inttostr(z);
      limg:='cache\build\icon\mapdistownhall64x32x0.gif' ;
      case strtoint(towns1.Values['vid' + inttostr(i)]) of
         1500:   limg:='cache\build\icon\mapmoabtownhall64x32x0.gif' ; //     
         4500:   limg:='cache\build\icon\mappgitownhall64x32x0.gif' ;
         3500:   limg:='cache\build\icon\mapmkotownhall64x32x0.gif' ;
         2500:   limg:='cache\build\icon\mapdistownhall64x32x0.gif' ;
      end;

      m1.image1.Picture.LoadFromFile(limg);

      m1.MasterURLHandler := fMasterURLHandler;
      m1.Name:='fff' + inttostr(i);
    end;
   notebook1.ActivePage:='towns';
   towns1.free;
end;

procedure Tsearchviewf.Image5Click(Sender: TObject);
var
  url:string;
begin
  //show you      RenderTycoon.asp?WorldName=<%= WorldName %>&Tycoon=<%= Request("Tycoon")%>
  url:=fClientView.getWorldURL  + 'Visual/Voyager/New Directory/RenderTycoon.asp?Tycoon=' + fClientView.getUserName + '&WorldName=' + fClientView.getWorldName;
  webbrowser1.Navigate(url);
  notebook1.ActivePage:='webpage';
end;

procedure Tsearchviewf.Image6Click(Sender: TObject);
var
  url:string;
begin
  //show people
  url:=fClientView.getWorldURL  + 'Visual/Voyager/New Directory/Tycoons.asp?Tycoon=' + fClientView.getUserName + '&WorldName=' + fClientView.getWorldName;
  webbrowser1.Navigate(url);
  notebook1.ActivePage:='webpage';
end;

procedure Tsearchviewf.Image7Click(Sender: TObject);
var
  url:string;
  i:integer;
begin
  //show rankings
  //url:=fClientView.getWorldURL  + 'Visual/Voyager/New Directory/Rankings.asp?Tycoon=' + fClientView.getUserName + '&WorldName=' + fClientView.getWorldName;
  //webbrowser1.Navigate(url);
   //logs.Log('loadrank','1');
  // set up rankings
  ranklist:=nil;
  ranklist:=tstringlist.create;
  ranklist.Text:= fclientview.getranklist;
  rlist.Items.Clear;
  //rlist.Column[0].Width:=150;
  //rlist.Column[1].Width:=150;
  //rlist.Column[2].Width:=150;
  //rlist.Column[3].Width:=150;
  //logs.Log('loadrank','2');
  for i := 0 to strtoint(ranklist.Values['count']) - 1 do
    begin
      //list all
      with rlist.Items.Add do
          begin
          //logs.Log('loadrank','3');
            case strtoint(ranklist.Values['level' + inttostr(i)]) of
              0: begin
                  url:='';
                  font.Size:=12;
                  font.Style:= [fsBold,fsUnderline];
                end;
              1: begin
                  url:='  ';
                  font.Size:=10;
                  font.Style:= [fsBold,fsUnderline];
                end;
              2: begin
                  url:='    ';
                  font.Size:=10;
                  font.Style:= [fsBold];
                end;
              3: begin
                  url:='      ';
                  font.Size:=0;
                  //font.Style:= [fsBold,fsUnderline];
                end;
            end;
            //logs.Log('loadrank','4');
            caption := url + ranklist.Values['name' + inttostr(i)];
          end;
    end;
    //logs.Log('loadrank','5');
    //rlist.
  notebook1.ActivePage:='rank';
end;

procedure Tsearchviewf.Image8Click(Sender: TObject);
var
  url:string;
begin
  //show banks
  url:=fClientView.getWorldURL  + 'Visual/Voyager/New Directory/Banks.asp?Tycoon=' + fClientView.getUserName + '&WorldName=' + fClientView.getWorldName;
  webbrowser1.Navigate(url);
  notebook1.ActivePage:='webpage';
end;

procedure Tsearchviewf.Image9Click(Sender: TObject);
var
  url:string;
begin
  // go to capitol
  fMasterURLHandler.HandleURL( '?frame_Id=MapIsoView&frame_Action=SELECT&x=' + cx + '&y=' + cy );
end;

function Tsearchviewf.reset:integer;
  begin
    //check if capitol
    image3.Visible:=true;
    image9.Visible:= false;
    capitol := nil;
    capitol := tstringlist.Create;
    capitol.Text := fclientview.capitol;
    if capitol.Values['capitol']='1' then
        begin
          image3.Visible:=false;
          image9.Visible:= true;
          cx:=capitol.Values['CapitolX'];
          cy:=capitol.Values['CapitolY'];
        end;
    //show front page
    notebook1.ActivePage:='front';
  end;

 procedure Tsearchviewf.rlistClick(Sender: TObject);
    var
      i:integer;
      url:string;
    begin
       // on click, send to right page
       //logs.Log('loadrank','m1');
       i:= rlist.ItemIndex;
       //logs.Log('loadrank','m2-' + inttostr(i));
       url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=rank&rid=' + ranklist.Values['path' + inttostr(i)] + '&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
       fMasterURLHandler.HandleURL( url);
       //logs.Log('loadrank',url);
    end;

procedure Tsearchviewf.SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
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

procedure Tsearchviewf.SetParent(which: TWinControl);
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
                InitializeCoolSB(rlist.Handle);
                if hThemeLib <> 0
                  then
                    SetWindowTheme(rlist.Handle, ' ', ' ');
                CoolSBEnableBar(rlist.Handle, true, true);
              end;
        end;
  end;

procedure Tsearchviewf.WebBrowser1BeforeNavigate2(ASender: TObject;
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
  if AnsiContainsStr(url,'ranking.asp') then
    begin
       //t1:= AnsiReplaceStr(url,'http://local.asp','');
       fMasterURLHandler.HandleURL(url);
       cancel:= true;
    end;
end;

end.
