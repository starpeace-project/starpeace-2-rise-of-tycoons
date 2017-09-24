{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit CategoryButtons;

interface

uses
  Windows, SysUtils, Classes, Controls, ImgList, Forms, Messages,
  Graphics, StdCtrls, GraphUtil, ActnList;

const
  crDragCopy = TCursor(-23); { New cursor, with a plus for copying }

type
  TBaseButtonItem = class;
  TBaseButtonItemClass = class of TBaseButtonItem;
  TButtonItem = class;
  TButtonItemClass = class of TButtonItem;
  TButtonCategory = class;
  TButtonCategoryClass = class of TButtonCategory;
  TButtonCategories = class;
  TButtonCategoriesClass = class of TButtonCategories;
  TButtonItemActionLink = class;
  TButtonItemActionLinkClass = class of TButtonItemActionLink;

  { TButtonDrawState }
  {
    bdsSelected:    Item is selected and in the "down" state
    bdsHot:         Item has the mouse over it
    bdsFocused:     Item should show focus
    bdsDown:        Item is being pressed by the user
    bdsDragged:     The drag image for that button is being drawn
    bdsInsertLeft:  Show that an item can be inserted to the left of this item
    bdsInsertTop:   Show that an item can be inserted above this item
    bdsInsertRight: Show that an item can be inserted to the right of this item
    bdsInsertBottom: Show that an item can be inserted below this item
  }
  TButtonDrawState = set of (bdsSelected, bdsHot, bdsFocused, bdsDown, 
    bdsDragged, bdsInsertLeft, bdsInsertTop, bdsInsertRight, bdsInsertBottom);

  TCatButtonOptions = set of (boAllowReorder, boAllowCopyingButtons,
    boFullSize, boGradientFill, boShowCaptions, boVerticalCategoryCaptions,
    boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder);

  TCatButtonEvent = procedure(Sender: TObject; const Button: TButtonItem) of object;
  TCatButtonGetHint = procedure(Sender: TObject; const Button: TButtonItem;
    const Category: TButtonCategory; var HintStr: string; var Handled: Boolean) of object;
  
  TCatButtonDrawEvent = procedure(Sender: TObject;
    const Button: TButtonItem; Canvas: TCanvas; Rect: TRect;
    State: TButtonDrawState) of object;
  TCatButtonDrawIconEvent = procedure(Sender: TObject;
    const Button: TButtonItem; Canvas: TCanvas; Rect: TRect;
    State: TButtonDrawState; var TextOffset: Integer) of object;
  TCatButtonReorderEvent = procedure(Sender: TObject; const Button: TButtonItem;
    const SourceCategory, TargetCategory: TButtonCategory) of object;
  TCatButtonCopyEvent = procedure(Sender: TObject;
    const SourceButton, CopiedButton: TButtonItem) of object;
  TCategoryReorderEvent = procedure(Sender: TObject; const SourceCategory,
    TargetCategory: TButtonCategory) of object;
  TCategoryCollapseEvent = procedure(Sender: TObject;
    const Category: TButtonCategory) of object;

  TCatButtonFlow = (cbfVertical, cbfHorizontal);

  { Note: TCategoryButtons requires (Win98 | Win NT 4.0) or above }
  TCategoryButtons = class(TCustomControl)
  private
    FButtonFlow: TCatButtonFlow;
    FCollapsedHeight: Integer;
    FDownButton: TButtonItem;
    FDragButton: TButtonItem;
    FDragCategory: TButtonCategory;
    FDragStartPos: TPoint;
    FDragStarted: Boolean;
    FDragImageList: TDragImageList;
    FGradientDirection: TGradientDirection;
    FBackGradientDirection: TGradientDirection;
    FGutterSize: Integer; { Also, used as the scroll size }
    FSideBufferSize: Integer;
    FHotButton: TButtonItem;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FInsertLeft, FInsertTop, FInsertRight, FInsertBottom: TButtonItem;
    FIgnoreUpdate: Boolean;
    FScrollBarMax: Integer;
    FScrollBarPos: Integer;
    FPageAmount: Integer;
    FButtonCategories: TButtonCategories;
    FButtonOptions: TCatButtonOptions;
    FButtonWidth, FButtonHeight: Integer;
    FBorderStyle: TBorderStyle;
    FSelectedItem: TButtonItem;
    FFocusedItem: TButtonItem;
    FMouseInControl: Boolean;
    FBackgroundGradientColor: TColor;
    FOnButtonClicked: TCatButtonEvent;
    FOnCopyButton: TCatButtonCopyEvent;
    FOnSelectedItemChange: TCatButtonEvent;
    FOnHotButton: TCatButtonEvent;
    FOnGetHint: TCatButtonGetHint;
    FOnDrawIcon: TCatButtonDrawIconEvent;
    FOnDrawText: TCatButtonDrawEvent;
    FOnDrawButton: TCatButtonDrawEvent;
    FOnBeforeDrawButton: TCatButtonDrawEvent;
    FOnAfterDrawButton: TCatButtonDrawEvent;
    FOnReorderButton: TCatButtonReorderEvent;
    FOnReorderCategory: TCategoryReorderEvent;
    FOnCategoryCollapase: TCategoryCollapseEvent;
    FOnClick: TNotifyEvent;
    FScrollBarShown: Boolean;
    FHotButtonColor, FSelectedButtonColor, FRegularButtonColor: TColor;
    procedure AutoScroll(ScrollCode: TScrollCode);
    procedure ImageListChange(Sender: TObject);
    function CalcButtonsPerRow: Integer;
    function CalcButtonsPerCol: Integer;
    procedure CalcBufferSizes;
    function CalcCategoryHeight(const Category: TButtonCategory;
      const ButtonsPerRow: Integer): Integer;
    function CalcCategoryWidth(const Category: TButtonCategory;
      const ButtonsPerCol: Integer): Integer;
    procedure DrawCategory(const Category: TButtonCategory;
      const Canvas: TCanvas; StartingPos: Integer);
    procedure GetCategoryBounds(const Category: TButtonCategory;
      const StartingPos: Integer; var CategoryBounds,
      ButtonBounds: TRect);
    function GetChevronBounds(const CategoryBounds: TRect): TRect;
    function GetIndexOfFirstCategory: Integer;
    function GetNextButtonInGroup(const StartingButton: TButtonItem;
      GoForward: Boolean): TButtonItem;
    function GetNextButton(const StartingButton: TButtonItem;
      GoForward: Boolean): TButtonItem;
    function GetScrollOffset: Integer;
    function GetScrollBuffer: Integer;
    procedure ScrollPosChanged(ScrollCode: TScrollCode;
      ScrollPos: Integer);
    procedure SetOnDrawButton(const Value: TCatButtonDrawEvent);
    procedure SetOnDrawIcon(const Value: TCatButtonDrawIconEvent);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetButtonCategories(const Value: TButtonCategories);
    procedure SetButtonHeight(const Value: Integer);
    procedure SetCatButtonOptions(const Value: TCatButtonOptions);
    procedure SetButtonWidth(const Value: Integer);
    procedure SetFocusedItem(const Value: TButtonItem);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetSelectedItem(const Value: TButtonItem);
    procedure ShowScrollBar(const Visible: Boolean);
    procedure SetHotButtonColor(const Value: TColor);
    procedure SetRegularButtonColor(const Value: TColor);
    procedure SetSelectedButtonColor(const Value: TColor);
    procedure SetButtonFlow(const Value: TCatButtonFlow);
    function ShouldScrollDown(out Delay: Integer): Boolean;
    function ShouldScrollUp(out Delay: Integer): Boolean;
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CNKeydown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Message: TWMVScroll); message WM_HSCROLL;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure SetDragButton(const Value: TButtonItem);
    procedure SetBackgroundGradientColor(const Value: TColor);
    procedure SetBackGradientDirection(const Value: TGradientDirection);
  protected
    procedure BeginAutoDrag; override;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoBeginDrag(Immediate: Boolean; Threshold: Integer); virtual;
    procedure DoCopyButton(const Button: TButtonItem;
      const TargetCategory: TButtonCategory; const TargetButton: TButtonItem); dynamic;
    procedure DoEndDrag(Target: TObject; X: Integer; Y: Integer); override;
    procedure DoHotButton; dynamic;
    procedure DoReorderButton(const Button: TButtonItem;
      const TargetCategory: TButtonCategory; const TargetButton: TButtonItem); dynamic;
    procedure DoReorderCategory(const SourceCategory,
      TargetCategory: TButtonCategory); dynamic;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DrawButton(const Button: TButtonItem; Canvas: TCanvas;
      Rect: TRect; State: TButtonDrawState); virtual;
    procedure DoItemClicked(const Button: TButtonItem); dynamic;
    procedure DoSelectedItemChanged(const Button: TButtonItem); dynamic;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetAllowReorder: Boolean; dynamic;
    function GetDragImages: TDragImageList; override;
    function GetButtonCategoriesClass: TButtonCategoriesClass; virtual;
    function GetButtonCategoryClass: TButtonCategoryClass; virtual;
    function GetButtonItemClass: TButtonItemClass; virtual;
    function GetScrollPos: Integer;
    procedure SetScrollPos(const Value: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure ScrollRectIntoView(const Rect: TRect);
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    { DragButton: If a drag operation is coming from this control, it is
      becuase they are dragging this item, or the category. One can
      write to it if they want to control what button is being dragged. }
    property DragButton: TButtonItem read FDragButton write SetDragButton;
    property DragCategory: TButtonCategory read FDragCategory write FDragCategory;
    property DragImageList: TDragImageList read FDragImageList;
    procedure DragDrop(Source: TObject; X: Integer; Y: Integer); override;
    procedure GenerateDragImage;
    function GetButtonRect(const Button: TButtonItem): TRect;
    function GetCategoryRect(const Category: TButtonCategory): TRect;
    function GetButtonAt(X, Y: Integer;
      Category: TButtonCategory = nil): TButtonItem;
    function GetCategoryAt(X, Y: Integer): TButtonCategory;
    procedure RemoveInsertionPoints;
    procedure ScrollIntoView(const Button: TButtonItem); overload;
    procedure ScrollIntoView(const Category: TButtonCategory); overload;
    { SetInsertionButton: Call this to set the current insertion "marks".
      Call RemoveInsertionPoints to remove the "marks". }
    procedure SetInsertionButton(InsertionButton: TButtonItem;
      InsertionCategory: TButtonCategory);
    { GetTargetAt: Gives you the target insertion point in the given group.
      TargetButton may be nil, while the TargetCategory is not (or, both may be nil)}
    procedure GetTargetAt(X, Y: Integer; var TargetButton: TButtonItem;
      var TargetCategory: TButtonCategory);
    procedure UpdateButton(const Button: TButtonItem);
    procedure UpdateAllButtons;
    property SelectedItem: TButtonItem read FSelectedItem write SetSelectedItem;
    property FocusedItem: TButtonItem read FFocusedItem write SetFocusedItem;
  published
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ButtonFlow: TCatButtonFlow read FButtonFlow write SetButtonFlow;
    property ButtonHeight: Integer read FButtonHeight write SetButtonHeight default 24;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth default 24;
    property ButtonOptions: TCatButtonOptions read FButtonOptions
      write SetCatButtonOptions default [boGradientFill, boShowCaptions, boVerticalCategoryCaptions];
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Height default 100;
    property Images: TCustomImageList read FImages write SetImages;
    property BackgroundGradientColor: TColor read FBackgroundGradientColor write SetBackgroundGradientColor default clNone;
    property BackgroundGradientDirection: TGradientDirection read FBackGradientDirection write SetBackGradientDirection default gdHorizontal;
    property Categories: TButtonCategories read FButtonCategories write SetButtonCategories;
    property Color default clWindow;
    property Cursor;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default gdHorizontal;
    property HotButtonColor: TColor read FHotButtonColor write SetHotButtonColor default $00EFD3C6;
    property PopupMenu;
    property RegularButtonColor: TColor read FRegularButtonColor write SetRegularButtonColor nodefault;
    property SelectedButtonColor: TColor read FSelectedButtonColor write SetSelectedButtonColor nodefault;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Width default 100;
    property Visible;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnAfterDrawButton: TCatButtonDrawEvent read FOnAfterDrawButton write FOnAfterDrawButton;
    property OnBeforeDrawButton: TCatButtonDrawEvent read FOnBeforeDrawButton write FOnBeforeDrawButton;
    property OnButtonClicked: TCatButtonEvent read FOnButtonClicked write FOnButtonClicked;
    property OnCategoryCollapase: TCategoryCollapseEvent read FOnCategoryCollapase write FOnCategoryCollapase;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnContextPopup;
    property OnCopyButton: TCatButtonCopyEvent read FOnCopyButton write FOnCopyButton;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawButton: TCatButtonDrawEvent read FOnDrawButton write SetOnDrawButton;
    property OnDrawIcon: TCatButtonDrawIconEvent read FOnDrawIcon write SetOnDrawIcon;
    property OnDrawText: TCatButtonDrawEvent read FOnDrawText write FOnDrawText;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetHint: TCatButtonGetHint read FOnGetHint write FOnGetHint;
    property OnHotButton: TCatButtonEvent read FOnHotButton write FOnHotButton;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnReorderButton: TCatButtonReorderEvent read FOnReorderButton write FOnReorderButton;
    property OnReorderCategory: TCategoryReorderEvent read FOnReorderCategory write FOnReorderCategory;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnSelectedItemChange: TCatButtonEvent read FOnSelectedItemChange write FOnSelectedItemChange;
    property OnStartDock;
    property OnStartDrag;
  end;

  TBaseButtonItem = class(TCollectionItem)
  private
    FActionLink: TButtonItemActionLink;
    FImageIndex: TImageIndex;
    FCaption: string;
    FData: Pointer;
    FHint: string;
    FOnClick: TNotifyEvent;
    procedure SetAction(const Value: TBasicAction);
    procedure SetCaption(const Value: string);
    procedure SetImageIndex(const Value: TImageIndex);
    function GetAction: TBasicAction;
    procedure DoActionChange(Sender: TObject);
    function IsCaptionStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); virtual;
    function GetNotifyTarget: TComponent; virtual; abstract;
    function GetDisplayName: string; override;
    function GetActionLinkClass: TButtonItemActionLinkClass; virtual;
    property ActionLink: TButtonItemActionLink read FActionLink write FActionLink;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Data: Pointer read FData write FData;
    procedure ScrollIntoView; virtual; abstract;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption: string read FCaption write SetCaption stored IsCaptionStored;
    property Hint: string read FHint write FHint stored IsHintStored;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored;
    property OnClick: TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
  end;

  TButtonItem = class(TBaseButtonItem)
  private
    FInterfaceData: IInterface;
    function GetButtonGroup: TCategoryButtons;
    function GetCategory: TButtonCategory;
  protected
    function GetNotifyTarget: TComponent; override;
  public
    procedure Assign(Source: TPersistent); override;
    property InterfaceData: IInterface read FInterfaceData write FInterfaceData;
    procedure ScrollIntoView; override;
    property Category: TButtonCategory read GetCategory;
  published
    property ButtonGroup: TCategoryButtons read GetButtonGroup;
  end;

  TButtonCollection = class(TCollection)
  private
    FCategory: TButtonCategory;
    function GetItem(Index: Integer): TButtonItem;
    procedure SetItem(Index: Integer; const Value: TButtonItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure Notify(Item: TCollectionItem;
      Action: TCollectionNotification); override;
  public
    constructor Create(const ACategory: TButtonCategory);
    function Add: TButtonItem;
    function AddItem(Item: TButtonItem; Index: Integer): TButtonItem;
    function Insert(Index: Integer): TButtonItem;
    property Items[Index: Integer]: TButtonItem read GetItem write SetItem; default;
    property Category: TButtonCategory read FCategory;
  end;

  TButtonCategory = class(TCollectionItem)
  private
    FCaption: string;
    FCollapsed: Boolean;
    FColor: TColor;
    FGradientColor: TColor;
    FTextColor: TColor;
    FItems: TButtonCollection;
    { Information for caching drawing state }
    FStart: Integer; 
    FEnd: Integer;
    FData: Pointer;
    FInterfaceData: IInterface;
    function GetCategories: TButtonCategories;
    procedure SetItems(const Value: TButtonCollection);
    procedure SetCollapsed(const Value: Boolean);
    procedure SetCaption(const Value: string);
    procedure SetColor(const Value: TColor);
    procedure SetGradientColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
  protected
    procedure SetIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure ScrollIntoView;
    function IndexOf(const Caption: string): Integer;
    property Categories: TButtonCategories read GetCategories;
    property Data: Pointer read FData write FData;
    property InterfaceData: IInterface read FInterfaceData write FInterfaceData;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: string read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor;
    property Collapsed: Boolean read FCollapsed write SetCollapsed;
    property GradientColor: TColor read FGradientColor write SetGradientColor default clNone;
    property Items: TButtonCollection read FItems write SetItems;
    property TextColor: TColor read FTextColor write SetTextColor default clWindowText;
  end;

  TButtonCategories = class(TCollection)
  private
    FButtonGroup: TCategoryButtons;
    FOriginalID: Integer;
    function GetItem(Index: Integer): TButtonCategory;
    procedure SetItem(Index: Integer; const Value: TButtonCategory);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(const ButtonGroup: TCategoryButtons);
    function Add: TButtonCategory;
    function AddItem(Item: TButtonCategory; Index: Integer): TButtonCategory;
    procedure BeginUpdate; override;
    function Insert(Index: Integer): TButtonCategory;
    function IndexOf(const Caption: string): Integer;
    property Items[Index: Integer]: TButtonCategory read GetItem write SetItem; default;
    property ButtonGroup: TCategoryButtons read FButtonGroup;
  end;

{ TButtonItemActionLink }

  TButtonItemActionLink = class(TActionLink)
  protected
    FClient: TBaseButtonItem;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  public
    function DoShowHint(var HintStr: string): Boolean; virtual;
  end;

implementation

uses Themes, ExtCtrls, Types;

{$R CategoryButtons.res} { Contains the Copy DragCursor }

{ TCategoryButtons }

constructor TCategoryButtons.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 100;
  ControlStyle := [csDoubleClicks, csCaptureMouse, csDisplayDragImage, csPannable];
  FButtonCategories := GetButtonCategoriesClass.Create(Self); 
  FBorderStyle := bsSingle;
  FButtonWidth := 24;
  FButtonHeight := 24;
  FGradientDirection := gdHorizontal;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FDoubleBuffered := True;
  FDragImageList := TDragImageList.Create(nil);
  FButtonOptions := [boGradientFill, boShowCaptions, boVerticalCategoryCaptions];

  FHotButtonColor := $00EFD3C6;
  FSelectedButtonColor := GetShadowColor(clBtnFace, -10);
  FRegularButtonColor := GetHighlightColor(clBtnFace, 15);
  FBackgroundGradientColor := clNone;

  TabStop := True;
  Color := clWindow;
end;


procedure TCategoryButtons.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (FBorderStyle = bsSingle) then
  begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

destructor TCategoryButtons.Destroy;
begin
  FDragImageList.Free;
  FButtonCategories.Free;
  FImageChangeLink.Free;
  FSelectedItem := nil;
  FFocusedItem := nil;
  inherited;
end;

function TCategoryButtons.GetScrollOffset: Integer;
begin
  Result := FScrollBarPos * FGutterSize;
end;

function TCategoryButtons.GetButtonRect(const Button: TButtonItem): TRect;
var
  ButtonsPerRow: Integer;
  Row, Col: Integer;
  StartingPos: Integer;
  CategoryBounds, ButtonBounds: TRect;
begin
  { Translate the current virtual position to the actual position }
  StartingPos := Button.Category.FStart - GetScrollOffset;
  GetCategoryBounds(Button.Category, StartingPos, CategoryBounds, ButtonBounds);

  if FButtonFlow = cbfVertical then
    ButtonsPerRow := CalcButtonsPerRow
  else
    ButtonsPerRow := (ButtonBounds.Right - ButtonBounds.Left) div FButtonWidth;
  Row := Button.Index div ButtonsPerRow;
  Result.Top := ButtonBounds.Top + Row*FButtonHeight;
  if (FButtonFlow = cbfVertical) and (boFullSize in FButtonOptions) then
  begin
    Result.Left := ButtonBounds.Left;
    Result.Right := ButtonBounds.Right;
  end
  else
  begin
    Col := Button.Index mod ButtonsPerRow;
    Result.Left := ButtonBounds.Left + Col*FButtonWidth;
    Result.Right := Result.Left + FButtonWidth;
  end;
  Result.Bottom := Result.Top + FButtonHeight;
end;

procedure TCategoryButtons.ImageListChange(Sender: TObject);
begin
  UpdateAllButtons;
end;

procedure TCategoryButtons.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I, J: Integer;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = Images then
      Images := nil
    else
      if AComponent is TBasicAction then
        for I := 0 to FButtonCategories.Count - 1 do
          for J := 0 to FButtonCategories[I].Items.Count - 1 do
            if AComponent = FButtonCategories[I].Items[J].Action then
              FButtonCategories[I].Items[J].Action := nil;
  end;
end;

const
  cBorderBuffer = 5;

function TCategoryButtons.CalcCategoryHeight(const Category: TButtonCategory;
  const ButtonsPerRow: Integer): Integer;
var
  RowCount: Integer;
begin
  if Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0) then
    Result := FCollapsedHeight + cBorderBuffer
  else
  begin
    RowCount := Category.Items.Count div ButtonsPerRow;
    if Category.Items.Count mod ButtonsPerRow <> 0 then
      Inc(RowCount);

    Result := RowCount * FButtonHeight + cBorderBuffer;
    if not (boVerticalCategoryCaptions in ButtonOptions) then
      Result := Result + FGutterSize;
  end;
