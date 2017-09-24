{*******************************************************}
{                                                       }
{       Borland Delphi Run-time Library                 }
{       Win32 API Desktop Window Manager Interface Unit }
{                                                       }
{       Copyright (c) 1985-2006 Microsoft Corporation   }
{                                                       }
{       Translator: Borland Software Corporation        }
{                                                       }
{*******************************************************}

unit DwmApi;

{$HPPEMIT ''}
{$HPPEMIT '#include "dwmapi.h"'}
{$HPPEMIT ''}

interface

uses Windows, Uxtheme;

const
  // Blur behind data structures

  {$EXTERNALSYM DWM_BB_ENABLE}
  DWM_BB_ENABLE                 = $00000001;  // fEnable has been specified
  {$EXTERNALSYM DWM_BB_BLURREGION}
  DWM_BB_BLURREGION             = $00000002;  // hRgnBlur has been specified
  {$EXTERNALSYM DWM_BB_TRANSITIONONMAXIMIZED}
  DWM_BB_TRANSITIONONMAXIMIZED  = $00000004;  // fTransitionOnMaximized has been specified

type
  {$EXTERNALSYM PDWM_BLURBEHIND}
  PDWM_BLURBEHIND = ^DWM_BLURBEHIND;
  {$EXTERNALSYM DWM_BLURBEHIND}
  DWM_BLURBEHIND = packed record
    dwFlags: DWORD;
    fEnable: BOOL;
    hRgnBlur: HRGN;
    fTransitionOnMaximized: BOOL;
  end;
  _DWM_BLURBEHIND = DWM_BLURBEHIND;
  TDWMBlurBehind = DWM_BLURBEHIND;
  PDWMBlurBehind = ^TDWMBlurBehind;

type
  {$EXTERNALSYM DWMWINDOWATTRIBUTE}
  DWMWINDOWATTRIBUTE = type Integer;
  TDWMWindowAttribute = DWMWINDOWATTRIBUTE;

const
  // Window attributes

  {$EXTERNALSYM DWMWA_NCRENDERING_ENABLED}
  DWMWA_NCRENDERING_ENABLED = 1;      // [get] Is non-client rendering enabled/disabled
  {$EXTERNALSYM DWMWA_NCRENDERING_POLICY}
  DWMWA_NCRENDERING_POLICY = 2;       // [set] Non-client rendering policy
  {$EXTERNALSYM DWMWA_TRANSITIONS_FORCEDISABLED}
  DWMWA_TRANSITIONS_FORCEDISABLED = 3; // [set] Potentially enable/forcibly disable transitions
  {$EXTERNALSYM DWMWA_ALLOW_NCPAINT}
  DWMWA_ALLOW_NCPAINT = 4;            // [set] Allow contents rendered in the non-client area to be visible on the DWM-drawn frame.
  {$EXTERNALSYM DWMWA_CAPTION_BUTTON_BOUNDS}
  DWMWA_CAPTION_BUTTON_BOUNDS = 5;    // [get] Bounds of the caption button area in window-relative space.
  {$EXTERNALSYM DWMWA_NONCLIENT_RTL_LAYOUT}
  DWMWA_NONCLIENT_RTL_LAYOUT = 6;     // [set] Is non-client content RTL mirrored
  {$EXTERNALSYM DWMWA_FORCE_ICONIC_REPRESENTATION}
  DWMWA_FORCE_ICONIC_REPRESENTATION = 7; // [set] Force this window to display iconic thumbnails.
  {$EXTERNALSYM DWMWA_FLIP3D_POLICY}
  DWMWA_FLIP3D_POLICY = 8;            // [set] Designates how Flip3D will treat the window.
  {$EXTERNALSYM DWMWA_EXTENDED_FRAME_BOUNDS}
  DWMWA_EXTENDED_FRAME_BOUNDS = 9;    // [get] Gets the extended frame bounds rectangle in screen space
  {$EXTERNALSYM DWMWA_LAST}
  DWMWA_LAST = 10;

  // Non-client rendering policy attribute values

  {$EXTERNALSYM DWMNCRP_USEWINDOWSTYLE}
  DWMNCRP_USEWINDOWSTYLE = 0; // Enable/disable non-client rendering based on window style
  {$EXTERNALSYM DWMNCRP_DISABLED}
  DWMNCRP_DISABLED = 1;       // Disabled non-client rendering; window style is ignored
  {$EXTERNALSYM DWMNCRP_ENABLED}
  DWMNCRP_ENABLED = 2;        // Enabled non-client rendering; window style is ignored
  {$EXTERNALSYM DWMNCRP_LAST}
  DWMNCRP_LAST = 3;

  // Values designating how Flip3D treats a given window.

  {$EXTERNALSYM DWMFLIP3D_DEFAULT}
  DWMFLIP3D_DEFAULT = 0;      // Hide or include the window in Flip3D based on window style and visibility.
  {$EXTERNALSYM DWMFLIP3D_EXCLUDEBELOW}
  DWMFLIP3D_EXCLUDEBELOW = 1; // Display the window under Flip3D and disabled.
  {$EXTERNALSYM DWMFLIP3D_EXCLUDEABOVE}
  DWMFLIP3D_EXCLUDEABOVE = 2; // Display the window above Flip3D and enabled.
  {$EXTERNALSYM DWMFLIP3D_LAST}
  DWMFLIP3D_LAST = 3;

