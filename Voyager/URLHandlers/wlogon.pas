unit wlogon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ExtCtrls,VisualControls;

type
  Ttwlogon = class(TVisualControl)       //  TForm      
    logon: TPanel;                                        
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    companyimage: TImageList;
    companylist: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
    companycount: integer;
  end;

var
  twlogon: Ttwlogon;

implementation

{$R *.dfm}

end.