{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit Dialogs;

{$R-,T-,H+,X+}

interface

{$IFDEF LINUX}
uses WinUtils, Windows, Messages, SysUtils, CommDlg,
  Printers, Classes, Graphics, Controls, Forms, StdCtrls;
{$ENDIF}
{$IFDEF MSWINDOWS}
uses Windows, Messages, SysUtils, CommDlg,
  Printers, Classes, Graphics, Controls, Forms, StdCtrls, ShlObj, CommCtrl;
{$ENDIF}
const

{ Maximum number of custom colors in color dialog }

  MaxCustomColors = 16;

type

{ TCommonDialog }

  TCommonDialog = class(TComponent)
  private
    FCtl3D: Boolean;
    FDefWndProc: Pointer;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FRedirector: TWinControl;
    FObjectInstance: Pointer;
    FTemplate: PChar;
    FTemplateModule: HINST;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMInitDialog(var Message: TWMInitDialog); message WM_INITDIALOG;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure MainWndProc(var Message: TMessage);
  protected
    procedure DoClose; dynamic;
    procedure DoShow; dynamic;
    procedure WndProc(var Message: TMessage); virtual;
    function MessageHook(var Msg: TMessage): Boolean; virtual;
    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; virtual;
    property Template: PChar read FTemplate write FTemplate;
    property TemplateModule: HINST read FTemplateModule write FTemplateModule;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; overload; virtual; 
    function Execute(ParentWnd: HWND): Boolean; overload; virtual; abstract; 
    procedure DefaultHandler(var Message); override;
    property Handle: HWnd read FHandle;
  published
    property Ctl3D: Boolean read FCtl3D write FCtl3D default True;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

{ TOpenDialog }

  TOpenOption = (ofReadOnly, ofOverwritePrompt, ofHideReadOnly,
    ofNoChangeDir, ofShowHelp, ofNoValidate, ofAllowMultiSelect,
    ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofCreatePrompt,
    ofShareAware, ofNoReadOnlyReturn, ofNoTestFileCreate, ofNoNetworkButton,
    ofNoLongNames, ofOldStyleDialog, ofNoDereferenceLinks, ofEnableIncludeNotify,
    ofEnableSizing, ofDontAddToRecent, ofForceShowHidden);
  TOpenOptions = set of TOpenOption;

  TOpenOptionEx = (ofExNoPlacesBar);
  TOpenOptionsEx = set of TOpenOptionEx;

  TFileEditStyle = (fsEdit, fsComboBox);
  TOFNotifyEx = type CommDlg.TOFNotifyEx;
  {$NODEFINE TOFNotifyEx}
  TIncludeItemEvent = procedure (const OFN: TOFNotifyEx; var Include: Boolean) of object;

  TOpenDialog = class(TCommonDialog)
  private
    FHistoryList: TStrings;
    FOptions: TOpenOptions;
    FFilter: string;
    FFilterIndex: Integer;
    FCurrentFilterIndex: Integer;
    FInitialDir: string;
    FTitle: string;
    FDefaultExt: string;
    FFileName: TFileName;
    FFiles: TStrings;
    FFileEditStyle: TFileEditStyle;
    FOnSelectionChange: TNotifyEvent;
    FOnFolderChange: TNotifyEvent;
    FOnTypeChange: TNotifyEvent;
    FOnCanClose: TCloseQueryEvent;
    FOnIncludeItem: TIncludeItemEvent;
    FOptionsEx: TOpenOptionsEx;
    function GetFileName: TFileName;
    function GetFilterIndex: Integer;
    procedure ReadFileEditStyle(Reader: TReader);
    procedure SetHistoryList(Value: TStrings);
    procedure SetInitialDir(const Value: string);
  protected
    function CanClose(var OpenFileName: TOpenFileName): Boolean;
    function DoCanClose: Boolean; dynamic;
    function DoExecute(Func: Pointer): Bool; overload;
    function DoExecute(Func: Pointer; ParentWnd: HWND): Bool; overload;
    procedure DoSelectionChange; dynamic;
    procedure DoFolderChange; dynamic;
    procedure DoTypeChange; dynamic;
    procedure DoIncludeItem(const OFN: TOFNotifyEx; var Include: Boolean); dynamic;
    procedure DefineProperties(Filer: TFiler); override;
    procedure GetFileNames(var OpenFileName: TOpenFileName);
    function GetStaticRect: TRect; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(ParentWnd: HWND): Boolean; override;
    property FileEditStyle: TFileEditStyle read FFileEditStyle write FFileEditStyle;
    property Files: TStrings read FFiles;
    property HistoryList: TStrings read FHistoryList write SetHistoryList;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property FileName: TFileName read GetFileName write FFileName;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read GetFilterIndex write FFilterIndex default 1;
    property InitialDir: string read FInitialDir write SetInitialDir;
    property Options: TOpenOptions read FOptions write FOptions default [ofHideReadOnly, ofEnableSizing];
    property OptionsEx: TOpenOptionsEx read FOptionsEx write FOptionsEx default [];
    property Title: string read FTitle write FTitle;
    property OnCanClose: TCloseQueryEvent read FOnCanClose write FOnCanClose;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
    property OnIncludeItem: TIncludeItemEvent read FOnIncludeItem write FOnIncludeItem;
  end;

{ TSaveDialog }

  TSaveDialog = class(TOpenDialog)
    function Execute(ParentWnd: HWND): Boolean; override;
  end;

{ TColorDialog }

  TColorDialogOption = (cdFullOpen, cdPreventFullOpen, cdShowHelp,
    cdSolidColor, cdAnyColor);
  TColorDialogOptions = set of TColorDialogOption;

  TCustomColors = array[0..MaxCustomColors - 1] of Longint;

  TColorDialog = class(TCommonDialog)
  private
    FColor: TColor;
    FOptions: TColorDialogOptions;
    FCustomColors: TStrings;
    procedure SetCustomColors(Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(ParentWnd: HWND): Boolean; override;
  published
    property Color: TColor read FColor write FColor default clBlack;
    property Ctl3D default True;
    property CustomColors: TStrings read FCustomColors write SetCustomColors;
    property Options: TColorDialogOptions read FOptions write FOptions default [];
  end;

{ TFontDialog }

  TFontDialogOption = (fdAnsiOnly, fdTrueTypeOnly, fdEffects,
    fdFixedPitchOnly, fdForceFontExist, fdNoFaceSel, fdNoOEMFonts,
    fdNoSimulations, fdNoSizeSel, fdNoStyleSel,  fdNoVectorFonts,
    fdShowHelp, fdWysiwyg, fdLimitSize, fdScalableOnly, fdApplyButton);
  TFontDialogOptions = set of TFontDialogOption;

  TFontDialogDevice = (fdScreen, fdPrinter, fdBoth);

  TFDApplyEvent = procedure(Sender: TObject; Wnd: HWND) of object;

  TFontDialog = class(TCommonDialog)
  private
    FFont: TFont;
    FDevice: TFontDialogDevice;
    FOptions: TFontDialogOptions;
    FOnApply: TFDApplyEvent;
    FMinFontSize: Integer;
    FMaxFontSize: Integer;
    FFontCharsetModified: Boolean;
    FFontColorModified: Boolean;
    procedure DoApply(Wnd: HWND);
    procedure SetFont(Value: TFont);
    procedure UpdateFromLogFont(const LogFont: TLogFont);
  protected
    procedure Apply(Wnd: HWND); dynamic;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(ParentWnd: HWND): Boolean; override;
  published
    property Font: TFont read FFont write SetFont;
    property Device: TFontDialogDevice read FDevice write FDevice default fdScreen;
    property MinFontSize: Integer read FMinFontSize write FMinFontSize default 0;
    property MaxFontSize: Integer read FMaxFontSize write FMaxFontSize default 0;
    property Options: TFontDialogOptions read FOptions write FOptions default [fdEffects];
    property OnApply: TFDApplyEvent read FOnApply write FOnApply;
  end;

{ TPrinterSetupDialog }

  TPrinterSetupDialog = class(TCommonDialog)
  public
    function Execute(ParentWnd: HWND): Boolean; override;
  end;

{ TPrintDialog }

  TPrintRange = (prAllPages, prSelection, prPageNums);
  TPrintDialogOption = (poPrintToFile, poPageNums, poSelection, poWarning,
    poHelp, poDisablePrintToFile);
  TPrintDialogOptions = set of TPrintDialogOption;

  TPrintDialog = class(TCommonDialog)
  private
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Boolean;
    FOptions: TPrintDialogOptions;
    FPrintToFile: Boolean;
    FPrintRange: TPrintRange;
    FMinPage: Integer;
    FMaxPage: Integer;
    FCopies: Integer;
    procedure SetNumCopies(Value: Integer);
  public
    function Execute(ParentWnd: HWND): Boolean; override;
  published
    property Collate: Boolean read FCollate write FCollate default False;
    property Copies: Integer read FCopies write SetNumCopies default 0;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TPrintDialogOptions read FOptions write FOptions default [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default False;
    property PrintRange: TPrintRange read FPrintRange write FPrintRange default prAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
  end;

  TPrinterOrientation = Printers.TPrinterOrientation;  // required for Form Designer
  TPageSetupDialogOption = (psoDefaultMinMargins, psoDisableMargins,
    psoDisableOrientation, psoDisablePagePainting, psoDisablePaper, psoDisablePrinter,
    psoMargins, psoMinMargins, psoShowHelp, psoWarning, psoNoNetworkButton);
  TPageSetupDialogOptions = set of TPageSetupDialogOption;
  TPrinterKind = (pkDotMatrix, pkHPPCL);
  TPageType = (ptEnvelope, ptPaper);
  TPageSetupBeforePaintEvent = procedure (Sender: TObject; const PaperSize: SmallInt;
    const Orientation: TPrinterOrientation; const PageType: TPageType;
    var DoneDrawing: Boolean) of object;
  TPageMeasureUnits = (pmDefault, pmMillimeters, pmInches);
  TPaintPageEvent = procedure(Sender: TObject; Canvas: TCanvas; PageRect: TRect;
    var DoneDrawing: Boolean) of object;

{ TPageSetupDialog }

  TPageSetupDialog = class(TCommonDialog)
  private
    FOptions: TPageSetupDialogOptions;
    FMinMarginLeft: Integer;
    FMinMarginTop: Integer;
    FMinMarginRight: Integer;
    FMinMarginBottom: Integer;
    FMarginLeft: Integer;
    FMarginTop: Integer;
    FMarginRight: Integer;
    FMarginBottom: Integer;
    FPageWidth: Integer;
    FPageHeight: Integer;
    FPageSetupDlgRec: TPageSetupDlg;
    FBeforePaint: TPageSetupBeforePaintEvent;
    FUnits: TPageMeasureUnits;
    FOnDrawRetAddress: TPaintPageEvent;
    FOnDrawMinMargin: TPaintPageEvent;
    FOnDrawEnvStamp: TPaintPageEvent;
    FOnDrawFullPage: TPaintPageEvent;
    FOnDrawGreekText: TPaintPageEvent;
    FOnDrawMargin: TPaintPageEvent;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute(ParentWnd: HWND): Boolean; override;
    function GetDefaults: Boolean;
    property PageSetupDlgRec: TPageSetupDlg read FPageSetupDlgRec;
  published
    property MinMarginLeft: Integer read FMinMarginLeft write FMinMarginLeft;
    property MinMarginTop: Integer read FMinMarginTop write FMinMarginTop;
    property MinMarginRight: Integer read FMinMarginRight write FMinMarginRight;
    property MinMarginBottom: Integer read FMinMarginBottom write FMinMarginBottom;
    property MarginLeft: Integer read FMarginLeft write FMarginLeft;
    property MarginTop: Integer read FMarginTop write FMarginTop;
    property MarginRight: Integer read FMarginRight write FMarginRight;
    property MarginBottom: Integer read FMarginBottom write FMarginBottom;
    property Options: TPageSetupDialogOptions read FOptions write FOptions
      default [psoDefaultMinMargins];
    property PageWidth: Integer read FPageWidth write FPageWidth;
    property PageHeight: Integer read FPageHeight write FPageHeight;
    property Units: TPageMeasureUnits read FUnits write FUnits default pmDefault;
    property BeforePaint: TPageSetupBeforePaintEvent read FBeforePaint
      write FBeforePaint;
    property OnDrawFullPage: TPaintPageEvent read FOnDrawFullPage write FOnDrawFullPage;
    property OnDrawMinMargin: TPaintPageEvent read FOnDrawMinMargin write FOnDrawMinMargin;
    property OnDrawMargin: TPaintPageEvent read FOnDrawMargin write FOnDrawMargin;
    property OnDrawGreekText: TPaintPageEvent read FOnDrawGreekText write FOnDrawGreekText;
    property OnDrawEnvStamp: TPaintPageEvent read FOnDrawEnvStamp write FOnDrawEnvStamp;
    property OnDrawRetAddress: TPaintPageEvent read FOnDrawRetAddress write FOnDrawRetAddress;                
  end;

{ TFindDialog }

  TFindOption = (frDown, frFindNext, frHideMatchCase, frHideWholeWord,
    frHideUpDown, frMatchCase, frDisableMatchCase, frDisableUpDown,
    frDisableWholeWord, frReplace, frReplaceAll, frWholeWord, frShowHelp);
  TFindOptions = set of TFindOption;

  TFindReplaceFunc = function(var FindReplace: TFindReplace): HWnd stdcall;

  TFindDialog = class(TCommonDialog)
  private
    FOptions: TFindOptions;
    FPosition: TPoint;
    FFindReplaceFunc: TFindReplaceFunc;
    FOnFind: TNotifyEvent;
    FOnReplace: TNotifyEvent;
    FFindHandle: HWnd;
    FFindReplace: TFindReplace;
    FFindText: array[0..255] of Char;
    FReplaceText: array[0..255] of Char;
    function GetFindText: string;
    function GetLeft: Integer;
    function GetPosition: TPoint;
    function GetReplaceText: string;
    function GetTop: Integer;
    procedure SetFindText(const Value: string);
    procedure SetLeft(Value: Integer);
    procedure SetPosition(const Value: TPoint);
    procedure SetReplaceText(const Value: string);
    procedure SetTop(Value: Integer);
    property ReplaceText: string read GetReplaceText write SetReplaceText;
    property OnReplace: TNotifyEvent read FOnReplace write FOnReplace;
  protected
    function MessageHook(var Msg: TMessage): Boolean; override;
    procedure Find; dynamic;
    procedure Replace; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseDialog;
    function Execute(ParentWnd: HWND): Boolean; override;
    property Left: Integer read GetLeft write SetLeft;
    property Position: TPoint read GetPosition write SetPosition;
    property Top: Integer read GetTop write SetTop;
  published
    property FindText: string read GetFindText write SetFindText;
    property Options: TFindOptions read FOptions write FOptions default [frDown];
    property OnFind: TNotifyEvent read FOnFind write FOnFind;
  end;

{ TReplaceDialog }

  TReplaceDialog = class(TFindDialog)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ReplaceText;
    property OnReplace;
  end;

{ TCustomFileDialog }

  EPlatformVersionException = class(Exception);

  TFileDialogOption = (fdoOverWritePrompt, fdoStrictFileTypes,
    fdoNoChangeDir, fdoPickFolders, fdoForceFileSystem,
    fdoAllNonStorageItems, fdoNoValidate, fdoAllowMultiSelect,
    fdoPathMustExist, fdoFileMustExist, fdoCreatePrompt,
    fdoShareAware, fdoNoReadOnlyReturn, fdoNoTestFileCreate,
    fdoHideMRUPlaces, fdoHidePinnedPlaces, fdoNoDereferenceLinks,
    fdoDontAddToRecent, fdoForceShowHidden, fdoDefaultNoMiniMode,
    fdoForcePreviewPaneOn);
  TFileDialogOptions = set of TFileDialogOption;

  TFileDialogOverwriteResponse = (forDefault = FDEOR_DEFAULT,
    forAccept = FDEOR_ACCEPT, forRefuse = FDEOR_REFUSE);
  TFileDialogShareViolationResponse = (fsrDefault = FDESVR_DEFAULT,
    fsrAccept = FDESVR_ACCEPT, fsrRefuse = FDESVR_REFUSE);

  TFileDialogCloseEvent = procedure(Sender: TObject; var CanClose: Boolean) of object;
  TFileDialogFolderChangingEvent = procedure(Sender: TObject; var CanChange: Boolean) of object;
  TFileDialogOverwriteEvent = procedure(Sender: TObject;
    var Response: TFileDialogOverwriteResponse) of object;
  TFileDialogShareViolationEvent = procedure(Sender: TObject;
    var Response: TFileDialogShareViolationResponse) of object;

  TFileTypeItem = class(TCollectionItem)
  private
    FDisplayName: string;
    FDisplayNameWStr: LPCWSTR;
    FFileMask: string;
    FFileMaskWStr: LPCWSTR;
    function GetDisplayNameWStr: LPCWSTR;
    function GetFileMaskWStr: LPCWSTR;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property DisplayNameWStr: LPCWSTR read GetDisplayNameWStr;
    property FileMaskWStr: LPCWSTR read GetFileMaskWStr;
  published
    property DisplayName: string read FDisplayName write FDisplayName;
    property FileMask: string read FFileMask write FFileMask;
  end;

  TFileTypeItems = class(TCollection)
  private
    function GetItem(Index: Integer): TFileTypeItem;
    procedure SetItem(Index: Integer; const Value: TFileTypeItem);
  public
    function Add: TFileTypeItem;
    function FilterSpecArray: TComdlgFilterSpecArray;
    property Items[Index: Integer]: TFileTypeItem read GetItem write SetItem; default;
  end;

  TFavoriteLinkItem = class(TCollectionItem)
  private
    FLocation: string;
  published
  protected
    function GetDisplayName: string; override;
  published
    property Location: string read FLocation write FLocation;
  end;

  TFavoriteLinkItems = class;

  TFavoriteLinkItemsEnumerator = class
  private
    FIndex: Integer;
    FCollection: TFavoriteLinkItems;
  public
    constructor Create(ACollection: TFavoriteLinkItems);
    function GetCurrent: TFavoriteLinkItem;
    function MoveNext: Boolean;
    property Current: TFavoriteLinkItem read GetCurrent;
  end;

  TFavoriteLinkItems = class(TCollection)
  private
    function GetItem(Index: Integer): TFavoriteLinkItem;
    procedure SetItem(Index: Integer; const Value: TFavoriteLinkItem);
  public
    function Add: TFavoriteLinkItem;
    function GetEnumerator: TFavoriteLinkItemsEnumerator;
    property Items[Index: Integer]: TFavoriteLinkItem read GetItem write SetItem; default;
  end;

  TCustomFileDialog = class(TComponent)
  private
    FClientGuid: string;
    FDefaultExtension: string;
    FDefaultFolder: string;
    FDialog: IFileDialog;
    FFavoriteLinks: TFavoriteLinkItems;
    FFileName: TFileName;
    FFileNameLabel: string;
    FFiles: TStrings;
    FFileTypeIndex: Cardinal;
    FFileTypes: TFileTypeItems;
    FHandle: HWnd;
    FOkButtonLabel: string;
    FOptions: TFileDialogOptions;
    FShellItem: IShellItem;
    FShellItems: IShellItemArray;
    FTitle: string;
    FOnExecute: TNotifyEvent;
    FOnFileOkClick: TFileDialogCloseEvent;
    FOnFolderChange: TNotifyEvent;
    FOnFolderChanging: TFileDialogFolderChangingEvent;
    FOnOverwrite: TFileDialogOverwriteEvent;
    FOnSelectionChange: TNotifyEvent;
    FOnShareViolation: TFileDialogShareViolationEvent;
    FOnTypeChange: TNotifyEvent;
    function GetDefaultFolder: string;
    function GetFileName: TFileName;
    function GetFiles: TStrings;
    procedure GetWindowHandle;
    procedure SetClientGuid(const Value: string);
    procedure SetDefaultFolder(const Value: string);
    procedure SetFavoriteLinks(const Value: TFavoriteLinkItems);
    procedure SetFileName(const Value: TFileName);
    procedure SetFileTypes(const Value: TFileTypeItems);
  strict protected
    function CreateFileDialog: IFileDialog; virtual; abstract;
    procedure DoOnExecute; dynamic;
    function DoOnFileOkClick: Boolean; dynamic;
    procedure DoOnFolderChange; dynamic;
    function DoOnFolderChanging: Boolean; dynamic;
    procedure DoOnOverwrite(var Response: TFileDialogOverwriteResponse); dynamic;
    procedure DoOnSelectionChange; dynamic;
    procedure DoOnShareViolation(var Response: TFileDialogShareViolationResponse); dynamic;
    procedure DoOnTypeChange; dynamic;
    function GetFileNames(Items: IShellItemArray): HResult; dynamic;
    function GetItemName(Item: IShellItem; var ItemName: TFileName): HResult; dynamic;
    function GetResults: HResult; virtual;
  protected
    function FileOkClick: HResult; dynamic;
    function FolderChange: HResult; dynamic;
    function FolderChanging(psiFolder: IShellItem): HResult; dynamic;
    function Overwrite(psiFile: IShellItem; var Response: Cardinal): HResult; dynamic;
    function SelectionChange: HResult; dynamic;
    function ShareViolation(psiFile: IShellItem; var Response: Cardinal): HResult; dynamic;
    function TypeChange: HResult; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; overload; virtual;
    function Execute(ParentWnd: HWND): Boolean; overload; virtual;
    property ClientGuid: string read FClientGuid write SetClientGuid;
    property DefaultExtension: string read FDefaultExtension write FDefaultExtension;
    property DefaultFolder: string read GetDefaultFolder write SetDefaultFolder;
    property Dialog: IFileDialog read FDialog;
    property FavoriteLinks: TFavoriteLinkItems read FFavoriteLinks write SetFavoriteLinks;
    property FileName: TFileName read GetFileName write SetFileName;
    property FileNameLabel: string read FFileNameLabel write FFileNameLabel;
    property Files: TStrings read GetFiles;
    property FileTypes: TFileTypeItems read FFileTypes write SetFileTypes;
    property FileTypeIndex: Cardinal read FFileTypeIndex write FFileTypeIndex default 1;
    property Handle: HWnd read FHandle;
    property OkButtonLabel: string read FOkButtonLabel write FOkButtonLabel;
    property Options: TFileDialogOptions read FOptions write FOptions;
    property ShellItem: IShellItem read FShellItem;
    property ShellItems: IShellItemArray read FShellItems;
    property Title: string read FTitle write FTitle;
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    property OnFileOkClick: TFileDialogCloseEvent read FOnFileOkClick write FOnFileOkClick;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnFolderChanging: TFileDialogFolderChangingEvent read FOnFolderChanging write FOnFolderChanging;
    property OnOverwrite: TFileDialogOverwriteEvent read FOnOverwrite write FOnOverwrite;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnShareViolation: TFileDialogShareViolationEvent read FOnShareViolation write FOnShareViolation;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
  end;

{ TFileOpenDialog }

  TCustomFileOpenDialog = class(TCustomFileDialog)
  protected
    function CreateFileDialog: IFileDialog; override;
    function GetResults: HResult; override;
    function SelectionChange: HResult; override;
  end;

  TFileOpenDialog = class(TCustomFileOpenDialog)
  published
    property ClientGuid;
    property DefaultExtension;
    property DefaultFolder;
    property FavoriteLinks;
    property FileName;
    property FileNameLabel;
    property FileTypes;
    property FileTypeIndex;
    property OkButtonLabel;
    property Options;
    property Title;
    property OnExecute;
    property OnFileOkClick;
    property OnFolderChange;
    property OnFolderChanging;
    property OnSelectionChange;
    property OnShareViolation;
    property OnTypeChange;
  end platform;

{ TFileSaveDialog }

  TCustomFileSaveDialog = class(TCustomFileDialog)
  protected
    function CreateFileDialog: IFileDialog; override;
  end;

  TFileSaveDialog = class(TCustomFileSaveDialog)
  published
    property ClientGuid;
    property DefaultExtension;
    property DefaultFolder;
    property FavoriteLinks;
    property FileName;
    property FileNameLabel;
    property FileTypes;
    property FileTypeIndex;
    property OkButtonLabel;
    property Options;
    property Title;
    property OnExecute;
    property OnFileOkClick;
    property OnFolderChange;
    property OnFolderChanging;
    property OnOverwrite;
    property OnSelectionChange;
    property OnShareViolation;
    property OnTypeChange;
  end platform;

{ TTaskDialog }

const
  tdiNone = 0;
  tdiWarning = 1;
  tdiError = 2;
  tdiInformation = 3;
  tdiShield = 4;

type
  TCustomTaskDialog = class;

  TTaskDialogFlag = (tfEnableHyperlinks, tfUseHiconMain,
    tfUseHiconFooter, tfAllowDialogCancellation,
    tfUseCommandLinks, tfUseCommandLinksNoIcon,
    tfExpandFooterArea, tfExpandedByDefault,
    tfVerificationFlagChecked, tfShowProgressBar,
    tfShowMarqueeProgressBar, tfCallbackTimer,
    tfPositionRelativeToWindow, tfRtlLayout,
    tfNoDefaultRadioButton, tfCanBeMinimized);
  TTaskDialogFlags = set of TTaskDialogFlag;

  TTaskDialogCommonButton = (tcbOk, tcbYes, tcbNo, tcbCancel, tcbRetry, tcbClose);
  TTaskDialogCommonButtons = set of TTaskDialogCommonButton;

  TTaskDialogIcon = Low(Integer)..High(Integer);

  TProgressBarState = (pbsNormal, pbsError, pbsPaused);

  TTaskDialogProgressBar = class(TPersistent)
  private
    FClient: TCustomTaskDialog;
    FMarqueeSpeed: Cardinal;
    FMax: Integer;
    FMin: Integer;
    FPosition: Integer;
    FState: TProgressBarState;
    procedure SetMarqueeSpeed(const Value: Cardinal);
    procedure SetMax(const Value: Integer);
    procedure SetMin(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetState(const Value: TProgressBarState);
  public
    constructor Create(AClient: TCustomTaskDialog);
    procedure Initialize;
  published
    property MarqueeSpeed: Cardinal read FMarqueeSpeed write SetMarqueeSpeed default 0;
    property Max: Integer read FMax write SetMax default 100;
    property Min: Integer read FMin write SetMin default 0;
    property Position: Integer read FPosition write SetPosition default 0;
    property State: TProgressBarState read FState write SetState default pbsNormal;
  end;

  TTaskDialogBaseButtonItem = class(TCollectionItem)
  private
    FCaption: string;
    FClient: TCustomTaskDialog;
    FEnabled: Boolean;
    FModalResult: TModalResult;
    FTextWStr: LPCWSTR;
    function GetDefault: Boolean;
    function GetTextWStr: LPCWSTR;
    procedure SetCaption(const Value: string);
    procedure SetDefault(const Value: Boolean);
    procedure SetEnabled(const Value: Boolean);
  strict protected
    procedure DoButtonClick; virtual;
    procedure DoSetEnabled; virtual;
    function GetButtonText: string; virtual;
    function GetDisplayName: string; override;
    property Client: TCustomTaskDialog read FClient;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Click;
    procedure SetInitialState; virtual;
    property ModalResult: TModalResult read FModalResult write FModalResult;
    property TextWStr: LPCWSTR read GetTextWStr;
  published
    property Caption: string read FCaption write SetCaption;
    property Default: Boolean read GetDefault write SetDefault default False;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

  TTaskDialogButtonItem = class(TTaskDialogBaseButtonItem)
  private
    FCommandLinkHint: string;
    FElevationRequired: Boolean;
    procedure DoSetElevationRequired;
    procedure SetElevationRequired(const Value: Boolean);
  strict protected
    function GetButtonText: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure SetInitialState; override;
  published
    property CommandLinkHint: string read FCommandLinkHint write FCommandLinkHint;
    property ElevationRequired: Boolean read FElevationRequired write SetElevationRequired default False;
    property ModalResult;
  end;

  TTaskDialogRadioButtonItem = class(TTaskDialogBaseButtonItem)
  strict protected
    procedure DoButtonClick; override;
    procedure DoSetEnabled; override;
  public
    constructor Create(Collection: TCollection); override;
  end;

  TTaskDialogButtonList = array of TTaskDialogButton;

  TTaskDialogButtons = class;

  TTaskDialogButtonsEnumerator = class
  private
    FIndex: Integer;
    FCollection: TTaskDialogButtons;
  public
    constructor Create(ACollection: TTaskDialogButtons);
    function GetCurrent: TTaskDialogBaseButtonItem;
    function MoveNext: Boolean;
    property Current: TTaskDialogBaseButtonItem read GetCurrent;
  end;

  TTaskDialogButtons = class(TOwnedCollection)
  private
    FButtonList:  TTaskDialogButtonList;
    FDefaultButton: TTaskDialogBaseButtonItem;
    function GetItem(Index: Integer): TTaskDialogBaseButtonItem;
    procedure SetDefaultButton(const Value: TTaskDialogBaseButtonItem);
    procedure SetItem(Index: Integer; const Value: TTaskDialogBaseButtonItem);
  public
    function Add: TTaskDialogBaseButtonItem;
    function Buttons: PTaskDialogButton;
    function FindButton(AModalResult: TModalResult): TTaskDialogBaseButtonItem;
    function GetEnumerator: TTaskDialogButtonsEnumerator;
    procedure SetInitialState; dynamic;
    property DefaultButton: TTaskDialogBaseButtonItem read FDefaultButton write SetDefaultButton;
    property Items[Index: Integer]: TTaskDialogBaseButtonItem read GetItem write SetItem; default;
  end;

  TTaskDlgClickEvent = procedure(Sender: TObject; ModalResult: TModalResult; var CanClose: Boolean) of object;
  TTaskDlgTimerEvent = procedure(Sender: TObject; TickCount: Cardinal; var Reset: Boolean) of object;

  TCustomTaskDialog = class(TComponent)
  private
    FButton: TTaskDialogButtonItem;
    FButtons: TTaskDialogButtons;
    FCaption: string;
    FCommonButtons: TTaskDialogCommonButtons;
    FCustomFooterIcon: TIcon;
    FCustomMainIcon: TIcon;
    FDefaultButton: TTaskDialogCommonButton;
    FExpandButtonCaption: string;
    FExpanded: Boolean;
    FExpandedText: string;
    FFlags: TTaskDialogFlags;
    FFooterIcon: TTaskDialogIcon;
    FFooterText: string;
    FHandle: HWND;
    FHelpContext: Integer;
    FMainIcon: TTaskDialogIcon;
    FModalResult: TModalResult;
    FProgressBar: TTaskDialogProgressBar;
    FRadioButton: TTaskDialogRadioButtonItem;
    FRadioButtons: TTaskDialogButtons;
    FText: string;
    FTitle: string;
    FURL: string;
    FVerificationText: string;
    FOnButtonClicked: TTaskDlgClickEvent;
    FOnDialogConstructed: TNotifyEvent;
    FOnDialogCreated: TNotifyEvent;
    FOnDialogDestroyed: TNotifyEvent;
    FOnExpanded: TNotifyEvent;
    FOnHyperlinkClicked: TNotifyEvent;
    FOnNavigated: TNotifyEvent;
    FOnRadioButtonClicked: TNotifyEvent;
    FOnTimer: TTaskDlgTimerEvent;
    FOnVerificationClicked: TNotifyEvent;
    procedure SetButtons(const Value: TTaskDialogButtons);
    procedure SetExpandedText(const Value: string);
    procedure SetFooterIcon(const Value: TTaskDialogIcon);
    procedure SetFooterText(const Value: string);
    procedure SetFlags(const Value: TTaskDialogFlags);
    procedure SetMainIcon(const Value: TTaskDialogIcon);
    procedure SetRadioButtons(const Value: TTaskDialogButtons);
    procedure SetText(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetCustomFooterIcon(const Value: TIcon);
    procedure SetCustomMainIcon(const Value: TIcon);
  strict protected
    function DoExecute(ParentWnd: HWND): Boolean; dynamic;
    procedure DoOnButtonClicked(AModalResult: Integer; var CanClose: Boolean); dynamic;
    procedure DoOnDialogContructed; dynamic;
    procedure DoOnDialogCreated; dynamic;
    procedure DoOnDialogDestroyed; dynamic;
    procedure DoOnExpandButtonClicked(Expanded: Boolean); dynamic;
    procedure DoOnHelp; dynamic;
    procedure DoOnHyperlinkClicked(const AURL: string); dynamic;
    procedure DoOnNavigated; dynamic;
    procedure DoOnRadioButtonClicked(ButtonID: Integer); dynamic;
    procedure DoOnTimer(TickCount: Cardinal; var Reset: Boolean); dynamic;
    procedure DoOnVerificationClicked(Checked: Boolean); dynamic;
  protected
    function CallbackProc(hwnd: HWND; msg: UINT; wParam: WPARAM;
      lParam: LPARAM; lpRefData: LONG_PTR): HResult; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; overload;
    function Execute(ParentWnd: HWND): Boolean; overload;
    property Button: TTaskDialogButtonItem read FButton write FButton;
    property Buttons: TTaskDialogButtons read FButtons write SetButtons;
    property Caption: string read FCaption write FCaption;
    property CommonButtons: TTaskDialogCommonButtons read FCommonButtons write FCommonButtons default [tcbOk, tcbCancel];
    property CustomFooterIcon: TIcon read FCustomFooterIcon write SetCustomFooterIcon;
    property CustomMainIcon: TIcon read FCustomMainIcon write SetCustomMainIcon;
    property DefaultButton: TTaskDialogCommonButton read FDefaultButton write FDefaultButton default tcbOk;
    property ExpandButtonCaption: string read FExpandButtonCaption write FExpandButtonCaption;
    property Expanded: Boolean read FExpanded;
    property ExpandedText: string read FExpandedText write SetExpandedText;
    property Flags: TTaskDialogFlags read FFlags write SetFlags default [tfAllowDialogCancellation];
    property FooterIcon: TTaskDialogIcon read FFooterIcon write SetFooterIcon default tdiNone;
    property FooterText: string read FFooterText write SetFooterText;
    property Handle: HWND read FHandle;
    property HelpContext: Integer read FHelpContext write FHelpContext default 0;
    property MainIcon: TTaskDialogIcon read FMainIcon write SetMainIcon default tdiInformation;
    property ModalResult: TModalResult read FModalResult write FModalResult;
    property ProgressBar: TTaskDialogProgressBar read FProgressBar write FProgressBar;
    property RadioButton: TTaskDialogRadioButtonItem read FRadioButton;
    property RadioButtons: TTaskDialogButtons read FRadioButtons write SetRadioButtons;
    property Text: string read FText write SetText;
    property Title: string read FTitle write SetTitle;
    property URL: string read FURL;
    property VerificationText: string read FVerificationText write FVerificationText;
    property OnButtonClicked: TTaskDlgClickEvent read FOnButtonClicked write FOnButtonClicked;
    property OnDialogConstructed: TNotifyEvent read FOnDialogConstructed write FOnDialogConstructed;
    property OnDialogCreated: TNotifyEvent read FOnDialogCreated write FOnDialogCreated;
    property OnDialogDestroyed: TNotifyEvent read FOnDialogDestroyed write FOnDialogDestroyed;
    property OnExpanded: TNotifyEvent read FOnExpanded write FOnExpanded;
    property OnHyperlinkClicked: TNotifyEvent read FOnHyperlinkClicked write FOnHyperlinkClicked;
    property OnNavigated: TNotifyEvent read FOnNavigated write FOnNavigated;
    property OnRadioButtonClicked: TNotifyEvent read FOnRadioButtonClicked write FOnRadioButtonClicked;
    property OnTimer: TTaskDlgTimerEvent read FOnTimer write FOnTimer;
    property OnVerificationClicked: TNotifyEvent read FOnVerificationClicked write FOnVerificationClicked;
  end;

  TTaskDialog = class(TCustomTaskDialog)
  published
    property Buttons;
    property Caption;
    property CommonButtons;
    property CustomFooterIcon;
    property CustomMainIcon;
    property DefaultButton;
    property ExpandButtonCaption;
    property ExpandedText;
    property Flags;
    property FooterIcon;
    property FooterText;
    property HelpContext;
    property MainIcon;
    property ProgressBar;
    property RadioButtons;
    property Text;
    property Title;
    property VerificationText;
    property OnButtonClicked;
    property OnDialogConstructed;
    property OnDialogCreated;
    property OnDialogDestroyed;
    property OnExpanded;
    property OnHyperlinkClicked;
    property OnNavigated;
    property OnRadioButtonClicked;
    property OnTimer;
    property OnVerificationClicked;
  end platform;

{ Message dialog }

type
  TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);
  TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore,
    mbAll, mbNoToAll, mbYesToAll, mbHelp);
  TMsgDlgButtons = set of TMsgDlgBtn;

const
  mbYesNo = [mbYes, mbNo];
  mbYesNoCancel = [mbYes, mbNo, mbCancel];
  mbYesAllNoAllCancel = [mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel];
  mbOKCancel = [mbOK, mbCancel];
  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];
  mbAbortIgnore = [mbAbort, mbIgnore];

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): TForm; overload;
function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): TForm; overload;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;

