{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit ActnMan;

interface

uses Windows, Messages, SysUtils, Forms, Classes, Menus, ActnList, Graphics,
  ToolWin, ImgList, Controls, Buttons, OleAcc;

const
  CM_ITEMSELECTED  = CM_BASE + $0402;
  CM_ITEMCLICKED   = CM_BASE + $0403;
  CM_ITEMKEYED     = CM_BASE + $0404;
  CM_SCROLLCLICKED = CM_BASE + $0406;
  CM_RESETBAR      = CM_BASE + $0409;
  CM_ENTERMENULOOP = CM_BASE + $0410;
  CM_ITEMDROPPOINT = CM_BASE + $0411;

type

  TActionBars = class;
  TActionListCollection = class;
  TActionClientsCollection = class;
  TActionClientItem = class;
  TActionClientItemClass = class of TActionClientItem;
  TCustomActionBar = class;
  TActionClient = class;
  TActionClients = class;
  TActionClientsClass = class of TActionClients;
  TActionBarsClass = class of TActionBars;
  TActionBarItem = class;
  TActionBarItemClass = class of TActionBarItem;
  TCustomActionManager = class;
  TGetBarsClassEvent = procedure(Sender: TCustomActionManager;
    BarsClass: TActionBarsClass) of object;
  TGetBarItemClassEvent = procedure(Sender: TCustomActionManager;
    var BarItemClass: TActionBarItemClass) of object;
  TGetClientsClassEvent = procedure(Sender: TCustomActionManager;
    var ClientsClass: TActionClientsClass) of object;
  TGetClientItemClassEvent = procedure(Sender: TCustomActionManager;
    var ClientItemClass: TActionClientItemClass) of object;
  TStyleChanged = procedure(Sender: TCustomActionManager) of object;    
  TActionProc = procedure(AClient: TActionClient) of object;

{ TActionBarStyle }

  TCustomActionControl = class;
  TCustomActionControlClass = class of TCustomActionControl;
  TCustomActionBarColorMap = class;
  TCustomColorMapClass = class of TCustomActionBarColorMap;

{ The following class requires the $M directive units which register
  descendants of this class to be added to the uses clause by the IDE. }

{$M+}

  TActionBarStyle = class
  public
    function GetControlClass(ActionBar: TCustomActionBar;
      AnItem: TActionClientItem): TCustomActionControlClass; virtual; abstract;
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; virtual; abstract;
    function GetStyleName: string; virtual; abstract;
  end;

{$M-}

{ TCustomActionManager }

  TCustomActionManager = class(TCustomActionList)
  private
    FAction: TCustomAction;
    FActionBars: TActionBars;
    FCompareCaption: string;
    FCompareProc: TActionProc;
    FFoundClient: TActionClientItem;
    FLinkedActionLists: TActionListCollection;
    FDefaultActionBars: TActionBars;
    FFileName: TFileName;
    FLoading: Boolean;
    FPrioritySchedule: TStringList;
    FSaved: Boolean;
    FOnGetBarItemClass: TGetBarItemClassEvent;
    FOnGetBarsClass: TGetBarsClassEvent;
    FOnGetClientItemClass: TGetClientItemClassEvent;
    FOnGetClientsClass: TGetClientsClassEvent;
    FOnStyleChanged: TStyleChanged;
    FStyle: TActionBarStyle;
    procedure CompareCaption(AClient: TActionClient);
    procedure CompareAction(AClient: TActionClient);
    function FindItem: TActionClientItem;
    procedure SetActionBars(const Value: TActionBars);
    procedure SetPrioritySchedule(const Value: TStringList);
    function IsPriorityScheduleStored: Boolean;
    procedure SetLinkedActionLists(const Value: TActionListCollection);
    function IsLinkedActionListsStored: Boolean;
    function IsActionBarsStored: Boolean;
    function GetLinkedActionLists: TActionListCollection;
    procedure ReadStyleProp(Reader: TReader);
    procedure WriteStyleProp(Writer: TWriter);
    procedure SetStyle(const Value: TActionBarStyle);
    procedure ResetClientUsageData(AClient: TActionClient);
  protected
    procedure Change; override;
    function CreateActionBars: TActionBars;
    procedure DefineProperties(Filer: TFiler); override;
    function FindActionClient(AnAction: TContainedAction;
      Clients: TActionClientsCollection = nil): TActionClientItem;
    function FindActionBar(ActionBar: TCustomActionBar;
      Clients: TActionClientsCollection = nil): TActionClient;
    procedure FindClient(AClient: TActionClient);
    function GetActionBarsClass: TActionBarsClass; dynamic;
    function GetActionBarItemClass: TActionBarItemClass; dynamic;
    function GetActionClientsClass: TActionClientsClass; dynamic;
    function GetActionClientItemClass: TActionClientItemClass; dynamic;
    function GetUsage(AnItem: TActionClientItem): Boolean; virtual;
    function HasLinkedActionLists: Boolean;
    procedure Loaded; override;
    procedure LoadMenu(Clients: TActionClients; AMenu: TMenuItem);
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure SetState(const Value: TActionListState); override;
    procedure SetupActionBars(ActionBars: TActionClientsCollection);
    procedure SetImages(Value: TCustomImageList); override;
    property Loading: Boolean read FLoading;
    property OnGetBarItemClass: TGetBarItemClassEvent read FOnGetBarItemClass
      write FOnGetBarItemClass;
    property OnGetBarsClass: TGetBarsClassEvent read FOnGetBarsClass
      write FOnGetBarsClass;
    property OnGetClientsClass: TGetClientsClassEvent read FOnGetClientsClass
      write FOnGetClientsClass;
    property OnGetClientItemClass: TGetClientItemClassEvent read FOnGetClientItemClass
      write FOnGetClientItemClass;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddAction(AnAction: TCustomAction; AClient: TActionClient;
      After: Boolean = True): TActionClientItem;
    function AddCategory(ACategory: string; AClient: TActionClient;
      After: Boolean = True): TActionClientItem;
    function AddSeparator(AnItem: TActionClientItem; After: Boolean = True): TActionClientItem;
    procedure AfterConstruction; override;    
    procedure Assign(Source: TPersistent); override;
    procedure DeleteActionItems(Actions: array of TCustomAction);
    procedure DeleteItem(Caption: string);
    function FindItemByCaption(ACaption: string): TActionClientItem;
    function FindItemByAction(Action: TCustomAction): TActionClientItem;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure ResetActionBar(Index: Integer);
    procedure ResetUsageData;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    property ActionBars: TActionBars read FActionBars write SetActionBars
      stored IsActionBarsStored;
    property DefaultActionBars: TActionBars read FDefaultActionBars;
    property LinkedActionLists: TActionListCollection read GetLinkedActionLists
      write SetLinkedActionLists stored IsLinkedActionListsStored;
    property FileName: TFileName read FFileName write FFileName;
    property Images;
    property PrioritySchedule: TStringList read FPrioritySchedule
      write SetPrioritySchedule stored IsPriorityScheduleStored;
    property Style: TActionBarStyle read FStyle write SetStyle;
    property OnStyleChanged: TStyleChanged read FOnStyleChanged write FOnStyleChanged;
  end;

{ TActionManager }

  TActionManager = class(TCustomActionManager)
  published
    // FileName must be streamed before ActionBars
    property FileName;
    property ActionBars;
    property LinkedActionLists;
    property Images;
    property PrioritySchedule;
    property State;
    property Style;
    property OnChange;
    property OnExecute;
    property OnGetBarItemClass;
    property OnGetBarsClass;
    property OnGetClientsClass;
    property OnGetClientItemClass;
    property OnUpdate;
    property OnStateChange;
    property OnStyleChanged;
  end;

{ TActionListItem }

  TActionListItem = class(TCollectionItem)
  private
    FActionList: TCustomActionList;
    FCaption: string;
    procedure SetActionList(const Value: TCustomActionList);
    function GetCaption: string;
  protected
    function GetDisplayName: string; override;
    function Owner: TActionListCollection;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ActionList: TCustomActionList read FActionList write SetActionList;
    property Caption: string read GetCaption write FCaption;
  end;

{ TActionListCollection }

  TActionListCollection = class(TOwnedCollection)
  private
    function GetActionManager: TCustomActionManager;
    function GetListItem(Index: Integer): TActionListItem;
    procedure SetListItem(Index: Integer;
      const Value: TActionListItem);
  public
    property ActionManager: TCustomActionManager read GetActionManager;
    property ListItems[Index: Integer]: TActionListItem read GetListItem
      write SetListItem; default;
  end;

{ TActionClientsCollection }

  TActionClientsCollection = class(TOwnedCollection)
  private
    FAutoHotKeys: Boolean;
    FParentItem: TActionClient;
    FCustomizable: Boolean;
    function GetActionClient(const Index: Integer): TActionClient;
    procedure SetActionClient(const Index: Integer;
      const Value: TActionClient);
    procedure SetAutoHotKeys(const Value: Boolean);
  protected
    function GetActionManager: TCustomActionManager;
    function InternalRethinkHotkeys(ForceRethink: Boolean): Boolean;
    property ActionClients[const Index: Integer]: TActionClient
      read GetActionClient write SetActionClient; default;
    property ParentItem: TActionClient read FParentItem write FParentItem;
  public
    procedure AfterConstruction; override;
    procedure IterateClients(Clients: TActionClientsCollection; ActionProc: TActionProc);
    property ActionManager: TCustomActionManager read GetActionManager;
    property AutoHotKeys: Boolean read FAutoHotKeys write SetAutoHotKeys;
    property Customizable: Boolean read FCustomizable write FCustomizable default True;
  end;

{ TActionClient }

  TBackgroundLayout = (blNormal, blStretch, blTile, blLeftBanner, blRightBanner);
  TChangesAllowed = (caModify, caMove, caDelete);
  TChangesAllowedSet = set of TChangesAllowed;

  TActionClient = class(TCollectionItem)
  private
    FActionBar: TCustomActionBar;
    FAccessible: IAccessible;
    FBackground: TPicture;
    FBackgroundLayout: TBackgroundLayout;
    FChildActionBar: TCustomActionBar;
    FContextItems: TActionClients;
    FCaption: string;
    FColor: TColor;
    FSmallIcons: Boolean;
    FItems: TActionClients;
    FVisible: Boolean;
    FChangesAllowed: TChangesAllowedSet;
    FTag: Integer;
    function GetContextItems: TActionClients;
    procedure SetActionBar(const Value: TCustomActionBar);
    procedure SetItems(const Value: TActionClients);
    procedure SetBackground(const Value: TPicture);
    procedure SetBackgroundLayout(const Value: TBackgroundLayout);
    procedure SetContextItems(const Value: TActionClients);
    function IsBackgroundStored: Boolean;
    function AreContextItemsStored: Boolean;
    function GetBackground: TPicture;
    function GetItems: TActionClients;
    function IsItemsStored: Boolean;
    function GetHasItems: Boolean;
    function GetOwningCollection: TActionClientsCollection;
  protected
    procedure ClearActionBar;
    procedure ColorChanged; virtual;
    procedure FreeChildren;
    function HasVisibleItems: Boolean;
    function IsChildItem(AClient: TActionClient): Boolean;
    procedure SetChangesAllowed(const Value: TChangesAllowedSet); virtual;
    procedure SetColor(const Value: TColor); virtual;
    procedure SetVisible(const Value: Boolean); virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function HasBackground: Boolean;
    procedure Refresh; virtual;
    property ActionBar: TCustomActionBar read FActionBar write SetActionBar;
    property Accessible: IAccessible read FAccessible write FAccessible;
    property ChildActionBar: TCustomActionBar read FChildActionBar
      write FChildActionBar;
    property HasItems: Boolean read GetHasItems;
    property OwningCollection: TActionClientsCollection read GetOwningCollection;
  published
    property ChangesAllowed: TChangesAllowedSet read FChangesAllowed
      write SetChangesAllowed default [caModify, caMove, caDelete];
    property Color: TColor read FColor write SetColor default clDefault;
    property ContextItems: TActionClients read GetContextItems write SetContextItems
      stored AreContextItemsStored;
    property Background: TPicture read GetBackground write SetBackground
      stored IsBackgroundStored;
    property BackgroundLayout: TBackgroundLayout read FBackgroundLayout
      write SetBackgroundLayout default blNormal;
    property Items: TActionClients read GetItems write SetItems
      stored IsItemsStored;
    property Tag: Integer read FTag write FTag default 0;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

{ TActionBarItem }

  TActionBarItem = class(TActionClient)
  private
    FAutoSize: Boolean;
    FGlyphLayout: TButtonLayout;
    function GetActionBars: TActionBars;
    procedure SetAutoSize(const Value: Boolean);
    procedure SetGlyphLayout(const Value: TButtonLayout);
  protected
    procedure ColorChanged; override;
    function GetDisplayName: string; override;
    procedure SetVisible(const Value: Boolean); override;
    property ActionBars: TActionBars read GetActionBars;
  public
    constructor Create(Collection: TCollection); override;
    procedure Refresh; override;
  published
    property ActionBar;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property GlyphLayout: TButtonLayout read FGlyphLayout write SetGlyphLayout default blGlyphLeft;
  end;

{ TActionBars }

  TActionBars = class(TActionClientsCollection)
  private
    FSessionCount: Integer;
    FShowHint: Boolean;
    function GetActionBar(const Index: Integer): TActionBarItem;
    procedure SetShowHints(const Value: Boolean);
    procedure SetHintShortCuts(const Value: Boolean);
    function GetHintShortCuts: Boolean;
  protected
    procedure DoShowHint(AClient: TActionClient);
    procedure Loaded;
    procedure Notify(Item: TCollectionItem;
      Action: TCollectionNotification); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    function Add: TActionBarItem;
    property ActionBars[const Index: Integer]: TActionBarItem
      read GetActionBar; default;
  published
    property Customizable;
    property HintShortCuts: Boolean read GetHintShortCuts
      write SetHintShortCuts default True;
    property SessionCount: Integer read FSessionCount write FSessionCount default 0;
    property ShowHints: Boolean read FShowHint write SetShowHints default True;
  end;

{ TActionClients }

  TActionClientClass = class of TActionClient;
  TCaptionOptions = (coNone, coSelective, coAll);

  TActionClients = class(TActionClientsCollection)
  private
    FCaptionOptions: TCaptionOptions;
    FSmallIcons: Boolean;
    FHideUnused: Boolean;
    function GetActionClient(const Index: Integer): TActionClientItem;
    procedure SetActionClient(const Index: Integer;
      const Value: TActionClientItem);
    procedure SetCaptionOptions(const Value: TCaptionOptions);
    procedure SetSmallIcons(const Value: Boolean);
    procedure SetHideUnused(const Value: Boolean);
  protected
    procedure DoHideUnused(AClient: TActionClient);
    procedure DoShowCaptions(AClient: TActionClient);
    procedure ToggleSmallIcons(Clients: TActionClients; Small: Boolean);
    procedure Notify(Item: TCollectionItem;
      Action: TCollectionNotification); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    function Add: TActionClientItem;
    procedure Assign(Source: TPersistent); override;
    function VisibleCount: Integer;
    property ActionClients[const Index: Integer]: TActionClientItem
      read GetActionClient write SetActionClient; default;
    property ActionManager: TCustomActionManager read GetActionManager;
  published
    property AutoHotKeys default True;
    property Customizable;
    property HideUnused: Boolean read FHideUnused write SetHideUnused default True;
    property CaptionOptions: TCaptionOptions read FCaptionOptions
      write SetCaptionOptions default coSelective;
    property SmallIcons: Boolean read FSmallIcons write SetSmallIcons default True;
  end;

{ TActionClientLink }

  TActionClientLink = class;
  TActionClientLinkClass = class of TActionClientLink;

  TActionClientLink = class(TActionLink)
  protected
    FClient: TActionClientItem;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHelpContextLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function DoShowHint(var HintStr: string): Boolean; virtual;
    procedure SetCaption(const Value: string); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHelpContext(Value: THelpContext); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
  end;

{ TActionClientItem }

  TMergeRange = 0..High(Integer);

  TActionClientItem = class(TActionClient)
  private
    FActionLink: TActionClientLink;
    FCheckUnused: Boolean;
    FControl: TCustomActionControl;
    FUsageCount: Integer;
    FShortCut: TShortCut;
    FMergeIndex: TMergeRange;
    FSeparator: Boolean;
    FShowCaption: Boolean;
    FShowShortCut: Boolean;
    FShortCutText: string;
    FImageIndex: TImageIndex;
    FLastSession: Integer;
    FUnused: Boolean;
    FShowGlyph: Boolean;
    FHelpContext: THelpContext;
    procedure DoActionChange(Sender: TObject);
    procedure SetAction(const Value: TContainedAction);
    procedure SetUsageCount(const Value: Integer);
    function GetActionClients: TActionClients;
    procedure SetShortCut(const Value: TShortCut);
    procedure SetControl(const Value: TCustomActionControl);
    procedure SetMergeIndex(const Value: TMergeRange);
    procedure SetShowShortCut(const Value: Boolean);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetCaption(const Value: string);
    procedure SetShowCaption(const Value: Boolean);
    function GetCaption: string;
    function GetAction: TContainedAction;
    procedure SetShowGlyph(const Value: Boolean);
    function IsCaptionStored: Boolean;
    function GetParentItem: TActionClient;
    procedure SetLastSession(const Value: Integer);
    function IsHelpContextStored: Boolean;
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    procedure ColorChanged; override;
    function GetActionLinkClass: TActionClientLinkClass; dynamic;
    function GetDisplayName: string; override;
    procedure ResetUsageData;
    procedure SetChangesAllowed(const Value: TChangesAllowedSet); override;
    procedure SetCollection(Value: TCollection); override;
    procedure SetIndex(Value: Integer); override;
    procedure SetVisible(const Value: Boolean); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function HasGlyph: Boolean;
    procedure InitiateAction; virtual;
    procedure Refresh; override;
    function Unused: Boolean;
    property ActionClients: TActionClients read GetActionClients;
    property ActionLink: TActionClientLink read FActionLink write FActionLink;
    property CheckUnused: Boolean read FCheckUnused write FCheckUnused;
    property Control: TCustomActionControl read FControl write SetControl;
    property ParentItem: TActionClient read GetParentItem;
    property Separator: Boolean read FSeparator;
    property ShortCutText: string read FShortCutText;
  published
    property Action: TContainedAction read GetAction write SetAction;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property HelpContext: THelpContext read FHelpContext write FHelpContext stored IsHelpContextStored default 0;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property MergeIndex: TMergeRange read FMergeIndex write SetMergeIndex default 0;
    property LastSession: Integer read FLastSession write SetLastSession default 0;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default True;
    property ShowGlyph: Boolean read FShowGlyph write SetShowGlyph default True;
    property ShowShortCut: Boolean read FShowShortCut write SetShowShortCut default True;
    property ShortCut: TShortCut read FShortCut write SetShortCut default 0;
    property UsageCount: Integer read FUsageCount write SetUsageCount default 0;
  end;

{ TActionDragBaseClass }

  TActionDragBaseClass = class(TDragObjectEx)
  private
    FActionManager: TCustomActionManager;
  public
    property ActionManager: TCustomActionManager read FActionManager
      write FActionManager;
  end;  

{ TActionDragObject }

  TCustomActionClass = class(TCustomAction);

  TActionDragObject = class(TActionDragBaseClass)
  private
    FActions: TList;
    function GetAction(Index: Integer): TContainedAction;
    function GetActionCount: Integer;
  protected
    FActionClasses: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddAction(AnAction: TContainedAction);
    procedure AddActionClass(AnActionClass: TCustomActionClass);
    property ActionCount: Integer read GetActionCount;
    property Actions[Index: Integer]: TContainedAction read GetAction;
  end;

{ TCategoryDragObject }

  TCategoryDragObject = class(TActionDragObject)
  private
    FCategory: string;
  public
    constructor Create(ACategory: string);
    property Category: string read FCategory;
  end;

{ TActionItemDragObject }

  TActionItemDragObject = class(TActionDragBaseClass)
  private
    FClientItem: TActionClientItem;
  protected
    procedure Finished(Target: TObject; X: Integer; Y: Integer;
      Accepted: Boolean); override;
  public
    property ClientItem: TActionClientItem read FClientItem write FClientItem;
  end;

{ TCustomActionBarColorMap }

  TColorMapUpdateProc = procedure(ActionBar: TCustomActionBar;
    Colors: TCustomActionBarColorMap);

  TCustomActionBarColorMap = class(TComponent)
  private
    FActionBars: TList;
    FBtnSelectedColor: TColor;
    FBtnFrameColor: TColor;
    FBtnSelectedFont: TColor;
    FColor: TColor;
    FDisabledColor: TColor;
    FDisabledFontColor: TColor;
    FDisabledFontShadow: TColor;
    FFontColor: TColor;
    FHotColor: TColor;
    FShadowColor: TColor;
    FHotFontColor: TColor;
    FUnusedColor: TColor;
    FSelectedFontColor: TColor;
    FSelectedColor: TColor;
    FHighlightColor: TColor;
    FDesignFocus: TColor;
    FMenuColor: TColor;
    FFrameTopLeftInner: TColor;
    FFrameTopLeftOuter: TColor;
    FFrameBottomRightInner: TColor;
    FFrameBottomRightOuter: TColor;
    FOnColorChange: TNotifyEvent;
    function GetDisabledColor: TColor;
    function GetUnusedColor: TColor;
  protected
    procedure Add(ActionBar: TCustomActionBar);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Remove(ActionBar: TCustomActionBar);
    procedure SetColor(const Value: TColor); virtual;
    procedure SetFontColor(const Value: TColor); virtual;
    procedure UpdateActionBars(UpdateProc: TColorMapUpdateProc; Color: TColor);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure UpdateColors; virtual;
    property BtnFrameColor: TColor read FBtnFrameColor write FBtnFrameColor;
    property BtnSelectedColor: TColor read FBtnSelectedColor write FBtnSelectedColor;
    property BtnSelectedFont: TColor read FBtnSelectedFont write FBtnSelectedFont;
    property Color: TColor read FColor write SetColor;
    property DesignFocus: TColor read FDesignFocus write FDesignFocus;
    property DisabledColor: TColor read GetDisabledColor write FDisabledColor;
    property DisabledFontColor: TColor read FDisabledFontColor write FDisabledFontColor;
    property DisabledFontShadow: TColor read FDisabledFontShadow write FDisabledFontShadow;
    property FontColor: TColor read FFontColor write SetFontColor;
    property FrameTopLeftInner: TColor read FFrameTopLeftInner write FFrameTopLeftInner;
    property FrameTopLeftOuter: TColor read FFrameTopLeftOuter write FFrameTopLeftOuter;
    property FrameBottomRightInner: TColor read FFrameBottomRightInner write FFrameBottomRightInner;
    property FrameBottomRightOuter: TColor read FFrameBottomRightOuter write FFrameBottomRightOuter;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor;
    property HotColor: TColor read FHotColor write FHotColor;
    property HotFontColor: TColor read FHotFontColor write FHotFontColor;
    property MenuColor: TColor read FMenuColor write FMenuColor;
    property SelectedColor: TColor read FSelectedColor write FSelectedColor;
    property SelectedFontColor: TColor read FSelectedFontColor write FSelectedFontColor;
    property ShadowColor: TColor read FShadowColor write FShadowColor;
    property UnusedColor: TColor read GetUnusedColor write FUnusedColor;
    property OnColorChange: TNotifyEvent read FOnColorChange write FOnColorChange;
  end;

{ TCustomActionBar }

  TCustomActionBarClass = class of TCustomActionBar;
  TBarOrientation = (boLeftToRight, boRightToLeft, boTopToBottom, boBottomToTop);
  TControlCreatedEvent = procedure(Sender: TObject;
    var Control: TCustomActionControl) of object;
  TGetControlClassEvent = procedure(Sender: TCustomActionBar; AnItem: TActionClient;
    var ControlClass: TCustomActionControlClass) of object;
  TBarEdge = (beLeft, beRight, beEither);

  TCustomActionBar = class(TToolWindow)
  private
    FActionClient: TActionClient;
    FActionManager: TCustomActionManager;
    FAllowHiding: Boolean;
    FCanvas: TCanvas;
    FColorMap: TCustomActionBarColorMap;
    FDesignable: Boolean;     
    FDesignMode: Boolean;
    FEnabledState: Boolean;
    FOrientation: TBarOrientation;
    FSpacing: Integer;
    FOnControlCreated: TControlCreatedEvent;
    FOnGetControlClass: TGetControlClassEvent;
    FOnPaint: TNotifyEvent;
    FPersistentHotKeys: Boolean;
    FHRowCount: Integer;
    FVRowCount: Integer;
    FVertMargin: Integer;
    FHorzMargin: Integer;
    FHorzSeparator: Boolean;
    FSavedSize: TPoint;
    FVertSeparator: Boolean;
    FTallest: Integer;
    FWidest: Integer;
    FContextBar: Boolean;
    procedure SetActionManager(const Value: TCustomActionManager);
    procedure SetHorzMargin(const Value: Integer);
    procedure SetHorzSeparator(const Value: Boolean);
    procedure SetVertMargin(const Value: Integer);
    procedure SetVertSeparator(const Value: Boolean);
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMResetBar(var Message: TMessage); message CM_RESETBAR;
    procedure CMWinINIChange(var Message: TMessage);
      message CM_WININICHANGE;
    function GetItems: TActionClients;
    procedure WMContextMenu(var Message: TWMContextMenu);
      message WM_CONTEXTMENU;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function GetAutoSizing: Boolean;
    function GetColorMap: TCustomActionBarColorMap;
  protected
    FDefaultColorMap: TCustomActionBarColorMap;
    FSavedWrapState: Boolean;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure AutoSizingChanged; virtual;
    function BackgroundSize: TPoint;
    procedure Clear; virtual;
    function CalcInsertPosition(Control: TCustomActionControl; X, Y: Integer): Integer;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; virtual;
    procedure CreateControls; virtual;
    function CustomAlignInsertBefore(C1: TControl; C2: TControl): Boolean; override;
    procedure CustomAlignPosition(Control: TControl; var NewLeft: Integer;
      var NewTop: Integer; var NewWidth: Integer; var NewHeight: Integer;
      var AlignRect: TRect; AlignInfo: TAlignInfo); override;
    function DesignWndProc(var Message: TMessage): Boolean; override;
    function DoGetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; dynamic;
    procedure DoControlCreated(var Control: TCustomActionControl); virtual;
    procedure DoDropCategory(Source: TCategoryDragObject; const X, Y: Integer); virtual;
    procedure DoDropActions(Source: TActionDragObject; const X, Y: Integer); virtual;
    procedure DoDropItem(Source: TActionItemDragObject; const X,Y: Integer); virtual;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    function FindLast: TActionClientItem; virtual;
    function FindAccelItem(const Accel: Word): TActionClientItem;
    function FindItemAt(const P: TPoint): TCustomActionControl;
    function FindItemCaption(const ACaption: string): TCustomActionControl;
    function FindNearestControl(const Point: TPoint): TCustomActionControl;
    function FindNextVisibleItem(AClient: TActionClientItem): TActionClientItem;
    function FindPreviousVisibleItem(AClient: TActionClientItem): TActionClientItem;
    function FindLeastUsedItem(const Visible: Boolean = True): TActionClientItem;
    function FindNext(AClient: TActionClientItem;
      const Wrap: Boolean = True): TActionClientItem; virtual;
     function FindPrevious(AClient: TActionClientItem;
      const Wrap: Boolean = True): TActionClientItem; virtual;
    function GetBannerWidth(BarEdge:  TBarEdge): Integer; virtual;
    function GetBarHeight: Integer; virtual;
    function GetBarWidth: Integer; virtual;
    function GetDesignMode: Boolean; virtual;
    function GetActionControl(const Index: Integer): TCustomActionControl; virtual;
    function GetDefaultColorMapClass: TCustomColorMapClass; virtual;
    function GetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; virtual;
    function GetPopupMenuClass: TCustomActionBarClass;
    function HasItems: Boolean;
    function ItemCount: Integer; virtual;
    procedure Loaded; override;
    procedure NCPaint(DC: HDC); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DrawBackground; virtual;
    procedure Paint; virtual;
    procedure PaintWindow(DC: HDC); override;
    procedure Reset; virtual;
    procedure SetActionClient(const Value: TActionClient); virtual;
    procedure SetAutoSizing(const Value: Boolean); virtual;
    procedure SetColorMap(const Value: TCustomActionBarColorMap); virtual;
    procedure SetDesignMode(const Value: Boolean); virtual;
    procedure SetOrientation(const Value: TBarOrientation); virtual;
    procedure SetPersistentHotKeys(const Value: Boolean); virtual;
    procedure SetSpacing(Value: Integer); virtual;
    procedure SetBiDiMode(Value: TBiDiMode); override;
    function SetupDefaultColorMap: TCustomActionBarColorMap;
    procedure VisibleChanging; override;
    property HRowCount: Integer read FHRowCount;
    property Items: TActionClients read GetItems;
    property VRowCount: Integer read FVRowCount;
    property Widest: Integer read FWidest;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    function FindFirst: TActionClientItem; virtual;
    function FindFirstVisibleItem: TActionClientItem;
    function FindLastVisibleItem: TActionClientItem;
    procedure RecreateControls; virtual;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    function Style: TActionBarStyle; virtual;
    property ActionManager: TCustomActionManager read FActionManager
      write SetActionManager;
    property ActionClient: TActionClient read FActionClient write SetActionClient;
    property AllowHiding: Boolean read FAllowHiding write FAllowHiding;
    property AutoSizing: Boolean read GetAutoSizing write SetAutoSizing;
    property Caption;
    property Canvas: TCanvas read FCanvas;
    property Color;
    property ColorMap: TCustomActionBarColorMap read GetColorMap write SetColorMap;
    property ContextBar: Boolean read FContextBar write FContextBar;
    property Designable: Boolean read FDesignable write FDesignable;
    property Font;
    property DesignMode: Boolean read GetDesignMode write SetDesignMode;
    property HorzMargin: Integer read FHorzMargin write SetHorzMargin default 1;
    property HorzSeparator: Boolean read FHorzSeparator write SetHorzSeparator;
    property Orientation: TBarOrientation read FOrientation write SetOrientation;
    property PersistentHotKeys: Boolean read FPersistentHotKeys write SetPersistentHotKeys;
    property ActionControls[const Index: Integer]: TCustomActionControl read GetActionControl;
    property Spacing: Integer read FSpacing write SetSpacing;
    property VertMargin: Integer read FVertMargin write SetVertMargin default 1;
    property VertSeparator: Boolean read FVertSeparator write SetVertSeparator;
    property OnControlCreated: TControlCreatedEvent read FOnControlCreated
      write FOnControlCreated;
    property OnGetControlClass: TGetControlClassEvent read FOnGetControlClass
      write FOnGetControlClass;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

{ TCustomActionControl }

  TCMItemMsg = record
    Msg: Cardinal;
    Unused: Integer;
    Sender: TCustomActionControl;
    Result: Longint;
  end;

  TCustomActionControl = class(TGraphicControl)
  private
    FActionBar: TCustomActionBar;
    FActionClient: TActionClientItem;
    FDropPoint: Boolean;
    FGlyphLayout: TButtonLayout;
    FGlyphPos: TPoint;
    FMargins: TRect;
    FSelected: Boolean;
    FSmallIcon: Boolean;
    FSpacing: Integer;
    FTextBounds: TRect;
    FTransparent: Boolean;
    function CaptionLength: Integer;
    function CaptionHeight: Integer;
    function ActualSpacing(ImageSize: TPoint): Integer;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    function GetActionBar: TCustomActionBar;
    procedure SetMargins(Value: TRect);
    procedure SetTransparent(const Value: Boolean);
    procedure SetSmallIcon(const Value: Boolean);
    procedure SetSpacing(const Value: Integer);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure WMContextMenu(var Message: TWMContextMenu);
      message WM_CONTEXTMENU;
  protected
    procedure BeginAutoDrag; override;
    procedure CalcLayout; virtual;
    function DesignWndProc(var Message: TMessage): Boolean; override;
    procedure DoDragDrop(DragObject: TObject; X, Y: Integer); virtual;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    function GetAction: TBasicAction; override;
    function GetShowCaption: Boolean; virtual;
    function GetShowShortCut: Boolean; virtual;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest);
      message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMItemSelected(var Message: TCMItemMsg); message CM_ITEMSELECTED;
    procedure CMItemDropPoint(var Message: TCMItemMsg); message CM_ITEMDROPPOINT;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DrawDesignFocus(var PaintRect: TRect); virtual;
    procedure DrawDragDropPoint;
    procedure DrawGlyph(const Location: TPoint); virtual;
    procedure DrawLargeGlyph(Location: TPoint); virtual;
    procedure DrawBackground(var PaintRect: TRect); virtual;
    procedure DrawText(var ARect: TRect; var Flags: Cardinal; Text: string); virtual;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: string;
      TextColor, ShadowColor: TColor); virtual;
    procedure DrawSeparator(const Offset: Integer); virtual;
    function GetImageSize: TPoint; virtual;
    function HasGlyph: Boolean;
    function IsChecked: Boolean; virtual;
    function IsGrouped: Boolean; virtual;
    function GetSeparator: Boolean; virtual;
    procedure Paint; override;
    procedure PositionChanged; virtual;
    procedure ResetUsageData;
    procedure SetActionClient(Value: TActionClientItem); virtual;
    procedure SetGlyphLayout(const Value: TButtonLayout); virtual;
    procedure SetSelected(Value: Boolean); virtual;
    procedure SetDropPoint(Value: Boolean);
    procedure UpdateSelection;
    procedure UpdateTextBounds;
    procedure WMSetText(var Message: TWMSetText); message WM_SETTEXT;
    property GlyphPos: TPoint read FGlyphPos write FGlyphPos;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CalcBounds; virtual;
    procedure Click; override;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    procedure InitiateAction; override;
    procedure Keyed; virtual;
    property ActionBar: TCustomActionBar read GetActionBar;
    property ActionClient: TActionClientItem read FActionClient write SetActionClient;
    property Caption;
    property DropPoint: Boolean read FDropPoint write SetDropPoint;
    property GlyphLayout: TButtonLayout read FGlyphLayout write SetGlyphLayout;
    property Margins: TRect read FMargins write SetMargins;
    property Selected: Boolean read FSelected write SetSelected;
    property Separator: Boolean read GetSeparator;
    property ShowCaption: Boolean read GetShowCaption;
    property ShowShortCut: Boolean read GetShowShortCut;
    property SmallIcon: Boolean read FSmallIcon write SetSmallIcon;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property TextBounds: TRect read FTextBounds write FTextBounds;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property OnClick;
  end;

