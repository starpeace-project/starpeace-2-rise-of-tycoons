unit MapIsoView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VisualControls, ExtCtrls, TiledPanel, StdCtrls, FiveControl,
  SHDocVw, Protocol, CustomWebBrowser, VoyagerInterfaces, VoyagerServerInterfaces, Buttons,
  MultiBMPButton, FiveIsometricMap, FramedButton, MarqueeCtrl, PDTabControl,
  ComCtrls, Collection, InternationalizerComponent, ImgList,
  {GLTexture, GLHeightData, GLWaterPlane, GLMisc, GLScene,
  GLTerrainRenderer, GLWin32Viewer, GLSkydome, GLBumpmapHDS,
  GLTexCombineShader, GLCadencer, GLObjects, GLHUDObjects,
  GLLensFlare,}math, PercentEdit, OleCtrls,DateUtils,ShellAPI, cefvcl;

type
  TOnToolPressed = procedure( toolid : integer ) of object;

type
  TMapIsoViewer = class(TVisualControl)
    CompositionTimer: TTimer;
    StatusPanel: TPanel;
    SmallMapFrame: TPanel;
    Date: TLabel;
    SmallMapPanel: TPanel;
    SmallPanelPlus: TPanel;
    FramedButton1: TFramedButton;
    SmallPanelMinus: TPanel;
    FramedButton2: TFramedButton;
    Tickers: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel11: TPanel;
    Label1: TLabel;
    Panel12: TPanel;
    Label3: TLabel;
    Panel13: TPanel;
    Label4: TLabel;
    Panel14: TPanel;
    Label9: TLabel;
    SecondaryText: TMarquee;
    HintText: TMarquee;
    Settings: TFramedButton;
    MapBtn: TFramedButton;
    TopPanel: TPanel;
    Panel15: TPanel;
    Panel17: TPanel;
    TickersTimer: TTimer;
    ChatEditPanel: TPanel;
    Panel3: TPanel;
    CloseChat: TFramedButton;
    Panel16: TPanel;
    ChatMsgComposer: TMemo;
    ZoomIn: TMultiBMPButton;
    MultiBMPButton1: TMultiBMPButton;
    ChasePanel: TPanel;
    ChaseIcon: TImage;
    ChasedUser: TLabel;
    ZonesTool: TFramedButton;
    OldLinksPanel: TPanel;
    LinksContainer: TPanel;
    LinkBtnsContainer: TPanel;
    LinkAdd: TFramedButton;
    LinkDel: TFramedButton;
    Links: TListView;
    ImageList1: TImageList;
    FramedButton12: TFramedButton;
    LinksBtn: TPanel;
    Image1: TImage;
    LinksMarquee: TMarquee;
    MapOptionsPanel: TPanel;
    Label8: TLabel;
    OverlaySel: TComboBox;
    LoosesAlert: TCheckBox;
    SmallMapTopBorder: TPanel;
    SmallMapLeftBorder: TPanel;
    btBack: TFramedButton;
    btNext: TFramedButton;
    btTownHall: TFramedButton;
    MultiBMPButton2: TMultiBMPButton;
    MultiBMPButton3: TMultiBMPButton;
    InternationalizerComponent1: TInternationalizerComponent;
    TutorBtn: TPanel;
    FrameTutor: TFramedButton;
    panel3d: TPanel;
    panel3dbut: TFramedButton;
    {GLScene1: TGLScene;
    view3d: TGLSceneViewer;
    GLTerrainRenderer1: TGLTerrainRenderer;
    GLHf: TGLBitmapHDS;
    GLMaterialLibrary1: TGLMaterialLibrary;
    GLSkyDome1: TGLSkyDome;
    GLDummyCube1: TGLDummyCube;
    GLCamera1: TGLCamera;
    GLCadencer1: TGLCadencer;
    GLTexCombineShader1: TGLTexCombineShader;
    GLLensFlare: TGLLensFlare;
    GLDummyCube2: TGLDummyCube;
    GLSprite1: TGLSprite;  }
    info3d: TLabel;
    timer3d: TTimer;
    PercentEdit1: TPercentEdit;
    PercentEdit2: TPercentEdit;
    Panel1: TPanel;
    WebBrowser1: TWebBrowser;
    Timer1: TTimer;
   { GLWaterPlane1: TGLWaterPlane;  }
    procedure ChatMsgComposerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CompositionTimerTimer(Sender: TObject);
    procedure OnToolClick(Sender: TObject);
    procedure OnSmallMapToolClick(Sender: TObject);
    procedure OnResize( Sender : TObject );
    procedure TickersTimerTimer(Sender: TObject);
    procedure CloseChatClick(Sender: TObject);
    procedure ChasedUserClick(Sender: TObject);
    procedure CloseMapOptBtnClick(Sender: TObject);
    procedure TabsTabChange(Sender: TObject);
    procedure LoosesAlarmClick(Sender: TObject);
    procedure ShowSurfaceBtnClick(Sender: TObject);
    procedure trainsClick(Sender: TObject);
    procedure LinksBtnClick(Sender: TObject);
    procedure LinkAddClick(Sender: TObject);
    procedure LinksChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure LinkDelClick(Sender: TObject);
    procedure LinksDblClick(Sender: TObject);
    procedure LinksEdited(Sender: TObject; Item: TListItem; var S: String);
    procedure Button1Click(Sender: TObject);
    procedure OverlaySelChange(Sender: TObject);
    procedure LoosesAlertClick(Sender: TObject);
    procedure SmallMapFrameResize(Sender: TObject);
    procedure SmallMapLeftBorderMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btBackClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure btTownHallClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FrameTutorClick(Sender: TObject);
    procedure panel3dbutClick(Sender: TObject);
    procedure view3dMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure view3dMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure timer3dTimer(Sender: TObject);
    procedure PercentEdit1Change(Sender: TObject);
    procedure PercentEdit2Change(Sender: TObject);
    procedure GLCadencer1Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure Timer1Timer(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);


  public
    constructor Create( aOwner : TComponent ); override;
    destructor  Destroy; override;
  private
    fMapView          : TFiveControl;
    fSmallMap         : TFiveIsometricMap;
    fQuickWeb         : TWebBrowser;
    fMasterURLHandler : IMasterURLHandler;
    fClientView       : IClientView;
    fCompState        : TMsgCompositionState;
    fOnToolPressed    : TOnToolPressed;
    fMapResize        : boolean;
    fLastX, fLastY    : integer;
    fLastMapX         : integer;
    fLastMapY         : integer;
    fHistory          : TCollection;
    fHistoryIndex     : integer;
    fMovingInHistory  : boolean;
    fLastSurfaceId    : integer;
    fValidLinks       : boolean;
    fUpdatingLinks    : boolean;
  public
    fCurrObj          : integer;
    fSelX             : integer;
    fSelY             : integer;
    fCurrX            : integer;
    fCurrY            : integer;
  private
    procedure SetMasterURLHandler( MasterURLHandler : IMasterURLHandler );
    procedure SetClientView( aClientView : IClientView );
  public
    property MapView  : TFiveControl      read fMapView;
    property SmallMap : TFiveIsometricMap read fSmallMap;
    property QuickWeb : TWebBrowser       read fQuickWeb;
    property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
    property ClientView       : IClientView       write SetClientView;
    property OnToolPressed    : TOnToolPressed    write fOnToolPressed;
  public
    procedure InitSmallMap;
    procedure DisplayChatMsg( From, Msg : string );
    procedure SetMsgComposerVisibility( ChatOverMap : boolean );
    procedure SetChasedUser( UserName : string );
  private
    //procedure AdjustChatPanel;
  protected
    procedure Loaded; override;
  public
    procedure ShowSurface( Id : integer );
    procedure SetCurrObj( Obj : integer; x,  y : integer );
    procedure InitLinks;
  private
    procedure AddLink( name : string; x, y : integer; select : boolean );
    procedure DelLink( index : integer );
    procedure threadedInitLinks( const parms : array of const );
    procedure syncInitLinks( const parms : array of const );
    procedure threadedAddLink( const parms : array of const );
    procedure syncAddLink( const parms : array of const );
    procedure threadedDelLink( const parms : array of const );
    procedure threadedDelLinks( const parms : array of const );
    procedure syncDelLink( const parms : array of const );
    procedure syncDelLinks( const parms : array of const );
    procedure threadedGetLinkData( const parms : array of const );
    procedure syncGetLinkData( const parms : array of const );
    procedure threadedGetStatusTexts( const parms : array of const );
    procedure syncGetStatusTexts( const parms : array of const );
    procedure threadedRenameLink( const parms : array of const );
    procedure threadedGetNearestTownHall( const parms : array of const );
    procedure syncGetNearestTownHall( const parms : array of const );
    procedure OnMapMovedTo( y, x : integer );
    procedure GLSceneViewerBeforeRender(Sender: TObject);
  private
    function getCookieValue(cookie : string) : string;
    function getCookieIndex(cookie : string) : integer;
  published
    function paiduser : string;
  public
    mx, my : Integer;
    FCamHeight : Single;
  end;
  var
    advert : integer;
  const
    idZoomIn      = 0;
    idZoomOut     = 1;
    idShowZones   = 3;
    idShowMap     = 4;
    idVisOpt      = 5;
    idQuickWeb    = 6;
    idWebSite     = 7;
    idRotateLeft  = 8;
    idRotateRight = 9;

   var
    currx,curry: integer;
    addiff: tdatetime;
