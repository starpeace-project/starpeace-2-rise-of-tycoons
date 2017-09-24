unit ToolbarHandlerViewer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VisualControls, ExtCtrls, MPlayer, PlayerAnim, PlayerGif, GradientBox,
  FramedButton, StdCtrls, BlockTicker, VoyagerServerInterfaces, VoyagerInterfaces,
  InternationalizerComponent, Config, jpeg, MultiBMPButton, logs;

type
  TToolbarHandlerView = class(TVisualControl)
    RightPanel: TPanel;
    GradientBox1: TGradientBox;
    UserName: TLabel;
    Money: TLabel;
    CompanyName: TLabel;
    LedsPanel: TPanel;
    MsgCompanionshipOn: TImage;
    MsgMailOn: TImage;
    MsgServerBusyOn: TImage;
    MsgCompanionshipOff: TImage;
    MsgMailOff: TImage;
    MsgServerBusyOff: TImage;
    MSGServerOnline: TImage;
    MoneyDelta: TLabel;
    LEDsTimer: TTimer;
    LeftSide: TPanel;
    Container: TPanel;
    Date: TLabel;
    BusyPlayer: TGifPlayer;
    ScrollPanel: TPanel;
    AdsContainer: TPanel;
    MinimizeBtn: TFramedButton;
    CloseBtn: TFramedButton;
    FacCounter: TLabel;
    FacIcon: TImage;
    BlockTicker: TBlockTicker;
    TickerTimer: TTimer;
    InternationalizerComponent1: TInternationalizerComponent;
    Label1: TLabel;
    MSGServerOffline: TImage;
    Image1: TImage;
    brefresh: TMultiBMPButton;
    bbuild: TMultiBMPButton;
    bhome: TMultiBMPButton;
    bfav: TMultiBMPButton;
    bsearch: TMultiBMPButton;
    bprofile: TMultiBMPButton;
    bmap: TMultiBMPButton;
    buni: TMultiBMPButton;
    bmail: TMultiBMPButton;
    bchat: TMultiBMPButton;
    boptions: TMultiBMPButton;
    bhelp: TMultiBMPButton;
    bib: TMultiBMPButton;
    container2: TPanel;
    procedure LEDsTimerTimer(Sender: TObject);
    procedure RightPanelResize(Sender: TObject);
    procedure MinimizeBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure TickerTimerTimer(Sender: TObject);
    procedure BlockTickerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure brefreshClick(Sender: TObject);
    procedure bhomeClick(Sender: TObject);
    procedure bbuildClick(Sender: TObject);
    procedure bfavClick(Sender: TObject);
    procedure bsearchClick(Sender: TObject);
    procedure bprofileClick(Sender: TObject);
    procedure bmapClick(Sender: TObject);
    procedure buniClick(Sender: TObject);
    procedure bmailClick(Sender: TObject);
    procedure bchatClick(Sender: TObject);
    procedure boptionsClick(Sender: TObject);
    procedure bhelpClick(Sender: TObject);
    procedure bibClick(Sender: TObject);
  private
    fUnreadMsgs       : integer;
    fMailLEDInertia   : integer;
    fReadCount        : integer;
    fURL              : string;
    fWaiting          : boolean;
    fClientView       : IClientView;
    fMasterURLHandler : IMasterURLHandler;
  private
    procedure SetBusyClipPath( aBusyClipPath : string );
    procedure SetUnreadMsgs( count : integer );
  public
    property BusyClipPath : string  write SetBusyClipPath;
    property UnreadMsgs   : integer write SetUnreadMsgs;
    property ReadCount    : integer read fReadCount write fReadCount;
    property ClientView   : IClientView write fClientView;
    property MasterURLHandler : IMasterURLHandler write fMasterURLHandler;
  public
    procedure Busy;
    procedure NotBusy;
  private
    procedure threadedPickMessage( const parms : array of const );
    procedure syncPickMessage( const parms : array of const );

    procedure threadedServerBusy( const parms : array of const );
    procedure syncServerBusy( const parms : array of const );
  public
    procedure ReloadHints;
    procedure StartHints;
    procedure StopHints;
  private
    fTimerCount  : integer;
    fServerBusy  : boolean;
    fFirstBackup : boolean;
  end;

