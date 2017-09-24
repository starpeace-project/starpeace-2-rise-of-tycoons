unit loans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, FramedButton, StdCtrls, ExtCtrls,VoyagerInterfaces,VoyagerServerInterfaces;

type
  TFrame2 = class(TFrame)
    Panel1: TPanel;
    bname: TLabel;
    bdate: TLabel;
    bamount: TLabel;
    brate: TLabel;
    bterm: TLabel;
    bnext: TLabel;
    brepay: TFramedButton;
    procedure brepayClick(Sender: TObject);
  private
    fMasterURLHandler : IMasterURLHandler;
    fClientView       : IClientView;
    procedure SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
  public
    bid:integer;
    property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
    property ClientView       : IClientView       write fClientView;
  end;
 var
  Frame2: Tframe2;
implementation

{$R *.dfm}


procedure TFrame2.brepayClick(Sender: TObject);
var
    url: string;
    i:integer;
begin
  //pay back loan
  i:=fclientview.bankloanpay(bid);
  //reload page
  url:= '?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=bank&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
  fMasterURLHandler.HandleURL(url);
end;

procedure TFrame2.SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
    var
      CachePath : string;
    begin
      fMasterURLHandler := aMasterURLHandler;
      //fMasterURLHandler.HandleEvent( evnAnswerConfigHolder, fConfigHolder );
     // fMasterURLHandler.HandleEvent( evnAnswerPrivateCache, CachePath );
     // fLangList := TStringList.Create;
     // try
     //   fLangList.LoadFromFile( CachePath + 'lang.dat' );
     // except
     // end;
    end;
end.