{ IActionBarDesigner }

  IActionBarDesigner = interface
  ['{7CFC301B-1C59-11D4-8184-00C04F6BB89F}']
    function CreateAction(AnActionClass: TContainedActionClass): TContainedAction;
    procedure EditAction(Action: TContainedAction);
    procedure Modified(ActionBar: TCustomActionBar);
    procedure SetActiveMenu(Menu: TCustomActionBar);
    procedure SetItemSelection(const Items: array of TActionClient);
    procedure SetSelection(APersistent: TPersistent);
  end;

{ TXToolDockForm }

  TXToolDockForm = class(TToolDockForm)
  private
    procedure CMDialogChar(var Message: TMessage); message CM_DIALOGCHAR;
  end;

procedure NotifyDesigner(ActionBar: TCustomActionBar);

const
  caAllChanges = [caModify, caMove, caDelete];
  ControlDragMode: array[Boolean] of TDragMode = (dmManual, dmAutomatic);
  cDefaultSchedule: string = '0=3'#13#10'1=3'#13#10'2=6'#13#10'3=9'#13#10 +
                             '4=12'#13#10'5=12'#13#10'6=17'#13#10'7=17'#13#10 +
                             '8=17'#13#10'9=23'#13#10'10=23'#13#10'11=23'#13#10 +
                             '12=23'#13#10'13=23'#13#10'14=31'#13#10'15=31'#13#10 +
                             '16=31'#13#10'17=31'#13#10'18=31'#13#10'19=31'#13#10 +
                             '20=31'#13#10'21=31'#13#10'22=31'#13#10'23=31'#13#10 +
                             '24=31'#13#10'25=31'#13#10;
type
  TActionBarStyleList = class(TStringList)
  private
    function GetStyle(Index: Integer): TActionBarStyle;
  public
    property Style[Index: Integer]: TActionBarStyle read GetStyle;
  end;
var
  ActionBarDesigner: IActionBarDesigner = nil;
  ActionBarStyles: TActionBarStyleList;
  DefaultActnBarStyle: string;

implementation

uses Consts, Dialogs, CommCtrl, GraphUtil, Math, ActnMenus, ActnCtrls, ActnColorMaps,
  Themes;

{ TXToolDockForm }

procedure TXToolDockForm.CMDialogChar(var Message: TMessage);
begin
  { Make sure pickletters are found in the main form first }
  if Application.MainForm <> nil then
    Application.MainForm.Dispatch(Message);
  if Message.Result = 0 then inherited;
end;

procedure NotifyDesigner(ActionBar: TCustomActionBar);
begin
  if Assigned(ActionBarDesigner) and ((ActionBar = nil) or
     (Assigned(ActionBar) and ActionBar.Designable)) then
    ActionBarDesigner.Modified(ActionBar);
end;

{ TCustomActionManager }

constructor TCustomActionManager.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited Create(AOwner);
  Exclude(FComponentStyle, csInheritable);
  FActionBars := CreateActionBars;
  FPrioritySchedule := TStringList.Create;
  FPrioritySchedule.Text := cDefaultSchedule;
  for I := 0 to FPrioritySchedule.Count - 1 do
    with FPrioritySchedule do
      Objects[I] := Pointer(StrToInt(Values[Names[I]]));
end;

destructor TCustomActionManager.Destroy;
begin
  FPrioritySchedule.Free;
  FActionBars.Free;
  FDefaultActionBars.Free;
  if Assigned(FLinkedActionLists) then
    FLinkedActionLists.Free;
  inherited Destroy;
end;

function TCustomActionManager.AddAction(AnAction: TCustomAction;
  AClient: TActionClient; After: Boolean): TActionClientItem;
begin
  Result := nil;
  if (AClient = nil) or (AClient.Collection = nil) then exit;
  Result := TActionClientItem(AClient.Collection.Add);
  Result.Index := AClient.Index + Integer(After);
  Result.Action := AnAction;
end;

type
  TActionManagerClass = class(TCustomActionManager);
  TActionArray = array of TContainedAction;

function AddActions(var Actions: TActionArray;
  ActionList: TCustomActionList; ACategory: string): Integer;
var
  I: Integer;
begin
  Result := Length(Actions);
  if ActionList = nil then exit;
  SetLength(Actions, Result + ActionList.ActionCount);
  for I := 0 to ActionList.ActionCount - 1 do
    if AnsiCompareText(ActionList[I].Category, ACategory) = 0 then
    begin
      Actions[Result] := ActionList[I];
      Inc(Result);
    end;
  SetLength(Actions, Result);
end;

function TCustomActionManager.AddCategory(ACategory: string;
  AClient: TActionClient; After: Boolean): TActionClientItem;
var
  I: Integer;
  Actions: TActionArray;
begin
  Result := nil;
  if (AClient = nil) then exit;
  AddActions(Actions, Self, ACategory);
  for I := 0 to LinkedActionLists.Count - 1 do
    AddActions(Actions, LinkedActionLists[I].ActionList, ACategory);
  with AClient as TActionClient do
  begin
    Result := GetActionClientItemClass.Create(nil);
    Result.Caption := ACategory;
    Result.Collection := AClient.Collection;
    Result.Index := AClient.Index + Integer(After);
    for I := 0 to Length(Actions) - 1 do
      Result.Items.Add.Action := Actions[I];
    Result.Control.Enabled := True;
  end;
end;

function TCustomActionManager.AddSeparator(AnItem: TActionClientItem;
  After: Boolean): TActionClientItem;
begin
  Result := nil;
  if (AnItem = nil) or (AnItem.ActionClients = nil) then exit;
  Result := TActionClientItem.Create(nil);
  Result.Caption := '|';
  Result.Collection := AnItem.ParentItem.Items;
  Result.Index := AnItem.Index + Integer(After);
end;

procedure TCustomActionManager.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TCustomActionManager then
  begin
    ActionBars.Assign(TCustomActionManager(Source).ActionBars);
    FileName := TCustomActionManager(Source).FileName;
    if Assigned(Images) then
      Images.Assign(TCustomActionManager(Source).Images);
    PrioritySchedule.Assign(TCustomActionManager(Source).PrioritySchedule);
    if Assigned(TCustomActionManager(Source).FLinkedActionLists) then
      LinkedActionLists.Assign(TCustomActionManager(Source).LinkedActionLists);
  end;
end;

procedure TCustomActionManager.CompareAction(AClient: TActionClient);
begin
  if AClient is TActionClientItem then
    with AClient as TActionClientItem do
      if Action = FAction then
        FFoundClient := TActionClientItem(AClient);
end;

procedure TCustomActionManager.CompareCaption(AClient: TActionClient);
begin
  if AClient is TActionClientItem then
    with AClient as TActionClientItem do
      if AnsiCompareText(Caption, FCompareCaption) = 0 then
        FFoundClient := TActionClientItem(AClient);
end;

function TCustomActionManager.CreateActionBars: TActionBars;
begin
  Result := GetActionBarsClass.Create(Self, GetActionBarItemClass);
end;

procedure TCustomActionManager.DeleteActionItems(
  Actions: array of TCustomAction);
var
  I: Integer;
  Item: TActionClientItem;
begin
  for I := Low(Actions) to High(Actions) do
  begin
    Item := FindItemByAction(Actions[I]);
    if Assigned(Item) then
      Item.Free;
  end;
end;

procedure TCustomActionManager.DefineProperties(Filer: TFiler);

  function StyleNameStored: Boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := Style <> TCustomActionManager(Filer.Ancestor).Style else
      Result := Style <> nil;
  end;

begin
  inherited;
  Filer.DefineProperty('StyleName', ReadStyleProp, { Do not localize }
    WriteStyleProp, StyleNameStored);
end;

procedure TCustomActionManager.DeleteItem(Caption: string);
var
  Item: TActionClientItem;
begin
  FFoundClient := nil;
  FCompareCaption := Caption;
  Item := FindItemByCaption(Caption);
  if Assigned(Item) then
    Item.Free;
end;

procedure TCustomActionManager.FindClient(AClient: TActionClient);
begin
  if Assigned(AClient) and Assigned(FCompareProc) and
     Assigned(FFoundClient) then exit;  // Only find the first occurance
    FCompareProc(AClient);
end;

function TCustomActionManager.FindItem: TActionClientItem;
begin
  FFoundClient := nil;
  ActionBars.IterateClients(ActionBars, FindClient);
  Result := FFoundClient;
end;

function TCustomActionManager.FindItemByAction(
  Action: TCustomAction): TActionClientItem;
begin
  FCompareProc := CompareAction;
  FAction := Action;
  Result := FindItem;
end;

function TCustomActionManager.FindItemByCaption(
  ACaption: string): TActionClientItem;
begin
  FCompareProc := CompareCaption;
  FCompareCaption := ACaption;
  Result := FindItem;
