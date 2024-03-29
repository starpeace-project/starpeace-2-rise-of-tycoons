{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit StdStyleActnCtrls;

interface

uses ActnMan, ActnMenus, ActnCtrls;

type

{ TStandardStyleActionBars }

  TStandardStyleActionBars = class(TActionBarStyleEx)
  public
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; override;
    function GetControlClass(ActionBar: TCustomActionBar;
      AnItem: TActionClientItem): TCustomActionControlClass; override;
    function GetPopupClass(ActionBar: TCustomActionBar): TCustomPopupClass; override;
    function GetAddRemoveItemClass(ActionBar: TCustomActionBar): TCustomAddRemoveItemClass; override;
    function GetStyleName: string; override;
    function GetScrollBtnClass: TCustomToolScrollBtnClass; override;
  end;

var
  StandardStyle: TStandardStyleActionBars;

implementation

uses ListActns, ActnColorMaps, StdActnMenus, Consts;

{ TStandardActionBandStyle }

function TStandardStyleActionBars.GetAddRemoveItemClass(ActionBar: TCustomActionBar): TCustomAddRemoveItemClass;
begin
  Result := TStandardAddRemoveItem;
end;

function TStandardStyleActionBars.GetColorMapClass(
  ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  Result := TStandardColorMap;
end;

function TStandardStyleActionBars.GetControlClass(ActionBar: TCustomActionBar;
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  if ActionBar is TCustomActionToolBar then
  begin
    if AnItem.HasItems then
      Result := TStandardDropDownButton
    else
      if (AnItem.Action is TStaticListAction) or
         (AnItem.Action is TVirtualListAction) then
        Result := TCustomComboControl
      else
        Result := TStandardButtonControl;
  end
  else if ActionBar is TCustomActionMainMenuBar then
    Result := TStandardMenuButton
  else if ActionBar is TCustomizeActionToolBar then
  begin
    with ActionBar as TCustomizeActionToolbar do
      if not Assigned(RootMenu) or (AnItem.ParentItem <> TCustomizeActionToolBar(RootMenu).AdditionalItem) then
        Result := TStandardMenuItem
      else
        Result := TStandardAddRemoveItem;
  end
  else if ActionBar is TCustomActionPopupMenu then
    Result := TStandardMenuItem
  else
                                                                                        
    Result := TStandardButtonControl;
end;

function TStandardStyleActionBars.GetPopupClass(
  ActionBar: TCustomActionBar): TCustomPopupClass;
begin
  if ActionBar is TCustomActionToolBar then
    Result := TStandardCustomizePopup
  else
    Result := TStandardMenuPopup;
end;

function TStandardStyleActionBars.GetScrollBtnClass: TCustomToolScrollBtnClass;
begin
  Result := TStandardToolScrollBtn;
end;

function TStandardStyleActionBars.GetStyleName: string;
begin
  Result := 'Standard'; { Do not localize }
end;

initialization
  StandardStyle := TStandardStyleActionBars.Create;
  RegisterActnBarStyle(StandardStyle);
finalization
  UnregisterActnBarStyle(StandardStyle);
  StandardStyle.Free;
end.
