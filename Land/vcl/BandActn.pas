{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2007 CodeGear            }
{                                                       }
{*******************************************************}

unit BandActn;

interface

(*$HPPEMIT '#pragma link "dclact.lib"'*)

uses Graphics, Classes, Messages, Controls, ActnList, ActnMan, Forms,
  CustomizeDlg;

type
  TCustomizeActionBars = class(TAction)
  private
    FCustomizeDlg: TCustomizeDlg;
    FActionManager: TCustomActionManager;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
  published
    property ActionManager: TCustomActionManager read FActionManager
      write FActionManager;
    property CustomizeDlg: TCustomizeDlg read FCustomizeDlg;
  end;

implementation

uses Windows, Consts;

{ TCustomizeActionBars }

constructor TCustomizeActionBars.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := SCustomize;
  FCustomizeDlg := TCustomizeDlg.Create(Self);
  FCustomizeDlg.Name := Copy(FCustomizeDlg.ClassName, 2, Length(FCustomizeDlg.ClassName));
  FCustomizeDlg.SetSubComponent(True);
end;

procedure TCustomizeActionBars.ExecuteTarget(Target: TObject);
begin
  if not Assigned(FCustomizeDlg.ActionManager) then
  begin
    if Assigned(FActionManager) then
      FCustomizeDlg.ActionManager := FActionManager
    else
      FCustomizeDlg.ActionManager := TCustomActionManager(ActionList);
  end;
  FCustomizeDlg.Show;
end;

function TCustomizeActionBars.HandlesTarget(Target: TObject): Boolean;
begin
  Result := (ActionList is TCustomActionManager) or Assigned(ActionManager);
end;

end.
