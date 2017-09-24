unit engine;

interface
uses Classes, Collection;

type
  tplayer = record   //the playing people

    fname: string;
    fpassword: string;
    femail: string;
    fcountry: integer;
    fteam: integer;
  end;
  
  tstadium = record  //the teams stadium
     fname: string;
  end;

  tteam = record     //the teams
    fname: string;
    fowner: integer;
    fplayers : array[0..31] of integer;
    fstadium : tstadium;
  end;

  tplayers = record     //actual football players

    fname: string;
  end;

  tcountries = record   //record of the countries and no of leagues in them
    fnames : array[0..30] of string;
    fdivs : array[0..30] of integer;
  end;

  tleague = record     //divisions
    fcountry : integer;  //split up into countries of players
    fdiv: integer;
    fsubdiv: integer;
  end;

  ttournament = record   //tournaments - payed for tourns
    fname:string;
  end;

  tfriendly = record

    fteam1:integer;
  end;

  tengine= record   // the actual engine
  //setup varibles
    fcountries: tcountries;
    fcountriescount: integer;
    //players
    players: array[0..1000000] of tplayer;
    playerscount:integer;
    //teams   (country,id)
    teams: array[0..30,0..10000] of tteam;
    teamcount:array[0..30] of integer;
    //football players
    //tournaments
    //freindlies
  //procedures/functions
  end;
implementation


end.
