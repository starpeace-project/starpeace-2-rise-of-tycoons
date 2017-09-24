{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit HtmlHelpViewer;

{ ************************************************************************ }
{                                                                          }
{ This unit implements a help viewer for the 32-bit windows Html help API. }
{ The design goal is for this unit to be indistinguishable from other      }
{ viewers as far as the VCL help manager can determine. Accordingly, at    }
{ at this time, it only wraps those features of the HtmlHelp API which are }
{ used by the help system implemented in HelpIntfs.pas.                    }
{                                                                          }
{ This unit is intended for use from within 32-bit windows applications.   }
{ It does not wrap the .NET interface to the HtmlHelp API.                 }
{                                                                          }
{ Because Microsoft HtmlHelp does not support direct querying without      }
{ displaying results, it is necessary for the HtmlHelp viewer to maintain  }
{ topic, keyword, and alink lists itself. In the case of the built-in IDE  }
{ help viewer, this list is drawn out of the .ALS file, and the analysis   }
{ of this list is delegated to an implementation of IHtmlHelp tester       }
{ (which is analagous to IWinHelpTester in WinHelpViewer.pas). Individual  }
{ applications wishing to support this functionality must implement        }
{ IHtmlHelpTester themselves. Absent an implementation of IHtmlHelpTester, }
{ the HtmlHelp viewer will *always* assume that the query should succeed   }
{ and HtmlHelp can be asked to provide help.                               }
{                                                                          }
{ Note that this means that an application which uses both WinHelpViewer   }
{ and HtmlHelpViewer MUST implement either IWinHelpTester, IHtmlHelpTester,}
{ or both, in order to avoid both the HtmlHelp Viewer and the WinHelp      }
{ Viewer from attempting to act as a default viewer. The behavior of       }
{ default viewers may be open for review in future revisions of the RTL.   }
{                                                                          }
{ ************************************************************************ }

interface

uses Classes;

{ Because HtmlHelp is uncooperative about responding to queries along the
  lines of 'do you support this', the HtmlHelp viewer in essence needs to
  hack a response to that. This interface is a hook by which user applications
  can override the HtmlHelp viewer's default answer. }

type
  IHtmlHelpTester = interface(IInterface)
    ['{82DF78E6-B675-4F5D-8A5B-F9BEEDDC14F6}']
    function CanShowALink(const ALink, FileName: String): Boolean;
    function CanShowTopic(const Topic, FileName: String): Boolean;
    function CanShowContext(const Context: Integer; 
                            const FileName: String): Boolean;
    function GetHelpStrings(const ALink: String): TStringList;
    function GetHelpPath : String;
    function GetDefaultHelpFile: String;
    function ConvertWinHelp(var Command: Word; var Data: LongInt): Boolean;
    end;

var
 HtmlHelpTester: IHtmlHelpTester;
 ViewerName: String;

{ =========================================================================== }

implementation

uses HelpIntfs, SysUtils, Windows;

resourcestring
  hNoKeyword = 'No help keyword specified.';
  hNoHtmlHelp = 'Unable to initalize HTML Help subsystem.';
  hNoHelpInThisRelease = 'No help available in this field test.';

type
 THTMLHelpViewer = class(TInterfacedObject, ICustomHelpViewer, IExtendedHelpViewer, ISpecialWinHelpViewer)
  private
   FViewerID: Integer;
   { fields used to handle popup configuration }
   FTopCenter: TPoint;
   FForeground: TColorRef;
   FBackground: TColorRef;
   FMargins: TRect;
   FFontDesc: String;
   FPopupResourceHandle: LongInt;
   FPopupResourceID: LongInt;
   FPopupText: String;
   FInitialized: Boolean;
 //  FInitializedCookie: LongInt;
   procedure ValidateHelpViewer;
  public
   FHelpManager: IHelpManager;
   constructor Create;
   destructor Destroy; override;
   { internal support functions }
   function GetHelpFile(const Name: String): String;
   procedure InternalShutDown;
   procedure SynchTopic(Handle: LongInt; const HelpFileName: String);
   procedure LookupALink(Handle: LongInt; const HelpFileName: String; 
                         LinkPtr: PHH_AkLink);
   procedure DisplayTextPopup(Handle: LongInt; Data: PHH_Popup);
   { ICustomHelpViewer }
   function GetViewerName : String;
   function UnderstandsKeyword(const HelpString: String): Integer;
   function GetHelpStrings(const HelpString: String): TStringList;
   function CanShowTableOfContents: Boolean;
   procedure ShowTableOfContents;
   procedure ShowHelp(const HelpString: String);
   procedure NotifyID(const ViewerID: Integer);
   procedure SoftShutDown;
   procedure ShutDown;
   { IExtendedHelpViewer }
   function UnderstandsTopic(const Topic: String): Boolean;
   procedure DisplayTopic(const Topic: String);
   function UnderstandsContext(const ContextID: Integer;
                               const HelpFileName: String): Boolean;
   procedure DisplayHelpByContext(const ContextId: Integer;
                                  const HelpFileName: String);
   { ISpecialHtmlHelpViewer }
   function CallHtmlHelp(Handle: LongInt; HelpFileName: String;
                         Command: Integer; Data: DWord): LongInt;
   { IExtendedHelpViewer2 }
   procedure Search(const HelpFileName: String; const Query: String);
   procedure Index(const HelpFileName: String; const Query: String);
   { IPopupHelp }
   procedure SetupPopupWindow(TopCenter: TPoint; Foreground, Background: DWord; 
                             Margins: TRect; const FontDesc: String);
   procedure SetupPopupSource(Handle: LongInt; ID: LongInt; const Text: String);
   procedure Popup(KeepWindowSetup: Boolean; KeepSourceSetup: Boolean);
   procedure ClearSetup;
   { ISpecialWinHelpViewer }
   function CallWinHelp(Handle: LongInt; const HelpFileName: String;
                        Command: Word; Data: LongInt) : Boolean;
   { properties }
   property ViewerID : Integer read FViewerID;
   property HelpManager : IHelpManager read FHelpManager write FHelpManager;
   property TopCenter: TPoint read FTopCenter write FTopCenter;
   property Foreground: TColorRef read FForeground write FForeground;
   property Background: TColorRef read FBackground write FBackground;
   property Margins: TRect read FMargins write FMargins;
   property FontDesc: String read FFontDesc write FFontDesc;
   property PopupResourceHandle: LongInt read FPopupResourceHandle write FPopupResourceHandle;
   property PopupResourceId: LongInt read FPopupResourceId write FPopupResourceId;
   property PopupText: String read FPopupText write FPopupText;
  end;

var
  HelpViewer: THtmlHelpViewer;
  HelpViewerIntf: ICustomHelpViewer;
  FInitializedCookie: LongInt;

procedure THtmlHelpViewer.ValidateHelpViewer;
begin
{ commented out to allo an error message for the field test. when help is 
  delivered, restore this. ALSO, note, that checking for the return from
  HH_INITIALIZE appears to be wrong, and the raise should remain commented
  out: HH_INITIALIZE always returns 0 and fails to set the cookie. }


  if not FInitialized then
  begin
    HtmlHelp(0, nil, HH_INITIALIZE, &FInitializedCookie);
    if FInitializedCookie = 0 then
    begin
       //raise EHelpSystemException.CreateRes(@hNoHtmlHelp);
    end;
    FInitialized := true;
  end;

  //raise EHelpSystemException.CreateRes(@hNoHelpInThisRelease);
end;

{ ICustomHelpViewer. }

{ GetViewerName returns a string that the Help Manager can use to identify
  this Viewer in a UI element asking users to choose among Viewers. }
function THtmlHelpViewer.GetViewerName: String;
begin
  Result := ViewerName;
end;

{ UnderstandsKeyword is a querying function that the Help Manager calls to
  determine if the Viewer provide helps on a particular keyword string. }
function THtmlHelpViewer.UnderstandsKeyword(const HelpString: String): Integer;
var
  CanShowHelp : Boolean;
  HelpFile: String;
begin
  HelpFile := GetHelpFile('');
  Result := 1;
  if Assigned(HtmlHelpTester) then
  begin
    CanShowHelp := HtmlHelpTester.CanShowALink(HelpString, HelpFile);
    if not CanShowHelp then Result := 0;
  end;
end;

{ GetHelpStrings is used by the Help Manager to display a list of keyword
  matches from which an application's user can select one. It assumes
  that the String List is properly allocated, so this function should
  never return nil. }

function THtmlHelpViewer.GetHelpStrings(const HelpString: String): TStringList;
begin
  if Assigned(HtmlHelpTester) then
    Result := HtmlHelpTester.GetHelpStrings(HelpString)
  else begin
    Result := TStringList.Create;
    Result.Add(GetViewerName + ': ' + HelpString);
  end;
end;

{ CanShowTableOfContents is a querying function that the Help Manager
  calls to determine if the Viewer supports tables of contents. HtmlHelp does. }

function THtmlHelpViewer.CanShowTableOfContents: Boolean;
begin
  Result := True;
end;

{ ShowTableOfContents is a command function that the Help Manager uses
  to direct the Viewer to display a table of contents. It is never
  called without being preceded by a call to CanShowTableOfContents. }
procedure THtmlHelpViewer.ShowTableOfContents;
var
  FileName : String;
  Handle: LongInt;
begin
  ValidateHelpViewer;
  FileName := GetHelpFile('');
  Handle := HelpManager.GetHandle;
  SynchTopic(Handle, FileName);
  HtmlHelp(Handle, PChar(FileName), HH_DISPLAY_TOPIC, 0);
end;

procedure THtmlHelpViewer.ShowHelp(const HelpString: String);
var
  FileName : String;
  Link: THH_AKLink;
  LinkPtr: PHH_AkLink;
begin
  ValidateHelpViewer;
  FileName := GetHelpFile('');
  { WARNING: the documentation says HH_DISPLAY_TOPIC is required before this
    will work. Is that true?  }
  Link.cbStruct := sizeof (THH_AKLink);
  Link.fReserved := false;
  Link.pszKeywords := PChar(HelpString);
  Link.pszUrl := nil;
  Link.pszMsgText := nil;
  Link.pszMsgTitle := nil;
  Link.pszWindow := nil;
  Link.fIndexOnFail := true;
  LinkPtr := @Link;
  LookupALink(HelpManager.GetHandle, FileName, LinkPtr);
end;

{ NotifyID is called by the Help Manager after a successful registration
  to provide the Help Viewer with a cookie which uniquely identifies the
  Viewer to the Manager, and can be used in communications between the two. }

procedure THtmlHelpViewer.NotifyId(const ViewerId: Integer);
begin
  FViewerID := ViewerID;
end;

{ SoftShutDown is called by the help manager to ask the viewer to
  terminate any externally spawned subsystem without shutting itself down. }
procedure THtmlHelpViewer.SoftShutDown;
begin
  HtmlHelp(0, nil, HH_CLOSE_ALL, 0);
end;

procedure THtmlHelpViewer.ShutDown;
begin
  SoftShutDown;
  if FInitialized then
  begin
    HtmlHelp(0, nil, HH_UNINITIALIZE, &FInitializedCookie);
    FInitialized := false;
    FInitializedCookie := 0;
  end;
  if Assigned(FHelpManager) then HelpManager := nil;
  if Assigned(HtmlHelpTester) then HtmlHelpTester := nil;
end;

{ IExtendedHelpViewer }

{ UnderstandsTopic is called by the Help Manager to ask if the Viewer
  is capable of displaying a topic-based help query for a given topic.
  It's default behavior is to say 'yes'. }

function THtmlHelpVIewer.UnderstandsTopic(const Topic: String): Boolean;
var
  HelpFile: string;
begin;
  HelpFile := GetHelpFile('');
  if Assigned(HtmlHelpTester) then
    Result := HtmlHelpTester.CanShowTopic(Topic, HelpFile)
  else
    Result := True;
end;

{ DisplayTopic is called by the Help Manager if a Help Viewer claims
  in its response to UnderstandsTopic to be able to provide Topic-based
  help for a particular keyword. }

procedure THtmlHelpViewer.DisplayTopic(const Topic: String);
const
  InvokeSep = '::/';
  InvokeSuf = '.htm';
var
  HelpFile: String;
  InvocationString: String;
begin
  ValidateHelpViewer;
  HelpFile := GetHelpFile('');
  InvocationString := HelpFile + InvokeSep + Topic + InvokeSuf;
  HtmlHelp(HelpManager.GetHandle(), PChar(InvocationString), HH_DISPLAY_TOPIC, 0);
end;

{ UnderstandsContext is a querying function called by the Help Manager
  to determine if an Extended Help Viewer is capable of providing
  help for a particular context-ID. Like all querying functions in
  this file, the default behavior is to say 'yes' unless overridden by
  a Tester. }

function THtmlHelpViewer.UnderstandsContext(const ContextId: Integer;
                                            const HelpFileName: String): Boolean;
begin
  Result := True;
  if Assigned(HtmlHelpTester) then
     Result := HtmlHelpTester.CanShowContext(ContextId, GetHelpFile(HelpFileName));
end;

{ DisplayHelpByContext is used by the Help Manager to request that a
  Help Viewer display help for a particular Context-ID. It is only
  invoked after a successful call to CanShowContext. }

procedure THtmlHelpviewer.DisplayHelpByContext(const ContextId: Integer;
                                               const HelpFileName: String);
var
  Handle: LongInt;
  FileName: String;
begin
  ValidateHelpViewer;
  FileName := GetHelpFile(HelpFileName);
  Handle := HelpManager.GetHandle;
  SynchTopic(Handle, FileName);
  HtmlHelp(Handle, PChar(FileName), HH_HELP_CONTEXT, ContextId);
end;

{ ISpecialWinHelpViewer }

{ This function reveals a design flaw in the D6/7 help system. :(
  ISpecialWinHelpViewer.CallWinHelp is intended to allow third-party
  help systems to process WinHelp messages which were not generalizable
  by the system designer. In this case, the expected behavior would be
  to convert WinHelp messages into HtmlHelp messages and forward them
  along.

  However, the same necessity that compels developers to be able to send
  non-generalizable winhelp messages also compels the ability to send
  non-generalizable htmlhelp messages. There is no mechanism in the 
  existing architecture to do that.

  The function signature for WinHelp() and HtmlHelp() are sufficiently
  similar, however, to allow the function to multiplex. Depending on the
  answer provided by an implementation of IHtmlHelpTester, the function
  will either convert messages (under the assumption that they are
  WinHelp messages) or pass them through (under the assumption that they
  are HtmlHelp messages).

  The need for this should be resolved in the next revision of the RTL, but 
  this function will continue to behave that way for purposes of backwards
  compatability. }

function THtmlHelpViewer.CallWinHelp(Handle: LongInt; const HelpFileName: String; Command: Word; Data: LongInt): Boolean;
var
  Convert : Boolean;
  FileName: String;
begin
  ValidateHelpViewer;
  Result := false;
  FileName := GetHelpFile(HelpFileName);
  if FileName <> '' then
  begin
    if Assigned(HtmlHelpTester) then
    begin
      Convert := HtmlHelpTester.ConvertWinHelp(Command, Data);
    end
    else Convert := false;

    if not Convert then
    begin
    end
    else begin
      CallHtmlHelp(Handle, FileName, Command, Data);
      Result := true;
    end;
  end else
  begin
  end;
end;

{ ISpecialHtmlHelpViewer }

function THtmlHelpViewer.CallHtmlHelp(Handle: LongInt; HelpFileName: String;
                         Command: Integer; Data: DWord): LongInt;
begin
  ValidateHelpViewer;
  Result := 0;
  case Command of
    HH_CLOSE_ALL: 
    begin
      SoftShutDown;
    end;
    HH_DISPLAY_TEXT_POPUP:
    begin
      DisplayTextPopup(Handle,PHH_Popup(Data));
    end;
    HH_HELP_CONTEXT:
    begin
      DisplayHelpByContext(Data, HelpFileName);
    end;
    HH_ALINK_LOOKUP:
    begin
      LookupALink(Handle, HelpFileName, PHH_AkLink(Data));
    end;
    { DisplayIndex, DisplaySearch, DisplayToc }
  else
begin
    SynchTopic(Handle, HelpFileName);
    Result := HtmlHelp(Handle, PChar(HelpFileName), Command, Data);
  end;
  end;
end;

{ IExtendedHelpViewer2 }

procedure THtmlHelpViewer.Search(const HelpFileName: String; 
                                 const Query: String);
begin

end;

procedure THtmlHelpViewer.Index(const HelpFileName: String; 
                                const Query: String);
begin

end;

{ IPopupHelp }

procedure THtmlHelpViewer.SetupPopupWindow(TopCenter: TPoint; 
                                           Foreground, Background: DWord; 
                                           Margins: TRect; 
                                           const FontDesc: String);
begin
  Self.TopCenter := TopCenter;
  Self.Foreground := Foreground;
  Self.Background := Background;
  Self.Margins := Margins;
  Self.FontDesc := FontDesc;
end;

procedure THtmlHelpVIewer.SetupPopupSource(Handle: LongInt; ID: LongInt; 
                                           const Text: String);
begin
 Self.PopupResourceHandle := Handle;
 Self.PopupResourceId := ID;
 Self.PopupText := Text;
end;

procedure THtmlHelpViewer.Popup(KeepWindowSetup: Boolean; 
                                KeepSourceSetup: Boolean);
begin
  { execute popup call }
  if not KeepWindowSetup then
  begin
  end;
  if not KeepSourceSetup then
  begin
  end;
end;

procedure THtmlHelpViewer.ClearSetup;
begin

end;

{==========================================================================}

procedure THtmlHelpViewer.SynchTopic(Handle: LongInt; const HelpFileName: String);
begin
  HtmlHelp(Handle, PChar(HelpFileName), HH_DISPLAY_TOPIC, 0);
end;

procedure THtmlHelpViewer.LookupALink(Handle: LongInt; 
                                      const HelpFileName: String; 
                                      LinkPtr: PHH_AkLink);
begin
  HtmlHelp(Handle, PChar(HelpFileName), HH_ALINK_LOOKUP, DWORD(LinkPtr));
end;

procedure THtmlHelpViewer.DisplayTextPopup(Handle: LongInt; Data: PHH_Popup);
var
  FileName: String;
begin
  HtmlHelp(Handle, PChar(FileName), HH_DISPLAY_TEXT_POPUP, DWord(Data));
end;

constructor THtmlHelpViewer.Create;
begin
  inherited Create;
  HelpViewerIntf := Self;
  FInitialized := False;
  FInitializedCookie := 0;
  ClearSetup;
end;

destructor THtmlHelpViewer.Destroy;
begin
  HelpViewer := nil;
  inherited Destroy;
end;

function THtmlHelpViewer.GetHelpFile(const Name: String): String;
var
  FileName: String;
begin
  Result := '';
  if (Name = '') and Assigned(FHelpManager) then
    FileName := HelpManager.GetHelpFile
  else
    FileName := Name;

  if (FileName = '') and Assigned(HtmlHelpTester) then 
    FileName := HtmlHelpTester.GetDefaultHelpFile;

  if Assigned(HtmlHelpTester) then
    FileName := HtmlHelpTester.GetHelpPath + PathDelim + FileName;

  Result := FileName;
end;

procedure THtmlHelpViewer.InternalShutDown;
begin
  SoftShutDown;
  if Assigned(FHelpManager) then
  begin
    HelpManager.Release(ViewerID);
    HelpManager := nil;
  end;
end;

initialization
  HelpViewer := THtmlHelpViewer.Create;
  HelpIntfs.RegisterViewer(HelpViewerIntf, HelpViewer.FHelpManager);

finalization
  if Assigned(HelpViewer.FHelpManager) then
   HelpViewer.InternalShutDown;
  HelpViewerIntf := nil;
  HtmlHelpTester := nil;
end.
