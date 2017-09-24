unit ftservermain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,WinSockRDOConnection, RDOInterfaces, RDOObjectProxy, RDOServer,
  WinSockRDOConnectionsServer,RDORootServer,logs, StdCtrls,engine, ComCtrls,
  ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    manualsave: TButton;
    blankworld: TCheckBox;
    PageControl1: TPageControl;
    main: TTabSheet;
    games: TTabSheet;
    users: TTabSheet;
    stats: TTabSheet;
    sgame: TListBox;
    refresh: TButton;
    cgame: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit5: TEdit;
    Label14: TLabel;
    Edit6: TEdit;
    Label15: TLabel;
    Edit7: TEdit;
    Label16: TLabel;
    Edit8: TEdit;
    gedit: TButton;
    gadd: TButton;
    backup: TTimer;
    savegeneral: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure sgameClick(Sender: TObject);
    procedure refreshClick(Sender: TObject);
    procedure geditClick(Sender: TObject);
    procedure gaddClick(Sender: TObject);
    procedure savegeneralTimer(Sender: TObject);
    procedure backupTimer(Sender: TObject);
    procedure manualsaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

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
      function recachegame(gameid:integer):integer;
      function reloadgame(gameid,version:integer):integer;
      function recacheplayer(playerid:integer):integer;
      function reloadplayer(playerid,version:integer):integer;
      function recachesystem(tp:integer):integer;
      function reloadsystem(tp,version:integer):integer;
    published
      function RDOnewuser(uname,pass,email:widestring):olevariant;
      function RDOlogon(uname,pass:widestring):olevariant;
      function RDOsendfile(filetype,game:integer;filename:widestring):olevariant;
  end;
  {$m-}


var
  Form2: TForm2;
  ts : Tfootball = nil;
  fDAConn       : IRDOConnectionsServer;
  fullbackup: integer;
  theplayercount:integer;
  thegamecount:integer;
const
MaxMailQueryThreads = 500;
theversion = 1;
clientversion = 1;

implementation
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
  begin
  //create connection and world
      logs.Log('main','start set connection');
      fDAConn     := TWinSockRDOConnectionsServer.Create(9999,tpnormal); // >> 100
      ts :=tfootball.Create(fDAConn, MaxMailQueryThreads, 'football' );
      logs.Log('main',' connection set');
      button1.Visible:=false;
  end;

procedure TForm2.sgameClick(Sender: TObject);
  var
    i:integer;
  begin
    i:= sgame.ItemIndex + 1;
    with ts.fengine do
      begin
    {show game info}
        label12.Caption:=inttostr(i);
        edit1.Text:= games[i].name;
        edit2.Text:= inttostr(games[i].price);
        edit3.Text:= inttostr(games[i].purchase);
        edit4.Text:= inttostr(games[i].category);
        edit5.Text:= games[i].owner;
        edit6.Text:= inttostr(games[i].version);
        edit7.Text:= inttostr(games[i].operc);
        edit8.Text:= inttostr(games[i].kitty);
        label5.Caption:='Time today:' + inttostr(games[i].timed);
        label6.Caption:='Time this week:' + inttostr(games[i].timetw);
        label7.Caption:='Time last week:' + inttostr(games[i].timelw);
        label8.Caption:='Total sold:' + inttostr(games[i].soldt);
        label9.Caption:='Sold last week:' + inttostr(games[i].soldlw);
        label10.Caption:='Sold this week:' + inttostr(games[i].soldtw);
     end;
  end;

procedure TForm2.refreshClick(Sender: TObject);
  var
    i:integer;
  begin
  sgame.Clear;
  with ts.fengine do
    begin
      for i:=1 to gamescount do
        begin
          sgame.Items.Insert(i-1,games[i].name);
        end;

    end;
  end;

procedure TForm2.geditClick(Sender: TObject);
  var
    i,j:integer;
  begin
  //edit game info
  i:=strtoint(label12.Caption);
  with ts.fengine.games[i] do
    begin
      name:= edit1.Text;
      price:= strtoint(edit2.Text);
      purchase:=strtoint(edit3.Text);
      category:=strtoint(edit4.Text);
      owner:= edit5.Text ;
      version:= strtoint(edit6.Text);
      operc:=strtoint(edit7.Text);
      kitty:=strtoint(edit8.Text);
    end;
    j:=ts.recachegame(i);
  end;

