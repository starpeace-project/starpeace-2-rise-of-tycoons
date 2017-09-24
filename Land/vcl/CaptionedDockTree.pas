{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit CaptionedDockTree;

interface

uses Windows, Controls, Graphics, Messages, SysUtils;

type
  /// <summary>
  /// TParentFormState: stores information about the parent dock form for
  /// use in drawing the dock site
  /// </summary>
  TParentFormState = record
    Caption: string;
    StartColor, EndColor, FontColor: TColor;
    Focused: Boolean;
    Icon: TIcon;
  end;

  TDockCaptionOrientation = (dcoHorizontal, dcoVertical);

  /// <summary>
  /// Hit tests for the caption. Note: The custom values allow you
  /// to return your own hit test results for your own drawer.
  /// </summary>
  TDockCaptionHitTest = Cardinal;
  /// <summary>
  /// The pin button style to draw, if any.
  /// </summary>
  TDockCaptionPinButton = (dcpbNone, dcpbUp, dcpbDown);

  TDockCaptionDrawer = class(TObject)
  private
    FDockCaptionOrientation: TDockCaptionOrientation;
    FDockCaptionPinButton: TDockCaptionPinButton;
    function GetCloseRect(const CaptionRect: TRect): TRect;
    function GetPinRect(const CaptionRect: TRect): TRect;
    function CalcButtonSize(const CaptionRect: TRect): Integer;
  public
    procedure DrawDockCaption(const Canvas: TCanvas;
      CaptionRect: TRect; State: TParentFormState); virtual;
    function DockCaptionHitTest(const CaptionRect: TRect;
      const MousePos: TPoint): TDockCaptionHitTest; virtual;
    /// <summary>
    /// Creates an instance of the TDockCaptionDrawer. It is virtual so the
    /// call to TCaptionedDockTree.GetDockCaptionDrawer.Create(..) will
    /// be called on the correct type.
    /// </summary>
    constructor Create(DockCaptionOrientation: TDockCaptionOrientation); virtual;
    property DockCaptionPinButton: TDockCaptionPinButton read FDockCaptionPinButton write FDockCaptionPinButton;
  end;

  TDockCaptionDrawerClass = class of TDockCaptionDrawer;

  TCaptionedDockTree = class(TDockTree)
  private
    FGrabberSize: Integer;
    FDockCaptionOrientation: TDockCaptionOrientation;
    FDockCaptionDrawer: TDockCaptionDrawer;
    procedure InvalidateDockSite(const Client: TControl);
  protected
    function AdjustCaptionRect(const ARect: TRect): TRect; virtual;
    procedure AdjustDockRect(Control: TControl; var ARect: TRect); override;
    function InternalCaptionHitTest(const Zone: TDockZone;
      const MousePos: TPoint): TDockCaptionHitTest;
    procedure PaintDockFrame(Canvas: TCanvas; Control: TControl;
      const ARect: TRect); override;
    function ZoneCaptionHitTest(const Zone: TDockZone;
      const MousePos: TPoint; var HTFlag: Integer): Boolean; override;
    property DockCaptionOrientation: TDockCaptionOrientation read FDockCaptionOrientation;
    property DockCaptionDrawer: TDockCaptionDrawer read FDockCaptionDrawer;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(DockSite: TWinControl); overload; override;
    constructor Create(DockSite: TWinControl;
      ADockCaptionOrientation: TDockCaptionOrientation); reintroduce; overload;
    destructor Destroy; override;
    class function GetParentFormState(const Control: TControl): TParentFormState; virtual;
    class function GetDockCaptionDrawer: TDockCaptionDrawerClass; virtual;
  end;

  TCaptionedDockTreeClass = class of TCaptionedDockTree;

const
  /// <summary>
  /// TDockCaptionHitTest constant values used. You can use your own values,
  /// but start at the dchtCustom value. Items 4-9 are reserved for future
  /// VCL use, and the value of dchtCustom may change.
  /// </summary>
  dchtNone = 0;
  dchtCaption = 1;
  dchtClose = 2;
  dchtPin = 3;
  dchtCustom = 10;

implementation

uses Types, Forms, GraphUtil;

{ TCaptionedDockTree }

procedure TCaptionedDockTree.AdjustDockRect(Control: TControl;
  var ARect: TRect);
begin
  if FDockCaptionOrientation = dcoHorizontal then
    Inc(ARect.Top, FGrabberSize)
  else
    Inc(ARect.Left, FGrabberSize)
end;

constructor TCaptionedDockTree.Create(DockSite: TWinControl);
begin
  inherited;
                                                            
  FGrabberSize := GetSystemMetrics(SM_CYMENUSIZE) + 4;
  FDockCaptionDrawer := GetDockCaptionDrawer.Create(FDockCaptionOrientation);
end;

constructor TCaptionedDockTree.Create(DockSite: TWinControl;
  ADockCaptionOrientation: TDockCaptionOrientation);
begin
  FDockCaptionOrientation := ADockCaptionOrientation;
  Create(DockSite);
end;

class function TCaptionedDockTree.GetParentFormState(const Control: TControl): TParentFormState;
begin
  if Control is TCustomForm then
  begin
    Result.Caption := TCustomForm(Control).Caption;
    Result.Focused := (Screen.ActiveControl <> nil) and
      Screen.ActiveControl.Focused and
      (TWinControl(Control).ContainsControl(Screen.ActiveControl));
    if Control is TForm then
      Result.Icon := TForm(Control).Icon
    else
      Result.Icon := nil;
  end
  else
  begin
    Result.Caption := '';
    Result.Focused := False;
    Result.Icon := nil;
  end;
  if Result.Focused then
  begin
    Result.StartColor := clActiveBorder;
    Result.EndColor := GetHighlightColor(clActiveBorder, 22);
    Result.FontColor := clBtnText;
  end
  else
  begin
    Result.StartColor := GetHighlightColor(clBtnFace, 5);
    Result.EndColor := GetHighlightColor(clBtnFace, 15);
    Result.FontColor := clBtnText;
  end;
end;

procedure TCaptionedDockTree.InvalidateDockSite(const Client: TControl);
var
  ParentForm: TCustomForm;
  Rect: TRect;
begin
  ParentForm := GetParentForm(Client, False);
  { Just invalidate the parent form's rect in the HostDockSite
    so that we can "follow focus" on docked items. }
  if (ParentForm <> nil) and (ParentForm.HostDockSite <> nil) then
  begin
    with ParentForm.HostDockSite do
      if UseDockManager and (DockManager <> nil) then
      begin
        DockManager.GetControlBounds(ParentForm, Rect);
        InvalidateRect(Handle, @Rect, False);
      end;
  end;
end;

function TCaptionedDockTree.AdjustCaptionRect(const ARect: TRect): TRect;
begin
  Result := ARect;
  if FDockCaptionOrientation = dcoHorizontal then
  begin
    Result.Bottom := Result.Top + FGrabberSize - 1;
    Result.Top := Result.Top + 1;
    Result.Right := Result.Right - 3; { Shrink the rect a little }
  end
  else
  begin
    Result.Right := Result.Left + FGrabberSize - 1;
    Result.Left := Result.Left + 1;
    Result.Bottom := Result.Bottom - 3;
  end;
end;

procedure TCaptionedDockTree.PaintDockFrame(Canvas: TCanvas;
  Control: TControl; const ARect: TRect);
begin
  FDockCaptionDrawer.DrawDockCaption(Canvas,
    AdjustCaptionRect(ARect),
    GetParentFormState(Control));
end;

procedure TCaptionedDockTree.WndProc(var Message: TMessage);
begin
  if Message.Msg = CM_DOCKNOTIFICATION then
  begin
    with TCMDockNotification(Message) do
    begin
      if NotifyRec.ClientMsg = CM_INVALIDATEDOCKHOST then
        InvalidateDockSite(TControl(NotifyRec.MsgWParam))
      else
        inherited;
    end;
  end
  else
    inherited;
end;

function TCaptionedDockTree.InternalCaptionHitTest(const Zone: TDockZone;
  const MousePos: TPoint): TDockCaptionHitTest;
var
  FrameRect, CaptionRect: TRect;
begin
  FrameRect := Zone.ChildControl.BoundsRect;
  AdjustDockRect(Zone.ChildControl, FrameRect);
  AdjustFrameRect(Zone.ChildControl, FrameRect);
  CaptionRect := AdjustCaptionRect(FrameRect);
  Result := FDockCaptionDrawer.DockCaptionHitTest(CaptionRect, MousePos);
end;

function TCaptionedDockTree.ZoneCaptionHitTest(const Zone: TDockZone;
  const MousePos: TPoint; var HTFlag: Integer): Boolean;
var
  HitTest: TDockCaptionHitTest;
begin
  HitTest := InternalCaptionHitTest(Zone, MousePos);
  if HitTest = dchtNone then
    Result := False
  else
  begin
    Result := True;
    if HitTest = dchtClose then
      HTFlag := HTCLOSE
    else if HitTest = dchtCaption then
      HTFlag := HTCAPTION;
  end;
end;

destructor TCaptionedDockTree.Destroy;
begin
  FDockCaptionDrawer.Free;
  inherited;
end;

class function TCaptionedDockTree.GetDockCaptionDrawer: TDockCaptionDrawerClass;
begin
  Result := TDockCaptionDrawer;
end;

{ TDockCaptionDrawer }

function TDockCaptionDrawer.CalcButtonSize(
  const CaptionRect: TRect): Integer;
const
  cButtonBuffer = 8;
begin
  if FDockCaptionOrientation = dcoHorizontal then
    Result := CaptionRect.Bottom - CaptionRect.Top - cButtonBuffer
  else
    Result := CaptionRect.Right - CaptionRect.Left - cButtonBuffer;
end;

constructor TDockCaptionDrawer.Create(
  DockCaptionOrientation: TDockCaptionOrientation);
begin
  FDockCaptionOrientation := DockCaptionOrientation;
end;

function TDockCaptionDrawer.DockCaptionHitTest(const CaptionRect: TRect;
  const MousePos: TPoint): TDockCaptionHitTest;
var
  CloseRect, PinRect: TRect;
begin
  if PtInRect(CaptionRect, MousePos) then
  begin
    CloseRect := GetCloseRect(CaptionRect);
    { Make the rect vertically the same size as the captionrect }
    if FDockCaptionOrientation = dcoHorizontal then
    begin
      CloseRect.Top := CaptionRect.Top;
      CloseRect.Bottom := CaptionRect.Bottom;
      Inc(CloseRect.Right);
    end
    else
    begin
      CloseRect.Left := CaptionRect.Left;
      CloseRect.Right := CaptionRect.Right;
      Inc(CloseRect.Bottom);
    end;
    if PtInRect(CloseRect, MousePos) then
      Result := dchtClose
    else if FDockCaptionPinButton <> dcpbNone then
    begin
      { did it hit the pin? }
      if FDockCaptionOrientation = dcoHorizontal then
      begin
        PinRect := GetPinRect(CaptionRect);
        PinRect.Top := CaptionRect.Top;
        PinRect.Bottom := CaptionRect.Bottom;
        Inc(PinRect.Right);
      end
      else
      begin
        PinRect := GetPinRect(CaptionRect);
        PinRect.Left := CaptionRect.Left;
        PinRect.Right := CaptionRect.Right;
        Inc(PinRect.Bottom);
      end;

      if PtInRect(PinRect, MousePos) then
        Result := dchtPin
      else
        Result := dchtCaption;
    end
    else
      Result := dchtCaption
  end
  else
    Result := dchtNone;
end;

procedure TDockCaptionDrawer.DrawDockCaption(const Canvas: TCanvas;
  CaptionRect: TRect; State: TParentFormState);

  procedure DrawCloseButton(const ARect: TRect);
  begin
    with ARect do
    begin
      Canvas.Pen.Color := Canvas.Font.Color;
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Width := 2;
      Canvas.MoveTo(Left+1, Top+1);
      Canvas.LineTo(Right-1, Bottom-1);
      Canvas.MoveTo(Left+1, Bottom-1);
      Canvas.LineTo(Right-1, Top+1);
    end;
  end;

  procedure DrawPinButton(const ARect: TRect);
  var
    Left, Top: Integer;
  begin
    Left := ARect.Left;
    Top := ARect.Top;

    Canvas.Pen.Color := Canvas.Font.Color;
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 1;

    if FDockCaptionPinButton = dcpbDown then
    begin
      Inc(Top);
      { Draw the top box }
      Canvas.MoveTo(Left + 1, Top + 4);
      Canvas.LineTo(Left + 1, Top);
      Canvas.LineTo(Left + 5, Top);
      Canvas.LineTo(Left + 5, Top + 5);
      { Draw the middle line }
      Canvas.MoveTo(Left, Top + 5);
      Canvas.LineTo(Left + 7, Top + 5);
      { Draw a depth line }
      Canvas.MoveTo(Left + 4, Top + 1);
      Canvas.LineTo(Left + 4, Top + 5);
      Canvas.MoveTo(Left + 3, Top + 6);
      Canvas.LineTo(Left + 3, Top + 6 + 4);
    end
    else
    begin
      { Draw the right box }
      Canvas.MoveTo(Left + 4, Top + 1);
      Canvas.LineTo(Left + 9, Top + 1);
      Canvas.LineTo(Left + 9, Top + 5);
      Canvas.LineTo(Left + 3, Top + 5);
      { Draw the middle line }
      Canvas.MoveTo(Left + 3, Top);
      Canvas.LineTo(Left + 3, Top + 7);
      { Draw a depth line }
      Canvas.MoveTo(Left + 4, Top + 4);
      Canvas.LineTo(Left + 9, Top + 4);
      Canvas.MoveTo(Left, Top + 3);
      Canvas.LineTo(Left + 3, Top + 3);
    end;
  end;

  function RectWidth(const Rect: TRect): Integer;
  begin
    Result := Rect.Right - Rect.Left;
  end;

  procedure DrawIcon;
  var
    FormBitmap: TBitmap;
    DestBitmap: TBitmap;
    ImageSize: Integer;
    X, Y: Integer;
  begin
    if (State.Icon <> nil) and (State.Icon.HandleAllocated) then
    begin
      if FDockCaptionOrientation = dcoHorizontal then
      begin
        ImageSize := CaptionRect.Bottom - CaptionRect.Top - 3;
        X := CaptionRect.Left;
        Y := CaptionRect.Top + 2;
      end
      else
      begin
        ImageSize := CaptionRect.Right - CaptionRect.Left - 3;
        X := CaptionRect.Left + 1;
        Y := CaptionRect.Top;
      end;

      FormBitmap := nil;
      DestBitmap := TBitmap.Create;
      try
        FormBitmap := TBitmap.Create;
        DestBitmap.Width :=  ImageSize;
        DestBitmap.Height := ImageSize;
        DestBitmap.Canvas.Brush.Color := clFuchsia;
        DestBitmap.Canvas.FillRect(Rect(0, 0, DestBitmap.Width, DestBitmap.Height));
        FormBitmap.Width := State.Icon.Width;
        FormBitmap.Height := State.Icon.Height;
        FormBitmap.Canvas.Draw(0, 0, State.Icon);
        ScaleImage(FormBitmap, DestBitmap, DestBitmap.Width / FormBitmap.Width);

        DestBitmap.TransparentColor := DestBitmap.Canvas.Pixels[0, DestBitmap.Height - 1];
        DestBitmap.Transparent := True;

        Canvas.Draw(X, Y, DestBitmap);
      finally
        FormBitmap.Free;
        DestBitmap.Free;
      end;

      if FDockCaptionOrientation = dcoHorizontal then
        CaptionRect.Left := CaptionRect.Left + 6 + ImageSize
      else
        CaptionRect.Top := CaptionRect.Top + 6 + ImageSize;
    end;
  end;

var
  ShouldDrawClose: Boolean;
  CloseRect, PinRect: TRect;
begin
  Canvas.Font.Color := State.FontColor;
  Canvas.Pen.Width := 1;
  Canvas.Pen.Color := State.StartColor;

  if FDockCaptionOrientation = dcoHorizontal then
  begin
    CaptionRect.Top := CaptionRect.Top + 1;

    { Give a rounded effect, draw a slightly smaller line on the left }
    Canvas.MoveTo(CaptionRect.Left + 2, CaptionRect.Top + 2);
    Canvas.LineTo(CaptionRect.Left + 2, CaptionRect.Bottom - 1);

    { Fill the middle with a gradient }
    GradientFillCanvas(Canvas, State.StartColor, State.EndColor,
      Rect(CaptionRect.Left+3, CaptionRect.Top, CaptionRect.Right,
      CaptionRect.Bottom), gdVertical);

    { Draw a slight outline }
    Canvas.Pen.Color := GetShadowColor(Canvas.Pen.Color, -20);
    with CaptionRect do
      Canvas.Polyline([Point(Left + 3, Top),
        Point(Right - 2, Top), { Top line }
        Point(Right, Top + 2), { Top right curve }
        Point(Right, Bottom - 2), { Right side line }
        Point(Right - 2, Bottom), { Bottom right curve }
        Point(Left + 3, Bottom), { Bottom line }
        Point(Left+1, Bottom - 2), { Bottom left curve }
        Point(Left+1, Top + 2), { Left side line }
        Point(Left + 3, Top)]); { Top left curve }


    { Get the close rect size/position }
    CloseRect := GetCloseRect(CaptionRect);
    { Does it have the pin button? Make some room for it, and draw it. }
    if FDockCaptionPinButton <> dcpbNone then
    begin
      PinRect := GetPinRect(CaptionRect);
      if FDockCaptionPinButton = dcpbUp then
        Inc(PinRect.Top); { Down a little further - better looks }
      DrawPinButton(PinRect);
      CaptionRect.Right := PinRect.Right - 2;
    end
    else
      { Shrink the rect to consider the close button on the right, and
        not draw text in it. }
      CaptionRect.Right := CloseRect.Right - 2;
    { Move away from the left edge a little before drawing text }
    CaptionRect.Left := CaptionRect.Left + 6;
    { Draw the icon, if found. }
    DrawIcon;
    ShouldDrawClose := CloseRect.Left >= CaptionRect.Left;
  end
  else
  begin
    { Give a rounded effect }
    Canvas.MoveTo(CaptionRect.Left + 1, CaptionRect.Top + 1);
    Canvas.LineTo(CaptionRect.Right - 1, CaptionRect.Top + 1);

    GradientFillCanvas(Canvas, State.StartColor, State.EndColor,
      Rect(CaptionRect.Left, CaptionRect.Top+2, CaptionRect.Right,
      CaptionRect.Bottom), gdVertical);

    Canvas.Pen.Color := State.EndColor;
    Canvas.MoveTo(CaptionRect.Left + 1, CaptionRect.Bottom);
    Canvas.LineTo(CaptionRect.Right - 1, CaptionRect.Bottom);

    Canvas.Font.Orientation := 900; { 90 degrees upwards }
    { Get the close rect size/position }
    CloseRect := GetCloseRect(CaptionRect);

    { Does it have the pin button? Make some room for it, and draw it. }
    if FDockCaptionPinButton <> dcpbNone then
    begin
      PinRect := GetPinRect(CaptionRect);
      DrawPinButton(PinRect);
      CaptionRect.Top := PinRect.Bottom + 2;
    end
    else
      { Add a little spacing between the close button and the text }
      CaptionRect.Top := CloseRect.Bottom + 2;

    ShouldDrawClose := CaptionRect.Top < CaptionRect.Bottom;
    { Make the captionrect horizontal for proper clipping }
    CaptionRect.Right := CaptionRect.Left + (CaptionRect.Bottom - CaptionRect.Top - 2);
    { Position the caption starting position at most at the bottom of the
      rectangle }
    CaptionRect.Top := CaptionRect.Top + Canvas.TextWidth(State.Caption) + 2;

    if CaptionRect.Top > CaptionRect.Bottom then
      CaptionRect.Top := CaptionRect.Bottom;
  end;

  Canvas.Brush.Style := bsClear; { For drawing the font }
  if State.Caption <> '' then
  begin
    if State.Focused then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold]
    else
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];

   if ShouldDrawClose then
     CaptionRect.Right := CaptionRect.Right - (CloseRect.Right - CloseRect.Left) - 4;

    Canvas.TextRect(CaptionRect, State.Caption,
      [tfEndEllipsis, tfVerticalCenter, tfSingleLine]);
  end;

  if ShouldDrawClose then
    DrawCloseButton(CloseRect);
