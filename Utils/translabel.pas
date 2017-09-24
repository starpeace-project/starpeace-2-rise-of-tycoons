unit translabel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;
  
const
  ROP_DSPDxax = $00E20746;

type
  TPatternType=(tpBrush,tpLeftRight,tpTopBottom,tpEllipse,tpBox);
  TDisplayType=(tdNormal,tdTile,tdStrech,tdCenter);

  TTransparentLabel = class(TGraphicControl)
  Constructor Create(AOwner:TComponent);override;
  Destructor  Destroy;override;
  private
    { Private declarations }
     FBrush:TBitmap;
     FPattern:TPatternType;
     FDisplay:TDisplayType;
     FFirstColor,FLastColor,
     FOutLineColor,FShadowColor:TColor;
     FOutLineWidth:Integer;
     FOutLine,FAutoSize,FTransparent,FShadow:Boolean;
     FShadowX,FShadowY:Integer;
     FDegrees,FFontHeight,FFontWidth:Integer;
     Procedure SetBrush(value:TBitmap);
     Procedure SetPattern(value:TPatternType);
     Procedure SetDisplay(value:TDisplayType);
     Procedure SetFirstColor(value:TColor);
     Procedure SetLastColor(value:TColor);
     Procedure SetOutLine(value:Boolean);
     Procedure SetOutLineColor(value:TColor);
     Procedure SetShadowX(value:Integer);
     Procedure SetShadowY(value:Integer);
     Procedure SetShadowColor(value:TColor);
     Procedure SetAutoSize(value:Boolean);
     Procedure SetTransparent(value:Boolean);
     Procedure SetDegrees(value:Integer);
     Procedure SetOutLineWidth(value:Integer);
     Procedure SetFontHeight(value:Integer);
     Procedure SetFontWidth(value:Integer);
     Procedure SetShadow(value:Boolean);
     Procedure CalcFontRect(Var Rect:TRect;Var X:Integer;Var Y:Integer);
     Procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
     Procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
     Procedure DrawText(Dcanvas:TCanvas;Rect:TRect;X,Y:Integer);
  protected
    { Protected declarations }
     Procedure Paint;override;
  public
    { Public declarations }
  published
    { Published declarations }
    property AutoSize:Boolean read FAutoSize write SetAutoSize default True;
    property Brush:TBitmap read FBrush write SetBrush;
    property ColorFirst:TColor read FFirstColor write SetFirstColor default clBlack;
    property ColorLast:TColor read FLastColor write SetLastColor default clRed;
    property Degrees:Integer read FDegrees write SetDegrees default 45;
    property Display:TDisplayType read FDisplay write SetDisplay default tdTile;
    property FontHeight:Integer read FFontHeight write SetFontHeight default 0;
    property FontWidth:Integer read FFontWidth write SetFontWidth default 0;
    property OutLineEnabled:Boolean read FOutLine write SetOutLine default True;
    property OutLineWidth:Integer read FOutLineWidth write SetOutLineWidth default 1;
    property OutLineColor:TColor read FOutLineColor write SetOutLineColor default clWhite;
    property Pattern:TPatternType read FPattern write SetPattern;
    property ShadowEnabled:Boolean read FShadow write SetShadow default True;
    property ShadowX:Integer read FShadowX write SetShadowX default 10;
    property ShadowY:Integer read FShadowY write SetShadowY default 10;
    property ShadowColor:TColor read FShadowColor write SetShadowColor default clBlack;
    {property Transparent:Boolean read FTransparent write SetTransparent default False;}
    property Caption;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Height;
    property Hint;
    property Left;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Top;
    property Visible;
    property Width;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Added', [TTransparentLabel]);
end;