function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer; overload;
function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer; overload;
function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer; overload;

{ TaskDialog based Message dialogs }

function TaskMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
function TaskMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;

function TaskMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer; overload;
function TaskMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;

function TaskMessageDlgPosHelp(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer; overload;
function TaskMessageDlgPosHelp(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer; overload;

procedure ShowMessage(const Msg: string);
procedure ShowMessageFmt(const Msg: string; Params: array of const);
procedure ShowMessagePos(const Msg: string; X, Y: Integer);

{ Input dialog }

function InputBox(const ACaption, APrompt, ADefault: string): string;
function InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;

function PromptForFileName(var AFileName: string; const AFilter: string = '';
  const ADefaultExt: string = ''; const ATitle: string = '';
  const AInitialDir: string = ''; SaveDialog: Boolean = False): Boolean;

{ Win98 and Win2k will default to the "My Documents" folder if the InitialDir
  property is empty and no files of the filtered type are contained in the
  current directory. Set this flag to True to force TOpenDialog and descendents
  to always open in the current directory when InitialDir is empty. (Same
  behavior as setting InitialDir to '.') }
var
  ForceCurrentDirectory: Boolean = False;
  UseLatestCommonDialogs: Boolean = True;

implementation

uses
  ExtCtrls, Consts, Dlgs, Math, ActiveX, StrUtils, WideStrUtils, 
  Themes, MultiMon, HelpIntfs;

{ Private globals }

var
  CreationControl: TCommonDialog = nil;
  HelpMsg: Cardinal;
  FindMsg: Cardinal;
  WndProcPtrAtom: TAtom = 0;

{ Center the given window on the screen }

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
  Monitor: TMonitor;
begin
  GetWindowRect(Wnd, Rect);
  if Application.MainForm <> nil then
  begin
    if Assigned(Screen.ActiveForm) then
      Monitor := Screen.ActiveForm.Monitor
    else
      Monitor := Application.MainForm.Monitor;
  end
  else
    Monitor := Screen.Monitors[0];
  SetWindowPos(Wnd, 0,
    Monitor.Left + ((Monitor.Width - Rect.Right + Rect.Left) div 2),
    Monitor.Top + ((Monitor.Height - Rect.Bottom + Rect.Top) div 3),
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{ Generic dialog hook. Centers the dialog on the screen in response to
  the WM_INITDIALOG message }

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CenterWindow(Wnd);
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end;
end;

{ TRedirectorWindow }
{ A redirector window is used to put the find/replace dialog into the
  ownership chain of a form, but intercept messages that CommDlg.dll sends
  exclusively to the find/replace dialog's owner.  TRedirectorWindow
  creates its hidden window handle as owned by the target form, and the
  find/replace dialog handle is created as owned by the redirector.  The
  redirector wndproc forwards all messages to the find/replace component.
}

type
  TRedirectorWindow = class(TWinControl)
  private
    FCommonDialog: TCommonDialog;
    FFormHandle: THandle;
    procedure CMRelease(var Message); message CM_Release;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;
  end;

procedure TRedirectorWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_VISIBLE or WS_POPUP;
    WndParent := FFormHandle;
  end;
end;

procedure TRedirectorWindow.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  with Message do
  begin
    if (Result = 0) and (Msg <> CM_RELEASE) and Assigned(FCommonDialog) then
      Result := Integer(FCommonDialog.MessageHook(Message));
    if (Result = 0) and (Msg = WM_SETFOCUS) and (FFormHandle <> 0) then
      Result := SendMessage(FFormHandle, WM_SETFOCUS, wParam, lParam);
  end;
end;

procedure TRedirectorWindow.CMRelease(var Message);
begin
  Free;
end;

{ TCommonDialog }

constructor TCommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCtl3D := True;
{$IFDEF MSWINDOWS}
  FObjectInstance := Classes.MakeObjectInstance(MainWndProc);
{$ENDIF}
{$IFDEF LINUX}
  FObjectInstance := WinUtils.MakeObjectInstance(MainWndProc);
{$ENDIF}
end;

destructor TCommonDialog.Destroy;
begin
{$IFDEF MSWINDOWS}
  if FObjectInstance <> nil then Classes.FreeObjectInstance(FObjectInstance);
{$ENDIF}
{$IFDEF LINUX}
  if FObjectInstance <> nil then WinUtils.FreeObjectInstance(FObjectInstance);
{$ENDIF}
  if Assigned(FRedirector) then
    TRedirectorWindow(FRedirector).FCommonDialog := nil;
  FreeAndNil(FRedirector);
  inherited Destroy;
end;

function TCommonDialog.Execute: Boolean;
var
  ParentWnd: HWND;
begin
  if Application.ModalPopupMode <> pmNone then
  begin
    ParentWnd := Application.ActiveFormHandle;
    if ParentWnd = 0 then
      ParentWnd := Application.Handle;
  end
  else
    ParentWnd := Application.Handle;
  Result := Execute(ParentWnd);
end;

function TCommonDialog.MessageHook(var Msg: TMessage): Boolean;
begin
  Result := False;
  if (Msg.Msg = HelpMsg) and (FHelpContext <> 0) then
  begin
    Application.HelpContext(FHelpContext);
    Result := True;
  end;
end;

procedure TCommonDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, LParam)
  else inherited DefaultHandler(Message);
end;

procedure TCommonDialog.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TCommonDialog.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

procedure TCommonDialog.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  DoClose;
end;

procedure TCommonDialog.WMInitDialog(var Message: TWMInitDialog);
begin
  { Called only by non-explorer style dialogs }
  DoShow;
  { Prevent any further processing }
  Message.Result := 0;
end;

procedure TCommonDialog.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
end;

function TCommonDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
type
  TDialogFunc = function(var DialogData): Bool stdcall;
var
  ActiveWindow: HWnd;
  WindowList: Pointer;
  FPUControlWord: Word;
  FocusState: TFocusState;
begin
  ActiveWindow := Application.ActiveFormHandle;
  WindowList := DisableTaskWindows(0);
  FocusState := SaveFocusState;
  try
    asm
      // Avoid FPU control word change in NETRAP.dll, NETAPI32.dll, etc
      FNSTCW  FPUControlWord
    end;
    try
      CreationControl := Self;
      Result := TDialogFunc(DialogFunc)(DialogData);
    finally
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
    end;
  finally
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
    RestoreFocusState(FocusState);
    FreeAndNil(FRedirector);
  end;
end;

procedure TCommonDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TCommonDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

{ Vista support }

type
  TFileDialogWrapper = class(TObject)
  private
    procedure AssignFileTypes;
    procedure AssignOptions;
    procedure OnFileOkEvent(Sender: TObject; var CanClose: Boolean);
    procedure OnFolderChangeEvent(Sender: TObject);
    procedure OnSelectionChangeEvent(Sender: TObject);
    procedure OnTypeChangeEvent(Sender: TObject);
  protected
    FFileDialog: TCustomFileDialog;
    FOpenDialog: TOpenDialog;
    function CreateFileDialog: TCustomFileDialog; virtual; abstract;
  public
    constructor Create(OpenDialog: TOpenDialog);
    destructor Destroy; override;
    function Execute(ParentWnd: HWND): Boolean;
  end;

  TFileOpenDialogWrapper = class(TFileDialogWrapper)
  private
    procedure OnExecuteEvent(Sender: TObject);
  protected
    function CreateFileDialog: TCustomFileDialog; override;
  end;

  TFileSaveDialogWrapper = class(TFileDialogWrapper)
  protected
    function CreateFileDialog: TCustomFileDialog; override;
  end;

{ TFileDialogWrapper }

constructor TFileDialogWrapper.Create(OpenDialog: TOpenDialog);
begin
  inherited Create;
  FOpenDialog := OpenDialog;
  FFileDialog := CreateFileDialog;
end;

destructor TFileDialogWrapper.Destroy;
begin
  FFileDialog.Free;
  inherited;
end;

procedure TFileDialogWrapper.AssignFileTypes;
var
  I, J: Integer;
  FilterStr: string;
begin
  FilterStr := FOpenDialog.Filter;
  J := 1;
  I := AnsiPos('|', FilterStr);
  while I <> 0 do
    with FFileDialog.Filetypes.Add do
    begin
      DisplayName := Copy(FilterStr, J, I - J);
      if not SysLocale.FarEast then
        J := PosEx('|', FilterStr, I + 1)
      else
      begin
        J := AnsiPos('|', Copy(FilterStr, I + 1, MAXINT));
        if J <> 0 then J := J + (I + 1) - 1;
      end;
      if J = 0 then J := Length(FilterStr) + 1;
      FileMask := Copy(FilterStr, I + 1, J - I - 1);
      Inc(J);

      if not SysLocale.FarEast then
        I := PosEx('|', FilterStr, J)
      else
      begin
        I := AnsiPos('|', Copy(FilterStr, J, MAXINT));
        if I <> 0 then I := I + J - 1;
      end;
    end;
end;

procedure TFileDialogWrapper.AssignOptions;
const
  CDialogOptionsMap: array[TOpenOption] of TFileDialogOptions = (
    [] {ofReadOnly}, [fdoOverWritePrompt], [] {ofHideReadOnly},
    [fdoNoChangeDir], [] {ofShowHelp}, [fdoNoValidate], [fdoAllowMultiSelect],
    [fdoStrictFileTypes], [fdoPathMustExist], [fdoFileMustExist],
    [fdoCreatePrompt], [fdoShareAware], [fdoNoReadOnlyReturn],
    [fdoNoTestFileCreate], [] {ofNoNetworkButton}, [] {ofNoLongNames},
    [] {ofOldStyleDialog}, [fdoNoDereferenceLinks], [] {ofEnableIncludeNotify},
    [] {ofEnableSizing}, [fdoDontAddToRecent], [fdoForceShowHidden]);
var
  LOption: TOpenOption;
begin
  for LOption := Low(LOption) to High(LOption) do
    if LOption in FOpenDialog.Options then
      FFileDialog.Options := FFileDialog.Options + CDialogOptionsMap[LOption];
  if ofExNoPlacesBar in FOpenDialog.OptionsEx then
    FFileDialog.Options := FFileDialog.Options + [fdoHidePinnedPlaces];
end;

function TFileDialogWrapper.Execute(ParentWnd: HWND): Boolean;
begin
  with FOpenDialog do
  begin
    FFileDialog.DefaultExtension := DefaultExt;
    FFileDialog.DefaultFolder := InitialDir;
    FFileDialog.FileName := FileName;
    FFileDialog.FileTypeIndex := FilterIndex;
    FFileDialog.Title := Title;
    if Assigned(OnCanClose) then
      FFileDialog.OnFileOkClick := OnFileOkEvent;
    if Assigned(OnFolderChange) then
      FFileDialog.OnFolderChange := OnFolderChangeEvent;
    if Assigned(OnSelectionChange) then
      FFileDialog.OnSelectionChange := OnSelectionChangeEvent;
    if Assigned(OnTypeChange) then
      FFileDialog.OnTypeChange := OnTypeChangeEvent;
  end;
  AssignFileTypes;
  AssignOptions;

  Result := FFileDialog.Execute(ParentWnd);
  if Result then
  begin
    FOpenDialog.FileName := FFileDialog.FileName;
    FOpenDialog.Files.Assign(FFileDialog.Files);
  end;
end;

procedure TFileDialogWrapper.OnFileOkEvent(Sender: TObject; var CanClose: Boolean);
begin
  with FOpenDialog do
  begin
    FileName := FFileDialog.FileName;
    Files.Assign(FFileDialog.Files);
  end;
  FOpenDialog.OnCanClose(FOpenDialog, CanClose);
end;

procedure TFileDialogWrapper.OnFolderChangeEvent(Sender: TObject);
begin
  with FOpenDialog do
  begin
    FileName := FFileDialog.FileName;
    OnFolderChange(FOpenDialog);
  end;
end;

procedure TFileDialogWrapper.OnSelectionChangeEvent(Sender: TObject);
begin
  with FOpenDialog do
  begin
    FileName := FFileDialog.FileName;
    Files.Assign(FFileDialog.Files);
    OnSelectionChange(FOpenDialog);
  end;
end;

procedure TFileDialogWrapper.OnTypeChangeEvent(Sender: TObject);
begin
  with FOpenDialog do
  begin
    FilterIndex := FFileDialog.FileTypeIndex;
    OnTypeChange(FOpenDialog);
  end;
end;

{ TFileOpenDialogWrapper }

function TFileOpenDialogWrapper.CreateFileDialog: TCustomFileDialog;
begin
  Result := TFileOpenDialog.Create(nil);
  Result.OnExecute := OnExecuteEvent;
end;

procedure TFileOpenDialogWrapper.OnExecuteEvent(Sender: TObject);
var
  LOptions: Cardinal;
begin
  if FOpenDialog.ClassName = 'TOpenPictureDialog' then // do not localize
  begin
    FFileDialog.Dialog.GetOptions(LOptions);
    LOptions := LOptions or FOS_FORCEPREVIEWPANEON;
    FFileDialog.Dialog.SetOptions(LOptions);
  end;
end;

{ TFileSaveDialogWrapper }

function TFileSaveDialogWrapper.CreateFileDialog: TCustomFileDialog;
begin
  Result := TFileSaveDialog.Create(nil);
end;


{ Open and Save dialog routines }

function ExplorerHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CreationControl.FHandle := Wnd;
    CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
      Longint(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
  end
  else if (Msg = WM_NOTIFY) and (POFNotify(LParam)^.hdr.code = CDN_INITDONE) then
    CenterWindow(GetWindowLong(Wnd, GWL_HWNDPARENT));
end;

{ TOpenDialog }

constructor TOpenDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHistoryList := TStringList.Create;
  FOptions := [ofHideReadOnly, ofEnableSizing];
  FOptionsEx := [];
  FFiles := TStringList.Create;
  FFilterIndex := 1;
  FFileEditStyle := fsEdit;
end;

destructor TOpenDialog.Destroy;
begin
  FFiles.Free;
  FHistoryList.Free;
  inherited Destroy;
end;

function TOpenDialog.CanClose(var OpenFileName: TOpenFileName): Boolean;
begin
  GetFileNames(OpenFileName);
  Result := DoCanClose;
  FFiles.Clear;
end;

procedure TOpenDialog.WndProc(var Message: TMessage);
var
  Index: Integer;
  Include: Boolean;
begin
  Message.Result := 0;
  { If not ofOldStyleDialog then DoShow on CDN_INITDONE, not WM_INITDIALOG }
  if (Message.Msg = WM_INITDIALOG) and not (ofOldStyleDialog in Options) then Exit
  else if (Message.Msg = WM_NOTIFY) then
    case (POFNotify(Message.LParam)^.hdr.code) of
      CDN_FILEOK:
        if not CanClose(POFNotify(Message.LParam)^.lpOFN^) then
        begin
          Message.Result := 1;
          SetWindowLong(Handle, DWL_MSGRESULT, Message.Result);
          Exit;
        end;
      CDN_INITDONE: DoShow;
      CDN_SELCHANGE: DoSelectionChange;
      CDN_FOLDERCHANGE: DoFolderChange;
      CDN_TYPECHANGE:
        begin
          Index := POFNotify(Message.LParam)^.lpOFN^.nFilterIndex;
          if Index <> FCurrentFilterIndex then
          begin
            FCurrentFilterIndex := Index;
            DoTypeChange;
          end;
        end;
      CDN_INCLUDEITEM:
        if Message.LParam <> 0 then
        begin
          Include := True;
          DoIncludeItem(TOFNotifyEx(POFNotifyEx(Message.LParam)^), Include);
          Message.Result := Byte(Include);
        end;
    end;
  inherited WndProc(Message);
end;

function TOpenDialog.DoCanClose: Boolean;
begin
  Result := True;
  if Assigned(FOnCanClose) then FOnCanClose(Self, Result);
end;

procedure TOpenDialog.DoSelectionChange;
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end;

procedure TOpenDialog.DoFolderChange;
begin
  if Assigned(FOnFolderChange) then FOnFolderChange(Self);
end;

procedure TOpenDialog.DoTypeChange;
begin
  if Assigned(FOnTypeChange) then FOnTypeChange(Self);
end;

procedure TOpenDialog.ReadFileEditStyle(Reader: TReader);
begin
  { Ignore FileEditStyle }
  Reader.ReadIdent;
end;

procedure TOpenDialog.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('FileEditStyle', ReadFileEditStyle, nil, False);
end;

{$IFDEF LINUX}
function DRIVE_GetRoot(Drive: Integer): PChar; cdecl; external 'libwine.borland.so' name 'DRIVE_GetRoot';

function FixFileName(const FileName: string): string;
var
  Root: string;
  I: Integer;
begin
  if (Length(FileName) > 2) and (FileName[2] = ':') then
  begin
    Result := Copy(FileName, 3, MaxInt);
    Root := DRIVE_GetRoot(Ord(UpCase(FileName[1])) - Ord('A'));
    if IsPathDelimiter(Root, Length(Root)) then
      Delete(Root, Length(Root) - 1, 1);
    Result := Root + PathDelim + Result;
  end else Result := FileName;
  for I := 1 to Length(Result) do
    if Result[I] = '\' then Result[I] := PathDelim;
end;
{$ENDIF}

function FixFileName(const FileName: string): string;
begin
  Result := FileName;
end;


function TOpenDialog.DoExecute(Func: Pointer): Bool;
var
  ParentWnd: HWND;
begin
  if Application.ModalPopupMode <> pmNone then
  begin
    ParentWnd := Application.ActiveFormHandle;
    if ParentWnd = 0 then
      ParentWnd := Application.Handle;
  end
  else
    ParentWnd := Application.Handle;
  Result := DoExecute(Func, ParentWnd);
end;

function TOpenDialog.DoExecute(Func: Pointer; ParentWnd: HWND): Bool;
const
  MultiSelectBufferSize = High(Word) - 16;
  OpenOptions: array [TOpenOption] of DWORD = (
    OFN_READONLY, OFN_OVERWRITEPROMPT, OFN_HIDEREADONLY,
    OFN_NOCHANGEDIR, OFN_SHOWHELP, OFN_NOVALIDATE, OFN_ALLOWMULTISELECT,
    OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST,
    OFN_CREATEPROMPT, OFN_SHAREAWARE, OFN_NOREADONLYRETURN,
    OFN_NOTESTFILECREATE, OFN_NONETWORKBUTTON, OFN_NOLONGNAMES,
    OFN_EXPLORER, OFN_NODEREFERENCELINKS, OFN_ENABLEINCLUDENOTIFY,
    OFN_ENABLESIZING, OFN_DONTADDTORECENT, OFN_FORCESHOWHIDDEN);

  OpenOptionsEx: array [TOpenOptionEx] of DWORD = (OFN_EX_NOPLACESBAR);
var
  Option: TOpenOption;
  OptionEx: TOpenOptionEx;
  OpenFilename: TOpenFilename;

  function AllocFilterStr(const S: string): string;
  var
    P: PChar;
  begin
    Result := '';
    if S <> '' then
    begin
      Result := S + #0;  // double null terminators
      P := AnsiStrScan(PChar(Result), '|');
      while P <> nil do
      begin
        P^ := #0;
        Inc(P);
        P := AnsiStrScan(P, '|');
      end;
    end;
  end;

var
  FileDialogWrapper: TFileDialogWrapper;
  TempFilter, TempFilename, TempExt: string;
begin
  if (Win32MajorVersion >= 6) and UseLatestCommonDialogs and (Template = nil) then
  begin
    // This requires Windows Vista or later
    if Func = @GetOpenFileName then
      FileDialogWrapper := TFileOpenDialogWrapper.Create(Self)
    else
      FileDialogWrapper := TFileSaveDialogWrapper.Create(Self);

    try
      Result := FileDialogWrapper.Execute(ParentWnd);
    finally
      FileDialogWrapper.Free;
    end;
    Exit;
  end;

  FFiles.Clear;
  FillChar(OpenFileName, SizeOf(OpenFileName), 0);
  with OpenFilename do
  begin
    if (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT) or { Win2k }
    ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion >= 4) and (Win32MinorVersion >= 90)) then { WinME }
      lStructSize := SizeOf(TOpenFilename)
    else
      lStructSize := SizeOf(TOpenFilename) - (SizeOf(DWORD) shl 1) - SizeOf(Pointer); { subtract size of added fields }

    hInstance := SysInit.HInstance;
    TempFilter := AllocFilterStr(FFilter);
    lpstrFilter := PChar(TempFilter);
    nFilterIndex := FFilterIndex;
    FCurrentFilterIndex := FFilterIndex;
    if ofAllowMultiSelect in FOptions then
      nMaxFile := MultiSelectBufferSize else
      nMaxFile := MAX_PATH;
    SetLength(TempFilename, nMaxFile + 2);
    lpstrFile := PChar(TempFilename);
    FillChar(lpstrFile^, nMaxFile + 2, 0);
    StrLCopy(lpstrFile, PChar(FFileName), nMaxFile);
    if (FInitialDir = '') and ForceCurrentDirectory then
      lpstrInitialDir := '.'
    else
      lpstrInitialDir := PChar(FInitialDir);
    lpstrTitle := PChar(FTitle);
    Flags := OFN_ENABLEHOOK;
    FlagsEx := 0;

    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or OpenOptions[Option];
    if NewStyleControls then
    begin
      Flags := Flags xor OFN_EXPLORER;
      if (Win32MajorVersion >= 5) and (Win32Platform = VER_PLATFORM_WIN32_NT) or { Win2k }
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (Win32MajorVersion >= 4) and (Win32MinorVersion >= 90)) then { WinME }
        for OptionEx := Low(OptionEx) to High(OptionEx) do
          if OptionEx in FOptionsEx then
            FlagsEx := FlagsEx or OpenOptionsEx[OptionEx]; 
    end
    else
      Flags := Flags and not OFN_EXPLORER;
    TempExt := FDefaultExt;
    if (TempExt = '') and (Flags and OFN_EXPLORER = 0) then
    begin
      TempExt := ExtractFileExt(FFilename);
      Delete(TempExt, 1, 1);
    end;
    if TempExt <> '' then lpstrDefExt := PChar(TempExt);
    if (ofOldStyleDialog in Options) or not NewStyleControls then
      lpfnHook := DialogHook
    else
      lpfnHook := ExplorerHook;

    if Template <> nil then
    begin
      Flags := Flags or OFN_ENABLETEMPLATE;
      lpTemplateName := Template;
      if FTemplateModule <> 0 then
        hInstance := FTemplateModule;
    end;
    if Application.ModalPopupMode <> pmNone then
    begin
      FRedirector := TRedirectorWindow.Create(nil);
      with TRedirectorWindow(FRedirector) do
      begin
        FCommonDialog := Self;
        FFormHandle := ParentWnd;
      end;
      hWndOwner := FRedirector.Handle;
    end
    else
      hWndOwner := Application.Handle;
    Result := TaskModalDialog(Func, OpenFileName);
    if Result then
    begin
      GetFileNames(OpenFilename);
      if (Flags and OFN_EXTENSIONDIFFERENT) <> 0 then
        Include(FOptions, ofExtensionDifferent) else
        Exclude(FOptions, ofExtensionDifferent);
      if (Flags and OFN_READONLY) <> 0 then
        Include(FOptions, ofReadOnly) else
        Exclude(FOptions, ofReadOnly);
      FFilterIndex := nFilterIndex;
    end;
  end;
