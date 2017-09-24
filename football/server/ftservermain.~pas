unit ftservermain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,WinSockRDOConnection, RDOInterfaces, RDOObjectProxy, RDOServer,
  WinSockRDOConnectionsServer,RDORootServer,logs, StdCtrls,engine, ComCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    manualsave: TButton;
    blankworld: TCheckBox;
    PageControl1: TPageControl;
    main: TTabSheet;
    countries: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    newcountry: TEdit;
    newcountryadd: TButton;
    countrylist: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure newcountryaddClick(Sender: TObject);
    procedure countrylistClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  {$m+}
  tfootball =
  Class(TRDORootServer)
    public
      fengine:tengine;
      constructor Create(aServerConn : IRDOConnectionsServer; MaxQueryThreads : integer; const RootName : string);
      destructor  Destroy; override;
      function  GetId : string;
    published
      function RDOtest(id:integer):olevariant;
      function RDOnewuser(uname,pass,email:widestring;country:integer):olevariant;
      function RDOlogon(uname,pass:widestring):olevariant;
      function RDOgetcountries:olevariant;
  end;
  {$m-}
var
  Form2: TForm2;
  CourierServer : Tfootball = nil;
  fDAConn       : IRDOConnectionsServer;
const
MaxMailQueryThreads = 50;

implementation

function  tfootball.GetId : string;
        begin
          result := 'football';
        end;

function tfootball.RDOtest(id:integer):olevariant;
var
  x:string;
  begin     //test for connection
      if id = 1 then x:='works and id is 1' else x:='works and id is not 1';
      result:=x;
  end;

function tfootball.RDOgetcountries:olevariant;
var
  x:tstrings;
  i:integer;
  begin     //get country list
      with fengine do
        begin
          x:= tstringlist.Create;
          for i:=0 to pred(fcountriescount) do
            begin
              
              x.Add(fcountries.fnames[i]);
            end;
        end;
      result:=x.Text;
  end;

function tfootball.RDOnewuser(uname,pass,email:widestring;country:integer):olevariant;
  var
    i,j:integer;
  begin
    with fengine do
      begin
        i:=0;
        j:=1;     //check if username exists
        while ((i<playerscount) and (j=1)) do
          begin
            if players[i].fname = uname then j:=2;
          end;
        //if username dosn't exist, create account
        if j=1 then
          begin
            players[playerscount].fname:=uname;

            playerscount:=playerscount + 1;
          end;
        result:=j;  
      end;
  end;

function tfootball.RDOlogon(uname,pass:widestring):olevariant;
var
  i,j:integer;
  begin
      with fengine do
        begin
         i:=0;
         j:=-2;
         while ((i<playerscount) and (j=-2)) do    //check for user in db
          begin
            if players[i].fname = uname then
              begin
                if players[i].fpassword = pass then j:=i else j:=-1;   //check password
              end;
            i:=i+1;
          end;
        end;
        result:=j;
  end;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
//create connection and world
      logs.Log('main','start set connection');
      fDAConn     := TWinSockRDOConnectionsServer.Create(9999,tpnormal); // >> 100
      CourierServer :=tfootball.Create(fDAConn, MaxMailQueryThreads, 'football' );
      logs.Log('main',' connection set');
      button1.Visible:=false;
end;

  constructor tfootball.Create(aServerConn : IRDOConnectionsServer; MaxQueryThreads : integer; const RootName : string);
    begin
      //load world
      with fengine do
        begin
          if form2.blankworld.Checked = true then
            begin
            //create a blank world
            end
          else
            begin
            //load world from saved world file
            end;
          //temp data, do full world load here later
          playerscount:=1;
          players[0].fname:='puggy';
          players[0].fpassword:='kickass';
        end;  
      //set up comm's
      inherited Create( aServerConn, MaxQueryThreads, nil, RootName );
      //RDOServer.OnClientDisconnect := OnClientDisconnect;
    end;

    destructor tfootball.Destroy;
    begin
       inherited;
    end;

procedure TForm2.newcountryaddClick(Sender: TObject);
begin
 with CourierServer.fengine do
  begin
    //set up country
    fcountries.fnames[fcountriescount]:=newcountry.Text;
    fcountries.fdivs[fcountriescount]:=0;
    fcountriescount:=fcountriescount +1;
    countrylist.Clear;
    countrylist.Items.Text:=CourierServer.RDOgetcountries;
    //set up first div
  end;
end;

procedure TForm2.countrylistClick(Sender: TObject);
begin
  label3.Caption:='Team Selected = ' + inttostr(countrylist.ItemIndex);
  label4.Caption:= 'Divisions = ' + inttostr(CourierServer.fengine.fcountries.fdivs[countrylist.ItemIndex])

end;

end.