implementation

  {$R *.DFM}

  uses
    ActiveX, MapTypes, FocusTypes, Map, Lander, LocalCacheManager, ServerCnxHandler,
    CircuitsHandler, Threads, GameTypes, Events, LanderTypes, Warnings, ChatListHandler,
    ChatHandler, FiveTypes, SimpleTrainView, Vehicles, CompStringsParser, mr_StrUtils,
    ServerCnxEvents, AxlDebug, Literals, VCLUtils, URLNotification,
    VoyagerWindow,logs, CommCtrl, CoolSB{,Keyboard},LogonHandlerViewer;

  type
    PLinkData = ^TLinkData;
    TLinkData =
      record
        x, y   : integer;
        select : boolean;
        index  : integer;
      end;

  const
    TimePerChar       = 200;
    MaxChatLines      = 10;
    StatusPanelHeight = 50;
    MinSmallMap       = 20;

  type
    THistoryItem =
      class
        x, y : integer;
      end;

  type
    TDebugConsole =
      class(TInterfacedObject, IDebugConsole)
        public
          constructor Create(const URLHandler : IURLHandler);
        private // IDebugConsole
          fURLHandler : IURLHandler;
          procedure WriteDebugStr(const which : string);
      end;

  // TDebugConsole

  constructor TDebugConsole.Create(const URLHandler : IURLHandler);
    begin
      inherited Create;
      fURLHandler := URLHandler;
    end;

  procedure TDebugConsole.WriteDebugStr(const which : string);
    {$IFDEF DEBUG}
    var
      ChatMsg : TChatMsgInfo;
    {$ENDIF}
    begin
      {$IFDEF DEBUG}
      ChatMsg.From := 'Debug';
      ChatMsg.Msg := which;
      fURLHandler.HandleEvent(evnChatMsg, ChatMsg);
      {$ENDIF}
    end;

  constructor TMapIsoViewer.Create( aOwner : TComponent );
    begin
      inherited;
      Align := alClient;
      fMapView := TFiveControl.Create( self );
      with fMapView do
        begin
          Align     := alClient;
          ZoomLevel := 3;   // ord(zr32x64);
        end;
      fMapView.OnMapMovedTo := OnMapMovedTo;
      fSmallMap := TFiveIsometricMap.Create( self );
      with fSmallMap do
        begin
          Align := alClient;
          ZoomLevel := 50;
        end;
      fHistory := TCollection.Create( 0, rkBelonguer );
      AxlDebug.Console := TDebugConsole.Create(fMapView);
      advert := 1;
      //try
  //GLMaterialLibrary1.LibMaterialByName('ground').Material.Texture.Image.LoadFromFile(ExtractFilePath(Application.ExeName) + 'cache\misc\land.bmp');
  //glterrainrenderer1.MaterialLibrary:=GLMaterialLibrary1;
  //glterrainrenderer1.TileSize:=16;
  //glterrainrenderer1.TilesPerTexture:=64;
      //glhf.MaxPoolSize:=8*1024*1024;
      //view3d.Buffer.BackgroundColor:=clWhite;
      //glhf.Picture.LoadFromFile(f3dmappath);
      //except
      //end;
    end;

  destructor TMapIsoViewer.Destroy;
    begin
      fHistory.Free;
      TickersTimer.Enabled := false;
      //fMapView.Parent := nil;
      //fMapView.Owner.RemoveComponent( fMapView );
//      RemoveComponentFreeAndNil(fSmallMap);  // Aqui genera una curda del vac-ace.
      RemoveComponentFreeAndNil(fMapView);
      //fMapView.Free;
      AxlDebug.Console := nil;
      inherited;
    end;

  procedure TMapIsoViewer.SetMasterURLHandler( MasterURLHandler : IMasterURLHandler );
    var
      CachePath : string;
      //Info      : TMsgAnswerVehicleArrayInfo;
    begin
      fMasterURLHandler := MasterURLHandler;
      fMasterURLHandler.HandleEvent( evnAnswerPrivateCache, CachePath );
    //  assert(fClientView <> nil);  .rag (1)
      fMapView.LoadCache( CachePath );
      {
      Info.ActorPoolId := poolIdTrains;
      fMasterURLHandler.HandleEvent( evnAnswerVehicleArray, Info );
      }
      //InitViewer( fClientView, Info.VehicleArray, Agents );
    end;

  procedure TMapIsoViewer.SetClientView( aClientView : IClientView );
    var
      msg : TGetMapperMsg;
    begin
      fClientView := aClientView;
      fMapView.ConnectToWorld( fClientView );
      if (fSmallMap <> nil) and (fMapView.Focus <> nil)
        then
          begin
            msg.id := msgGetMapper;
            fMapView.Focus.Dispatch(msg);
            fSmallMap.Mapper := nil;
            fSmallMap.Mapper := msg.Mapper;
          end;
    end;

  procedure TMapIsoViewer.InitSmallMap;
    var
      Informant : IWarningInformant;
      msg       : TGetMapperMsg;
      AStyle    : Integer;
    begin
      fSmallMap.Parent := SmallMapPanel;
      assert(fMapView.Focus <> nil);
      msg.id := msgGetMapper;
      fMapView.Focus.Dispatch(msg);
      fSmallMap.Mapper := msg.Mapper;
      Informant := fMapView.Focus.GetInformant;
      if Informant <> nil
        then Informant.AttachTarget(fSmallMap);
      OverlaySel.ItemIndex := 0;

      if InitSkinImage
        then InitializeCoolSB(Links.Handle);

