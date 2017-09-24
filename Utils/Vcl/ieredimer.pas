//-----------------------------------------------------------------------------
// Unit Name: ieredimer
// Author:    Alex Sporik
// Purpose:   Remove 3D frame border from Web Browser control
//-----------------------------------------------------------------------------

unit ieredimer;

interface

uses Windows, Classes, SHDocVw, ActiveX;

const

  IID_IDocHostUIHandler: TGUID = '{bd3f23c0-d43e-11cf-893b-00aa00bdce1a}';

  DOCHOSTUITYPE_BROWSE = 0;
  DOCHOSTUITYPE_AUTHOR = 1;

  DOCHOSTUIDBLCLK_DEFAULT = 0;
  DOCHOSTUIDBLCLK_SHOWPROPERTIES = 1;
  DOCHOSTUIDBLCLK_SHOWCODE = 2;

  DOCHOSTUIFLAG_DIALOG = $0001;
  DOCHOSTUIFLAG_DISABLE_HELP_MENU = $0002;
  DOCHOSTUIFLAG_NO3DBORDER = $0004;
  DOCHOSTUIFLAG_SCROLL_NO = $0008;
  DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE = $0010;
  DOCHOSTUIFLAG_OPENNEWWIN = $0020;
  DOCHOSTUIFLAG_DISABLE_OFFSCREEN = $0040;
  DOCHOSTUIFLAG_FLAT_SCROLLBAR = $0080;
  DOCHOSTUIFLAG_DIV_BLOCKDEFAULT = $0100;
  DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY = $0200;
  DOCHOSTUIFLAG_OVERRIDEBEHAVIORFACTORY = $0400;
  DOCHOSTUIFLAG_CODEPAGELINKEDFONTS = $0800;
  DOCHOSTUIFLAG_URL_ENCODING_DISABLE_UTF8 = $1000;
  DOCHOSTUIFLAG_URL_ENCODING_ENABLE_UTF8 = $2000;
  DOCHOSTUIFLAG_ENABLE_FORMS_AUTOCOMPLETE = $4000;
  DOCHOSTUIFLAG_ENABLE_INPLACE_NAVIGATION = $10000;
  DOCHOSTUIFLAG_IME_ENABLE_RECONVERSION = $20000;

type

  PDOCHOSTUIINFO = ^TDOCHOSTUIINFO;
  TDOCHOSTUIINFO = record
    cbSize: ULONG;
    dwFlags: DWORD;
    dwDoubleClick: DWORD;
    chHostCss: POLESTR;
    chHostNS: POLESTR;
  end;

  IDocHostUIHandler = interface(IUnknown)
    ['{bd3f23c0-d43e-11cf-893b-00aa00bdce1a}']
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT; const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT; stdcall;
    function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject; const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame; const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT; const pUIWindow: IOleInPlaceUIWindow; const fRameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup: PGUID; const nCmdID: DWORD): HRESULT; stdcall;
    function GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD): HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget; out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POLESTR; var ppchURLOut: POLESTR): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HRESULT; stdcall;
  end;

type

   TGetHostInfoEvent = function(var pInfo: TDOCHOSTUIINFO): HRESULT of object;
   
   TFramelessIE = class(TWebBrowser, IDocHostUIHandler)
   private
    FOnGetHostInfo:TGetHostInfoEvent;
   protected
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT; const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT; stdcall;
    function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject; const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame; const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT; const pUIWindow: IOleInPlaceUIWindow; const FrameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup: PGUID; const nCmdID: DWORD): HRESULT; stdcall; function GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD): HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget; out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POLESTR; var ppchURLOut: POLESTR): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HRESULT; stdcall;
   public
    property OnGetHostInfo: TGetHostInfoEvent read FOnGethostinfo Write FOnGetHostInfo;
   end;

implementation

{ TFramelessIE }

function TFramelessIE.EnableModeless(const fEnable: BOOL): HRESULT;
begin
 Result:=S_FALSE; 
end;

function TFramelessIE.FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.GetDropTarget(const pDropTarget: IDropTarget; out ppDropTarget: IDropTarget): HRESULT;
begin
 Result:=S_OK;
end;

function TFramelessIE.GetExternal(out ppDispatch: IDispatch): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT;
begin
 pInfo.cbSize:=SizeOf(pInfo);
 pInfo.dwFlags:=DOCHOSTUIFLAG_NO3DBORDER;// or DOCHOSTUIFLAG_FLAT_SCROLLBAR;// or DOCHOSTUIFLAG_SCROLL_NO;
 pInfo.dwDoubleClick:=DOCHOSTUIDBLCLK_DEFAULT;
 if Assigned(FOnGetHostInfo) then Result:=FOnGetHostInfo(pInfo) else Result:=S_OK;
end;

function TFramelessIE.GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.HideUI: HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.OnDocWindowActivate(const fActivate: BOOL): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.OnFrameWindowActivate(const fActivate: BOOL): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.ResizeBorder(const prcBorder: PRECT; const pUIWindow: IOleInPlaceUIWindow; const FrameWindow: BOOL): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.ShowContextMenu(const dwID: DWORD; const ppt: PPOINT; const pcmdtReserved: IInterface;  const pdispReserved: IDispatch): HRESULT;
begin
 Result:=S_OK; // S_FALSE if you want default popup menu
end;

function TFramelessIE.ShowUI(const dwID: DWORD;
  const pActiveObject: IOleInPlaceActiveObject;
  const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
  const pDoc: IOleInPlaceUIWindow): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.TranslateAccelerator(const lpMsg: PMSG;
  const pguidCmdGroup: PGUID; const nCmdID: DWORD): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POLESTR; var ppchURLOut: POLESTR): HRESULT;
begin
 Result:=S_FALSE;
end;

function TFramelessIE.UpdateUI: HRESULT;
begin
 Result:=S_FALSE;
end;

end.