implementation

  {$R *.DFM}
  uses
   {$IFOPT D+}
    ShareMem,  //.rag para chequear la memoria usada.
    GameTypes,
    Map,
   {$ENDIF}
    ShutDown, Protocol, Threads, Literals, ClientMLS, URLParser, Events, VoyagerWindow, MessageBox;

  const
    Hints : TStringList = nil;

  procedure TToolbarHandlerView.SetBusyClipPath( aBusyClipPath : string );
    begin
      try
        BusyPlayer.Filename := aBusyClipPath;
      except
      end;
    end;

  procedure TToolbarHandlerView.SetUnreadMsgs( count : integer );
    begin
      MsgMailOn.Hint := GetFormattedLiteral('Literal344', [count]);
      MsgMailOff.Hint := GetFormattedLiteral('Literal345', [count]);
      fUnreadMsgs := count;
      fMailLEDInertia := 30;
    end;

  procedure TToolbarHandlerView.bmailClick(Sender: TObject);
    var
      url:string;
    begin
      //shpw mail                                                  mail/MailFolder.asp?Folder=Inbox&WorldName=<%= Request("WorldName") %>&Tycoon=<%= Request("Tycoon")%>&Account=<%= Request("MailAccount")%>&Password=<%= Request("Password")%>&frame_Id=MailView&frame_Class=HTMLView&frame_Align=bottom&frame_Height=40%&frame_KeepContent=no&frame_ToHistory=yes
      url:=fclientview.getWorldURL + 'visual/voyager/mail/MailFolder.asp?Folder=Inbox&Tycoon=' + fclientview.getUserName + '&Password=' + fclientview.getUserPassword + '&Company=' + fclientview.getCompanyName + '&WorldName=' + fclientview.getWorldName + '&DAAddr=' + fclientview.getDAAddr + '&DAPort=' + inttostr(fclientview.getDAPort) + '&ISAddr=' + fclientview.getISAddr + '&ISPort=' + inttostr(fclientview.getISPort) + '&Account=' + fClientView.getUserName+'@'+ fClientView.getWorldName + '.net' +'&frame_Id=MailView&frame_Class=HTMLView&frame_Align=bottom&frame_Height=40%&frame_KeepContent=no&frame_ToHistory=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.bmapClick(Sender: TObject);
    var
      url:string;
    begin
      //show map
      url:='?frame_Id=MapIsoView&frame_Align=client&frame_ToHistory=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.boptionsClick(Sender: TObject);
    var
      url:string;
    begin
       //show options
      url:='?frame_Id=OptionsView&frame_Class=OptionsView&frame_Align=top&frame_Width=100%&frame_Height=114&frame_Visibility=switch&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.bprofileClick(Sender: TObject);
    var
      url:string;
    begin
      //show profile     tycoonView      newtycoon/tycoonOptions.asp?Tycoon=<%= Request("Tycoon")%>&Password=<%= Request("Password")%>&Company=<%= Request("Company")%>&WorldName=<%= Request("WorldName")%>&DAAddr=<%= Request("DAAddr")%>&DAPort=<%= Request("DAPort")%>&ISAddr=<%= Request("ISAddr")%>&ISPort=<%= Request("ISPort")%>&frame_Id=TycoonOpt&frame_Class=HTMLView&frame_Visibility=switch&frame_Align=left&frame_NoBorder=Yes&frame_ToHistory=yes&SecurityId=<%= Request("SecurityId") %>&ClientViewId=<%= Request("ClientViewId")%>&frame_Width=170&frame_NoScrollBars=yes::http://local.asp?frame_Id=MapIsoView&frame_Align=client&frame_ToHistory=yes&frame_Visibility=switch
      //url:=fclientview.getWorldURL + 'visual/voyager/newtycoon/tycoonOptions.asp?Tycoon=' + fclientview.getUserName + '&Password=' + fclientview.getUserPassword + '&Company=' + fclientview.getCompanyName + '&WorldName=' + fclientview.getWorldName + '&DAAddr=' + fclientview.getDAAddr + '&DAPort=' + inttostr(fclientview.getDAPort) + '&ISAddr=' + fclientview.getISAddr + '&ISPort=' + inttostr(fclientview.getISPort) + '&frame_Id=TycoonOpt&frame_Class=HTMLView&frame_Visibility=switch&frame_Align=left&frame_NoBorder=Yes&frame_ToHistory=yes&SecurityId=' + fclientview.getSecurityId + '&ClientViewId=' + inttostr(fclientview.getClientViewId) + '&frame_Width=170&frame_NoScrollBars=yes::http://local.asp?frame_Id=MapIsoView&frame_Align=client&frame_ToHistory=yes&frame_Visibility=switch';
      url:='?frame_Id=tycoonView&frame_Class=tycoonView&frame_Align=left&frame_Width=200&frame_visibility=switch';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.brefreshClick(Sender: TObject);
    var
      url:string;
    begin
      //refresh
      url:='?frame_Id=Master&frame_Action=Refresh';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.bsearchClick(Sender: TObject);
