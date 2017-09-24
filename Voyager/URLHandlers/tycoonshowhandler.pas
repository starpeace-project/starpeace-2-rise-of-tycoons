unit tycoonshowhandler;

interface
   uses
    Classes, VoyagerInterfaces, VoyagerServerInterfaces, Controls, tycoonshow,
    Protocol, Privacy, VCLUtils,StrUtils, ComCtrls, URLParser, VisualClassManager,
    IniClasses,logs;

type

    Ttycoonshowhandler =
      class( TInterfacedObject, IMetaURLHandler, IURLHandler )
        public
          constructor Create;
          destructor  Destroy; override;
        private
          fControl          : Ttycoonshower;
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
    tidHandlerName_tycoonshow  = 'tycoonshow';

implementation
  uses
    ServerCnxHandler, VoyagerUIEvents, Events, ServerCnxEvents, Config, SysUtils, FileCtrl,
    VoyagerEvents, DisplayControl;

  function Ttycoonshowhandler.getName : string;
    begin
      result := tidHandlerName_tycoonshow;
    end;

  function Ttycoonshowhandler.getOptions : TURLHandlerOptions;
    begin
      result := [hopCacheable];
    end;

  function Ttycoonshowhandler.getCanHandleURL( URL : TURL ) : THandlingAbility;
    begin
      result := 0;
    end;

  function Ttycoonshowhandler.Instantiate : IURLHandler;
    begin
      result := self;// TworldlogonHandler.Create
    end;

  // TOptionsHandler

  constructor Ttycoonshowhandler.Create;
    var
       i:integer;
    begin
      inherited Create;
      fControl := Ttycoonshower.Create( nil );
     // fcontrol.frefresh := true;
      //logs.log('tshow','create');
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

  destructor Ttycoonshowhandler.Destroy;
    begin
      RemoveComponentFreeAndNil(fControl);
      //fPlayList.free;
      //fIgnoreList.free;
      inherited;
    end;

  function Ttycoonshowhandler.HandleURL( URL : TURL ) : TURLHandlingResult;
    var
      i: integer;
      Action : string;
      resulttype: string;
    begin
      //set image
      //i:= fcontrol.showimage;
      //logs.log('tshow','s1');
      Action := URLParser.GetURLAction( URL );
      //non page based action here BANKLOAN BANKPAY TYCOONPAY

      //logs.log('tshow',action);
      if action = 'CURR' then
        begin
          //show curr
          i:=fcontrol.scurr;
          //fcontrol.Notebook1.ActivePage:='curr';
          //logs.log('tshow','s1-1');
        end
      else
        if action = 'COMP' then
          begin
            //show comp's
            i:=fcontrol.ncompany;
            //logs.log('tshow','s1-2');
          end
        else
          if action = 'BANK' then
            begin
              //show bank
              i:=fcontrol.bankpage;
              //logs.log('tshow','s1-bank');
            end
          else
            if action = 'PL' then
              begin
                //show bank
                i:=fcontrol.plpage;
                //Threads.Fork(threadedRequestLatency, priNormal, [0]);
                //logs.log('tshow','s1-pl');
              end
            else
              if action = 'IS' then
                 begin
                    //show bank
                    i:=fcontrol.ispage;
                    //logs.log('tshow','s1-is');
                 end
              else
                if action = 'STRAT' then
                  begin
                     //show bank
                     i:=fcontrol.stratpage;
                     //logs.log('tshow','s1-strat');
                  end
                else
                  if action = 'WEB' then
                    begin
                      i:=fcontrol.webpage;
                    end              //URLParser.GetParmValue( URL, htmlParmName_ISAddr )
                  else
                    if action = 'RANK' then
                      begin
                      //logs.Log('loadrank','s');
                        i:=fcontrol.rank(URLParser.GetParmValue( URL, 'rid' ));
                       // logs.Log('loadrank','f');
                      end; 
                  
      result := urlNotHandled;
    end;

  function Ttycoonshowhandler.HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
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

  function Ttycoonshowhandler.getControl : TControl;
    begin
      result := fControl;
    end;

  procedure Ttycoonshowhandler.setMasterURLHandler( const URLHandler : IMasterURLHandler );
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

