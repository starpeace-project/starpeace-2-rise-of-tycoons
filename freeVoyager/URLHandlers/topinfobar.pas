unit topinfobar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,RDOInterfaces, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MarqueeCtrl,RDOObjectProxy,WinSockRDOConnection,DateUtils;

type
  Ttib = class(TForm)
    Marquee1: TMarquee;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tib: Ttib;
  DateTime : TDateTime;
  dsupdate:integer;
  dsnews: string;
  dsver,cliver: string;
const
  DSTimeout = 20000;

implementation

{$R *.dfm}

procedure Ttib.Timer1Timer(Sender: TObject);
var
      DSCnx     : IRDOConnectionInit;
      DSProxy   : OleVariant;
      session   : integer;
      thefile :  textfile;
begin

if ((dsupdate>30) or (dsupdate=0))then
  begin
   dsupdate:=0;
   try
        DSCnx        := TWinSockRDOConnection.Create('Directory Server');
        DSCnx.Server := 'sp1.starpeace2.com';
        DSCnx.Port   := 1111;
        DSProxy      := TRDOObjectProxy.Create as IDispatch;
        try
          if DSCnx.Connect( DSTimeOut )
            then
              begin
                DSProxy.SetConnection( DSCnx );
                DSProxy.BindTo( 'DirectoryServer' );
                DSProxy.TimeOut := 20000;
                DSProxy.WaitForAnswer := true;
                session  := DSProxy.RDOOpenSession;
                if session <> 0
                  then
                    begin
                      try
                        DSProxy.BindTo( session );
                         DSProxy.RDOCurrentKey := 'root/mediainfo/english';
                         DSProxy.WaitForAnswer := true;
                         dsnews:= DSProxy.RDOReadString( 'clientnews' );
                         dsver:= DSProxy.RDOReadString( 'clientver' );
                         AssignFile(thefile, ExtractFilePath( paramstr(0) ) + 'version.txt');
                         reset(thefile);
                         readln(thefile,cliver);
                         CloseFile(thefile);
                         if dsver <> cliver then
                          begin
                          dsnews:= 'WARNING: THE CLIENT IS NOT UP TO DATE, PLEASE PATCH THE CLIENT     ' + dsnews;
                          MARQUEE1.ForeColor:=clred;
                          end;
                       except
                         dsnews:='Could not get information from server';
                       end;
                    end
                    else dsnews:='Could not get information from server';
               DSProxy.RDOEndSession;
              end
              else dsnews:='Could not get information from server';
        except
        dsnews:='Could not get information from server';
        end;
   except
   dsnews:='test of the system, adding time online and news later on       ' ;
   end;
   {update news  info}
  end;
dsupdate:=dsupdate + 1;
marquee1.Caption:= dsnews + '        client version ' + dsver + '    ' + inttostr(MinutesBetween(now , DateTime)) + ' minutes online';
marquee1.Hint:=marquee1.Caption;
//marquee1.
end;

procedure Ttib.Timer2Timer(Sender: TObject);
begin
marquee1.Tick;
end;

procedure Ttib.BitBtn1Click(Sender: TObject);
begin
  tib.Visible:=false;
end;

end.