type
  // Thumbnails

  {$EXTERNALSYM HTHUMBNAIL}
  HTHUMBNAIL = THandle;
  {$EXTERNALSYM PHTHUMBNAIL}
  PHTHUMBNAIL = ^HTHUMBNAIL;

const
  {$EXTERNALSYM DWM_TNP_RECTDESTINATION}
  DWM_TNP_RECTDESTINATION       = $00000001;
  {$EXTERNALSYM DWM_TNP_RECTSOURCE}
  DWM_TNP_RECTSOURCE            = $00000002;
  {$EXTERNALSYM DWM_TNP_OPACITY}
  DWM_TNP_OPACITY               = $00000004;
  {$EXTERNALSYM DWM_TNP_VISIBLE}
  DWM_TNP_VISIBLE               = $00000008;
  {$EXTERNALSYM DWM_TNP_SOURCECLIENTAREAONLY}
  DWM_TNP_SOURCECLIENTAREAONLY  = $00000010;

type
  {$EXTERNALSYM PDWM_THUMBNAIL_PROPERTIES}
  PDWM_THUMBNAIL_PROPERTIES = ^DWM_THUMBNAIL_PROPERTIES;
  {$EXTERNALSYM DWM_THUMBNAIL_PROPERTIES}
  DWM_THUMBNAIL_PROPERTIES = packed record
    dwFlags: DWORD;
    rcDestination: TRect;
    rcSource: TRect;
    opacity: Byte;
    fVisible: BOOL;
    fSourceClientAreaOnly: BOOL;
  end;
  _DWM_THUMBNAIL_PROPERTIES = DWM_THUMBNAIL_PROPERTIES;
  TDWMThumbnailProperties = DWM_THUMBNAIL_PROPERTIES;
  PDWMThumbnailProperties = ^TDWMThumbnailProperties;

  // Video enabling apis

  {$EXTERNALSYM DWM_FRAME_COUNT}
  DWM_FRAME_COUNT = ULONGLONG;
  {$EXTERNALSYM QPC_TIME}
  QPC_TIME = ULONGLONG;

  {$EXTERNALSYM UNSIGNED_RATIO}
  UNSIGNED_RATIO = packed record
    uiNumerator: Cardinal;
    uiDenominator: Cardinal;
  end;
  _UNSIGNED_RATIO = UNSIGNED_RATIO;
  TUnsignedRatio = UNSIGNED_RATIO;
  PUnsignedRatio = ^TUnsignedRatio;

  {$EXTERNALSYM DWM_TIMING_INFO}
  DWM_TIMING_INFO = packed record
    cbSize: Cardinal;

    // Data on DWM composition overall

    // Monitor refresh rate
    rateRefresh: UNSIGNED_RATIO;

    // Actual period
    qpcRefreshPeriod: QPC_TIME;

    // composition rate
    rateCompose: UNSIGNED_RATIO;

    // QPC time at a VSync interupt
    qpcVBlank: QPC_TIME;

    // DWM refresh count of the last vsync
    // DWM refresh count is a 64bit number where zero is
    // the first refresh the DWM woke up to process
    cRefresh: DWM_FRAME_COUNT;

    // DX refresh count at the last Vsync Interupt
    // DX refresh count is a 32bit number with zero
    // being the first refresh after the card was initialized
    // DX increments a counter when ever a VSync ISR is processed
    // It is possible for DX to miss VSyncs
    // 
    // There is not a fixed mapping between DX and DWM refresh counts
    // because the DX will rollover and may miss VSync interupts
    cDXRefresh: UINT;

    // QPC time at a compose time. 
    qpcCompose: QPC_TIME;

    // Frame number that was composed at qpcCompose
    cFrame: DWM_FRAME_COUNT;

    // The present number DX uses to identify renderer frames
    cDXPresent: UINT;

    // Refresh count of the frame that was composed at qpcCompose
    cRefreshFrame: DWM_FRAME_COUNT;


    // DWM frame number that was last submitted
    cFrameSubmitted: DWM_FRAME_COUNT;

    // DX Present number that was last submitted
    cDXPresentSubmitted: UINT;

    // DWM frame number that was last confirmed presented
    cFrameConfirmed: DWM_FRAME_COUNT;

    // DX Present number that was last confirmed presented
    cDXPresentConfirmed: UINT;

    // The target refresh count of the last
    // frame confirmed completed by the GPU
    cRefreshConfirmed: DWM_FRAME_COUNT;

    // DX refresh count when the frame was confirmed presented
    cDXRefreshConfirmed: UINT;

    // Number of frames the DWM presented late
    // AKA Glitches
    cFramesLate: DWM_FRAME_COUNT;

    // the number of composition frames that
    // have been issued but not confirmed completed
    cFramesOutstanding: UINT;


    // Following fields are only relavent when an HWND is specified
    // Display frame


    // Last frame displayed
    cFrameDisplayed: DWM_FRAME_COUNT;

    // QPC time of the composition pass when the frame was displayed
    qpcFrameDisplayed: QPC_TIME;

    // Count of the VSync when the frame should have become visible
    cRefreshFrameDisplayed: DWM_FRAME_COUNT;

    // Complete frames: DX has notified the DWM that the frame is done rendering

    // ID of the the last frame marked complete (starts at 0)
    cFrameComplete: DWM_FRAME_COUNT;

    // QPC time when the last frame was marked complete
    qpcFrameComplete: QPC_TIME;

    // Pending frames:
    // The application has been submitted to DX but not completed by the GPU

    // ID of the the last frame marked pending (starts at 0)
    cFramePending: DWM_FRAME_COUNT;

    // QPC time when the last frame was marked pending
    qpcFramePending: QPC_TIME;

    // number of unique frames displayed
    cFramesDisplayed: DWM_FRAME_COUNT;

    // number of new completed frames that have been received
    cFramesComplete: DWM_FRAME_COUNT;

     // number of new frames submitted to DX but not yet complete
    cFramesPending: DWM_FRAME_COUNT;

    // number of frames available but not displayed, used or dropped
    cFramesAvailable: DWM_FRAME_COUNT;

    // number of rendered frames that were never
    // displayed because composition occured too late
    cFramesDropped: DWM_FRAME_COUNT;

    // number of times an old frame was composed
    // when a new frame should have been used
    // but was not available
    cFramesMissed: DWM_FRAME_COUNT;

    // the refresh at which the next frame is
    // scheduled to be displayed
    cRefreshNextDisplayed: DWM_FRAME_COUNT;

    // the refresh at which the next DX present is
    // scheduled to be displayed
    cRefreshNextPresented: DWM_FRAME_COUNT;

    // The total number of refreshes worth of content
    // for this HWND that have been displayed by the DWM
    // since DwmSetPresentParameters was called
    cRefreshesDisplayed: DWM_FRAME_COUNT;

    // The total number of refreshes worth of content
    // that have been presented by the application
    // since DwmSetPresentParameters was called
    cRefreshesPresented: DWM_FRAME_COUNT;


    // The actual refresh # when content for this
    // window started to be displayed
    // it may be different than that requested
    // DwmSetPresentParameters
    cRefreshStarted: DWM_FRAME_COUNT;

    // Total number of pixels DX redirected
    // to the DWM.
    // If Queueing is used the full buffer
    // is transfered on each present.
    // If not queuing it is possible only
    // a dirty region is updated
    cPixelsReceived: ULONGLONG;

    // Total number of pixels drawn.
    // Does not take into account if
    // if the window is only partial drawn
    // do to clipping or dirty rect management
    cPixelsDrawn: ULONGLONG;

    // The number of buffers in the flipchain
    // that are empty.   An application can
    // present that number of times and guarantee
    // it won't be blocked waiting for a buffer to
    // become empty to present to
    cBuffersEmpty: DWM_FRAME_COUNT;

  end;
  _DWM_TIMING_INFO = DWM_TIMING_INFO;
  TDWMTimingInfo = DWM_TIMING_INFO;
  PDWMTimingInfo = ^TDWMTimingInfo;

