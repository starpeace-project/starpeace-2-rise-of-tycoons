unit tycoonhandler;

interface
   uses
    Classes, VoyagerInterfaces, VoyagerServerInterfaces, Controls, tycoonviewer,
    Protocol, Privacy, VCLUtils,StrUtils, ComCtrls, URLParser, VisualClassManager,
    IniClasses;

type

    Ttycoonhandler =
      class( TInterfacedObject, IMetaURLHandler, IURLHandler )
        public
          constructor Create;
          destructor  Destroy; override;
        private
          fControl          : Ttycoonview;
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
    tidHandlerName_tycoon  = 'tycoonView';

implementation
  uses
    ServerCnxHandler, VoyagerUIEvents, Events, ServerCnxEvents, Config, SysUtils, FileCtrl,
    VoyagerEvents, DisplayControl, logs;

  function Ttycoonhandler.getName : string;
    begin
      result := tidHandlerName_tycoon;
    end;

  function Ttycoonhandler.getOptions : TURLHandlerOptions;
    begin
      result := [hopCacheable];
    end;

  function Ttycoonhandler.getCanHandleURL( URL : TURL ) : THandlingAbility;
    begin
      result := 0;
    end;

  function Ttycoonhandler.Instantiate : IURLHandler;
    begin
      result := self;// TworldlogonHandler.Create
    end;

  // TOptionsHandler

  constructor Ttycoonhandler.Create;
    var
       i:integer;
    begin
      inherited Create;
      fControl := Ttycoonview.Create( nil );
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

  destructor Ttycoonhandler.Destroy;
    begin
      RemoveComponentFreeAndNil(fControl);
      //fPlayList.free;
      //fIgnoreList.free;
      inherited;
    end;

  function Ttycoonhandler.HandleURL( URL : TURL ) : TURLHandlingResult;
    var
      i: integer;
      resulttype: string;
    begin
      //set image
      i:= fcontrol.showimage;
      result := urlNotHandled;
    end;

  function Ttycoonhandler.HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
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

  function Ttycoonhandler.getControl : TControl;
    begin
      result := fControl;
    end;

  procedure Ttycoonhandler.setMasterURLHandler( const URLHandler : IMasterURLHandler );
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
