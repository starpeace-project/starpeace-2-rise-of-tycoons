unit Configuration;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TConfigurationFrm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    IPconfig: TEdit;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    { Private declarations }
    { Public declarations }
  end;

var
  ConfigurationFrm: TConfigurationFrm;

implementation

uses
   Registry, DirectoryRegistry;


{$R *.DFM}


procedure TConfigurationFrm.FormCreate(Sender: TObject);
  var
    Reg : TRegistry;
    aux : string;
  begin
    try
      Reg := TRegistry.Create;
      try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKey( tidRegKey_Directory, false )
          then
            begin
              aux := Reg.ReadString( 'IPAddr' );
              if aux <> ''
                then IPconfig.Text := aux;
            end;
      finally
        Reg.Free;
      end;
    except
    end
  end;

procedure TConfigurationFrm.Button1Click(Sender: TObject);
  var
    Reg : TRegistry;
  begin
    try
      Reg := TRegistry.Create;
      try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKey(tidRegKey_Directory, true)
          then
            begin
              Reg.WriteString('IPAddr', IPconfig.Text);
            end;
      finally
        Reg.Free;
      end;
    except
    end;
  end;

end.