const
  // Use the first source frame that
  // includes the first refresh of the output frame
  {$EXTERNALSYM DWM_SOURCE_FRAME_SAMPLING_POINT}
  DWM_SOURCE_FRAME_SAMPLING_POINT = 0;

  // use the source frame that includes the most
  // refreshes of out the output frame
  // in case of multiple source frames with the
  // same coverage the last will be used
  {$EXTERNALSYM DWM_SOURCE_FRAME_SAMPLING_COVERAGE}
  DWM_SOURCE_FRAME_SAMPLING_COVERAGE = 1;

  // Sentinel value
  {$EXTERNALSYM DWM_SOURCE_FRAME_SAMPLING_LAST}
  DWM_SOURCE_FRAME_SAMPLING_LAST = 2;

const
  c_DwmMaxQueuedBuffers = 8;
  c_DwmMaxMonitors = 16;
  c_DwmMaxAdapters = 16;

type
  {$EXTERNALSYM DWM_PRESENT_PARAMETERS}
  DWM_PRESENT_PARAMETERS = packed record
    cbSize: Cardinal;
    fQueue: BOOL;
    cRefreshStart: DWM_FRAME_COUNT;
    cBuffer: UINT;
    fUseSourceRate: BOOL;
    rateSource: UNSIGNED_RATIO;
    cRefreshesPerFrame: UINT;
    eSampling: UINT;
  end;
  _DWM_PRESENT_PARAMETERS = DWM_PRESENT_PARAMETERS;
  TDWMPresentParameters = DWM_PRESENT_PARAMETERS;
  PDWMPresentParameters = ^TDWMPresentParameters;