end;

const
  cSideBuffer = 4;

function TDockCaptionDrawer.GetCloseRect(const CaptionRect: TRect): TRect;
var
  CloseSize: Integer;
begin
  CloseSize := CalcButtonSize(CaptionRect);
  if FDockCaptionOrientation = dcoHorizontal then
  begin
    Result.Left := CaptionRect.Right - CloseSize - cSideBuffer;
    Result.Top := CaptionRect.Top + ((CaptionRect.Bottom - CaptionRect.Top) - CloseSize) div 2;
  end
  else
  begin
    Result.Left := CaptionRect.Left + ((CaptionRect.Right - CaptionRect.Left) - CloseSize) div 2;
    Result.Top := CaptionRect.Top + 2*cSideBuffer;
  end;
  Result.Right := Result.Left + CloseSize;
  Result.Bottom := Result.Top + CloseSize;
end;

function TDockCaptionDrawer.GetPinRect(const CaptionRect: TRect): TRect;
var
  PinSize: Integer;
begin
  PinSize := CalcButtonSize(CaptionRect);
  if FDockCaptionOrientation = dcoHorizontal then
  begin
    Result.Left := CaptionRect.Right - 2*PinSize - 2*cSideBuffer;
    Result.Top := CaptionRect.Top + ((CaptionRect.Bottom - CaptionRect.Top) - PinSize) div 2;
  end
  else
  begin
    Result.Left := CaptionRect.Left + ((CaptionRect.Right - CaptionRect.Left) - PinSize) div 2;
    Result.Top := CaptionRect.Top + 2*cSideBuffer + 2*PinSize;
  end;
  Result.Right := Result.Left + PinSize + 2;
  Result.Bottom := Result.Top + PinSize;
end;

initialization
  DefaultDockTreeClass := TCaptionedDockTree;
end.