end;

function TCustomActionManager.FindActionClient(AnAction: TContainedAction;
  Clients: TActionClientsCollection): TActionClientItem;
var
  I: Integer;
begin
  Result := nil;
  if Clients = nil then
   Clients := ActionBars;
   for I := 0 to Clients.Count - 1 do
    if Clients[I] is TActionClientItem and
       (TActionClientItem(Clients[I]).Action = AnAction) then
    begin
      Result := TActionClientItem(Clients[I]);
      break;
    end
    else
      if Clients[I].HasItems then
      begin
        Result := FindActionClient(AnAction, Clients[I].Items);
        if Assigned(Result) then
          break;
      end;
end;

function TCustomActionManager.FindActionBar(ActionBar: TCustomActionBar;
  Clients: TActionClientsCollection): TActionClient;
var
  I: Integer;
begin
  Result := nil;
  if Clients = nil then
    Clients := ActionBars;
  for I := 0 to Clients.Count - 1 do
    if Clients[I].ActionBar = ActionBar then
    begin
      Result := Clients[I];
      break;
    end
    else
      if Clients[I].HasItems then
      begin
        Result := FindActionBar(ActionBar, Clients[I].Items);
        if Assigned(Result) then
          break;
      end;
end;

procedure TCustomActionManager.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  try
    try
      LoadFromStream(S);
    except
      //  swallow exceptions here because we still want the app to start
      FreeAndNil(S);
      if MessageDlg(Format(SErrorLoadingFile, [FileName]), mtError,
         [mbYes, mbNo], 0) = mrYes then
        DeleteFile(FileName);
    end;
  finally
    FreeAndNil(S);
  end;
end;

procedure TCustomActionManager.LoadFromStream(S: TStream);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  FLoading := True;
  try
    if Assigned(FDefaultActionBars) then
      FDefaultActionBars.Free;
    FDefaultActionBars := CreateActionBars;
    FDefaultActionBars.Assign(ActionBars);
    try
      Stream.LoadFromStream(S);
      Stream.Position := 0;
      Stream.ReadComponent(Self);
      inherited Loaded;  // Reset the csLoading flag
      SetupActionBars(ActionBars);
      ActionBars.Loaded;
    except
      FActionBars.Assign(FDefaultActionBars);
      raise;
    end;
  finally
    FLoading := False;
    Stream.Free;
  end;
end;

procedure TCustomActionManager.Loaded;
var
  I: Integer;
begin
  inherited Loaded;
  if FLoading then exit;
  FDefaultActionBars := CreateActionBars;
  FDefaultActionBars.Assign(ActionBars);
  if not (csDesigning in ComponentState) and FileExists(FileName) then
    LoadFromFile(FFileName)
  else
    SetupActionBars(FActionBars);
  if not (csDesigning in ComponentState) then
    Inc(ActionBars.FSessionCount);
  for I := 0 to ActionBars.Count - 1 do
    if Assigned(ActionBars[I].ActionBar) and
       (ActionBars[I].ActionBar.ColorMap = ActionBars[I].ActionBar.FDefaultColorMap) then
      ActionBars[I].ActionBar.ColorMap := nil;
end;

procedure TCustomActionManager.LoadMenu(Clients: TActionClients; AMenu: TMenuItem);
var
  I: Integer;
begin
  for I := 0 to AMenu.Count - 1 do
    with Clients.Add do
    begin
      Caption := AMenu.Items[I].Caption;
      Action := TContainedAction(AMenu.Items[I].Action);
      if Assigned(Action) then
        Action.ActionList := Self;
      if AMenu.Items[I].Count > 0 then
        LoadMenu(Items, AMenu.Items[I]);
    end;
end;

procedure TCustomActionManager.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  Item: TActionClientItem;
  ABar: TActionClient;
  I: Integer;
  Bars: TList;
begin
  inherited Notification(AComponent, Operation);
  if Application.Terminated and (Length(FFileName) > 0) and not FSaved then
  begin
    SaveToFile(FFileName);
    FSaved := True;
  end;
  if (Operation = opRemove) and not (csDestroying in ComponentState) then
    if (AComponent is TContainedAction) then
    begin
      Item := FindActionClient(TContainedAction(AComponent));
      Bars := TList.Create;
      try
        while Item <> nil do
        begin
          if Assigned(Item.ActionClients.ParentItem.ActionBar) then
          begin
            Item.ActionClients.ParentItem.ActionBar.DisableAlign;
            Bars.Add(Item.ActionClients.ParentItem.ActionBar);
          end;
          Item.ActionClients.Delete(Item.Index);
          Item := FindActionClient(TContainedAction(AComponent));
        end;
      finally
        for I := 0 to Bars.Count - 1 do
          if Assigned(Bars[I]) then
            TCustomActionBar(Bars[I]).EnableAlign;
        Bars.Free;
      end;
    end
    else if (AComponent is TCustomActionBar) then
    begin
      ABar := FindActionBar(TCustomActionBar(AComponent), ActionBars);
      if Assigned(ABar) then
        ABar.FActionBar := nil;
      ABar := FindActionBar(TCustomActionBar(AComponent), DefaultActionBars);
      if Assigned(ABar) then
        ABar.FActionBar := nil;
    end
    else if (AComponent is TCustomActionList) and Assigned(FLinkedActionLists) then
      for I := FLinkedActionLists.Count - 1 downto 0 do
        if FLinkedActionLists[I].ActionList = AComponent then
        begin
          FLinkedActionLists.Delete(I);
          break;
        end;
end;

procedure TCustomActionManager.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  State := asNormal;
  try
    S := TFileStream.Create(ExpandFileName(Filename), fmCreate);
    try
      try
        SaveToStream(S);
      except
        //  catch all exceptions because we still want the app to shutdown
      end;
    finally
      S.Free;
    end;
  except
    ShowMessage(SUnableToSaveSettings);
  end;
end;

procedure TCustomActionManager.SaveToStream(S: TStream);
var
  BinaryStream: TMemoryStream;
begin
  BinaryStream := TMemoryStream.Create;
  try
    BinaryStream.WriteComponent(Self);
    BinaryStream.Position := 0;
    S.CopyFrom(BinaryStream, BinaryStream.Size);
  finally
    BinaryStream.Free;
  end;
end;

procedure TCustomActionManager.SetupActionBars(ActionBars: TActionClientsCollection);
var
  I: Integer;
begin
  if ActionBars.Count = 0 then exit;
  for I := 0 to ActionBars.Count - 1 do
    if Assigned(ActionBars[I].ActionBar) then
    begin
      ActionBars.InternalRethinkHotkeys(True);
      ActionBars[I].ActionBar.ActionClient := ActionBars[I];
      ActionBars[I].ActionBar.Resize;
      ActionBars[I].ActionBar.RequestAlign;
      ActionBars[I].ActionBar.Visible := ActionBars[I].Visible;
    end;
end;

procedure TCustomActionManager.SetActionBars(const Value: TActionBars);
begin
  FActionBars.Assign(Value);
end;

procedure TCustomActionManager.SetImages(Value: TCustomImageList);
var
  I, X: Integer;
  Update: Boolean;
begin
  Update := (Value <> Images) and not (csDestroying in ComponentState);
  inherited SetImages(Value);
  if not Update then exit;
  for I := 0 to ActionBars.Count - 1 do
    for X := 0 to ActionBars[I].Items.Count - 1 do
      if Assigned(ActionBars[I].Items[X].Control) then
        ActionBars[I].Items[X].Control.CalcBounds;
end;

function PrioritySort(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := AnsiCompareText(List.Names[Index1], List.Names[Index2]);
end;

procedure TCustomActionManager.SetPrioritySchedule(const Value: TStringList);
var
  I: Integer;
begin
  if Length(Trim(FPrioritySchedule.Text)) = 0 then
  begin
    if MessageDlg(SRestoreDefaultSchedule, mtConfirmation, mbOKCancel, 0) = mrOk then
      FPrioritySchedule.Text := cDefaultSchedule
    else
      FPrioritySchedule.Clear;
  end
  else
  begin
    StrToInt(Value.Names[0]);
    StrToInt(Value.Values[Value.Names[0]]);
    FPrioritySchedule.Assign(Value);
  end;
  FPrioritySchedule.CustomSort(PrioritySort);
  for I := 0 to FPrioritySchedule.Count - 1 do
    with FPrioritySchedule do
      Objects[I] := Pointer(StrToInt(Values[Names[I]]));
end;

function TCustomActionManager.GetUsage(AnItem: TActionClientItem): Boolean;
var
  NumSessions: Integer;
  I: Integer;
begin
  // Returns True if AnItem is recently used
  Result := (AnItem.UsageCount = -1) or (PrioritySchedule.Count = 0);
  if Result then exit;
  NumSessions := ActionBars.SessionCount - AnItem.LastSession;
  I := 0;
  while (I < PrioritySchedule.Count) and
     (AnItem.UsageCount > I) do
    Inc(I);
  if I = PrioritySchedule.Count then
    Dec(I);
  Result := NumSessions < Integer(PrioritySchedule.Objects[I]);
end;

function TCustomActionManager.IsPriorityScheduleStored: Boolean;
begin
  Result := AnsiCompareText(cDefaultSchedule, FPrioritySchedule.Text) <> 0;
end;

procedure TCustomActionManager.ResetActionBar(Index: Integer);
var
  ABar: TCustomActionBar;
begin
  if Assigned(FDefaultActionBars) then
  begin
    ABar := FActionBars[Index].ActionBar;
    FActionBars[Index].ActionBar := nil;
    FActionBars.Items[Index].Assign(FDefaultActionBars.Items[Index]);
    FActionBars[Index].ActionBar := ABar;
  end;
end;

procedure TCustomActionManager.ResetClientUsageData(
  AClient: TActionClient);
begin
  if AClient is TActionClientItem then
    with AClient as TActionClientItem do
    begin
      UsageCount := 0;
      LastSession := ActionBars.SessionCount;
    end;
end;

procedure TCustomActionManager.ResetUsageData;
begin
  ActionBars.IterateClients(ActionBars, ResetClientUsageData);
end;

procedure TCustomActionManager.SetLinkedActionLists(
  const Value: TActionListCollection);
begin
  if not Assigned(FLinkedActionLists) then
    FLinkedActionLists := TActionListCollection.Create(Self, TActionListItem);
  FLinkedActionLists.Assign(Value);
end;

procedure TCustomActionManager.Change;
begin
  inherited Change;
  if Assigned(ActionBars) then
    ActionBars.IterateClients(ActionBars, nil);
end;

function TCustomActionManager.GetActionClientsClass: TActionClientsClass;
begin
  Result := TActionClients;
  if Assigned(FOnGetClientsClass) then
    FOnGetClientsClass(Self, Result);
  if Result = nil then
    Result := TActionClients;
end;

function TCustomActionManager.GetActionClientItemClass: TActionClientItemClass;
begin
  Result := TActionClientItem;
  if Assigned(FOnGetClientItemClass) then
    FOnGetClientItemClass(Self, Result);
  if Result = nil then
    Result := TActionClientItem;
end;

function TCustomActionManager.GetActionBarsClass: TActionBarsClass;
begin
  Result := TActionBars;
  if Assigned(FOnGetBarsClass) then
    FOnGetBarsClass(Self, Result);
  if Result = nil then
    Result := TActionBars;
end;

function TCustomActionManager.GetActionBarItemClass: TActionBarItemClass;
begin
  Result := TActionBarItem;
  if Assigned(FOnGetBarItemClass) then
    FOnGetBarItemClass(Self, Result);
  if Result = nil then
    Result := TActionBarItem;
end;

function TCustomActionManager.IsLinkedActionListsStored: Boolean;
begin
  Result := Assigned(FLinkedActionLists) and (LinkedActionLists.Count > 0);
end;

function TCustomActionManager.IsActionBarsStored: Boolean;
begin
  Result := ActionBars.Count > 0;
end;

function TCustomActionManager.GetLinkedActionLists: TActionListCollection;
begin
  if not Assigned(FLinkedActionLists) then
    FLinkedActionLists := TActionListCollection.Create(Self, TActionListItem);
  Result := FLinkedActionLists;
end;

procedure TCustomActionManager.ReadStyleProp(Reader: TReader);
var
  StyleName: string;
begin
  StyleName := Reader.ReadString;
  if StyleName <> '' then
  try
    Style := ActionBarStyles.Style[ActionBarStyles.IndexOf(StyleName)];
  except
    if csDesigning in ComponentState then
      if Assigned(Classes.ApplicationHandleException) then
        Classes.ApplicationHandleException(ExceptObject)
      else
        ShowException(ExceptObject, ExceptAddr)
    else
      raise;
  end;
end;

procedure TCustomActionManager.WriteStyleProp(Writer: TWriter);
var
  AStyle: TActionBarStyle;
begin
  if Assigned(Style) then
    AStyle := Style
  else
    AStyle := ActionBarStyles.Style[0];
  Writer.WriteString(AStyle.GetStyleName);
end;

function TCustomActionManager.HasLinkedActionLists: Boolean;
begin
  Result := Assigned(FLinkedActionLists);
end;

procedure TCustomActionManager.AfterConstruction;
begin
  inherited;
  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    FStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf(DefaultActnBarStyle)];
end;

procedure TCustomActionManager.SetStyle(const Value: TActionBarStyle);
var
  I: Integer;
begin
  if Style <> Value then
  begin
    FStyle := Value;
    for I := 0 to ActionBars.Count - 1 do
      if Assigned(ActionBars[I].ActionBar) then
      begin
        ActionBars[I].ActionBar.RecreateControls;
        if ActionBars[I].ActionBar.ColorMap = ActionBars[I].ActionBar.FDefaultColorMap then
          ActionBars[I].ActionBar.ColorMap := nil;
        ActionBars[I].ActionBar.Invalidate;
      end;
    if Assigned(FOnStyleChanged) then
      FOnStyleChanged(Self);
    if csDesigning in ComponentState then
      NotifyDesigner(nil);
  end;
end;

procedure TCustomActionManager.SetState(const Value: TActionListState);
var
  LItem: TCollectionItem;
begin
  inherited SetState(Value);
  if Assigned(FLinkedActionLists) then
    for LItem in FLinkedActionLists do
      TActionListItem(LItem).ActionList.State := Value;
end;

{ TActionListItem }

procedure TActionListItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TActionListItem then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      ActionList := TActionListItem(Source).ActionList;
      Caption := TActionListItem(Source).Caption;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end;
end;

function TActionListItem.GetCaption: string;
begin
  Result := FCaption;
  if (Length(Result) = 0) then
    if Assigned(FActionList) then
      Result := FActionList.Name
    else
      Result := SNoName;
end;

function TActionListItem.GetDisplayName: string;
begin
  if Assigned(FActionList) then
    Result := Caption
  else
    Result := inherited GetDisplayName;
end;

function TActionListItem.Owner: TActionListCollection;
begin
  Result := TActionListCollection(Collection);
end;

procedure TActionListItem.SetActionList(
  const Value: TCustomActionList);
begin
  if Value = Owner.ActionManager then
    raise Exception.Create(SCirularReferencesNotAllowed);
  if (FActionList <> Value) then
  begin
    FActionList := Value;
    FActionList.FreeNotification(Owner.ActionManager);
  end;
end;

{ TActionListCollection }

function TActionListCollection.GetActionManager: TCustomActionManager;
begin
  Result := TCustomActionManager(Owner);
end;

function TActionListCollection.GetListItem(
  Index: Integer): TActionListItem;
begin
  Result := TActionListItem(Items[Index]);
end;

procedure TActionListCollection.SetListItem(Index: Integer;
  const Value: TActionListItem);
begin
  TActionListItem(ListItems[Index]).Assign(Value);
end;

{ TActionClientsCollection }

procedure TActionClientsCollection.SetActionClient(const Index: Integer;
  const Value: TActionClient);
begin
  inherited SetItem(Index, Value);
end;

function TActionClientsCollection.GetActionClient(
  const Index: Integer): TActionClient;
begin
  Result := TActionClient(Items[Index]);
end;

function TActionClientsCollection.GetActionManager: TCustomActionManager;
begin
  Result := Owner as TActionManager;
end;

function TActionClientsCollection.InternalRethinkHotkeys(
  ForceRethink: Boolean): Boolean;
var
  Did, Doing, ToDo, Best: TStringList;
  I, Iteration, Column, At, BestCount: Integer;
  Char, Caption, OrigAvailable, Available, BestAvailable: string;

  function IfHotkeyAvailable(const AHotkey: string): Boolean;
  var
    At: Integer;
  begin
    At := AnsiPos(AHotkey, Available);
    Result := At <> 0;
    if Result then
      System.Delete(Available, At, 1);
  end;

  procedure CopyToBest;
  var
    I: Integer;
  begin
    Best.Assign(Did);
    BestCount := Did.Count;
    for I := 0 to Doing.Count - 1 do
      Best.AddObject(TActionClient(Doing.Objects[I]).FCaption, Doing.Objects[I]);
    BestAvailable := Available;
  end;

  procedure InsertHotkeyFarEastFormat(var ACaption: string; const AHotKey: string; AColumn: Integer);
  var
    I: Integer;
    vMBCSFlag: Boolean;
  begin
    vMBCSFlag := False;
    for I := 1 to Length(ACaption) do
      if ACaption[I] in LeadBytes then
      begin
        vMBCSFlag := True;
        System.Break;
      end;
    if vMBCSFlag then
    begin
      if Copy(ACaption, (Length(ACaption) - Length(cDialogSuffix)) + 1, Length(cDialogSuffix)) = cDialogSuffix then
        ACaption := Copy(ACaption, 1, Length(ACaption) - Length(cDialogSuffix)) +
          '(' + cHotkeyPrefix + AHotKey + ')' + cDialogSuffix
      else
        ACaption := ACaption + '(' + cHotkeyPrefix + AHotKey + ')';
    end
    else if AColumn <> 0 then
      System.Insert(cHotkeyPrefix, ACaption, AColumn);
  end;

begin
  Result := False;
  if not AutoHotKeys then exit;
  if ForceRethink then
  begin
    Available := ValidMenuHotkeys;
    Did := TStringList.Create;
    Doing := TStringList.Create;
    ToDo := TStringList.Create;
    Best := TStringList.Create;
    BestCount := 0;
    try
      for I := 0 to Count - 1 do
        if ActionClients[I].Visible and
           (ActionClients[I].FCaption <> cLineCaption) and
           (ActionClients[I].FCaption <> '') then
        begin
          Char := Uppercase(GetHotkey(ActionClients[I].FCaption));
          if Char = '' then
            ToDo.InsertObject(0, ActionClients[I].FCaption, Items[I])
          else if (AnsiPos(Char, ValidMenuHotkeys) <> 0) and
                  not IfHotkeyAvailable(Char) then
          begin
            ActionClients[I].FCaption := StripHotkey(ActionClients[I].FCaption);
            ToDo.InsertObject(0, ActionClients[I].FCaption, Items[I]);
          end;
        end;
      OrigAvailable := Available;
      for Iteration := 0 to ToDo.Count - 1 do
      begin
        Available := OrigAvailable;
        Doing.Assign(ToDo);
        Did.Clear;
        for I := Doing.Count - 1 downto 0 do
        begin
          Caption := Doing[I];
          Column := 1;
          while Column <= Length(Caption) do
          begin
            if Caption[Column] in LeadBytes then
              Inc(Column)
            else
            begin
              Char := Uppercase(Copy(Caption, Column, 1));
              if IfHotkeyAvailable(Char) then
              begin
                if SysLocale.FarEast then
                  InsertHotkeyFarEastFormat(Caption, Char, Column)
                else
                  System.Insert(cHotkeyPrefix, Caption, Column);
                Did.AddObject(Caption, Doing.Objects[I]);
                Doing.Delete(I);
                System.Break;
              end;
            end;
            Inc(Column);
          end;
        end;
        if Did.Count > BestCount then
          CopyToBest;
        if Doing.Count > 0 then
          for I := 0 to Doing.Count - 1 do
          begin
            At := ToDo.IndexOfObject(Doing.Objects[I]);
            ToDo.Move(At, ToDo.Count - 1);
          end
        else
          System.Break;
      end;
      if BestCount = 0 then
        CopyToBest;
      Result := Best.Count > 0;
      for I := 0 to Best.Count - 1 do
      begin
        Caption := Best[I];
        if SysLocale.FarEast and (AnsiPos(cHotkeyPrefix, Caption) = 0)
          and (BestAvailable <> '') then
        begin
          if AnsiPos(cHotkeyPrefix, Caption) = 0 then
          begin
            InsertHotkeyFarEastFormat(Caption, Copy(BestAvailable, Length(BestAvailable), 1), 0);
            System.Delete(BestAvailable, length(BestAvailable), 1);
          end;
        end;
        TActionClient(Best.Objects[I]).FCaption := Caption;
      end;
    finally
      Best.Free;
      ToDo.Free;
      Doing.Free;
      Did.Free;
    end;
  end;
  for I := 0 to Count - 1 do
    if Assigned(ActionClients[I].FItems) and ActionClients[I].FItems.AutoHotKeys then
      ActionClients[I].FItems.InternalRethinkHotkeys(True);
end;

procedure TActionClientsCollection.AfterConstruction;
begin
  inherited AfterConstruction;
  FCustomizable := True;
end;

procedure TActionClientsCollection.IterateClients(Clients: TActionClientsCollection;
  ActionProc: TActionProc);

  procedure UpdateActionBar(Client: TActionClient);
  begin
    if Client.Items.Count = 0 then exit;
    with Client.Items do
      if Assigned(ParentItem) and Assigned(ParentItem.ActionBar) then
        ParentItem.ActionBar.Resize;
  end;

var
  I: Integer;