end;

procedure TOpenDialog.GetFileNames(var OpenFileName: TOpenFileName);
var
  Separator: Char;

  function ExtractFileName(P: PChar; var S: TFilename): PChar;
  begin
    Result := AnsiStrScan(P, Separator);
    if Result = nil then
    begin
      S := P;
      Result := StrEnd(P);
    end
    else
    begin
      SetString(S, P, Result - P);
      Inc(Result);
    end;
  end;

  procedure ExtractFileNames(P: PChar);
  var
    DirName, FileName: TFilename;
  begin
    P := ExtractFileName(P, DirName);
    P := ExtractFileName(P, FileName);
    if FileName = '' then
      FFiles.Add(DirName)
    else
    begin
      if AnsiLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
          (FileName[2] <> ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        FFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;

begin
  Separator := #0;
  if (ofAllowMultiSelect in FOptions) and
    ((ofOldStyleDialog in FOptions) or not NewStyleControls) then
    Separator := ' ';
  with OpenFileName do
  begin
    if ofAllowMultiSelect in FOptions then
    begin
      ExtractFileNames(lpstrFile);
      FFileName := FFiles[0];
    end else
    begin
      ExtractFileName(lpstrFile, FFileName);
      FFiles.Add(FFileName);
    end;
  end;
end;

function TOpenDialog.GetStaticRect: TRect;
begin
  if FHandle <> 0 then
  begin
    if not (ofOldStyleDialog in Options) then
    begin
      GetWindowRect(GetDlgItem(FHandle, stc32), Result);
      MapWindowPoints(0, FHandle, Result, 2);
    end
    else GetClientRect(FHandle, Result)
  end
  else Result := Rect(0,0,0,0);
end;

function TOpenDialog.GetFileName: TFileName;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if NewStyleControls and (FHandle <> 0) then
  begin
    SendMessage(GetParent(FHandle), CDM_GETFILEPATH, SizeOf(Path), Integer(@Path));
    Result := StrPas(Path);
  end
  else Result := FFileName;
end;

function TOpenDialog.GetFilterIndex: Integer;
begin
  if FHandle <> 0 then
    Result := FCurrentFilterIndex
  else
    Result := FFilterIndex;
end;

procedure TOpenDialog.SetHistoryList(Value: TStrings);
begin
  FHistoryList.Assign(Value);
end;

procedure TOpenDialog.SetInitialDir(const Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  if (L > 1) and IsPathDelimiter(Value, L)
    and not IsDelimiter(':', Value, L - 1) then Dec(L);
  FInitialDir := Copy(Value, 1, L);
end;

function TOpenDialog.Execute(ParentWnd: HWND): Boolean;
begin
  Result := DoExecute(@GetOpenFileName, ParentWnd);
end;

procedure TOpenDialog.DoIncludeItem(const OFN: TOFNotifyEx; var Include: Boolean);
begin
  if Assigned(FOnIncludeItem) then FOnIncludeItem(OFN, Include);
end;

{ TSaveDialog }

function TSaveDialog.Execute(ParentWnd: HWND): Boolean;
begin
  Result := DoExecute(@GetSaveFileName, ParentWnd);
end;

{ TColorDialog }

constructor TColorDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCustomColors := TStringList.Create;
end;

destructor TColorDialog.Destroy;
begin
  FCustomColors.Free;
  inherited Destroy;
end;

function TColorDialog.Execute(ParentWnd: HWND): Boolean;
const
  DialogOptions: array[TColorDialogOption] of DWORD = (
    CC_FULLOPEN, CC_PREVENTFULLOPEN, CC_SHOWHELP, CC_SOLIDCOLOR,
    CC_ANYCOLOR);
var
  ChooseColorRec: TChooseColor;
  Option: TColorDialogOption;
  CustomColorsArray: TCustomColors;

const
  ColorPrefix = 'Color';

  procedure GetCustomColorsArray;
  var
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
      FCustomColors.Values[ColorPrefix + Char(Ord('A') + I)] :=
        Format('%.6x', [CustomColorsArray[I]]);
  end;

  procedure SetCustomColorsArray;
  var
    Value: string;
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
    begin
      Value := FCustomColors.Values[ColorPrefix + Char(Ord('A') + I)];
      if Value <> '' then
        CustomColorsArray[I] := StrToInt('$' + Value) else
        CustomColorsArray[I] := -1;
    end;
  end;

begin
  with ChooseColorRec do
  begin
    SetCustomColorsArray;
    lStructSize := SizeOf(ChooseColorRec);
    hInstance := SysInit.HInstance;
    rgbResult := ColorToRGB(FColor);
    lpCustColors := @CustomColorsArray;
    Flags := CC_RGBINIT or CC_ENABLEHOOK;
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or DialogOptions[Option];
    if Template <> nil then
    begin
      Flags := Flags or CC_ENABLETEMPLATE;
      lpTemplateName := Template;
      if FTemplateModule <> 0 then
        hInstance := FTemplateModule;
    end;
    lpfnHook := DialogHook;
    if Application.ModalPopupMode <> pmNone then
    begin
      FRedirector := TRedirectorWindow.Create(nil);
      with TRedirectorWindow(FRedirector) do
      begin
        FCommonDialog := Self;
        FFormHandle := ParentWnd;
      end;
      hWndOwner := FRedirector.Handle;
    end
    else
      hWndOwner := Application.Handle;
    Result := TaskModalDialog(@ChooseColor, ChooseColorRec);
    if Result then
    begin
      FColor := rgbResult;
      GetCustomColorsArray;
    end;
  end;
end;

procedure TColorDialog.SetCustomColors(Value: TStrings);
begin
  FCustomColors.Assign(Value);
end;

{ TFontDialog }

const
  IDAPPLYBTN = $402;

var
  FontDialog: TFontDialog;

function FontDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  if (Msg = WM_COMMAND) and (LongRec(WParam).Lo = IDAPPLYBTN) and
    (LongRec(WParam).Hi = BN_CLICKED) then
  begin
    FontDialog.DoApply(Wnd);
    Result := 1;
  end else
    Result := DialogHook(Wnd, Msg, wParam, lParam);
end;

constructor TFontDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
  FOptions := [fdEffects];
end;

destructor TFontDialog.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TFontDialog.WndProc(var Message: TMessage);
begin
  { Make sure we only take values from the color combobox and script combobox
    if they have been changed. }
  if (Message.Msg = WM_COMMAND) and (Message.WParamHi = CBN_SELENDOK) then
    if (Message.WParamLo = cmb4) then FFontColorModified := True
    else if (Message.WParamLo = cmb5) then FFontCharsetModified := True;
  inherited WndProc(Message);
end;

procedure TFontDialog.Apply(Wnd: HWND);
begin
  if Assigned(FOnApply) then FOnApply(Self, Wnd);
end;

procedure TFontDialog.DoApply(Wnd: HWND);
const
  IDCOLORCMB = $473;
var
  I: Integer;
  LogFont: TLogFont;
begin
  SendMessage(Wnd, WM_CHOOSEFONT_GETLOGFONT, 0, LongInt(@LogFont));
  UpdateFromLogFont(LogFont);
  I := SendDlgItemMessage(Wnd, IDCOLORCMB, CB_GETCURSEL, 0, 0);
  if I <> CB_ERR then
    Font.Color := SendDlgItemMessage(Wnd, IDCOLORCMB, CB_GETITEMDATA, I, 0);
  try
    Apply(Wnd);
  except
    Application.HandleException(Self);
  end;
end;

function TFontDialog.Execute(ParentWnd: HWND): Boolean;
const
  FontOptions: array[TFontDialogOption] of DWORD = (
    CF_ANSIONLY, CF_TTONLY, CF_EFFECTS, CF_FIXEDPITCHONLY, CF_FORCEFONTEXIST,
    CF_NOFACESEL, CF_NOOEMFONTS, CF_NOSIMULATIONS, CF_NOSIZESEL,
    CF_NOSTYLESEL, CF_NOVECTORFONTS, CF_SHOWHELP,
    CF_WYSIWYG or CF_BOTH or CF_SCALABLEONLY, CF_LIMITSIZE,
    CF_SCALABLEONLY, CF_APPLY);  
  Devices: array[TFontDialogDevice] of DWORD = (
    CF_SCREENFONTS, CF_PRINTERFONTS, CF_BOTH);
var
  ChooseFontRec: TChooseFont;
  LogFont: TLogFont;
  Option: TFontDialogOption;
  SaveFontDialog: TFontDialog;
  OriginalFaceName: string;
begin
  with ChooseFontRec do
  begin
    lStructSize := SizeOf(ChooseFontRec);
    hDC := 0;
    if FDevice <> fdScreen then hDC := Printer.Handle;
    lpLogFont := @LogFont;
    GetObject(Font.Handle, SizeOf(LogFont), @LogFont);
    OriginalFaceName := LogFont.lfFaceName;
    Flags := Devices[FDevice] or (CF_INITTOLOGFONTSTRUCT or CF_ENABLEHOOK);
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or FontOptions[Option];
    if Assigned(FOnApply) then Flags := Flags or CF_APPLY;
    if Template <> nil then
    begin
      Flags := Flags or CF_ENABLETEMPLATE;
      lpTemplateName := Template;
      if FTemplateModule <> 0 then
        hInstance := FTemplateModule;
    end;
    rgbColors := Font.Color;
    lCustData := 0;
    lpfnHook := FontDialogHook;
    nSizeMin := FMinFontSize;
    nSizeMax := FMaxFontSize;
    if nSizeMin > nSizeMax then Flags := Flags and (not CF_LIMITSIZE);
    if Application.ModalPopupMode <> pmNone then
    begin
      FRedirector := TRedirectorWindow.Create(nil);
      with TRedirectorWindow(FRedirector) do
      begin
        FCommonDialog := Self;
        FFormHandle := ParentWnd;
      end;
      hWndOwner := FRedirector.Handle;
    end
    else
      hWndOwner := Application.Handle;
    SaveFontDialog := FontDialog;
    FontDialog := Self;
    FFontColorModified := False;
    FFontCharsetModified := False;
    Result := TaskModalDialog(@ChooseFont, ChooseFontRec);
    FontDialog := SaveFontDialog;
    if Result then
    begin
      if AnsiCompareText(OriginalFaceName, LogFont.lfFaceName) <> 0 then
        FFontCharsetModified := True;
      UpdateFromLogFont(LogFont);
      if FFontColorModified then Font.Color := rgbColors;
    end;
  end;
end;

procedure TFontDialog.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TFontDialog.UpdateFromLogFont(const LogFont: TLogFont);
var
  Style: TFontStyles;
begin
  with LogFont do
  begin
    Font.Name := LogFont.lfFaceName;
    Font.Height := LogFont.lfHeight;
    if FFontCharsetModified then
      Font.Charset := TFontCharset(LogFont.lfCharSet);
    Style := [];
    with LogFont do
    begin
      if lfWeight > FW_REGULAR then Include(Style, fsBold);
      if lfItalic <> 0 then Include(Style, fsItalic);
      if lfUnderline <> 0 then Include(Style, fsUnderline);
      if lfStrikeOut <> 0 then Include(Style, fsStrikeOut);
    end;
    Font.Style := Style;
  end;
end;

{ Printer dialog routines }

procedure GetPrinter(var DeviceMode, DeviceNames: THandle);
var
  Device, Driver, Port: array[0..1023] of char;
  DevNames: PDevNames;
  Offset: PChar;
begin
  Printer.GetPrinter(Device, Driver, Port, DeviceMode);
  if DeviceMode <> 0 then
  begin
    DeviceNames := GlobalAlloc(GHND, SizeOf(TDevNames) +
     StrLen(Device) + StrLen(Driver) + StrLen(Port) + 3);
    DevNames := PDevNames(GlobalLock(DeviceNames));
    try
      Offset := PChar(DevNames) + SizeOf(TDevnames);
      with DevNames^ do
      begin
        wDriverOffset := Longint(Offset) - Longint(DevNames);
        Offset := StrECopy(Offset, Driver) + 1;
        wDeviceOffset := Longint(Offset) - Longint(DevNames);
        Offset := StrECopy(Offset, Device) + 1;
        wOutputOffset := Longint(Offset) - Longint(DevNames);;
        StrCopy(Offset, Port);
      end;
    finally
      GlobalUnlock(DeviceNames);
    end;
  end;
end;

procedure SetPrinter(DeviceMode, DeviceNames: THandle);
var
  DevNames: PDevNames;
begin
  DevNames := PDevNames(GlobalLock(DeviceNames));
  try
    with DevNames^ do
      Printer.SetPrinter(PChar(DevNames) + wDeviceOffset,
        PChar(DevNames) + wDriverOffset,
        PChar(DevNames) + wOutputOffset, DeviceMode);
  finally
    GlobalUnlock(DeviceNames);
    GlobalFree(DeviceNames);
  end;
end;

function CopyData(Handle: THandle): THandle;
var
  Src, Dest: PChar;
  Size: Integer;
begin
  if Handle <> 0 then
  begin
    Size := GlobalSize(Handle);
    Result := GlobalAlloc(GHND, Size);
    if Result <> 0 then
      try
        Src := GlobalLock(Handle);
        Dest := GlobalLock(Result);
        if (Src <> nil) and (Dest <> nil) then Move(Src^, Dest^, Size);
      finally
        GlobalUnlock(Handle);
        GlobalUnlock(Result);
      end
  end
  else Result := 0;
end;

{ TPrinterSetupDialog }

function TPrinterSetupDialog.Execute(ParentWnd: HWND): Boolean;
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PD_ENABLESETUPHOOK or PD_PRINTSETUP;
    lpfnSetupHook := DialogHook;
    if Application.ModalPopupMode <> pmNone then
    begin
      FRedirector := TRedirectorWindow.Create(nil);
      with TRedirectorWindow(FRedirector) do
      begin
        FCommonDialog := Self;
        FFormHandle := ParentWnd;
      end;
      hWndOwner := FRedirector.Handle;
    end
    else
      hWndOwner := Application.Handle;
    Result := TaskModalDialog(@PrintDlg, PrintDlgRec);
    if Result then
      SetPrinter(hDevMode, hDevNames)
    else begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ TPrintDialog }

procedure TPrintDialog.SetNumCopies(Value: Integer);
begin
  FCopies := Value;
  Printer.Copies := Value;
end;

function TPrintDialog.Execute(ParentWnd: HWND): Boolean;
const
  PrintRanges: array[TPrintRange] of Integer =
    (PD_ALLPAGES, PD_SELECTION, PD_PAGENUMS);
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PrintRanges[FPrintRange] or (PD_ENABLEPRINTHOOK or
      PD_ENABLESETUPHOOK);
    if FCollate then Inc(Flags, PD_COLLATE);
    if not (poPrintToFile in FOptions) then Inc(Flags, PD_HIDEPRINTTOFILE);
    if not (poPageNums in FOptions) then Inc(Flags, PD_NOPAGENUMS);
    if not (poSelection in FOptions) then Inc(Flags, PD_NOSELECTION);
    if poDisablePrintToFile in FOptions then Inc(Flags, PD_DISABLEPRINTTOFILE);
    if FPrintToFile then Inc(Flags, PD_PRINTTOFILE);
    if poHelp in FOptions then Inc(Flags, PD_SHOWHELP);
    if not (poWarning in FOptions) then Inc(Flags, PD_NOWARNING);
    if Template <> nil then
    begin
      Flags := Flags or PD_ENABLEPRINTTEMPLATE;
      lpPrintTemplateName := Template;
      if FTemplateModule <> 0 then
        hInstance := FTemplateModule;
    end;
    nFromPage := FFromPage;
    nToPage := FToPage;
    nMinPage := FMinPage;
    nMaxPage := FMaxPage;
    lpfnPrintHook := DialogHook;
    lpfnSetupHook := DialogHook;
    if Application.ModalPopupMode <> pmNone then
    begin
      FRedirector := TRedirectorWindow.Create(nil);
      with TRedirectorWindow(FRedirector) do
      begin
        FCommonDialog := Self;
        FFormHandle := ParentWnd;
      end;
      hWndOwner := FRedirector.Handle;
    end
    else
      hWndOwner := Application.Handle;
    Result := TaskModalDialog(@PrintDlg, PrintDlgRec);
    if Result then
    begin
      SetPrinter(hDevMode, hDevNames);
      FCollate := Flags and PD_COLLATE <> 0;
      FPrintToFile := Flags and PD_PRINTTOFILE <> 0;
      if Flags and PD_SELECTION <> 0 then FPrintRange := prSelection else
        if Flags and PD_PAGENUMS <> 0 then FPrintRange := prPageNums else
          FPrintRange := prAllPages;
      FFromPage := nFromPage;
      FToPage := nToPage;
      if nCopies = 1 then
        Copies := Printer.Copies else
        Copies := nCopies;
    end
    else begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ TPageSetupDialog }