procedure TForm2.gaddClick(Sender: TObject);
  var
    i,j:integer;
  begin
    //add game
    i:= ts.fengine.gamescount + 1;
    ts.fengine.gamescount:=i;
    with ts.fengine.games[i] do
      begin
        id:=i;
        name:=edit1.Text;
        version:=strtoint(edit6.Text);
        owner:=edit5.Text; //game owner
        kitty:=0; //owners kitty
        operc:=strtoint(edit7.Text); //owners percentage
        price:= strtoint(edit2.Text);
        purchase:=strtoint(edit3.Text);//free, pay for, subscription model, not avaible yet
        soldt:=0;
        soldlw:=0;
        soldtw:=0;
        category:=strtoint(edit4.Text);//type of game eg action mmo etc etc
        timed:=0;
        timelw:=0;//time last week
        timetw:=0;//time this week
      end;
     j:=ts.recachegame(i);
  end;

procedure TForm2.savegeneralTimer(Sender: TObject);
  begin
  //save general info
  //game data
  end;

procedure TForm2.backupTimer(Sender: TObject);
  begin
  //save data in backup folder
  end;

procedure TForm2.manualsaveClick(Sender: TObject);
  var
    i:integer;
  begin
    i:=ts.recachesystem(1);
  end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
  var
    i:integer;
  begin
    //make full record backup, both 1 file and individual, then save config
    i:=ts.recachesystem(1);
    i:=ts.recachesystem(2);
    fullbackup:=1;
    i:=ts.recachesystem(0);
    ts.Destroy;
  end;
{end form stuff, go to engine stuff here}





function  tfootball.GetId : string;
  begin
          result := 'football';
  end;

function tfootball.RDOnewuser(uname,pass,email:widestring):olevariant;
  var
    i,j,k:integer;
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
            k:=recacheplayer(playerscount);
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


  constructor tfootball.Create(aServerConn : IRDOConnectionsServer; MaxQueryThreads : integer; const RootName : string);
    var
      thefile:textfile;
      i,j,bk,ver:integer;
    begin
      //load world
      if form2.blankworld.Checked = true then
        begin
          //create a blank world
          fengine.playerscount:=0;
          fengine.players[0].fname:='puggy';
          fengine.players[0].fpassword:='kickass';
          fengine.gamescount:=0;
              
         end
       else
         begin
              //load world from saved world file
              //load main config, first line is save data version
            AssignFile(thefile, 'data/system.dat');
            Reset(thefile);
            readln(thefile,ver);
            readln(thefile,bk);
            readln(thefile,theplayercount);
            readln(thefile,thegamecount);
            if ((ver=theversion) and (bk = 1)) then
              begin
                //load from main backup file
                j:=reloadsystem(1,ver);
              end
            else
              begin
                //load individual files
                j:=reloadsystem(2,ver);
              end;
            closefile(thefile);
              //load users
              //load user info
         end;
          //temp data, do full world load here later
      fullbackup:=0;
      //set up comm's
      inherited Create( aServerConn, MaxQueryThreads, nil, RootName );
      //RDOServer.OnClientDisconnect := OnClientDisconnect;
    end;

    destructor tfootball.Destroy;
    begin
       inherited;
    end;

function tfootball.recachegame(gameid:integer):integer;
  var
    thefile: textfile;
  begin
    //cache a certain game
    {AssignFile(thefile2, 'data/games/' +  inttostr(gameid) + '.dat2');
    Rewrite(thefile2);
    //write the game data to stored file
    x:=fengine.games[gameid];
    write(thefile2,x);
    //close the file
    CloseFile(thefile2);}

    AssignFile(thefile, 'data/games/' +  inttostr(gameid) + '.dat');
    Rewrite(thefile);
    //write the game data to stored file
    with fengine.games[gameid]do
      begin
        writeln(thefile,id);
        writeln(thefile,name);
        writeln(thefile,version);
        writeln(thefile,owner);
        writeln(thefile,kitty);
        writeln(thefile,operc);
        writeln(thefile,price);
        writeln(thefile,purchase);
        writeln(thefile,soldt);
        writeln(thefile,soldlw);
        writeln(thefile,soldtw);
        writeln(thefile,category);
        writeln(thefile,timed);
        writeln(thefile,timelw);
        writeln(thefile,timetw);
      end;
    //close the file
    CloseFile(thefile);
  end;

function tfootball.reloadgame(gameid,version:integer):integer;
  var
    thefile:textfile;
  begin
    AssignFile(thefile, 'data/games/' +  inttostr(gameid) + '.dat');
    Reset(thefile);
    with fengine.games[gameid] do
      begin
        readln(thefile,id);
        readln(thefile,name);
        readln(thefile,version);
        readln(thefile,owner);
        readln(thefile,kitty);
        readln(thefile,operc);
        readln(thefile,price);
        readln(thefile,purchase);
        readln(thefile,soldt);
        readln(thefile,soldlw);
        readln(thefile,soldtw);
        readln(thefile,category);
        readln(thefile,timed);
        readln(thefile,timelw);
        readln(thefile,timetw);
        //use if version if adding something new, to load from old db's
      end;
    closefile(thefile);
  end;