begin
  if Clients = nil then exit;
  for I := 0 to Clients.Count - 1 do
    if Clients[I].HasItems then
    begin
      if Assigned(ActionProc) then
        ActionProc(Clients[I])
      else
        Clients[I].Refresh;
      IterateClients(Clients[I].Items, ActionProc);
      UpdateActionBar(Clients[I]);
    end
    else
      if Assigned(Clients[I].ActionBar) then
      begin
        if Assigned(ActionProc) then
          ActionProc(Clients[I])
        else
          Clients[I].Refresh;
        UpdateActionBar(Clients[I]);
      end
      else
      begin
        if Assigned(ActionProc) then
          ActionProc(Clients[I])
        else
          Clients[I].Refresh;
        UpdateActionBar(Clients[I]);
      end;
end;

procedure TActionClientsCollection.SetAutoHotKeys(const Value: Boolean);
begin
  if FAutoHotKeys <> Value then
  begin
    FAutoHotKeys := Value;
    InternalRethinkHotkeys(True);
  end;
end;

{ TActionClient }

constructor TActionClient.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTag := 0;
  FBackgroundLayout := blNormal;
  FVisible := True;
  FSmallIcons := True;
  FColor := clDefault;
  FBackgroundLayout := blNormal;
  FChangesAllowed := caAllChanges;
end;

destructor TActionClient.Destroy;
begin
  FreeAndNil(FContextItems);
  if Assigned(FActionBar) and not (csDestroying in FActionBar.ComponentState) then
    FActionBar.ActionClient := nil;
  ClearActionBar;
  if Assigned(FBackground) then
    FreeAndNil(FBackground);
  FreeChildren;
  inherited Destroy;
end;

function TActionClient.AreContextItemsStored: Boolean;
begin
  Result := Assigned(FContextItems) and ((FContextItems.Count > 0) or
    not FContextItems.AutoHotKeys or (FContextItems.CaptionOptions <> coSelective) or
    not FContextItems.Customizable or not FContextItems.HideUnused or
    not FContextItems.SmallIcons);
end;

procedure TActionClient.Assign(Source: TPersistent);
begin
  if Source is TActionClient then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      Color := TActionClient(Source).Color;
      if Assigned(TActionClient(Source).FContextItems) then
        ContextItems.Assign(TActionClient(Source).FContextItems);
      if TActionClient(Source).HasBackground then
        Background.Assign(TActionClient(Source).Background);
      BackgroundLayout := TActionClient(Source).BackgroundLayout;
      Visible := TActionClient(Source).Visible;
      if Assigned(TActionClient(Source).FItems) then
        Items.Assign(TActionClient(Source).FItems);
      ActionBar := TActionClient(Source).ActionBar;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TActionClient.ClearActionBar;
begin
  FActionBar := nil;
end;

procedure TActionClient.ColorChanged;
begin
end;

procedure TActionClient.FreeChildren;
var
  I: Integer;
begin
  if FItems = nil then exit;
  if FItems.Count > 0 then
    for I := 0 to FItems.Count - 1 do
      if FItems.ActionClients[I].FItems <> nil then
        FItems.ActionClients[I].FreeChildren;
  FItems.Free;
  FItems := nil;
end;

function TActionClient.GetBackground: TPicture;
begin
  if FBackground = nil then
    FBackground := TPicture.Create;
  Result := FBackground;
end;

function TActionClient.GetContextItems: TActionClients;
begin
  if FContextItems = nil then
    FContextItems := TActionClients.Create(Self.OwningCollection.ActionManager,
      TActionClientItem);
  Result := FContextItems;
end;

function TActionClient.GetHasItems: Boolean;
begin
  Result := Assigned(FItems) and (FItems.Count > 0);
end;

function TActionClientItem.GetParentItem: TActionClient;
begin
  if Assigned(ActionClients) then
    Result := ActionClients.ParentItem
  else
    Result := nil;
end;

function TActionClient.GetItems: TActionClients;
begin
  if FItems = nil then
  begin
    if Assigned(OwningCollection) and Assigned(OwningCollection.ActionManager) then
      with OwningCollection.ActionManager do
        FItems := GetActionClientsClass.Create(OwningCollection.ActionManager,
          GetActionClientItemClass)
    else
      FItems := TActionClients.Create(OwningCollection.ActionManager,
        TActionClientItem);
    FItems.FParentItem := Self;
  end;
  Result := FItems;
end;

function TActionClient.GetOwningCollection: TActionClientsCollection;
begin
  Result := TActionClientsCollection(Collection);
end;

function TActionClient.HasBackground: Boolean;
begin
  Result := Assigned(FBackground) and Assigned(FBackground.Graphic) and
    not FBackground.Graphic.Empty;
end;

function TActionClient.HasVisibleItems: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Items.Count - 1 do
    if not Items[I].Unused and Items[I].Visible then
      Result := True
    else
      if Items[I].HasVisibleItems then
        Result := True;
end;

function TActionClient.IsBackgroundStored: Boolean;
begin
  Result := Assigned(FBackground) and Assigned(FBackground.Graphic) and
    not FBackground.Graphic.Empty;
end;

function TActionClient.IsChildItem(AClient: TActionClient): Boolean;
var
  AC: TActionClient;
begin
  Result := False;
  if not Assigned(AClient) or Assigned(AClient) and (AClient.Items = Collection) then
  begin
    Result := True;
    exit;
  end;
  AC := OwningCollection.ParentItem;
  while AC <> nil do
    if AC.Collection = AClient.Items then
    begin
      Result := True;
      exit;
    end
    else
      AC := AC.OwningCollection.ParentItem;
end;

function TActionClient.IsItemsStored: Boolean;
begin
  Result := Assigned(FItems) and ((FItems.Count > 0) or not FItems.AutoHotKeys or
    (FItems.CaptionOptions <> coSelective) or not FItems.Customizable or
    not FItems.HideUnused or not FItems.SmallIcons);
end;

procedure TActionClient.Refresh;
begin
end;

procedure TActionClient.SetActionBar(const Value: TCustomActionBar);
var
  ParentCollection: TActionClientsCollection;
begin
  if FActionBar <> Value then
  begin
    // Check to ensure no parent of this actionbar is already connected to a client
    ParentCollection := OwningCollection;
    while Assigned(ParentCollection) do
      if Assigned(ParentCollection.FParentItem) then
      begin
        if Assigned(ParentCollection.FParentItem.ActionBar) then
          raise Exception.Create(SAssignSubItemError)
        else
          ParentCollection := ParentCollection.FParentItem.OwningCollection
      end
      else
        ParentCollection := nil;
    if Assigned(FActionBar) and Assigned(FActionBar.ActionClient) then
      FActionBar.Clear;
    if Assigned(Value) and
       not (csLoading in OwningCollection.ActionManager.ComponentState) and
       not OwningCollection.ActionManager.Loading then
      Value.ActionClient := Self;
    FActionBar := Value;
  end;
end;

procedure TActionClient.SetItems(const Value: TActionClients);
begin
  if Value = nil then
    FreeAndNil(FItems)
  else
    FItems.Assign(Value);
end;

procedure TActionClient.SetBackground(const Value: TPicture);
var
  I: Integer;
begin
  FBackground.Assign(Value);
  if Assigned(Value) and HasItems then
    if Assigned(ActionBar) then
    begin
      for I := 0 to ActionBar.Items.Count - 1 do
        ActionBar.Items[I].Control.Transparent := not (FBackgroundLayout in
          [blLeftBanner, blRightBanner]);
      ActionBar.Realign;
      ActionBar.Invalidate;
    end;
end;

procedure TActionClient.SetBackgroundLayout(const Value: TBackgroundLayout);
var
  I: Integer;
begin
  if FBackgroundLayout <> Value then
  begin
    FBackgroundLayout := Value;
    if HasBackground and HasItems then
      for I := 0 to Items.Count - 1 do
        if Assigned(Items.ActionClients[I].Control) then
          Items.ActionClients[I].Control.Transparent :=
            not (Value in [blLeftBanner, blRightBanner]);
    if Assigned(ActionBar) then
    begin
      ActionBar.RequestAlign;
      ActionBar.Invalidate;
    end;
  end;
end;

procedure TActionClient.SetChangesAllowed(const Value: TChangesAllowedSet);
begin
  if FChangesAllowed <> Value then
    FChangesAllowed := Value;
end;

procedure TActionClient.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    ColorChanged;
  end;
end;

procedure TActionClient.SetContextItems(const Value: TActionClients);
begin
  FContextItems := Value;
end;

procedure TActionClient.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    NotifyDesigner(nil);
  end;
end;

{ TActionBarItem }

procedure TActionBarItem.ColorChanged;
begin
  if Assigned(FActionBar) then
    if Color = clDefault then
      FActionBar.ParentColor := True
    else
      FActionBar.Color := Color;
end;

constructor TActionBarItem.Create(Collection: TCollection);
begin
  inherited;
  FAutoSize := True;
end;

function TActionBarItem.GetActionBars: TActionBars;
begin
  Result := TActionBars(Collection);
end;

function TActionBarItem.GetDisplayName: string;
begin
  if Assigned(ActionBar) then
    Result := 'ActionBar ->' + ActionBar.Name
  else
    Result := inherited GetDisplayName;
end;

procedure TActionBarItem.Refresh;
begin
  if Assigned(ActionBar) and not (csLoading in ActionBar.ComponentState) then
    ActionBar.RequestAlign;
end;

procedure TActionBarItem.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if Assigned(FActionBar) then
      FActionBar.AutoSizingChanged;
  end;
end;

procedure TActionBarItem.SetGlyphLayout(const Value: TButtonLayout);
var
  I: Integer;
begin
  if FGlyphLayout <> Value then
  begin
    FGlyphLayout := Value;
    if Assigned(ActionBar) then
    begin
      ActionBar.DisableAlign;
      try
        for I := 0 to Items.Count - 1 do
          if Assigned(Items[I].Control) then
            Items[I].Control.GlyphLayout := Value;
      finally
        ActionBar.EnableAlign;
        ActionBar.Resize;
      end;
    end
    else
      for I := 0 to Items.Count - 1 do
        if Assigned(Items[I].Control) then
          Items[I].Control.GlyphLayout := Value;
  end;
end;

procedure TActionBarItem.SetVisible(const Value: Boolean);
begin
  inherited SetVisible(Value);
  if Assigned(FActionBar) then
    FActionBar.Visible := Visible;
end;

{ TActionBars }

constructor TActionBars.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
  FSessionCount := 0;
  ShowHints := True;
  HintShortCuts := True;
end;

function TActionBars.Add: TActionBarItem;
begin
  Result := TActionBarItem(inherited Add);
end;

procedure TActionBars.DoShowHint(AClient: TActionClient);
begin
  if (AClient is TActionBarItem) and Assigned(TActionBarItem(AClient).ActionBar) then
    with AClient as TActionBarItem do
      ActionBar.ShowHint := FShowHint;
end;

function TActionBars.GetActionBar(const Index: Integer): TActionBarItem;
begin
  Result := TActionBarItem(Items[Index]);
end;

function TActionBars.GetHintShortCuts: Boolean;
begin
  Result := False;
  if Assigned(Application) then
    Result := Application.HintShortCuts;
end;

procedure TActionBars.Loaded;
var
  I: Integer;
begin
  // Adjust width of TCustomActionDockBar descendents after loading
  for I := 0 to Count - 1 do
    if ActionBars[I].ActionBar is TCustomActionDockBar then
      with TCustomActionDockBar(ActionBars[I].ActionBar) do
        SetBounds(Left, Top, CalcDockedWidth, Height);
end;

procedure TActionBars.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited Notify(Item, Action);
  if (Action = cnDeleting) and (Item is TActionBarItem) then
    with Item as TActionBarItem do
      if Assigned(FActionBar) then
        FActionBar.FActionClient := nil;
end;

procedure TActionBars.SetShowHints(const Value: Boolean);
begin
  if Value <> FShowHint then
  begin
    FShowHint := Value;
    IterateClients(Self, DoShowHint);
  end;
end;

procedure TActionBars.SetHintShortCuts(const Value: Boolean);
begin
  if Assigned(Application) then
    Application.HintShortCuts := Value;
end;

{ TActionClients }

constructor TActionClients.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
  FCaptionOptions := coSelective;
  FSmallIcons := True;
  FHideUnused := True;
  FAutoHotKeys := True;
end;

function TActionClients.Add: TActionClientItem;
begin
  Result := TActionClientItem(inherited Add);
end;

procedure TActionClients.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TActionClients then
  begin
    AutoHotKeys := TActionClients(Source).AutoHotKeys;
    Customizable := TActionClients(Source).Customizable;
    HideUnused := TActionClients(Source).HideUnused;
    CaptionOptions := TActionClients(Source).CaptionOptions;
    SmallIcons := TActionClients(Source).SmallIcons;
  end;
end;

procedure TActionClients.DoHideUnused(AClient: TActionClient);
begin
  if not (AClient is TActionClientItem) then exit;
  with AClient as TActionClientItem do
  begin
    FCheckUnused := True;
    if Assigned(FItems) then
      Items.HideUnused := FHideUnused;
  end;
end;

procedure TActionClients.DoShowCaptions(AClient: TActionClient);
begin
  if not (AClient is TActionClientItem) then exit;
    with AClient as TActionClientItem do
      if Assigned(Control) then
        Control.CalcBounds;
end;

function TActionClients.GetActionClient(const Index: Integer): TActionClientItem;
begin
  Result := TActionClientItem(Items[Index]);
end;

procedure TActionClients.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
var
  ActnBar: TCustomActionBar;
begin
  inherited Notify(Item, Action);
  case Action of
    cnAdded:
      with Item as TActionClient do
        if Assigned(Self.ParentItem) then
        begin
          if Assigned(Self.ParentItem) then
            Self.ParentItem.OwningCollection.InternalRethinkHotkeys(True);
          ActnBar := nil;
          if Assigned(Self.ParentItem.ActionBar) then
            ActnBar := Self.ParentItem.ActionBar
          else
            if Assigned(Self.ParentItem.ChildActionBar) then
              ActnBar := Self.ParentItem.ChildActionBar;
          if (Self.UpdateCount = 0) and Assigned(ActnBar) and ActnBar.HandleAllocated then
            ActnBar.CreateControl(TActionClientItem(Item));
        end;
    cnExtracting:
      if Item is TActionClientItem then
        with Item as TActionClientItem do
          if Assigned(ParentItem) and Assigned(ParentItem.ChildActionBar) and
             ParentItem.ChildActionBar.HandleAllocated then
            PostMessage(ParentItem.ChildActionBar.Handle, WM_SIZE, 0 ,0);
    cnDeleting:
      begin
        TActionClient(Item).FreeChildren;
        if Item is TActionClientItem then
          with Item as TActionClientItem do
            if Assigned(ParentItem) and Assigned(ParentItem.ChildActionBar) and
               ParentItem.ChildActionBar.HandleAllocated then
              PostMessage(ParentItem.ChildActionBar.Handle, WM_SIZE, 0 ,0);
      end;
  end;
end;

procedure TActionClients.SetActionClient(const Index: Integer;
  const Value: TActionClientItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TActionClients.SetCaptionOptions(const Value: TCaptionOptions);
begin
  if FCaptionOptions <> Value then
  begin
    FCaptionOptions := Value;
    if Assigned(ParentItem) and Assigned(ParentItem.ActionBar) then
    begin
      ParentItem.ActionBar.DisableAlign;
      try
        IterateClients(Self, DoShowCaptions);
      finally
        ParentItem.ActionBar.EnableAlign;
      end;
    end
    else
      IterateClients(Self, DoShowCaptions);
  end;
end;

procedure TActionClients.SetHideUnused(const Value: Boolean);
begin
  if FHideUnused <> Value then
  begin
    FHideUnused := Value;
    if not (csLoading in ActionManager.ComponentState) then
      IterateClients(Self, DoHideUnused);
  end;
end;

procedure TActionClients.SetSmallIcons(const Value: Boolean);
begin
  if FSmallIcons <> Value then
  begin
    FSmallIcons := Value;
    if Assigned(FParentItem) and Assigned(FParentItem.ActionBar) then
    begin
      FParentItem.ActionBar.DisableAlign;
      try
        ToggleSmallIcons(Self, Value);
        FParentItem.ActionBar.RequestAlign;
      finally
        FParentItem.ActionBar.EnableAlign;
      end;
    end
    else
      ToggleSmallIcons(Self, Value);
  end;
end;

procedure TActionClients.ToggleSmallIcons(Clients: TActionClients;
  Small: Boolean);
var
  I: Integer;
begin
  if Clients = nil then exit;
  for I := 0 to Clients.Count - 1 do
  begin
    if Assigned(Clients[I].Control) then
      Clients[I].Control.SmallIcon := Small;
    if Clients[I].HasItems then
    begin
      Clients[I].Items.SmallIcons := Small;
      ToggleSmallIcons(Clients[I].Items, Small);
    end;
  end;
end;

function TActionClients.VisibleCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if ActionClients[I].Visible then
      Inc(Result);
end;

{ TActionClientLink }

procedure TActionClientLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TActionClientItem;
end;

function TActionClientLink.DoShowHint(var HintStr: string): Boolean;
begin
  Result := True;
  if Action is TCustomAction and TCustomAction(Action).DoHint(HintStr) and
     Application.HintShortCuts and (TCustomAction(Action).ShortCut <> scNone) then
    if HintStr <> '' then
      HintStr := Format('%s (%s)', [HintStr,
        ShortCutToText(TCustomAction(Action).ShortCut)]);
end;

function TActionClientLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
  if not Result and TActionClients(FClient.Collection).AutoHotKeys then
    Result := StripHotKey(FClient.Caption) = (Action as TCustomAction).Caption;
end;

function TActionClientLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and Assigned(FClient.FControl) and
    (FClient.FControl.Enabled = (Action as TCustomAction).Enabled);
end;

function TActionClientLink.IsHelpContextLinked: Boolean;
begin
  Result := inherited IsHelpContextLinked and
    (FClient.HelpContext = (Action as TCustomAction).HelpContext);
end;

function TActionClientLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and Assigned(FClient.FControl) and
    (FClient.FControl.Hint = (Action as TCustomAction).Hint);
end;

function TActionClientLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and Assigned(FClient.FControl) and
    (FClient.FControl.Hint = (Action as TCustomAction).Hint);
end;

function TActionClientLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and Assigned(FClient.FControl) and
    (@FClient.FControl.OnClick = @Action.OnExecute);
end;

function TActionClientLink.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = (Action as TCustomAction).ShortCut);
end;

function TActionClientLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and (FClient.Visible =
    (Action as TCustomAction).Visible);
end;

procedure TActionClientLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TActionClientLink.SetChecked(Value: Boolean);
begin
  inherited SetChecked(Value);
  if IsCheckedLinked and Assigned(FClient.Control) then FClient.Control.Invalidate;
end;

procedure TActionClientLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.FControl.Enabled := Value;
end;

procedure TActionClientLink.SetHelpContext(Value: THelpContext);
begin
  if IsHelpContextLinked then FClient.HelpContext := Value;
end;

procedure TActionClientLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.FControl.Hint := Value;
end;

procedure TActionClientLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TActionClientLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.FControl.OnClick := Value;
end;

procedure TActionClientLink.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.Shortcut := Value;
end;

procedure TActionClientLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

{ TActionClientItem }

constructor TActionClientItem.Create(Collection: TCollection);
begin
  // Set the color before calling inherited Create since it will result in
  // the control being created and the color will be necesary at that point.
  FColor := clDefault;
  inherited Create(Collection);
  FImageIndex := -1;
  FMergeIndex := 0;
  FShowCaption := True;
  FShowGlyph := True;
  FShowShortCut := True;
  FCheckUnused := True;
  FUsageCount := 0;
  FLastSession := 0;
end;

destructor TActionClientItem.Destroy;
begin
  FreeAndNil(FActionLink);
  FreeAndNil(FControl);
  inherited Destroy;
end;

procedure TActionClientItem.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if Assigned(Self.FControl) then
      begin
        if (not CheckDefaults or (Self.FControl.Enabled = True)) then
          Self.FControl.Enabled := Enabled;
        if not CheckDefaults or (Self.FControl.Hint = '') then
          Self.FControl.Hint := Hint;
        if not CheckDefaults or not Assigned(Self.FControl.OnClick) then
          Self.FControl.OnClick := OnExecute;
      end;
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.ImageIndex = 0) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.ShortCut = 0) then
        Self.ShortCut := ShortCut;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
    end;
end;

procedure TActionClientItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TActionClientItem then
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      Action := TActionClientItem(Source).Action;
      Caption := TActionClientItem(Source).Caption;
      HelpContext := TActionClientItem(Source).HelpContext;      
      ImageIndex := TActionClientItem(Source).ImageIndex;
      MergeIndex := TActionClientItem(Source).MergeIndex;
      LastSession := TActionClientItem(Source).LastSession;
      ShowCaption := TActionClientItem(Source).ShowCaption;
      ShowGlyph := TActionClientItem(Source).ShowGlyph;
      ShowShortCut := TActionClientItem(Source).ShowShortCut;
      ShortCut := TActionClientItem(Source).ShortCut;
      UsageCount := TActionClientItem(Source).UsageCount;
      if Assigned(TActionClientItem(Source).FItems) then
        Items.Assign(TActionClientItem(Source).Items);
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
end;

procedure TActionClientItem.ColorChanged;
begin
  if Assigned(FControl) then
    case FColor of
      clDefault: FControl.ParentColor := True;
      clNone   : FControl.Transparent := True;
    else
      FControl.Color := Color;
    end;
end;

procedure TActionClientItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, True);
end;

function TActionClientItem.GetActionClients: TActionClients;
begin
  Result := TActionClients(Collection);
end;

