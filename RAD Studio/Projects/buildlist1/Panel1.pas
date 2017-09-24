unit Panel1;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls;

type
  buildlist1 = class(TPanel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Five', [buildlist1]);
end;

end.