end;

function TCategoryButtons.CalcCategoryWidth(
  const Category: TButtonCategory; const ButtonsPerCol: Integer): Integer;
var
  ColCount: Integer;
begin
  if Category.Collapsed or (Category.Items = nil) or
      (Category.Items.Count = 0) then
    Result := FCollapsedHeight + cBorderBuffer
  else
  begin
    ColCount := Category.Items.Count div ButtonsPerCol;
    if Category.Items.Count mod ButtonsPerCol <> 0 then
      Inc(ColCount);

    Result := ColCount * FButtonWidth + cBorderBuffer;
    if boVerticalCategoryCaptions in ButtonOptions then
      Result := Result + FGutterSize;
  end;
end;

procedure TCategoryButtons.GetCategoryBounds(const Category: TButtonCategory;
  const StartingPos: Integer; var CategoryBounds, ButtonBounds: TRect);
var
  CatHeight, CatWidth: Integer;
  ButtonsPerRow, ButtonsPerCol: Integer;
  XStart, YStart: Integer;
  XEnd, YEnd: Integer;
begin
  if FButtonFlow = cbfVertical then
  begin
    { 2 Pixel buffer on each side }
    XStart := 2;
    XEnd := ClientWidth - 3;

    ButtonsPerRow := CalcButtonsPerRow;
    CatHeight := CalcCategoryHeight(Category, ButtonsPerRow);

    with CategoryBounds do
    begin
      Left := XStart;
      Top := StartingPos + 1;
      Right := XEnd;
      Bottom := StartingPos + CatHeight - 1;
    end;

    if not Category.Collapsed then
    begin
      if boCaptionOnlyBorder in ButtonOptions then
        with CategoryBounds do
          Inc(Bottom, 3);

      with ButtonBounds do
      begin
        Top := StartingPos + 3;
        if boVerticalCategoryCaptions in ButtonOptions then
          Left := XStart + FGutterSize + 1
        else
        begin
          Left := XStart + 2;
          Top := Top + FGutterSize;
        end;
        Right := XEnd - 1;
        Bottom := Top + (Category.Items.Count div ButtonsPerRow) * FButtonHeight;
        if Category.Items.Count mod ButtonsPerRow <> 0 then
          Inc(Bottom, FButtonHeight);
        if boCaptionOnlyBorder in ButtonOptions then
          Inc(Top, 3);
      end;
    end;
  end
  else
  begin
    { 2 Pixel buffer on each side }
    YStart := 2;
    YEnd := ClientHeight - 3;

    ButtonsPerCol := CalcButtonsPerCol;
    CatWidth := CalcCategoryWidth(Category, ButtonsPerCol);

    with CategoryBounds do
    begin
      Left := StartingPos + 1;
      Top := YStart;
      Right := StartingPos + CatWidth - 1;;
      Bottom := YEnd;
    end;

    if not Category.Collapsed then
      with ButtonBounds do
      begin
        Left := StartingPos + 3;
        if not (boVerticalCategoryCaptions in ButtonOptions) then
          Top := YStart + FGutterSize + 1
        else
        begin
          Top := YStart + 2;
          Left := Left + FGutterSize;
        end;

        Bottom := YEnd - 1;
        Right := Left + (Category.Items.Count div ButtonsPerCol) * FButtonWidth;
        if Category.Items.Count mod ButtonsPerCol <> 0 then
          Inc(Right, FButtonWidth);
      end;
  end;
end;

const
  cDropDownSize = 13;

function TCategoryButtons.GetChevronBounds(const CategoryBounds: TRect): TRect;
begin
  Result.Left := CategoryBounds.Left + 2;
  Result.Top := CategoryBounds.Top + 2;
  Result.Right := Result.Left + cDropDownSize;
  Result.Bottom := Result.Top + cDropDownSize;
end;