function TActionClientItem.GetActionLinkClass: TActionClientLinkClass;
begin
  Result := TActionClientLink;
end;

function TActionClientItem.GetAction: TContainedAction;
begin
  Result := nil;
  if ActionLink <> nil then
    Result := TContainedAction(ActionLink.Action);
end;

function TActionClientItem.GetCaption: string;
begin
  if Assigned(ActionBarDesigner) and (Length(FCaption) = 0) and
     not Assigned(Action) then
    Result := Format('ActionClientItem%d', [Index])  { do not localize }
  else
    Result := FCaption;
end;

function TActionClientItem.GetDisplayName: string;
begin
  Result := inherited GetDisplayName;
  if Length(Caption) > 0 then
    Result := Caption
  else
    if Action is TCustomAction then
      with Action as TCustomAction do
        if Length(Caption) > 0 then
          Result := Caption;
end;

function TActionClientItem.HasGlyph: Boolean;

  function CheckImageList(ActionList: TCustomActionList): Boolean;
  begin
    Result := Assigned(ActionList) and Assigned(ActionList.Images) and
      (ImageIndex > -1) and (ImageIndex < ActionList.Images.Count);
  end;

begin
  Result := ShowGlyph and (Assigned(OwningCollection) and
    CheckImageList(OwningCollection.ActionManager)) or
    (Assigned(Action) and CheckImageList(Action.ActionList));
end;

procedure TActionClientItem.InitiateAction;
begin
  if ActionLink <> nil then ActionLink.Update;
end;

function TActionClientItem.IsCaptionStored: Boolean;
begin
  if Assigned(Action) and (Action is TCustomAction) then
    Result := AnsiCompareText(Caption, TCustomAction(Action).Caption) <> 0
  else
    Result := True;
end;

procedure TActionClientItem.Refresh;
begin
  if Assigned(FControl) then FControl.CalcBounds;
end;

procedure TActionClientItem.ResetUsageData;
var
  ParentCollection: TActionClientsCollection;
  ParentItem: TActionClient;
begin
  if FUsageCount <> -1 then
  begin
    Inc(FUsageCount);
    FCheckUnused := True;
  end;
  FLastSession := ActionClients.ActionManager.ActionBars.SessionCount;
  ParentItem := ActionClients.ParentItem;
  if Assigned(ParentItem) then
  begin
    ParentCollection := ActionClients.ParentItem.OwningCollection;
    while Assigned(ParentCollection) and not (ParentCollection is TActionBars) do
      ParentCollection := ParentCollection.FParentItem.OwningCollection;
    if Assigned(ParentCollection) then
      FLastSession := TActionBars(ParentCollection).SessionCount;
    while Assigned(ParentItem) do
    begin
      if ParentItem is TActionClientItem then
      begin
        TActionClientItem(ParentItem).FCheckUnused := True;
        if TActionClientItem(ParentItem).FUsageCount <> -1 then
          Inc(TActionClientItem(ParentItem).FUsageCount);
        TActionClientItem(ParentItem).LastSession := FLastSession;
      end;
      ParentItem := ParentItem.OwningCollection.FParentItem;
    end
  end;
end;

procedure TActionClientItem.SetAction(const Value: TContainedAction);
begin
  if Value = nil then
  begin
    ActionLink.Free;
    ActionLink := nil;
  end
  else
  begin
    if Value = Action then exit;
    if Assigned(Control) then
      FreeAndNil(FControl);
    if ActionLink = nil then
      ActionLink := GetActionLinkClass.Create(Self);
    ActionLink.Action := Value;
    ActionLink.OnChange := DoActionChange;
    ActionChange(Value, (csLoading in Value.ComponentState) or
      ActionClients.ActionManager.Loading);
    Value.FreeNotification(TActionClients(Collection).ActionManager);
    if Assigned(ActionClients.ParentItem) then
      if Assigned(ActionClients.ParentItem.ActionBar) then
        ActionClients.ParentItem.ActionBar.CreateControl(Self)
      else if Assigned(ActionClients.ParentItem.ChildActionBar) then
        ActionClients.ParentItem.ChildActionBar.CreateControl(Self)
  end;
end;

procedure TActionClientItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    FSeparator := (Action = nil) and ((Value = '-') or (Value = '|'));
    if Separator then
    begin
      Action := nil;
      ShortCut := 0;
    end;
    if Assigned(FControl) then
      Control.Caption := Value;
  end;
end;

procedure TActionClientItem.SetControl(const Value: TCustomActionControl);
begin
  if FControl <> Value then
  begin
    FreeAndNil(FControl);
    FControl := Value;
    if Assigned(FControl) then
    begin
      ActionChange(Action, True);
      FControl.ActionClient := Self;
    end;
  end;
end;

procedure TActionClientItem.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if Assigned(Control) then
    begin
      Control.CalcBounds;
      Control.Invalidate;
    end;
  end;
end;

procedure TActionClientItem.SetIndex(Value: Integer);
begin
  inherited SetIndex(Value);
  if Assigned(FControl) then
    FControl.PositionChanged;
  NotifyDesigner(ActionBar);
end;

procedure TActionClientItem.SetLastSession(const Value: Integer);
begin
  if FLastSession <> Value then
  begin
    FLastSession := Value;
    FCheckUnused := True;
  end;
end;

procedure TActionClientItem.SetMergeIndex(const Value: TMergeRange);
var
  I: Integer;
begin
  if (Value > FMergeIndex) or (Index = 0) or
     (ActionClients.ActionClients[Index - 1].FMergeIndex = 0) then
  begin
    for I := Index + 1 to ActionClients.Count - 1 do
      with ActionClients.ActionClients[I] do
        if Self.FMergeIndex = FMergeIndex then
          FMergeIndex := Value
        else
          FMergeIndex := Value + Abs(Self.FMergeIndex - FMergeIndex);
    FMergeIndex := Value;
  end;
end;

procedure TActionClientItem.SetShortCut(const Value: TShortCut);
begin
  if FShortCut <> Value then
  begin
    FShortCut := Value;
    FShortCutText := ShortCutToText(Value);
    Refresh;
  end;
end;