{
      AStyle := GetWindowLong(LinksPanel.Handle, GWL_EXSTYLE);
      SetWindowLong(LinksPanel.Handle, GWL_EXSTYLE, AStyle or WS_EX_LAYERED);
      SetLayeredWindowAttributes(LinksPanel.Handle, 0, (255 * 70) div 100, LWA_ALPHA);
}
    end;

  procedure TMapIsoViewer.DisplayChatMsg( From, Msg : string );
    begin
    end;

  procedure TMapIsoViewer.SetMsgComposerVisibility( ChatOverMap : boolean );
    begin
      ChatEditPanel.Visible := ChatOverMap;
      if ChatOverMap
        then
          begin
            ChatMsgComposer.Text := GetLiteral('Literal421');
            ChatMsgComposer.SelectAll;
            ChatMsgComposer.SetFocus;
          end;
      OnResize( self );
    end;

  procedure TMapIsoViewer.SetChasedUser( UserName : string );
    begin
      ChasedUser.Caption := UserName;
      ChasePanel.Width   := ChasedUser.Left + ChasedUser.Width + 10;
      ChasePanel.Left    := Width - ChasePanel.Width;
      ChasePanel.Top     := 0;
      ChasePanel.Visible := UserName <> '';
      if ChasePanel.Visible
        then
          begin
            ChasePanel.BringToFront;
            //LinksPanel.Top := ChasePanel.Height;
          end;
    end;

  {
  procedure TMapIsoViewer.AdjustChatPanel;
    begin
    end;
  }

  procedure TMapIsoViewer.Loaded;
    begin
      inherited;
      OnResize( self );
    end;

  procedure TMapIsoViewer.ChatMsgComposerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    var
      text      : string;
      p         : integer;
      ErrorCode : TErrorCode;
    begin
      if (Key = vk_Return) and (trim(ChatMsgComposer.Text)<>'')
        then
          begin
            if fCompState<>mstIdle
              then
                begin
                  text := ChatMsgComposer.Text;
                  p := system.pos( #$D#$A, text );
                  if p > 0
                    then delete( text, p, 2 );
                  if not ChatHandler.ExecChatCmdURL(fMasterURLHandler, text)
                    then fClientView.SayThis( '', text, ErrorCode );
                  fClientView.MsgCompositionChanged( mstIdle, ErrorCode );
                end;
            fCompState := mstIdle;
            ChatMsgComposer.Clear;
          end
        else
          begin
            if fCompState = mstIdle
              then
                begin
                  fClientView.MsgCompositionChanged( mstComposing, ErrorCode );
                  fCompState := mstComposing;
                end;
            CompositionTimer.Interval := 0;
            CompositionTimer.Interval := CompositionTimeOut;
          end;
    end;

  procedure TMapIsoViewer.CompositionTimerTimer(Sender: TObject);
    var
      ErrorCode : TErrorCode;
    begin
      fClientView.MsgCompositionChanged( mstIdle, ErrorCode );
      CompositionTimer.Interval := 0;
      fCompState := mstIdle;
    end;

  procedure TMapIsoViewer.OnToolClick(Sender: TObject);
    begin
      case TComponent(Sender).Tag of
        idZoomIn :
          fMapView.ZoomIn;
        idZoomOut :
          fMapView.ZoomOut;
        idShowZones :
          if ZonesTool.Selected
            then ShowSurface( 1 )
            else ShowSurface( 0 );
        idRotateLeft :
          fMapView.RotateCCW;
        idRotateRight :
          fMapView.RotateCW;
        idShowMap :
          begin
            MapOptionsPanel.Visible := not MapOptionsPanel.Visible;
            {
            if MapOptionsPanel.Visible
              then MapBtn.Text := 'HIDE'
              else MapBtn.Text := 'MAP';
            }
            MapBtn.Selected := MapOptionsPanel.Visible;
            if not MapOptionsPanel.Visible
              then
                begin
                  ShowSurface( 0 );
                end;
            OnResize(self);                
          end;
        idQuickWeb, idVisOpt, idWebSite :;
      end;
      if assigned(fOnToolPressed)
        then fOnToolPressed( TComponent(Sender).Tag );
      {$ifopt D+}
        if (fMapView<>nil)
          then DebugRotate := fMapView.CurrentRotation;
      {$endif}
    end;

  procedure TMapIsoViewer.OnSmallMapToolClick(Sender: TObject);
    begin
      case TComponent(Sender).Tag of
        idZoomIn : fSmallMap.ZoomIn;
        idZoomOut : fSmallMap.ZoomOut;
      end;
    end;

  procedure TMapIsoViewer.OnResize( Sender : TObject );

    function GetMaxLinksHeight : integer;
      begin
        result := Links.Items.Count*(ImageList1.Height + 2) + {2*LinksPanel.BorderWidth +} LinksMarquee.Height + LinkBtnsContainer.Height + 25;
      end;

    var
      LinksHeight : integer;
    begin
      StatusPanel.BringToFront;
      {
      StatusPanel.Top   := Height - StatusPanel.Height;
      StatusPanel.Width := Width - SmallMapFrame.Width;
      }
      //SmallMapFrame.Top := StatusPanel.Top + StatusPanel.Height - SmallMapFrame.Height;
      //SmallMapFrame.Left := WiStatusPanel.Width;
      if SmallMapFrame.Width>Width-100
        then SmallMapFrame.Width := Width-100;
      SmallMapFrame.Left := Width - SmallMapFrame.Width;
      panel1.Left := (width div 2) - 234 - (SmallMapFrame.width div 2);
      if panel1.left < 0 then panel1.Left:= 0;
      ChatEditPanel.Top := StatusPanel.Top - ChatEditPanel.Height;
      ChatEditPanel.Width := StatusPanel.Width-SmallMapFrame.Width;
      //ChatMsgComposer.Width := StatusPanel.Width - ChatMsgComposer.Left - 10;
      SecondaryText.Width := Tickers.Width - 2;
      HintText.Width  := Tickers.Width - 2;
      ChasePanel.Left := Width - ChasePanel.Width;
      ChasePanel.Top  := 0;
      MapOptionsPanel.Left := 0;
      TutorBtn.Left := 0;
      if ChatEditPanel.Visible
        then
          begin
            MapOptionsPanel.Top := ChatEditPanel.Top - MapOptionsPanel.Height;
            panel1.Top := ChatEditPanel.Top - 64;
            //SmallMapFrame.Top := ChatEditPanel.Top - SmallMapFrame.Height;
          end
        else
          begin
            MapOptionsPanel.Top := StatusPanel.Top - MapOptionsPanel.Height;
            panel1.Top := StatusPanel.Top - 64;
            //SmallMapFrame.Top := StatusPanel.Top - SmallMapFrame.Height;
          end;

      if SmallMapFrame.Height>StatusPanel.Top-100
        then SmallMapFrame.Height := StatusPanel.Top-100;
      SmallMapFrame.Top := StatusPanel.Top - SmallMapFrame.Height;

      if MapOptionsPanel.Visible
        then TutorBtn.Top := MapOptionsPanel.Top - TutorBtn.Height
        else
          if ChatEditPanel.Visible
            then TutorBtn.Top  := ChatEditPanel.Top - TutorBtn.Height
            else TutorBtn.Top  := StatusPanel.Top - TutorBtn.Height;

      //LinksPanel.BringToFront;
      //LinksPanel.Left := SmallMapFrame.Left;  // Width - LinksPanel.Width;
      //LinksPanel.Width := SmallMapFrame.Width;
      LinksBtn.Left := Width - LinksBtn.Width;
      LinksBtn.Top  := SmallMapFrame.Top - LinksBtn.Height;
      LinksHeight := GetMaxLinksHeight;
      {
      if LinksHeight > SmallMapFrame.Top
        then
          begin
            LinksPanel.Top    := 0;
            LinksPanel.Height := SmallMapFrame.Top;
          end
        else
          begin
            LinksPanel.Top    := SmallMapFrame.Top - LinksHeight;
            LinksPanel.Height := LinksHeight;
          end;
      }
      {
      if ChatEditPanel.Visible
        then MapOptionsPanel.Height := ChatEditPanel.Top
        else MapOptionsPanel.Height := StatusPanel.Top;
      }
     // view3d.BringToFront;
      SmallMapFrame.BringToFront;
      ChatEditPanel.BringToFront;
      ChasePanel.BringToFront;
      TutorBtn.BringToFront;
      LinksBtn.BringToFront;
      panel3d.BringToFront;
      panel1.BringToFront;
      MapOptionsPanel.BringToFront;
    end;

  procedure TMapIsoViewer.TickersTimerTimer(Sender: TObject);
    begin
      if not VoyagerWin.AppMinimise
        then
          begin
            SecondaryText.Tick;
            HintText.Tick;
            LinksMarquee.Tick;
            with URLFrameNotification do
              begin
                if TutorBtn.Visible <> fIsTutor
                  then TutorBtn.Visible := fIsTutor;
                if (FrameTutor.Selected <> Visible)
                  then FrameTutor.Selected := Visible;
              end;
          end;
    end;

procedure TMapIsoViewer.Timer1Timer(Sender: TObject);
  var
    urladvert: string;
begin
// logs.Log('mapiso', 'timer - advert =' + inttostr(LogonHandlerViewer.advert));

 if LogonHandlerViewer.advert = 2 then
  begin
    panel1.Visible:= false;
    timer1.Enabled:= false;
  end;
  if LogonHandlerViewer.advert = 3 then
  begin
     addiff:=now;
     urladvert:= 'http://www.starpeacelive.com/a1/ad.asp';
     webbrowser1.Navigate(urladvert);
     timer1.Interval:= 300000;
     webbrowser1.OleObject.document.body.style.overflowX := 'hidden';
     webbrowser1.OleObject.document.body.style.overflowY := 'hidden';
  end;

end;

procedure TMapIsoViewer.CloseChatClick(Sender: TObject);
    begin
      ChatEditPanel.Visible := false;

      fMasterURLHandler.HandleURL( '?frame_Id=' + tidHandlerName_ChatList + '&frame_Close=yes' );
      fMasterURLHandler.HandleURL( '?frame_Id=' + tidHandlerName_Chat + '&frame_Close=yes' );
      OnResize( self );
    end;

  procedure TMapIsoViewer.ChasedUserClick(Sender: TObject);
    var
      ErrorCode : TErrorCode;
    begin
      fClientView.StopChase( ErrorCode );
    end;

  procedure TMapIsoViewer.CloseMapOptBtnClick( Sender: TObject );
    begin
      MapOptionsPanel.Visible := false;
    end;

  procedure TMapIsoViewer.TabsTabChange(Sender: TObject);
    begin
      //Notebook.PageIndex := Tabs.CurrentTab;
    end;

  type
    TSurfaceData =
      record
        Id     : string;
        Points : array[0..2] of TColorScalePt;
        Style  : TSurfaceStyle;
      end;
  const
    ZoneData : array[0..9] of TColorScalePt =
      ((value: 0; color: clNone),
       (value: 1; color: clMaroon),
       (value: 2; color: clTeal),
       (value: 3; color: $00BBFFC0),
       (value: 4; color: $0043A34F),
       (value: 5; color: $001E4823),
       (value: 6; color: $0088D9D7),
       (value: 7; color: $00D87449),
       (value: 8; color: $00FFFFFF),
       (value: 9; color: $00884439));
  const
    clQuasiBlack = $01010101;
  const
     SurfaceData : array[0..44] of TSurfaceData =
       ((Id : 'Beauty'; Points : ((value: -3; color: clRed),(value: 0; color: clQuasiBlack),(value: 3; color: clLime)); Style : ssOver),
        (Id : 'hiPeople'; Points : ((value: 0; color: clQuasiBlack),(value: 0.1; color: clTeal),(value: 0.1; color: clTeal)); Style : ssOver),
        (Id : 'midPeople'; Points : ((value: 0; color: clQuasiBlack),(value: 0.2; color: clTeal),(value: 0.2; color: clTeal)); Style : ssOver),
        (Id : 'loPeople'; Points : ((value: 0; color: clQuasiBlack),(value: 0.3; color: clTeal),(value: 0.3; color: clTeal)); Style : ssOver),
        (Id : 'QOL'; Points : ((value: 0; color: clQuasiBlack),(value: 1; color: clBlue),(value: 1; color: clBlue)); Style : ssOver),
        (Id : 'Crime'; Points : ((value: -1; color: clBlue),(value: 0; color: clQuasiBlack),(value: 1; color: clRed)); Style : ssOver),
        (Id : 'Pollution'; Points : ((value: -1; color: clLime),(value: 0; color: clQuasiBlack),(value: 1; color: clRed)); Style : ssOver),
        (Id : 'BAP'; Points : ((value: 0; color: clQuasiBlack),(value: 1; color: clPurple),(value: 1; color: clPurple)); Style : ssOver),
        {(Id : 'FreshFood'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'ElabFood'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Clothes_Market'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'HouseHoldingAppliances'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Cars_Market'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Restaurant'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Bar'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Toys'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Drugs'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Movie'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Gasoline'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Computers'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Furniture'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Books'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'CDs'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
        (Id : 'Funeral'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver)}
        (Id : 'Trouser_Market'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'bakery'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'shoes_Market'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'fruitpie_Market'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'cutlery'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'tablecloth'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'freshbuns'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'glasses'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'Plates'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'smallcar'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'tv'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'tie'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'suit'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'underwear'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'hats'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'Socks'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'lingerie'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'scarves'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'Leatherpants'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'sportscar'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'mp3player'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'printer'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'camcorder'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'hoover'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'dvdplayer'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'kettle'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'microwave'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'toaster'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'cooker'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'motorbike'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'mphone'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'carwashkit'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'polish'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'airfreshener'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'fluffydice'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'humvee'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver),
(Id : 'pc'; Points : ((value: 0; color: clQuasiBlack),(value: 0.5; color: clYellow),(value: 0.5; color: clYellow)); Style : ssOver) );
 {

}

  const
    MaxTowns = 1000;
  var
    TownData : array[0..MaxTowns - 1] of TColorScalePt;

  procedure TMapIsoViewer.ShowSurface( Id : integer );

    procedure PushButton( Id : integer );
      begin
        OverlaySel.ItemIndex := Id;
      end;

    var
      ErrorCode : TErrorCode;
    begin
      if Id <> fLastSurfaceId
        then
          begin
            fLastSurfaceId := Id;
            if Id <> 0
              then fClientView.SayThis( fClientView.getUserName, GetFormattedLiteral('Literal422', [OverlaySel.Items[Id]]), ErrorCode );
            ZonesTool.Selected := Id = 1;
            try
              if Id = 1
                then fMapView.ShowSurface( tidSurface_Zones, ssUnder, Slice(ZoneData, 10) )
                else
                  if Id = 2
                    then fMapView.ShowSurface( tidSurface_Towns, ssUnder, Slice(TownData, MaxTowns) )
                    else
                      begin
                        if Id > 0
                          then
                            with SurfaceData[Id - 3] do
                              fMapView.ShowSurface( Id, Style, Slice(Points, 3) ) // >> transparent should be selectable
                          else fMapView.HideCurrentSurface;
                      end;
              PushButton( Id );
            except
            end;
          end;
    end;

  procedure TMapIsoViewer.SetCurrObj( Obj : integer; x, y : integer );
    begin
      LinkAdd.Enabled := Obj <> 0;
      fCurrObj  := Obj;
      fCurrX    := x;
      fCurrY    := y;
      currx     := x;
      curry     := y;
    end;

  procedure TMapIsoViewer.InitLinks;
    begin
      if not fUpdatingLinks
        then
          begin
            fUpdatingLinks := true;
            fValidLinks := false;
            Links.Items.Clear;
             Fork(threadedInitLinks, priNormal, [0]);
          end;
    end;

  procedure TMapIsoViewer.AddLink( name : string; x, y : integer; select : boolean );
    var
      link : string;
    begin
      link := ComposeLinkCookie( name, x, y, select );
      Fork( threadedAddLink, priNormal, [link, name] );
    end;

  procedure TMapIsoViewer.DelLink( index : integer );
    var
      cookieIndex : integer;
    begin
      try
        cookieIndex := PLinkData(Links.Items[index].Data).index;
        Fork( threadedDelLink, priNormal, [cookieIndex, index] );
      except
      end;
    end;

  function TMapIsoViewer.getCookieValue(cookie : string) : string;
    var
      i : integer;
    begin
      i := system.pos('=', cookie);
      if i <> 0
        then result := system.copy(cookie, succ(i), length(cookie) - i)
        else result := '';
    end;

  function TMapIsoViewer.getCookieIndex(cookie : string) : integer;
    var
      aux : string;
      i   : integer;
    begin
      i := succ(length('Link')); //=5
      CompStringsParser.SkipChars(cookie, i, ['0'..'9']);
      aux := system.copy(cookie, succ(length('Link')), i - succ(length('Link')));
      if aux <> ''
        then result := StrToInt(aux)
        else result := -1;
    end;

  procedure TMapIsoViewer.threadedInitLinks( const parms : array of const );
    const
      tidLink      = 'Link';
      tidLinkCount = 'LinkCount';
    var
      count, i  : integer;
      ErrorCode : integer;
      aux       : string;
      idx       : integer;
      linkdata  : TStringList;
    begin
      try
        try
          aux := fClientView.GetCookie('', ErrorCode);
        except
          aux := '';
        end;
        if (aux <> '') and (ErrorCode = NOERROR)
          then
            begin
              linkData := TStringList.Create;
              linkData.Text := aux;
              linkData.Values[tidLinkCount] := '';
              for i := pred(linkData.Count) downto 0 do
                begin
                  aux := linkData[i];
                  if (aux = '') or (system.pos(tidLink, aux) <> 1)
                    then linkData.Delete(i);
                end;
              count := linkData.Count;
              if count > 0
                then
                  begin
                    for i := 0 to pred(count) do
                      begin
                        idx := getCookieIndex(linkData[i]);
                        aux := getCookieValue(linkData[i]);
                        linkData.Delete(i);
                        if aux <> ''
                          then linkData.InsertObject(i, aux, TObject(idx));
                      end;
                    Join(syncInitLinks, [linkData]);
                    fValidLinks := true;
                  end
                else
                  begin
                    fValidLinks := false;
                    Join(syncInitLinks, []);
                    fUpdatingLinks := false;
                  end;
            end
          else
            begin
              fValidLinks := false;
              fUpdatingLinks := false;
            end;
      except
      end;
    end;
{
  procedure TMapIsoViewer.threadedInitLinks( const parms : array of const );
    var
      count, i  : integer;
      link      : string;
      ErrorCode : integer;
      aux       : string;
      linkdata  : TStringList;
    begin
      try
        aux := fClientView.GetCookie('LinkCount', ErrorCode);
        if (aux <> '') and (ErrorCode = NOERROR)
          then count := StrToInt(aux)
          else count := 0;
        if ErrorCode = NOERROR
          then
            begin
              linkData := TStringList.Create;
              try
                for i := 0 to pred(count) do
                  begin
                    link := fClientView.GetCookie( 'Link' + IntToStr(i), ErrorCode );
                    if (link <> '') and (ErrorCode = NOERROR)
                      then linkData.AddObject( link, TObject(i) );
                  end;
                fValidLinks := true;
                Join( syncInitLinks, [linkData, count] );
              except
                fValidLinks := false;
                linkData.Free;
              end;
            end;
      except
      end;
    end;
}

  procedure TMapIsoViewer.syncInitLinks( const parms : array of const );
    var
      linkData : TStringList;
      i        : integer;
    begin
      try
        Links.Items.BeginUpdate;
        if length(parms)>0
          then
            try
              linkData := parms[0].vPointer;
              for i := 0 to pred(linkData.Count) do
                syncAddLink([linkData[i], integer(linkData.Objects[i]), false]);
            finally
            end;
        OnResize( self );
        Links.Items.EndUpdate;
      except
      end;
      fUpdatingLinks := false;
    end;

  procedure TMapIsoViewer.threadedAddLink( const parms : array of const );
    var
      link      : string;
      name      : string;
      count     : integer;
      ErrorCode : integer;
    begin
      link := parms[0].vPchar;
      name := parms[1].vPchar;
      // replace this code..
      try
        try
          count := StrToInt(fClientView.GetCookie( 'LinkCount', ErrorCode ));
        except
          count := 0;
        end;
        if ErrorCode = NOERROR
          then
            begin
              fClientView.SetCookie( 'Link' + IntToStr(count), link, ErrorCode );
              if ErrorCode = NOERROR
                then
                  begin
                    fClientView.SetCookie( 'LinkCount', IntToStr(count + 1), ErrorCode );
                    if ErrorCode = NOERROR
                      then Join( syncAddLink, [link, count, true] );
                  end;
            end;
      except
      end;
    end;

  procedure TMapIsoViewer.syncAddLink( const parms : array of const );
    var
      link     : string absolute parms[0].vPchar;
      LinkName : string;
      x, y     : integer;
      select   : boolean;
      LinkData : PLinkData;
      resize   : boolean;
    begin
      resize := parms[2].vBoolean;
      try
        if ParseLinkCookie( link, LinkName, x, y, select )
          then
            begin
              new( LinkData );
              LinkData.x      := x;
              LinkData.y      := y;
              LinkData.select := select;
              LinkData.index  := parms[1].vInteger;
              with Links.Items.Add do
                begin
                  Caption    := LinkName;
                  ImageIndex := integer(select);
                  Data       := LinkData;
                end;
            end;
        if resize
          then OnResize( self );
      except
      end;
    end;

  procedure TMapIsoViewer.threadedDelLink( const parms : array of const );
    var
      cookieindex : integer absolute parms[0].vInteger;
      index       : integer;
      count       : integer;
      ErrorCode   : integer;
    begin
      index := parms[1].vInteger;
      try
        fClientView.SetCookie( 'Link' + IntToStr(cookieindex), '', ErrorCode );
        if ErrorCode = NOERROR
          then
            begin
              count := StrToInt(fClientView.GetCookie( 'LinkCount', ErrorCode ));
              if ErrorCode = NOERROR
                then
                  begin
                    // fClientView.SetCookie( 'LinkCount', IntToStr(count - 1), ErrorCode );
                    if ErrorCode = NOERROR
                      then Join( syncDelLink, [index] );
                  end;
            end;
      except
      end;
    end;

  procedure TMapIsoViewer.threadedDelLinks( const parms : array of const );
    var
      list : Tlist absolute parms[0].VObject;
      i : integer;
      ErrorCode: integer;
    begin
      try
        for i:=pred(list.count) downto 0 do
          begin
            with PLinkData(list.Items[i])^ do
              begin
                fClientView.SetCookie( 'Link' + IntToStr(index), '', ErrorCode );
                if ErrorCode<>NOERROR
                  then list.Delete(i);
              end;
            end;
        if list.Count > 0
          then Join( syncDelLinks, [list] )
          else list.Free;
      except
        list.Free;
      end;
    end;

  procedure TMapIsoViewer.syncDelLink( const parms : array of const );
    var
      index : integer absolute parms[0].vInteger;
      dd : integer;
    begin
      if (index<Links.Items.Count)
        then
          begin
            dispose( PLinkData(Links.Items[index].Data) );
            Links.Items.Delete( index );
          end
        else dd := 5;
      OnResize( self );
    end;

  procedure TMapIsoViewer.syncDelLinks( const parms : array of const );
    var
      list : Tlist absolute parms[0].VObject;
      i : integer;
      j : integer;
      data     : pointer;
    begin
      for i:=pred(list.Count) downto 0 do
        with Links.Items do
          begin
            data := list.Items[i];
            j := pred(Links.Items.Count);
            while (Links.Items[j].Data <> data) and (j>=0) do
              dec(j);
            if j>=0
              then Delete(j);
            dispose(PLinkData(Data));
          end;

      list.Free;
      OnResize(self);
    end;

  procedure TMapIsoViewer.LoosesAlarmClick(Sender: TObject);
    begin
      if LoosesAlert.Checked
        then fMapView.ShowLoosingFacilities( fClientView.getTycoonUId )
        else fMapView.HideLoosingFacilities;
      fMapView.Refresh;
    end;

  procedure TMapIsoViewer.ShowSurfaceBtnClick(Sender: TObject);
    begin
      ShowSurface( TControl(Sender).Tag );
    end;


  procedure TMapIsoViewer.trainsClick(Sender: TObject);
    var
      Info : TMsgAnswerVehicleArrayInfo;
    begin
      Info.ActorPoolId := poolIdTrains;
      fMasterURLHandler.HandleEvent( evnAnswerVehicleArray, Info );
      {
      Info.VehicleArray.RegisterNotificationProc( SimpleTrains.OnVehicleArrayChanged );
      if trains.Selected
        then SimpleTrains.Show
        else SimpleTrains.Hide;
      }
    end;

  procedure TMapIsoViewer.LinksBtnClick(Sender: TObject);
    begin
      {
      if not LinksPanel.Visible
        then
          begin
            LinksPanel.Visible := true;
            LinksPanel.BringToFront;
            if not fValidLinks
              then InitLinks;
          end
        else
          begin
            LinksPanel.Visible := false;
            LinksBtn.BringToFront;
          end;
      OnResize( self );
      }
    end;

  procedure TMapIsoViewer.LinkAddClick(Sender: TObject);
    begin
      Fork( threadedGetLinkData, priNormal, [fCurrObj, fCurrX, fCurrY] );
    end;

  procedure TMapIsoViewer.threadedGetLinkData( const parms : array of const );
    var
      Obj, x, y : integer;
      StText    : string;
      Name      : string;
      Desc      : string;
      ErrorCode : TErrorCode;
      p         : integer;
    begin
      try
        Obj    := parms[0].vInteger;
        x      := parms[1].vInteger;
        y      := parms[2].vInteger;
        StText := ReplaceStr( fClientView.ObjectStatusText( sttMain, Obj, ErrorCode ), #10#13, '|' );
        if ErrorCode = NOERROR
          then
            begin
              p    := 1;
              Name := GetNextStringUpTo( StText, p, '|' );
              inc( p );
              Desc := GetNextStringUpTo( StText, p, '|' );
              if uppercase(Name) = 'TOWN HALL'
                then Name := Desc;
              Join( syncGetLinkData, [Name, x, y] );
            end
          else fClientView.SayThis( '', IntToStr(ErrorCode), ErrorCode );
      except
      end;
    end;

  procedure TMapIsoViewer.syncGetLinkData( const parms : array of const );
    var
      Name : string;
      x, y : integer;
    begin
      try
        Name := parms[0].vPchar;
        x    := parms[1].vInteger;
        y    := parms[2].vInteger;
        AddLink( Name, x, y, true );
      except
      end;
    end;

  procedure TMapIsoViewer.threadedGetStatusTexts( const parms : array of const );
    var
      Data      : PLinkData absolute parms[0].vPointer;
      Obj       : integer;
      Main      : string;
      Sec       : string;
      Hint      : string;
      Text      : string;
      ErrorCode : TErrorCode;
    begin
      try
        Obj := fClientView.ObjectAt( Data.x, Data.y, ErrorCode );
        if ErrorCode = NOERROR
          then
            begin
              Main := ReplaceStr( fClientView.ObjectStatusText( sttMain, Obj, ErrorCode ), #10#13, ' ' );
              Sec  := fClientView.ObjectStatusText( sttSecondary, Obj, ErrorCode );
              Hint := fClientView.ObjectStatusText( sttHint, Obj, ErrorCode );
              Text := Main + ' ' + Sec + ' ' + Hint;
              Join( syncGetStatusTexts, [Text, Data] );
            end;
      except
      end;
    end;

  procedure TMapIsoViewer.syncGetStatusTexts( const parms : array of const );
    var
      text : string;
      data : PLinkData;
    begin
      text := parms[0].vPchar;
      data := parms[1].vPointer;
      if (Links.Selected <> nil) and (Links.Selected.data = data)
        then LinksMarquee.Caption := text;
    end;

  procedure TMapIsoViewer.threadedRenameLink( const parms : array of const );
    var
      Name      : string;
      Data      : PLinkData;
      link      : string;
      ErrorCode : TErrorCode;
    begin
      try
        Name := parms[0].vPchar;
        Data := parms[1].vPointer;
        link := ComposeLinkCookie( Name, Data.x, Data.y, Data.select );
        fClientView.SetCookie( 'Link' + IntToStr(Data.index), link, ErrorCode );
      except
      end;
    end;

  procedure TMapIsoViewer.threadedGetNearestTownHall( const parms : array of const );
    var
      xTown     : integer;
      yTown     : integer;
      LastMapX  : integer;
      LastMapY  : integer;
      ErrorCode : TErrorCode;
    begin
      try
        LastMapX  := parms[0].vInteger;
        LastMapY  := parms[1].vInteger;
        fClientView.GetNearestTownHall( LastMapX, LastMapY, xTown, yTown, ErrorCode );
        if ErrorCode = NOERROR
          then Join( syncGetNearestTownHall, [xTown, yTown] );
      except
      end;
    end;

  procedure TMapIsoViewer.syncGetNearestTownHall( const parms : array of const );
    var
      xTown : integer;
      yTown : integer;
    begin
      try
        xTown := parms[0].vInteger;
        yTown := parms[1].vInteger;
        fMapView.MoveAndSelect( yTown, xTown );
      except
      end;
    end;

  procedure TMapIsoViewer.OnMapMovedTo( y, x : integer );
    var
      H : THistoryItem;
    begin
      fLastMapX := x;
      fLastMapY := y;
      if not fMovingInHistory
        then
          begin
            if fHistory.Count > 0
              then H := THistoryItem(fHistory[pred(fHistory.Count)])
              else H := nil;
            if (H = nil) or (abs(H.x - x) > (4 - fMapView.ZoomLevel)*30) or (abs(H.y - y) > (4 - fMapView.ZoomLevel)*30)
              then
                begin
                  H := THistoryItem.Create;
                  H.x := x;
                  H.y := y;
                  while fHistoryIndex + 1 <= pred(fHistory.Count) do
                    fHistory.AtDelete( fHistoryIndex + 1 );
                  fHistory.Insert( H );
                  while fHistory.Count > 100 do
                    fHistory.AtDelete( 0 );
                  fHistoryIndex := pred(fHistory.Count);
                end;
            btBack.Enabled := fHistoryIndex > 0;
            btNext.Enabled := fHistoryIndex < pred(fHistory.Count);
          end;
    end;

  procedure TMapIsoViewer.LinksChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    var
      b : boolean;
    begin
      ListView_SetColumnWidth(Links.Handle, 0, Links.Width);
      b := Links.Selected <> nil;
      LinkDel.Enabled := b;
      FramedButton12.Enabled := b;
      if b
        then
          begin
            LinksMarquee.Caption := GetLiteral('Literal424');
            Fork( threadedGetStatusTexts, priNormal, [Links.Selected.Data] );
          end
        else LinksMarquee.Caption := GetLiteral('Literal425');
    end;

  procedure TMapIsoViewer.LinkDelClick(Sender: TObject);
    var
      i : integer;
      list : TList;
    begin
      if Links.Selected <> nil
        then
          begin
            list := TList.create;
            for i := pred(Links.Items.Count) downto 0 do
              if Links.Items[i].Selected
                then list.Add(Links.Items[i].Data); // DelLink( i );
            if list.Count>0
              then
                try
                  Fork( threadedDelLinks, priNormal, [list] );
                except
                end
              else list.Free;
          end;
    end;

  procedure TMapIsoViewer.LinksDblClick(Sender: TObject);
    var
      Data : PLinkData;
    begin
      if Links.Selected <> nil
        then
          begin
            Data := PLinkData(Links.Selected.Data);
            with Data^ do
              begin
                if select
                  then
                    begin
                      fMapView.MoveAndSelect( y, x );
                    end
                  else
                    begin
                      fMapView.MoveTo( y, x );
                    end;
              end;
          end;
    end;

  procedure TMapIsoViewer.LinksEdited(Sender: TObject; Item: TListItem; var S: String);
    begin
      Fork( threadedRenameLink, priNormal, [S, Item.Data] );
    end;

  procedure TMapIsoViewer.Button1Click(Sender: TObject);
    begin
      fMapView.ImageSuit := TComponent(Sender).Tag;
    end;

  procedure TMapIsoViewer.OverlaySelChange(Sender: TObject);
    begin
      ShowSurface( OverlaySel.ItemIndex );
    end;

  procedure TMapIsoViewer.LoosesAlertClick(Sender: TObject);
    begin
      if LoosesAlert.Checked
        then fMapView.ShowLoosingFacilities( fClientView.getTycoonUId )
        else fMapView.HideLoosingFacilities;
      fMapView.Refresh;
    end;

  procedure TMapIsoViewer.SmallMapFrameResize(Sender: TObject);
    begin
      SmallPanelMinus.Left  := SmallMapFrame.Width - SmallPanelMinus.Width;
      SmallPanelMinus.Top   := SmallMapFrame.Height - SmallPanelMinus.Height;
      SmallPanelPlus.Left   := 0;
      SmallPanelPlus.Top    := SmallMapFrame.Height - SmallPanelPlus.Height;
    end;

  procedure TMapIsoViewer.SmallMapLeftBorderMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
      fMapResize := true;
      fLastX     := SmallMapLeftBorder.ClientOrigin.x + x;
      fLastY     := SmallMapLeftBorder.ClientOrigin.y + y;
      if fLastX<MinSmallMap
        then fLastX := MinSmallMap;
      if fLastY<MinSmallMap
        then fLastY := MinSmallMap;

      MouseCapture := true;
      SmallMapFrame.BringToFront;
    end;

  procedure TMapIsoViewer.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    var
      dx : integer;
      dy : integer;
    begin
      if fMapResize
        then
          begin
            dx := (ClientOrigin.x + x) - fLastX;
            dy := (ClientOrigin.y + y) - fLastY;
            if SmallMapFrame.Left + dx < Width - 120
              then
                begin
                  SmallMapFrame.Left   := SmallMapFrame.Left + dx;
                  SmallMapFrame.Width  := Width - SmallMapFrame.Left;
                end;
            if SmallMapFrame.Top + dy < Height - 80
              then
                begin
                  SmallMapFrame.Top    := SmallMapFrame.Top + dy;
                  SmallMapFrame.Height := Height - SmallMapFrame.Top - StatusPanel.Height;
                  if ChatEditPanel.Visible
                    then SmallMapFrame.Height := SmallMapFrame.Height - ChatEditPanel.Height;
                end;
            fLastX := ClientOrigin.x + x;
            fLastY := ClientOrigin.y + y;
          end;
    end;

  procedure TMapIsoViewer.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
      fMapResize := false;
      MouseCapture := false;
      OnResize( self );
    end;

  procedure TMapIsoViewer.btBackClick(Sender: TObject);
    var
      H : THistoryItem;
    begin
      if fHistoryIndex > 0
        then dec( fHistoryIndex );
      H := THistoryItem(fHistory[fHistoryIndex]);
      fMovingInHistory := true;
      try
        fMapView.MoveTo( H.y, H.x );
      finally
        fMovingInHistory := false;
      end;
      btBack.Enabled := fHistoryIndex > 0;
      btNext.Enabled := fHistoryIndex < pred(fHistory.Count);
    end;

  procedure TMapIsoViewer.btNextClick(Sender: TObject);
    var
      H : THistoryItem;
    begin
      if fHistoryIndex < pred(fHistory.Count)
        then inc( fHistoryIndex );
      H := THistoryItem(fHistory[fHistoryIndex]);
      fMovingInHistory := true;
      try
        fMapView.MoveTo( H.y, H.x );
      finally
        fMovingInHistory := false;
      end;
      btBack.Enabled := fHistoryIndex > 0;
      btNext.Enabled := fHistoryIndex < pred(fHistory.Count);
    end;

  procedure TMapIsoViewer.btTownHallClick(Sender: TObject);
    begin
      Fork( threadedGetNearestTownHall, priNormal, [fLastMapX, fLastMapY] );
    end;

  procedure TMapIsoViewer.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
      case Key of
        VK_F10:
          MessageBeep(0);
      end;
    end;

procedure TMapIsoViewer.FrameTutorClick(Sender: TObject);
  begin
    if (URLFrameNotification<>nil)
      then
        with URLFrameNotification do
          begin
            FrameTutor.Selected := not FrameTutor.Selected;
            Visible := FrameTutor.Selected;
            if Visible
              then
                begin
                  FormStyle := fsStayOnTop;
                  RefressNavigator;
                end;
          end
      else FrameTutor.Visible := false;
  end;

procedure InitTownColors;
  var
    i : integer;
    r, g, b : byte;
  begin
    for i := 0 to MaxTowns - 1 do
      begin
        TownData[i].value := i;
        r := 64 + round(random*192);
        g := 64 + round(random*192);
        b := 64 + round(random*192);
        TownData[i].color := r shl 16 + g shl 8 + b;
      end;
  end;

procedure TMapIsoViewer.panel3dbutClick(Sender: TObject);
var xl1:string;
begin
{if view3d.Visible = false then
  begin
  glhf.MaxPoolSize:=8*1024*1024;
  view3d.Buffer.BackgroundColor:=clWhite;
  xl1:=ExtractFilePath(Application.ExeName) + 'cache\misc\land.bmp';
  GLMaterialLibrary1.Materials[0].Material.Texture.Image.LoadFromFile(xl1);
  glterrainrenderer1.MaterialLibrary:=GLMaterialLibrary1;
  glterrainrenderer1.TileSize:=16;
  glterrainrenderer1.TilesPerTexture:=256/glterrainrenderer1.TileSize;
  glhf.Picture.LoadFromFile(localcachemanager.f3dmappath);
  glterrainrenderer1.Material.Texture.Disabled:=false;
  glterrainrenderer1.Material.Texture.ApplyMappingMode;
  glterrainrenderer1.StructureChanged;
  //glterrainrenderer1.HeightDataSource.MarkDirty;
  ChatMsgComposer.Text := localcachemanager.f3dmappath + xl1; //file location checking
  GLCadencer1.Enabled:=true;
  //view3d.Invalidate;

  view3d.Visible:= true;

  end
  else
    begin
    view3d.Visible :=false;
    GLCadencer1.Enabled:=false;
    end;
if view3d.Visible = false then panel3dbut.Selected:= false else  panel3dbut.Selected:= true; }
end;


procedure TMapIsoViewer.GLSceneViewerBeforeRender(Sender: TObject);
begin
  //GLLensFlare.PreRender(Sender as TGLSceneBuffer);
end;

procedure TMapIsoViewer.view3dMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // view3d.SetFocus;
  // mx:=x;
  // my:=y;
end;

procedure TMapIsoViewer.view3dMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   // if ssLeft in Shift then begin
   //   GLCamera1.MoveAroundTarget((my-y)*0.5, (mx-x)*0.5);
   //   mx:=x;
   //   my:=y;
    //end;
    {if ssRight in Shift then begin
      //GLDummyCube1.Translate(-Y*0.5, 0, -X*0.5);
      GLDummyCube1.Position.X := GLDummyCube1.Position.X + x;
      GLDummyCube1.Position.z := GLDummyCube1.Position.z + y;
      end;
    if ssAlt in Shift then begin
      FCamHeight:=FCamHeight+Y*50;
    end; }
    //if ssCtrl in Shift then begin
    //  GLCamera1.MoveAroundTarget((my-y)*0.5, (mx-x)*0.5);
    //  mx:=x;
   //   my:=y;
  //  end;
end;

procedure TMapIsoViewer.WebBrowser1BeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  if SecondsBetween(addiff,Now)>10 then
  begin
     Cancel := True;
     webbrowser1.Stop;
     ShellExecute(0, 'OPEN', PChar(string(URL)), '', '', SW_SHOWNORMAL);
  end;
end;

procedure TMapIsoViewer.timer3dTimer(Sender: TObject);
begin
 // info3d.Caption:=view3d.FramesPerSecondText;
 //  view3d.ResetPerformanceMonitor;
end;

procedure TMapIsoViewer.PercentEdit1Change(Sender: TObject);
begin
//change distance
//GLCamera1.DepthOfView := Sqr(PercentEdit1.Value)+1500;//for now
end;

procedure TMapIsoViewer.PercentEdit2Change(Sender: TObject);
begin
//change clod
//GLTerrainRenderer1.CLODPrecision := 2500 - Sqr(PercentEdit2.Value) + 1; //for now

end;

function tmapisoviewer.paiduser;
begin
      panel1.Visible:= false;
    timer1.Enabled:= false;
  result:='done';
end;

procedure TMapIsoViewer.GLCadencer1Progress(Sender: TObject;
  const deltaTime, newTime: Double);
  var
   speed : Single;
begin
  {view3d.Invalidate;
  if IsKeyDown(VK_SHIFT) then
      speed:=5000*deltaTime
   else speed:=50*deltaTime;
   with GLCamera1.Position do begin
      if IsKeyDown(VK_UP) then
         glDummyCube1.Translate(-X*speed, 0, -Z*speed);
      if IsKeyDown(VK_DOWN) then
         glDummyCube1.Translate(X*speed, 0, Z*speed);
      if IsKeyDown(VK_LEFT) then
         glDummyCube1.Translate(-Z*speed, 0, X*speed);
      if IsKeyDown(VK_RIGHT) then
         glDummyCube1.Translate(Z*speed, 0, -X*speed);
      if IsKeyDown(VK_PRIOR) then
         FCamHeight:=FCamHeight+10*speed;
      if IsKeyDown(VK_NEXT) then
         FCamHeight:=FCamHeight-10*speed;
      //if IsKeyDown(VK_ESCAPE) then Close;
   end;
   // don't drop through terrain!
   with glDummyCube1.Position do
      Y:=glTerrainRenderer1.InterpolatedHeight(AsVector)+FCamHeight;  }
end;



initialization

  InitTownColors;

end.