Constructor TTransparentLabel.Create;
Begin
   Inherited Create(AOwner);
   Inherited Height:=152;
   Inherited Width:=152;
   FBrush:=TBitmap.Create;
   FPattern:=tpLeftRight;
   FDisplay:=tdTile;
   FFirstColor:=clBlack;
   FLastColor:=clRed;
   FOutLine:=True;
   FOutLineWidth:=1;
   FOutLineColor:=clWhite;
   FFontHeight:=0;
   FFontWidth:=0;
   FShadowX:=10;FShadowY:=10;
   FShadowColor:=clBlack;
   FAutoSize:=True;
   FTransparent:=False;
   FShadow:=True;
   FDegrees:=45;
   Font.Name:='ARIAL';
   Font.Size:=14;
   Font.Style:=[fsBold];
End;

Destructor TTransparentLabel.Destroy;
Begin
   FBrush.Free;
   Inherited;
End;

Procedure TTransparentLabel.SetBrush;
Begin
   If value<>FBrush then
   Begin
      FBrush.Assign(value);
      RePaint;
   End;
End;

Procedure TTransparentLabel.SetPattern;
Begin
   If value<>FPattern then
   Begin
      FPattern:=Value;
      RePaint;
   End;
End;

Procedure TTransparentLabel.SetDisplay;
Begin
   If value<>FDisplay then
   Begin
      FDisplay:=value;
      RePaint;
   End;
End;

Procedure TTransparentLabel.SetFirstColor;
Begin
   If value<>FFirstColor then
   Begin
      FFirstColor:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetLastColor;
Begin
   If value<>FLastColor then
   Begin
      FLastColor:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetOutLine;
Begin
   If value<>FOutLine then
   Begin
      FOutLine:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetOutLineColor;
Begin
   If value<>FOutLineColor then
   Begin
      FOutLineColor:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetShadowX;
Begin
   If value<>FShadowX then
   Begin
      FShadowX:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetShadowY;
Begin
   If value<>FShadowY then
   Begin
      FShadowY:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetShadowColor;
Begin
   If value<>FShadowColor then
   Begin
      FShadowColor:=value;
      Invalidate;
   End;
End;


Procedure TTransparentLabel.SetTransparent;
Begin
   If value<>FTransparent then
   Begin
      FTransparent:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetAutoSize;
Begin
   If value<>FAutoSize then
   Begin
      FAutoSize:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetDegrees;
Begin
   If value<>FDegrees then
   Begin
      FDegrees:=Abs(value mod 360);
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetOutLineWidth;
Begin
   If value<>FOutLineWidth then
   Begin
      FOutLineWidth:=value mod 6;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetFontHeight;
Begin
   If value<>FFontHeight then
   Begin
      FFontHeight:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetFontWidth;
Begin
   If value<>FFontWidth then
   Begin
      FFontWidth:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.SetShadow;
Begin
   If value<>FShadow then
   Begin
      FShadow:=value;
      Invalidate;
   End;
End;

Procedure TTransparentLabel.CMTextChanged;
Var Rect:TRect;
    X,Y:Integer;
begin
   If Parent<>Nil then
   Begin
      CalcFontRect(Rect,X,Y);
      Invalidate;
   End;
end;

Procedure TTransparentLabel.CMFontChanged;
Var Rect:TRect;
    X,Y:Integer;
begin
   If Parent<>Nil then
   Begin
      CalcFontRect(Rect,X,Y);
      inherited;
   End;
end;

Procedure TTransparentLabel.CalcFontRect;
Var sX,sY:Integer;
    CosDeg,SinDeg:Real;