const
  {$EXTERNALSYM DWM_FRAME_DURATION_DEFAULT}
  DWM_FRAME_DURATION_DEFAULT = -1;

{$EXTERNALSYM DwmDefWindowProc}
function DwmDefWindowProc(hWnd: HWND; msg: UINT; wParam: WPARAM; lParam: LPARAM; 
  var plResult: LRESULT): BOOL;

{$EXTERNALSYM DwmEnableBlurBehindWindow}
function DwmEnableBlurBehindWindow(hWnd: HWND;
  const pBlurBehind: TDWMBlurBehind): HResult;

const
  {$EXTERNALSYM DWM_EC_DISABLECOMPOSITION}
  DWM_EC_DISABLECOMPOSITION         = 0;
  {$EXTERNALSYM DWM_EC_ENABLECOMPOSITION}
  DWM_EC_ENABLECOMPOSITION          = 1;

{$EXTERNALSYM DwmEnableComposition}
function DwmEnableComposition(uCompositionAction: UINT): HResult;

{$EXTERNALSYM DwmEnableMMCSS}
function DwmEnableMMCSS(fEnableMMCSS: BOOL): HResult;

{$EXTERNALSYM DwmExtendFrameIntoClientArea}
function DwmExtendFrameIntoClientArea(hWnd: HWND; const pMarInset: TMargins): HResult;