var
      url:string;
  begin
    //show search   new directory/directory.asp?Tycoon=<%= Request("Tycoon")%>&Company=<%= Request("Company")%>&WorldName=<%= Request("WorldName")%>&DAAddr=<%= Request("DAAddr")%>&DAPort=<%= Request("DAPort")%>&frame_Id=DirectoryView&frame_Class=HTMLView&frame_Visibility=switch&frame_Align=left&frame_Width=220&frame_NoBorder=Yes&frame_NoScrollBars=No&frame_KeepContent=yes&frame_ToHistory=yes
      //url:=fclientview.getWorldURL + 'visual/voyager/new directory/directory.asp?Tycoon=' + fclientview.getUserName + '&Company=' + fclientview.getCompanyName + '&WorldName=' + fclientview.getWorldName + '&DAAddr=' + fclientview.getDAAddr + '&DAPort=' + inttostr(fclientview.getDAPort) + '&frame_Id=DirectoryView&frame_Class=HTMLView&frame_Visibility=switch&frame_Align=left&frame_Width=220&frame_NoBorder=Yes&frame_NoScrollBars=No&frame_KeepContent=yes&frame_ToHistory=yes';
      url:='?frame_Id=searchview&frame_Class=searchview&frame_Align=left&frame_Width=200&frame_visibility=switch';
      fMasterURLHandler.HandleURL(url);
  end;

procedure TToolbarHandlerView.buniClick(Sender: TObject);
  var
      url:string;
  begin
    //show universe
    url:='?frame_Id=UniverseMap&frame_Class=UniversalMapHandler&frame_Align=left&Logon=false&frame_Visibility=switch';
    fMasterURLHandler.HandleURL(url);
  end;

procedure TToolbarHandlerView.Busy;
    begin
      BusyPlayer.Paused := false;
    end;

  procedure TToolbarHandlerView.NotBusy;
    begin
      BusyPlayer.Paused := true;
    end;

  {$IFOPT D+}
  const
  RotationSt : array[TRotation] of string = ('North', 'East', 'South', 'West');
  {$endif}

  procedure TToolbarHandlerView.LEDsTimerTimer(Sender: TObject);
    begin
      if (fMailLEDInertia > 0) and (fUnreadMsgs > 0)
        then
          begin
            MsgMailOff.Visible := not MsgMailOff.Visible;
            dec( fMailLEDInertia );
          end
        else
          begin
            MsgMailOff.Visible := true;
            MsgMailOff.Hint := GetLiteral('Literal346');
          end;