procedure TActionClientItem.SetShowCaption(const Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    if not (csLoading in ActionClients.ActionManager.ComponentState) and not HasGlyph then
      FShowCaption := Value or Assigned(FControl) and (FControl.ComponentCount = 0)
    else
      FShowCaption := Value;
    Refresh;
  end;
end;

procedure TActionClientItem.SetShowShortCut(const Value: Boolean);
begin
  if FShowShortCut <> Value then
  begin
    FShowShortCut := Value;
    if Assigned(FControl) then
    begin
      FControl.CalcBounds;
      FControl.Parent.Realign;
    end;
  end;
end;

procedure TActionClientItem.SetUsageCount(const Value: Integer);
begin
  if Value = MaxInt then
    FUsageCount := 0
  else
    FUsageCount := Value;
  FCheckUnused := True;
  if Assigned(FControl) then
    FControl.Invalidate;
end;

procedure TActionClientItem.SetVisible(const Value: Boolean);
begin
  if (FVisible <> Value) or (Assigned(Control) and (Control.Visible <> Value)) then
  begin
    FVisible := Value;
    if Assigned(FControl) and (FControl.Visible <> Value) then
      FControl.Visible := FVisible;
    if Assigned(FActionBar) then
    begin
      if (FActionBar.Visible <> Value) then
        if FActionBar.Parent is TXToolDockForm then
          FActionBar.Parent.Visible := False
        else
          FActionBar.Visible := FVisible;
      if not (csDesigning in FActionBar.ComponentState) then
        Refresh;
    end;
  end;
end;

procedure TActionClientItem.SetChangesAllowed(
  const Value: TChangesAllowedSet);
begin
  inherited SetChangesAllowed(Value);
  if (ParentItem is TActionClientItem) and (Byte(ChangesAllowed) < Byte(ActionClients.ParentItem.ChangesAllowed)) then
    ParentItem.FChangesAllowed := ChangesAllowed;
end;

procedure TActionClientItem.SetShowGlyph(const Value: Boolean);
begin
  if FShowGlyph <> Value then
  begin
    FShowGlyph := Value;
    if Assigned(Control) then
      Control.CalcBounds;
  end;
end;

procedure TActionClientItem.SetCollection(Value: TCollection);
begin
  if Assigned(FControl) then
  begin
    FreeAndNil(FControl);
    if Assigned(ActionBar) then
      ActionBar.Resize;
  end;
  inherited SetCollection(Value);
end;

function TActionClientItem.Unused: Boolean;

  function CheckControl(Item: TActionClientItem): Boolean;
  begin
    Result := Item.Visible and Assigned(Item.Control) and Item.Control.Visible;
  end;

var
  I: Integer;
begin
  Result := FUnused;
  if not FCheckUnused then exit;
  if not ActionClients.HideUnused then
  begin
    Result := False;
    exit;
  end;
  with ActionClients.ActionManager do
    // if item is a separator and items surrounding it are unused, it is unused too
    if Separator then
    begin
      for I := Index - 1 downto 0 do
        if (Index > 0) then
        begin
          if ActionClients.ActionClients[Index - 1].Separator then
            break;
          Result := not GetUsage(ActionClients.ActionClients[Index - 1]);
          if Result then
            break;
        end;

      if Result then
        for I := 0 to Collection.Count - 1 do
          if (Index < Collection.Count - 1) then
          begin
            if ActionClients.ActionClients[Index + 1].Separator then
              break;
            Result := not GetUsage(ActionClients.ActionClients[Index + 1]);
            if Result then
              break;
          end;
    end
    else
    begin
      Result := not GetUsage(Self);
      if Result and (Items.Count > 0) then
        Result := not HasVisibleItems;
      FCheckUnused := False;
    end;
  FUnused := Result;
end;

function TActionClientItem.IsHelpContextStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHelpContextLinked;
end;

{ TActionDragObject }

constructor TActionDragObject.Create;
begin
  FActions := TList.Create;
  FActionClasses := False;
end;

destructor TActionDragObject.Destroy;
begin
  FActions.Free;
  inherited Destroy;
end;

procedure TActionDragObject.AddAction(AnAction: TContainedAction);
begin
  FActions.Add(AnAction);
end;

procedure TActionDragObject.AddActionClass(AnActionClass: TCustomActionClass);
begin
  FActions.Add(AnActionClass);
end;

function TActionDragObject.GetAction(
  Index: Integer): TContainedAction;
begin
  if FActionClasses then
    Result := ActionBarDesigner.CreateAction(FActions[Index])
  else
    Result := TCustomAction(FActions[Index]);
end;

function TActionDragObject.GetActionCount: Integer;
begin
  Result := FActions.Count;
end;

{ TCategoryDragObject }

constructor TCategoryDragObject.Create(ACategory: string);
begin
  inherited Create;
  FCategory := ACategory;
end;

{ TActionItemDragObject }

procedure TActionItemDragObject.Finished(Target: TObject; X, Y: Integer;
  Accepted: Boolean);
var
  P: TPoint;
begin
  inherited Finished(Target, X, Y, Accepted);
  if not Assigned(ClientItem.Control) then exit;
  if Target = ClientItem.Control then exit;
  P := ClientItem.Control.ScreenToClient(Point(X, Y));
  if Dropped and not Accepted and not PtInRect(ClientItem.Control.ClientRect, P) then
    ClientItem.Free;
  NotifyDesigner(nil);
end;

procedure ColorProc(ActionBar: TCustomActionBar; Colors: TCustomActionBarColorMap);
begin
  if Assigned(ActionBar) then
  begin
    if ActionBar is TCustomActionPopupMenu then
      ActionBar.Color := Colors.MenuColor
    else
      ActionBar.Color := Colors.Color;
    if ActionBar.HandleAllocated then
      ActionBar.Invalidate;
  end;
end;

procedure FontColorProc(ActionBar: TCustomActionBar; Colors: TCustomActionBarColorMap);
begin
  if Assigned(ActionBar) and (ActionBar.Font.Color <> Colors.FontColor) then
    ActionBar.Font.Color := Colors.FontColor;
end;

{ TCustomActionBarColorMap }

procedure TCustomActionBarColorMap.Add(ActionBar: TCustomActionBar);
begin
  if Assigned(ActionBar) then
    if FActionBars.IndexOf(ActionBar) = -1 then
    begin
      FActionBars.Add(ActionBar);
      FreeNotification(ActionBar);
      ColorProc(ActionBar, Self);
      FontColorProc(ActionBar, Self);
    end;
end;

constructor TCustomActionBarColorMap.Create(AOwner: TComponent);
begin
  inherited;
  FActionBars := TList.Create;
  UpdateColors;
end;

destructor TCustomActionBarColorMap.Destroy;
begin
  FreeAndNil(FActionBars);
  inherited;
end;

function TCustomActionBarColorMap.GetDisabledColor: TColor;
begin
  Result := FDisabledColor;
  if not (csDesigning in ComponentState) and (FDisabledColor = clNone) then
    Result := Color;
end;

function TCustomActionBarColorMap.GetUnusedColor: TColor;
begin
  if FUnusedColor = clDefault then
    Result := GetHighLightColor(Color)
  else
    Result := FUnusedColor;
end;

procedure TCustomActionBarColorMap.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  Idx: Integer;
begin
  inherited;
  case Operation of
    opRemove:
      if AComponent is TCustomActionBar then
      begin
        Idx := FActionBars.IndexOf(AComponent);
        if Idx <> - 1 then
          FActionBars.Delete(Idx);
      end;
  end;
end;

procedure TCustomActionBarColorMap.Remove(ActionBar: TCustomActionBar);
var
  Idx: Integer;
begin
  if Assigned(ActionBar) then
  begin
    if Assigned(FActionBars) then
    begin
      Idx := FActionBars.IndexOf(ActionBar);
      if Idx <> -1 then
        FActionBars.Delete(Idx);
    end;
    RemoveFreeNotification(ActionBar);
  end;
end;

procedure TCustomActionBarColorMap.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    UpdateActionBars(ColorProc, Value);
    if FUnusedColor = clDefault then
      FUnusedColor := GetHighLightColor(Color);
    if FDisabledFontColor = clDefault then
      FDisabledFontColor := GetShadowColor(Color);
    if Assigned(FOnColorChange) then
      FOnColorChange(Self);
  end;
end;

procedure TCustomActionBarColorMap.SetFontColor(const Value: TColor);
begin
  if FFontColor <> Value then
  begin
    FFontColor := Value;
    if FDisabledFontColor = clDefault then
      FDisabledFontColor := GetShadowColor(Color);
    if FDisabledFontShadow = clDefault then
      FDisabledFontShadow := GetHighlightColor(Color);
    UpdateActionBars(FontColorProc, Value);
  end;
end;

procedure TCustomActionBarColorMap.UpdateColors;
begin
  FDesignFocus := clBlack;
end;

procedure TCustomActionBarColorMap.UpdateActionBars(
  UpdateProc: TColorMapUpdateProc; Color: TColor);
var
  I: Integer;
begin
  for I := 0 to FActionBars.Count - 1 do
    UpdateProc(FActionBars[I], Self);
end;

procedure TCustomActionBarColorMap.Assign(Source: TPersistent);
begin
  if Source is TCustomActionBarColorMap then
  begin
    BtnSelectedColor := TCustomActionBarColorMap(Source).BtnSelectedColor;
    BtnFrameColor := TCustomActionBarColorMap(Source).BtnFrameColor;
    BtnSelectedFont := TCustomActionBarColorMap(Source).BtnSelectedFont;
    Color := TCustomActionBarColorMap(Source).Color;
    DesignFocus := TCustomActionBarColorMap(Source).DesignFocus;
    DisabledColor := TCustomActionBarColorMap(Source).DisabledColor;
    DisabledFontColor := TCustomActionBarColorMap(Source).DisabledFontColor;
    DisabledFontShadow := TCustomActionBarColorMap(Source).DisabledFontShadow;
    FontColor := TCustomActionBarColorMap(Source).FontColor;
    FrameTopLeftInner := TCustomActionBarColorMap(Source).FrameTopLeftInner;
    FrameTopLeftOuter := TCustomActionBarColorMap(Source).FrameTopLeftOuter;
    FrameBottomRightInner := TCustomActionBarColorMap(Source).FrameBottomRightInner;
    FrameBottomRightOuter := TCustomActionBarColorMap(Source).FrameBottomRightOuter;
    HighlightColor := TCustomActionBarColorMap(Source).HighlightColor;
    HotColor := TCustomActionBarColorMap(Source).HotColor;
    HotFontColor := TCustomActionBarColorMap(Source).HotFontColor;
    MenuColor := TCustomActionBarColorMap(Source).MenuColor;
    SelectedColor := TCustomActionBarColorMap(Source).SelectedColor;
    SelectedFontColor := TCustomActionBarColorMap(Source).SelectedFontColor;
    ShadowColor := TCustomActionBarColorMap(Source).ShadowColor;
    UnusedColor := TCustomActionBarColorMap(Source).UnusedColor;
    OnColorChange := TCustomActionBarColorMap(Source).OnColorChange;
  end;
end;

{ TCustomActionBar }

constructor TCustomActionBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDesignable := True;
  ColorMap := SetupDefaultColorMap;
  FActionManager := nil;
  FActionClient := nil;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  ControlStyle := ControlStyle + [csClickEvents, csDoubleClicks, csSetCaption,
    csOpaque];
  Height := 50;
  Width := 150;
  DoubleBuffered := True;
  FVertMargin := 1;
  FHorzMargin := 0;
  FAllowHiding := True;
end;

destructor TCustomActionBar.Destroy;
begin
  ActionManager := nil;
  FCanvas.Free;
  FreeAndNil(FDefaultColorMap);
  inherited Destroy;
end;

procedure TCustomActionBar.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  FHRowCount := 1;
  FVRowCount := 1;
  FWidest := 0;
  FTallest := 0;
  inherited AlignControls(AControl, Rect);
end;

procedure TCustomActionBar.AutoSizingChanged;
begin
end;

function TCustomActionBar.BackgroundSize: TPoint;
begin
  Result := Point(0, 0);
end;

function TCustomActionBar.CalcInsertPosition(Control: TCustomActionControl;
  X, Y: Integer): Integer;
begin
  if Assigned(Control) and Assigned(Control.ActionClient) then
  begin
    Result := Control.ActionClient.Index;
    if (X < Control.Left) and (Orientation in [boLeftToRight]) then
      Dec(Result);
    if (Y < Control.Top) and (Orientation in [boTopToBottom]) then
      Dec(Result);
    if (X > Control.BoundsRect.Right) and (Orientation in [boLeftToRight]) then
      Inc(Result);
    if (Y > Control.BoundsRect.Bottom) and (Orientation in [boTopToBottom]) then
      Inc(Result);
    if Result > Items.Count then
      Result := Items.Count;
    if Result < 0 then Result := 0;
  end
  else
    if HasItems then
      Result := Items.Count
    else
      Result := 0;
end;

procedure TCustomActionBar.Clear;
var
  I: Integer;
begin
  if Assigned(FActionClient) then
  begin
    DisableAlign;
    try
      for I := ItemCount - 1 downto 0 do
        ActionControls[I].Free;
      FActionClient.ClearActionBar;
      FActionClient := nil;
    finally
      EnableAlign;
    end;
  end;
end;

procedure TCustomActionBar.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  Broadcast(Message);
end;

function TCustomActionBar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
var
  ItemClass: TCustomActionControlClass;
begin
  if AnItem.Control <> nil then
  begin
    AnItem.Control.Free;
    AnItem.Control := nil;
  end;
  Result := nil;
  ItemClass := DoGetControlClass(AnItem);
  if ItemClass = nil then exit;
  DisableAlign;
  try
    Result := ItemClass.Create(Self);
    with Result do
    begin
      DragMode := ControlDragMode[DesignMode];
      Align := alCustom;
      FActionBar := Self;
      Parent := Self;
      BiDiMode := Self.BiDiMode;
      ActionClient := AnItem;
      ActionClient.Control := Result;
      RequestAlign;
    end;
  finally
    EnableAlign;
  end;
end;

procedure TCustomActionBar.CreateControls;
var
  I: Integer;
  NewControl: TCustomActionControl;
  Items: TActionClients;
begin
  if (FActionClient = nil) then exit;
  DisableAlign;
  try
    if ContextBar then
      Items := FActionClient.FContextItems
    else
      Items := FActionClient.FItems;
    if not Assigned(Items) then exit;
    for I := 0 to Items.Count - 1 do
    begin
      NewControl := CreateControl(Items.ActionClients[I]);
      if Assigned(NewControl) then
      begin
        NewControl.Transparent := FActionClient.HasBackground and
          not (FActionClient.BackgroundLayout in [blLeftBanner, blRightBanner]);
        DoControlCreated(NewControl);
      end;
    end;
  finally
    EnableAlign;
  end;
end;

function TCustomActionBar.CustomAlignInsertBefore(C1,
  C2: TControl): Boolean;
begin
  Result := (C1 is TCustomActionControl) and (C2 is TCustomActionControl);
  if not Result then exit;
  if Assigned(TCustomActionControl(C1).ActionClient) and
    Assigned(TCustomActionControl(C2).ActionClient) then
    Result := TCustomActionControl(C1).ActionClient.Index <
      TCustomActionControl(C2).ActionClient.Index
  else
    Result := False;
  if C1.Visible and (C1.Height > FTallest) then
    FTallest := C1.Height;
  if C1.Visible and (C1.Width > FWidest) then
    FWidest := C1.Width;
  if C2.Visible and (C2.Height > FTallest) then
    FTallest := C2.Height;
  if C2.Visible and (C2.Width > FWidest) then
    FWidest := C2.Width;
  if Floating then
    case Orientation of
      boTopToBottom, boBottomToTop: Constraints.MinHeight := FTallest + VertMargin * 2;
      boLeftToRight, boRightToLeft: Constraints.MinWidth := FWidest + HorzMargin * 2 +
        GetBannerWidth(beEither);
    end;
end;

procedure TCustomActionBar.CustomAlignPosition(Control: TControl;
  var NewLeft, NewTop, NewWidth, NewHeight: Integer; var AlignRect: TRect;
  AlignInfo: TAlignInfo);
const
  SepSize: array[Boolean] of Integer = (0, 2);
var
  ABControl: TCustomActionControl;
begin
  if not (Control is TCustomActionControl) then exit;
  ABControl := TCustomActionControl(Control);
  if AlignInfo.AlignList.Count = 1 then
  begin
    FWidest := Control.Width;
    FTallest := Control.Height;
  end;
  if AlignInfo.ControlIndex = 0 then
    AlignRect := Rect(HorzMargin + GetBannerWidth(beLeft),
      VertMargin, ClientWidth - VertMargin - GetBannerWidth(beRight),
      ClientHeight - VertMargin);
  case FOrientation of
    boLeftToRight:
      begin
        if (Floating or AutoSizing) and (AlignInfo.ControlIndex <> 0) and
           (ABControl.Width + FHorzMargin > AlignRect.Right - AlignRect.Left) then
        begin
          AlignRect := Rect(FHorzMargin + GetBannerWidth(beLeft),
            AlignRect.Top + FTallest + (FVertMargin * 2 +
            SepSize[FHorzSeparator]),
            ClientWidth - FHorzMargin - GetBannerWidth(beRight),
            ClientHeight - AlignRect.Top - FVertMargin);
          Inc(FVRowCount);
        end;
        NewTop := AlignRect.Top;
        NewLeft := AlignRect.Left;
        NewHeight := FTallest;
        Inc(AlignRect.Left, ABControl.Width + FSpacing);
      end;
    boRightToLeft:
      begin
        if (Floating or AutoSizing) and (AlignInfo.ControlIndex <> 0) and
           (ABControl.Width > AlignRect.Right - AlignRect.Left) then
        begin
          AlignRect := Rect(FHorzMargin + GetBannerWidth(beLeft),
            AlignRect.Top + FTallest + (FVertMargin * 2 +
            SepSize[FHorzSeparator]),
            ClientWidth - FHorzMargin - GetBannerWidth(beRight),
            ClientHeight - AlignRect.Top - FVertMargin);
          Inc(FVRowCount);
        end;
        NewTop := AlignRect.Top;
        if AlignInfo.ControlIndex = 0 then
        begin
          NewLeft := AlignRect.Right - ABControl.Width - FHorzMargin;
          Dec(AlignRect.Right, FVertMargin + ABControl.Width + FSpacing);
        end
        else
        begin
          NewLeft := AlignRect.Right - ABControl.Width;
          if AlignInfo.ControlIndex = AlignInfo.AlignList.Count - 1 then
            Dec(AlignRect.Right, ABControl.Width)
          else
            Dec(AlignRect.Right, ABControl.Width + FSpacing);
        end;
        NewHeight := FTallest;
      end;
    boTopToBottom:
      begin
        if (Floating or AutoSizing) and (AlignInfo.ControlIndex <> 0) and
           (ABControl.Height > AlignRect.Bottom - AlignRect.Top) then
        begin
          AlignRect := Rect(AlignRect.Left + FWidest + HorzMargin * 2 + SepSize[FHorzSeparator],
            VertMargin, ClientWidth - HorzMargin - GetBannerWidth(beRight),
            ClientHeight - VertMargin);
          Inc(FHRowCount);
        end;
        if AlignInfo.ControlIndex = 0 then
          NewTop := VertMargin
        else
          NewTop := AlignRect.Top;
        AlignRect.Right := FWidest + GetBannerWidth(beEither);
        NewLeft := AlignRect.Left;
        NewWidth := FWidest;
        Inc(AlignRect.Top, ABControl.Height + FSpacing);
      end;
    boBottomToTop:
      begin
        if (Floating or AutoSizing) and (AlignInfo.ControlIndex <> 0) and
           (ABControl.Height > AlignRect.Bottom - AlignRect.Top) then
        begin
          AlignRect := Rect(HorzMargin + GetBannerWidth(beLeft), VertMargin,
            AlignRect.Right - FWidest - (HorzMargin * 2) - SepSize[FHorzSeparator],
            ClientHeight - VertMargin);
          Inc(FHRowCount);
        end;
        if AlignInfo.ControlIndex = 0 then
          NewTop := ClientHeight - Control.Height - HorzMargin
        else
          NewTop := AlignRect.Bottom - Control.Height - Spacing;
        NewLeft := AlignRect.Right - FWidest;
        NewWidth := FWidest;
        Dec(AlignRect.Bottom, ABControl.Height + FSpacing);
      end;
  end;
end;

procedure TCustomActionBar.DrawBackground;
var
   x,y,w,h : Integer;
begin
  if Assigned(FActionClient) and FActionClient.HasBackground then
    case FActionClient.BackgroundLayout of
      blRightBanner: Canvas.Draw(Width - FActionClient.Background.Graphic.Width,
        0, FActionClient.Background.Graphic);
      blLeftBanner,
      blNormal : Canvas.Draw(0, 0, FActionClient.Background.Graphic);
      blStretch: Canvas.StretchDraw(ClientRect, FActionClient.Background.Graphic);
      blTile:
        begin
          w := FActionClient.Background.Graphic.Width;
          h := FActionClient.Background.Graphic.Height;
          for x := 0 to ClientWidth div w do
           for y := 0 to ClientHeight div h do
             Canvas.Draw(w * x, h * y, FActionClient.Background.Graphic);
        end;
    end;
end;

procedure TCustomActionBar.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited DragOver(Source, X, Y, State, Accept);
  Accept := Designable and ((Source is TActionDragObject) or (Source is TActionItemDragObject));
end;

procedure TCustomActionBar.DragDrop(Source: TObject; X, Y: Integer);
begin
  inherited DragDrop(Source, X, Y);
  if (FActionClient = nil) then
    with Source as TActionDragBaseClass do
    begin
      Self.ActionManager := TCustomActionManager(ActionManager);
      FActionClient := ActionManager.ActionBars.Add;
      FActionClient.FActionBar := Self;
    end;
  DisableAlign;
  try
    if Source is TCategoryDragObject then
      DoDropCategory(Source as TCategoryDragObject, X, Y)
    else if Source is TActionDragObject then
      DoDropActions(Source as TActionDragObject, X, Y)
    else if Source is TActionItemDragObject then
      DoDropItem(Source as TActionItemDragObject, X, Y);
  finally
    ActionClient.Items.InternalRethinkHotkeys(True);
    ActionClient.Refresh;
    EnableAlign;
    Realign;
  end;
end;

function TCustomActionBar.DoGetControlClass(
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  Result := GetControlClass(AnItem);
  if Assigned(FOnGetControlClass) then
    FOnGetControlClass(Self, AnItem, Result)
end;

procedure TCustomActionBar.DoControlCreated(var Control: TCustomActionControl);
begin
  if Assigned(FOnControlCreated) then
    FOnControlCreated(Self, Control);
end;

function TCustomActionBar.FindAccelItem(const Accel: Word): TActionClientItem;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    Result := Items[I];
    if (Items.CaptionOptions <> coNone) and Result.Control.Parent.Showing and
       Result.Visible and Result.ShowCaption and IsAccel(Accel, Result.Caption) then
      Exit;
  end;
  Result := nil;
end;

function TCustomActionBar.FindFirst: TActionClientItem;
begin
  if Assigned(FActionClient) and HasItems and (ControlCount > 0) then
    Result := Items[0]
  else
    Result := nil;
end;

function TCustomActionBar.FindItemAt(const P: TPoint): TCustomActionControl;
var
  Item: TControl;
begin
  Item := ControlAtPos(P, True);
  if Item is TCustomActionControl then
    Result := TCustomActionControl(Item)
  else
    Result := nil;
end;

function TCustomActionBar.FindItemCaption(const ACaption: string): TCustomActionControl;
var
  I: Integer;
begin
  Result := nil;
  for i := 0 to ItemCount - 1 do
    if AnsiCompareText(ActionControls[I].Caption, ACaption) = 0 then
    begin
      Result := ActionControls[I];
      break;
    end;
end;

function TCustomActionBar.FindLast: TActionClientItem;
begin
  if Assigned(FActionClient) and HasItems then
    Result := Items[Items.Count - 1]
  else
    Result := nil;
end;

function TCustomActionBar.FindLeastUsedItem(
  const Visible: Boolean = True): TActionClientItem;
var
  I: Integer;
  Age: Integer;
begin
  Result := FindFirst;
  if Result = nil then exit;
  while Assigned(Result) and not Result.Control.Visible do
    Result := FindPrevious(Result, False);
  Age := 0;
  for I := 1 to ItemCount - 1 do
  begin
    if Assigned(Items[I].Control) and
      (Items[I].Control.Visible <> Visible) then Continue;
    if Assigned(Items[I]) and Assigned(ActionControls[I]) and
       (Age <= ActionManager.ActionBars.SessionCount - Items[I].LastSession) then
    begin
      Result := Items[I];
      Age := ActionManager.ActionBars.SessionCount - ActionControls[I].ActionClient.LastSession;
    end;
  end;
  if Result = nil then
    Result := FindLastVisibleItem;
end;

function TCustomActionBar.FindLastVisibleItem: TActionClientItem;
begin
  Result := FindLast;
  while Assigned(Result) and ((Result.Control = nil) or
     (Assigned(Result.Control) and not Result.Control.Visible)) do
    Result := FindPrevious(Result, False);
end;

function TCustomActionBar.FindFirstVisibleItem: TActionClientItem;
begin
  Result := FindFirst;
  while Assigned(Result) and Assigned(Result.Control) and not Result.Control.Visible do
    Result := FindNext(Result, False);
end;

function TCustomActionBar.FindNearestControl(
  const Point: TPoint): TCustomActionControl;

  function PointToRow(Pt: TPoint): Integer;
  var
    RowSize: Integer;
  begin
    Result := 1;
    if FVRowCount > 1 then
    begin
      RowSize := GetBarHeight div FVRowCount;
      Result := 1;
      while Pt.Y > RowSize * Result do
        Inc(Result);
    end;
    if FHRowCount > 1 then
    begin
      RowSize := GetBarWidth div FHRowCount;
      Result := 1;
      while Pt.X > RowSize * Result do
        Inc(Result);
    end;
  end;

var
  I: Integer;
  MinDistance: Integer;
  D: Integer;
  X1, Y1: Integer;
  Row: Integer;
  Ctrl: TControl;
begin
  Ctrl := ControlAtPos(Point, True);
  if Ctrl is TCustomActionControl then
  begin
    Result := TCustomActionControl(Ctrl);
    exit;
  end
  else
    Result := nil;
  MinDistance := MaxInt;
  Row := PointToRow(Point);
  for I := 0 to ItemCount - 1 do
  begin
    if (Items[I].Control = nil) or not Items[I].Control.Visible then Continue;
    if PointToRow(Items[I].Control.BoundsRect.TopLeft) <> Row then Continue;
    X1 := Point.X;
    Y1 := Point.Y;
    if Point.X < Items[I].Control.Left then X1 := Items[I].Control.Left;
    if Point.Y < Items[I].Control.Top then Y1 := Items[I].Control.Top;
    if Point.X > Items[I].Control.BoundsRect.Right then X1 := Items[I].Control.BoundsRect.Right;
    if Point.Y > Items[I].Control.BoundsRect.Bottom then Y1 := Items[I].Control.BoundsRect.Bottom;
    D := ((Point.X - X1) * (Point.X - X1)) + ((Point.Y - Y1) * (Point.Y - Y1));
    if D < MinDistance then
    begin
      MinDistance := D;
      Result := Items[I].Control;
    end;
  end;
end;

function TCustomActionBar.FindNextVisibleitem(AClient: TActionClientItem): TActionClientItem;
begin
  Result := FindNext(AClient, False);
  while Assigned(Result) and Assigned(Result.Control) and not Result.Control.Visible do
    Result := FindNext(Result, False);
end;

function TCustomActionBar.FindNext(AClient: TActionClientItem;
  const Wrap: Boolean = True): TActionClientItem;
begin
  Result := nil;
  if Assigned(AClient) then
  begin
    if HasItems and
       (AClient.Index < Items.Count - 1) then
      Result := Items[AClient.Index + 1]
    else
      if Wrap and (ItemCount > 1) then
        Result := Items[0];
  end
  else
    if Wrap then
      Result := FindFirst;
end;

function TCustomActionBar.FindPrevious(AClient: TActionClientItem;
  const Wrap: Boolean = True): TActionClientItem;
begin
  Result := nil;
  if Assigned(AClient) then
  begin
    if AClient.Index > 0 then
      Result := Items[AClient.Index - 1]
    else
      if Wrap and (ItemCount > 1) then
        Result := Items[Items.Count - 1];
  end
  else
    if Wrap then
      Result := FindLast;
end;

function TCustomActionBar.GetActionControl(const Index: Integer): TCustomActionControl;
begin
  if (Index >= 0) and (Index < ItemCount) then
    { Use Items to ensure we only get items from the ActionClients
     Collection.  ActionBars can add additional controls to enhance the utility
     of the Actionbar and in those cases we want to avoid returning controls
     that are not actually an Actionclient. }
    Result := Items[Index].Control
  else
    Result := nil;
end;

function TCustomActionBar.GetBannerWidth(
  BarEdge: TBarEdge): Integer;
begin
  Result := 0;
  if ActionClient = nil then exit;
  case BarEdge of
    beLeft : if ActionClient.BackgroundLayout = blLeftBanner then
               Result := ActionClient.Background.Bitmap.Width;
    beRight: if ActionClient.BackgroundLayout = blRightBanner then
               Result := ActionClient.Background.Bitmap.Width;
    beEither: if ActionClient.BackgroundLayout in [blLeftBanner, blRightBanner] then
                Result := ActionClient.Background.Bitmap.Width;
  end;
end;

function TCustomActionBar.GetControlClass(
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  Result := Style.GetControlClass(Self, AnItem)
end;

function TCustomActionBar.GetItems: TActionClients;
begin
  Result := nil;
  if not Assigned(ActionClient) then exit;
  if ContextBar then
    Result := ActionClient.ContextItems
  else
    Result := ActionClient.Items;
end;

function TCustomActionBar.HasItems: Boolean;
begin
  Result := False;
  if not Assigned(ActionClient) then exit;
  if ContextBar then
    Result := Assigned(ActionClient.FContextItems) and
      (ActionClient.FContextItems.Count > 0)
  else
    Result := ActionClient.HasItems;
end;

function TCustomActionBar.ItemCount: Integer;
begin
  if Assigned(FActionClient) and HasItems then
    Result := Items.Count
  else
    Result := 0;
end;

procedure TCustomActionBar.Loaded;
var
  AM: TCustomActionManager;
begin
  inherited Loaded;
  if Assigned(FActionManager) then
  begin
    AM := FActionManager;
    SetActionManager(AM);
  end;
  if not Assigned(FColorMap) then
    ColorMap := SetupDefaultColorMap;
end;

procedure TCustomActionBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  case Operation of
    opRemove:
      if (AComponent = FActionManager) then
      begin
        Clear;
        FActionManager := nil;
      end
      else if (AComponent = FColorMap) and not (csDestroying in ComponentState) then
        SetColorMap(nil);
  end;
end;

procedure TCustomActionBar.Paint;
begin
  DrawBackground;
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

procedure TCustomActionBar.PaintWindow(DC: HDC);
begin
  FCanvas.Lock;
  try
    FCanvas.Handle := DC;
    try
      TControlCanvas(FCanvas).UpdateTextFlags;
      Paint;
    finally
      FCanvas.Handle := 0;
    end;
  finally
    FCanvas.Unlock;
  end;
end;

procedure TCustomActionBar.SetActionClient(const Value: TActionClient);
begin
  if FActionClient <> Value then
  begin
    Clear;
    FActionClient := Value;
    if FActionClient = nil then
    begin
      Invalidate;
      exit;
    end;
    if FActionClient.Color <> clDefault then
      Color := FActionClient.Color;
    ActionManager := Value.OwningCollection.ActionManager;
    FActionClient := Value;
    AutoSizingChanged;
    CreateControls;
  end;
end;

procedure TCustomActionBar.SetDesignMode(const Value: Boolean);
var
  I: Integer;
begin
  if FDesignMode <> Value then
  begin
    FDesignMode := Value;
    if csDesigning in ComponentState then exit;
    if Assigned(ActionClient) and not Items.Customizable or
       (ActionClient.ChangesAllowed = []) then
      if FDesignMode then
      begin
        FEnabledState := Enabled;
        Enabled := False;
      end
      else
        Enabled := FEnabledState;

    if DesignMode then
    begin
      FSavedWrapState := DesignMode and AutoSizing;
      FSavedSize := Point(Width, Height);
    end;
    AutoSizing := (DesignMode or FSavedWrapState) and (ItemCount > 0);
    if not DesignMode then
      case Orientation of
        boLeftToRight, boRightToLeft: Height := FSavedSize.Y;
        boTopToBottom, boBottomToTop: Width := FSavedSize.X;
      end;
    for I := 0 to Items.Count - 1 do
      with Items[I] do
        if Assigned(Control) then
          if FDesignMode then
          begin
            if not Control.Visible then
              Control.Visible := True;
            Control.Enabled := (ChangesAllowed <> []) and
              (Self.ActionClient.ChangesAllowed <> []);
            Control.DragMode := ControlDragMode[DesignMode and
              (caMove in ActionClient.ChangesAllowed) or
              (caDelete in ActionClient.ChangesAllowed)];
          end
          else
          begin
            Control.DragMode := dmManual;
            if not Visible then
              Control.Visible := Visible;
            if Assigned(Action) then
              Action.Update
            else
              Control.Enabled := True;
            Control.Selected := False;
          end;
  end;
end;

procedure TCustomActionBar.SetOrientation(const Value: TBarOrientation);
var
  I: Integer;
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    if ItemCount > 0 then
    begin
      DisableAlign;
      try
        for I := 0 to ItemCount - 1 do
          ActionControls[I].CalcBounds;
      finally
        EnableAlign;
      end;
    end;
  end;
end;

procedure TCustomActionBar.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Realign;
  end;
end;

procedure TCustomActionBar.SetActionManager(const Value: TCustomActionManager);
begin
  if FActionManager <> Value then
  begin
    if Assigned(FActionManager) then
    begin
      FActionManager.RemoveFreeNotification(Self);
      Clear;
    end;
    FActionManager := Value;
    if Assigned(FActionManager) then
      FActionManager.FreeNotification(Self);
  end;
end;

procedure TCustomActionBar.SetPersistentHotKeys(const Value: Boolean);
begin
  if FPersistentHotKeys<> Value then
  begin
    FPersistentHotKeys := Value;
    Refresh;
  end;
end;

procedure TCustomActionBar.DoDropActions(Source: TActionDragObject;
  const X, Y: Integer);
var
  Idx: Integer;
  I: Integer;
  AC: TActionClientItem;
begin
  Idx := CalcInsertPosition(FindNearestControl(Point(X, Y)), X, Y);
  with Source as TActionDragObject do
  begin
    if ActionCount = 0 then exit;
    for I := 0 to ActionCount - 1 do
    begin
      AC := TActionClientItem(ActionClient.Items.Insert(Idx));
      ActionClient.Items[Idx].Action := Actions[I];
      Idx := AC.Index + 1;
    end;
  end;
end;

procedure TCustomActionBar.DoDropCategory(Source: TCategoryDragObject;
  const X, Y: Integer);
var
  I: Integer;
  AC: TActionClientItem;
begin
  I := CalcInsertPosition(FindNearestControl(Point(X, Y)), X, Y);
  AC := TActionClientItem(Items.Insert(I));
  with Source as TCategoryDragObject do
  begin
    AC.Caption := Category;
    if ActionCount = 0 then exit;
    Items[AC.Index].Caption := Category;
    for I := 0 to ActionCount - 1 do
      with Items[AC.Index].Items.Insert(I) as TActionClientItem do
      begin
        Action := Actions[I];
        LastSession := ActionManager.ActionBars.SessionCount;
      end;
    AC.Control.CalcBounds;
    AC.Visible := True;
    AC.Control.Enabled := (Assigned(AC.Action) or
      (AC.HasItems and (AC.Items.VisibleCount > 0)));
  end;
end;

function TCustomActionBar.FindPreviousVisibleItem(
  AClient: TActionClientItem): TActionClientItem;
begin
  Result := FindPrevious(AClient, False);
  while Assigned(Result) and not Result.Visible do
    Result := FindPrevious(Result, False);
end;

procedure TCustomActionBar.SetBiDiMode(Value: TBiDiMode);
var
  LBiDiMode: TBiDiMode;
begin
  LBiDiMode := BiDiMode;
  inherited SetBiDiMode(Value);
  if (Value <> LBiDiMode) and not (FOrientation in [boTopToBottom, boBottomToTop]) then
    case Value of
      bdLeftToRight: Orientation := boLeftToRight;
      bdRightToLeftNoAlign,
      bdRightToLeftReadingOnly,
      bdRightToLeft: Orientation := boRightToLeft;
   end;
end;

function TCustomActionBar.GetBarHeight: Integer;
begin
  Result := Height;
  if (ItemCount = 0) or (Align in [alLeft, alRight, alClient]) then exit;
  Result := VertMargin + FTallest * FVRowCount +
    (VertMargin * 2) * (FVRowCount - 1) + VertMargin;
  if HorzSeparator and (FVRowCount > 1) then
    Inc(Result, 2 * (FVRowCount - 1));
  if ebTop in EdgeBorders then
  begin
    if EdgeInner in [esRaised, esLowered] then
      Inc(Result);
    if EdgeOuter in [esRaised, esLowered] then
      Inc(Result);
  end;
  if ebBottom in EdgeBorders then
    if EdgeInner in [esRaised, esLowered] then
      Inc(Result);
    if EdgeOuter in [esRaised, esLowered] then
      Inc(Result);
end;

function TCustomActionBar.GetBarWidth: Integer;
begin
  Result := Width;
  if (ItemCount = 0) or not AutoSizing or (Align in [alTop, alBottom, alClient]) then exit;
  Result := HorzMargin + FWidest * FHRowCount +
    (HorzMargin * 2) * (FHRowCount - 1) + HorzMargin;
  if VertSeparator and (FHRowCount > 1) then
    Inc(Result, FHRowCount * 2);
  if ebLeft in EdgeBorders then
  begin
    if EdgeInner in [esRaised, esLowered] then
      Inc(Result);
    if EdgeOuter in [esRaised, esLowered] then
      Inc(Result);
  end;
  if ebRight in EdgeBorders then
    if EdgeInner in [esRaised, esLowered] then
      Inc(Result);
    if EdgeOuter in [esRaised, esLowered] then
      Inc(Result);
end;

function TCustomActionBar.GetDesignMode: Boolean;
begin
  if not Designable then
    Result := False
  else
    Result := (csDesigning in ComponentState) or FDesignMode;
end;

procedure TCustomActionBar.SetHorzMargin(const Value: Integer);
begin
  if FHorzMargin <> Value then
  begin
    FHorzMargin := Value;
    Realign;
    AdjustSize;
  end;
end;

procedure TCustomActionBar.SetVertMargin(const Value: Integer);
begin
  if FVertMargin <> Value then
  begin
    FVertMargin := Value;
    Realign;
    AdjustSize;
  end;
end;

procedure TCustomActionBar.SetHorzSeparator(const Value: Boolean);
begin
  if FHorzSeparator <> Value then
  begin
    FHorzSeparator := Value;
    Realign;
    AdjustSize;
  end;
end;

procedure TCustomActionBar.SetVertSeparator(const Value: Boolean);
begin
  if FHorzSeparator <> Value then
  begin
    FHorzSeparator := Value;
    Realign;
    AdjustSize;
  end;
end;

procedure TCustomActionBar.CMResetBar(var Message: TMessage);
begin
  Reset;
end;

procedure TCustomActionBar.Reset;
var
  AC: TActionClient;
begin
  if Assigned(ActionManager) then
  begin
    DisableAlign;
    AC := ActionClient;
    try
                                                                           
//!!      ActionClient := nil;
      ActionManager.ResetActionBar(AC.Index);
    finally
      ActionClient := AC;
      EnableAlign
    end;
  end;
end;

procedure TCustomActionBar.VisibleChanging;
begin
  inherited VisibleChanging;
  if not AllowHiding then
    raise Exception.CreateFmt(SCannotHideActionBand, [Name]);
end;

procedure TCustomActionBar.WMContextMenu(var Message: TWMContextMenu);
var
  PopupMenu: TCustomActionPopupMenu;
begin
  inherited;
  if Assigned(ActionClient) and (ActionClient.ContextItems.Count > 0) then
  begin
    PopupMenu := GetPopupMenuClass.Create(Owner) as TCustomActionPopupMenu;
    PopupMenu.ContextBar := True;
    PopupMenu.ParentWindow := Application.Handle;
    PopupMenu.Parent := Self;
    PopupMenu.ActionClient := ActionClient;
    PopupMenu.Popup(Message.XPos, Message.YPos);
    PopupMenu.Free;
  end;
end;

function TCustomActionBar.GetAutoSizing: Boolean;
begin
  Result := ActionClient is TActionBarItem and TActionBarItem(ActionClient).AutoSize
end;

procedure TCustomActionBar.SetAutoSizing(const Value: Boolean);
begin
  if ActionClient is TActionBarItem then
    TActionBarItem(ActionClient).AutoSize := Value;
  AdjustSize;
end;

procedure TCustomActionBar.DoDropItem(Source: TActionItemDragObject;
  const X, Y: Integer);
var
  Ctrl: TCustomActionControl;
  Offset: Integer;
begin
  with Source do
  begin
    Ctrl := FindNearestControl(Point(X, Y));
    if Assigned(ClientItem.Control) and (Ctrl = ClientItem.Control) then exit;
    if Ctrl = nil then
      ClientItem.Collection := Items
    else
    begin
      Offset := 0;
      if ((X > Ctrl.BoundsRect.Right) or (Y > Ctrl.BoundsRect.Bottom)) and
         (Ctrl.ActionClient.Index < Ctrl.ActionClient.ActionClients.Count - 1) then
        Offset := 1;
      if (X < Ctrl.BoundsRect.Left) or (Y < Ctrl.BoundsRect.Top) then
        Offset := 0;
      ClientItem.Collection := Items;
      ClientItem.Index := Ctrl.ActionClient.Index + Offset;
    end;
    CreateControl(ClientItem);
  end;
end;

procedure TCustomActionBar.RecreateControls;
var
  I: Integer;
begin
  if ActionClient = nil then exit;
  for I := 0 to ActionClient.Items.Count - 1 do
    FreeAndNil(ActionClient.Items[I].FControl);
  CreateControls;
end;

procedure TCustomActionBar.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
var
  NewWidth: Integer;
begin
                                                     
  if {(AutoSizing or Floating) and }not AlignDisabled and
     (ActionClient is TActionBarItem) then
  begin
    if (Align in [alTop, alBottom]) or (Floating and (Align = alNone)) then
      AHeight := GetBarHeight;
    if (Align in [alLeft, alRight]) or (Floating and (Align = alNone)) then
      NewWidth := GetBarWidth
    else
      NewWidth := AWidth;
    if not Floating and (NewWidth <> Width) then
      AWidth := NewWidth;
  end;
  inherited;
end;

procedure TCustomActionBar.WMPaint(var Message: TWMPaint);
begin
  ControlState := ControlState + [csCustomPaint];
  inherited;
  ControlState := ControlState - [csCustomPaint];
end;

procedure TCustomActionBar.SetColorMap(const Value: TCustomActionBarColorMap);
begin
  if FColorMap <> Value then
  begin
    if Assigned(FColorMap) then
      FColorMap.Remove(Self);
    FColorMap := Value;
    if not Assigned(FColorMap) then
      FColorMap := SetupDefaultColorMap;
    FColorMap.Add(Self);
    Color := FColorMap.Color;
    Invalidate;
    if HandleAllocated then
      SendMessage(Handle, WM_NCPAINT, 1, 0);
  end;
end;

function TCustomActionBar.GetDefaultColorMapClass: TCustomColorMapClass;
begin
  Result := Style.GetColorMapClass(Self)
end;

function TCustomActionBar.SetupDefaultColorMap: TCustomActionBarColorMap;
begin
  FreeAndNil(FDefaultColorMap);
  FDefaultColorMap := GetDefaultColorMapClass.Create(Self);
  FDefaultColorMap.Name := 'DefaultColorMap';
  FDefaultColorMap.SetSubComponent(True);
  FDefaultColorMap.Add(Self);
  Result := FDefaultColorMap;
end;

type
  TEdgeCombinations = (ecOuterRaised, ecInnerRaised = 1,
    ecOuterLowered = 3, ecBothRaised = 4, ecInnerLowered = 5,
    ecInnerRaisedOuterLowered = 7, ecInnerLoweredOuterRaised = 8,
    ecBothLowered = 11);

procedure TCustomActionBar.NCPaint(DC: HDC);
var
  RC, RW: TRect;
  OldHandle: THandle;
  OuterTopLeft,
  OuterBottomRight,
  InnerTopLeft,
  InnerBottomRight: TColor;
  EdgeCombination: TEdgeCombinations;
begin
  if EdgeBorders = [] then exit;
  EdgeCombination := TEdgeCombinations(Ord(EdgeOuter) + Ord(EdgeInner) +
    Ord(EdgeOuter) * 2 + Ord(EdgeInner) * 3 - 3);
  InnerTopLeft := ColorMap.Color;
  InnerBottomRight := ColorMap.Color;
  case EdgeCombination of
    ecOuterRaised,
    ecInnerRaised:
      begin
        OuterTopLeft := GetHighlightColor(ColorMap.Color);
        OuterBottomRight := GetShadowColor(ColorMap.Color);
      end;
    ecInnerLowered,
    ecOuterLowered:
      begin
        OuterTopLeft := GetShadowColor(ColorMap.Color);
        OuterBottomRight := GetHighlightColor(ColorMap.Color);
      end;
    ecBothRaised:
      begin
        InnerTopLeft := GetShadowColor(GetHighlightColor(ColorMap.Color), -30);
        InnerBottomRight := GetShadowColor(ColorMap.Color);
        OuterTopLeft := GetHighlightColor(ColorMap.Color);
        OuterBottomRight := GetShadowColor(ColorMap.Color, -25);
      end;
    ecInnerRaisedOuterLowered:
      begin
        InnerTopLeft  := GetHighlightColor(ColorMap.Color);
        InnerBottomRight := GetShadowColor(ColorMap.Color);
        OuterTopLeft := GetShadowColor(ColorMap.Color);
        OuterBottomRight := GetHighlightColor(ColorMap.Color);
      end;
    ecInnerLoweredOuterRaised:
      begin
        InnerTopLeft  := GetShadowColor(ColorMap.Color);
        InnerBottomRight := GetHighlightColor(ColorMap.Color);
        OuterTopLeft := GetHighlightColor(ColorMap.Color);
        OuterBottomRight := GetShadowColor(ColorMap.Color);
      end;
    ecBothLowered:
      begin
        InnerTopLeft := GetShadowColor(ColorMap.Color);
        InnerBottomRight := GetHighlightColor(ColorMap.Color);
        OuterTopLeft := GetShadowColor(ColorMap.Color);
        OuterBottomRight := GetHighlightColor(ColorMap.Color);
      end;
  else
    OuterTopLeft := ColorMap.Color;
    OuterBottomRight := ColorMap.Color;
    InnerTopLeft := ColorMap.Color;
    InnerBottomRight := ColorMap.Color;
  end;
  Windows.GetClientRect(Handle, RC);
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
  { Draw border in non-client area }
  OffsetRect(RW, -RW.Left, -RW.Top);
  OldHandle := Canvas.Handle;
  try
    Canvas.Handle := DC;
    Canvas.Pen.Width := 1;

    if (ebTop in EdgeBorders) or (ebLeft in EdgeBorders) and
       ((EdgeOuter in [esRaised, esLowered]) or
        (EdgeOuter = esNone) and (EdgeInner in [esRaised, esLowered])) then
    begin
      Canvas.Pen.Color := OuterTopLeft;
      if ebTop in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Right, RW.Top);
        Canvas.LineTo(RW.Left - 1, Rw.Top);
      end;
      if ebLeft in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Left, Rw.Top);
        Canvas.LineTo(RW.Left, RW.Bottom);
      end;
    end;

    if (ebTop in EdgeBorders) or (ebLeft in EdgeBorders) and
       ((EdgeOuter in [esRaised, esLowered]) and
        (EdgeInner in [esRaised, esLowered])) then
    begin
      Canvas.Pen.Color := InnerTopLeft;
      if ebTop in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Right - 1, RW.Top + 1);
        Canvas.LineTo(RW.Left + 1, Rw.Top + 1);
      end;
      if ebLeft in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Left + 1, Rw.Top + 1);
        Canvas.LineTo(RW.Left + 1, RW.Bottom - 2);
      end;
    end;

    if (ebBottom in EdgeBorders) or (ebRight in EdgeBorders) and
       ((EdgeOuter in [esRaised, esLowered]) or
        (EdgeOuter = esNone) and (EdgeInner in [esRaised, esLowered])) then
    begin
      Canvas.Pen.Color := OuterBottomRight;
      if ebRight in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Right - 1, RW.Top);
        Canvas.LineTo(RW.Right - 1, RW.Bottom - 1);
      end;
      if ebBottom in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Right - 1, RW.Bottom - 1);
        Canvas.LineTo(RW.Left - 1, RW.Bottom - 1);
      end;
    end;

    if (ebBottom in EdgeBorders) or (ebRight in EdgeBorders) and
       ((EdgeOuter in [esRaised, esLowered]) and
        (EdgeInner in [esRaised, esLowered])) then
    begin
      Canvas.Pen.Color := InnerBottomRight;
      if ebRight in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Right - 2, RW.Top + 1);
        Canvas.LineTo(RW.Right - 2, RW.Bottom - 2);
      end;
      if ebBottom in EdgeBorders then
      begin
        Canvas.MoveTo(RW.Right - 2, RW.Bottom - 2);
        Canvas.LineTo(RW.Left, RW.Bottom - 2);
      end;
    end;
  finally
    Canvas.Handle := OldHandle;
  end;