Begin
   canvas.Font.Assign(Font);
   sY:=canvas.TextHeight(Caption);
   sX:=canvas.TextWidth(Caption);
   Rect.Top:=0;
   Rect.Left:=0;
   SinDeg:=Abs(Sin(FDegrees*Pi/180));
   CosDeg:=Abs(Cos(FDegrees*Pi/180));
   If FDegrees<=90 then
   Begin
      Rect.Bottom:=Round(sY*CosDeg+sX*SinDeg);
      Rect.Right:=Round(sX*CosDeg+sY*SinDeg);
      X:=0;
      Y:=Round(sX*SinDeg);
   End
   Else If FDegrees<=180 then
   Begin
      Rect.Bottom:=Round(sY*CosDeg)+Round(sX*SinDeg);
      Rect.Right:=Round(sX*CosDeg)+Round(sY*SinDeg);
      X:=Round(Abs(sX*CosDeg));
      Y:=Round(Abs(sY*CosDeg))+Round(sX*SinDeg)
   End
   Else If FDegrees<=270 then
   Begin
      Rect.Bottom:=Round(sY*CosDeg)+Round(sX*SinDeg);
      Rect.Right:=Round(sX*CosDeg)+Round(sY*SinDeg);
      X:=Round(sX*CosDeg)+Round(sY*SinDeg);
      Y:=Round(sY*CosDeg);
   End
   Else
   Begin
      Rect.Bottom:=Round(sY*CosDeg)+Round(sX*SinDeg);
      Rect.Right:=Round(sX*CosDeg)+Round(sY*SinDeg);
      X:=Round(sY*SinDeg);
      Y:=0;
   End;
   Rect.Right:=Rect.Right+Abs(ShadowX)+1;
   If ShadowX<0 then X:=X+Abs(ShadowX);
   Rect.Bottom:=Rect.Bottom+Abs(ShadowY)+1;
   If ShadowY<0 then Y:=Y+Abs(ShadowY);
   Inc(X);Inc(Y);
   If FAutoSize then
   Begin
      Height:=Rect.Bottom;
      Width:=Rect.Right;
   End
   Else
   Begin
      Rect.Bottom:=Height;
      Rect.Right:=Width;
   End;
End;

Procedure TTransparentLabel.DrawText;
Var LFont:TLogFont;
    HOldFont,HNewFont:HFont;
Begin
   GetObject(DCanvas.Font.Handle,SizeOf(LFont),@LFont);
   LFont.lfEscapement:=FDegrees*10;
   LFont.lfQuality:=PROOF_QUALITY;
   If FFontHeight<>0 then LFont.lfHeight:=FFontHeight;
   If FFontWidth<>0 then LFont.lfWidth:=FFontWidth;
   HNewFont:=CreateFontIndirect(LFont);
   HOldFont:=SelectObject(DCanvas.Handle,HNewFont);
   Dcanvas.Brush.Style:=bsClear;
   DCanvas.TextRect(Rect,X,Y,Caption);
   DeleteObject(SelectObject(DCanvas.Handle,HOldFont));
End;

Procedure ColorAverage(canvas:TCanvas;X,Y:Integer);
Var oX,oY,R,G,B:Integer;
    c:TColor;
Begin
   R:=0;B:=0;G:=0;
   For oX:=X-1 To X+1 Do
   Begin
      For  oY:=Y-1 To Y+1 Do
      Begin
         If Not ((oX=X) And (oY=Y)) then
         Begin
            c:=canvas.Pixels[oX,oY];
            R:=R+C and $0000FF;
            G:=G+(C and $00FF00) shr 8;
            B:=B+(C and $FF0000) shr 16;
         End;
      End;
   End;
   R:=R div 8;
   G:=G div 8;
   B:=B div 8;
   canvas.Pixels[X,Y]:=R+G shl 8+B shl 16;
End;

Procedure TTransparentLabel.Paint;
Var MonoBMP,FBTemp:TBitmap;
    LFont:TLogFont;
    HOldFont,HNewFont:HFont;
    X,Y,oX,oY,f:Integer;
    Rect,cRect:TRect;
    cRGB:TColor;
    fR,fG,fB,lR,lG,lB,eR,eG,eB,rH,eH:Real;
    P:Pointer;