//            MsgServerBusyOff.Visible := false;
//          MsgServerBusyOn.Visible  := false;
        if (fClientView.Offline)
        then
          begin
            MSGServerOffline.Visible := true;
            MSGServerOffline.Hint    := GetLiteral('literal484');
            MSGServerOnline.Visible  := false;
            fTimerCount := 30;
          end
        else
          begin
            MSGServerOffline.Visible := false;
            MSGServerOnline.Visible  := true;
            MSGServerOnline.Hint     := '';
            if ((fTimerCount mod 50)=0)
              then Defer( threadedServerBusy, priNormal, [0] )
              else inc(fTimerCount);
            if fServerBusy
              then
                begin
                  MsgServerBusyOff.Visible := false;
                  MsgServerBusyOn.Visible  := true;
                  MsgServerBusyOn.Hint     := GetLiteral('literal483');
                end
              else
                begin
                  MsgServerBusyOff.Visible := true;
                  MsgServerBusyOn.Visible  := false;
                  MsgServerBusyoff.Hint     := '';
                end;
          end;
      {$IFOPT D+}
      try
        Label1.Caption := Format('%.0n   X:(%d)  Y:(%d)  [ %s ]', [int(GetHeapStatus.TotalAllocated), DebugPosX, DebugPosY, RotationSt[DebugRotate]]);
      except
      end;
      {$ENDIF}
      {$ifOpt D-}
      Label1.Visible := false;
      {$EndIf}
    end;

  procedure TToolbarHandlerView.RightPanelResize(Sender: TObject);
    begin
      // BusyPlayer.Left := LedsPanel.Left - BusyPlayer.Width;
    end;

  procedure TToolbarHandlerView.MinimizeBtnClick(Sender: TObject);
    begin
      Application.Minimize;
    end;

  procedure TToolbarHandlerView.CloseBtnClick(Sender: TObject);
    begin
      VoidJoins;
      Application.Terminate; //.rag
      {$ifOpt D-}
      halt(0); //.rag
      {$EndIf}
    end;

  procedure TToolbarHandlerView.TickerTimerTimer(Sender: TObject);
    begin
      BlockTicker.Tick;
      inc( fReadCount );
      if (fReadCount/2 > length(BlockTicker.Caption)) and not fWaiting
        then
          begin
            fWaiting := true;
            Defer( threadedPickMessage, priNormal, [0] );
          end;
    end;

  procedure TToolbarHandlerView.threadedPickMessage( const parms : array of const );
    var
      list : TStringList;
    begin
      try
        if not fClientView.Offline
          then list := fClientView.PickEvent
          else list := nil;
        Join( syncPickMessage, [list] );
      except
        Join( syncPickMessage, [nil] );
      end;
    end;

  procedure TToolbarHandlerView.syncPickMessage( const parms : array of const );
    var
      list : TStringList absolute parms[0].vPointer;
      aux  : string;
      strX : string;
      strY : string;
    begin
      if list <> nil
        then
          begin
            BlockTicker.Caption := list.Values[tidEventField_Date] + ' - ' + list.Values[tidEventField_Text + ActiveLanguage];
            fURL := list.Values[tidEventField_URL];
            if (fURL <> '') and (pos( 'http://', fURL ) = 0)
              then
                begin
                  fURL :=
                    fClientView.getWorldURL +
                    fURL +
                    '?WorldName=' + fClientView.getWorldName +
                    '&Tycoon=' + fClientView.getUserName +
                    '&DAAddr=' + fClientView.getDAAddr +
                    '&DAPort=' + IntToStr(fClientView.getDALockPort);
                end;
            list.Free;
            fReadCount := 0;
            BlockTicker.Hovering := fURL <> '';
            if (ParamCount > 0) and ((UpperCase(ParamStr(1)) = 'DEMO') or (UpperCase(ParamStr(1)) = 'DEMO'))
              then
                begin
                  strX := GetParmValue(fURL, 'x');
                  strY := GetParmValue(fURL, 'y');
                  if (strX <> '') and (strY <> '')
                    then
                      begin
                        aux := 'http://local.asp?frame_Id=MapIsoView&frame_Action=MOVETO&x=' + strX + '&y=' + strY;
                        fMasterURLHandler.HandleURL(aux);
                      end;
                end;
          end
        else
          begin
            if random(10) = 0
              then
                begin
                  if Hints.Count = 0
                    then ReloadHints;
                  {if (ParamCount > 0) and ((UpperCase(ParamStr(1)) = 'DEMO') or (UpperCase(ParamStr(1)) = 'DEMO'))
                    then
                      begin
                        if (lastX = 0) or (lastY = 0)
                          then
                            begin
                              lastX := 20 + random(fClientView.getWorldXSize - 40);
                              lastY := 20 + random(fClientView.getWorldYSize - 40);
                            end;
                        lastX := lastX + 10 - random(20);
                        if lastX < 20
                          then lastX := 20
                          else
                            if lastX > fClientView.getWorldXSize - 20
                              then lastX := fClientView.getWorldXSize - 20;
                        lastY := lastY + 10 - random(20);
                        if lastY < 20
                          then lastY := 20
                          else
                            if lastY > fClientView.getWorldYSize - 20
                              then lastY := fClientView.getWorldYSize - 20;
                        fMasterURLHandler.HandleURL('?frame_Id=MapIsoView&frame_Action=MoveTo&x=' + IntToStr(lastX) + '&y=' + IntToStr(lastY));
                      end;}
                  BlockTicker.Caption := Hints[random(Hints.Count)];
                  fURL       := '';
                  BlockTicker.Hovering := false;
                end;
            fReadCount := 0;
          end;
      fWaiting := false;
    end;

  procedure TToolbarHandlerView.threadedServerBusy( const parms : array of const );
    var
      IsBusy: boolean;
    begin
      try
        IsBusy := fClientView.IsServerBusy;
      except
        IsBusy := false;
      end;
      Join( syncServerBusy, [IsBusy] );
    end;

  procedure TToolbarHandlerView.syncServerBusy( const parms : array of const );
    var
      IsBusy : boolean absolute parms[0].VBoolean;
      Config : IConfigHolder;
    begin
      fServerBusy := IsBusy;
      fMasterURLHandler.HandleEvent( evnAnswerConfigHolder, Config );
      if fServerBusy and (Config <> nil) and not Config.ReadBoolean( false, fClientView.getUserMasterName, 'BackupWarning', false)
        then
          begin
            ShowMsgBox(
              GetLiteral('Literal494'),
              GetLiteral('Literal493'),
              1, true, false );
            Config.WriteBoolean( false, fClientView.getUserMasterName, 'BackupWarning', true );
            fFirstBackup := true;
          end;
      if not fServerBusy and fFirstBackup
        then
          begin
            ShowMsgBox(
              GetLiteral('Literal495'),
              GetLiteral('Literal496'),
              1, true, false );
            fFirstBackup := false;
          end;
    end;

  procedure TToolbarHandlerView.ReloadHints;
    var
      cachefolder : string;
      filename    : string;
    begin
      {
      Hints.Clear;
      Hints.Add( GetLiteral('Literal347') );
      Hints.Add( GetLiteral('Literal348') );
      Hints.Add( GetLiteral('Literal349') );
      Hints.Add( GetLiteral('Literal350') );
      Hints.Add( GetLiteral('Literal351') );
      Hints.Add( GetLiteral('Literal352') );
      Hints.Add( GetLiteral('Literal353') );
      Hints.Add( GetLiteral('Literal354') );
      Hints.Add( GetLiteral('Literal355') );
      Hints.Add( GetLiteral('Literal356') );
      Hints.Add( GetLiteral('Literal357') );
      Hints.Add( GetLiteral('Literal358') );
      Hints.Add( GetLiteral('Literal359') );
      Hints.Add( GetLiteral('Literal360') );
      Hints.Add( GetLiteral('Literal361') );
      Hints.Add( GetLiteral('Literal362') );
      Hints.Add( GetLiteral('Literal363') );
      Hints.Add( GetLiteral('Literal364') );
      Hints.Add( GetLiteral('Literal365') );
      Hints.Add( GetLiteral('Literal366') );
      }
      try
        Hints.Clear;
        fMasterURLHandler.HandleEvent( evnAnswerPrivateCache, cachefolder );
        filename := cachefolder + '\news\ticker' + ActiveLanguage + '.txt';
        if not FileExists( filename )
          then filename := cachefolder + '\news\ticker0.txt';
        if FileExists( filename )
          then Hints.LoadFromFile( filename  );
      except
      end;
    end;

  procedure TToolbarHandlerView.StartHints;
    begin
      TickerTimer.Enabled := true;
    end;

  procedure TToolbarHandlerView.StopHints;
    begin
      TickerTimer.Enabled := false;
    end;

  procedure TToolbarHandlerView.bbuildClick(Sender: TObject);
  var
      url:string;
    begin
      //show build menu    fclientview.
      //url:=fclientview.getWorldURL + 'visual/voyager/Build/Build.asp?Tycoon=' + fclientview.getUserName + '&Company=' + fclientview.getCompanyName + '&WorldName=' + fclientview.getWorldName + '&frame_Id=BuildView&frame_Visibility=switch&frame_Width=220&frame_KeepContent=yes&frame_ToHistory=yes';
      url:='?frame_Id=builderView&frame_Class=builderView&frame_Align=left&frame_Width=225&frame_visibility=switch';
      //logs.log('toolbar', url);
      fMasterURLHandler.HandleURL(url);
    end;

  procedure TToolbarHandlerView.bchatClick(Sender: TObject);
    var
      url:string;
    begin
      //show chat
      url:='?frame_Action=Create&frame_Id=ChatListHandler&frame_Class=ChatListHandler&frame_Align=right&frame_Width=150&frame_Visibility=switch&frame_ToHistory=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.bfavClick(Sender: TObject);
  var
      url:string;
    begin
      //show fav bar
      url:='?frame_Id=Favorites&frame_Class=Favorites&frame_Align=top&frame_height=95&frame_visibility=switch';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.bhelpClick(Sender: TObject);
    var
      url:string;
    begin
      //show help
      url:='?frame_Id=GMChat&frame_Class=GMChatHandler&frame_Align=top&frame_Height=110&frame_Visibility=switch';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.bhomeClick(Sender: TObject);
    var
      url:string;
    begin
      //show home
      url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=web&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

  procedure TToolbarHandlerView.bibClick(Sender: TObject);
    var
      url:string;
    begin
      //show IB
      url:='?frame_Action=Create&frame_Id=CrimeHandler&frame_Class=CrimeHandler&frame_Align=left&frame_Width=375&frame_Visibility=switch&frame_ToHistory=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure TToolbarHandlerView.BlockTickerClick(Sender: TObject);
    begin
      if BlockTicker.Hovering and (fURL <> '')
        then fMasterURLHandler.HandleURL( fURL );
    end;

  procedure TToolbarHandlerView.FormShow(Sender: TObject);
  begin
    VoyagerWin.OnLogonTimer(nil);
  end;

initialization

  Hints := TStringList.Create;
finalization //.rag
  Hints.Free;  //.rag
  sleep(200);    //. Esta espera es por los hilos.... blas blas blas
end.



