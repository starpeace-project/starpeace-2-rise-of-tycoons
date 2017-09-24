unit engine;

interface
uses Classes, Collection;

type
  //
  // games avaible
  tgame = record
    id:integer;
    name:string[255];
    version:integer;
    owner:string[255]; //game owner
    kitty:integer; //owners kitty
    operc:byte; //owners percentage
    price: integer;
    purchase:byte;//free, pay for, subscription model, not avaible yet
    soldt:integer;
    soldlw:integer;
    soldtw:integer;
    category:integer;//type of game eg action mmo etc etc
    timed:integer;
    timelw:integer;//time last week
    timetw:integer;//time this week
  end;

  // user's games
  tugame = record
    owned:byte; //0 no, 1 yes
    timed:integer;
    timelw:integer;
    timetw:integer;
  end;

  tcontacts = record
    id:integer;
    contact:byte;
  end;

  //user info
  tplayer = record   //the playing people
    fname: string[64];
    fpassword: string[64];
    femail: string[64];
    flastip:string[20];
    fonline:byte; //0 no, 1 yes, 2 away, 3 busy
    fplaying:byte; //which game are they playing (0 none)
    fgames:array[0..100] of tugame;
    fcontacts: array[0..100] of tcontacts;
  end;


  tengine= record   // the actual engine
  //setup varibles
    //users
    players: array[0..10000] of tplayer;
    playerscount:integer;
    games:array [0..100] of tgame;
    gamescount:integer;
  end;
implementation


end.