var
  PgSetupDlg: TPageSetupDialog;  // Used for page paint callback

function PagePaint(Wnd: HWND; Message: UINT; wParam: WPARAM; lParam: LPARAM): UINT; stdcall;
var
  DoneDrawing: Boolean;

  procedure CallPaintEvent(Event: TPaintPageEvent);
  var
    Canvas: TCanvas;
  begin
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := HDC(wParam);
      if Assigned(Event) then
        Event(PgSetupDlg, Canvas, PRect(lParam)^, DoneDrawing);
    finally
      Canvas.Free;
    end;
  end;

const
  PageType: array[Boolean] of TPageType = (ptEnvelope, ptPaper);
  Orientation: array[Boolean] of TPrinterOrientation = (poPortrait, poLandscape);
begin
  Result := UINT(False);
  if not Assigned(PgSetupDlg) then Exit; 
  DoneDrawing := False;
  if Message = WM_PSD_PAGESETUPDLG then
  begin
    if Assigned(PgSetupDlg.FBeforePaint) then
      // Constants used below are from WinAPI help on WM_PSD_PAGESETUPDLG
      PgSetupDlg.BeforePaint(PgSetupDlg, (wParam and $FFFF),
        Orientation[(wParam shr 16) in [$0001,$0003, $000B, $0019]],
        PageType[(wParam shr 16) > $000B], DoneDrawing);
  end
  else
    with PgSetupDlg do
      case Message of
        WM_PSD_FULLPAGERECT  : CallPaintEvent(FOnDrawFullPage);
        WM_PSD_MINMARGINRECT : CallPaintEvent(FOnDrawMinMargin);
        WM_PSD_MARGINRECT    : CallPaintEvent(FOnDrawMargin);
        WM_PSD_GREEKTEXTRECT : CallPaintEvent(FOnDrawGreekText);
        WM_PSD_ENVSTAMPRECT  : CallPaintEvent(FOnDrawEnvStamp);
        WM_PSD_YAFULLPAGERECT: CallPaintEvent(FOnDrawRetAddress);
      end;
  Result := UINT(DoneDrawing);
