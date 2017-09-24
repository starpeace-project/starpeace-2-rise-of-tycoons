unit GamblingDen;

interface
  uses
    SysUtils, IllegalKernel, Collection, ClassStorage, MetaCrime;

   type
    TGamblingDen =
      class( TMission )
       protected
          constructor Create( aOwner : TTeam; aMetaMission : TMetaServerMission ); override;
       public
          class function OptionData( index : integer ) : TMissionOptionInfo; override;
       public
          procedure StartMission; override;
          procedure ResearchMission;
          procedure ProceedWithMission; override;
          procedure EndMission; override;
    end;

    const
    MaxCrimes = 2;
    cGamblingDenOptions = 3;
    cComputer1Values = 1;
    cDriving1Values = 2;


implementation

    constructor TGamblingDen.Create( aOwner : TTeam; aMetaMission : TMetaServerMission );
    begin
      inherited;
    end;

    class function TGamblingDen.OptionData( index : integer ) : TMissionOptionInfo;
    var
      i : integer;
      j : integer;
      k : integer;
      l : integer;
      Info : TMissionOptionInfo;
    begin
      if index < cGamblingDenOptions
        then
          begin
            case index of
              0 :
                begin
                  Info.Id := 'NoOption';
                  Info.way := '';
                  Info.compulsory := False;
                  Info.Roles[0] := 'Leader';
                  Info.Roles[1] := 'Driver';
                  Info.Roles[2] := 'Gorilla-1';
                  for i := 3 to (MaxRoles - 1) do
                    Info.Roles[i] := '';
                  Info.Skills[0] := 'Leadership';
                  Info.Skills[1] := 'Driving';
                  Info.Skills[2] := 'Brawling';
                  for l := 3 to (MaxRoles - 1) do
                    Info.Skills[l] := '';
                  Info.SkillValues[0] := 30;
                  Info.SkillValues[1] := 20;
                  Info.SkillValues[2] := 30;
                  for j := 3 to (MaxRoles - 1) do
                    Info.SkillValues[j] := 0;
                  Info.Descriptions[0] := 'Coordinate the explosion';
                  Info.Descriptions[1] := 'Drive to and away from the road spot';
                  Info.Descriptions[2] := 'Keep away any undesired person';
                  for k := 3 to (MaxRoles - 1) do
                    Info.Descriptions[k] := '';
                  Info.Sub := False;
                  Info.ParentOptionId := '';
                  Info.Objective := 'Road';
                  Info.Target := ttpRoad;
                  Info.MaxDistance := 100;
                  Info.ObjCoord.X := 0;
                  Info.ObjCoord.Y := 0;
                  Info.MaxRadius := 0;
                  Info.Duration := 2;
                  Info.Cost := 200;
                  Info.Profit := 0;
                end;
              1 :
                begin
                  Info.Id := 'Destroy with:';
                  Info.way := 'Explosive';
                  Info.compulsory := True;
                  Info.Roles[0] := '';
                  Info.Roles[1] := '';
                  Info.Roles[2] := '';
                  Info.Roles[3] := 'Artificer';
                  for i := 4 to (MaxRoles - 1) do
                    Info.Roles[i] := '';
                  Info.Skills[0] := '';
                  Info.Skills[1] := '';
                  Info.Skills[2] := '';
                  Info.Skills[3] := 'Demolition';
                  for l := 4 to (MaxRoles - 1) do
                    Info.Skills[l] := '';
                  Info.SkillValues[0] := 0;
                  Info.SkillValues[1] := 0;
                  Info.SkillValues[2] := 0;
                  Info.SkillValues[3] := 40;
                  for j := 4 to (MaxRoles - 1) do
                    Info.SkillValues[j] := 0;
                  Info.Descriptions[0] := '';
                  Info.Descriptions[1] := '';
                  Info.Descriptions[2] := '';
                  Info.Descriptions[3] := 'Prepare and execute the explosion';
                  for k := 4 to (MaxRoles - 1) do
                    Info.Descriptions[k] := '';
                  Info.Sub := False;
                  Info.ParentOptionId := '';
                  Info.Objective := 'Road';
                  Info.Target := ttpRoad;
                  Info.MaxDistance := 100;
                  Info.ObjCoord.X := 0;
                  Info.ObjCoord.Y := 0;
                  Info.MaxRadius := 0;
                  Info.Duration := 0;
                  Info.Cost := 10000;
                  Info.Profit := 0;
                end;
              2 :
                begin
                  Info.Id := 'Destroy with:';
                  Info.way := 'Muscles';
                  Info.compulsory := True;
                  Info.Roles[0] := 'Leader';
                  Info.Roles[1] := '';
                  Info.Roles[2] := '';
                  Info.Roles[3] := '';
                  Info.Roles[4] := 'Gorilla-2';
                  Info.Roles[5] := 'Gorilla-3';
                  Info.Roles[6] := 'Gorilla-4';
                  for i := 7 to (MaxRoles - 1) do
                    Info.Roles[i] := '';
                  Info.Skills[0] := 'Leadership';
                  Info.Skills[1] := '';
                  Info.Skills[2] := '';
                  Info.Skills[3] := '';
                  Info.Skills[4] := 'Brawling';
                  Info.Skills[5] := 'Brawling';
                  Info.Skills[6] := 'Brawling';
                  for l := 7 to (MaxRoles - 1) do
                    Info.Skills[l] := '';
                  Info.SkillValues[0] := 50;
                  Info.SkillValues[1] := 0;
                  Info.SkillValues[2] := 0;
                  Info.SkillValues[3] := 0;
                  Info.SkillValues[4] := 20;
                  Info.SkillValues[5] := 20;
                  Info.SkillValues[6] := 20;
                  for j := 7 to (MaxRoles - 1) do
                    Info.SkillValues[j] := 0;
                  Info.Descriptions[0] := '';
                  Info.Descriptions[1] := '';
                  Info.Descriptions[2] := '';
                  Info.Descriptions[3] := '';
                  Info.Descriptions[4] := 'Physically destroys the road';
                  Info.Descriptions[5] := 'Physically destroys the road';
                  Info.Descriptions[6] := 'Physically destroys the road';
                  for k := 7 to (MaxRoles - 1) do
                    Info.Descriptions[k] := '';
                  Info.Sub := False;
                  Info.ParentOptionId := '';
                  Info.Objective := 'Road';
                  Info.Target := ttpRoad;
                  Info.MaxDistance := 100;
                  Info.ObjCoord.X := 0;
                  Info.ObjCoord.Y := 0;
                  Info.MaxRadius := 0;
                  Info.Duration := 2;
                  Info.Cost := 10000;
                  Info.Profit := 0;
                end;
            end;
            Result := Info;
          end
        else
          result := inherited OptionData( index );
    end;


    procedure TGamblingDen.ResearchMission;
    begin

    end;

  procedure TGamblingDen.StartMission;
    begin
      //DestroyWith := Parameters.Way[1];
      //PoliceAlerted := False;
      StartingTime := Time;
      Profit := 0;
      Change := 'yes';
      Ready := True;
    end;

  procedure TGamblingDen.ProceedWithMission;
    begin
    if ready = true then
      begin
      if MissionTime = 0
      then
        //DriveToTheRoad(20);
        {drive to facility}
      if MissionTime = 1
      then
        {set up facility}
      if MissionTime >= 2
      then
        {make money}
      end;  
    end;

  procedure TGamblingDen.EndMission;
    var
      i : integer;
    begin
      for i := 1 to 8 do
      if roles.Name[i] <> '' then
        begin
        if Roles.Result[i] = 'Arrested'
        then
          IllSystem.CriminalArrested(Roles.Name[i])
        else
          IllSystem.GiveChargesToCriminal(Roles.Name[i]);
        end;  
      Ready := False;
      IllSystem.GiveChargesToLeader((IllSystem.FindCriminalInSystem(TRolesInMission(Roles).Name[1])).LeaderName, MetaMission.Name, StartingTime, Charges);
      Report.Values['endmission'] := 'The Mission has now ended';
    end;
end.
