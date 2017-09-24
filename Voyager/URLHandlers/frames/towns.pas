unit towns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs,VisualControls,logs, VoyagerInterfaces, FramedButton, StdCtrls, jpeg,
  GIFImg, ExtCtrls;

type
  TFrame3 = class(TFrame)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FramedButton1: TFramedButton;
    procedure FramedButton1Click(Sender: TObject);
  private
    fMasterURLHandler : IMasterURLHandler;
    procedure SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
    { Private declarations }
  public
    { Public declarations }
    x,y:string;
    property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
   // function clickit: integer;
  end;

implementation

{$R *.dfm}

procedure TFrame3.FramedButton1Click(Sender: TObject);
begin
  // go to x/y
  fMasterURLHandler.HandleURL( '?frame_Id=MapIsoView&frame_Action=SELECT&x=' + x + '&y=' + y );
end;


procedure TFrame3.SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
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