end;

constructor TPageSetupDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Options := [psoDefaultMinMargins];
  GetDefaults;
end;

function TPageSetupDialog.Execute(ParentWnd: HWND): Boolean;
var
  DevHandle: THandle;
begin
  FillChar(FPageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);
  with PageSetupDlgRec do
  begin
    lStructSize := SizeOf(PageSetupDlgRec);
    if Application.ModalPopupMode <> pmNone then
    begin
      FRedirector := TRedirectorWindow.Create(nil);
      with TRedirectorWindow(FRedirector) do
      begin
        FCommonDialog := Self;
        FFormHandle := ParentWnd;
      end;
      hWndOwner := FRedirector.Handle;
    end
    else
      hWndOwner := Application.Handle;
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PSD_RETURNDEFAULT;
    PageSetupDlg(FPageSetupDlgRec);
    Flags := PSD_ENABLEPAGEPAINTHOOK or PSD_ENABLEPAGESETUPHOOK;
    case FUnits of
//    pmDefault    : Read from locale settings by the dialog
      pmInches     : Inc(Flags, PSD_INTHOUSANDTHSOFINCHES);
      pmMillimeters: Inc(Flags, PSD_INHUNDREDTHSOFMILLIMETERS);
    end;
    if psoDefaultMinMargins in FOptions then Inc(Flags, PSD_DEFAULTMINMARGINS);
    if psoDisableMargins in FOptions then Inc(Flags, PSD_DisableMargins);
    if psoDisableOrientation in FOptions then Inc(Flags, PSD_DISABLEORIENTATION);
    if psoDisablePagePainting in FOptions then
      Inc(Flags, PSD_DISABLEPAGEPAINTING)
    else
    begin
      PgSetupDlg := Self;
      lpfnPagePaintHook := PagePaint;
    end;
    if psoDisablePaper in FOptions then Inc(Flags, PSD_DISABLEPAPER);
    if psoDisablePrinter in FOptions then Inc(Flags, PSD_DISABLEPRINTER);
    if psoMargins in FOptions then Inc(Flags, PSD_MARGINS);
    if psoMinMargins in FOptions then Inc(Flags, PSD_MINMARGINS);
    if psoShowHelp in FOptions then Inc(Flags, PSD_SHOWHELP);
    if not (psoWarning in FOptions) then Inc(Flags, PSD_NOWARNING);
    if psoNoNetworkButton in FOptions then Inc(Flags, PSD_NONETWORKBUTTON);
    ptPaperSize := Point(FPageWidth, FPageHeight);
    rtMinMargin := Rect(FMinMarginLeft, FMinMarginTop, FMinMarginRight, FMinMarginBottom);
    rtMargin := Rect(FMarginLeft, FMarginTop, FMarginRight, FMarginBottom);
    lpfnPageSetupHook := DialogHook;

    Result := TaskModalDialog(@PageSetupDlg, FPageSetupDlgRec);
    if Result then
    begin
      PageWidth := ptPaperSize.x;
      PageHeight := ptPaperSize.y;
      MarginLeft := rtMargin.Left;
      MarginTop := rtMargin.Top;
      MarginRight := rtMargin.Right;
      MarginBottom := rtMargin.Bottom;
      SetPrinter(hDevMode, hDevNames)
    end
    else begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

function TPageSetupDialog.GetDefaults: Boolean;
var
  PageSetupDlgRec: TPageSetupDlg;
begin
  Result := False;
  if Printer.Printers.Count = 0 then Exit;
  FillChar(PageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);
  with PageSetupDlgRec do
  begin
    lStructSize := SizeOf(PageSetupDlgRec);
    hwndOwner := Application.Handle;
    hInstance := SysInit.HInstance;
    case FUnits of
//    pmDefault    : Read from locale settings by the dialog
      pmInches     : Inc(Flags, PSD_INTHOUSANDTHSOFINCHES);
      pmMillimeters: Inc(Flags, PSD_INHUNDREDTHSOFMILLIMETERS);
    end;
    if psoDefaultMinMargins in FOptions then Inc(Flags, PSD_DEFAULTMINMARGINS);
    if psoDisableMargins in FOptions then Inc(Flags, PSD_DISABLEMARGINS);
    if psoDisableOrientation in FOptions then Inc(Flags, PSD_DISABLEORIENTATION);
    if psoDisablePagePainting in FOptions then
      Inc(Flags, PSD_DISABLEPAGEPAINTING);
    if psoDisablePaper in FOptions then Inc(Flags, PSD_DISABLEPAPER);
    if psoDisablePrinter in FOptions then Inc(Flags, PSD_DISABLEPRINTER);
    ptPaperSize := Point(FPageWidth, FPageHeight);
    rtMinMargin := Rect(FMinMarginLeft, FMinMarginTop, FMinMarginRight, FMinMarginBottom);
    rtMargin := Rect(FMarginLeft, FMarginTop, FMarginRight, FMarginBottom);
    lpfnPageSetupHook := DialogHook;

    Flags := Flags or PSD_RETURNDEFAULT;
    Result := PageSetupDlg(PageSetupDlgRec);

    if Result then
    begin
      FPageWidth := ptPaperSize.x;
      FPageHeight := ptPaperSize.y;
      FMarginLeft := rtMargin.Left;
      FMarginTop := rtMargin.Top;
      FMarginRight := rtMargin.Right;
      FMarginBottom := rtMargin.Bottom;
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ Find and Replace dialog routines }

function FindReplaceWndProc(Wnd: HWND; Msg, WParam, LParam: Longint): Longint; stdcall;

  function CallDefWndProc: Longint;
  begin
    Result := CallWindowProc(Pointer(GetProp(Wnd,
      MakeIntAtom(WndProcPtrAtom))), Wnd, Msg, WParam, LParam);
  end;

begin
  case Msg of
    WM_DESTROY:
      if Application.DialogHandle = Wnd then Application.DialogHandle := 0;
    WM_NCACTIVATE:
      if WParam <> 0 then
      begin
        if Application.DialogHandle = 0 then Application.DialogHandle := Wnd;
      end else
      begin
        if Application.DialogHandle = Wnd then Application.DialogHandle := 0;
      end;
    WM_NCDESTROY:
      begin
        Result := CallDefWndProc;
        RemoveProp(Wnd, MakeIntAtom(WndProcPtrAtom));
        Exit;
      end;
   end;
   Result := CallDefWndProc;
end;

function FindReplaceDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := DialogHook(Wnd, Msg, wParam, lParam);
  if Msg = WM_INITDIALOG then
  begin
    with TFindDialog(PFindReplace(LParam)^.lCustData) do
      if (Left <> -1) or (Top <> -1) then
        SetWindowPos(Wnd, 0, Left, Top, 0, 0, SWP_NOACTIVATE or
          SWP_NOSIZE or SWP_NOZORDER);
    SetProp(Wnd, MakeIntAtom(WndProcPtrAtom), GetWindowLong(Wnd, GWL_WNDPROC));
    SetWindowLong(Wnd, GWL_WNDPROC, Longint(@FindReplaceWndProc));
    Result := 1;
  end;
end;

const
  FindOptions: array[TFindOption] of DWORD = (
    FR_DOWN, FR_FINDNEXT, FR_HIDEMATCHCASE, FR_HIDEWHOLEWORD,
    FR_HIDEUPDOWN, FR_MATCHCASE, FR_NOMATCHCASE, FR_NOUPDOWN, FR_NOWHOLEWORD,
    FR_REPLACE, FR_REPLACEALL, FR_WHOLEWORD, FR_SHOWHELP);

{ TFindDialog }

constructor TFindDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [frDown];
  FPosition.X := -1;
  FPosition.Y := -1;
  with FFindReplace do
  begin
    lStructSize := SizeOf(TFindReplace);
    hWndOwner := Application.Handle;
    hInstance := SysInit.HInstance;
    lpstrFindWhat := FFindText;
    wFindWhatLen := SizeOf(FFindText);
    lpstrReplaceWith := FReplaceText;
    wReplaceWithLen := SizeOf(FReplaceText);
    lCustData := Longint(Self);
    lpfnHook := FindReplaceDialogHook;
  end;
  FFindReplaceFunc := @CommDlg.FindText;
end;

destructor TFindDialog.Destroy;
begin
  if FFindHandle <> 0 then SendMessage(FFindHandle, WM_CLOSE, 0, 0);
  inherited Destroy;
end;

procedure TFindDialog.CloseDialog;
begin
  if FFindHandle <> 0 then PostMessage(FFindHandle, WM_CLOSE, 0, 0);
end;

function GetTopWindow(Wnd: THandle; var ReturnVar: THandle):Bool; stdcall;
var
  Test: TWinControl;
begin
  Test := FindControl(Wnd);
  Result := True;
  if Assigned(Test) and (Test is TForm) then
  begin
    ReturnVar := Wnd;
    Result := False;
   end;
end;

function TFindDialog.Execute(ParentWnd: HWND): Boolean;
var
  Option: TFindOption;
begin
  if FFindHandle <> 0 then
  begin
    BringWindowToTop(FFindHandle);
    Result := True;
  end else
  begin
    FFindReplace.Flags := FR_ENABLEHOOK;
    FFindReplace.lpfnHook := FindReplaceDialogHook;
    FRedirector := TRedirectorWindow.Create(nil);
    with TRedirectorWindow(FRedirector) do
    begin
      FCommonDialog := Self;
      EnumThreadWindows(GetCurrentThreadID, @GetTopWindow, LPARAM(@FFormHandle));
    end;
    FFindReplace.hWndOwner := FRedirector.Handle;
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        FFindReplace.Flags := FFindReplace.Flags or FindOptions[Option];
    if Template <> nil then
    begin
      FFindReplace.Flags := FFindReplace.Flags or FR_ENABLETEMPLATE;
      FFindReplace.lpTemplateName := Template;
    end;
    CreationControl := Self;
    FFindHandle := FFindReplaceFunc(FFindReplace);
    Result := FFindHandle <> 0;
  end;
end;

procedure TFindDialog.Find;
begin
  if Assigned(FOnFind) then FOnFind(Self);
end;

function TFindDialog.GetFindText: string;
begin
  Result := FFindText;
end;

function TFindDialog.GetLeft: Integer;
begin
  Result := Position.X;
end;

function TFindDialog.GetPosition: TPoint;
var
  Rect: TRect;
begin
  Result := FPosition;
  if FFindHandle <> 0 then
  begin
    GetWindowRect(FFindHandle, Rect);
    Result := Rect.TopLeft;
  end;
end;

function TFindDialog.GetReplaceText: string;
begin
  Result := FReplaceText;
end;

function TFindDialog.GetTop: Integer;
begin
  Result := Position.Y;
end;

function TFindDialog.MessageHook(var Msg: TMessage): Boolean;
var
  Option: TFindOption;
  Rect: TRect;
begin
  Result := inherited MessageHook(Msg);
  if not Result then
    if (Msg.Msg = FindMsg) and (Pointer(Msg.LParam) = @FFindReplace) then
    begin
      FOptions := [];
      for Option := Low(Option) to High(Option) do
        if (FFindReplace.Flags and FindOptions[Option]) <> 0 then
          Include(FOptions, Option);
      if (FFindReplace.Flags and FR_FINDNEXT) <> 0 then
        Find
      else
      if (FFindReplace.Flags and (FR_REPLACE or FR_REPLACEALL)) <> 0 then
        Replace
      else
      if (FFindReplace.Flags and FR_DIALOGTERM) <> 0 then
      begin
        GetWindowRect(FFindHandle, Rect);
        FPosition := Rect.TopLeft;
        FFindHandle := 0;
        PostMessage(FRedirector.Handle, CM_RELEASE, 0, 0); // free redirector later
        FRedirector := nil;
      end;
      Result := True;
    end;
end;

procedure TFindDialog.Replace;
begin
  if Assigned(FOnReplace) then FOnReplace(Self);
end;

procedure TFindDialog.SetFindText(const Value: string);
begin
  StrLCopy(FFindText, PChar(Value), SizeOf(FFindText) - 1);
end;

procedure TFindDialog.SetLeft(Value: Integer);
begin
  SetPosition(Point(Value, Top));
end;

procedure TFindDialog.SetPosition(const Value: TPoint);
begin
  if (FPosition.X <> Value.X) or (FPosition.Y <> Value.Y) then
  begin
    FPosition := Value;
    if FFindHandle <> 0 then
      SetWindowPos(FFindHandle, 0, Value.X, Value.Y, 0, 0,
        SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;

procedure TFindDialog.SetReplaceText(const Value: string);
begin
  StrLCopy(FReplaceText, PChar(Value), SizeOf(FReplaceText) - 1);
end;

procedure TFindDialog.SetTop(Value: Integer);
begin
  SetPosition(Point(Left, Value));
end;

{ TReplaceDialog }

constructor TReplaceDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFindReplaceFunc := CommDlg.ReplaceText;
end;

{ TFileDialogFileType }

constructor TFileTypeItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDisplayNameWStr := nil;
  FFileMaskWStr := nil;
end;

destructor TFileTypeItem.Destroy;
begin
  if FDisplayNameWStr <> nil then
    CoTaskMemFree(FDisplayNameWStr);
  if FFileMaskWStr <> nil then
    CoTaskMemFree(FFileMaskWStr);
  inherited;
end;

function TFileTypeItem.GetDisplayNameWStr: LPCWSTR;
var
  Len: Integer;
begin
  if FDisplayNameWStr <> nil then
    CoTaskMemFree(FDisplayNameWStr);
  Len := Length(FDisplayName);
  FDisplayNameWStr := CoTaskMemAlloc((Len * 2) + 2);
  Result := WStrPLCopy(FDisplayNameWStr, WideString(FDisplayName), Len);
end;

function TFileTypeItem.GetDisplayName: string;
begin
  if FDisplayName <> '' then
    Result := FDisplayName
  else
    Result := inherited GetDisplayName;
end;

function TFileTypeItem.GetFileMaskWStr: LPCWSTR;
var
  Len: Integer;
begin
  if FFileMaskWStr <> nil then
    CoTaskMemFree(FFileMaskWStr);
  Len := Length(FFileMask);
  FFileMaskWStr := CoTaskMemAlloc((Len * 2) + 2);
  Result := WStrPLCopy(FFileMaskWStr, WideString(FFileMask), Len);
end;

{ TFileDialogFileTypes }

function TFileTypeItems.Add: TFileTypeItem;
begin
  Result := TFileTypeItem(inherited Add);
end;

function TFileTypeItems.FilterSpecArray: TComdlgFilterSpecArray;
var
  I: Integer;
begin
  SetLength(Result, Count);
  for I := 0 to Count - 1 do
  begin
    Result[I].pszName := Items[I].DisplayNameWStr;
    Result[I].pszSpec := Items[I].FileMaskWStr;
  end;
end;

function TFileTypeItems.GetItem(Index: Integer): TFileTypeItem;
begin
  Result := TFileTypeItem(inherited GetItem(Index));
end;

procedure TFileTypeItems.SetItem(Index: Integer; const Value: TFileTypeItem);
begin
  inherited SetItem(Index, Value);
end;

{ TFilePlacesEnumerator }

constructor TFavoriteLinkItemsEnumerator.Create(ACollection: TFavoriteLinkItems);
begin
  inherited Create;
  FIndex := -1;
  FCollection := ACollection;
end;

function TFavoriteLinkItemsEnumerator.GetCurrent: TFavoriteLinkItem;
begin
  Result := FCollection[FIndex];
end;

function TFavoriteLinkItemsEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FCollection.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TFilePlaceItem }

function TFavoriteLinkItem.GetDisplayName: string;
begin
  if FLocation <> '' then
    Result := FLocation
  else
    Result := inherited GetDisplayName;
end;

{ TFilePlaces }

function TFavoriteLinkItems.Add: TFavoriteLinkItem;
begin
  Result := TFavoriteLinkItem(inherited Add);
end;

function TFavoriteLinkItems.GetEnumerator: TFavoriteLinkItemsEnumerator;
begin
  Result := TFavoriteLinkItemsEnumerator.Create(Self);
end;

function TFavoriteLinkItems.GetItem(Index: Integer): TFavoriteLinkItem;
begin
  Result := TFavoriteLinkItem(inherited GetItem(Index));
end;

procedure TFavoriteLinkItems.SetItem(Index: Integer; const Value: TFavoriteLinkItem);
begin
  inherited SetItem(Index, Value);
end;

{ TFileDialogEvents }

type
  TFileDialogEvents = class(TInterfacedObject, IFileDialogEvents)
  private
    FFileDialog: TCustomFileDialog;
    FRetrieveHandle: Boolean;
  public
    constructor Create(AFileDialog: TCustomFileDialog);
    { IFileDialogEvents }
    function OnFileOk(const pfd: IFileDialog): HResult; stdcall;
    function OnFolderChanging(const pfd: IFileDialog;
      const psiFolder: IShellItem): HResult; stdcall;
    function OnFolderChange(const pfd: IFileDialog): HResult; stdcall;
    function OnSelectionChange(const pfd: IFileDialog): HResult; stdcall;
    function OnShareViolation(const pfd: IFileDialog; const psi: IShellItem;
      out pResponse: DWORD): HResult; stdcall;
    function OnTypeChange(const pfd: IFileDialog): HResult; stdcall;
    function OnOverwrite(const pfd: IFileDialog; const psi: IShellItem;
      out pResponse: DWORD): HResult; stdcall;
  end;

