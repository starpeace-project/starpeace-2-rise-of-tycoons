unit MissionViewer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FramedButton, ExtCtrls, ComCtrls, VoyagerInterfaces, VoyagerServerInterfaces,
  InternationalizerComponent, CrimeMainViewer,MapIsoView,Literals,logs, map,
  roads, MapTypes,jpeg,CrimeProtocol;

type
  TMisionView = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Notebook1: TNotebook;
    CloseBtn: TFramedButton;
    ListBox1: TListBox;
    Label13: TLabel;
    FramedButton6: TFramedButton;
    FramedButton1: TFramedButton;
    Label1: TLabel;
    FramedButton2: TFramedButton;
    FramedButton3: TFramedButton;
    FramedButton4: TFramedButton;
    Label4: TLabel;
    ListView1: TListView;
    MissionOption1: TCheckBox;
    MissionWays1: TComboBox;
    Label5: TLabel;
    Label9: TLabel;
    MissionOption2: TCheckBox;
    MissionWays2: TComboBox;
    MissionOption3: TCheckBox;
    MissionWays3: TComboBox;
    MissionOption4: TCheckBox;
    MissionWays4: TComboBox;
    FramedButton5: TFramedButton;
    FramedButton7: TFramedButton;
    FramedButton8: TFramedButton;
    Label6: TLabel;
    Panel1: TPanel;
    Memo1: TMemo;
    InternationalizerComponent1: TInternationalizerComponent;
    x1: TEdit;
    y1: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    ibmimage: TImage;
    miserror: TLabel;
    FramedButton9: TFramedButton;
    FramedButton10: TFramedButton;
    procedure FormShow(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FramedButton6Click(Sender: TObject);
    procedure FramedButton2Click(Sender: TObject);
    procedure FramedButton4Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FramedButton9Click(Sender: TObject);
    procedure FramedButton5Click(Sender: TObject);
    procedure FramedButton3Click(Sender: TObject);
    procedure FramedButton7Click(Sender: TObject);
    procedure FramedButton10Click(Sender: TObject);
  private
    fClientView       : IClientView;
    fMasterURLHandler : IMasterURLHandler;
    fIllSystem        : olevariant;
    fLeader           : TStringList;
    fTeam             : TStringList;
    fCriminals        : TStringList;
    fthemap           : TMapIsoViewer;
    fmissionno        : integer;
    fthemap2           : tworldmap;
    fMainView         : TCrimeMainView;
  public
    property ClientView       : IClientView       write fClientView;
    property MasterURLHandler : IMasterURLHandler write fMasterURLHandler;
    property IllSystem        : olevariant        write fIllSystem;
    property Leader           : TStringList       write fLeader;
    property Team             : TStringList       write fTeam;
    property Criminals        : TStringlist       write fCriminals;
    property missionno        : integer    read fmissionno write fmissionno;
    property MainView         : TCrimeMainView    write fMainView;
  end;

var
  MisionView: TMisionView;

implementation

{$R *.DFM}


procedure TMisionView.FormShow(Sender: TObject);
 var
 a: string;
begin
{on show}
  a:= fTeam.Values['MissionName'];
  if a <> '' then
    begin    //they have a mission
      notebook1.ActivePage:='4'; //now add info on mission
      if fteam.Values['Ready'] = 'true' then FramedButton10.text :='Cancel mission' else FramedButton10.text:='Confrim Mission End';
      memo1.Text := fillsystem.RDOGetMissionReport(fLeader.Values['Name'],fTeam.Values['Name']);
    end
  else
    begin   //no mission
      missionno:= -1;
      label13.Caption:= 'Click on a mission and select to see the details';
      notebook1.ActivePage:='1';
    end;
end;

procedure TMisionView.CloseBtnClick(Sender: TObject);
begin
  close;
end;

procedure TMisionView.FramedButton6Click(Sender: TObject);
var
  mi1:string;
begin
{if mission selected, go to next section
get mission name and see whats needed}

    {simple bit first, edit later for other types of missions, like kill pres}
    notebook1.ActivePage:= '2';
    label3.Caption:= 'Step 2 of 3';

end;

procedure TMisionView.FramedButton2Click(Sender: TObject);
var
x,y:integer;

begin
{get x and y location from slected building}
  x:= MapIsoView.currx;        //  .fCurrX
  y:= MapIsoView.curry;
  x1.text:= inttostr(x);
  y1.text:= inttostr(y);
end;

procedure TMisionView.FramedButton4Click(Sender: TObject);
var
  go,x,y,objid,misago,i:integer;
  errcode:TErrorCode;
  theroad:troad;
  roles,cstate: string;
  rn: array[0..7] of boolean;
  rn2: array[0..7] of string;
  ListItem: TListItem;
begin
{first, make sure a target is picked, next check target is right, then go to next bit}
  go:= 1;
  misago:=0;
  try
    x := StrToint(x1.Text);
  except
    on E: EConvertError do
      begin
      go:=0;
      miserror.caption:='invalid co ordinates';
      end;
    end;
  try
    y := StrToint(y1.Text);
  except
    on E: EConvertError do
      begin
      go:=0;
      miserror.caption:='invalid co ordinates';
      end;
    end;
  logs.Log('missionview','valid co ords');
  if go = 1 then
    begin
     {find out whats at the location, then check it's the correct target to mission type}
     //objid:=fClientView.ObjectAt(x,y,errcode);
     logs.Log('missionview','mission no: ' + inttostr(missionno));
     case missionno of
     0:
      begin
      {gambling den}
          FramedButton5.Visible:=false;
          listview1.Clear; //show roles needed
          for i:=0 to 7 do
            begin
             rn[i]:=false;
            end;

          for i:=0 to pred(fcriminals.Count) do
            begin
             //check which criminals are there and if we have the requirements for mission
             // TStringList(fCriminals.Objects[i]).Values['value']
             // roles needed - leader, driver, gorillia, artificer
             cstate:=TStringList(fCriminals.Objects[i]).Values['State'];
             if ((cstate='0') or (cstate='1') or (cstate='2') or (cstate='3')) then
             begin
             roles:= TStringList(fCriminals.Objects[i]).Values['Role'];
             if ((roles = 'Leader') and (rn[0]= false)) then
              begin
               //ListItem:=listview1.Items.Insert(0);
               ListItem:=listview1.Items.Insert(0);
               listitem.Caption:='Leader';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[0]:=true;
              end;
              if ((roles = 'Gorilla') and (rn[1]= false)) then
              begin
               ListItem:=listview1.Items.Insert(1);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[1]:=true;
               rn2[0]:= TStringList(fCriminals.Objects[i]).Values['Name'];
              end;
              if ((roles = 'Gorilla') and (rn[1]= true) and (rn[2]= false) and (TStringList(fCriminals.Objects[i]).Values['Name'] <> rn2[0])) then
              begin
               ListItem:=listview1.Items.Insert(2);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[2]:=true;
              end;
              if ((roles = 'Falsifier') and (rn[3]= false)) then
              begin
               ListItem:=listview1.Items.Insert(3);
               listitem.Caption:='Falsifier';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'o');
               rn[3]:=true;
              end;
              if ((roles = 'Hacker') and (rn[4]= false)) then
              begin
               ListItem:=listview1.Items.Insert(4);
               listitem.Caption:='Hacker';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'o');
               rn[4]:=true;
              end;
            end;
            end;
            //set options
            if rn[0] = false then
              begin
            ListItem:=listview1.Items.Insert(0);
               listitem.Caption:='Leader';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[1] = false then
              begin
            ListItem:=listview1.Items.Insert(1);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[2] = false then
              begin
            ListItem:=listview1.Items.Insert(2);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[3] = false then
              begin
            ListItem:=listview1.Items.Insert(3);
               listitem.Caption:='Falsifier';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'o');
              end;
            if rn[4] = false then
              begin
            ListItem:=listview1.Items.Insert(4);
               listitem.Caption:='Hacker';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'o');
              end;
            MissionOption1.Visible:=true;
          MissionOption2.Visible:=true;
          MissionOption3.Visible:=false;
          MissionOption4.Visible:=false;
          MissionWays1.Visible:=True;
          MissionWays2.Visible:=true;
          MissionWays3.Visible:=false;
          MissionWays4.Visible:=false;
          MissionOption1.Caption:='Use Falsifier';
          MissionOption1.Checked:=true;
          MissionOption2.Caption:='Hack ';
          MissionOption2.Checked:=true;
           MissionWays1.Clear;
          MissionWays1.Items.Insert(0,'No');
          if rn[3] = true then MissionWays1.Items.Insert(1,'yes');
          MissionWays1.ItemIndex:=0;
          MissionWays2.Clear;
          MissionWays2.Items.Insert(0,'no');
          MissionWays2.Items.Insert(1,'yes');
          MissionWays2.ItemIndex:=0;
          if rn[3] = true then Missionways1.Enabled:= true else Missionways1.Enabled:=false;
          if rn[4] = true then Missionways2.Enabled:= true else Missionways2.Enabled:=false;
          if (rn[0] and rn[1] and rn[2]) then FramedButton5.Visible:=true;
           notebook1.ActivePage:= '3';
           label3.Caption:= 'Step 3 of 3';
      end;
     1:
      begin
      {bank robbery}
          FramedButton5.Visible:=false;
          listview1.Clear; //show roles needed
          for i:=0 to 7 do
            begin
             rn[i]:=false;
            end;
            
          for i:=0 to pred(fcriminals.Count) do
            begin
             //check which criminals are there and if we have the requirements for mission
             // TStringList(fCriminals.Objects[i]).Values['value']
             // roles needed - leader, driver, gorillia, artificer
             cstate:=TStringList(fCriminals.Objects[i]).Values['State'];
             if ((cstate='0') or (cstate='1') or (cstate='2') or (cstate='3')) then
             begin
             roles:= TStringList(fCriminals.Objects[i]).Values['Role'];
             if ((roles = 'Leader') and (rn[0]= false)) then
              begin
               //ListItem:=listview1.Items.Insert(0);
               ListItem:=listview1.Items.Insert(0);
               listitem.Caption:='Leader';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[0]:=true;
              end;
              if ((roles = 'Driver') and (rn[1]= false)) then
              begin
               ListItem:=listview1.Items.Insert(1);
               listitem.Caption:='Driver';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[1]:=true;
              end;
              if ((roles = 'Gorilla') and (rn[2]= false)) then
              begin
               ListItem:=listview1.Items.Insert(2);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[2]:=true;
              end;
              if ((roles = 'Artificer') and (rn[3]= false)) then
              begin
               ListItem:=listview1.Items.Insert(3);
               listitem.Caption:='Artificer';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'o');
               rn[3]:=true;
              end;
              if ((roles = 'Hacker') and (rn[4]= false)) then
              begin
               ListItem:=listview1.Items.Insert(4);
               listitem.Caption:='Hacker';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'o');
               rn[4]:=true;
               rn2[0]:= TStringList(fCriminals.Objects[i]).Values['Name']
              end;
              if ((roles = 'Hacker') and (rn[4]= true) and (rn[5]= false) and(TStringList(fCriminals.Objects[i]).Values['Name']<>rn2[0])) then
              begin
               ListItem:=listview1.Items.Insert(5);
               listitem.Caption:='Hacker';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'o');
               rn[5]:=true;
              end;
            end;
            end;
          //set options
            if rn[0] = false then
              begin
            ListItem:=listview1.Items.Insert(0);
               listitem.Caption:='Leader';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[1] = false then
              begin
            ListItem:=listview1.Items.Insert(1);
               listitem.Caption:='Driver';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[2] = false then
              begin
            ListItem:=listview1.Items.Insert(2);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[3] = false then
              begin
            ListItem:=listview1.Items.Insert(3);
               listitem.Caption:='Artificer';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'o');
              end;
            if rn[4] = false then
              begin
            ListItem:=listview1.Items.Insert(4);
               listitem.Caption:='Hacker';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'o');
              end;
            if rn[5] = false then
              begin
            ListItem:=listview1.Items.Insert(5);
               listitem.Caption:='Hacker';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'o');
              end;
          MissionOption1.Visible:=true;
          MissionOption2.Visible:=true;
          MissionOption3.Visible:=false;
          MissionOption4.Visible:=false;
          MissionWays1.Visible:=True;
          MissionWays2.Visible:=true;
          MissionWays3.Visible:=false;
          MissionWays4.Visible:=false;
          MissionOption1.Caption:='Open vault';
          MissionOption1.Checked:=true;
          MissionOption2.Caption:='Hack security';
          MissionOption2.Checked:=true;
          //MissionOption1.
          MissionWays1.Clear;
          MissionWays1.Items.Insert(0,'No');
          if rn[3] = true then MissionWays1.Items.Insert(1,'Explosives');
          if rn[5] = true then MissionWays1.Items.Insert(2,'Hacker');
          MissionWays1.ItemIndex:=0;
          MissionWays2.Clear;
          MissionWays2.Items.Insert(0,'no');
          MissionWays2.Items.Insert(1,'yes');
          MissionWays2.ItemIndex:=0;
          if rn[3] = true then Missionways1.Enabled:= true else Missionways1.Enabled:=false;
          if rn[4] = true then Missionways2.Enabled:= true else Missionways2.Enabled:=false;
          if (rn[0] and rn[1] and rn[2]) then FramedButton5.Visible:=true;
          {MissionOption2.caption:='Driver';
          MissionOption3.caption:='Gorilla'; }
           notebook1.ActivePage:= '3';
           label3.Caption:= 'Step 3 of 3';
      end;
     2:
      begin
        {destroy road}
        {theroad:=fthemap2.GetRoad(x,y);
        if theroad = roadNone then
          begin
           go:=0;
           miserror.caption:='This is not a road';
           logs.Log('missionview','not a road');
          end
        else
          begin

           logs.Log('missionview','is a road, go to next');
          end;}
          FramedButton5.Visible:=false;
          listview1.Clear; //show roles needed
          for i:=0 to 7 do
            begin
             rn[i]:=false;
            end;
            
          for i:=0 to pred(fcriminals.Count) do
            begin
             //check which criminals are there and if we have the requirements for mission
             // TStringList(fCriminals.Objects[i]).Values['value']
             // roles needed - leader, driver, gorillia, artificer
             cstate:=TStringList(fCriminals.Objects[i]).Values['State'];
             if ((cstate='0') or (cstate='1') or (cstate='2') or (cstate='3')) then
             begin
             roles:= TStringList(fCriminals.Objects[i]).Values['Role'];
             if ((roles = 'Leader') and (rn[0]= false)) then
              begin
               //ListItem:=listview1.Items.Insert(0);
               ListItem:=listview1.Items.Insert(0);
               listitem.Caption:='Leader';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[0]:=true;
              end;
              if ((roles = 'Driver') and (rn[1]= false)) then
              begin
               ListItem:=listview1.Items.Insert(1);
               listitem.Caption:='Driver';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[1]:=true;
              end;
              if ((roles = 'Gorilla') and (rn[2]= false)) then
              begin
               ListItem:=listview1.Items.Insert(2);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'y');
               rn[2]:=true;
              end;
              if ((roles = 'Artificer') and (rn[3]= false)) then
              begin
               ListItem:=listview1.Items.Insert(3);
               listitem.Caption:='Artificer';
               listitem.SubItems.Insert(0,TStringList(fCriminals.Objects[i]).Values['Name']);
               listitem.SubItems.Insert(1,'o');
               rn[3]:=true;
              end;
            end;
            end;
          //set options
            if rn[0] = false then
              begin
            ListItem:=listview1.Items.Insert(0);
               listitem.Caption:='Leader';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[1] = false then
              begin
            ListItem:=listview1.Items.Insert(1);
               listitem.Caption:='Driver';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[2] = false then
              begin
            ListItem:=listview1.Items.Insert(2);
               listitem.Caption:='Gorilla';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'y');
              end;
            if rn[3] = false then
              begin
            ListItem:=listview1.Items.Insert(3);
               listitem.Caption:='Artificer';
               listitem.SubItems.Insert(0,'NONE');
               listitem.SubItems.Insert(1,'o');
              end;
          MissionOption1.Visible:=true;
          MissionOption2.Visible:=false;
          MissionOption3.Visible:=false;
          MissionOption4.Visible:=false;
          MissionWays1.Visible:=True;
          MissionWays2.Visible:=false;
          MissionWays3.Visible:=false;
          MissionWays4.Visible:=false;
          MissionOption1.Caption:='Method';
          MissionOption1.Checked:=true;
          //MissionOption1.
          MissionWays1.Clear;
          MissionWays1.Items.Insert(0,'By hand');
          MissionWays1.Items.Insert(1,'Explosive');
          MissionWays1.ItemIndex:=0;
          if rn[3] = true then Missionways1.Enabled:= true else Missionways1.Enabled:=false;
          if (rn[0] and rn[1] and rn[2]) then FramedButton5.Visible:=true;
          {MissionOption2.caption:='Driver';
          MissionOption3.caption:='Gorilla'; }
           notebook1.ActivePage:= '3';
           label3.Caption:= 'Step 3 of 3';
        end;
      end;
     //logs.Log('missionview','object at: x-' + inttostr(x) + ' y-' + inttostr(y) + ' objtid-' +inttostr(objid) + ' -done that');
    end;
  if go = 0 then miserror.Visible:=true else miserror.Visible:=false;