end;

procedure TCustomActionBar.CMWinINIChange(var Message: TMessage);
begin
  inherited;
  ColorMap.UpdateColors;
end;

function TCustomActionBar.GetPopupMenuClass: TCustomActionBarClass;
begin
  Result := TCustomActionPopupMenu;
end;

function TCustomActionBar.GetColorMap: TCustomActionBarColorMap;
begin
  Result := FColorMap;
  if not Assigned(Result) then
  begin
    SetupDefaultColorMap;
    Result := FDefaultColorMap;
  end;
  Color := Result.Color;
end;

procedure TCustomActionBar.CMMouseLeave(var Message: TMessage);
var
  Msg: TMessage;
begin
  inherited;
  if DesignMode then
  begin
    Msg.Msg := CM_ITEMDROPPOINT;
    Msg.WParam := 0;
    Msg.LParam := 0;
    Msg.Result := 0;
    Broadcast(Msg);
  end;
end;

function TCustomActionBar.DesignWndProc(var Message: TMessage): Boolean;
begin
  Result := False;
  case Message.Msg of
    CM_MOUSELEAVE:
      if Mouse.IsDragging then
      begin
        Dispatch(Message);
        Result := True;
      end;
  end;
end;

function TCustomActionBar.Style: TActionBarStyle;
begin
  if Assigned(ActionManager) and Assigned(ActionManager.Style) then
    Result := ActionManager.Style
  else
    Result := ActionBarStyles.Style[0];
end;

{ TCustomActionControl }

constructor TCustomActionControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDesignInteractive];
  Height := 22;
  Width := 22;
  FGlyphLayout := blGlyphLeft;
  ParentShowHint := True;
  FMargins := Rect(4,4,4,4);
  FTransparent := False;
end;

destructor TCustomActionControl.Destroy;
begin
  if Assigned(FActionClient) and (FActionClient.Control = Self) then
    FActionClient.FControl := nil;
  inherited Destroy;
end;

procedure TCustomActionControl.BeginAutoDrag;
begin
  SetSelected(True);
  BeginDrag(False, Mouse.DragThreshold);
end;

function TCustomActionControl.CaptionLength: Integer;
begin
  if Assigned(ActionClient) and ShowCaption or not HasGlyph or
     (ActionClient.ActionClients.CaptionOptions = coAll) then
    Result := FTextBounds.Right - FTextBounds.Left
  else
    Result := 0;
end;

function TCustomActionControl.CaptionHeight: Integer;
begin
  if Assigned(ActionClient) and ShowCaption or not HasGlyph or
     (ActionClient.ActionClients.CaptionOptions = coAll) then
    Result := FTextBounds.Bottom - FTextBounds.Top
  else
    Result := 0;
end;

function TCustomActionControl.ActualSpacing(ImageSize: TPoint): Integer;
begin
  // Assumes that if the CaptionLength = 0 then CaptionHeight would also = 0
  if (ImageSize.X = 0) or (CaptionLength = 0) then
    Result := 0
  else
    Result := FSpacing;
end;

procedure TCustomActionControl.CalcLayout;
var
  AWidth: Integer;
  AHeight: Integer;
  ImageSize: TPoint;
begin
  if ActionClient = nil then exit;
  ImageSize := GetImageSize;
  Canvas.Font.Assign(Font);
  UpdateTextBounds;
  AWidth := Width;
  AHeight := Height;
  case GlyphLayout of
    blGlyphRight,
    blGlyphLeft:
      if GlyphLayout = blGlyphLeft then
      begin
        FGlyphPos := Point(FMargins.Left, AHeight div 2 - ImageSize.Y div 2);
        OffsetRect(FTextBounds, FMargins.Left + ImageSize.X + ActualSpacing(ImageSize),
          AHeight div 2 - CaptionHeight div 2);
      end
      else
      begin
        FGlyphPos := Point(AWidth - FMargins.Right - ImageSize.X,
          AHeight div 2 - ImageSize.Y div 2);
        OffsetRect(FTextBounds, FMargins.Left, AHeight div 2 - CaptionHeight div 2);
      end;
    blGlyphTop,
    blGlyphBottom:
      if GlyphLayout = blGlyphTop then
      begin
        if ShowCaption then
          FGlyphPos := Point(AWidth div 2 - ImageSize.X div 2, FMargins.Top)
        else
          FGlyphPos := Point(AWidth div 2 - ImageSize.X div 2,
            AHeight div 2 - ImageSize.Y div 2);
          OffsetRect(FTextBounds, AWidth div 2 - CaptionLength div 2,
            FGlyphPos.Y + ImageSize.Y + FSpacing);
      end
      else
      begin
        OffsetRect(FTextBounds, AWidth div 2 - CaptionLength div 2, FMargins.Top);
        FGlyphPos := Point(AWidth div 2 - ImageSize.X div 2, FTextBounds.Top +
          CaptionHeight + ActualSpacing(ImageSize));
      end;
  end;
end;

procedure TCustomActionControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if ActionClient <> nil then
    CalcBounds;
end;

procedure TCustomActionControl.Click;
begin
  if Assigned(ActionClient) and Assigned(ActionClient.ActionLink) then
  begin
    if not ActionBar.DesignMode then
      ResetUsageData;
    Repaint;
    if not ActionBar.DesignMode then
      ActionClient.ActionLink.Execute(Self);
  end;
end;

function TCustomActionControl.DesignWndProc(var Message: TMessage): Boolean;
begin
  Result := False;
  case Message.Msg of
    WM_CONTEXTMENU,
    WM_RBUTTONDOWN,
    WM_RBUTTONUP:
      if Assigned(ActionClient) and Assigned(ActionClient.FContextItems) then
        Result := True;
    CM_MOUSELEAVE,
    CM_MOUSEENTER,
    CM_DRAG,
    WM_LBUTTONUP,
    WM_LBUTTONDOWN,
    WM_MOUSEMOVE:
      begin
        Dispatch(Message);
        Result := True;
      end;
    WM_LBUTTONDBLCLK:
      begin
        if Assigned(ActionClient) and Assigned(ActionClient.Action) then
          ActionBarDesigner.EditAction(ActionClient.Action);
        Result := True;
      end;
  end;
end;

procedure TCustomActionControl.DrawBackground(var PaintRect: TRect);
const
  BrushStyle: array[Boolean] of TBrushStyle = (bsSolid, bsClear);
var
  ARect: TRect;
begin
  if not Selected and Assigned(ActionBar) and Assigned(ActionClient) and
     (ActionBar.ParentBackground = True) and
     (not ActionBar.ActionClient.HasBackground or
     (ActionBar.ActionClient.HasBackground and
     not (ActionBar.ActionClient.BackgroundLayout in [blLeftBanner, blRightBanner]))) and
     ThemeServices.ThemesEnabled and (Canvas.Brush.Color = ActionBar.ColorMap.Color) and
     (csParentBackground in ControlStyle) then
  begin
    ARect := BoundsRect;
    ThemeServices.DrawParentBackground(ActionBar.Handle, Canvas.Handle, nil, Transparent, @ARect);
    Canvas.Font.Handle := 0;  // Hack: reset the font because it gets destroyed
    Canvas.Font.Assign(Font);
  end
  else
  begin
    if Canvas.Brush.Bitmap = nil then
      Canvas.Brush.Style := BrushStyle[FTransparent and not FSelected];
    Canvas.FillRect(PaintRect);
  end;
end;

procedure TCustomActionControl.DrawGlyph(const Location: TPoint);
var
  ImageList: TCustomImageList;
  DrawEnabled: Boolean;
begin
  if not HasGlyph then exit;
  if Assigned(Action) then
    ImageList := ActionClient.Action.ActionList.Images
  else
    ImageList := ActionClient.OwningCollection.ActionManager.Images;
  if not Assigned(ImageList) then exit;
  DrawEnabled := Enabled and (ActionClient.ImageIndex <> -1) or
    (csDesigning in ComponentState);
  ImageList.Draw(Canvas, Location.X, Location.Y, ActionClient.ImageIndex,
    dsTransparent, itImage, DrawEnabled);
end;

procedure TCustomActionControl.DrawLargeGlyph(Location: TPoint);
var
  FgBmp, BgBmp: TBitmap;
  ImageSize: TPoint;
  ImageList: TCustomImageList;