procedure TCategoryButtons.DrawCategory(
  const Category: TButtonCategory; const Canvas: TCanvas; StartingPos: Integer);
  
  procedure DrawDropDownButton(X, Y: Integer; Collapsed: Boolean);
  var
    Middle: Integer;
    EdgeColor: TColor;

    procedure SmallCheveron(const X, Y: Integer);
    begin
      { Shared portions }
      if Collapsed then
      begin
        { Top line }
        Canvas.Pixels[X-1, Y] := EdgeColor;
        Canvas.Pixels[X+0, Y] := EdgeColor;
        Canvas.Pixels[X+4, Y] := EdgeColor;
        Canvas.Pixels[X+5, Y] := EdgeColor;
        { Middle line }
        Canvas.Pixels[X+0, Y+1] := EdgeColor;
        Canvas.Pixels[X+1, Y+1] := EdgeColor;
        Canvas.Pixels[X+3, Y+1] := EdgeColor;
        Canvas.Pixels[X+4, Y+1] := EdgeColor;
        { Bottom line  }
        Canvas.Pixels[X + 1, Y + 2] := EdgeColor;
        Canvas.Pixels[X + 2, Y + 2] := EdgeColor;
        Canvas.Pixels[X + 3, Y + 2] := EdgeColor;
        { Bottom tip of the chevron }
        Canvas.Pixels[X+2, Y+3] := EdgeColor;
      end
      else
      begin
        { Top tip of the chevron }
        Canvas.Pixels[X+2, Y] := EdgeColor;
        { Top line  }
        Canvas.Pixels[X + 1, Y + 1] := EdgeColor;
        Canvas.Pixels[X + 2, Y + 1] := EdgeColor;
        Canvas.Pixels[X + 3, Y + 1] := EdgeColor;
        { Middle line }
        Canvas.Pixels[X, Y+2] := EdgeColor;
        Canvas.Pixels[X+1, Y+2] := EdgeColor;
        Canvas.Pixels[X+3, Y+2] := EdgeColor;
        Canvas.Pixels[X+4, Y+2] := EdgeColor;
        { Bottom line }
        Canvas.Pixels[X-1, Y+3] := EdgeColor;
        Canvas.Pixels[X+0, Y+3] := EdgeColor;
        Canvas.Pixels[X+4, Y+3] := EdgeColor;
        Canvas.Pixels[X+5, Y+3] := EdgeColor;
      end;
    end;

    procedure DrawPlusMinus;
    var
      Width, Height: Integer;
      Details: TThemedElementDetails;

    begin
      Width := 9;
      Height := Width;
      Inc(X, 2);
      Inc(Y, 2);

      if ThemeServices.ThemesEnabled then
      begin
        if Collapsed then
          Details := ThemeServices.GetElementDetails(ttGlyphClosed)
        else
          Details := ThemeServices.GetElementDetails(ttGlyphOpened);
        ThemeServices.DrawElement(Canvas.Handle, Details, Rect(X, Y, X + Width, Y + Width));
      end
      else
      begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Brush.Color := clWindow;
        Canvas.Rectangle(X, Y, X + Width, Y + Height);
        Canvas.Pen.Color := clWindowText;

        Canvas.MoveTo(X + 2, Y + Width div 2);
        Canvas.LineTo(X + Width - 2, Y + Width div 2);

        if Collapsed then
        begin
          Canvas.MoveTo(X + Width div 2, Y + 2);
          Canvas.LineTo(X + Width div 2, Y + Width - 2);
        end;
      end;
    end;

  begin
    if boUsePlusMinus in ButtonOptions then
    begin
      DrawPlusMinus;
    end
    else
    begin
      EdgeColor := clBtnShadow;
      Middle := cDropDownSize div 2;

      SmallCheveron(X + Middle - 2, Y + Middle - 4);
      SmallCheveron(X + Middle - 2, Y + Middle + 1);
    end;
  end;

var
  I: Integer;
  ButtonTop, ButtonLeft, ButtonRight: Integer;
  ButtonRect: TRect;
  ActualWidth: Integer;
  ButtonStart: Integer;
  ButtonBottom: Integer;
  CapWidth: Integer;
  VerticalCaption: Boolean;
  CapLeft: Integer;
  DrawState: TButtonDrawState;
  Button: TButtonItem;
  CatHeight: Integer;
  CategoryBounds, ButtonBounds, ChevronBounds: TRect;
  GradientColor, SourceColor, TempColor: TColor;
  Caption: string;
  CaptionRect: TRect;
  CategoryRealBounds: TRect;
  ButtonsPerRow: Integer;