{$EXTERNALSYM DwmGetColorizationColor}
function DwmGetColorizationColor(out pcrColorization: DWORD; out pfOpaqueBlend: BOOL): HResult;

{$EXTERNALSYM DwmGetCompositionTimingInfo}
function DwmGetCompositionTimingInfo(hwnd: HWND; out pTimingInfo: TDWMTimingInfo): HResult;

{$EXTERNALSYM DwmGetWindowAttribute}
function DwmGetWindowAttribute(hwnd: HWND; dwAttribute: DWORD;
  pvAttribute: Pointer; cbAttribute: DWORD): HResult;

{$EXTERNALSYM DwmIsCompositionEnabled}
function DwmIsCompositionEnabled(out pfEnabled: BOOL): HResult;

{$EXTERNALSYM DwmModifyPreviousDxFrameDuration}
function DwmModifyPreviousDxFrameDuration(hwnd: HWND; cRefreshes: Integer;
  fRelative: BOOL): HResult;

{$EXTERNALSYM DwmQueryThumbnailSourceSize}
function DwmQueryThumbnailSourceSize(hThumbnail: HTHUMBNAIL;
  pSize: PSIZE): HResult;

{$EXTERNALSYM DwmRegisterThumbnail}
function DwmRegisterThumbnail(hwndDestination: HWND; hwndSource: HWND;
  out phThumbnailId: HTHUMBNAIL): HResult;

{$EXTERNALSYM DwmSetDxFrameDuration}
function DwmSetDxFrameDuration(hwnd: HWND; cRefreshes: Integer): HResult;

{$EXTERNALSYM DwmSetPresentParameters}
function DwmSetPresentParameters(hwnd: HWND; var pPresentParams: TDWMPresentParameters): HResult;

{$EXTERNALSYM DwmSetWindowAttribute}
function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD;
  pvAttribute: Pointer; cbAttribute: DWORD): HResult;

{$EXTERNALSYM DwmUnregisterThumbnail}
function DwmUnregisterThumbnail(hThumbnailId: HTHUMBNAIL): HResult;

{$EXTERNALSYM DwmUpdateThumbnailProperties}
function DwmUpdateThumbnailProperties(hThumbnailId: HTHUMBNAIL;
  const ptnProperties: TDWMThumbnailProperties): HResult;

function DwmCompositionEnabled: Boolean;

implementation

uses
  SysUtils;

const
  ModName = 'DWMAPI.DLL';

var
  hDWMAPI: HMODULE;