end;

procedure TMisionView.ListBox1Click(Sender: TObject);

begin
  {find which one was selected}



end;

procedure TMisionView.FramedButton9Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to 2 do
    begin
      if listbox1.Selected[i] then missionno:=i;
    end;

    FramedButton6.Visible:= true;
    label13.Caption:=GetLiteral('ibm'+inttostr(missionno));
    {ibmimage.Picture.LoadFromFile('');   //add in later}
end;

procedure TMisionView.FramedButton5Click(Sender: TObject);
var
  LeaderName,TeamName,MissionName,TargetPlayer,Cost:widestring;
  RolesList,ParametersList,Objective,TargetName,TargetFacType : widestring;
  RolesList2,ParametersList2 : tstringlist;
  ListItem: TListItem;
  ObjectiveX, ObjectiveY,TargetType,Radius,missetup,missetup2: integer;

begin
logs.Log('missetup','start setting up the mission');
{send the info to the server and start mission}
  LeaderName:=fleader.Values['Name'];
  TeamName:=fteam.Values['Name'];
  logs.Log('missetup','leader and team name');
{mission specific info}
  case missionno of
    0:
      begin
      {gambling den}
      logs.Log('missetup','mission: gambling den');
      MissionName:='Gambling Place';
       RolesList2:=TStringList.Create;
      logs.Log('missetup','set up roles');
      ListItem:=listview1.Items[0];
      RolesList2.Values['Name1']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role1']:= 'Leader';
      ListItem:=listview1.Items[1];
      RolesList2.Values['Name2']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role2']:= 'Gorilla-1';
      ListItem:=listview1.Items[2];
      RolesList2.Values['Name3']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role3']:= 'Gorilla-2';
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'yes' then
        begin
           ListItem:=listview1.Items[3];
          RolesList2.Values['Name4']:= listitem.SubItems.Strings[0];
          RolesList2.Values['Role4']:= 'Falsifier';
        end
        else
        begin
          RolesList2.Values['Name4']:= '';
          RolesList2.Values['Role4']:= '';
        end;
       if MissionWays2.Items.Strings[MissionWays2.ItemIndex] = 'yes' then
        begin
           ListItem:=listview1.Items[4];
          RolesList2.Values['Name5']:= listitem.SubItems.Strings[0];
          RolesList2.Values['Role5']:= 'Hacker';
        end
        else
        begin
          RolesList2.Values['Name5']:= '';
          RolesList2.Values['Role5']:= '';
        end;
        {setup unused roles then put roles into widestring}
      logs.Log('missetup','unused roles');
      RolesList2.Values['Name6']:= '';
      RolesList2.Values['Role6']:= '';
      RolesList2.Values['Name7']:= '';
      RolesList2.Values['Role7']:= '';
      RolesList2.Values['Name8']:= '';
      RolesList2.Values['Role8']:= '';
      RolesList := RolesList2.Text;
      {set up ParametersList}
      logs.Log('missetup','setup parameters');
      ParametersList2:=TStringList.Create;
      ParametersList2.Values['Name1']:='Produce fake money:';
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'yes' then ParametersList2.Values['Value1']:='True' else ParametersList2.Values['Value1']:='False';
      ParametersList2.Values['Way1']:=MissionWays1.Items.Strings[MissionWays1.ItemIndex];
      ParametersList2.Values['Name2']:='Hack gambling equipment:';
      ParametersList2.Values['Value2']:='True';
      if MissionWays2.Items.Strings[MissionWays2.ItemIndex] = 'No' then ParametersList2.Values['Way2']:='' else ParametersList2.Values['Way2']:='yes';
      {setup unused params and put into widestring}
      ParametersList2.Values['Name3']:='';
      ParametersList2.Values['Value3']:='';
      ParametersList2.Values['Way3']:='';
      ParametersList2.Values['Name4']:='';
      ParametersList2.Values['Value4']:='';
      ParametersList2.Values['Way4']:='';
      ParametersList := ParametersList2.Text;
      {objective   Objective : widestring;}
      logs.Log('missetup','remaining stuff');
      Objective := 'Building';
      ObjectiveX:=StrToint(x1.Text);
      ObjectiveY:=StrToint(y1.Text);
      TargetType:=6;
      TargetName:='Building';
      Radius:=0;
      TargetPlayer:='';
      TargetFacType:='Facility';
      Cost:='1000';
      logs.Log('missetup','ready to go');
      end;
    1:
      begin
      {bank robbery}
      logs.Log('missetup','mission: bank robbery');
      MissionName:='Bank Robbery';
      {set up roles}
      RolesList2:=TStringList.Create;
      logs.Log('missetup','set up roles');
      ListItem:=listview1.Items[0];
      RolesList2.Values['Name1']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role1']:= 'Leader';
      ListItem:=listview1.Items[1];
      RolesList2.Values['Name2']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role2']:= 'Driver';
      ListItem:=listview1.Items[2];
      RolesList2.Values['Name3']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role3']:= 'Gorilla';
      {optional roles if required   -road MissionWays1.Items.Insert(1,'Explosives');}
      logs.Log('missetup','optional roles');
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'Explosives' then
        begin
           ListItem:=listview1.Items[3];
          RolesList2.Values['Name4']:= listitem.SubItems.Strings[0];
          RolesList2.Values['Role4']:= 'Artificer';
        end
        else
        begin
          RolesList2.Values['Name4']:= '';
          RolesList2.Values['Role4']:= '';
        end;
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'Hacker' then
        begin
           ListItem:=listview1.Items[5];
          RolesList2.Values['Name6']:= listitem.SubItems.Strings[0];
          RolesList2.Values['Role6']:= 'Hacker-2';
        end
        else
        begin
          RolesList2.Values['Name6']:= '';
          RolesList2.Values['Role6']:= '';
        end;
       if MissionWays2.Items.Strings[MissionWays2.ItemIndex] = 'yes' then
        begin
           ListItem:=listview1.Items[4];
          RolesList2.Values['Name5']:= listitem.SubItems.Strings[0];
          RolesList2.Values['Role5']:= 'Hacker-1';
        end
        else
        begin
          RolesList2.Values['Name5']:= '';
          RolesList2.Values['Role5']:= '';
        end;
      {setup unused roles then put roles into widestring}
      logs.Log('missetup','unused roles');
      RolesList2.Values['Name7']:= '';
      RolesList2.Values['Role7']:= '';
      RolesList2.Values['Name8']:= '';
      RolesList2.Values['Role8']:= '';
      RolesList := RolesList2.Text;
      {set up ParametersList}
      logs.Log('missetup','setup parameters');
      ParametersList2:=TStringList.Create;
      ParametersList2.Values['Name1']:='Hack into security:';
      if MissionWays2.Items.Strings[MissionWays2.ItemIndex] = 'yes' then ParametersList2.Values['Value1']:='True' else ParametersList2.Values['Value1']:='False';
      ParametersList2.Values['Way1']:=MissionWays1.Items.Strings[MissionWays1.ItemIndex];
      ParametersList2.Values['Name2']:='Open Vault:';
      ParametersList2.Values['Value2']:='True';
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'No' then ParametersList2.Values['Way2']:='' else ParametersList2.Values['Way2']:=MissionWays1.Items.Strings[MissionWays1.ItemIndex];
      {setup unused params and put into widestring}
      ParametersList2.Values['Name3']:='';
      ParametersList2.Values['Value3']:='';
      ParametersList2.Values['Way3']:='';
      ParametersList2.Values['Name4']:='';
      ParametersList2.Values['Value4']:='';
      ParametersList2.Values['Way4']:='';
      ParametersList := ParametersList2.Text;
      {objective   Objective : widestring;}
      logs.Log('missetup','remaining stuff');
      Objective := 'Bank';
      ObjectiveX:=StrToint(x1.Text);
      ObjectiveY:=StrToint(y1.Text);
      TargetType:=6;
      TargetName:='Bank';
      Radius:=0;
      TargetPlayer:='';
      TargetFacType:='Bank';
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'Explosives' then Cost:='30000' else Cost:='5000';
      logs.Log('missetup','ready to go');
      end;
    2:
      begin
      {road destroy}
      logs.Log('missetup','mission: destroy road');
      MissionName:='Destroy Road';
      {set up roles}              // MissionWays1.Items[MissionWays1.ItemIndex].Text
      RolesList2:=TStringList.Create;
      logs.Log('missetup','set up roles');
      ListItem:=listview1.Items[0];
      RolesList2.Values['Name1']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role1']:= 'Leader';
      ListItem:=listview1.Items[1];
      RolesList2.Values['Name2']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role2']:= 'Driver';
      ListItem:=listview1.Items[2];
      RolesList2.Values['Name3']:= listitem.SubItems.Strings[0];
      RolesList2.Values['Role3']:= 'Gorilla';
      {optional roles if required   -road MissionWays1.Items.Insert(1,'Explosives');}
      logs.Log('missetup','optional roles - seltext= ' + MissionWays1.Items.Strings[MissionWays1.ItemIndex]);
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'Explosive' then
        begin
           ListItem:=listview1.Items[3];
          RolesList2.Values['Name4']:= listitem.SubItems.Strings[0];
          RolesList2.Values['Role4']:= 'Artificer';
        end
        else
        begin
          RolesList2.Values['Name4']:= '';
          RolesList2.Values['Role4']:= '';
        end;
      {setup unused roles then put roles into widestring}
      logs.Log('missetup','unused roles');
      RolesList2.Values['Name5']:= '';
      RolesList2.Values['Role5']:= '';
      RolesList2.Values['Name6']:= '';
      RolesList2.Values['Role6']:= '';
      RolesList2.Values['Name7']:= '';
      RolesList2.Values['Role7']:= '';
      RolesList2.Values['Name8']:= '';
      RolesList2.Values['Role8']:= '';
      RolesList := RolesList2.Text;
      {set up ParametersList}
      logs.Log('missetup','setup parameters');
      ParametersList2:=TStringList.Create;
      ParametersList2.Values['Name1']:='Destroy with:';
      ParametersList2.Values['Value1']:='True';
      ParametersList2.Values['Way1']:=MissionWays1.Items.Strings[MissionWays1.ItemIndex];
      {setup unused params and put into widestring}
      ParametersList2.Values['Name2']:='';
      ParametersList2.Values['Value2']:='';
      ParametersList2.Values['Way2']:='';
      ParametersList2.Values['Name3']:='';
      ParametersList2.Values['Value3']:='';
      ParametersList2.Values['Way3']:='';
      ParametersList2.Values['Name4']:='';
      ParametersList2.Values['Value4']:='';
      ParametersList2.Values['Way4']:='';
      ParametersList := ParametersList2.Text;
      {objective   Objective : widestring;}
      logs.Log('missetup','remaining stuff');
      Objective := 'Road';
      ObjectiveX:=StrToint(x1.Text);
      ObjectiveY:=StrToint(y1.Text);
      TargetType:=1;
      TargetName:='Road';
      Radius:=0;
      TargetPlayer:='';
      TargetFacType:='';
      if MissionWays1.Items.Strings[MissionWays1.ItemIndex] = 'Explosive' then Cost:='10000' else Cost:='200';
      logs.Log('missetup','ready to go');
      end;
  end;
{setup mission}
if ((missionno = 1) or (missionno = 2)) then
  begin
  logs.Log('missetup','send data');
  missetup:=fillsystem.RDOAssignMission(LeaderName, TeamName, MissionName, RolesList,ParametersList, Objective, ObjectiveX, ObjectiveY, TargetType,TargetName, Radius, TargetPlayer, TargetFacType, Cost);
  logs.Log('missetup','data sent, got back: ' + inttostr(missetup));
  end;
 {if ok, start mission}
if missetup = CRIME_NOERROR then
  begin
  {start mission}
   logs.Log('missetup','no error');
   missetup2:= fillsystem.RDOStartMission(LeaderName, TeamName, MissionName);
   logs.Log('missetup','started mission got back - ' + inttostr(missetup2));
  end
  else
  begin
  {error has occured}
   logs.Log('missetup','error occured');
  end;
end;

procedure TMisionView.FramedButton3Click(Sender: TObject);
begin
  notebook1.ActivePage:= '1';
end;

procedure TMisionView.FramedButton7Click(Sender: TObject);
begin
notebook1.ActivePage:= '2';
end;

procedure TMisionView.FramedButton10Click(Sender: TObject);
var
  misend:integer;
  cancel:string;
begin
    cancel:= 'false';
    misend:= fillsystem.RDODeassignMission(fleader.Values['Name'], fteam.Values['Name'], Cancel, fTeam.Values['MissionName']);
end;

end.
