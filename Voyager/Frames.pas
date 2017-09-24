unit Frames;

interface

  uses
    VoyagerInterfaces, Classes, Collection, Controls, ExtCtrls,logs;

  const
    HistoryLimit = 1000;

  type
    TFrameId = string;

  type
    TTaskReport =
      class
        public
          constructor Create( aName, aDesc : string );
        private
          fName     : string;
          fDesc     : string;
          fProgress : integer;
        public
          property Name : string read fName;
          property Desc : string read fDesc;
          property Progress : integer read fProgress;
      end;

    TTaskCarrier =
      class
        public
          constructor Create( aCarrier : IURLHandler );
          destructor  Destroy; override;
        private
          fCarrier      : IURLHandler;
          fTasks        : TCollection;
          fPendingClose : boolean;
        private
          function GetTask( name : string ) : TTaskReport;
        public
          property Carrier : IURLHandler read fCarrier;
          property Task[name : string] : TTaskReport read GetTask;
          property Tasks : TCollection read fTasks;
      end;

  type
    TExclusionReport =
      class
        public
          constructor Create( anExcluder : string );
          destructor  Destroy; override;
        private
          fExcluder   : string;
          fExclusions : TStringList;
        public
          property Excluder   : string      read fExcluder;
          property Exclusions : TStringList read fExclusions;
      end;

  type
    // Classes defined:

    TMetaFrame = class;
    TFrame     = class;
    TFrameSet  = class;

    
    // TMetaFrame is a wrapper to a IMetaURLHandler. It contains an
    // IMetaURLHandler and also implements it.

    TMetaFrame =
      class( TInterfacedObject, IMetaURLHandler )
        public
          constructor Create( aMetaURLHandler : IMetaURLHandler );
          destructor  Destroy; override;
        private
          fMetaURLHandler : IMetaURLHandler;
        private
          function getName    : string;
          function getOptions : TURLHandlerOptions;
        public
          property Name    : string             read GetName;
          property Options : TURLHandlerOptions read GetOptions;
        private
          function getCanHandleURL( URL : TURL ) : THandlingAbility;
        public
          property CanHandleURL[URL : TURL] : THandlingAbility read getCanHandleURL;
        private
          function Instantiate : IURLHandler;
        public
          function InstantiateFrame( FrameId : TFrameId ) : TFrame;
      end;


    // TFrame is a wrapper to a IURLHandler. It contains a IURLHandler and also
    // implements it.

    TFrame =
      class( TInterfacedObject, IURLHandler )
        public
          constructor Create( anId : TFrameId; aMetaFrame : TMetaFrame; aURLHandler : IURLHandler );
          destructor  Destroy; override;
        private
          fId         : TFrameId;
          fMetaFrame  : TMetaFrame;
          fURLHandler : IURLHandler;
        private
          function getControl : TControl;
          procedure setMasterURLHandler( const URLHandler : IMasterURLHandler );
        public
          property Id        : TFrameId   read fId;
          property MetaFrame : TMetaFrame read fMetaFrame;
          property Control   : TControl   read getControl;
        public
          function HandleURL( URL : string ) : TURLHandlingResult;
          function HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
      end;


    // A FrameSet allows to execute URLs in different frames, according to
    // the MetaFrame information registered to it. The controls that are
    // associated with each frame are inserted in the FrameSet's control.
    // The FrameSet also implements IMasterURLHandler.

    TNavigationDir = (navBack, navForward);

    THistoryRecord =
      class
        private
          BackCount    : integer;
          ForwardCount : integer;
          HandlerId    : string;
      end;

    TFrameSet =
      class( TInterfacedObject, IMasterURLHandler )
        public
          constructor Create;
          destructor  Destroy; override;
          procedure   Clear; //.rag
        private
          fFrames     : TCollection;
          fMetaFrames : TCollection;
          fFrameCache : TCollection;
        private
          function getMetaFrameByName( Name : string ) : TMetaFrame;
          function getFrameById( Id : TFrameId ) : TFrame;
          function getFrameByHandler( Handler : IURLHandler ) : TFrame;
          function getCachedFrame( Id : TFrameId ) : TFrame;
        public
          property MetaFramesByName[Name    : string]      : TMetaFrame read getMetaFrameByName;
          property FramesById      [Id      : TFrameId]    : TFrame     read getFrameById;
          property FramesByHandler [Handler : IURLHandler] : TFrame     read getFrameByHandler;
        protected
          property CachedFrames[Id : TFrameId] : TFrame read getCachedFrame;
        public
        private
          fContainerPanel : TPanel;
        private
          function getControl : TControl;
        public
          property Control : TControl read GetControl;
        private
          function getURLIsLocal( URL : TURL ) : boolean;
        public
          property URLIsLocal[URL : TURL] : boolean read getURLIsLocal;
        public
          function HandleURL( URL : TURL ) : TURLHandlingResult;
          function HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
        private
          function  RegisterMetaHandler( const aMetaURLHandler : IMetaURLHandler ) : TMetaHandlerRegistrationResult;
          procedure RegisterDefaultHandler( Handler : string );
          procedure RegisterExclusion( Excluder, ToExclude : string; mutual : boolean );
          procedure setMasterURLHandler( const URLHandler : IMasterURLHandler );
          procedure ReportNavigation( const Handler : IURLHandler; URL : TURL; localBack, localForward : boolean );
        private
          fMasterURLHandler : IMasterURLHandler;
          fDefaultHandler   : string;
        private
          fNavHistory   : TStringList;
          fNavInHistory : boolean;
          fPosInHistory : integer;
        private
          function  GoBack : TURLHandlingResult;
          function  GoForward : TURLHandlingResult;
          procedure InternalNavigation( HistRec : THistoryRecord; Direction : TNavigationDir );
        private
          fTasks      : TCollection;
          fExclusions : TCollection;
        protected
          function GetTaskCarrier( Handler : IURLHandler ) : TTaskCarrier;
          function GetExclusions( Handler : string ) : TExclusionReport;
          function Excludes( Excluder, ToExclude : string ) : boolean;
      end;

  const
    htmlAction_GoBack      = 'GOBACK';
    htmlAction_GoForward   = 'GOFORWARD';
    htmlAction_Refresh     = 'REFRESH';
    htmlAction_InternalNav = 'INTERNALNAV';
    htmlParm_NavBack       = 'nav_Back';
    htmlParm_NavForward    = 'nav_Forward';