var
  _DwmDefWindowProc: function(hWnd: HWND; msg: UINT; wParam: WPARAM;
    lParam: LPARAM; var plResult: LRESULT): BOOL; stdcall;

  _DwmEnableBlurBehindWindow: function(hWnd: HWND;
    const pBlurBehind: TDWMBlurBehind): HResult; stdcall;

  _DwmEnableComposition: function(uCompositionAction: UINT): HResult; stdcall;

  _DwmEnableMMCSS: function(fEnableMMCSS: BOOL): HResult; stdcall;

  _DwmExtendFrameIntoClientArea: function(hWnd: HWND;
    const pMarInset: TMargins): HResult; stdcall;

  _DwmGetColorizationColor: function(out pcrColorization: DWORD;
    out pfOpaqueBlend: BOOL): HResult; stdcall;

  _DwmGetCompositionTimingInfo: function(hwnd: HWND;
    out pTimingInfo: TDWMTimingInfo): HResult; stdcall;

  _DwmGetWindowAttribute: function(hwnd: HWND; dwAttribute: DWORD;
    pvAttribute: Pointer; cbAttribute: DWORD): HResult; stdcall;

  _DwmIsCompositionEnabled: function(out pfEnabled: BOOL): HResult; stdcall;

  _DwmModifyPreviousDxFrameDuration: function(hwnd: HWND; cRefreshes: Integer;
    fRelative: BOOL): HResult; stdcall;

  _DwmQueryThumbnailSourceSize: function(hThumbnail: HTHUMBNAIL; pSize: PSIZE): HResult; stdcall;

  _DwmRegisterThumbnail: function(hwndDestination: HWND; hwndSource: HWND;
    out phThumbnailId: HTHUMBNAIL): HResult; stdcall;

  _DwmSetDxFrameDuration: function(hwnd: HWND; cRefreshes: Integer): HResult; stdcall;

  _DwmSetPresentParameters: function(hwnd: HWND;
    var pPresentParams: TDWMPresentParameters): HResult; stdcall;

  _DwmSetWindowAttribute: function(hwnd: HWND; dwAttribute: DWORD;
    pvAttribute: Pointer; cbAttribute: DWORD): HResult; stdcall;

  _DwmUnregisterThumbnail: function(hThumbnailId: HTHUMBNAIL): HResult; stdcall;

  _DwmUpdateThumbnailProperties: function(hThumbnailId: HTHUMBNAIL;
    const ptnProperties: TDWMThumbnailProperties): HResult; stdcall;

procedure InitDwmApi; inline;
begin
  if hDWMAPI = 0 then
    hDWMAPI := LoadLibrary(ModName);
end;

function DwmDefWindowProc(hWnd: HWND; msg: UINT; wParam: WPARAM;
  lParam: LPARAM; var plResult: LRESULT): BOOL;
begin
  if Assigned(_DwmDefWindowProc) then
    Result := _DwmDefWindowProc(hWnd, msg, wParam, lParam, plResult)
  else
  begin
    InitDwmApi;
    Result := False;
    if hDWMAPI > 0 then
    begin
      _DwmDefWindowProc := GetProcAddress(hDWMAPI, 'DwmDefWindowProc'); // Do not localize
      if Assigned(_DwmDefWindowProc) then
        Result := _DwmDefWindowProc(hWnd, msg, wParam, lParam, plResult);
    end;
  end;
end;

function DwmEnableBlurBehindWindow(hWnd: HWND; const pBlurBehind: TDWMBlurBehind): HResult;
begin
  if Assigned(_DwmEnableBlurBehindWindow) then
    Result := _DwmEnableBlurBehindWindow(hWnd, pBlurBehind)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmEnableBlurBehindWindow := GetProcAddress(hDWMAPI, 'DwmEnableBlurBehindWindow'); // Do not localize
      if Assigned(_DwmEnableBlurBehindWindow) then
        Result := _DwmEnableBlurBehindWindow(hWnd, pBlurBehind);
    end;
  end;
end;

function DwmEnableComposition(uCompositionAction: UINT): HResult;
begin
  if Assigned(_DwmEnableComposition) then
    Result := _DwmEnableComposition(uCompositionAction)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmEnableComposition := GetProcAddress(hDWMAPI, 'DwmEnableComposition'); // Do not localize
      if Assigned(_DwmEnableComposition) then
        Result := _DwmEnableComposition(uCompositionAction);
    end;
  end;
end;

function DwmEnableMMCSS(fEnableMMCSS: BOOL): HResult;
begin
  if Assigned(_DwmEnableMMCSS) then
    Result := _DwmEnableMMCSS(fEnableMMCSS)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmEnableMMCSS := GetProcAddress(hDWMAPI, 'DwmEnableMMCSS'); // Do not localize
      if Assigned(_DwmEnableMMCSS) then
        Result := _DwmEnableMMCSS(fEnableMMCSS);
    end;
  end;
end;

