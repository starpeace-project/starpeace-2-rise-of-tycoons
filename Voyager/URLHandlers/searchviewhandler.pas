unit searchviewhandler;

interface
uses
    Classes, VoyagerInterfaces, VoyagerServerInterfaces, Controls, searchview,
    Protocol, Privacy, VCLUtils,StrUtils, ComCtrls, URLParser, VisualClassManager,
    IniClasses;

type

    Tsearchviewhandler =
      class( TInterfacedObject, IMetaURLHandler, IURLHandler )
        public
          constructor Create;
          destructor  Destroy; override;
        private
          fControl          : Tsearchviewf;
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
    tidHandlerName_searchview  = 'searchview';

implementation

uses
    ServerCnxHandler, VoyagerUIEvents, Events, ServerCnxEvents, Config, SysUtils, FileCtrl,
    VoyagerEvents, DisplayControl, logs;

  function Tsearchviewhandler.getName : string;
    begin
      result := tidHandlerName_searchview;
    end;

  function Tsearchviewhandler.getOptions : TURLHandlerOptions;
    begin
      result := [hopCacheable];
    end;

  function Tsearchviewhandler.getCanHandleURL( URL : TURL ) : THandlingAbility;
    begin
      result := 0;
    end;

  function Tsearchviewhandler.Instantiate : IURLHandler;
    begin
      result := self;// TworldlogonHandler.Create
    end;

  // TOptionsHandler

  constructor Tsearchviewhandler.Create;
    var
       i:integer;
    begin
      inherited Create;
      fControl := Tsearchviewf.Create( nil );
     // fcontrol.frefresh := true;
      //logs.log('wlogin','create');
     // i:= fcontrol.blistset;
     // i:= fcontrol.loadclass;
     { for i := 0 to 99 do
         begin
           fcontrol.fblist[i] := Tblist.Create(fcontrol.bpan);
           fcontrol.fblist[i].Align :=alTop;
           fcontrol.fblist[i].Parent :=fcontrol.bpan;
           fcontrol.fblist[i].Visible:=true;
         end;
      //logs.log('wlogin','buildlist'); }
    end;

  destructor Tsearchviewhandler.Destroy;
    begin
      RemoveComponentFreeAndNil(fControl);
      //fPlayList.free;
      //fIgnoreList.free;
      inherited;
    end;

  function Tsearchviewhandler.HandleURL( URL : TURL ) : TURLHandlingResult;
    var
      i: integer;
      resulttype: string;
    begin
      //set image
      i:= fcontrol.reset;
      result := urlNotHandled;
    end;

  function Tsearchviewhandler.HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
    var
      i:integer;
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
        evnRefresh :
            begin
              //fControl.frefresh:=true;
            end;
        else
          result := evnNotHandled;    
      end;
    end;

  function Tsearchviewhandler.getControl : TControl;
    begin
      result := fControl;
    end;

  procedure Tsearchviewhandler.setMasterURLHandler( const URLHandler : IMasterURLHandler );
    var
      cache : string;

    begin
      //fMasterURLHandler := URLHandler;
      URLHandler.HandleEvent( evnAnswerClientView, fClientView );
      fMasterURLHandler := URLHandler;
      fControl.ClientView       := fClientView;
      fControl.MasterURLHandler := URLHandler;
      URLHandler.HandleEvent( evnAnswerPrivateCache, cache );
         fControl.Cache := cache;
    end;

end.