implementation

  uses
    SysUtils, Graphics, URLParser, VoyagerEvents, Windows, Forms, VCLUtils;


  // TTaskReport

  constructor TTaskReport.Create( aName, aDesc : string );
    begin
      inherited Create;
      fName := aName;
      fDesc := aDesc;
    end;


  // TTaskCarrier

  constructor TTaskCarrier.Create( aCarrier : IURLHandler );
    begin
      inherited Create;
      fCarrier := aCarrier;
      fTasks   := TCollection.Create( 0, rkBelonguer );
    end;

  destructor TTaskCarrier.Destroy;
    begin
      fTasks.Free;
      inherited;
    end;

  function TTaskCarrier.GetTask( name : string ) : TTaskReport;
    var
      i : integer;
    begin
      i := 0;
      while (i < fTasks.Count) and (TTaskReport(fTasks[i]).Name <> name) do
        inc( i );
      if i < fTasks.Count
        then result := TTaskReport(fTasks[i])
        else result := nil;
    end;


  // TExclusionReport

  constructor TExclusionReport.Create( anExcluder : string );
    begin
      inherited Create;
      fExcluder   := anExcluder;
      fExclusions := TStringList.Create;
    end;

  destructor TExclusionReport.Destroy;
    begin
      fExclusions.Free;
      inherited;
    end;


  // TMetaFrame

  constructor TMetaFrame.Create( aMetaURLHandler : IMetaURLHandler );
    begin
      inherited Create;
      fMetaURLHandler := aMetaURLHandler;
    end;

  destructor TMetaFrame.Destroy;
    begin
      inherited;
    end;

  function TMetaFrame.getName : string;
    begin
      result := fMetaURLHandler.getName;
    end;

  function TMetaFrame.getOptions : TURLHandlerOptions;
    begin
      result := fMetaURLHandler.getOptions;
    end;

  function TMetaFrame.getCanHandleURL( URL : TURL ) : THandlingAbility;
    begin
      result := fMetaURLHandler.getCanHandleURL( URL );
    end;

  function TMetaFrame.Instantiate : IURLHandler;
    begin
      result := fMetaURLHandler.Instantiate;
    end;

  function TMetaFrame.InstantiateFrame( FrameId : TFrameId ) : TFrame;
    begin
      result := TFrame.Create( FrameId, self, Instantiate );
    end;


  // TFrame

  constructor TFrame.Create( anId : TFrameId; aMetaFrame : TMetaFrame; aURLHandler : IURLHandler );
    begin
      inherited Create;
      fId         := anId;
      fMetaFrame  := aMetaFrame;
      fURLHandler := aURLHandler;
    end;

  destructor TFrame.Destroy;
    begin
      fURLHandler := nil;
      inherited;
    end;

  function TFrame.getControl : TControl;
    begin
      result := fURLHandler.getControl;
    end;

  procedure TFrame.setMasterURLHandler( const URLHandler : IMasterURLHandler );
    begin
      fURLHandler.setMasterURLHandler( URLHandler );
    end;

  function TFrame.HandleURL( URL : string ) : TURLHandlingResult;
    begin
      try
        result := fURLHandler.HandleURL( URL );
      except
        result := urlError;
      end;
    end;

  function TFrame.HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
    begin
      try
        if fURLHandler<>nil
          then result := fURLHandler.HandleEvent( EventId, info )
          else result := evnError;
        if EventId=evnShutDown
          then fURLHandler := nil;
      except
        result := evnError;
      end;
    end;


  // TFrameSet

  constructor TFrameSet.Create;
    begin
      inherited Create;
      fFrames     := TCollection.Create( 0, rkBelonguer );
      fMetaFrames := TCollection.Create( 0, rkBelonguer );
      fFrameCache := TCollection.Create( 0, rkBelonguer );
      fTasks      := TCollection.Create( 0, rkBelonguer );
      fExclusions := TCollection.Create( 0, rkBelonguer );
      fNavHistory := TStringList.Create;
      fContainerPanel := TPanel.Create( nil );
      with fContainerPanel do
        begin
          Align       := alClient;
          BevelInner  := bvNone;
          BevelOuter  := bvNone;
          Caption     := '';
          Color       := clBlack;
          Ctl3D       := false;
          FullRepaint := false;
        end;
    end;
      
  destructor TFrameSet.Destroy;
    begin
      Clear;
      inherited;
    end;

  procedure TFrameSet.Clear; //.rag
    var
      i : integer;
    begin
      if fFrames<>nil
        then
          with fFrames do  //.rag
            begin
              for i := pred(Count) downto 0 do
                begin
                  TFrame(Items[i]).HandleEvent(evnShutDown, self);
                  AtDelete(i);
                end;
            end;
      if fFrameCache<>nil
        then
          with fFrameCache do  //.rag
            begin
              for i := pred(Count) downto 0 do
                begin
                  TFrame(Items[i]).HandleEvent(evnShutDown, self);
                  AtDelete(i);
                end;
            end;
      FreeAndNil(fFrames);                                                                           
      FreeAndNil(fFrameCache);
      FreeAndNil(fMetaFrames);
      FreeAndNil(fTasks);
      FreeAndNil(fExclusions);
      FreeAndNil(fNavHistory);
      RemoveComponentFreeAndNil(fContainerPanel); //.rag
    end;
      
  function TFrameSet.getMetaFrameByName( Name : string ) : TMetaFrame;
    var
      i : integer;
    begin
      Name := uppercase(Name);
      i := 0;
      while (i < fMetaFrames.Count) and (uppercase(TMetaFrame(fMetaFrames[i]).Name) <> Name) do
        inc( i );
      if i < fMetaFrames.Count                                                             
        then result := TMetaFrame(fMetaFrames[i])
        else result := nil;
    end;
      
  function TFrameSet.getFrameById( Id : TFrameId ) : TFrame;
    var
      i : integer;
    begin
      Id := uppercase(Id);
      i := 0;
      try
        while (i < fFrames.Count) and (uppercase(TFrame(fFrames[i]).Id) <> Id) do
          inc( i );
      if i < fFrames.Count
        then result := TFrame(fFrames[i])
        else result := nil;
      except
        result := nil;
      end;
    end;

  function TFrameSet.getFrameByHandler( Handler : IURLHandler ) : TFrame;
    var
      i : integer;
    begin
      i := 0;
      while (i < fFrames.Count) and (TFrame(fFrames[i]).fURLHandler <> Handler) do
        inc( i );
      if i < fFrames.Count
        then result := TFrame(fFrames[i])
        else result := nil;
    end;
    
  function TFrameSet.getCachedFrame( Id : TFrameId ) : TFrame;
    var
      i : integer;
    begin
      Id := uppercase(Id);
      i := 0;
      while (i < fFrameCache.Count) and (uppercase(TFrame(fFrameCache[i]).Id) <> Id) do
        inc( i );
      if i < fFrameCache.Count
        then result := TFrame(fFrameCache[i])
        else result := nil;
    end;

  function TFrameSet.getControl : TControl;
    begin
      result := fContainerPanel;
    end;

  function TFrameSet.getURLIsLocal( URL : TURL ) : boolean;
    begin
      result := URLParser.GetAnchorData( URLParser.ExtractURL( URL ) ).FrameId = '';
    end;

  function TFrameSet.HandleURL( URL : TURL ) : TURLHandlingResult;

    procedure FillGaps;
      const
        GapRatioMax = 40;
      var
        UsedArea : integer;
        i        : integer;
      begin
        UsedArea := 0;
        for i := 0 to pred(fFrames.Count) do
          with TFrame(fFrames[i]) do
            if Control <> nil
              then inc( UsedArea, Control.Width*Control.Height );
        if (100*UsedArea) div (Screen.Width*Screen.Height) < GapRatioMax
          then HandleURL( '?frame_Id=' + fDefaultHandler + '&frame_Align=client' );
      end;

    procedure CloseFrame( Frame : TFrame; VoidCache : boolean );
      var
        frameName : string;
      begin
        if not (hopNonVisual in Frame.MetaFrame.Options) and (Frame.Control <> nil)
          then
            begin
              LockWindowUpdate( fContainerPanel.Handle );
              try
                Frame.Control.Visible := false;
              finally
                LockWindowUpdate( 0 );
              end;
              //fContainerPanel.RemoveControl( Frame.Control );
              //Frame.Control.Parent := nil;
            end;
        fFrames.Extract( Frame );
        if (hopCacheable in Frame.MetaFrame.Options) and not VoidCache
          then
            begin
              fFrameCache.Insert( Frame );
              Frame.HandleEvent( evnHandlerUnexposed, self );
              frameName := Frame.Id;
              HandleEvent( evnFrameClosed, frameName );
            end
          else Frame.Free;
      end;

    procedure HidePrevFrames( NewFrame : TFrame );
      var
        i : integer;
      begin
        for i := pred(fFrames.Count) downto 0 do
          with TFrame(fFrames[i]) do
            if (Control <> nil) and (Control.Visible) and (fFrames[i] <> NewFrame)
              then CloseFrame( TFrame(fFrames[i]), false );
      end;

    procedure HideClientAlignedFrame( NewFrame : TFrame );
      var
        i : integer;
      begin
        for i := pred(fFrames.Count) downto 0 do
          with TFrame(fFrames[i]) do
            if (Control <> nil) and (Control.Align = alClient) and (fFrames[i] <> NewFrame)
              then CloseFrame( TFrame(fFrames[i]), false );
      end;

    procedure PerformExclusions( Frame : TFrame );
      var
        i : integer;
      begin
        for i := pred(fFrames.Count) downto 0 do
          if Excludes( Frame.MetaFrame.Name, TFrame(fFrames[i]).MetaFrame.Name ) or Excludes( Frame.Id, TFrame(fFrames[i]).Id )
            then CloseFrame( TFrame(fFrames[i]), false );
      end;

    procedure InsertFrame( Frame : TFrame );
      begin
        //logs.log('frames','fins1 - ');
        PerformExclusions( Frame );
        fFrameCache.Extract( Frame );
        //logs.log('frames','fins2 - ');
        if not (hopNonVisual in Frame.fMetaFrame.Options) and (Frame.Control <> nil)
          then
            begin
              //logs.log('frames','fins3 - ');
              LockWindowUpdate( fContainerPanel.Handle );
              //logs.log('frames','fins3 -1 ');
              try
                if Frame.Control.Parent = nil
                  then
                    begin
                      //logs.log('frames','fins3 -2 ');
                      Frame.Control.Parent := fContainerPanel;
                      //logs.log('frames','fins3 -3 ');
                    end
                  else
                    begin
                      //logs.log('frames','fins3 -4 ');
                      Frame.Control.Visible := true;
                      //logs.log('frames','fins3 -5 ');
                    end;
              finally
                LockWindowUpdate( 0 );
              end;
              //logs.log('frames','fins4 - ');
              //Frame.Control.Visible := true;
              //Frame.Control.Parent := fContainerPanel;
              //fContainerPanel.InsertControl( Frame.Control );
            end;
        //logs.log('frames','fins5 - ');
        fFrames.Insert( Frame );
        //logs.log('frames','fins6 - ');
        Frame.HandleEvent( evnHandlerExposed, self );
        //logs.log('frames','fins7 - ');
      end;

    function FullScreen( AnchorData : TAnchorData ) : boolean;
      begin
        result := (AnchorData.Width.value = 100) and AnchorData.Width.relative and
                  (AnchorData.Height.value = 100) and AnchorData.Height.relative;
      end;

    var
      AnchorData  : TAnchorData;
      MetaFrame   : TMetaFrame;
      Frame       : TFrame;
      TaskCarrier : TTaskCarrier;
      CurrURL     : string;
    begin
      try
        result := urlHandled;
        //logs.log('frames','frame1 - ');
        repeat
          CurrURL := URLParser.ExtractURL( URL );
          //logs.log('frames','frame2 - ' + currurl);
          if CurrURL <> ''
            then
              begin
                AnchorData := URLParser.GetAnchorData( CurrURL );
                //logs.log('frames','frame3 - ' + anchordata.action);
                if AnchorData.Action = htmlAction_GoBack
                  then result := GoBack
                  else
                    if AnchorData.Action = htmlAction_GoForward
                      then result := GoForward
                      else
                        if AnchorData.Action = htmlAction_Refresh
                          then
                            begin
                              Frame := FramesById[AnchorData.FrameId];
                              if Frame = nil
                                then Frame := CachedFrames[AnchorData.FrameId];
                              if Frame <> nil
                                then Frame.HandleEvent( evnRefresh, self )
                                else HandleEvent( evnRefresh, self );
                              result := urlHandled;
                            end
                          else
                            if AnchorData.FrameId <> ''
                              then
                                begin
                                  Frame := FramesById[AnchorData.FrameId];
                                  //logs.log('frames','frame4 - ' + anchordata.frameid);
                                  if not AnchorData.CloseFrame and ((AnchorData.Visibility <> visSwitch) or (Frame = nil))
                                    then
                                      begin
                                        //logs.log('frames','f1 - ');
                                        if Frame = nil
                                          then
                                            begin
                                              //logs.log('frames','f2 - ');
                                              Frame := CachedFrames[AnchorData.FrameId];
                                              //logs.log('frames','f2 -1 ');
                                              if (Frame <> nil) and (AnchorData.Visibility <> visHidden)
                                                then InsertFrame( Frame );
                                              //logs.log('frames','f2 -3 ');
                                            end;
                                        if Frame = nil
                                          then
                                            begin
                                              //logs.log('frames','f3 - ');
                                              MetaFrame := MetaFramesByName[AnchorData.FrameClass];
                                              if MetaFrame <> nil
                                                then
                                                  begin
                                                    //logs.log('frames','f3 -1 ');
                                                    Frame := MetaFrame.InstantiateFrame( AnchorData.FrameId );
                                                    //logs.log('frames','f3 -2 ');
                                                    Frame.setMasterURLHandler( self );
                                                    //logs.log('frames','f3 -3 ' );
                                                    if AnchorData.Visibility <> visHidden
                                                      then InsertFrame( Frame )
                                                      else fFrameCache.Insert( Frame );
                                                    //logs.log('frames','f3 -4 ');
                                                  end;
                                            end;
                                        if Frame <> nil
                                          then
                                            begin
                                              //logs.log('frames','frame5 - ');
                                              if not (hopNonVisual in Frame.fMetaFrame.Options) and (Frame.Control <> nil)
                                                then
                                                  begin
                                                    //logs.log('frames','frame6 - ');
                                                    LockWindowUpdate( fContainerPanel.Handle );
                                                    try
                                                      if Frame.Control.Align = alClient
                                                        then
                                                          if not FullScreen( AnchorData )
                                                            then HideClientAlignedFrame( Frame )
                                                            else HidePrevFrames( Frame );
                                                      if AnchorData.Align <> alNone
                                                        then Frame.Control.Align := AnchorData.Align;
                                                      if (AnchorData.Width.value >= 0) and ((Frame.Control.Align = alLeft) or (Frame.Control.Align = alRight))
                                                        then
                                                          if AnchorData.Width.relative
                                                            then Frame.Control.Width := AnchorData.Width.value*fContainerPanel.Width div 100
                                                            else Frame.Control.Width := AnchorData.Width.value;
                                                      if (AnchorData.Height.value >= 0) and ((Frame.Control.Align = alTop) or (Frame.Control.Align = alBottom))
                                                        then
                                                          if AnchorData.Height.relative
                                                            then Frame.Control.Height := AnchorData.Height.value*fContainerPanel.Height div 100
                                                            else Frame.Control.Height := AnchorData.Height.value;
                                                      //logs.log('frames','frame7 - ');
                                                    finally
                                                      LockWindowUpdate( 0 );
                                                    end;
                                                    FillGaps;
                                                  end;
                                              if AnchorData.ToHistory
                                                then ReportNavigation( nil, CurrURL, false, false );
                                              result := Frame.HandleURL( CurrURL );
                                              //logs.log('frames','frame8 - ');
                                            end
                                          else result := urlNotHandled;
                                      end
                                    else
                                      if Frame <> nil
                                        then
                                          begin
                                            TaskCarrier := GetTaskCarrier( Frame.fURLHandler );
                                            if TaskCarrier = nil
                                              then CloseFrame( Frame, AnchorData.VoidCache )
                                              else TaskCarrier.fPendingClose := true;
                                            FillGaps;
                                          end
                                        else result := urlNotHandled
                                end
                              else result := urlNotHandled;
              end;
        until CurrURL = '';
      except
        result := urlError;
      end;
    end;

  function TFrameSet.HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;

    procedure TaskStarted( const Info : TEvnTaskStartInfo );
      var
        Carrier : TTaskCarrier;
        Task    : TTaskReport;
      begin
        Carrier := GetTaskCarrier( Info.Carrier );
        if Carrier = nil
          then
            begin
              Carrier := TTaskCarrier.Create( Info.Carrier );
              fTasks.Insert( Carrier );
              if fTasks.Count = 1
                then HandleEvent( evnSystemBusy, self );
            end;
        Task := Carrier.Task[Info.TaskName];
        if Task = nil
          then
            begin
              Task := TTaskReport.Create( Info.TaskName, Info.TaskDesc );
              Carrier.Tasks.Insert( Task );
            end
      end;

    procedure TaskProgress( const Info : TEvnTaskProgressInfo );
      var
        Carrier : TTaskCarrier;
        Task    : TTaskReport;
      begin
        Carrier := GetTaskCarrier( Info.Carrier );
        if Carrier <> nil
          then
            begin
              Task := Carrier.Task[Info.TaskName];
              if Task <> nil
                then
                  begin
                    Task.fDesc := Info.TaskDesc;
                    Task.fProgress := Info.Progress;
                  end
            end;
      end;

    procedure TaskEnded( const Info : TEvnTaskEndInfo );
      var
        Carrier     : TTaskCarrier;
        Task        : TTaskReport;
        FreeHandler : boolean;
      begin
        Carrier := GetTaskCarrier( Info.Carrier );
        if Carrier <> nil
          then
            begin
              Task := Carrier.Task[Info.TaskName];
              if Task <> nil
                then
                  begin
                    Carrier.Tasks.Delete( Task );
                    if Carrier.Tasks.Count = 0
                      then
                        try
                          FreeHandler := Carrier.fPendingClose;
                          if fTasks.Count = 1
                            then HandleEvent( evnSystemIdle, self );
                          if FreeHandler
                            then HandleURL( '?frame_Id=' + FramesByHandler[Carrier.Carrier].Id + '&frame_Close=Yes' );
                          fTasks.Delete( Carrier );
                        except
                          {Repair}
                        end;
                  end
            end;
      end;

    function FrameHandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
      var
        EvnTaskStartInfo    : TEvnTaskStartInfo    absolute info;
        EvnTaskProgressInfo : TEvnTaskProgressInfo absolute info;
        EvnTaskEndInfo      : TEvnTaskEndInfo      absolute info;
      begin
        result := evnHandled;
        case EventId of
          evnTaskStart :
            TaskStarted( EvnTaskStartInfo );
          evnTaskProgress :
            TaskProgress( EvnTaskProgressInfo );
          evnTaskEnd :
            TaskEnded( EvnTaskEndInfo );
          evnShutDown :
            fMasterURLHandler := nil;
          else
            result := evnNotHandled;
        end;
      end;

    var
      i       : integer;
      Visited : TCollection;
      LastCnt : integer;
    begin
      result := FrameHandleEvent( EventId, info );
      Visited := TCollection.Create( fFrames.Count, rkUse );
      try
        repeat
          i := 0;
          LastCnt := fFrames.Count;
          while (i < fFrames.Count) and (LastCnt = fFrames.Count) do
            begin
              if Visited.IndexOf( fFrames[i] ) = NoIndex
                then
                  begin
                    if (TFrame(fFrames[i]).HandleEvent( EventId, info ) = evnHandled)
                      then result := evnHandled;
                    Visited.Insert( fFrames[i] );
                  end;
              inc( i );
            end;
        until (LastCnt = fFrames.Count);
        for i := 0 to pred(fFrameCache.Count) do
          with TFrame(fFrameCache[i]) do
            if (hopEnabledWhenCached in MetaFrame.Options) and (HandleEvent( EventId, info ) = evnHandled)
              then result := evnHandled;
      finally
        Visited.Free;
      end;
      {
      for i := 0 to pred(fFrames.Count) do
        if TFrame(fFrames[i]).HandleEvent( EventId, info ) = evnHandled
          then result := evnHandled;
      for i := 0 to pred(fFrameCache.Count) do
        with TFrame(fFrameCache[i]) do
          if (hopEnabledWhenCached in MetaFrame.Options) and (HandleEvent( EventId, info ) = evnHandled)
            then result := evnHandled;
      }
    end;

  function TFrameSet.RegisterMetaHandler( const aMetaURLHandler : IMetaURLHandler ) : TMetaHandlerRegistrationResult;
    var
      MetaFrame : TMetaFrame;
    begin
      try
        if MetaFramesByName[aMetaURLHandler.getName] = nil
          then
            begin
              MetaFrame := TMetaFrame.Create( aMetaURLHandler );
              fMetaFrames.Insert( MetaFrame );
              result := mhrRegistered;
            end
          else result := mhrRegistered;
      except
        result := mhrUknownError;
      end;
    end;

  procedure TFrameSet.RegisterDefaultHandler( Handler : string );
    begin
      fDefaultHandler := Handler;
    end;

  procedure TFrameSet.RegisterExclusion( Excluder, ToExclude : string; mutual : boolean );
    var
      ExclusionReport : TExclusionReport;
    begin
      ExclusionReport := GetExclusions( Excluder );
      if ExclusionReport = nil
        then
          begin
            ExclusionReport := TExclusionReport.Create( Excluder );
            fExclusions.Insert( ExclusionReport );
          end;
      ExclusionReport.Exclusions.Add( ToExclude );
      if mutual
        then RegisterExclusion( ToExclude, Excluder, false );
    end;

  procedure TFrameSet.setMasterURLHandler( const URLHandler : IMasterURLHandler );
    begin
      fMasterURLHandler := URLHandler;
    end;

  procedure TFrameSet.ReportNavigation( const Handler : IURLHandler; URL : TURL; localBack, localForward : boolean );
    {
    var
      Frame   : TFrame;
      HistRec : THistoryRecord;
    }
    begin
      {
      if not fNavInHistory
        then
          begin
            Frame := FramesByHandler[Handler];
            if not localBack and not localForward
              then
                begin
                  if Frame <> nil
                    then URL := URL + '&frame_Id=' + Frame.Id + '&frame_Class=' + Frame.MetaFrame.Name;
                  while fPosInHistory < pred(fNavHistory.Count) do
                    fNavHistory.Delete( pred(fNavHistory.Count) );
                  if fNavHistory.Count = HistoryLimit
                    then fNavHistory.Delete( 0 );
                  fNavHistory.Add( URL );
                  fPosInHistory := pred(fNavHistory.Count);
                end
              else
                if (fNavHistory.Count > 0) and (Frame <> nil)
                  then
                    begin
                      HistRec := THistoryRecord(fNavHistory.Objects[fPosInHistory]);
                      if HistRec = nil
                        then
                          begin
                            HistRec := THistoryRecord.Create;
                            HistRec.HandlerId := Frame.Id;
                            fNavHistory.Objects[fPosInHistory] := HistRec;
                          end;
                      if localBack
                        then inc( HistRec.BackCount );
                      if localForward
                        then inc( HistRec.ForwardCount );
                    end;
          end;
      }
    end;

  function TFrameSet.GoBack : TURLHandlingResult;
    var
      HistRec : THistoryRecord;
    begin
      fNavInHistory := true;
      try
        HistRec := THistoryRecord(fNavHistory.Objects[fPosInHistory]);
        if (HistRec = nil) or (HistRec.BackCount = 0)
          then
            begin
              if fPosInHistory > 0
                then
                  begin
                    dec( fPosInHistory );
                    HandleURL( fNavHistory[fPosInHistory] );
                  end;
            end
          else InternalNavigation( HistRec, navBack );
      finally
        fNavInHistory := false;
      end;
      result := urlHandled;
    end;

  function TFrameSet.GoForward : TURLHandlingResult;
    var
      HistRec : THistoryRecord;
    begin
      fNavInHistory := true;
      try
        HistRec := THistoryRecord(fNavHistory.Objects[fPosInHistory]);
        if (HistRec = nil) or (HistRec.BackCount = 0)
          then
            begin
              if fPosInHistory < pred(fNavHistory.Count)
                then
                  begin
                    inc( fPosInHistory );
                    HandleURL( fNavHistory[fPosInHistory] );
                  end;
            end
          else InternalNavigation( HistRec, navForward );
      finally
        fNavInHistory := false;
      end;
      result := urlHandled;
    end;

  procedure TFrameSet.InternalNavigation( HistRec : THistoryRecord; Direction : TNavigationDir );
    var
      Frame : TFrame;
    begin
      Frame := FramesById[HistRec.HandlerId];
      if Frame <> nil
        then
          case Direction of
            navBack :
              if Frame.HandleEvent( evnGoBack, self ) <> evnError
                then dec( HistRec.BackCount )
                else HistRec.BackCount := 0;
            navForward :
              if Frame.HandleEvent( evnGoForward, self ) <> evnError
                then dec( HistRec.ForwardCount )
                else HistRec.ForwardCount := 0;
          end;
    end;
    
  {
  procedure TFrameSet.ReportNavigation( Handler : IURLHandler; URL : TURL; localBack, localForward : boolean );
    var
      Frame   : TFrame;
      HistRec : THistoryRecord;
    begin
      if not fNavInHistory
        then
          begin
            if Handler <> nil
              then
                begin
                  Frame := FramesByHandler[Handler];
                  if Frame <> nil
                    then
                      if not localForward and not localBack
                        then URL := URL + '&frame_Id=' + Frame.Id + '&frame_Class=' + Frame.MetaFrame.Name
                        else
                          begin
                            HistRec := THistoryRecord(fNavHistory.Objects[fPosInHistory]);
                            if HistRec
                              then
                                begin
                                  HistRec := THistoryRecord.Create;
                            HistRec.HandlerId := Frame.Id;
                            if localBack
                              then inc( HistRec.BackCount );
                            if localForward
                              then inc( HistRec.BackCount );
                            URL := '?frame_Action=' + htmlAction_InternalNav + '&frame_Id=' + Frame.Id;
                            if localBack
                              then URL := URL + htmlParm_NavBack + '=yes';
                            if localForward
                              then URL := URL + htmlParm_NavForward + '=yes';
                          end;
                end;

            while fPosInHistory < pred(fNavHistory.Count) do
              fNavHistory.Delete( pred(fNavHistory.Count) );
            if fNavHistory.Count = HistoryLimit
              then fNavHistory.Delete( 0 );
            fNavHistory.Add( URL );
            fPosInHistory := pred(fNavHistory.Count);
          end;
    end;

  function TFrameSet.GoBack : TURLHandlingResult;
    begin
      if fPosInHistory > 0
        then
          begin
            fNavInHistory := true;
            try
              dec( fPosInHistory );
              if URLParser.GetURLAction( fNavHistory[fPosInHistory] ) <> htmlAction_InternalNav
                then HandleURL( fNavHistory[fPosInHistory] )
                else InternalNavigation( fNavHistory[fPosInHistory], navBack );
            finally
              fNavInHistory := false;
            end;
          end;
      result := urlHandled;
    end;

  function TFrameSet.GoForward : TURLHandlingResult;
    begin
      if fPosInHistory < pred(fNavHistory.Count)
        then
          begin
            fNavInHistory := true;
            try
              inc( fPosInHistory );
              if URLParser.GetURLAction( fNavHistory[fPosInHistory] ) <> htmlAction_InternalNav
                then HandleURL( fNavHistory[fPosInHistory] )
                else InternalNavigation( fNavHistory[fPosInHistory], navForward );
            finally
              fNavInHistory := false;
            end;
          end;
      result := urlHandled;
    end;
    
  procedure TFrameSet.InternalNavigation( HistRec : THistoryRecord; Direction : TNavigationDir );
    var
      FrameId : TFrameId;
      Frame   : TFrame;
    begin
      FrameId := URLParser.GetParmValue( URL, htmlParmName_Id );
      Frame := FramesById[FrameId];
      if Frame <> nil
        then
          case Direction of
            navBack :
              Frame.HandleEvent( evnGoBack, self );
            navForward :
              Frame.HandleEvent( evnGoForward, self );
          end;
    end;
  }

  function TFrameSet.GetTaskCarrier( Handler : IURLHandler ) : TTaskCarrier;
    var
      i : integer;
    begin
      i := 0;
      while (i < fTasks.Count) and (TTaskCarrier(fTasks[i]).Carrier <> Handler) do
        inc( i );
      if i < fTasks.Count
        then result := TTaskCarrier(fTasks[i])
        else result := nil;
    end;

  function TFrameSet.GetExclusions( Handler : string ) : TExclusionReport;
    var
      i : integer;
    begin
      i := 0;
      while (i < fExclusions.Count) and (TExclusionReport(fExclusions[i]).Excluder <> Handler) do
        inc( i );
      if i < fExclusions.Count
        then result := TExclusionReport(fExclusions[i])
        else result := nil;
    end;

  function TFrameSet.Excludes( Excluder, ToExclude : string ) : boolean;
    var
      ExclusionReport : TExclusionReport;
    begin
      ExclusionReport := GetExclusions( Excluder );
      if ExclusionReport <> nil
        then result := ExclusionReport.Exclusions.IndexOf( ToExclude ) <> -1
        else result := false;
    end;
    

end.