function DwmExtendFrameIntoClientArea(hWnd: HWND; const pMarInset: TMargins): HResult;
begin
  if Assigned(_DwmExtendFrameIntoClientArea) then
    Result := _DwmExtendFrameIntoClientArea(hWnd, pMarInset)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmExtendFrameIntoClientArea := GetProcAddress(hDWMAPI, 'DwmExtendFrameIntoClientArea'); // Do not localize
      if Assigned(_DwmExtendFrameIntoClientArea) then
        Result := _DwmExtendFrameIntoClientArea(hWnd, pMarInset);
    end;
  end;
end;

function DwmGetColorizationColor(out pcrColorization: DWORD; out pfOpaqueBlend: BOOL): HResult;
begin
  if Assigned(_DwmGetColorizationColor) then
    Result := _DwmGetColorizationColor(pcrColorization, pfOpaqueBlend)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmGetColorizationColor := GetProcAddress(hDWMAPI, 'DwmGetColorizationColor'); // Do not localize
      if Assigned(_DwmGetColorizationColor) then
        Result := _DwmGetColorizationColor(pcrColorization, pfOpaqueBlend);
    end;
  end;
end;

function DwmGetCompositionTimingInfo(hwnd: HWND; out pTimingInfo: TDWMTimingInfo): HResult;
begin
  if Assigned(_DwmGetCompositionTimingInfo) then
    Result := _DwmGetCompositionTimingInfo(hwnd, pTimingInfo)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmGetCompositionTimingInfo := GetProcAddress(hDWMAPI, 'DwmGetCompositionTimingInfo'); // Do not localize
      if Assigned(_DwmGetCompositionTimingInfo) then
        Result := _DwmGetCompositionTimingInfo(hwnd, pTimingInfo);
    end;
  end;
end;

function DwmGetWindowAttribute(hwnd: HWND; dwAttribute: DWORD;
  pvAttribute: Pointer; cbAttribute: DWORD): HResult;
begin
  if Assigned(_DwmGetWindowAttribute) then
    Result := _DwmGetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmGetWindowAttribute := GetProcAddress(hDWMAPI, 'DwmGetWindowAttribute'); // Do not localize
      if Assigned(_DwmGetWindowAttribute) then
        Result := _DwmGetWindowAttribute(hwnd, dwAttribute, pvAttribute,
          cbAttribute);
    end;
  end;
end;

function DwmIsCompositionEnabled(out pfEnabled: BOOL): HResult;
begin
  if Assigned(_DwmIsCompositionEnabled) then
    Result := _DwmIsCompositionEnabled(pfEnabled)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmIsCompositionEnabled := GetProcAddress(hDWMAPI, 'DwmIsCompositionEnabled'); // Do not localize
      if Assigned(_DwmIsCompositionEnabled) then
        Result := _DwmIsCompositionEnabled(pfEnabled);
    end;
  end;
end;

function DwmModifyPreviousDxFrameDuration(hwnd: HWND; cRefreshes: Integer;
  fRelative: BOOL): HResult;
begin
  if Assigned(_DwmModifyPreviousDxFrameDuration) then
    Result := _DwmModifyPreviousDxFrameDuration(hwnd, cRefreshes, fRelative)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmModifyPreviousDxFrameDuration := GetProcAddress(hDWMAPI, 'DwmModifyPreviousDxFrameDuration'); // Do not localize
      if Assigned(_DwmModifyPreviousDxFrameDuration) then
        Result := _DwmModifyPreviousDxFrameDuration(hwnd, cRefreshes, fRelative);
    end;
  end;
end;

function DwmQueryThumbnailSourceSize(hThumbnail: HTHUMBNAIL; pSize: PSIZE): HResult;
begin
  if Assigned(_DwmQueryThumbnailSourceSize) then
    Result := _DwmQueryThumbnailSourceSize(hThumbnail, pSize)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmQueryThumbnailSourceSize := GetProcAddress(hDWMAPI, 'DwmQueryThumbnailSourceSize'); // Do not localize
      if Assigned(_DwmQueryThumbnailSourceSize) then
        Result := _DwmQueryThumbnailSourceSize(hThumbnail, pSize);
    end;
  end;