function tfootball.recacheplayer(playerid:integer):integer;
  var
    thefile: textfile;
    i:integer;
  begin
    //cache player
    AssignFile(thefile, 'data/players/' +  inttostr(playerid) + '.dat');
    Rewrite(thefile);
    with fengine.players[playerid]do
      begin             //  writeln(thefile,);
        writeln(thefile,fname);
        writeln(thefile,fpassword);
        writeln(thefile,femail);
        writeln(thefile,flastip);
        writeln(thefile,fonline);
        writeln(thefile,fplaying);
        for i:=0 to 100 do    //if no games changes, do version check on load
          begin
            writeln(thefile,fgames[i].owned);
            writeln(thefile,fgames[i].timed);
            writeln(thefile,fgames[i].timelw);
            writeln(thefile,fgames[i].timetw);
          end;
        //contacts
        for i:=0 to 1000 do
          begin
            writeln(thefile,fcontacts[i].id);
            writeln(thefile,fcontacts[i].contact);
          end;
      end;
    //close the file
    CloseFile(thefile);
  end;

function tfootball.reloadplayer(playerid,version:integer):integer;
  var
    thefile: textfile;
    i:integer;
  begin
    //load player
    AssignFile(thefile, 'data/players/' +  inttostr(playerid) + '.dat');
    Reset(thefile);
    with fengine.players[playerid]do
      begin             //  writeln(thefile,);
        readln(thefile,fname);
        readln(thefile,fpassword);
        readln(thefile,femail);
        readln(thefile,flastip);
        readln(thefile,fonline);
        readln(thefile,fplaying);
        for i:=0 to 100 do    //if no games changes, do version check on load
          begin
            writeln(thefile,fgames[i].owned);
            writeln(thefile,fgames[i].timed);
            writeln(thefile,fgames[i].timelw);
            writeln(thefile,fgames[i].timetw);
          end;
        //contacts
        for i:=0 to 1000 do
          begin
            writeln(thefile,fcontacts[i].id);
            writeln(thefile,fcontacts[i].contact);
          end;
      end;
    //close the file
    CloseFile(thefile);
  end;

function tfootball.recachesystem(tp:integer):integer;
  var
    thefile: file of tengine;
    thefile2:textfile;
    i,j:integer;
  begin
    // cache main system info
    if tp=0 then
      begin
        AssignFile(thefile2, 'data/system.dat');
        Rewrite(thefile2);
        writeln(thefile2,theversion); //for checking when loading up newer servers
        writeln(thefile2,fullbackup); //was it a full backup last time?
        writeln(thefile2,fengine.playerscount);
        writeln(thefile2,fengine.gamescount);
        closefile(thefile2);
      end;
    //cache full engine in a record
    if tp=1 then
      begin
        AssignFile(thefile, 'data/main.dat');
        Rewrite(thefile);
        write(thefile,fengine); //if ever gets too big split up
        closefile(thefile);
      end;
    //cache all system individually
    if tp=2 then
      begin
        //cache all games
        for i:=1 to fengine.gamescount do
          begin
            j:=recachegame(i);
          end;
        //cache all players
        for i:=0 to fengine.playerscount do
          begin
            j:=recacheplayer(i);
          end;
      end;
  end;

function tfootball.reloadsystem(tp,version:integer):integer;
  var
    thefile: file of tengine;
    thefile2:textfile;
    i,j:integer;
  begin
    //load system
    if tp=1 then
      begin
        AssignFile(thefile, 'data/main.dat');
        Reset(thefile);
        read(thefile,fengine);
        closefile(thefile);
      end;
    //cache all system individually
    if tp=2 then
      begin
        //cache all games
        for i:=1 to thegamecount do
          begin
            j:=reloadgame(i,version);
          end;
        //cache all players
        for i:=0 to theplayercount do
          begin
            j:=reloadplayer(i,version);
          end;
      end;
  end;

function tfootball.RDOsendfile(filetype,game:integer;filename:widestring):olevariant;
   var
    x: tfilestream;
    contents: string;
   begin
      if filetype = 1 then      //full version
        begin
          x:= TFileStream.Create('data/files/' + inttostr(game) + '/' + filename + '.zip', fmOpenRead);
          try
            x.Position := 0;
            SetLength(contents, x.Size);
            x.ReadBuffer(Pointer(contents)^, x.Size);
          finally
            x.Free;
          end;

          result:= contents;
        end;
      if filetype = 2 then      //update version
        begin

        end;
   end;





end.