begin
  if not HasGlyph then exit;
  if not (Action is TCustomAction) then exit;
  ImageList := ActionClient.OwningCollection.ActionManager.Images;
  ImageSize := Point(32,32);
  BgBmp := TBitmap.Create;
  try
    FgBmp := TBitmap.Create;
    try
      BgBmp.Width := ImageList.Width;
      BgBmp.Height := ImageList.Height;
      BgBmp.Canvas.Brush.Color := clWhite;
      if Enabled then
        BgBmp.Canvas.CopyRect(Rect(0,0, BgBmp.Width, BgBmp.Height), Canvas, BgBmp.Canvas.ClipRect)
      else
        BgBmp.Canvas.FillRect(FgBmp.Canvas.ClipRect);
      ImageList_DrawEx(ImageList.Handle, TCustomAction(Action).ImageIndex,
        BgBmp.Canvas.Handle, 0, 0, 0, 0, CLR_NONE, CLR_NONE, ILD_TRANSPARENT);
      FgBmp.Width := ImageSize.X;
      FgBmp.Height := ImageSize.Y;
      FgBmp.Canvas.StretchDraw(Rect(0, 0, ImageSize.X, ImageSize.Y), BgBmp);
      FgBmp.TransparentColor := clWhite;
      FgBmp.Transparent := True;
      BgBmp.Width := ImageSize.X;
      BgBmp.Height := ImageSize.Y;
      BgBmp.Canvas.Brush.Color := Canvas.Brush.Color;
      BgBmp.Canvas.FillRect(BgBmp.Canvas.ClipRect);
      BgBmp.Canvas.Draw(0, 0, FgBmp);
      if Enabled or (csDesigning in ComponentState) then
      begin
        with Location do
          if ActionClient.ParentItem.HasBackground then
            Canvas.StretchDraw(Rect(X, Y, X + ImageSize.X, Y + ImageSize.Y), FgBmp)
          else
            Canvas.StretchDraw(Rect(X, Y, X + ImageSize.X, Y + ImageSize.Y), BgBmp);
      end
      else
        DrawState(Canvas.Handle, Canvas.Brush.Handle, nil, FgBmp.Handle, 0,
          Location.X, Location.Y, 0, 0, DST_BITMAP or DSS_DISABLED)
    finally
      FgBmp.Free;
    end;
  finally
    BgBmp.Free;
  end;
end;

procedure TCustomActionControl.DrawSeparator(const Offset: Integer);
var
  StartPos: TPoint;
  EndPos: TPoint;
begin
  if ActionBar = nil then exit;
  if ActionBar.Orientation in [boLeftToRight, boRightToLeft] then
  begin     // Vertical bar
    StartPos := Point(ClientWidth div 2, Offset - 1);
    EndPos := Point(ClientWidth div 2, ClientHeight - Offset + 1);
  end
  else
  begin     // Horizontal bar
    StartPos := Point(Offset, ClientHeight div 2);
    EndPos := Point(Width - Offset, ClientHeight div 2);
  end;
  with Canvas do
  begin
    Pen.Width := 1;
    if FSelected and (csDesigning in ComponentState) then
      FillRect(ClientRect);
    if Assigned(ActionClient) and ActionClient.Unused then
      Pen.Color := GetShadowColor(ActionBar.ColorMap.HighlightColor)
    else
      if Color = clBtnFace then
        Pen.Color := clBtnShadow
      else
        Pen.Color := GetShadowColor(Color);
    MoveTo(StartPos.X, StartPos.Y);
    LineTo(EndPos.X, EndPos.Y);
    if Assigned(ActionClient) and ActionClient.Unused then
    begin
      if Color = clBtnFace then
        Pen.Color := clBtnHighLight
      else
        Pen.Color := GetHighLightColor(ActionBar.ColorMap.HighlightColor)
    end
    else
      if Color = clBtnFace then
        Pen.Color := clBtnHighLight
      else
        Pen.Color := ActionBar.ColorMap.HighlightColor;
    if StartPos.X = EndPos.X then
    begin
      MoveTo(StartPos.X + 1, StartPos.Y);
      LineTo(StartPos.X + 1, EndPos.Y);
    end
    else
    begin
      MoveTo(StartPos.X, StartPos.Y + 1);
      LineTo(EndPos.X, EndPos.Y + 1);
    end;
  end;
end;

procedure TCustomActionControl.DrawText(var ARect: TRect; var Flags: Cardinal;
  Text: string);
begin
  Windows.DrawText(Canvas.Handle, PChar(Text), Length(Text), ARect, Flags);
end;

procedure TCustomActionControl.DrawShadowedText(Rect: TRect;
  Flags: Cardinal; Text: string; TextColor, ShadowColor: TColor);
begin
  OffsetRect(Rect, 1, 1);
  Canvas.Font.Color := ShadowColor;
  Windows.DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  OffsetRect(Rect, -1, -1);
  Canvas.Font.Color := TextColor;
  Windows.DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
end;

function TCustomActionControl.IsGrouped: Boolean;
begin
  Result := (Action is TCustomAction) and (TCustomAction(Action).GroupIndex > 0);
end;

procedure TCustomActionControl.Paint;
const
  BrushStyle: array[Boolean] of TBrushStyle = (bsSolid, bsClear);
var
  PaintRect: TRect;
  TextRect: TRect;
  Flags: Cardinal;
begin
  PaintRect := ClientRect;

  if csDesigning in ComponentState then
    Canvas.Brush.Style := BrushStyle[FTransparent]
  else
    Canvas.Brush.Style := BrushStyle[FTransparent and not FSelected];

  if Assigned(ActionClient) and (ActionClient.Color <> clDefault) then
    Canvas.Brush.Color := ActionClient.Color
  else
    Canvas.Brush.Color := ActionBar.ColorMap.Color;

  DrawBackground(PaintRect);
  if Separator then
    DrawSeparator(2)
  else
  begin
    if ActionBar.HasItems then
      if ActionBar.Items.SmallIcons then
        DrawGlyph(FGlyphPos)
      else
        DrawLargeGlyph(FGlyphPos);
    if ShowCaption or not HasGlyph then
    begin
      Flags := DrawTextBiDiModeFlags(DT_LEFT) or DT_NOCLIP;
      TextRect := FTextBounds;
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Color := ActionBar.ColorMap.FontColor;
      // Hack: Themes delete the font so it must be reassigned
      // Occurs when there is a gradient background on the ActionBand
      if ThemeServices.ThemesEnabled then
        Canvas.Font.Assign(Self.Font);
      if not ActionBar.DesignMode then
        if Enabled or (not Enabled and Selected) then
        begin
          if Selected then
            Canvas.Font.Color := ActionBar.ColorMap.SelectedFontColor;
          if not Enabled then
            Canvas.Font.Color := ActionBar.ColorMap.DisabledFontColor;
        end;
      if ActionBar.DesignMode or (Enabled or (not Enabled and Selected)) then
        DrawText(TextRect, Flags, Caption)
      else
        DrawShadowedText(TextRect, Flags, Caption, ActionBar.ColorMap.DisabledFontColor,
          ActionBar.ColorMap.DisabledFontShadow)
    end;
  end;

  if FSelected and Assigned(ActionBar) and ActionBar.DesignMode then
  begin
    PaintRect := ClientRect;
    OffSetRect(PaintRect, 1, 1);
    Dec(PaintRect.Right);
    Dec(PaintRect.Bottom);
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := ActionBar.ColorMap.DesignFocus;
    Canvas.pen.Width := 2;
    if not Mouse.IsDragging then
      DrawDesignFocus(PaintRect);
  end;
  if DropPoint then
    DrawDragDropPoint;
end;

procedure TCustomActionControl.PositionChanged;
begin
  RequestAlign;
end;

procedure TCustomActionControl.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

function TCustomActionControl.GetImageSize: TPoint;
begin
  Result := Point(0,0);
  if not HasGlyph or not ActionClient.ShowGlyph then exit;
  if ActionClient.ActionClients.SmallIcons then
  begin
    if Assigned(ActionClient.Action) then
    begin
      if Assigned(ActionClient.Action.ActionList) and
         Assigned(ActionClient.Action.ActionList.Images) then
        with ActionClient.Action.ActionList.Images do
          Result := Point(Width, Height);
    end
    else if Assigned(ActionClient.OwningCollection.ActionManager.Images) then
      with ActionClient.OwningCollection.ActionManager.Images do
        Result := Point(Width, Height);
  end
  else
    Result := Point(32, 32);
end;

procedure TCustomActionControl.SetActionClient(Value: TActionClientItem);
begin
  if FActionClient <> Value then
  begin
    if Assigned(FActionClient) then
      FActionClient.ActionBar := nil;
    FActionClient := Value;
    if Assigned(Action) then
      ControlStyle := ControlStyle + [csActionClient];
    if Value = nil then exit;
    case FActionClient.Color of
      clNone:
        begin
          Transparent := True;
          ParentColor := True;
        end;
      clDefault:
        ParentColor := True;
      else
        if FActionClient.Color = clDefault then
          ParentColor := True
        else
          Color := FActionClient.Color;
    end;
    Visible := Value.Visible;
    Caption := FActionClient.Caption
  end;
end;

procedure TCustomActionControl.SetSelected(Value: Boolean);
begin
  if (Value <> FSelected) then
  begin
    FSelected := Value;
    if Value then
      UpdateSelection;
    Invalidate;
    if Value then
      if Assigned(ActionClient.Action) then
        Application.Hint := GetLongHint(TCustomAction(ActionClient.Action).Hint)
      else
        Application.CancelHint;
    if Value then
      NotifyWinEvent(EVENT_OBJECT_FOCUS, Parent.Handle, OBJID_CLIENT, ActionClient.Index + 1);
  end;
end;

procedure TCustomActionControl.UpdateSelection;
var
  Msg: TMessage;
begin
  // MenuItems can be selected but they don't have to be enabled
  if Parent <> nil then
  begin
    Msg.Msg := CM_ITEMSELECTED;
    Msg.WParam := 0;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

procedure TCustomActionControl.CMItemSelected(var Message: TCMItemMsg);
begin
  Selected := Message.Sender = Self;
{  if Message.Sender <> Self then
    if Message.Sender.Selected and FSelected then
      Selected := False;}
  if Selected and ActionBar.Designable and Assigned(ActionBarDesigner) then
    ActionBarDesigner.SetSelection(FActionClient);
end;

procedure TCustomActionControl.SetMargins(Value: TRect);
begin
  if (Value.Left <> FMargins.Left) or (Value.Top <> FMargins.Bottom) or
     (Value.Right <> FMargins.Right) or (Value.Bottom <> FMargins.Bottom) then
  begin
    FMargins := Value;
    CalcBounds;
  end;
end;

procedure TCustomActionControl.SetSpacing(const Value: Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    if Assigned(ActionBar) and ActionBar.AlignDisabled then
      CalcBounds;
  end;
end;

procedure TCustomActionControl.SetGlyphLayout(const Value: TButtonLayout);
var
  PaintRect: TRect;
  Offset: TPoint;
begin
  if FGlyphLayout <> Value then
  begin
    PaintRect := Rect(0, 0, Width, Height);
    Offset.X := 0;
    Offset.Y := 0;
    FGlyphLayout := Value;
    { Recalculate the Width/Height of the control }
    CalcBounds;
    RequestAlign;
    Invalidate;
  end;
end;

procedure TCustomActionControl.Keyed;
begin
  ResetUsageData;
  if Assigned(Parent) then
    PostMessage(Parent.Handle, CM_ITEMKEYED, 0, LongInt(Self));
end;

procedure TCustomActionControl.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := 1;
end;

procedure TCustomActionControl.CMHintShow(var Message: TCMHintShow);
begin
  if Assigned(ActionClient) and Assigned(ActionClient.ActionLink) and
     not ActionClient.ActionLink.DoShowHint(TCMHintShow(Message).HintInfo^.HintStr) then
    Message.Result := 1;
end;

procedure TCustomActionControl.DrawDesignFocus(var PaintRect: TRect);
begin
  Canvas.Rectangle(PaintRect);
end;

procedure TCustomActionControl.ResetUsageData;
begin
  if (csDesigning in ComponentState) or Assigned(ActionBar) and
     ActionBar.DesignMode then
    exit;
  if Assigned(ActionClient) and not ActionClient.HasItems then
    if Enabled and Assigned(FActionClient) then
      FActionClient.ResetUsageData;
end;

procedure TCustomActionControl.DragDrop(Source: TObject; X, Y: Integer);
begin
  inherited DragDrop(Source, X, Y);
  DoDragDrop(Source, X, Y);
end;

procedure TCustomActionControl.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  AnItem: TActionClientItem;
begin
  inherited DragOver(Source, X, Y, State, Accept);
  Accept := Assigned(FActionClient) and ActionBar.Designable and ((Source is TActionDragObject) or
    (Source is TActionItemDragObject) or (Source is TCategoryDragObject));
  if Accept and (Source is TActionItemDragObject) then
    with Source as TActionItemDragObject do
    begin
      Accept := not Assigned(ClientItem);
      if not Accept and (ClientItem <> Self.ActionClient) then
        Accept := not ActionClient.IsChildItem(ClientItem);
    end;
  if Accept and (State in [dsDragEnter, dsDragMove]) then
  begin
    AnItem := nil;
    case ActionBar.Orientation of
      boLeftToRight:
        if X > Width div 2 then
          AnItem := ActionBar.FindNextVisibleItem(ActionClient);
      boRightToLeft:
        if X < Width div 2 then
          AnItem := ActionBar.FindPreviousVisibleItem(ActionClient);
      boTopToBottom:
        if Y > Height div 2 then
          AnItem := ActionBar.FindNextVisibleItem(ActionClient);
      boBottomToTop:
        if Y < Height div 2 then
          AnItem := ActionBar.FindPreviousVisibleItem(ActionClient);
    end;
    if (AnItem = nil) then
      AnItem := ActionClient;
    AnItem.Control.DropPoint := True;
  end;
end;

procedure TCustomActionControl.DrawDragDropPoint;
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Color := ActionBar.ColorMap.DesignFocus;
  case ActionBar.Orientation of
    boLeftToRight, boRightToLeft:
      begin
        PatBlt(Canvas.Handle, 0, 0, 6, 2, PATINVERT);
        PatBlt(Canvas.Handle, 2, 2, 2, ClientHeight - 4, PATINVERT);
        PatBlt(Canvas.Handle, 0, ClientHeight - 2, 6, ClientHeight, PATINVERT);
      end;
    boTopToBottom, boBottomToTop:
      begin
        PatBlt(Canvas.Handle, 0, 0, 2, 6, PATINVERT);
        PatBlt(Canvas.Handle, 2, 2, ClientWidth - 6, 2, PATINVERT);
        PatBlt(Canvas.Handle, ClientWidth - 4, 0, 2, 6, PATINVERT);
      end;
  end;
end;

procedure TCustomActionControl.DoStartDrag(var DragObject: TDragObject);
begin
  DragObject := TActionItemDragObject.Create;
  TActionItemDragObject(DragObject).FClientItem := ActionClient;
  TActionItemDragObject(DragObject).ActionManager := ActionClient.ActionClients.ActionManager;  
  inherited DoStartDrag(DragObject);
end;

function TCustomActionControl.HasGlyph: Boolean;
begin
  Result := False;
  if Assigned(FActionClient) then
    Result := FActionClient.HasGlyph and FActionClient.ShowGlyph;
end;

procedure TCustomActionControl.WMSetText(var Message: TWMSetText);
begin
  inherited;
  if Assigned(FActionBar) then
    FActionBar.Resize;
end;

function TCustomActionControl.GetSeparator: Boolean;
begin
  Result := False;
  if Assigned(ActionClient) then
    Result := ActionClient.Separator;
end;

function TCustomActionControl.GetShowCaption: Boolean;
begin
  Result := True;
  if Assigned(FActionClient) then
    case FActionClient.ActionClients.CaptionOptions of
      coNone: Result := False;
      coSelective: Result := FActionClient.ShowCaption;
      coAll: Result := True;
    end;
end;

function TCustomActionControl.GetShowShortCut: Boolean;
begin
  Result := False;
  if Assigned(FActionClient) then
    Result := FActionClient.ShowShortCut and (FActionClient.ShortCut <> 0);
end;

function TCustomActionControl.IsChecked: Boolean;
begin
  Result := False;
  if Assigned(ActionClient) and (ActionClient.Action is TCustomAction) then
    Result := TCustomAction(ActionClient.Action).Checked;
end;

function TCustomActionControl.GetAction: TBasicAction;
begin
  if Assigned(FActionClient) then
    Result := FActionClient.Action
  else
    Result := nil;
end;

procedure TCustomActionControl.InitiateAction;
begin
  if Assigned(FActionClient) then
    FActionClient.InitiateAction;
end;

function TCustomActionControl.GetActionBar: TCustomActionBar;
begin
  Result := Parent as TCustomActionBar;
end;

procedure TCustomActionControl.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(ActionBar) then
    CalcBounds;
end;

procedure TCustomActionControl.UpdateTextBounds;
begin
  FTextBounds := Rect(0,0,0,0);
  if Assigned(ActionClient) then
    Windows.DrawText(Canvas.Handle, PChar(ActionClient.Caption), -1, FTextBounds,
      DT_CALCRECT)
  else
    Windows.DrawText(Canvas.Handle, PChar(Caption), -1, FTextBounds, DT_CALCRECT)
end;

procedure TCustomActionControl.CalcBounds;
var
  AWidth: Integer;
  AHeight: Integer;
  ImageSize: TPoint;
begin
  if ActionClient = nil then exit;
  ImageSize := GetImageSize;
  Canvas.Font.Assign(Font);
  UpdateTextBounds;
  AWidth := Width;
  AHeight := Height;
  case GlyphLayout of
    blGlyphRight,
    blGlyphLeft:
      begin
        AWidth := Margins.Left + ImageSize.X + ActualSpacing(ImageSize) + CaptionLength +
          Margins.Right;
        AHeight := Margins.Top + Max(ImageSize.Y, CaptionHeight) +
          Margins.Bottom;
      end;
    blGlyphTop,
    blGlyphBottom:
      begin
        AWidth := Margins.Left + ImageSize.X + CaptionLength + Margins.Right;
        AHeight := Margins.Top + ImageSize.Y + ActualSpacing(ImageSize) + CaptionHeight +
          Margins.Bottom;
      end;
  end;
  if (AWidth <> Width) or (AHeight <> Height) then
  begin
    SetBounds(Left, Top, AWidth, AHeight);
    CalcLayout;
    RequestAlign;
  end;
end;

procedure TCustomActionControl.DoDragDrop(DragObject: TObject;
  X, Y: Integer);
var
  Idx: Integer;
  I: Integer;
  NewItem: TActionClientItem;
  Msg: TMessage;
begin
  Idx := 0;
  if Assigned(ActionClient) then
    for I := 0 to ActionClient.ActionClients.Count - 1 do
      if Assigned(ActionClient.ActionClients[I].Control) and
         ActionClient.ActionClients[I].Control.FDropPoint then
      begin
        Idx := I;
        break;
      end;

  if DragObject is TActionDragObject then
  begin
    ActionBar.DisableAlign;
    ActionBar.Items.BeginUpdate;
    try
      with DragObject as TActionDragObject do
        for I := 0 to ActionCount - 1 do
        begin
          NewItem := TActionClientItem(ActionBar.Items.Insert(Idx));
          NewItem.LastSession := ActionBar.ActionManager.ActionBars.SessionCount;
          NewItem.Action := Actions[I];
          NewItem.Index := Idx;
        end;
    finally
      ActionBar.Items.EndUpdate;
      ActionBar.EnableAlign;
    end;
  end
  else if DragObject is TActionItemDragObject then
    with DragObject as TActionItemDragObject do
    begin
      if ClientItem.Collection <> Self.ActionClient.ActionClients then
      begin
        ClientItem.Collection := Self.ActionClient.ActionClients;
        ClientItem.Index := idx;
        ClientItem.LastSession := ActionBar.ActionManager.ActionBars.SessionCount;
      end
      else
      begin
        if ClientItem.Index < ActionClient.Index then
          Dec(Idx);
        ClientItem.Index := idx;
        if ActionBar.Designable and Assigned(ActionBarDesigner) then
          ActionBarDesigner.SetSelection(ClientItem);
      end;
    end;
  NotifyDesigner(ActionBar);
  Msg.Msg := CM_ITEMDROPPOINT;
  Msg.WParam := 0;
  Msg.LParam := 0;
  Msg.Result := 0;
  Parent.Broadcast(Msg);
end;

procedure TCustomActionControl.SetSmallIcon(const Value: Boolean);
begin
  if FSmallIcon <> Value then
  begin
    FSmallIcon := Value;
    CalcBounds;
    RequestAlign;
  end;
end;

procedure TCustomActionControl.WMContextMenu(var Message: TWMContextMenu);
var
  PopupMenu: TCustomActionPopupMenu;
begin
  inherited;
  if Assigned(ActionClient) and (ActionClient.ContextItems.Count > 0) then
  begin
    PopupMenu := ActionBar.GetPopupMenuClass.Create(Owner) as TCustomActionPopupMenu;
    PopupMenu.ContextBar := True;
    PopupMenu.Parent := Parent;
    PopupMenu.ActionClient := ActionClient;
    PopupMenu.Popup(Message.XPos, Message.YPos);
    PopupMenu.Free;
  end;
end;

procedure TCustomActionControl.SetDropPoint(Value: Boolean);
var
  Msg: TMessage;
begin
  if (Value <> FDropPoint) then
  begin
    FDropPoint := Value;
    if Value and (Parent <> nil) then
    begin
      Msg.Msg := CM_ITEMDROPPOINT;
      Msg.WParam := 0;
      Msg.LParam := Longint(Self);
      Msg.Result := 0;
      Parent.Broadcast(Msg);
    end;
    Invalidate;
  end;
end;

procedure TCustomActionControl.CMItemDropPoint(var Message: TCMItemMsg);
begin
  if (Message.Sender <> Self) and DropPoint then
    DropPoint := False;
end;

{ TActionBarStyleList }

function TActionBarStyleList.GetStyle(Index: Integer): TActionBarStyle;
begin
  if not Assigned(ActionBarStyles) then
    raise Exception.Create(SActionBarStyleMissing);
  Result := ActionBarStyles.Objects[Index] as TActionBarStyle;
end;

initialization
  ActionBarStyles := nil;
  GroupDescendentsWith(TCustomActionBarColorMap, TControl);
  GroupDescendentsWith(TActionClient, TControl);
end.
