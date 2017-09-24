unit worldlogonhandler;

interface
  uses
    Classes, VoyagerInterfaces, VoyagerServerInterfaces, Controls, worldlogon,
    Protocol, Privacy, VCLUtils,StrUtils, ComCtrls, URLParser, VisualClassManager,
    IniClasses;

    type

    TworldlogonHandler =
      class( TInterfacedObject, IMetaURLHandler, IURLHandler )
        public
          constructor Create;
          destructor  Destroy; override;
        private
          fControl          : Tworldlogon;
          fClientView       : IClientView;
          fMasterURLHandler : IMasterURLHandler;
          fCachePath        : string;
        // IURLHandler
        private
          function getName    : string;
          function getOptions : TURLHandlerOptions;
          function getCanHandleURL( URL : TURL ) : THandlingAbility;
          function Instantiate : IURLHandler;
          function  HandleURL( URL : TURL ) : TURLHandlingResult;
          function  HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
          function  getControl : TControl;
          procedure setMasterURLHandler( const URLHandler : IMasterURLHandler );
      end;

    const
    tidHandlerName_worldlogon  = 'worldlogonView';

implementation
  uses
    ServerCnxHandler, VoyagerUIEvents, Events, ServerCnxEvents, Config, SysUtils, FileCtrl,
    VoyagerEvents, DisplayControl, logs;

  // TMetaOptionsHandler

  function TworldlogonHandler.getName : string;
    begin
      result := tidHandlerName_worldlogon;
    end;

  function TworldlogonHandler.getOptions : TURLHandlerOptions;
    begin
      result := [hopCacheable];
    end;

  function TworldlogonHandler.getCanHandleURL( URL : TURL ) : THandlingAbility;
    begin
      result := 0;
    end;

  function TworldlogonHandler.Instantiate : IURLHandler;
    begin
      result := self;// TworldlogonHandler.Create
    end;

  // TOptionsHandler

  constructor TworldlogonHandler.Create;
    begin
      inherited Create;
      fControl := Tworldlogon.Create( nil );
      //logs.log('wlogin','create');
    end;

  destructor TworldlogonHandler.Destroy;
    begin
      RemoveComponentFreeAndNil(fControl);
      //fPlayList.free;
      //fIgnoreList.free;
      inherited;
    end;

  function TworldlogonHandler.HandleURL( URL : TURL ) : TURLHandlingResult;
    var
      i: string;
      resulttype: string;
    begin
      //logs.log('wlogin','start1 - ' + URL);
      //fcontrol.Notebook1.PageIndex:=0;
      resulttype:= 'NORMAL';
      //logs.log('wlogin','start2');
      fcontrol.clientviewid := URLParser.GetParmValue(URL,'ClientViewId');  //  ServerCnxHandler.TServerCnxHandler.fISAddr;
      fcontrol.UserName:= URLParser.GetParmValue(URL,htmlParmName_UserName );
      fcontrol.ISAddr :=URLParser.GetParmValue(URL,htmlParmName_ISAddr ); //  h
      fcontrol.ISPort := URLParser.GetParmValue(URL,'ISPort');
      fcontrol.ResultType := URLParser.GetParmValue(URL,'ResultType');
      //logs.log('wlogin','start3');
      if URLParser.GetParmValue(URL,'frame_Action') <> 'Create' then
        begin
          i:= fcontrol.login;
        end;
      //logs.log('wlogin','start4');
      result := urlNotHandled;
    end;

  function TworldlogonHandler.HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
    begin
      //logs.log('wlogin','event - ' +inttostr(eventid));
      result := evnHandled;
      case EventId of
        evnHandlerExposed :
          begin
            if fclientview = nil then logs.log('wlogin','no fclientview - 2' );
            fControl.ClientView := fClientView;
            fControl.MasterURLHandler := fMasterURLHandler;
          end;
         else
          result := evnNotHandled;
      end;
    end;

  function TworldlogonHandler.getControl : TControl;
    begin
      result := fControl;
    end;

  procedure TworldlogonHandler.setMasterURLHandler( const URLHandler : IMasterURLHandler );
    var
      cache : string;

    begin
      //fMasterURLHandler := URLHandler;
      try
          //logs.log('options','playlist4');
          URLHandler.HandleEvent( evnAnswerClientView, fClientView );
      fMasterURLHandler := URLHandler;
      fControl.ClientView       := fClientView;
      fControl.MasterURLHandler := URLHandler;
      URLHandler.HandleEvent( evnAnswerPrivateCache, cache );
         fControl.Cache := cache;
      finally
        //
      end;
     
    end;




end.
