unit tycoonviewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StrUtils,logs,VisualControls, protocol,SHDocVw, ActiveX,MSHTML,
  VoyagerInterfaces, VoyagerServerInterfaces, OleCtrls, StdCtrls, GIFImg,
  ExtCtrls, FramedButton,IdHTTP,jpeg, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient;

type
  Ttycoonview = class(TVisualControl)
    Memo1: TMemo;
    Memo2: TMemo;
    Image1: TImage;
    uname: TFramedButton;
    cimg: TFramedButton;
    bcur: TFramedButton;
    bbank: TFramedButton;
    bpl: TFramedButton;
    bis: TFramedButton;
    bcomp: TFramedButton;
    bstrat: TFramedButton;
    IdHTTP1: TIdHTTP;
    Image2: TImage;
    procedure cimgClick(Sender: TObject);
    procedure bcurClick(Sender: TObject);
    procedure bcompClick(Sender: TObject);
    procedure bbankClick(Sender: TObject);
    procedure bplClick(Sender: TObject);
    procedure bisClick(Sender: TObject);
    procedure bstratClick(Sender: TObject);
  private
    { Private declarations }
  private
    { Private declarations }
    fClientView       : IClientView;
    fMasterURLHandler : IMasterURLHandler;
  private
    procedure SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
  public
    { Public declarations }
    fCache            : string ;
    property ClientView       : IClientView       write fClientView;
    property MasterURLHandler : IMasterURLHandler write SetMasterURLHandler;
    property Cache            : string            write fCache;
  protected
        procedure SetParent(which : TWinControl);  override;
  published
    function showimage:integer;
  end;

//var
  //tycoonview: Ttycoonview;

implementation

{$R *.dfm}

procedure Ttycoonview.bbankClick(Sender: TObject);
var
      url:string;
    begin
       //show options
      url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=bank&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure Ttycoonview.bcompClick(Sender: TObject);
var
      url:string;
    begin
       //show options
      url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=comp&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure Ttycoonview.bcurClick(Sender: TObject);
    var
      url:string;
    begin
       //show options
      url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=curr&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure Ttycoonview.bisClick(Sender: TObject);
    var
      url:string;
    begin
       //show options
      url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=is&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure Ttycoonview.bplClick(Sender: TObject);
    var
      url:string;
    begin
       //show options
      url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=pl&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure Ttycoonview.bstratClick(Sender: TObject);
    var
      url:string;
    begin
       //show options
      url:='?frame_Id=tycoonshow&frame_Class=tycoonshow&frame_Action=strat&frame_Align=client&frame_Visibility=visible&frame_NoBorder=Yes&frame_KeepContent=yes';
      fMasterURLHandler.HandleURL(url);
    end;

procedure Ttycoonview.cimgClick(Sender: TObject);
var
    url: string;
begin
    url:= '?frame_Id=AppHandler&frame_Action=SendPicture';
    fMasterURLHandler.HandleURL(url);
end;

procedure Ttycoonview.SetMasterURLHandler( aMasterURLHandler : IMasterURLHandler );
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

procedure Ttycoonview.SetParent(which: TWinControl);
  begin
    inherited;
    //logs.log('wlogin','setparent');
    {if which<>nil
      then
        begin
          RulesTicker.Visible := false;
          if InitSkinImage
            then
              begin
                InitializeCoolSB(WorldList.Handle);
                if hThemeLib <> 0
                  then
                    SetWindowTheme(WorldList.Handle, ' ', ' ');
                CoolSBEnableBar(WorldList.Handle, false, true);
              end;
        end;  }
  end;

function Ttycoonview.showimage:integer;
  var
    sl: TStringList;
    ms: TMemoryStream;
    r1:string;
    HTMLDocument: IHTMLDocument2;
    v: OleVariant;
    memStream: TMemoryStream;
      jpegimg: TJPEGImage;
      bitmp: tbitmap;
      noimage: boolean;
  begin
    //show the user's image
    //logs.Log('buildimage','1');
    r1:= fClientView.getWorldAbsURL + 'fivedata/userinfo/' + fClientView.getWorldName + '/' + fClientView.getUserName + '/largephoto.jpg';
    uname.Text:=fClientView.getUserName;
    // html version
   { memo2.Text:=StringReplace(memo1.Text, '[treplace1]', r1, [rfReplaceAll, rfIgnoreCase]);
    if not Assigned(uimg.Document) then  uimg.Navigate('about:blank') ;
    
    HTMLDocument := uimg.Document as IHTMLDocument2;
    v := VarArrayCreate([0, 0], varVariant); 
    v[0] := memo2.Text;
    HTMLDocument.Write(PSafeArray(TVarData(v).VArray));
    HTMLDocument.Close; }
    noimage:= false;
    //client version
    try

        memStream := TMemoryStream.Create;

        idhttp1.Get(r1,memStream);

      except
        on e: EIdHTTPProtocolException do begin
          noimage:= true;
          //logs.log('objectviewer','error code - ' + inttostr(e.ErrorCode));
        end;
    end;
    if noimage = false then
        begin

          jpegimg   := TJPEGImage.Create;
          //logs.log('objectviewer','lmg - 5');
          try
            //memStream.Write(strStream[1], Length(strStream));
            memStream.Seek(0,soFromBeginning);//.Position := 0;
            //logs.log('objectviewer','lmg - 6');
            jpegimg.LoadFromStream(memStream);
            //logs.log('objectviewer','lmg - 6.1');
            jpegimg.PixelFormat := jf8Bit;
            //logs.log('objectviewer','lmg - 6.2');
            //jpegimg.Grayscale := True;
            //logs.log('objectviewer','lmg - 7');
            jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
            //logs.log('objectviewer','lmg - 8');
            Image2.Picture.Assign(jpegimg);
            //logs.log('objectviewer','lmg - 9');
            //logs.log('objectviewer','show user pic');
          finally
            memStream.Free;
            jpegimg.Free;
          end;
        end
      else
        begin
          jpegimg   := TJPEGImage.Create;
          jpegimg.LoadFromFile('cache\misc\nopicture2.jpg');
          jpegimg.PixelFormat := jf8Bit;
         // jpegimg.Grayscale := True;
          jpegimg.Performance := jpBestSpeed;
            jpegimg.DIBNeeded;
            jpegimg.Compress;
          Image2.Picture.Assign(jpegimg);
          //logs.log('objectviewer','show nopic2');
        end;
   //while uimg.ReadyState < READYSTATE_INTERACTIVE do
   // Application.ProcessMessages;

  // if Assigned(uimg.Document) then
  // begin
   {  sl := TStringList.Create;
     try
       ms := TMemoryStream.Create;
       try
         sl.Text := memo2.Text;
         sl.SaveToStream(ms) ;
         ms.Seek(0, 0) ;
         (uimg.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms)) ;
       finally
         ms.Free;
       end;
     finally
       sl.Free;
     end;
   //end;   }
   //logs.Log('buildimage','5');
   //uimg.OleObject.document.body.style.overflowX := 'hidden';
  // uimg.OleObject.document.body.style.overflowY := 'hidden';
   //logs.Log('buildimage','6');
  end;


  
end.
