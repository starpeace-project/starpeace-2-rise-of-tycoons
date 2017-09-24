unit ftconnection;

interface
  uses
  WinSockRDOConnection, RDOInterfaces, RDOObjectProxy,logs,variants;

  type
  Tftconnection = class
    public
    fconnection : olevariant;
   published
    function connect : olevariant;
  end;

  const
  faddr = '127.0.0.1';
  fport =  10000;

implementation

function Tftconnection.connect : olevariant;
   var
     IBCnx : IRDOConnectionInit;
   begin
     IBCnx        := TWinSockRDOConnection.Create('football client main');
     IBCnx.Server := 'localhost';
     IBCnx.Port   := 9999;
     if IBCnx.Connect( 1000000 )
     then
        begin
        result := TRDOObjectProxy.Create as IDispatch;
        result.SetConnection( IBCnx );
        result.BindTo( 'football' );
        logs.Log('connection','connect');
        end
     else
        begin
        result := null;
        logs.Log('connection','no connect');
        end;
   end;


   
end.