constructor TFileDialogEvents.Create(AFileDialog: TCustomFileDialog);
begin
  FFileDialog := AFileDialog;
  FRetrieveHandle := True;
end;

function TFileDialogEvents.OnFileOk(const pfd: IFileDialog): HResult;
begin
  if Assigned(FFileDialog.OnFileOkClick) then
    Result := FFileDialog.FileOkClick
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnFolderChange(const pfd: IFileDialog): HResult;
begin
  if Assigned(FFileDialog.OnFolderChange) then
    Result := FFileDialog.FolderChange
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnFolderChanging(const pfd: IFileDialog;
  const psiFolder: IShellItem): HResult;
begin
  if Assigned(FFileDialog.OnFolderChanging) then
    Result := FFileDialog.FolderChanging(psiFolder)
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnOverwrite(const pfd: IFileDialog;
  const psi: IShellItem; out pResponse: DWORD): HResult;
begin
  if Assigned(FFileDialog.OnOverwrite) then
    Result := FFileDialog.Overwrite(psi, pResponse)
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnSelectionChange(const pfd: IFileDialog): HResult;
begin
  // OnSelectionChange is called when the dialog is opened, use this
  // to retrieve the window handle if OnTypeChange wasn't triggered.
  if FRetrieveHandle then
  begin
    FFileDialog.GetWindowHandle;
    FRetrieveHandle := False;
  end;

  if Assigned(FFileDialog.OnSelectionChange) then
    Result := FFileDialog.SelectionChange
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnShareViolation(const pfd: IFileDialog;
  const psi: IShellItem; out pResponse: DWORD): HResult;
begin
  if Assigned(FFileDialog.OnShareViolation) then
    Result := FFileDialog.ShareViolation(psi, pResponse)
  else
    Result := E_NOTIMPL;
end;

function TFileDialogEvents.OnTypeChange(const pfd: IFileDialog): HResult;
begin
  // OnTypeChange is supposed to always be called when the dialog is
  // opened. In reality it isn't called if you don't assign any FileTypes.
  // Use this to retrieve the window handle, if it's called.
  if FRetrieveHandle then
  begin
    FFileDialog.GetWindowHandle;
    FRetrieveHandle := False;
  end;

  if Assigned(FFileDialog.OnTypeChange) then
    Result := FFileDialog.TypeChange
  else
    Result := E_NOTIMPL;
end;

{ TCustomFileDialog }

constructor TCustomFileDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFiles := TStringList.Create;
  FFileTypeIndex := 1;
  FFileTypes := TFileTypeItems.Create(TFileTypeItem);
  FHandle := 0;
  FOptions := [];
  FFavoriteLinks := TFavoriteLinkItems.Create(TFavoriteLinkItem); //TStringList.Create;
  FShellItem := nil;
  FShellItems := nil;
end;

destructor TCustomFileDialog.Destroy;
begin
  FFiles.Free;
  FFileTypes.Free;
  FFavoriteLinks.Free;
  FShellItem := nil;
  FShellItems := nil;
  inherited;
end;

procedure TCustomFileDialog.DoOnExecute;
begin
  if Assigned(FOnExecute) then
    FOnExecute(Self);
end;

function TCustomFileDialog.DoOnFileOkClick: Boolean;
begin
  Result := True;
  if Assigned(FOnFileOkClick) then
    FOnFileOkClick(Self, Result);
end;

procedure TCustomFileDialog.DoOnFolderChange;
begin
  if Assigned(FOnFolderChange) then
    FOnFolderChange(Self);
end;

function TCustomFileDialog.DoOnFolderChanging: Boolean;
begin
  Result := True;
  if Assigned(FOnFolderChanging) then
    FOnFolderChanging(Self, Result);
end;

procedure TCustomFileDialog.DoOnOverwrite(var Response: TFileDialogOverwriteResponse);
begin
  if Assigned(FOnOverwrite) then
    FOnOverwrite(Self, Response);
end;

procedure TCustomFileDialog.DoOnSelectionChange;
begin
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self);
end;

procedure TCustomFileDialog.DoOnShareViolation(var Response: TFileDialogShareViolationResponse);
begin
  if Assigned(FOnShareViolation) then
    FOnShareViolation(Self, Response);
end;

procedure TCustomFileDialog.DoOnTypeChange;
begin
  if Assigned(FOnTypeChange) then
    FOnTypeChange(Self);
end;

                                                                                           
function TCustomFileDialog.Execute: Boolean;
var
  ParentWnd: HWND;
begin
  if Application.ModalPopupMode <> pmNone then
  begin
    ParentWnd := Application.ActiveFormHandle;
    if ParentWnd = 0 then
      ParentWnd := Application.Handle;
  end
  else
    ParentWnd := Application.Handle;
  Result := Execute(ParentWnd);
end;

                                                                                           
function TCustomFileDialog.Execute(ParentWnd: HWND): Boolean;
const
  CDialogOptions: array[TFileDialogOption] of DWORD = (
    FOS_OVERWRITEPROMPT, FOS_STRICTFILETYPES, FOS_NOCHANGEDIR,
    FOS_PICKFOLDERS, FOS_FORCEFILESYSTEM, FOS_ALLNONSTORAGEITEMS,
    FOS_NOVALIDATE, FOS_ALLOWMULTISELECT, FOS_PATHMUSTEXIST,
    FOS_FILEMUSTEXIST, FOS_CREATEPROMPT, FOS_SHAREAWARE,
    FOS_NOREADONLYRETURN, FOS_NOTESTFILECREATE, FOS_HIDEMRUPLACES,
    FOS_HIDEPINNEDPLACES, FOS_NODEREFERENCELINKS, FOS_DONTADDTORECENT,
    FOS_FORCESHOWHIDDEN, FOS_DEFAULTNOMINIMODE, FOS_FORCEPREVIEWPANEON);
var
  LWindowList: Pointer;
  LFocusState: TFocusState;
  LPlace: TFavoriteLinkItem;
  LShellItem: IShellItem;
  LAdviseCookie: Cardinal;
  LDialogOptions: Cardinal;
  LDialogEvents: TFileDialogEvents;
  LDialogOption: TFileDialogOption;
begin
  if Win32MajorVersion < 6 then
    raise EPlatformVersionException.CreateResFmt(@SWindowsVistaRequired, [ClassName]);

  Result := False;
  FDialog := CreateFileDialog;
  if FDialog <> nil then
    try
      with FDialog do
      begin
        // ClientGuid, DefaultExt, FileName, Title, OkButtonLabel, FileNameLabel
        if FClientGuid <> '' then
          SetClientGuid(StringToGUID(FClientGuid));
        if FDefaultExtension <> '' then
          SetDefaultExtension(PWideChar(WideString(FDefaultExtension)));
        if FFileName <> '' then
          SetFileName(PWideChar(WideString(FFileName)));
        if FFileNameLabel <> '' then
          SetFileNameLabel(PWideChar(WideString(FFileNameLabel)));
        if FOkButtonLabel <> '' then
          SetOkButtonLabel(PWideChar(WideString(FOkButtonLabel)));
        if FTitle <> '' then
          SetTitle(PWideChar(WideString(FTitle)));

        // DefaultFolder
        if FDefaultFolder <> '' then
        begin
          if Succeeded(SHCreateItemFromParsingName(PWideChar(WideString(FDefaultFolder)),
             nil, StringToGUID(SID_IShellItem), LShellItem)) then
            SetFolder(LShellItem);
        end;

        // FileTypes, FileTypeIndex
        if FFileTypes.Count > 0 then
        begin
          FDialog.SetFileTypes(FFileTypes.Count, FFileTypes.FilterSpecArray);
          SetFileTypeIndex(FFileTypeIndex);
        end;

        // Options
        LDialogOptions := 0;
        for LDialogOption in Options do
          LDialogOptions := LDialogOptions or CDialogOptions[LDialogOption];
        SetOptions(LDialogOptions);

        // Additional Places
        for LPlace in FFavoriteLinks do
          if Succeeded(SHCreateItemFromParsingName(PWideChar(WideString(LPlace.Location)),
             nil, StringToGUID(SID_IShellItem), LShellItem)) then
            AddPlace(LShellItem, FDAP_BOTTOM);
 
        // Show dialog and get results
        DoOnExecute;
        LWindowList := DisableTaskWindows(ParentWnd);
        LFocusState := SaveFocusState;
        try
          LDialogEvents := TFileDialogEvents.Create(Self);
          Advise(LDialogEvents, LAdviseCookie);
          try
            Result := Succeeded(Show(ParentWnd));
            if Result then
              Result := Succeeded(GetResults);
          finally
            Unadvise(LAdviseCookie);
          end;
        finally
          EnableTaskWindows(LWindowList);
          SetActiveWindow(ParentWnd);
          RestoreFocusState(LFocusState);
        end;
      end;
    finally
      FDialog := nil;
    end;
end;

function TCustomFileDialog.FileOkClick: HResult;
const
  CResults: array[Boolean] of HResult = (S_FALSE, S_OK);
begin
  Result := GetResults;
  if Succeeded(Result) then
    Result := CResults[DoOnFileOkClick];
  Files.Clear;
end;

function TCustomFileDialog.FolderChange: HResult;
begin
  FFileName := '';
  Result := FDialog.GetFolder(FShellItem);
  if Succeeded(Result) then
  begin
    Result := GetItemName(FShellItem, FFileName);
    if Succeeded(Result) then
      DoOnFolderChange;
  end;
  FShellItem := nil;
end;

function TCustomFileDialog.FolderChanging(psiFolder: IShellItem): HResult;
const
  CResults: array[Boolean] of HResult = (S_FALSE, S_OK);
begin
  FFileName := '';
  FShellItem := psiFolder;
  Result := GetItemName(FShellItem, FFileName);
  if Succeeded(Result) then
    Result := CResults[DoOnFolderChanging];
  FShellItem := nil;
end;

                                                                    
function TCustomFileDialog.GetDefaultFolder: string;
begin
  Result := FDefaultFolder;
end;

                                                                    
function TCustomFileDialog.GetFileName: TFileName;
begin
  Result := FFileName;
end;

function TCustomFileDialog.GetFileNames(Items: IShellItemArray): HResult;
var
  Count: Integer;
  LShellItem: IShellItem;
  LEnumerator: IEnumShellItems;
begin
  Files.Clear;
  Result := Items.EnumItems(LEnumerator);
  if Succeeded(Result) then
  begin
    Result := LEnumerator.Next(1, LShellItem, @Count);
    while Succeeded(Result) and (Count <> 0) do
    begin
      GetItemName(LShellItem, FFileName);
      Files.Add(FFileName);
      Result := LEnumerator.Next(1, LShellItem, @Count);
    end;
    if Files.Count > 0 then
      FFileName := Files[0];
  end;
end;

                                                                    
function TCustomFileDialog.GetFiles: TStrings;
begin
  Result := FFiles;
end;

function TCustomFileDialog.GetItemName(Item: IShellItem; var ItemName: TFileName): HResult;
var
  pszItemName: PWideChar;
begin
  Result := Item.GetDisplayName(SIGDN_FILESYSPATH, pszItemName);
  if Failed(Result) then
    Result := Item.GetDisplayName(SIGDN_NORMALDISPLAY, pszItemName);
  if Succeeded(Result) then
  try
    ItemName := pszItemName;
  finally
    CoTaskMemFree(pszItemName);
  end;
end;

function TCustomFileDialog.GetResults: HResult;
begin
  Result := FDialog.GetResult(FShellItem);
  if Succeeded(Result) then
  begin
    Result := GetItemName(FShellItem, FFileName);
    FFiles.Clear;
    FFiles.Add(FFileName);
  end;
end;

procedure TCustomFileDialog.GetWindowHandle;
var
  LOleWindow: IOleWindow;
begin
  if Supports(FDialog, IOleWindow, LOleWindow) then
    LOleWindow.GetWindow(FHandle);
end;

function TCustomFileDialog.Overwrite(psiFile: IShellItem; var Response: Cardinal): HResult;
var
  LResponse: TFileDialogOverwriteResponse;
begin
  FFileName := '';
  LResponse := forAccept;
  FShellItem := psiFile;
  Result := GetItemName(FShellItem, FFileName);
  if Succeeded(Result) then
    DoOnOverwrite(LResponse);
  Response := Cardinal(LResponse);
  FShellItem := nil;
end;

function TCustomFileDialog.SelectionChange: HResult;
begin
  FFileName := '';
  Result := FDialog.GetCurrentSelection(FShellItem);
  if Succeeded(Result) then
  begin
    Result := GetItemName(FShellItem, FFileName);
    if Succeeded(Result) then
      DoOnSelectionChange;
  end;
  FShellItem := nil;
end;

procedure TCustomFileDialog.SetClientGuid(const Value: string);
begin
  if Value <> FClientGuid then
  begin
    if Value <> '' then
      StringToGUID(Value);
    FClientGuid := Value;
  end;
end;

                                                                    
procedure TCustomFileDialog.SetDefaultFolder(const Value: string);
begin
  if FDefaultFolder <> Value then
    FDefaultFolder := Value;
end;

                                                                    
procedure TCustomFileDialog.SetFileName(const Value: TFileName);
begin
  if Value <> FFileName then
    FFileName := Value;
end;

procedure TCustomFileDialog.SetFileTypes(const Value: TFileTypeItems);
begin
  if Value <> nil then
    FFileTypes.Assign(Value);
end;

                                                                    
procedure TCustomFileDialog.SetFavoriteLinks(const Value: TFavoriteLinkItems);
begin
  if Value <> nil then
    FFavoriteLinks.Assign(Value);
end;

function TCustomFileDialog.ShareViolation(psiFile: IShellItem;
  var Response: Cardinal): HResult;
var
  LResponse: TFileDialogShareViolationResponse;
begin
  FFileName := '';
  LResponse := fsrAccept;
  FShellItem := psiFile;
  Result := GetItemName(FShellItem, FFileName);
  if Succeeded(Result) then
    DoOnShareViolation(LResponse);
  Response := Cardinal(LResponse);
  FShellItem := nil;
end;

function TCustomFileDialog.TypeChange: HResult;
begin
  Result := FDialog.GetFileTypeIndex(FFileTypeIndex);
  if Succeeded(Result) then
    DoOnTypeChange;
end;

{ TCustomFileOpenDialog }

function TCustomFileOpenDialog.CreateFileDialog: IFileDialog;
begin
  CoCreateInstance(CLSID_FileOpenDialog, nil, CLSCTX_INPROC_SERVER,
    IFileOpenDialog, Result);
end;

function TCustomFileOpenDialog.GetResults: HResult;
begin
  if not (fdoAllowMultiSelect in Options) then
    Result := inherited GetResults
  else
  begin
    Result := (Dialog as IFileOpenDialog).GetResults(FShellItems);
    if Succeeded(Result) then
      Result := GetFileNames(FShellItems);
  end;
end;

function TCustomFileOpenDialog.SelectionChange: HResult;
begin
  if not (fdoAllowMultiSelect in Options) then
    Result := inherited SelectionChange
  else
  begin
    Result := (Dialog as IFileOpenDialog).GetSelectedItems(FShellItems);
    if Succeeded(Result) then
    begin
      Result := GetFileNames(FShellItems);
      if Succeeded(Result) then
      begin
        Dialog.GetCurrentSelection(FShellItem);
        DoOnSelectionChange;
      end;
      FShellItems := nil;
    end;
  end;
end;

{ TCustomFileSaveDialog }

function TCustomFileSaveDialog.CreateFileDialog: IFileDialog;
begin
  CoCreateInstance(CLSID_FileSaveDialog, nil, CLSCTX_INPROC_SERVER,
    IFileSaveDialog, Result);
end;

{ TTaskDialogProgressBar }

constructor TTaskDialogProgressBar.Create(AClient: TCustomTaskDialog);
begin
  inherited Create;
  FClient := AClient;
  FMax := 100;
  FMin := 0;
  FPosition := 0;
  FMarqueeSpeed := 0;
  FState := pbsNormal;
end;

procedure TTaskDialogProgressBar.SetMax(const Value: Integer);
begin
  if Value <> FMax then
  begin
    if Value < FMin then
      raise EInvalidOperation.CreateFmt(SPropertyOutOfRange, [Classname]);
    FMax := Value;
    if (FClient.Handle <> 0) and not (tfShowMarqueeProgressBar in FClient.Flags) then
      SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_RANGE, 0, MakeLParam(FMin, FMax));
  end;
end;

procedure TTaskDialogProgressBar.SetMin(const Value: Integer);
begin
  if Value <> FMin then
  begin
    if Value > FMax then
      raise EInvalidOperation.CreateFmt(SPropertyOutOfRange, [Classname]);
    FMin := Value;
    if (FClient.Handle <> 0) and not (tfShowMarqueeProgressBar in FClient.Flags) then
      SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_RANGE, 0, MakeLParam(FMin, FMax));
  end;
end;

procedure TTaskDialogProgressBar.SetPosition(const Value: Integer);
begin
  if Value <> FPosition then
  begin
    if (Value < 0) or (Value > High(Word)) then
      raise Exception.CreateResFmt(@SOutOfRange, [0, High(Word)]);
    FPosition := Value;
    if (FClient.Handle <> 0) and not (tfShowMarqueeProgressBar in FClient.Flags) then
      SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_POS, FPosition, 0);
  end;
end;

const
  ProgressBarStates: array[TProgressBarState] of Integer = (PBST_NORMAL, PBST_ERROR, PBST_PAUSED);

procedure TTaskDialogProgressBar.SetState(const Value: TProgressBarState);
begin
  if Value <> FState then
  begin
    FState := Value;
    if (FClient.Handle <> 0) then
      SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_STATE, ProgressBarStates[FState], 0);
  end;
end;

procedure TTaskDialogProgressBar.SetMarqueeSpeed(const Value: Cardinal);
begin
  if Value <> FMarqueeSpeed then
  begin
    FMarqueeSpeed := Value;
    if (FClient.Handle <> 0) and (tfShowMarqueeProgressBar in FClient.Flags) then
      SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_MARQUEE, Windows.WPARAM(BOOL(True)), FMarqueeSpeed);
  end;
end;

procedure TTaskDialogProgressBar.Initialize;
begin
  SendMessage(FClient.Handle, TDM_SET_MARQUEE_PROGRESS_BAR,
    Windows.WPARAM(BOOL((tfShowMarqueeProgressBar in FClient.Flags))), 0);
  if (tfShowMarqueeProgressBar in FClient.Flags) then
    SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_MARQUEE, Windows.WPARAM(BOOL(True)), FMarqueeSpeed)
  else
  begin
    SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_RANGE, 0, MakeLParam(FMin, FMax));
    SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_POS, FPosition, 0);
  end;
  SendMessage(FClient.Handle, TDM_SET_PROGRESS_BAR_STATE, ProgressBarStates[FState], 0);
end;

{ TTaskDialogButton }

constructor TTaskDialogBaseButtonItem.Create(Collection: TCollection);
begin
  inherited;
  FCaption := '';
  FClient := TCustomtaskDialog(Collection.Owner);
  FEnabled := True;
  FModalResult := ID + 100; // Avoid mrNone..mrYesToAll and IDOK..IDCONTINUE
  FTextWStr := nil;