end;

function DwmRegisterThumbnail(hwndDestination: HWND; hwndSource: HWND;
  out phThumbnailId: HTHUMBNAIL): HResult;
begin
  if Assigned(_DwmRegisterThumbnail) then
    Result := _DwmRegisterThumbnail(hwndDestination, hwndSource, phThumbnailId)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmRegisterThumbnail := GetProcAddress(hDWMAPI, 'DwmRegisterThumbnail'); // Do not localize
      if Assigned(_DwmRegisterThumbnail) then
        Result := _DwmRegisterThumbnail(hwndDestination, hwndSource,
          phThumbnailId);
    end;
  end;
end;

function DwmSetDxFrameDuration(hwnd: HWND; cRefreshes: Integer): HResult;
begin
  if Assigned(_DwmSetDxFrameDuration) then
    Result := _DwmSetDxFrameDuration(hwnd, cRefreshes)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmSetDxFrameDuration := GetProcAddress(hDWMAPI, 'DwmSetDxFrameDuration'); // Do not localize
      if Assigned(_DwmSetDxFrameDuration) then
        Result := _DwmSetDxFrameDuration(hwnd, cRefreshes);
    end;
  end;
end;

function DwmSetPresentParameters(hwnd: HWND; var pPresentParams: TDWMPresentParameters): HResult;
begin
  if Assigned(_DwmSetPresentParameters) then
    Result := _DwmSetPresentParameters(hwnd, pPresentParams)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmSetPresentParameters := GetProcAddress(hDWMAPI, 'DwmSetPresentParameters'); // Do not localize
      if Assigned(_DwmSetPresentParameters) then
        Result := _DwmSetPresentParameters(hwnd, pPresentParams);
    end;
  end;
end;

function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD;
  pvAttribute: Pointer; cbAttribute: DWORD): HResult;
begin
  if Assigned(_DwmSetWindowAttribute) then
    Result := _DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute, cbAttribute)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmSetWindowAttribute := GetProcAddress(hDWMAPI, 'DwmSetWindowAttribute'); // Do not localize
      if Assigned(_DwmSetWindowAttribute) then
        Result := _DwmSetWindowAttribute(hwnd, dwAttribute, pvAttribute,
          cbAttribute);
    end;
  end;
end;

function DwmUnregisterThumbnail(hThumbnailId: HTHUMBNAIL): HResult;
begin
  if Assigned(_DwmUnregisterThumbnail) then
    Result := _DwmUnregisterThumbnail(hThumbnailId)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmUnregisterThumbnail := GetProcAddress(hDWMAPI, 'DwmUnregisterThumbnail'); // Do not localize
      if Assigned(_DwmUnregisterThumbnail) then
        Result := _DwmUnregisterThumbnail(hThumbnailId);
    end;
  end;
end;

function DwmUpdateThumbnailProperties(hThumbnailId: HTHUMBNAIL;
  const ptnProperties: TDWMThumbnailProperties): HResult;
begin
  if Assigned(_DwmUpdateThumbnailProperties) then
    Result := _DwmUpdateThumbnailProperties(hThumbnailId, ptnProperties)
  else
  begin
    InitDwmApi;
    Result := E_NOTIMPL;
    if hDWMAPI > 0 then
    begin
      _DwmUpdateThumbnailProperties := GetProcAddress(hDWMAPI, 'DwmUpdateThumbnailProperties'); // Do not localize
      if Assigned(_DwmUpdateThumbnailProperties) then
        Result := _DwmUpdateThumbnailProperties(hThumbnailId, ptnProperties);
    end;
  end;
end;

function DwmCompositionEnabled: Boolean;
var
  LEnabled: BOOL;
begin
  Result := (Win32MajorVersion >= 6) and (DwmIsCompositionEnabled(LEnabled) = S_OK) and LEnabled;
end;


initialization

finalization
  if hDWMAPI > 0 then
    FreeLibrary(hDWMAPI);
end.