begin
  GetCategoryBounds(Category, StartingPos, CategoryBounds, ButtonBounds);

  if Category.Color <> clNone then
    SourceColor := Category.Color
  else
    SourceColor := Self.Color;

  CategoryRealBounds := CategoryBounds;
  if boCaptionOnlyBorder in ButtonOptions then
  begin
    // shrink the top, so it is "collapsed"
    if (FButtonFlow = cbfVertical) and not Category.Collapsed
      and (Category.Items.Count > 0) then
    begin
      if (boVerticalCategoryCaptions in ButtonOptions) then
        CategoryRealBounds.Right := CategoryRealBounds.Left + FCollapsedHeight + cBorderBuffer
      else
        CategoryRealBounds.Bottom := CategoryRealBounds.Top + FCollapsedHeight + cBorderBuffer
    end;
  end;

  if boGradientFill in FButtonOptions then
  begin
    if Category.GradientColor <> clNone then
      GradientColor := Category.GradientColor
    else
      GradientColor := Self.Color;

    GradientFillCanvas(Canvas, SourceColor, GradientColor, CategoryRealBounds,
      FGradientDirection);
  end
  else
  begin
    Canvas.Brush.Color := Category.Color;
    Canvas.FillRect(CategoryRealBounds)
  end;

  with CategoryRealBounds do
  begin
    // take care of the top left few pixels..
    TempColor := Self.Color;
    Canvas.Pixels[Left, Top] := TempColor;
    Canvas.Pixels[Left+1, Top] := TempColor;
    Canvas.Pixels[Left, Top+1] := TempColor;

    Canvas.Pixels[Left, Bottom] := TempColor;
    Canvas.Pixels[Left+1, Bottom] := TempColor;
    Canvas.Pixels[Left, Bottom-1] := TempColor;

    if BackgroundGradientColor <> clNone then
      TempColor := BackgroundGradientColor;

    Canvas.Pixels[Right, Top] := TempColor;
    Canvas.Pixels[Right-1, Top] := TempColor;
    Canvas.Pixels[Right, Top+1] := TempColor;

    Canvas.Pixels[Right, Bottom] := TempColor;
    Canvas.Pixels[Right-1, Bottom] := TempColor;
    Canvas.Pixels[Right, Bottom-1] := TempColor;

    { Now draw an outline }
    Canvas.Pen.Color := GetShadowColor(SourceColor, -10);
    Canvas.Polyline([Point(Left + 2, Top),
      Point(Right - 2, Top), { Top line }
      Point(Right, Top + 2), { Top right curve }
      Point(Right, Bottom - 2), { Right side line }
      Point(Right - 2, Bottom), { Bottom right curve }
      Point(Left + 2, Bottom), { Bottom line }
      Point(Left, Bottom - 2), { Bottom left curve }
      Point(Left, Top + 2), { Left side line }
      Point(Left + 2, Top)]); { Top left curve }
  end;

  if (Category.Collapsed) and (FSelectedItem <> nil) and
       (FSelectedItem.Category = Category) then
  begin
    Canvas.Brush.Color :=  GetShadowColor(SourceColor, -75);
    with CategoryRealBounds do
      Canvas.FrameRect(Rect(Left + 1, Top + 1, Right, Bottom));
  end;

  ChevronBounds := GetChevronBounds(CategoryRealBounds);

  if Category.Items.Count > 0 then
    DrawDropDownButton(ChevronBounds.Left, ChevronBounds.Top,
      Category.Collapsed);

  VerticalCaption := True;
  if FButtonFlow = cbfVertical then
  begin
    if not (boVerticalCategoryCaptions in ButtonOptions) or
        Category.Collapsed or
        (Category.Items = nil) or
        (Category.Items.Count = 0) then
      VerticalCaption := False
  end
  else if not (boVerticalCategoryCaptions in ButtonOptions) and
      not (Category.Collapsed or (Category.Items = nil) or (Category.Items.Count = 0)) then
    VerticalCaption := False;

  { Draw the category caption. Truncating and vertical as needed. }
  Caption := Category.Caption;

  if (boBoldCaptions in ButtonOptions) then
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];

  CapWidth := Canvas.TextWidth(Caption);
  if VerticalCaption then
    CatHeight := CategoryBounds.Bottom - CategoryBounds.Top - 3 - cDropDownSize
  else
    CatHeight := CategoryBounds.Right - CategoryBounds.Left - 2 - cDropDownSize;

  CapLeft := (CatHeight - CapWidth) div 2;
  if CapLeft < 2 then
    CapLeft := 2;


  Canvas.Brush.Style := bsClear;
  Canvas.Font.Color := Category.TextColor;
  if not VerticalCaption then
  begin
    CaptionRect.Left := CategoryBounds.Left + 4 + cDropDownSize;
    CaptionRect.Top := CategoryBounds.Top + 2;
  end
  else
  begin
    CaptionRect.Left := CategoryBounds.Left + 1;
    CaptionRect.Top := CategoryBounds.Bottom - CapLeft;
    Canvas.Font.Orientation := 900;
  end;

  CaptionRect.Right := CaptionRect.Left + CatHeight;
  CaptionRect.Bottom := CaptionRect.Top + Canvas.TextHeight(Caption);
  Canvas.TextRect(CaptionRect, Caption, [tfNoClip, tfEndEllipsis]);

  if (boBoldCaptions in ButtonOptions) then
    Canvas.Font.Style := Canvas.Font.Style - [fsBold];

  Canvas.Brush.Style := bsSolid;
  Canvas.Font.Orientation := 0;

  if not Category.Collapsed then
  begin
    { Draw the buttons }
    if (FButtonFlow = cbfVertical) and (boFullSize in ButtonOptions) then
      ActualWidth := ClientWidth - FSideBufferSize
    else
      ActualWidth := FButtonWidth;

    ButtonStart := ButtonBounds.Left;
    ButtonTop := ButtonBounds.Top;
    ButtonLeft := ButtonStart;
    for I := 0 to Category.Items.Count - 1 do
    begin
      { Don't waste time painting clipped things }
      if (FButtonFlow = cbfVertical) and (ButtonTop > ClientHeight) then
        Break; { Done drawing }

      { Don't waste time drawing what is offscreen }
      ButtonBottom := ButtonTop + FButtonHeight;
      ButtonRight := ButtonLeft + ActualWidth;
      if (ButtonBottom >= 0) and (ButtonRight >= 0) then
      begin
        ButtonRect := Rect(ButtonLeft, ButtonTop, ButtonRight, ButtonBottom);

        Button := Category.Items[I];
        DrawState := [];
        if Button = FHotButton then
        begin
          Include(DrawState, bdsHot);
          if Button = FDownButton then
            Include(DrawState, bdsDown);
        end;
        if Button = FSelectedItem then
          Include(DrawState, bdsSelected)
        else if (Button = FFocusedItem) and Focused and (FDownButton = nil) then
          Include(DrawState, bdsFocused);

        if Button = FInsertTop then
          Include(DrawState, bdsInsertTop)
        else if Button = FInsertBottom then
          Include(DrawState, bdsInsertBottom)
        else if Button = FInsertRight then
          Include(DrawState, bdsInsertRight)
        else if Button = FInsertLeft then
          Include(DrawState, bdsInsertLeft);

        DrawButton(Button, Canvas, ButtonRect, DrawState);
      end;
      Inc(ButtonLeft, ActualWidth);

      if (ButtonLeft + ActualWidth) > ButtonBounds.Right then
      begin
        ButtonLeft := ButtonStart;
        Inc(ButtonTop, FButtonHeight);
      end;
    end;
  end;
end;

procedure TCategoryButtons.Paint;
var
  TopCategory: Integer;
  CatIndex: Integer;
  StartingPos: Integer;
  EndingPos: Integer;
  Category: TButtonCategory;
begin
  TopCategory := GetIndexOfFirstCategory;

  if BackgroundGradientColor = clNone then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  end
  else
    GradientFillCanvas(Canvas, Color, BackgroundGradientColor, ClientRect,
      BackgroundGradientDirection);

  if (TopCategory > -1) and (TopCategory < FButtonCategories.Count) then
  begin
    { Calculate the virtual position and ending position }
    StartingPos := FButtonCategories[TopCategory].FStart - GetScrollOffset;
    if FButtonFlow = cbfVertical then
      EndingPos := ClientHeight
    else
      EndingPos := ClientWidth;
    for CatIndex := TopCategory to FButtonCategories.Count - 1 do
    begin
      Category := FButtonCategories[CatIndex];
      DrawCategory(Category, Canvas, StartingPos);
      StartingPos := StartingPos + Category.FEnd - Category.FStart;
      { Stop drawing early, if we can }
      if StartingPos > EndingPos then
        Break;
    end;
  end;
end;

function TCategoryButtons.CalcButtonsPerRow: Integer;
begin
  if boFullSize in ButtonOptions then
    Result := 1
  else
  begin
    Result := (ClientWidth - FSideBufferSize) div FButtonWidth;
    if Result = 0 then
      Result := 1;
  end;
end;

function TCategoryButtons.CalcButtonsPerCol: Integer;
begin
  { Ignore full size buttons; they don't make sense in this layout }
  Result := (ClientHeight - FSideBufferSize) div FButtonHeight;
  if Result = 0 then
    Result := 1;
end;

const
  cScrollBarKind: array[TCatButtonFlow] of Integer = (SB_VERT, SB_HORZ);

procedure TCategoryButtons.Resize;

  function CalcCategoryHeights: Integer;
  var
    I: Integer;
    Category: TButtonCategory;
    Y: Integer;
    ButtonsPerRow: Integer;
  begin
    ButtonsPerRow := CalcButtonsPerRow;
    Y := 0;
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      Category := FButtonCategories[I];
      Category.FStart := Y;
      Category.FEnd := Y + CalcCategoryHeight(Category, ButtonsPerRow);
      Y := Category.FEnd;
    end;
    Result := Y;
  end;

  function CalcCategoryWidths: Integer;
  var
    I: Integer;
    Category: TButtonCategory;
    X: Integer;
    ButtonsPerCol: Integer;
  begin
    ButtonsPerCol := CalcButtonsPerCol;
    X := 0;
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      Category := FButtonCategories[I];
      Category.FStart := X;
      Category.FEnd := X + CalcCategoryWidth(Category, ButtonsPerCol);
      X := Category.FEnd;
    end;
    Result := X;
  end;

var
  ScrollInfo: TScrollInfo;
  TotalAmount: Integer;
  AmountSeen: Integer;
begin
  inherited;
  if (not HandleAllocated) or (FGutterSize = 0) then
    Exit;

  if FButtonFlow = cbfVertical then
  begin
    TotalAmount := CalcCategoryHeights;
    AmountSeen := ClientHeight;
  end
  else
  begin
    TotalAmount := CalcCategoryWidths;
    AmountSeen := ClientWidth;
  end;

  { Do we have to take the scrollbar into consideration? }
  if (TotalAmount > AmountSeen) then
  begin
    { The max size is the number of "rows of buttons" that are hidden }
    FScrollBarMax := TotalAmount div FGutterSize;
    ScrollInfo.nMax := FScrollBarMax;

    AmountSeen := AmountSeen div FGutterSize;
    if FScrollBarMax > AmountSeen then
      FPageAmount := AmountSeen
    else
      FPageAmount := FScrollBarMax;

    { Adjust the max to NOT contain the page amount }
    FScrollBarMax := FScrollBarMax - FPageAmount + 1;

    if FScrollBarPos > FScrollBarMax then
      FScrollBarPos := FScrollBarMax;

    ScrollInfo.cbSize := SizeOf(TScrollInfo);
    ScrollInfo.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
    ScrollInfo.nMin := 0;
    ScrollInfo.nPos := FScrollBarPos;
    ScrollInfo.nPage := FPageAmount;

    SetScrollInfo(Handle, cScrollBarKind[FButtonFlow], ScrollInfo, True);
    ShowScrollBar(True);
  end
  else
  begin
    FScrollBarPos := 0;
    FScrollBarMax := 0;
    ShowScrollBar(False);
  end;
end;

procedure TCategoryButtons.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCategoryButtons.SetButtonHeight(const Value: Integer);
begin
  if (FButtonHeight <> Value) and (Value > 0) then
  begin
    FButtonHeight := Value;
    Resize;
    UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.SetButtonCategories(const Value: TButtonCategories);
begin
  FButtonCategories.Assign(Value);
end;

procedure TCategoryButtons.SetCatButtonOptions(const Value: TCatButtonOptions);
begin
  if FButtonOptions <> Value then
  begin
    FButtonOptions := Value;
    CalcBufferSizes;
    Resize;
    UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.SetButtonWidth(const Value: Integer);
begin
  if (FButtonWidth <> Value) and (Value > 0) then
  begin
    FButtonWidth := Value;
    Resize;
    UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.ShowScrollBar(const Visible: Boolean);
begin
  if Visible <> FScrollBarShown then
  begin
    FScrollBarShown := Visible;
    Windows.ShowScrollBar(Handle, cScrollBarKind[ButtonFlow], Visible);
  end;
end;

procedure TCategoryButtons.UpdateAllButtons;
begin
  Invalidate;
end;

procedure TCategoryButtons.UpdateButton(const Button: TButtonItem);
var
  R: TRect;
begin
  { Just invalidate one button's rect }
  if (Button <> nil) and (HandleAllocated) then
  begin
    R := GetButtonRect(Button);
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TCategoryButtons.WMVScroll(var Message: TWMVScroll);
begin
  with Message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TCategoryButtons.WMHScroll(var Message: TWMVScroll);
begin
  with Message do
    ScrollPosChanged(TScrollCode(ScrollCode), Pos);
end;

procedure TCategoryButtons.ScrollPosChanged(ScrollCode: TScrollCode;
  ScrollPos: Integer);
var
  OldPos: Integer;
begin
  OldPos := FScrollBarPos;
  if (ScrollCode = scLineUp) and (FScrollBarPos > 0) then
    Dec(FScrollBarPos)
  else if (ScrollCode = scLineDown) and (FScrollBarPos < FScrollBarMax) then
    Inc(FScrollBarPos)
  else if (ScrollCode = scPageUp) then
  begin
    Dec(FScrollBarPos, FPageAmount);
    if FScrollBarPos < 0 then
      FScrollBarPos := 0;
  end
  else if ScrollCode = scPageDown then
  begin
    Inc(FScrollBarPos, FPageAmount);
    if FScrollBarPos > FScrollBarMax then
      FScrollBarPos := FScrollBarMax;
  end
  else if ScrollCode in [scPosition, scTrack] then
    FScrollBarPos := ScrollPos
  else if ScrollCode = scTop then
    FScrollBarPos := 0
  else if ScrollCode = scBottom then
    FScrollBarPos := FScrollBarMax;
  if OldPos <> FScrollBarPos then
  begin
    Windows.SetScrollPos(Handle, cScrollBarKind[FButtonFlow], FScrollBarPos, True);
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetImages(const Value: TCustomImageList);
begin
  if Images <> Value then
  begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if Images <> nil then
    begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
   end;
   UpdateAllButtons;
  end;
end;

procedure TCategoryButtons.DrawButton(const Button: TButtonItem; Canvas: TCanvas;
  Rect: TRect; State: TButtonDrawState);
var
  TextLeft, TextTop: Integer;
  RectHeight: Integer;
  ImgTop: Integer;
  TextOffset: Integer;
  FillColor: TColor;
  EdgeColor: TColor;
  InsertIndication: TRect;
  TextRect: TRect;
  OrgRect: TRect;
  Caption: string;
begin
  if Assigned(FOnDrawButton) and (not (csDesigning in ComponentState)) then
    FOnDrawButton(Self, Button, Canvas, Rect, State)
  else
  begin
    OrgRect := Rect;
    if Assigned(FOnBeforeDrawButton) then
      FOnBeforeDrawButton(Self, Button, Canvas, Rect, State);
    InflateRect(Rect, -1, -1);

    Canvas.Font.Color := clBtnText;
    if bdsHot in State then
    begin
      FillColor := FHotButtonColor;
      if bdsSelected in State then
        FillColor := GetShadowColor(FillColor, -10);
      EdgeColor := GetShadowColor(FillColor);
    end
    else if bdsSelected in State then
    begin
      FillColor := FSelectedButtonColor;
      EdgeColor := GetShadowColor(FillColor);
    end
    else
    begin
      FillColor := FRegularButtonColor;
      if (bdsFocused in State) then
        EdgeColor := GetShadowColor(FSelectedButtonColor) 
      else
        EdgeColor := GetShadowColor(FillColor);
    end;

    Canvas.Brush.Color := FillColor;
    if FillColor <> clNone then
    begin
      Canvas.FillRect(Rect);
      { Draw the edge outline }
      Canvas.Brush.Color := EdgeColor;
      Canvas.FrameRect(Rect);
    end;

    if bdsFocused in State then
    begin
      InflateRect(Rect, -1, -1);
      Canvas.FrameRect(Rect);
    end;

    Canvas.Brush.Color := FillColor;

    { Compute the text location }
    TextLeft := Rect.Left + 4;
    RectHeight := Rect.Bottom - Rect.Top;
    TextTop := Rect.Top + (RectHeight - Canvas.TextHeight('Wg')) div 2;

    if boFullSize in ButtonOptions then
      Inc(TextLeft, 4);  // indent, slightly

    if TextTop < Rect.Top then
      TextTop := Rect.Top;
    if bdsDown in State then
    begin
      Inc(TextTop);
      Inc(TextLeft);
    end;

    { Draw the icon - prefer the event }
    TextOffset := 0;
    if Assigned(FOnDrawIcon) then
      FOnDrawIcon(Self, Button, Canvas, OrgRect, State, TextOffset)
    else if (FImages <> nil) and (Button.ImageIndex > -1) and
        (Button.ImageIndex < FImages.Count) then
    begin
      ImgTop := Rect.Top + (RectHeight - FImages.Height) div 2;
      if ImgTop < Rect.Top then
        ImgTop := Rect.Top;
      if bdsDown in State then
        Inc(ImgTop);
      FImages.Draw(Canvas, TextLeft - 1, ImgTop, Button.ImageIndex);
      TextOffset := FImages.Width + 1;
    end;

    { Show insert indications }
    if [bdsInsertLeft, bdsInsertTop, bdsInsertRight, bdsInsertBottom] * State <> [] then
    begin
      Canvas.Brush.Color := GetShadowColor(EdgeColor);
      InsertIndication := Rect;
      if bdsInsertLeft in State then
      begin
        Dec(InsertIndication.Left, 2);
        InsertIndication.Right := InsertIndication.Left + 2;
      end
      else if bdsInsertTop in State then
      begin
        Dec(InsertIndication.Top);
        InsertIndication.Bottom := InsertIndication.Top + 2;
      end
      else if bdsInsertRight in State then
      begin
        Inc(InsertIndication.Right, 2);
        InsertIndication.Left := InsertIndication.Right - 2;
      end
      else if bdsInsertBottom in State then
      begin
        Inc(InsertIndication.Bottom);
        InsertIndication.Top := InsertIndication.Bottom - 2;
      end;
      Canvas.FillRect(InsertIndication);
      Canvas.Brush.Color := FillColor;
    end;

    if boShowCaptions in FButtonOptions then
    begin
      if FillColor = clNone then
        Canvas.Brush.Style := bsClear;

      { Avoid clipping the image }
      Inc(TextLeft, TextOffset);
      TextRect.Left := TextLeft;
      TextRect.Right := Rect.Right - 2;
      TextRect.Top := TextTop;
      TextRect.Bottom := Rect.Bottom -1;

      if Assigned(FOnDrawText) then
        FOnDrawText(Self, Button, Canvas, TextRect, State)
      else
      begin
        Caption := Button.Caption;
        Canvas.TextRect(TextRect, Caption, [tfEndEllipsis]);
      end;
    end;

    if Assigned(FOnAfterDrawButton) then
      FOnAfterDrawButton(Self, Button, Canvas, OrgRect, State);
  end;
  Canvas.Brush.Color := Color; { Restore the original color }
end;

procedure TCategoryButtons.SetOnDrawButton(const Value: TCatButtonDrawEvent);
begin
  FOnDrawButton := Value;
  Invalidate;
end;

procedure TCategoryButtons.SetOnDrawIcon(const Value: TCatButtonDrawIconEvent);
begin
  FOnDrawIcon := Value;
  Invalidate;
end;

procedure TCategoryButtons.CalcBufferSizes;
var
  VertInOpt: Boolean;
begin
  if HandleAllocated then
  begin
    Canvas.Font := Font;
    FCollapsedHeight := Canvas.TextHeight('Wg');  { Do not localize }
    FGutterSize := FCollapsedHeight + 1 { Border around the text };

    VertInOpt := boVerticalCategoryCaptions in ButtonOptions;
    if ((FButtonFlow = cbfVertical) and VertInOpt) or
       ((FButtonFlow = cbfHorizontal) and not VertInOpt) then
      FSideBufferSize := FGutterSize + 8
    else
      FSideBufferSize := 8;
  end;
end;

procedure TCategoryButtons.CreateHandle;
begin
  inherited CreateHandle;
  CalcBufferSizes;
  Resize;
end;

procedure TCategoryButtons.WMMouseLeave(var Message: TMessage);
begin
  FMouseInControl := False;
  if FHotButton <> nil then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    DoHotButton;
  end;
  if FDragImageList.Dragging then
  begin
    FDragImageList.HideDragImage;
    RemoveInsertionPoints;
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
  end;
end;

procedure TCategoryButtons.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DownCategory: TButtonCategory;
begin
  inherited;
  if Button = mbLeft then
  begin
    FDragStarted := False;
    DownCategory := GetCategoryAt(X, Y);
    FDownButton := GetButtonAt(X, Y, DownCategory);

    { Focus ourselves, when clicked, like a button would, but
      after setting the FDownButton }
    if (not Focused) and CanFocus then
      Windows.SetFocus(Handle);

    if FDownButton <> nil then
    begin
      FDragButton := FDownButton;
      FDragStartPos := Point(X, Y);
      UpdateButton(FDownButton);
    end
    else if DownCategory <> nil then
    begin
      if GetAllowReorder then
      begin
        FDragCategory := DownCategory;
        FDragStartPos := Point(X, Y);
      end;
    end;
  end;
end;

procedure TCategoryButtons.BeginAutoDrag;
begin
  FDragStartPos := ScreenToClient(Mouse.CursorPos);
  with FDragStartPos do
    FDragButton := GetButtonAt(X, Y);
  if FDragButton <> nil then
  begin
    FDragStarted := True;
    DoBeginDrag(Mouse.DragImmediate, Mouse.DragThreshold);
  end;
  { Don't call inherited; the above takes care of calling BeginDrag } 
end;

procedure TCategoryButtons.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewHotButton, OldHotButton: TButtonItem;
  EventTrack: TTrackMouseEvent;
  DragThreshold: Integer;
begin
  inherited;
  { Was the drag threshold met? }
  if (GetAllowReorder) and
    ((FDragButton <> nil) or (FDragCategory <> nil)) then
  begin
    DragThreshold := Mouse.DragThreshold;
    if (Abs(FDragStartPos.X - X) >= DragThreshold) or
        (Abs(FDragStartPos.Y - Y) >= DragThreshold) then
    begin
      FDragStartPos.X := X; { Used in the start of the drag }
      FDragStartPos.Y := Y;
      FDownButton := nil; { Stops repaints and clicks }
      if FHotButton <> nil then
      begin
        OldHotButton := FHotButton;
        FHotButton := nil;
        UpdateButton(OldHotButton);
        { We must have the window process the paint message before
          the drag operation starts }
        UpdateWindow(Handle);
        DoHotButton;
      end;
      FDragStarted := True;
      DoBeginDrag(True, -1);
      Exit;
    end;
  end;

  NewHotButton := GetButtonAt(X, Y);
  if NewHotButton <> FHotButton then
  begin
    OldHotButton := FHotButton;
    FHotButton := NewHotButton;
    UpdateButton(OldHotButton);
    UpdateButton(FHotButton);
    DoHotButton;
  end;
  if not FMouseInControl then
  begin
    FMouseInControl := True;
    EventTrack.cbSize := SizeOf(TTrackMouseEvent);
    EventTrack.dwFlags := TME_LEAVE;
    EventTrack.hwndTrack := Handle;
    EventTrack.dwHoverTime := 0;
    TrackMouseEvent(EventTrack);
  end;
end;

procedure TCategoryButtons.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  LastDown: TButtonItem;
  DownCategory: TButtonCategory;
begin
  inherited;
  if (Button = mbLeft) and (not FDragStarted) then
  begin
    LastDown := FDownButton;
    FDownButton := nil;
    FDragButton := nil;
    FDragCategory := nil;
    if LastDown <> nil then
      UpdateButton(LastDown);
    if (LastDown <> nil) and (GetButtonAt(X, Y) = LastDown) then
    begin
      SelectedItem := LastDown;
      DoItemClicked(FSelectedItem);
    end
    else
    begin
      DownCategory := GetCategoryAt(X, Y);
      if (DownCategory <> nil) and (DownCategory.Items.Count > 0) then
        DownCategory.Collapsed := not DownCategory.Collapsed
    end;
    if Assigned(FOnClick) then
      FOnClick(Self);
  end;
  FDragStarted := False;
end;

function TCategoryButtons.GetButtonAt(X, Y: Integer;
  Category: TButtonCategory = nil): TButtonItem;
var
  Row, Col: Integer;
  CategoryBounds, ButtonBounds: TRect;
  ResIndex: Integer;
  ButtonsPerRow: Integer;
begin
  Result := nil;
  if Category = nil then
    Category := GetCategoryAt(X, Y);
  if Category <> nil then
  begin
    { Translate the X or Y position to our virtual system }
    if FButtonFlow = cbfVertical then
      Y := Y + GetScrollOffset { Amount hidden }
    else
      X := X + GetScrollOffset;
    GetCategoryBounds(Category, Category.FStart, CategoryBounds, ButtonBounds);
    if (X >= ButtonBounds.Left) and (X <= ButtonBounds.Right) and
       (Y >= ButtonBounds.Top) and (Y <= ButtonBounds.Bottom) then
    begin
      { Find out which button it is. }
      Row := (Y - ButtonBounds.Top) div FButtonHeight;
      if (FButtonFlow = cbfVertical) and (boFullSize in FButtonOptions) then
        Col := 0
      else
      begin
        Col := (X - ButtonBounds.Left) div FButtonWidth;
        if ButtonBounds.Left + (Col+1)*FButtonWidth > ButtonBounds.Right then
          Exit; { Not within the bounds }
      end;

      if FButtonFlow = cbfVertical then
        ButtonsPerRow := CalcButtonsPerRow
      else
        ButtonsPerRow := (ButtonBounds.Right - ButtonBounds.Left) div FButtonWidth;
      ResIndex := Row * ButtonsPerRow + Col;
      if ResIndex < Category.Items.Count then
        Result := Category.Items[ResIndex];
    end;
  end;
end;

procedure TCategoryButtons.DoItemClicked(const Button: TButtonItem);
begin
  if (Button <> nil) and Assigned(Button.OnClick) then
    Button.OnClick(Self)
  else if Assigned(FOnButtonClicked) then
    FOnButtonClicked(Self, Button);
end;

procedure TCategoryButtons.DragDrop(Source: TObject; X, Y: Integer);
var
  TargetButton: TButtonItem;
  TargetCategory: TButtonCategory;
begin
  if ((boAllowReorder in ButtonOptions) and
    ((Source = Self) or
        ((Source is TBaseDragControlObject) and (TBaseDragControlObject(Source).Control = Self)))) then
  begin
    RemoveInsertionPoints;
    GetTargetAt(X, Y, TargetButton, TargetCategory);
    if (TargetCategory <> nil) and (FDragButton <> nil) then
    begin
      { Reordering, or copying? }
      if (boAllowCopyingButtons in ButtonOptions) and
         (GetKeyState(VK_CONTROL) < 0) then
        DoCopyButton(FDragButton, TargetCategory, TargetButton)
      else
        DoReorderButton(FDragButton, TargetCategory, TargetButton);
    end
    else if (FDragCategory <> nil) then
      DoReorderCategory(FDragCategory, TargetCategory);
    FDragButton := nil;
    FDragCategory := nil;
  end
  else
    inherited;
end;

procedure TCategoryButtons.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  OverButton: TButtonItem;
  OverCategory: TButtonCategory;
  Temp: Integer;
begin
  if (boAllowReorder in ButtonOptions) and
    ((Source = Self) or ((Source is TBaseDragControlObject) and
        (TBaseDragControlObject(Source).Control = Self))) then
  begin
    if ShouldScrollDown(Temp) then
      AutoScroll(scLineDown)
    else if ShouldScrollUp(Temp) then
      AutoScroll(scLineUp);

    GetTargetAt(X, Y, OverButton, OverCategory);

    if (boAllowCopyingButtons in ButtonOptions) and
       (GetKeyState(VK_CONTROL) < 0) then
    begin
      Accept := FDragButton <> nil; { Copy from somewhere to anywhere }
      DragCursor := crDragCopy;
    end
    else
    begin
      { Don't accept when it is the same as the start or right after us }
      Accept := (FDragButton <> nil) and (OverButton <> FDragButton)
        and (OverButton <> nil) and (OverButton.Index <> FDragButton.Index + 1);
      DragCursor := crDrag;
    end;

    if not Accept then
    begin
      { Accept if it is into another category, or it isn't the last index
        in the current category }
      Accept := (FDragButton <> nil) and (OverCategory <> nil) and
        ((OverCategory <> FDragButton.Category) or
         ((FDragButton <> OverButton) and (OverButton <> nil) and
           (OverButton.Index <> FDragButton.Index + 1)));
      { If we are dragging the category, use similar logic }
      if (not Accept) and (FDragCategory <> nil) then
      begin
        OverButton := nil;
        Accept := OverCategory <> FDragCategory;
        if Accept then
          if OverCategory = nil then
            Accept := FDragCategory.Index <> Categories.Count - 1;
      end;
    end;

    if FDragButton <> nil then
    begin
      if Accept and (State <> dsDragLeave) then
      begin
        SetInsertionButton(OverButton, OverCategory)
      end
      else
      begin
        if FDragImageList.Dragging then
          FDragImageList.HideDragImage;
        RemoveInsertionPoints;
        if FDragImageList.Dragging then
        begin
          UpdateWindow(Handle);
          FDragImageList.ShowDragImage;
        end;
      end;
    end;
  end
  else
    inherited DragOver(Source, X, Y, State, Accept);
end;

procedure TCategoryButtons.DoHotButton;
begin
  if Assigned(FOnHotButton) then
    FOnHotButton(Self, FHotButton);
end;

procedure TCategoryButtons.GenerateDragImage;
var
  ButtonRect: TRect;
  State: TButtonDrawState;
  DragImage: TBitmap;
begin
  DragImage := TBitmap.Create;
  try
    if FDragButton <> nil then
    begin
      ButtonRect := GetButtonRect(FDragButton);
      DragImage.Width := ButtonRect.Right - ButtonRect.Left;
      DragImage.Height := ButtonRect.Bottom - ButtonRect.Top;
      State := [bdsDragged];
      if FSelectedItem = FDragButton then
        State := State + [bdsSelected];

      DragImage.Canvas.Brush.Color := clBtnFace;
      DragImage.Canvas.FillRect(Rect(0, 0, DragImage.Width, DragImage.Height));
      DrawButton(FDragButton, DragImage.Canvas,
        Rect(0, 0, DragImage.Width, DragImage.Height), State);
    end
    else
    begin
      Assert(FDragCategory <> nil);
      if (FDragCategory <> nil) then
      begin
        ButtonRect := GetCategoryRect(FDragCategory);
        DragImage.Width := ButtonRect.Right - ButtonRect.Left + 3;
        DragImage.Height := ButtonRect.Bottom - ButtonRect.Top + 2;
        DragImage.Canvas.Brush.Color := clBtnFace;
        DragImage.Canvas.FillRect(Rect(0, 0, DragImage.Width, DragImage.Height));
        DrawCategory(FDragCategory, DragImage.Canvas, 0);
      end;
    end;

    if (FDragButton <> nil) or (FDragCategory <> nil) then
    begin
      FDragImageList.Clear;
      FDragImageList.Width := DragImage.Width;
      FDragImageList.Height := DragImage.Height;
      FDragImageList.Add(DragImage, nil);

      with FDragImageList.DragHotspot do
      begin
        X := FDragStartPos.X - ButtonRect.Left - Mouse.DragThreshold;
        Y := FDragStartPos.Y - ButtonRect.Top - Mouse.DragThreshold;
      end;
    end;
  finally
    DragImage.Free;
  end;
end;

procedure TCategoryButtons.DoStartDrag(var DragObject: TDragObject);
begin
  GenerateDragImage;
  inherited DoStartDrag(DragObject);
end;

function TCategoryButtons.GetDragImages: TDragImageList;
begin
  Result := FDragImageList;
end;

procedure TCategoryButtons.RemoveInsertionPoints;

  procedure ClearSelection(var Item: TButtonItem);
  var
    OldItem: TButtonItem;
  begin
    if Item <> nil then
    begin
      OldItem := Item;
      Item := nil;
      UpdateButton(OldItem);
    end;
  end;
begin
  ClearSelection(FInsertTop);
  ClearSelection(FInsertLeft);
  ClearSelection(FInsertRight);
  ClearSelection(FInsertBottom);
end;

procedure TCategoryButtons.DoReorderButton(const Button: TButtonItem;
  const TargetCategory: TButtonCategory; const TargetButton: TButtonItem);
var
  TargetIndex: Integer;
  OldCategory: TButtonCategory;
begin
  FIgnoreUpdate := True;
  try
    { Are we moving in the same cateogry to over a button? }
    OldCategory := Button.Category;
    if (TargetButton <> nil) and (Button.Category = TargetButton.Category) then
    begin
      TargetIndex := TargetButton.Index;
      if TargetIndex > Button.Index then
        Dec(TargetIndex); { Account for moving ourselves }
      Button.Index := TargetIndex;
    end
    else if TargetCategory <> nil then
    begin
      if TargetCategory = Button.Category then
      begin
        { Moving to the end of the category }
        Button.Index := TargetCategory.Items.Count - 1;
      end
      else
      begin
        Button.Collection := TargetCategory.Items;
        if (TargetButton <> nil) then
          Button.Index := TargetButton.Index;
        Resize; { We have to recalculate the group's size }
      end;
    end;
  finally
    FIgnoreUpdate := False;
  end;
  Invalidate;
  if Assigned(FOnReorderButton) then
    FOnReorderButton(Self, Button, OldCategory, TargetCategory);
end;

const
  cMinScrollDelay = 20;
  cMaxScrollDelay = 400;

function TCategoryButtons.ShouldScrollDown(out Delay: Integer): Boolean;
var
  ScrollBuffer: Integer;
  AWidth, AHeight: Integer;
begin
  Result := FScrollBarPos < FScrollBarMax;
  if Result then
  begin
    ScrollBuffer := GetScrollBuffer;
    { Is the mouse still in position? }
    with ScreenToClient(Mouse.CursorPos) do
    begin
      if FButtonFlow = cbfHorizontal then
      begin
        { Switch X and Y and Width and Height }
        AWidth := X; { temp }
        X := Y;
        Y := AWidth;        
        AWidth := Height;
        AHeight := Width;
      end
      else
      begin
        AWidth := Width;
        AHeight := Height;
      end;

      if (X < 0) or (X > AWidth) or (Y > AHeight) or (Y < AHeight - ScrollBuffer) then
        Result := False
      else
        Delay := Trunc(cMaxScrollDelay * ((AHeight - Y) / ScrollBuffer)) + cMinScrollDelay;
    end
  end;
end;

function TCategoryButtons.ShouldScrollUp(out Delay: Integer): Boolean;
var
  ScrollBuffer: Integer;
  AWidth: Integer;
begin
  Result := FScrollBarPos > 0;
  if Result then
  begin
    ScrollBuffer := GetScrollBuffer;
    with ScreenToClient(Mouse.CursorPos) do
    begin
      if FButtonFlow = cbfHorizontal then
      begin
        AWidth := X;
        X := Y;
        Y := AWidth;
        AWidth := Height;
      end
      else
        AWidth := Width;

      if (X < 0) or (X > AWidth) or (Y < 0) or (Y > ScrollBuffer) then
        Result := False
      else
        Delay := Trunc(cMaxScrollDelay * (Y / ScrollBuffer)) + cMinScrollDelay;
    end;
  end;
end;


procedure TCategoryButtons.AutoScroll(ScrollCode: TScrollCode);

  function ShouldContinue(out Delay: Integer): Boolean;
  begin
    { Are we autoscrolling up or down? }
    if ScrollCode = scLineDown then
      Result := ShouldScrollDown(Delay)
    else
      Result := ShouldScrollUp(Delay)
  end;
  
var
  CurrentTime, StartTime, ElapsedTime: Longint;
  Delay: Integer;
begin
  FDragImageList.HideDragImage;
  RemoveInsertionPoints;
  FDragImageList.ShowDragImage;

  CurrentTime := 0;
  while (ShouldContinue(Delay)) do
  begin
    StartTime := GetCurrentTime;
    ElapsedTime := StartTime - CurrentTime;
    if ElapsedTime < Delay then
      Sleep(Delay - ElapsedTime);
    CurrentTime := StartTime;

    FDragImageList.HideDragImage;
    ScrollPosChanged(ScrollCode, 0{ Ignored});
    UpdateWindow(Handle);
    FDragImageList.ShowDragImage;
  end;
end;

function TCategoryButtons.GetNextButtonInGroup(const StartingButton: TButtonItem;
  GoForward: Boolean): TButtonItem;
var
  Category: TButtonCategory;
  NextIndex: Integer;
begin
  Result := nil;
  if StartingButton <> nil then
  begin
    Category := StartingButton.Category;
    if GoForward then
      NextIndex := StartingButton.Index + 1
    else
      NextIndex := StartingButton.Index - 1;

    if (NextIndex > -1) and (NextIndex < Category.Items.Count) then
      Result := Category.Items[NextIndex];  { Same category, next button in it. }
  end;
end;

procedure TCategoryButtons.GetTargetAt(X, Y: Integer;
  var TargetButton: TButtonItem; var TargetCategory: TButtonCategory);
var
  ButtonRect: TRect;
begin
  TargetCategory := GetCategoryAt(X, Y);
  TargetButton := GetButtonAt(X, Y, TargetCategory);
  if (TargetButton <> nil) then
  begin
    { Before the index, or after it?  }
    ButtonRect := GetButtonRect(TargetButton);

    if (FButtonFlow = cbfVertical) and (CalcButtonsPerRow = 1) then
    begin
      if Y > (ButtonRect.Top + (ButtonRect.Bottom - ButtonRect.Top) div 2) then
        TargetButton := GetNextButtonInGroup(TargetButton, True);
    end
    else
      if X > (ButtonRect.Left + (ButtonRect.Right - ButtonRect.Left) div 2) then
        TargetButton := GetNextButtonInGroup(TargetButton, True);
  end
  else if (TargetCategory <> nil) and (TargetCategory.Items.Count > 0) then
  begin
    { Insert before or after all the items? }
    if FButtonFlow = cbfVertical then
      Y := Y + GetScrollOffset { Amount hidden }
    else
      X := X + GetScrollOffset;
    if (FButtonFlow = cbfVertical) and (CalcButtonsPerRow = 1) then
    begin
      if Y < (TargetCategory.FStart + (TargetCategory.FEnd - TargetCategory.FStart) div 2) then
        if (not TargetCategory.Collapsed) then
          TargetButton := TargetCategory.Items[0]
    end
    else
      if X < (ClientWidth div 2) then
        if (not TargetCategory.Collapsed) then
          TargetButton := TargetCategory.Items[0]
  end;
end;

procedure TCategoryButtons.CNKeydown(var Message: TWMKeyDown);
var
  IncAmount: Integer;
  CurrentItem: TButtonItem;

  procedure FixIncAmount(const StartValue: Integer);
  begin
    { Keep it within the bounds }
    if StartValue + IncAmount >= FButtonCategories.Count then
      IncAmount := FButtonCategories.Count - StartValue - 1
    else if StartValue + IncAmount < 0 then
      IncAmount := 0 - StartValue; 
  end;

  function CalcRowsSeen: Integer;
  begin
    Result := ClientHeight div FButtonHeight;
  end;

  function GetNextItem(const StartIndex: Integer; SuggestedIndex: Integer): TButtonItem;
  var
    CatCount: Integer;
    I: Integer;
  begin
    Result := nil;
    for I := StartIndex to FButtonCategories.Count - 1 do
    begin
      CatCount := FButtonCategories[I].Items.Count;
      if CatCount > 0 then
      begin
        if SuggestedIndex >= CatCount then
          SuggestedIndex := CatCount - 1;
        Result := FButtonCategories[I].Items[SuggestedIndex];
        Break;
      end;
    end;
  end;

  function GetPriorItem(const StartIndex: Integer; Col: Integer): TButtonItem;
  var
    I: Integer;
    CatCount: Integer;
    Category: TButtonCategory;
    LastRow: Integer;
    ButtonsPerRow: Integer;
  begin
    Result := nil;
    ButtonsPerRow := CalcButtonsPerRow;
    for I := StartIndex downto 0 do
    begin
      Category := FButtonCategories[I];
      CatCount := Category.Items.Count;
      if CatCount > 0 then
      begin
        LastRow := CatCount div ButtonsPerRow - 1;
        if CatCount mod ButtonsPerRow <> 0 then
          Inc(LastRow);

        Col := Col + LastRow*ButtonsPerRow;

        if Col >= CatCount then
          Col := CatCount - 1;
        Result := Category.Items[Col];
        Break;
      end;
    end;
  end;

  function CalcActualButtonsPerRow: Integer;
  var
    CatBounds, Temp: TRect;
  begin
    if FButtonFlow = cbfVertical then
      Result := CalcButtonsPerRow
    else
    begin
      GetCategoryBounds(CurrentItem.Category, 0, CatBounds, Temp);
      Result := (CatBounds.Right - CatBounds.Left) div FButtonWidth;
      if Result = 0 then
        Result := 1;
    end;
  end;

  function GetNext(GoForward: Boolean): TButtonItem;
  var
    Row, Col: Integer;
    ButtonsPerRow: Integer;
    CatCount: Integer;
    I: Integer;
  begin
    Result := nil;
    if CurrentItem <> nil then
    begin
      ButtonsPerRow := CalcActualButtonsPerRow;

      CatCount := CurrentItem.Category.Items.Count;
      Row := CurrentItem.Index div ButtonsPerRow;
      Col := CurrentItem.Index mod ButtonsPerRow;
      if GoForward then
        Inc(Row)
      else
        Dec(Row);

      if (Row > -1) and (Row*ButtonsPerRow < CatCount) and
         (not CurrentItem.Category.Collapsed) then
      begin
        I := Col + Row*ButtonsPerRow;
        if I >= CatCount then
          I := CatCount - 1;
        Result := CurrentItem.Category.Items[I];
      end
      else if FButtonFlow = cbfVertical then
      begin
        I := CurrentItem.Category.Index;
        if GoForward then
        begin
          Inc(I);
          Result := GetNextItem(I, Col);
        end
        else
        begin
          Dec(I);
          Result := GetPriorItem(I, Col);
        end;
      end;
    end
    else if (FButtonFlow = cbfVertical) and GoForward then
      Result := GetNextItem(0, 0);
  end;

  function MoveSideways(IsLeft: Boolean): TButtonItem;
  var
    ButtonsPerRow: Integer;
    Col: Integer;
    Row: Integer;
    NewIndex: Integer;
  begin
    Result := nil;

    ButtonsPerRow := CalcActualButtonsPerRow;
    Col := CurrentItem.Index mod ButtonsPerRow;
    if IsLeft and (Col > 0) then
      NewIndex := CurrentItem.Index - 1 { Can move to the left }
    else if (not IsLeft) and (Col < ButtonsPerRow - 1) then
      NewIndex := CurrentItem.Index + 1
    else
      NewIndex := -1;
    if (NewIndex >= 0) and (NewIndex < CurrentItem.Category.Items.Count) then
      Result := CurrentItem.Category.Items[NewIndex]
    else if (FButtonFlow = cbfHorizontal) then
    begin
      { Try the next category }
      if IsLeft then
      begin
        if CurrentItem.Category.Index <> 0 then
          Result := GetPriorItem(CurrentItem.Category.Index - 1, 0)
      end
      else
        Result := GetNextItem(CurrentItem.Category.Index + 1, 0);
      { Try and maintain the same row that we were on }
      if Result <> nil then
      begin
        Row := CurrentItem.Index div ButtonsPerRow;
        CurrentItem := Result;
        ButtonsPerRow := CalcActualButtonsPerRow;
        if IsLeft then
          Col := ButtonsPerRow - 1
        else
          Col := 0;
        NewIndex := Col + Row*ButtonsPerRow;
        if NewIndex >= Result.Category.Items.Count then
          NewIndex := Result.Category.Items.Count - 1;
        Result := Result.Category.Items[NewIndex];
      end;
    end
  end;

  function CtrlIsDown: Boolean;
  begin
    Result := ssCtrl in KeyboardStateToShiftState;
  end;

  function ChangePage(GoForward: Boolean): TButtonItem;
  var
    NewTop: Integer;
    NewCat: TButtonCategory;
    I: Integer;
    TempBounds, ButtonBounds: TRect;
    YInCat: Integer;
  begin
    NewTop := ClientHeight;
    if not GoForward then
      NewTop := NewTop * -1;

    if CurrentItem <> nil then
      NewTop := GetButtonRect(CurrentItem).Top + FGutterSize * FScrollBarPos
        + NewTop;

    if NewTop < 0 then
      NewTop := 0
    else if NewTop > FButtonCategories[FButtonCategories.Count-1].FEnd then
      NewTop := FButtonCategories[FButtonCategories.Count-1].FEnd - 1;

    { Find where this is at }
    NewCat := nil;
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      if (FButtonCategories[I].Items.Count > 0) and
         (NewTop < FButtonCategories[I].FEnd) then
      begin
        NewCat := FButtonCategories[I];
        Break;
      end;
    end;

    if NewCat <> nil then
    begin
      if NewCat.Collapsed then
        Result := NewCat.Items[0]
      else
      begin
        { Find which button we would be on }
        GetCategoryBounds(NewCat, NewCat.FStart, TempBounds, ButtonBounds);
        YInCat := NewTop - ButtonBounds.Top;
        if YInCat < 0 then
          YInCat := 0;
        I := YInCat div FButtonHeight;
        if YInCat mod FButtonHeight <> 0 then
          Inc(I);
        if I < 0 then
          I := 0
        else if I >= NewCat.Items.Count then
          I := NewCat.Items.Count - 1;
        Result := NewCat.Items[I];
      end;
    end
    else
      Result := nil;
  end;

var
  NewItem: TButtonItem;
  I: Integer;
begin
  CurrentItem := FSelectedItem;
  if CurrentItem = nil then
    CurrentItem := FFocusedItem;

  NewItem := nil;
  if Message.CharCode = VK_DOWN then
    NewItem := GetNext(True)
  else if Message.CharCode = VK_UP then
    NewItem := GetNext(False)
  else if Message.CharCode = VK_LEFT then
  begin
    if CurrentItem <> nil then
    begin
      if CtrlIsDown and not CurrentItem.Category.Collapsed then
        CurrentItem.Category.Collapsed := True
      else
        NewItem := MoveSideways(True)
    end;
  end
  else if Message.CharCode = VK_RIGHT then
  begin
    if CurrentItem <> nil then
    begin
      if CtrlIsDown and CurrentItem.Category.Collapsed then
        CurrentItem.Category.Collapsed := False
      else
        NewItem := MoveSideways(False)
    end;
  end
  else if Message.CharCode = VK_NEXT then
  begin
    NewItem := ChangePage(True);
  end
  else if Message.CharCode = VK_PRIOR then
  begin
    NewItem := ChangePage(False);
  end
  else if (Message.CharCode = VK_RETURN) and (CurrentItem <> nil) then
  begin
    if CurrentItem.Category.Collapsed then
      CurrentItem.Category.Collapsed := False;
    SelectedItem := CurrentItem;
    DoItemClicked(CurrentItem)
  end
  else if Message.CharCode = VK_HOME then
    for I := 0 to Categories.Count - 1 do
    begin
      if Categories[I].Items.Count > 0 then
      begin
        NewItem := Categories[I].Items[0];
        Break;
      end
    end
  else if Message.CharCode = VK_END then
    for I := Categories.Count - 1 downto 0 do
    begin
      if Categories[I].Items.Count > 0 then
      begin
        NewItem := Categories[I].Items[Categories[I].Items.Count - 1];
        Break;
      end
    end
  else if (Message.CharCode = VK_RETURN) and (CurrentItem <> nil) then
  begin
    SelectedItem := CurrentItem;
    DoItemClicked(CurrentItem)
  end
  else
    inherited;

  if NewItem <> nil then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    SelectedItem := NewItem;
  end;
end;

procedure TCategoryButtons.ScrollIntoView(const Button: TButtonItem);
begin
  if Button.Category.Collapsed then
    ScrollIntoView(Button.Category)
  else
    ScrollRectIntoView(GetButtonRect(Button));
end;

procedure TCategoryButtons.CMHintShow(var Message: TCMHintShow);
var
  CurrentItem: TButtonItem;
  CurrentCat: TButtonCategory;
  CatRect: TRect;
  Handled: Boolean;
  HintStr: string;
begin
  Message.Result := 1; { Don't show the hint }
  if Message.HintInfo.HintControl = Self then
  begin
    with Message.HintInfo.CursorPos do
    begin
      CurrentCat := GetCategoryAt(X, Y);
      CurrentItem := GetButtonAt(X, Y, CurrentCat);
    end;

    Handled := False;
    HintStr := '';
    if Assigned(FOnGetHint) then
      FOnGetHint(Self, CurrentItem, CurrentCat, HintStr, Handled);
    if (CurrentItem <> nil) then
    begin
      if not Handled then
      begin
        if CurrentItem.Hint <> '' then
          HintStr := CurrentItem.Hint
        else
          HintStr := CurrentItem.Caption;
        if (CurrentItem.ActionLink <> nil) then
          CurrentItem.ActionLink.DoShowHint(HintStr);
      end;
      Message.HintInfo.CursorRect := GetButtonRect(CurrentItem);
      Handled := True;
    end
    else if (CurrentCat <> nil) then
    begin
      if not Handled then
        HintStr := CurrentCat.Caption;

      CatRect := GetCategoryRect(CurrentCat);
      if not CurrentCat.Collapsed then { exclude the button area on the right }
        CatRect.Right := CatRect.Left + FGutterSize;
      Message.HintInfo.CursorRect := CatRect;

      Handled := True;
    end;
    if Handled then
    begin
      Message.HintInfo.HintStr := HintStr;
      Message.Result := 0; { Show the hint }
    end;
  end;
end;

procedure TCategoryButtons.Assign(Source: TPersistent);
begin
  if Source is TCategoryButtons then
  begin
    Categories := TCategoryButtons(Source).Categories;
    ButtonHeight := TCategoryButtons(Source).ButtonHeight;
    ButtonWidth := TCategoryButtons(Source).ButtonWidth;
    ButtonOptions := TCategoryButtons(Source).ButtonOptions;
  end
  else
    inherited;
end;

procedure TCategoryButtons.SetInsertionButton(InsertionButton: TButtonItem;
  InsertionCategory: TButtonCategory);

  procedure UpdateAll;
  begin
    UpdateButton(FInsertTop);
    UpdateButton(FInsertLeft);
    UpdateButton(FInsertBottom);
    UpdateButton(FInsertRight);
    UpdateWindow(Handle);
  end;

  function CalcActualButtonsPerRow: Integer;
  var
    CatBounds, Temp: TRect;
  begin
    if FButtonFlow = cbfVertical then
      Result := CalcButtonsPerRow
    else
    begin
      GetCategoryBounds(InsertionCategory, 0, CatBounds, Temp);
      Result := (CatBounds.Right - CatBounds.Left) div FButtonWidth;
    end;
  end;

var
  ButtonsPerRow: Integer;

begin
  if (FDragCategory = nil) then
  begin
    ButtonsPerRow := CalcActualButtonsPerRow;
    if (InsertionButton = nil) and (InsertionCategory <> nil) and
       (InsertionCategory.Items.Count > 0) then
    begin
      { Appending a button to the current category }
      if FDragImageList.Dragging then
        FDragImageList.HideDragImage;
      RemoveInsertionPoints;
      InsertionButton := InsertionCategory.Items[InsertionCategory.Items.Count - 1];
      if ButtonsPerRow = 1 then
        FInsertBottom := InsertionButton
      else
        FInsertRight := InsertionButton;
      UpdateAll;
      if FDragImageList.Dragging then
        FDragImageList.ShowDragImage;
    end
    else if ((ButtonsPerRow = 1) and (FInsertTop <> InsertionButton)) or
        ((ButtonsPerRow > 1) and (FInsertLeft <> InsertionButton)) then
    begin
      if FDragImageList.Dragging then
        FDragImageList.HideDragImage;
      RemoveInsertionPoints;
      if ButtonsPerRow = 1 then
      begin
        FInsertTop := InsertionButton;
        FInsertBottom := GetNextButtonInGroup(InsertionButton, False);
      end
      else
      begin
        { More than one button per row, so use Left/Right separators }
        FInsertLeft := InsertionButton;
        FInsertRight := GetNextButtonInGroup(InsertionButton, False);
      end;
      UpdateAll;
      if FDragImageList.Dragging then
        FDragImageList.ShowDragImage;
    end;
  end;
end;

procedure TCategoryButtons.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FDragImageList.EndDrag;
  FDragButton := nil;
  FDragCategory := nil;
  RemoveInsertionPoints;
end;

procedure TCategoryButtons.SetSelectedItem(const Value: TButtonItem);

  procedure UpdateCategory(const Category: TButtonCategory);
  var
    R: TRect;
  begin
    if HandleAllocated then
    begin
      R := GetCategoryRect(Category);
      InvalidateRect(Handle, @R, False);
    end;
  end;

begin
  if FSelectedItem <> Value then
  begin
    if FFocusedItem <> Value then
      UpdateButton(FFocusedItem);

    if FSelectedItem <> nil then
    begin
      UpdateButton(FSelectedItem);
      if FSelectedItem.Category.Collapsed then
        UpdateCategory(FSelectedItem.Category)
    end;
    if Value <> nil then
      ScrollIntoView(Value);
    FSelectedItem := Value;
    if Value <> nil then
      FFocusedItem := Value;
    if FSelectedItem <> nil then
    begin
      UpdateButton(FSelectedItem);
      if FSelectedItem.Category.Collapsed then
        UpdateCategory(FSelectedItem.Category);
    end;
    if not (csDestroying in ComponentState) then
      DoSelectedItemChanged(FSelectedItem);
  end;
end;

function TCategoryButtons.GetIndexOfFirstCategory: Integer;
var
  TopPos: Integer;
  CatIndex: Integer;
begin
  Result := -1;
  TopPos := GetScrollOffset;
  { Avoid drawing hidden categories }
  for CatIndex := 0 to FButtonCategories.Count - 1 do
  begin
    if FButtonCategories[CatIndex].FEnd >= TopPos then
    begin
      Result := CatIndex;
      Exit;
    end;
  end;
end;

function TCategoryButtons.GetCategoryAt(X, Y: Integer): TButtonCategory;
var
  I: Integer;
  CurrentPos: Integer;
begin
  Result := nil;
  { Is it within our X and Y bounds first? }
  if (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
  begin
    { It is, so translate the X or Y position to our virtual system }
    if FButtonFlow = cbfVertical then
      CurrentPos := Y + GetScrollOffset
    else
      CurrentPos := X + GetScrollOffset;
    { Find out which category this X or Y position would lie in }
    for I := 0 to FButtonCategories.Count - 1 do
    begin
      if CurrentPos <= FButtonCategories[I].FEnd then
      begin
        Result := FButtonCategories[I];
        Break;
      end;
    end;
  end;
end;

procedure TCategoryButtons.ScrollIntoView(const Category: TButtonCategory);
begin
  ScrollRectIntoView(GetCategoryRect(Category));
end;

procedure TCategoryButtons.ScrollRectIntoView(const Rect: TRect);
var
  Amount: Integer;

  procedure CalcAmount(const ScrollPixels: Integer);
  begin
    Amount := ScrollPixels div FGutterSize;
    if ScrollPixels mod FGutterSize <> 0 then
      Inc(Amount);
  end;

var
  RectStart, RectEnd, MaxSize: Integer;
begin
  if FButtonFlow = cbfVertical then
  begin
    RectStart := Rect.Top;
    RectEnd := Rect.Bottom;
    MaxSize := ClientHeight;
  end
  else
  begin
    RectStart := Rect.Left;
    RectEnd := Rect.Right;
    MaxSize := ClientWidth;
  end;

  if RectStart < 0 then
  begin
    CalcAmount(-1*RectStart);
    if FScrollBarPos - Amount < 0 then
      Amount := FScrollBarPos;
    ScrollPosChanged(scPosition, FScrollBarPos - Amount);
  end
  else if RectStart > MaxSize then
  begin
    if (RectEnd - RectStart > MaxSize) then
      CalcAmount(RectStart) { Put the start into view at the top}
    else
      CalcAmount(RectEnd - MaxSize); { Put the whole thing into view at the bottom }

    if FScrollBarPos + Amount > FScrollBarMax then
      ScrollPosChanged(scPosition, FScrollBarMax)
    else
      ScrollPosChanged(scPosition, FScrollBarPos + Amount);
  end
  else if RectEnd > MaxSize then
  begin
    CalcAmount(RectEnd - MaxSize);          
    
    if FScrollBarPos + Amount > FScrollBarMax then
      ScrollPosChanged(scPosition, FScrollBarMax)
    else
      ScrollPosChanged(scPosition, FScrollBarPos + Amount);
  end;
end;

function TCategoryButtons.GetCategoryRect(const Category: TButtonCategory): TRect;
var
  YPos: Integer;
  ButtonBounds: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  YPos := Category.FStart - GetScrollOffset;
  GetCategoryBounds(Category, YPos, Result, ButtonBounds);
end;

function TCategoryButtons.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
var
  NextButton: TButtonItem;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    Result := True;
    if (FScrollBarMax > 0) and (Shift = []) then
      ScrollPosChanged(scLineUp, 0)
    else if (FScrollBarMax > 0) and (ssCtrl in Shift) then
      ScrollPosChanged(scPageUp, 0)
    else if ssShift in Shift then
    begin
      NextButton := GetNextButton(SelectedItem, False);
      if NextButton <> nil then
        SelectedItem := NextButton;
    end;
  end;
end;

function TCategoryButtons.GetNextButton(const StartingButton: TButtonItem;
  GoForward: Boolean): TButtonItem;

  function ProcessCategory(const Category: TButtonCategory): TButtonItem;
  begin
    if (not Category.Collapsed) and (Category.Items.Count > 0) then
      if GoForward then
        Result := Category.Items[0]
      else
        Result := Category.Items[Category.Items.Count - 1]
    else
      Result := nil;
  end;

var
  I: Integer;
begin
  if StartingButton <> nil then
  begin
    Result := GetNextButtonInGroup(StartingButton, GoForward);
    if Result = nil then
    begin
      if GoForward then
      begin
        for I := StartingButton.Category.Index + 1 to FButtonCategories.Count -1 do
        begin
          Result := ProcessCategory(FButtonCategories[I]);
          if Result <> nil then
            Break;
        end
      end
      else
      begin
        for I := StartingButton.Category.Index - 1 downto 0 do
        begin
          Result := ProcessCategory(FButtonCategories[I]);
          if Result <> nil then
            Break;
        end
      end;
    end;
  end
  else
    Result := nil;
end;

function TCategoryButtons.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
var
  NextButton: TButtonItem;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    UpdateButton(FHotButton);
    FHotButton := nil;
    Result := True;
    if (FScrollBarMax > 0) and (Shift = []) then
      ScrollPosChanged(scLineDown, 0)
    else if (FScrollBarMax > 0) and (ssCtrl in Shift) then
      ScrollPosChanged(scPageDown, 0)
    else if ssShift in Shift then
    begin
      NextButton := GetNextButton(SelectedItem, True);
      if NextButton <> nil then
        SelectedItem := NextButton;
    end;
  end;
end;

procedure TCategoryButtons.DoReorderCategory(const SourceCategory,
  TargetCategory: TButtonCategory);
begin
  if TargetCategory = nil then
    SourceCategory.Index := FButtonCategories.Count - 1
  else
    SourceCategory.Index := TargetCategory.Index;
//  SourceCategory.ScrollIntoView;
//  if Assigned(FOnReorderCategory) then
  //  FOnReorderCategory(Self, SourceCategory, TargetCategory);
end;

function TCategoryButtons.GetScrollBuffer: Integer;
begin
  Result := FGutterSize * 2;
  if Result < 6 then
    Result := 6;
end;

procedure TCategoryButtons.SetFocusedItem(const Value: TButtonItem);
begin
  if FFocusedItem <> Value then
  begin
    FFocusedItem := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.DoSelectedItemChanged(
  const Button: TButtonItem);
begin
  if Assigned(FOnSelectedItemChange) then
    FOnSelectedItemChange(Self, Button);
end;

procedure TCategoryButtons.DoCopyButton(const Button: TButtonItem;
  const TargetCategory: TButtonCategory; const TargetButton: TButtonItem);
var
  CopiedButton: TButtonItem;
begin
  CopiedButton := TargetCategory.Items.Add;
  if TargetButton <> nil then
    CopiedButton.Index := TargetButton.Index;
  CopiedButton.Assign(Button);

  if Assigned(FOnCopyButton) then
    FOnCopyButton(Self, Button, CopiedButton);
end;

procedure TCategoryButtons.SetHotButtonColor(const Value: TColor);
begin
  if FHotButtonColor <> Value then
  begin
    FHotButtonColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetRegularButtonColor(const Value: TColor);
begin
  if FRegularButtonColor <> Value then
  begin
    FRegularButtonColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetSelectedButtonColor(const Value: TColor);
begin
  if FSelectedButtonColor <> Value then
  begin
    FSelectedButtonColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetButtonFlow(const Value: TCatButtonFlow);
var
  OldFlow: TCatButtonFlow;
begin
  if FButtonFlow <> Value then
  begin
    OldFlow := FButtonFlow;
    FButtonFlow := Value; { Set the flow }
    CalcBufferSizes;
    FScrollBarPos := 0; { Nothing scrolled }
    { Hide the previous scroll bar, if shown, which will cause a resize }
    if FScrollBarShown then
    begin
      FScrollBarShown := False;
      Windows.ShowScrollBar(Handle, cScrollBarKind[OldFlow], False);
    end
    else
    begin
      { We have to resize }
      Resize;
      Invalidate;
    end;
  end;
end;

procedure TCategoryButtons.SetGradientDirection(
  const Value: TGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if not (csDestroying in ComponentState) then
    UpdateButton(FFocusedItem);
end;

procedure TCategoryButtons.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  UpdateButton(FFocusedItem);
end;

procedure TCategoryButtons.CMFontchanged(var Message: TMessage);
begin
  inherited;
  CalcBufferSizes;
  Invalidate;
end;

function TCategoryButtons.GetButtonCategoriesClass: TButtonCategoriesClass;
begin
  Result := TButtonCategories;
end;

function TCategoryButtons.GetButtonCategoryClass: TButtonCategoryClass;
begin
  Result := TButtonCategory;
end;

function TCategoryButtons.GetButtonItemClass: TButtonItemClass;
begin
  Result := TButtonItem;
end;

procedure TCategoryButtons.SetDragButton(const Value: TButtonItem);
begin
  FDragButton := Value;
  FDragStarted := True;
  FDragStartPos := ScreenToClient(Mouse.CursorPos);
end;

procedure TCategoryButtons.DoBeginDrag(Immediate: Boolean; Threshold: Integer);
begin
  BeginDrag(Immediate, Threshold);
end;

function TCategoryButtons.GetAllowReorder: Boolean;
begin
  Result := boAllowReorder in ButtonOptions;
end;

procedure TCategoryButtons.SetBackgroundGradientColor(const Value: TColor);
begin
  if FBackgroundGradientColor <> Value then
  begin
    FBackgroundGradientColor := Value;
    Invalidate;
  end;
end;

procedure TCategoryButtons.SetBackGradientDirection(
  const Value: TGradientDirection);
begin
  if FBackGradientDirection <> Value then
  begin
    FBackGradientDirection := Value;
    Invalidate;
  end;
end;

function TCategoryButtons.GetScrollPos: Integer;
begin
  Result := FScrollBarPos;
end;

procedure TCategoryButtons.SetScrollPos(const Value: Integer);
begin
  if FScrollBarPos <> Value then
  begin
    FScrollBarPos := Value;
    if Categories.UpdateCount = 0 then
      Resize;
  end;
end;

{ TBaseButtonItem }

procedure TBaseButtonItem.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;
end;

procedure TBaseButtonItem.Assign(Source: TPersistent);
begin
  if Source is TBaseButtonItem then
  begin
    Caption := TBaseButtonItem(Source).Caption;
    ImageIndex := TBaseButtonItem(Source).ImageIndex;
    Hint := TBaseButtonItem(Source).Hint;
    Data := TBaseButtonItem(Source).Data;
  end
  else
    inherited Assign(Source);
end;

constructor TBaseButtonItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
end;

procedure TBaseButtonItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TBaseButtonItem.GetAction: TBasicAction;
begin
  if ActionLink <> nil then
    Result := ActionLink.Action
  else
    Result := nil;
end;

function TBaseButtonItem.GetActionLinkClass: TButtonItemActionLinkClass;
begin
  Result := TButtonItemActionLink;
end;

function TBaseButtonItem.GetDisplayName: string;
begin
  Result := Caption;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

function TBaseButtonItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsCaptionLinked;
end;

function TBaseButtonItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsHintLinked;
end;

function TBaseButtonItem.IsImageIndexStored: Boolean;
begin
  Result := (FImageIndex <> -1) and ((ActionLink = nil) or not ActionLink.IsImageIndexLinked);
end;

function TBaseButtonItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not ActionLink.IsOnExecuteLinked;
end;

procedure TBaseButtonItem.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
  begin
    ActionLink.Free;
    ActionLink := nil;
  end
  else
  begin
    if ActionLink = nil then
      ActionLink := GetActionLinkClass.Create(Self);
    ActionLink.Action := Value;
    ActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
    Value.FreeNotification(GetNotifyTarget);
  end;
end;

procedure TBaseButtonItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TBaseButtonItem.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

{ TButtonItem }

procedure TButtonItem.Assign(Source: TPersistent);
begin
  if Source is TButtonItem then
  begin
    inherited Assign(Source);
    InterfaceData := TButtonItem(Source).InterfaceData;
  end
  else
    inherited Assign(Source);
end;

function TButtonItem.GetButtonGroup: TCategoryButtons;
begin
  Result := Category.Categories.ButtonGroup;
end;

function TButtonItem.GetCategory: TButtonCategory;
begin
  Result := TButtonCollection(Collection).Category;
end;

function TButtonItem.GetNotifyTarget: TComponent;
begin
  Result := TComponent(ButtonGroup);
end;

procedure TButtonItem.ScrollIntoView;
begin
  TCategoryButtons(ButtonGroup).ScrollIntoView(Self);
end;

{ TButtonCollection }

function TButtonCollection.Add: TButtonItem;
begin
  Result := TButtonItem(inherited Add);
end;

function TButtonCollection.AddItem(Item: TButtonItem;
  Index: Integer): TButtonItem;
begin
  if Item = nil then
    Result := FCategory.Categories.ButtonGroup.GetButtonItemClass.Create(Self)
  else
    Result := Item;
  if Assigned(Result) then
  begin
    Result.Collection := Self;
    if Index < 0 then
      Index := Count - 1;
    Result.Index := Index;
  end;
end;

constructor TButtonCollection.Create(const ACategory: TButtonCategory);
begin
  inherited Create(ACategory.Categories.ButtonGroup.GetButtonItemClass);
  FCategory := ACategory;
end;

function TButtonCollection.GetItem(Index: Integer): TButtonItem;
begin
  Result := TButtonItem(inherited GetItem(Index));
end;

function TButtonCollection.GetOwner: TPersistent;
begin
  Result := FCategory;
end;

function TButtonCollection.Insert(Index: Integer): TButtonItem;
begin
  Result := AddItem(nil, Index);
end;

procedure TButtonCollection.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
var
  ButtonGroup: TCategoryButtons;
begin
  if (Action <> cnAdded) and (FCategory <> nil) then
  begin
    ButtonGroup := FCategory.Categories.ButtonGroup;
    if not (csDestroying in ButtonGroup.ComponentState) then
    begin
      if Item = ButtonGroup.FDownButton then
        ButtonGroup.FDownButton := nil;
      if Item = ButtonGroup.FDragButton then
        ButtonGroup.FDragButton := nil;
      if Item = ButtonGroup.FHotButton then
        Buttongroup.FHotButton := nil;
      if Item = ButtonGroup.FSelectedItem then
        ButtonGroup.SelectedItem := nil;
      if Item = ButtonGroup.FFocusedItem then
        ButtonGroup.FFocusedItem := nil;
    end;
  end;
  inherited;
end;

procedure TButtonCollection.SetItem(Index: Integer; const Value: TButtonItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TButtonCollection.Update(Item: TCollectionItem);
var
  ButtonGroup: TCategoryButtons;
begin
  inherited;
  if (UpdateCount = 0) and (FCategory.Categories.UpdateCount = 0) then
  begin                          
    ButtonGroup := FCategory.Categories.ButtonGroup;
    if not ButtonGroup.FIgnoreUpdate then
    begin
      if Item <> nil then
        ButtonGroup.UpdateButton(Item as TButtonItem)
      else
      begin
        ButtonGroup.Resize;
        ButtonGroup.UpdateAllButtons;
      end;
    end;
  end;
end;

{ TButtonCategories }

function TButtonCategories.Add: TButtonCategory;
begin
  Result := TButtonCategory(inherited Add);
end;

function TButtonCategories.AddItem(Item: TButtonCategory;
  Index: Integer): TButtonCategory;
begin
  if Item = nil then
    Result := FButtonGroup.GetButtonCategoryClass.Create(Self)
  else
    Result := Item;
  if Assigned(Result) then
  begin
    Result.Collection := Self;
    if Index < 0 then
      Index := Count - 1;
    Result.Index := Index;
  end;
end;

procedure TButtonCategories.BeginUpdate;
begin
  if UpdateCount = 0 then
    if FButtonGroup.SelectedItem <> nil then
      FOriginalID := FButtonGroup.SelectedItem.ID
    else
      FOriginalID := -1;
  inherited;
end;

constructor TButtonCategories.Create(const ButtonGroup: TCategoryButtons);
begin
  inherited Create(ButtonGroup.GetButtonCategoryClass);
  FButtonGroup := ButtonGroup;
  FOriginalID := -1;  
end;

function TButtonCategories.GetItem(Index: Integer): TButtonCategory;
begin
  Result := TButtonCategory(inherited GetItem(Index));
end;

function TButtonCategories.GetOwner: TPersistent;
begin
  Result := FButtonGroup;
end;

function TButtonCategories.IndexOf(const Caption: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
  begin
    if SameText(Items[I].Caption, Caption) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TButtonCategories.Insert(Index: Integer): TButtonCategory;
begin
  Result := AddItem(nil, Index);
end;

procedure TButtonCategories.SetItem(Index: Integer;
  const Value: TButtonCategory);
begin
  inherited SetItem(Index, Value);
end;

procedure TButtonCategories.Update(Item: TCollectionItem);
begin
  inherited;
  if (UpdateCount = 0) and (not FButtonGroup.FIgnoreUpdate) then
  begin
    FButtonGroup.Resize;
    FButtonGroup.UpdateAllButtons;
  end;
end;

{ TButtonCategory }
var
  GLastPreset: Integer = 0;

procedure TButtonCategory.Assign(Source: TPersistent);
begin
  if Source is TButtonCategory then
  begin
    Caption := TButtonCategory(Source).Caption;
    Color := TButtonCategory(Source).Color;
    GradientColor := TButtonCategory(Source).GradientColor;
    TextColor := TButtonCategory(Source).TextColor;
    Collapsed := TButtonCategory(Source).Collapsed;
    Data := TButtonCategory(Source).Data;
    InterfaceData := TButtonCategory(Source).InterfaceData;
  end
  else
    inherited Assign(Source);
end;

constructor TButtonCategory.Create(Collection: TCollection);
const
  cMaxPresets = 10;
  cPresetColors: array[0..cMaxPresets-1] of TColor = ($00FFEAFF, $00F4F4F4, $00EAEBFF,
    $00FFEAFF, $00FFEAEA, $00EAFFFF, $00FFFFEA, $00EAEBFF, $00EBFFEA, $00FFEAEA);
begin
  inherited Create(Collection);
  FGradientColor := clNone;
  FTextColor := clWindowText;
  FItems := TButtonCollection.Create(Self);
  with TButtonCategories(Collection).ButtonGroup do
    FColor := cPresetColors[GLastPreset];
  Inc(GLastPreset);
  if GLastPreset >= cMaxPresets then
    GLastPreset := 0;
end;

destructor TButtonCategory.Destroy;
begin
  if (Categories <> nil) and (Categories.ButtonGroup <> nil) and
     (Categories.ButtonGroup.SelectedItem <> nil) then
  begin
    if Categories.ButtonGroup.SelectedItem.Category = Self then
      Categories.ButtonGroup.SelectedItem := nil;
  end;
  FItems.Free;
  inherited;
end;

function TButtonCategory.GetCategories: TButtonCategories;
begin
  Result := TButtonCategories(Collection);
end;

function TButtonCategory.IndexOf(const Caption: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Items.Count - 1 do
  begin
    if SameText(Items[I].Caption, Caption) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TButtonCategory.ScrollIntoView;
begin
  Categories.ButtonGroup.ScrollIntoView(Self);
end;

procedure TButtonCategory.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TButtonCategory.SetCollapsed(const Value: Boolean);
begin
  if FCollapsed <> Value then
  begin
    FCollapsed := Value;
    Changed(True);
    if Assigned(Categories.ButtonGroup.OnCategoryCollapase) then
      Categories.ButtonGroup.OnCategoryCollapase(Categories.ButtonGroup, Self);
  end;
end;

procedure TButtonCategory.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed(False);
  end;
end;

procedure TButtonCategory.SetGradientColor(const Value: TColor);
begin
  if FGradientColor <> Value then
  begin
    FGradientColor := Value;
    Changed(False);
  end;
end;

procedure TButtonCategory.SetIndex(Value: Integer);
var
  TargetCategory: TButtonCategory;
begin
  if Value <> Index then
  begin
    if Index < Categories.Count then
      TargetCategory := Categories[Value]
    else
      TargetCategory := nil;
    inherited;
    ScrollIntoView;
    if Assigned(Categories.ButtonGroup.FOnReorderCategory) then
      Categories.ButtonGroup.FOnReorderCategory(Categories.ButtonGroup,
        Self, TargetCategory);
  end;
end;

procedure TButtonCategory.SetItems(const Value: TButtonCollection);
begin
  FItems.Assign(Value);
end;

procedure TButtonCategory.SetTextColor(const Value: TColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Changed(False);
  end;
end;

{ TButtonItemActionLink }

procedure TButtonItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TBaseButtonItem;
end;

function TButtonItemActionLink.DoShowHint(var HintStr: string): Boolean;
begin
  Result := True;
  if Action is TCustomAction then
    TCustomAction(Action).DoHint(HintStr);
end;

function TButtonItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TButtonItemActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TButtonItemActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TButtonItemActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    (((not Assigned(FClient.OnClick)) and (not Assigned(Action.OnExecute))) or
     (Assigned(FClient.OnClick) and (@FClient.OnClick = @Action.OnExecute)));
end;

procedure TButtonItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TButtonItemActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TButtonItemActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TButtonItemActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

initialization
  { Add our drag/copy cursor image }
  Screen.Cursors[crDragCopy] := LoadCursor(HInstance, PChar('CAT_DRAG_COPY')); { Do not localize }

end.

