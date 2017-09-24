unit Logs;

interface

  uses
  
    ShareMem,

    SocketComp, SysUtils;

  procedure Log( LogId, Info : string );
  procedure InitSocket(id : string; aSocket : TClientSocket);
  procedure LogMemReport(LogId : string);

  var
    LogProxy : OleVariant;

implementation

           { Delphi 6.0 } //.rag
  uses
    Variants;




  procedure Log( LogId, Info : string ); external 'FIVELogs.dll';
  procedure InitSocket(id : string; aSocket : TClientSocket); external 'FIVELogs.dll';

  procedure LogMemReport;
    begin

      Log(LogId, Format('AllocMem: %d, AllocSize: %d', [ShareMem.GetAllocMemCount, ShareMem.GetAllocMemSize]));

    end;



  {procedure Log( LogId, Info : string );
    begin
    end;

  procedure InitSocket(id : string; aSocket : TClientSocket);
    begin
    end;

  procedure LogMemReport;
    begin
    end;

  }

initialization

  LogProxy := Unassigned;
  
end.