end;

destructor TTaskDialogBaseButtonItem.Destroy;
begin
  if FTextWStr <> nil then
    CoTaskMemFree(FTextWStr);
  inherited;
end;

procedure TTaskDialogBaseButtonItem.DoButtonClick;
begin
  if FClient.Handle <> 0 then
    SendMessage(FClient.Handle, TDM_CLICK_BUTTON, FModalResult, 0);
end;

procedure TTaskDialogBaseButtonItem.DoSetEnabled;
begin
  if FClient.Handle <> 0 then
    SendMessage(FClient.Handle, TDM_ENABLE_BUTTON, FModalResult, LPARAM(FEnabled))
end;

procedure TTaskDialogBaseButtonItem.Click;
begin
  DoButtonClick;
end;

function TTaskDialogBaseButtonItem.GetButtonText: string;
begin
  Result := FCaption;
end;

function TTaskDialogBaseButtonItem.GetDefault: Boolean;
begin
  Result := TTaskDialogButtons(Collection).DefaultButton = Self;
end;

function TTaskDialogBaseButtonItem.GetDisplayName: string;
begin
  Result := FCaption;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function TTaskDialogBaseButtonItem.GetTextWStr: LPCWSTR;
var
  Len: Integer;
  LText: string;
begin
  LText := GetButtonText;
  if FTextWStr <> nil then
    CoTaskMemFree(FTextWStr);
  Len := Length(LText);
  FTextWStr := CoTaskMemAlloc((Len * 2) + 2);
  Result := WStrPLCopy(FTextWStr, WideString(LText), Len);
end;

procedure TTaskDialogBaseButtonItem.SetCaption(const Value: string);
begin
  if Value <> FCaption then
  begin
    if Value = '' then
      raise Exception.CreateRes(@SInvalidTaskDlgButtonCaption);
    FCaption := Value;
  end;
end;

procedure TTaskDialogBaseButtonItem.SetDefault(const Value: Boolean);
begin
  if Value then
    TTaskDialogButtons(Collection).DefaultButton := Self
  else
    TTaskDialogButtons(Collection).DefaultButton := nil;
end;

procedure TTaskDialogBaseButtonItem.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    DoSetEnabled;
  end;
end;

procedure TTaskDialogBaseButtonItem.SetInitialState;
begin
  if not FEnabled then
    DoSetEnabled;
end;

{ TTaskDialogButtonItem }

constructor TTaskDialogButtonItem.Create(Collection: TCollection);
begin
  inherited;
  Caption := Format(STaskDlgButtonCaption, [ID + 1]);
  FElevationRequired := False;
end;

procedure TTaskDialogButtonItem.DoSetElevationRequired;
begin
  if Client.Handle <> 0 then
    SendMessage(Client.Handle, TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE,
      ModalResult, LPARAM(FElevationRequired))
end;

function TTaskDialogButtonItem.GetButtonText: string;
begin
  if (FCommandLinkHint <> '') and ((tfUseCommandLinks in Client.Flags) or
     (tfUseCommandLinksNoIcon in Client.Flags)) then
    Result := Caption + #10 + FCommandLinkHint
  else
    Result := inherited GetButtonText;
end;

procedure TTaskDialogButtonItem.SetElevationRequired(const Value: Boolean);
begin
  if Value <> FElevationRequired then
  begin
    FElevationRequired := Value;
    DoSetElevationRequired;
  end;
end;

procedure TTaskDialogButtonItem.SetInitialState;
begin
  inherited;
  if FElevationRequired then
    DoSetElevationRequired
end;

{ TTaskDialogRadioButtonItem }

constructor TTaskDialogRadioButtonItem.Create(Collection: TCollection);
begin
  inherited;
  Caption := Format(STaskDlgRadioButtonCaption, [ID + 1]);
end;

procedure TTaskDialogRadioButtonItem.DoButtonClick;
begin
  if Client.Handle <> 0 then
    SendMessage(Client.Handle, TDM_CLICK_RADIO_BUTTON, ModalResult, 0);
end;

procedure TTaskDialogRadioButtonItem.DoSetEnabled;
begin
  if Client.Handle <> 0 then
    SendMessage(Client.Handle, TDM_ENABLE_RADIO_BUTTON, ModalResult, LPARAM(Enabled))
end;

{ TTaskDialogButtonsEnumerator }

constructor TTaskDialogButtonsEnumerator.Create(ACollection: TTaskDialogButtons);
begin
  inherited Create;
  FIndex := -1;
  FCollection := ACollection;
end;

function TTaskDialogButtonsEnumerator.GetCurrent: TTaskDialogBaseButtonItem;
begin
  Result := FCollection[FIndex];
end;

function TTaskDialogButtonsEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FCollection.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TTaskDialogButtons }

function TTaskDialogButtons.Add: TTaskDialogBaseButtonItem;
begin
  Result := TTaskDialogBaseButtonItem(inherited Add);
end;

function TTaskDialogButtons.Buttons: PTaskDialogButton;
var
  I: Integer;
begin
  SetLength(FButtonList, Count);
  for I := 0 to Count - 1 do
  begin
    FButtonList[I].nButtonID := Items[I].ModalResult;
    FButtonList[I].pszButtonText := Items[I].TextWStr;
  end;
  Result := @FButtonList[0];
end;

function TTaskDialogButtons.FindButton(AModalResult: TModalResult): TTaskDialogBaseButtonItem;
var
  LButton: TTaskDialogBaseButtonItem;
begin
  Result := nil;
  for LButton in Self do
    if LButton.ModalResult = AModalResult then
    begin
      Result := LButton;
      Exit;
    end;
end;

function TTaskDialogButtons.GetEnumerator: TTaskDialogButtonsEnumerator;
begin
  Result := TTaskDialogButtonsEnumerator.Create(Self);
end;

function TTaskDialogButtons.GetItem(Index: Integer): TTaskDialogBaseButtonItem;
begin
  Result := TTaskDialogBaseButtonItem(inherited GetItem(Index));
end;

procedure TTaskDialogButtons.SetDefaultButton(const Value: TTaskDialogBaseButtonItem);
begin
  if Value <> FDefaultButton then
    FDefaultButton := Value;
end;

procedure TTaskDialogButtons.SetInitialState;
var
  LButton: TTaskDialogBaseButtonItem;
begin
  for LButton in Self do
    LButton.SetInitialState;
end;

procedure TTaskDialogButtons.SetItem(Index: Integer; const Value: TTaskDialogBaseButtonItem);
begin
  inherited SetItem(Index, Value);
end;

{ TCustomTaskDialog }

constructor TCustomTaskDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TTaskDialogButtons.Create(Self, TTaskDialogButtonItem);
  FCommonButtons := [tcbOk, tcbCancel];
  FCustomFooterIcon := TIcon.Create;
  FCustomMainIcon := TIcon.Create;
  FDefaultButton := tcbOk;
  FFlags := [tfAllowDialogCancellation];
  FFooterIcon := tdiNone;
  FHandle := 0;
  FMainIcon := tdiInformation;
  FProgressBar := TTaskDialogProgressBar.Create(Self);
  FRadioButtons := TTaskDialogButtons.Create(Self, TTaskDialogRadioButtonItem);
end;

destructor TCustomTaskDialog.Destroy;
begin
  FButtons.Free;
  FCustomFooterIcon.Free;
  FCustomMainIcon.Free;
  FProgressBar.Free;
  FRadioButtons.Free;
  inherited;
end;

function TCustomTaskDialog.CallbackProc(hwnd: HWND; msg: UINT; wParam: WPARAM;
  lParam: LPARAM; lpRefData: LONG_PTR): HResult;
var
  LCanClose, LReset: Boolean;
begin
  Result := S_OK;
  case msg of
    TDN_BUTTON_CLICKED:
      begin
        LCanClose := True;
        DoOnButtonClicked(wParam, LCanClose);
        if not LCanClose then
          Result := S_FALSE;
      end;
    TDN_CREATED:
      DoOnDialogCreated;
    TDN_DESTROYED:
      DoOnDialogDestroyed;
    TDN_DIALOG_CONSTRUCTED:
      begin
        FHandle := hwnd;
        FButtons.SetInitialState;
        FRadioButtons.SetInitialState;
        FProgressBar.Initialize;
        DoOnDialogContructed;
      end;
    TDN_EXPANDO_BUTTON_CLICKED:
      DoOnExpandButtonClicked(BOOL(wParam));
    TDN_HELP:
      DoOnHelp;
    TDN_HYPERLINK_CLICKED:
      DoOnHyperlinkClicked(PWideChar(lParam));
    TDN_NAVIGATED:
      DoOnNavigated;
    TDN_RADIO_BUTTON_CLICKED:
      DoOnRadioButtonClicked(wParam);
    TDN_TIMER:
      begin
        LReset := False;
        DoOnTimer(wParam, LReset);
        if LReset then
          Result := S_FALSE;
      end;
    TDN_VERIFICATION_CLICKED:
      DoOnVerificationClicked(wParam = 1);
  end;
end;

function TaskDialogCallbackProc(hwnd: HWND; msg: UINT; wParam: WPARAM;
  lParam: LPARAM; lpRefData: LONG_PTR): HResult; stdcall;
begin
  Result := TCustomTaskDialog(Pointer(lpRefData)).CallbackProc(hwnd, msg,
    wparam, lparam, 0);
end;

const
  CTaskDlgIcons: array[tdiNone..tdiShield] of PWideChar = (
    nil, TD_WARNING_ICON, TD_ERROR_ICON, TD_INFORMATION_ICON, TD_SHIELD_ICON);

function TCustomTaskDialog.DoExecute(ParentWnd: HWND): Boolean;
const
  CTaskDlgFlags: array[TTaskDialogFlag] of Cardinal = (
    TDF_Enable_Hyperlinks, TDF_Use_Hicon_Main,
    tdf_Use_Hicon_Footer, TDF_ALLOW_DIALOG_CANCELLATION,
    TDF_USE_COMMAND_LINKS, TDF_USE_COMMAND_LINKS_NO_ICON,
    TDF_EXPAND_FOOTER_AREA, TDF_EXPANDED_BY_DEFAULT,
    TDF_VERIFICATION_FLAG_CHECKED, TDF_SHOW_PROGRESS_BAR,
    TDF_SHOW_MARQUEE_PROGRESS_BAR, TDF_CALLBACK_TIMER,
    TDF_POSITION_RELATIVE_TO_WINDOW, TDF_RTL_LAYOUT,
    TDF_NO_DEFAULT_RADIO_BUTTON, TDF_CAN_BE_MINIMIZED);

  CTaskDlgCommonButtons: array[TTaskDialogCommonButton] of Cardinal = (
    TDCBF_OK_BUTTON, TDCBF_YES_BUTTON, TDCBF_NO_BUTTON,
    TDCBF_CANCEL_BUTTON, TDCBF_RETRY_BUTTON, TDCBF_CLOSE_BUTTON);

  CTaskDlgDefaultButtons: array[TTaskDialogCommonButton] of Integer = (
    IDOK, IDYES, IDNO, IDCANCEL, IDRETRY, IDCLOSE);

var
  LWindowList: Pointer;
  LRadioButton: Integer;
  LFlag: TTaskDialogFlag;
  LFocusState: TFocusState;
  LVerificationChecked: Boolean;
  LTaskDialog: TTaskDialogConfig;
  LCommonButton: TTaskDialogCommonButton;
begin
  if Win32MajorVersion < 6 then
    raise EPlatformVersionException.CreateResFmt(@SWindowsVistaRequired, [ClassName]);
  if not ThemeServices.ThemesEnabled then
    raise Exception.CreateResFmt(@SXPThemesRequired, [ClassName]);

  FillChar(LTaskDialog, SizeOf(LTaskDialog), 0);
  with LTaskDialog do
  begin
    // Set Size, Parent window, Flags
    cbSize := SizeOf(LTaskDialog);
    hwndParent := ParentWnd;
    dwFlags := 0;
    for LFlag := Low(TTaskDialogFlag) to High(TTaskDialogFlag) do
      if LFlag in FFlags then
        dwFlags := dwFlags or CTaskDlgFlags[LFlag];

    // Set CommonButtons
    dwCommonButtons := 0;
    for LCommonButton := Low(TTaskDialogCommonButton) to High(TTaskDialogCommonButton) do
      if LCommonButton in FCommonButtons then
        dwCommonButtons := dwCommonButtons or CTaskDlgCommonButtons[LCommonButton];

    // Set Content, MainInstruction, Title, MainIcon, DefaultButton
    if FText <> '' then
      pszContent := PWideChar(WideString(FText));
    if FTitle <> '' then
      pszMainInstruction := PWideChar(WideString(FTitle));
    if FCaption <> '' then
      pszWindowTitle := PWideChar(WideString(FCaption));
    if tfUseHiconMain in FFlags then
      hMainIcon := FCustomMainIcon.Handle
    else
    begin
      if FMainIcon in [tdiNone..tdiShield] then
        pszMainIcon := CTaskDlgIcons[FMainIcon]
      else
        pszMainIcon := PWideChar(MakeIntResourceW(Word(FMainIcon)));
    end;
    nDefaultButton := CTaskDlgDefaultButtons[FDefaultButton];

    // Set Footer, FooterIcon
    if FFooterText <> '' then
      pszFooter := PWideChar(WideString(FFooterText));
    if tfUseHiconFooter in FFlags then
      hFooterIcon := FCustomFooterIcon.Handle
    else
    begin
      if FFooterIcon in [tdiNone..tdiShield] then
        pszFooterIcon := CTaskDlgIcons[FFooterIcon]
      else
        pszFooterIcon := PWideChar(MakeIntResourceW(Word(FFooterIcon)));
    end;

    // Set VerificationText, ExpandedInformation, CollapsedControlText
    if FVerificationText <> '' then
      pszVerificationText := PWideChar(WideString(FVerificationText));
    if FExpandedText <> '' then
      pszExpandedInformation := PWideChar(WideString(FExpandedText));
    if FExpandButtonCaption <> '' then
      pszCollapsedControlText := PWideChar(WideString(FExpandButtonCaption));

    // Set Buttons
    cButtons := FButtons.Count;
    if cButtons > 0 then
      pButtons := FButtons.Buttons;
    if FButtons.DefaultButton <> nil then
      nDefaultButton := FButtons.DefaultButton.ModalResult;

    // Set RadioButtons
    cRadioButtons := FRadioButtons.Count;
    if cRadioButtons > 0 then
      pRadioButtons := FRadioButtons.Buttons;
    if not (tfNoDefaultRadioButton in FFlags) and (FRadioButtons.DefaultButton <> nil) then
      nDefaultRadioButton := FRadioButtons.DefaultButton.ModalResult;

    // Prepare callback
    lpCallbackData := LONG_PTR(Self);
    pfCallback := @TaskDialogCallbackProc;
  end;

  LWindowList := DisableTaskWindows(ParentWnd);
  LFocusState := SaveFocusState;
  try
    Result := TaskDialogIndirect(LTaskDialog, @FModalResult, @LRadioButton,
      @LVerificationChecked) = S_OK;
    if Result then
    begin
      FButton := TTaskDialogButtonItem(FButtons.FindButton(FModalResult));
      FRadioButton := TTaskDialogRadioButtonItem(FRadioButtons.FindButton(LRadioButton));
      if LVerificationChecked then
        Include(FFlags, tfVerificationFlagChecked);
    end;
  finally
    EnableTaskWindows(LWindowList);
    SetActiveWindow(ParentWnd);
    RestoreFocusState(LFocusState);
  end;
end;

procedure TCustomTaskDialog.DoOnButtonClicked(AModalResult: Integer; var CanClose: Boolean);
begin
  if Assigned(FOnButtonClicked) then
  begin
    FButton := TTaskDialogButtonItem(FButtons.FindButton(AModalResult));
    FOnButtonClicked(Self, AModalResult, CanClose);
  end;
end;

procedure TCustomTaskDialog.DoOnDialogCreated;
begin
  if Assigned(FOnDialogCreated) then
    FOnDialogCreated(Self);
end;

procedure TCustomTaskDialog.DoOnDialogDestroyed;
begin
  if Assigned(FOnDialogDestroyed) then
    FOnDialogDestroyed(Self);
end;

procedure TCustomTaskDialog.DoOnDialogContructed;
begin
  if Assigned(FOnDialogConstructed) then
    FOnDialogConstructed(Self);
end;

procedure TCustomTaskDialog.DoOnExpandButtonClicked(Expanded: Boolean);
begin
  if Assigned(FOnExpanded) then
  begin
    FExpanded := Expanded;
    FOnExpanded(Self);
  end;
end;

procedure TCustomTaskDialog.DoOnHelp;

  procedure ShowHelpException(E: Exception);
  var
    Msg: string;
    Flags: Integer;
  begin
    Flags := MB_OK or MB_ICONSTOP;
    if Application.UseRightToLeftReading then
      Flags := Flags or MB_RTLREADING;
    Msg := E.Message;
    if (Msg <> '') and (AnsiLastChar(Msg) > '.') then
      Msg := Msg + '.';
    MessageBox(FHandle, PChar(Msg), PChar(Application.Title), Flags);
  end;

begin
  if FHelpContext <> 0 then
  try
    Application.HelpContext(FHelpContext);
  except
    on E: Exception do
      ShowHelpException(E);
  end;
end;

procedure TCustomTaskDialog.DoOnHyperlinkClicked(const AURL: string);
begin
  if Assigned(FOnHyperlinkClicked) then
  begin
    FURL := AURL;
    FOnHyperlinkClicked(Self);
  end;
end;

procedure TCustomTaskDialog.DoOnNavigated;
begin
  if Assigned(FOnNavigated) then
    FOnNavigated(Self);
end;

procedure TCustomTaskDialog.DoOnRadioButtonClicked(ButtonID: Integer);
begin
  if Assigned(FOnRadioButtonClicked) then
  begin
    FRadioButton := TTaskDialogRadioButtonItem(FRadioButtons.FindButton(ButtonID));
    FOnRadioButtonClicked(Self);
  end;
end;

procedure TCustomTaskDialog.DoOnTimer(TickCount: Cardinal; var Reset: Boolean);
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self, TickCount, Reset);
end;

procedure TCustomTaskDialog.DoOnVerificationClicked(Checked: Boolean);
begin
  if Assigned(FOnVerificationClicked) then
  begin
    if Checked then
      Include(FFlags, tfVerificationFlagChecked)
    else
      Exclude(FFlags, tfVerificationFlagChecked);
    FOnVerificationClicked(Self);
  end;
end;

function TCustomTaskDialog.Execute: Boolean;
var
  LParentWnd: HWND;
begin
  if Assigned(Screen.ActiveForm) then
    LParentWnd := Screen.ActiveForm.Handle
  else
  begin
    LParentWnd := Application.ActiveFormHandle;
    if LParentWnd = 0 then
      LParentWnd := Application.Handle;
  end;
  Result := Execute(LParentWnd);
end;

function TCustomTaskDialog.Execute(ParentWnd: HWND): Boolean;
begin
  FModalResult := 0;
  Result := DoExecute(ParentWnd);
end;

procedure TCustomTaskDialog.SetButtons(const Value: TTaskDialogButtons);
begin
  if Value <> FButtons then
    FButtons.Assign(Value);
end;