Begin
   CalcFontRect(Rect,X,Y);
   MonoBMP:=TBitmap.Create;
   MonoBMP.Monochrome:=True;
   MonoBMP.canvas.Brush.Color:=clBlack;
   MonoBMP.Width:=Width;
   MonoBMP.Height:=Height;
   FBTemp:=TBitmap.Create;
   FBTemp.canvas.Brush.Color:=Color;
   FBTemp.Width:=Width;
   FBTemp.Height:=Height;
   FBTemp.canvas.FillRect(Rect);
   FBTemp.canvas.Font.Assign(Font);
   FBTemp.canvas.Font.Color:=FShadowColor;
   If FShadow then DrawText(FBTemp.canvas,Rect,X+ShadowX,Y+ShadowY);
   If FOutLine then
   Begin
      FBTemp.canvas.Font.Color:=FOutLineColor;
      For oX:=-FOutLineWidth To +FOutLineWidth Do
        For oY:=-FOutLineWidth To +FOutLineWidth Do
        If (Abs(oX)=FOutLineWidth) Or (Abs(oY)=FOutLineWidth) then
            DrawText(FBTemp.canvas,Rect,X+oX,Y+oY);
   End;
   MonoBMP.canvas.Font.Assign(Font);
   MonoBMP.canvas.Font.Color:=clWhite;
   DrawText(MonoBMP.canvas,Rect,X,Y);
   FBTemp.canvas.Brush.Bitmap:=TBitmap.Create;
   If FPattern=tpBrush then                                   {if the transparent is the brush}
   Begin
      Case FDisplay of
         tdNormal:Begin
            FBTemp.canvas.Brush.Bitmap.Width:=Width;
            FBTemp.canvas.Brush.Bitmap.Height:=Height;
            FBTemp.canvas.Brush.Bitmap.canvas.CopyRect(FBrush.canvas.ClipRect,FBrush.canvas,FBrush.canvas.ClipRect);
         End;
         tdTile:FBTemp.canvas.Brush.Bitmap.Assign(FBrush);
         tdStrech:Begin
            FBTemp.canvas.Brush.Bitmap.Width:=Width;
            FBTemp.canvas.Brush.Bitmap.Height:=Height;
            FBTemp.canvas.Brush.Bitmap.canvas.CopyRect(Rect,FBrush.canvas,FBrush.canvas.ClipRect);
         End;
         tdCenter:Begin
            FBTemp.canvas.Brush.Bitmap.Width:=Width;
            FBTemp.canvas.Brush.Bitmap.Height:=Height;
            oX:=(Width-FBrush.Width) div 2;
            oY:=(Height-FBrush.Height) div 2;
            FBTemp.canvas.Brush.Bitmap.canvas.Draw(oX,oY,FBrush);
         End;
      End;
   End
   Else If FPattern=tpLeftRight then
   Begin
      FBTemp.canvas.Brush.Bitmap.Width:=Width;
      FBTemp.canvas.Brush.Bitmap.Height:=Height;
      fR:=FFirstColor and $FF;
      fG:=(FFirstColor and $FF00) shr 8;
      fB:=(FFirstColor and $FF0000) shr 16;
      lR:=FLastColor and $FF;
      lG:=(FLastColor and $FF00) shr 8;
      lB:=(FLastColor and $FF0000) shr 16;
      eR:=(lR-fR)/Width;
      eG:=(lG-fG)/Width;
      eB:=(lB-fB)/Width;
      For oX:=0 To Width Do
      Begin
         cRGB:=Round(fR)+(Round(fG) shl 8)+(Round(fB) shl 16);
         FBTemp.canvas.Brush.Bitmap.canvas.Pen.Color:=cRGB;
         FBTemp.canvas.Brush.Bitmap.canvas.MoveTo(oX,0);
         FBTemp.canvas.Brush.Bitmap.canvas.LineTo(oX,Height);
         fR:=fR+eR;
         fG:=fG+eG;
         fB:=fB+eB;
      End;
   End
   Else If FPattern=tpTopBottom then
   Begin
      FBTemp.canvas.Brush.Bitmap.Width:=Width;
      FBTemp.canvas.Brush.Bitmap.Height:=Height;
      fR:=FFirstColor and $FF;
      fG:=(FFirstColor and $FF00) shr 8;
      fB:=(FFirstColor and $FF0000) shr 16;
      lR:=FLastColor and $FF;
      lG:=(FLastColor and $FF00) shr 8;
      lB:=(FLastColor and $FF0000) shr 16;
      eR:=(lR-fR)/Height;
      eG:=(lG-fG)/Height;
      eB:=(lB-fB)/Height;
      For oX:=0 To Height Do
      Begin
         cRGB:=Round(fR)+(Round(fG) shl 8)+(Round(fB) shl 16);
         FBTemp.canvas.Brush.Bitmap.canvas.Pen.Color:=cRGB;
         FBTemp.canvas.Brush.Bitmap.canvas.MoveTo(0,oX);
         FBTemp.canvas.Brush.Bitmap.canvas.LineTo(Width,oX);
         fR:=fR+eR;
         fG:=fG+eG;
         fB:=fB+eB;
      End;
   End
   Else If FPattern=tpBox then
   Begin
      FBTemp.canvas.Brush.Bitmap.Width:=Width;
      FBTemp.canvas.Brush.Bitmap.Height:=Height;
      fR:=FFirstColor and $FF;
      fG:=(FFirstColor and $FF00) shr 8;
      fB:=(FFirstColor and $FF0000) shr 16;
      lR:=FLastColor and $FF;
      lG:=(FLastColor and $FF00) shr 8;
      lB:=(FLastColor and $FF0000) shr 16;
      eR:=(lR-fR)/(Width shr 1);
      eG:=(lG-fG)/(Width shr 1);
      eB:=(lB-fB)/(Width shr 1);
      eH:=Height/Width;
      rH:=0;
      For oX:=0 To Width shr 1 Do
      Begin
         cRGB:=Round(fR)+(Round(fG) shl 8)+(Round(fB) shl 16);
         FBTemp.canvas.Brush.Bitmap.canvas.Brush.Color:=cRGB;
         cRect.Left:=oX;
         cRect.Right:=Width-oX;
         cRect.Top:=Round(rH);cRect.Bottom:=Height-Round(rH);
         FBTemp.canvas.Brush.Bitmap.canvas.FillRect(cRect);
         fR:=fR+eR;
         fG:=fG+eG;
         fB:=fB+eB;
         rH:=rH+eH;
      End;
   End
   Else If FPattern=tpEllipse then
   Begin
      FBTemp.canvas.Brush.Bitmap.Width:=Width;
      FBTemp.canvas.Brush.Bitmap.Height:=Height;
      fR:=FFirstColor and $FF;
      fG:=(FFirstColor and $FF00) shr 8;
      fB:=(FFirstColor and $FF0000) shr 16;
      lR:=FLastColor and $FF;
      lG:=(FLastColor and $FF00) shr 8;
      lB:=(FLastColor and $FF0000) shr 16;
      eR:=(lR-fR)/(Width shr 1);
      eG:=(lG-fG)/(Width shr 1);
      eB:=(lB-fB)/(Width shr 1);
      eH:=Height/Width;
      rH:=0;
      For oX:=0 To Width shr 1 Do
      Begin
         cRGB:=Round(fR)+(Round(fG) shl 8)+(Round(fB) shl 16);
         FBTemp.canvas.Brush.Bitmap.canvas.Pen.Color:=cRGB;
         cRect.Left:=oX;
         cRect.Right:=Width-oX;
         cRect.Top:=Round(rH);cRect.Bottom:=Height-Round(rH);
         FBTemp.canvas.Brush.Bitmap.canvas.Ellipse(cRect.Left,cRect.Top,cRect.Right,CRect.Bottom);
         fR:=fR+eR;
         fG:=fG+eG;
         fB:=fB+eB;
         rH:=rH+eH;
      End;
   End;
   SetTextColor(FBTemp.canvas.Handle,$0);
   SetBkColor(FBTemp.canvas.Handle,$FFFFFF);
   BitBlt(FBTemp.canvas.Handle, 0, 0, Width, Height, MonoBMP.canvas.Handle, 0, 0, ROP_DSPDxax);
   canvas.CopyRect(Rect,FBTemp.canvas,Rect);
   MonoBMP.Free;
   FBTemp.canvas.Brush.Bitmap.Free;
   FBTemp.Free;
End;

end.