procedure TCustomTaskDialog.SetCustomFooterIcon(const Value: TIcon);
begin
  if Value <> FCustomFooterIcon then
    FCustomFooterIcon.Assign(Value);
end;

procedure TCustomTaskDialog.SetCustomMainIcon(const Value: TIcon);
begin
  if Value <> FCustomMainIcon then
    FCustomMainIcon.Assign(Value);
end;

procedure TCustomTaskDialog.SetExpandedText(const Value: string);
begin
  if Value <> FExpandedText then
  begin
    FExpandedText := Value;
    if FHandle <> 0 then
      SendMessage(FHandle, TDM_UPDATE_ELEMENT_TEXT, TDE_EXPANDED_INFORMATION,
        LPARAM(PWideChar(WideString(FExpandedText))));
  end;
end;

procedure TCustomTaskDialog.SetFlags(const Value: TTaskDialogFlags);
begin
  if Value <> FFlags then
  begin
    if (tfVerificationFlagChecked in FFlags) <> (tfVerificationFlagChecked in Value) and
       (FHandle <> 0) then
      SendMessage(FHandle, TDM_CLICK_VERIFICATION,
        WPARAM((tfVerificationFlagChecked in Value)), LPARAM(False));
    FFlags := Value;
  end;
end;

procedure TCustomTaskDialog.SetFooterIcon(const Value: TTaskDialogIcon);
begin
  if Value <> FFooterIcon then
  begin
    FFooterIcon := Value;
    if FHandle <> 0 then
      SendMessage(FHandle, TDM_UPDATE_ICON, TDIE_ICON_FOOTER, LPARAM(CTaskDlgIcons[FFooterIcon]));
  end;
end;

procedure TCustomTaskDialog.SetFooterText(const Value: string);
begin
  if Value <> FFooterText then
  begin
    FFooterText := Value;
    if FHandle <> 0 then
      SendMessage(FHandle, TDM_UPDATE_ELEMENT_TEXT, TDE_FOOTER,
        LPARAM(PWideChar(WideString(FFooterText))));
  end;
end;

procedure TCustomTaskDialog.SetMainIcon(const Value: TTaskDialogIcon);
begin
  if Value <> FMainIcon then
  begin
    FMainIcon := Value;
    if FHandle <> 0 then
      SendMessage(FHandle, TDM_UPDATE_ICON, TDIE_ICON_MAIN, LPARAM(CTaskDlgIcons[FMainIcon]));
  end;
end;

procedure TCustomTaskDialog.SetRadioButtons(const Value: TTaskDialogButtons);
begin
  if Value <> FRadioButtons then
    FRadioButtons.Assign(Value);
end;

procedure TCustomTaskDialog.SetText(const Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    if FHandle <> 0 then
      SendMessage(FHandle, TDM_UPDATE_ELEMENT_TEXT, TDE_CONTENT,
        LPARAM(PWideChar(WideString(FText))));
  end;
end;

procedure TCustomTaskDialog.SetTitle(const Value: string);
begin
  if Value <> FTitle then
  begin
    FTitle := Value;
    if FHandle <> 0 then
      SendMessage(FHandle, TDM_UPDATE_ELEMENT_TEXT, TDE_MAIN_INSTRUCTION,
        LPARAM(PWideChar(WideString(FTitle))));
  end;
end;

{ Message dialog }

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;


type
  TMessageForm = class(TForm)
  private
    Message: TLabel;
    procedure HelpButtonClick(Sender: TObject);
  protected
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WriteToClipBoard(Text: String);
    function GetFormText: String;
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
  end;

constructor TMessageForm.CreateNew(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
end;

procedure TMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TMessageForm.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    Beep;
    WriteToClipBoard(GetFormText);
  end;
end;

procedure TMessageForm.WriteToClipBoard(Text: String);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if OpenClipBoard(0) then
  begin
    try
      Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Length(Text) + 1);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(PChar(Text)^, DataPtr^, Length(Text) + 1);
          EmptyClipBoard;
          SetClipboardData(CF_TEXT, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      CloseClipBoard;
    end;
  end
  else
    raise Exception.CreateRes(@SCannotOpenClipboard);
end;

function TMessageForm.GetFormText: String;
var
  DividerLine, ButtonCaptions: string;
  I: integer;
begin
  DividerLine := StringOfChar('-', 27) + sLineBreak;
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TButton then
      ButtonCaptions := ButtonCaptions + TButton(Components[I]).Caption +
        StringOfChar(' ', 3);
  ButtonCaptions := StringReplace(ButtonCaptions,'&','', [rfReplaceAll]);
  Result := Format('%s%s%s%s%s%s%s%s%s%s', [DividerLine, Caption, sLineBreak,
    DividerLine, Message.Caption, sLineBreak, DividerLine, ButtonCaptions,
    sLineBreak, DividerLine]);
end;

var
  Captions: array[TMsgDlgType] of Pointer = (@SMsgDlgWarning, @SMsgDlgError,
    @SMsgDlgInformation, @SMsgDlgConfirm, nil);
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  ButtonNames: array[TMsgDlgBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help');
  ButtonCaptions: array[TMsgDlgBtn] of Pointer = (
    @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgOK, @SMsgDlgCancel, @SMsgDlgAbort,
    @SMsgDlgRetry, @SMsgDlgIgnore, @SMsgDlgAll, @SMsgDlgNoToAll, @SMsgDlgYesToAll,
    @SMsgDlgHelp);
  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0);
var
  ButtonWidths : array[TMsgDlgBtn] of integer;  // initialized to zero

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): TForm;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, ALeft: Integer;
  B, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  TextRect: TRect;
  LButton: TButton;
begin
  Result := TMessageForm.CreateNew(Application);
  with Result do
  begin
    BiDiMode := Application.BiDiMode;
    BorderStyle := bsDialog;
    Canvas.Font := Font;
    KeyPreview := True;
    Position := poDesigned;
    OnKeyDown := TMessageForm(Result).CustomKeyDown;
    DialogUnits := GetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      if B in Buttons then
      begin
        if ButtonWidths[B] = 0 then
        begin
          TextRect := Rect(0,0,0,0);
          Windows.DrawText( canvas.handle,
            PChar(LoadResString(ButtonCaptions[B])), -1,
            TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or
            DrawTextBiDiModeFlagsReadingOnly);
          with TextRect do ButtonWidths[B] := Right - Left + 8;
        end;
        if ButtonWidths[B] > ButtonWidth then
          ButtonWidth := ButtonWidths[B];
      end;
    end;
    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
    DrawText(Canvas.Handle, PChar(Msg), Length(Msg)+1, TextRect,
      DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or
      DrawTextBiDiModeFlagsReadingOnly);
    IconID := IconIDs[DlgType];
    IconTextWidth := TextRect.Right;
    IconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;
    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);
    if DlgType <> mtCustom then
      Caption := LoadResString(Captions[DlgType]) else
      Caption := Application.Title;
    if IconID <> nil then
      with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;
    TMessageForm(Result).Message := TLabel.Create(Result);
    with TMessageForm(Result).Message do
    begin
      Name := 'Message';
      Parent := Result;
      WordWrap := True;
      Caption := Msg;
      BoundsRect := TextRect;
      BiDiMode := Result.BiDiMode;
      ALeft := IconTextWidth - TextRect.Right + HorzMargin;
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
      SetBounds(ALeft, VertMargin,
        TextRect.Right, TextRect.Bottom);
    end;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
      begin
        LButton := TButton.Create(Result);
        with LButton do
        begin
          Name := ButtonNames[B];
          Parent := Result;
          Caption := LoadResString(ButtonCaptions[B]);
          ModalResult := ModalResults[B];
          if B = DefaultButton then
          begin
            Default := True;
            ActiveControl := LButton;
          end;
          if B = CancelButton then
            Cancel := True;
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing,
            ButtonWidth, ButtonHeight);
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := TMessageForm(Result).HelpButtonClick;
        end;
      end;
  end;
end;

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons): TForm;
var
  DefaultButton: TMsgDlgBtn;
begin
  if mbOk in Buttons then DefaultButton := mbOk else
    if mbYes in Buttons then DefaultButton := mbYes else
      DefaultButton := mbRetry;
  Result := CreateMessageDialog(Msg, DlgType, Buttons, DefaultButton);
end;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, -1, -1, '', DefaultButton);
end;

function TaskMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := TaskMessageDlgPosHelp(Title, Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;

function TaskMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := TaskMessageDlgPosHelp(Title, Msg, DlgType, Buttons, HelpCtx,
    -1, -1, '', DefaultButton);
end;

function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;

function MessageDlgPos(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, HelpCtx, X, Y, '', DefaultButton);
end;

function TaskMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer;
begin
  Result := TaskMessageDlgPosHelp(Title, Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;

function TaskMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  Result := TaskMessageDlgPosHelp(Title, Msg, DlgType, Buttons, HelpCtx,
    X, Y, '', DefaultButton);
end;

function DoMessageDlgPosHelp(MessageDialog: TForm; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;
begin
  with MessageDialog do
    try
      HelpContext := HelpCtx;
      HelpFile := HelpFileName;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if (Y < 0) and (X < 0) then Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
end;

{ Forward declarations for TaskDialog based implementations }

function DoTaskMessageDlgPosHelp(const Instruction, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer; overload; forward;

function DoTaskMessageDlgPosHelp(const Instruction, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer; overload; forward;


function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;
begin
  if (Win32MajorVersion >= 6) and UseLatestCommonDialogs and ThemeServices.ThemesEnabled then
    Result := DoTaskMessageDlgPosHelp('', Msg, DlgType, Buttons,
      HelpCtx, X, Y, HelpFileName)
  else
    Result := DoMessageDlgPosHelp(CreateMessageDialog(Msg, DlgType, Buttons),
      HelpCtx, X, Y, HelpFileName);
end;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer; overload;
begin
  if (Win32MajorVersion >= 6) and UseLatestCommonDialogs and ThemeServices.ThemesEnabled then
    Result := DoTaskMessageDlgPosHelp('', Msg, DlgType, Buttons,
      HelpCtx, X, Y, HelpFileName, DefaultButton)
  else
    Result := DoMessageDlgPosHelp(CreateMessageDialog(Msg, DlgType, Buttons, DefaultButton),
      HelpCtx, X, Y, HelpFileName);
end;

function TaskMessageDlgPosHelp(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;
begin
  if (Win32MajorVersion >= 6) and ThemeServices.ThemesEnabled then
    Result := DoTaskMessageDlgPosHelp(Title, Msg, DlgType, Buttons,
      HelpCtx, X, Y, HelpFileName)
  else
    Result := DoMessageDlgPosHelp(CreateMessageDialog(Msg, DlgType, Buttons),
      HelpCtx, X, Y, HelpFileName);
end;

function TaskMessageDlgPosHelp(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer;
begin
  if (Win32MajorVersion >= 6) and ThemeServices.ThemesEnabled then
    Result := DoTaskMessageDlgPosHelp(Title, Msg, DlgType, Buttons,
      HelpCtx, X, Y, HelpFileName, DefaultButton)
  else
    Result := DoMessageDlgPosHelp(CreateMessageDialog(Msg, DlgType, Buttons, DefaultButton),
      HelpCtx, X, Y, HelpFileName);
end;

procedure ShowMessage(const Msg: string);
begin
  ShowMessagePos(Msg, -1, -1);
end;

procedure ShowMessageFmt(const Msg: string; Params: array of const);
begin
  ShowMessage(Format(Msg, Params));
end;

procedure ShowMessagePos(const Msg: string; X, Y: Integer);
begin
  MessageDlgPos(Msg, mtCustom, [mbOK], 0, X, Y);
end;

{ TaskDialog based message dialog; requires Windows Vista or later }

type
  PTaskDialogData = ^TTaskDialogData;
  TTaskDialogData = record
    HelpCtx: Integer;
    HelpFileName: string;
    ParentWnd: HWND;
    Position: TPoint;
  end;

procedure ShowHelpException(ParentWnd: HWND; E: Exception);
var
  Msg: string;
  Flags: Integer;
begin
  Flags := MB_OK or MB_ICONSTOP;
  if Application.UseRightToLeftReading then
    Flags := Flags or MB_RTLREADING;
  Msg := E.Message;
  if (Msg <> '') and (AnsiLastChar(Msg) > '.') then
    Msg := Msg + '.';
  MessageBox(ParentWnd, PChar(Msg), PChar(Application.Title), Flags);
end;

function TaskDlgCallback(hwnd: HWND; msg: UINT; wParam: WPARAM;
  lParam: LPARAM; lpRefData: LONG_PTR): HResult; stdcall;
var
  Rect: TRect;
  LHandle: HMONITOR;
  LHelpFile: string;
  LHelpSystem: IHelpSystem;
  LMonitorInfo: TMonitorInfo;
begin
  Result := S_OK;
  case msg of
    TDN_HELP:
      with PTaskDialogData(lpRefData)^ do
      begin
        if HelpFileName = '' then
          LHelpFile := Application.HelpFile
        else
          LHelpFile := HelpFileName;
        if HelpIntfs.GetHelpSystem(LHelpSystem) then
        try
          LHelpSystem.Hook(Application.Handle, LHelpFile, HELP_CONTEXT, HelpCtx);
        except
          on E: Exception do
            ShowHelpException(hwnd, E);
        end;
      end;
    TDN_CREATED:
      with PTaskDialogData(lpRefData)^, Position do
      begin
        LHandle := MonitorFromWindow(ParentWnd, MONITOR_DEFAULTTONEAREST);
        LMonitorInfo.cbSize := SizeOf(LMonitorInfo);
        if GetMonitorInfo(LHandle, @LMonitorInfo) then
          with LMonitorInfo do
          begin
            GetWindowRect(hwnd, Rect);
            if X < 0 then
              X := ((rcMonitor.Right - rcMonitor.Left) - (Rect.Right - Rect.Left)) div 2;
            if Y < 0 then
              Y := ((rcMonitor.Bottom - rcMonitor.Top) - (Rect.Bottom - Rect.Top)) div 2;
            Inc(X, rcMonitor.Left);
            Inc(Y, rcMonitor.Top);
            SetWindowPos(hwnd, 0, X, Y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
          end;
      end;
  end;
end;

function DoTaskMessageDlgPosHelp(const Instruction, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string; DefaultButton: TMsgDlgBtn): Integer;
const
  IconIDs: array[TMsgDlgType] of PWideChar = (TD_WARNING_ICON, TD_ERROR_ICON,
    TD_INFORMATION_ICON, TD_INFORMATION_ICON, nil);
var
  Len, I: Integer;
  LCaption: string;
  DlgBtn: TMsgDlgBtn;
  ButtonCount: Integer;
  LData: TTaskDialogData;
  LTaskDialog: TTaskDialogConfig;
  LButtons: array[0..Integer(High(TMsgDlgBtn)) - 1] of TTaskDialogButton;
  WindowList: Pointer;
  FocusState: TFocusState;
  ActiveWindow: HWND;
begin
  FillChar(LTaskDialog, SizeOf(LTaskDialog), 0);
  FillChar(LButtons, Length(LButtons) * SizeOf(TTaskDialogButton), 0);
  ButtonCount := 0;
  try
    with LTaskDialog do
    begin
      cbSize := SizeOf(LTaskDialog);
      if Assigned(Screen.ActiveForm) then
        hwndParent := Screen.ActiveForm.Handle
      else
      begin
        hwndParent := Application.ActiveFormHandle;
        if hwndParent = 0 then
          hwndParent := Application.Handle;
      end;
      dwFlags := TDF_ALLOW_DIALOG_CANCELLATION;
      if Application.UseRightToLeftReading then
        dwFlags := dwFlags or TDF_RTL_LAYOUT;
      pszMainIcon :=  IconIDs[DlgType];
      for DlgBtn := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
        if DlgBtn in Buttons then
          with LButtons[ButtonCount] do
          begin
            LCaption := LoadResString(ButtonCaptions[DlgBtn]);
            Len := Length(LCaption);
            nButtonId := ModalResults[DlgBtn];
            pszButtonText := WStrPLCopy(CoTaskMemAlloc((Len * 2) + 2),
              WideString(LCaption), Len);
            Inc(ButtonCount);
          end;
      cButtons := ButtonCount;
      pButtons := @LButtons[0];
      nDefaultButton := ModalResults[DefaultButton];
      pszWindowTitle := PWideChar(WideString(LoadResString(Captions[DlgType])));
      pszMainInstruction := PWideChar(WideString(Instruction));
      pszContent := PWideChar(WideString(Msg));
      if (X >= 0) or (Y >= 0) or (HelpCtx <> 0) then
      begin
        LData.HelpCtx := HelpCtx;
        LData.HelpFileName := HelpFileName;
        LData.ParentWnd := hwndParent;
        LData.Position := Point(X, Y);
        lpCallbackData := LONG_PTR(@LData);
        pfCallback := TaskDlgCallback;
      end;
    end;

    ActiveWindow := Application.ActiveFormHandle;
    WindowList := DisableTaskWindows(ActiveWindow);
    FocusState := SaveFocusState;
    try
      TaskDialogIndirect(LTaskDialog, @Result, nil, nil);
    finally
      EnableTaskWindows(WindowList);
      SetActiveWindow(ActiveWindow);
      RestoreFocusState(FocusState);
    end;
  finally
    for I := 0 to ButtonCount - 1 do
      if LButtons[I].pszButtonText <> nil then
        CoTaskMemFree(LButtons[I].pszButtonText);
  end;
end;

function DoTaskMessageDlgPosHelp(const Instruction, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  const HelpFileName: string): Integer;
var
  DefaultButton: TMsgDlgBtn;
begin
  if mbOk in Buttons then DefaultButton := mbOk else
    if mbYes in Buttons then DefaultButton := mbYes else
      DefaultButton := mbRetry;
  Result := DoTaskMessageDlgPosHelp(Instruction, Msg, DlgType, Buttons, HelpCtx,
    X, Y, HelpFileName, DefaultButton);
end;

{ Input dialog }

function InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;          
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result);
end;

function PromptForFileName(var AFileName: string; const AFilter: string = '';
  const ADefaultExt: string = ''; const ATitle: string = '';
  const AInitialDir: string = ''; SaveDialog: Boolean = False): Boolean;
var
  Dialog: TOpenDialog;
begin
  if SaveDialog then
  begin
    Dialog := TSaveDialog.Create(nil);
    Dialog.Options := Dialog.Options + [ofOverwritePrompt];
  end
  else
    Dialog := TOpenDialog.Create(nil);
  with Dialog do
  try
    Title := ATitle;
    DefaultExt := ADefaultExt;
    if AFilter = '' then
      Filter := SDefaultFilter else
      Filter := AFilter;
    InitialDir := AInitialDir;
    FileName := AFileName;
    Result := Execute;
    if Result then
      AFileName := FileName;
  finally
    Free;
  end;
end;

{ Initialization and cleanup }

procedure InitGlobals;
var
  AtomText: array[0..31] of Char;
begin
  HelpMsg := RegisterWindowMessage(HelpMsgString);
  FindMsg := RegisterWindowMessage(FindMsgString);
  WndProcPtrAtom := GlobalAddAtom(StrFmt(AtomText,
    'WndProcPtr%.8X%.8X', [HInstance, GetCurrentThreadID]));
end;

initialization
  InitGlobals;
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TCommonDialog, TControl);
finalization
  if WndProcPtrAtom <> 0 then GlobalDeleteAtom(WndProcPtrAtom);
end.
