unit CrimeHandler;

interface

  uses
    VoyagerInterfaces, VoyagerServerInterfaces, Controls, CrimeMainViewer, VCLUtils;

  type
    TMetaCrimeHandler =
      class( TInterfacedObject, IMetaURLHandler )
        public
          constructor Create;
        // IMetaURLHandler
        private
          function getName    : string;
          function getOptions : TURLHandlerOptions;
          function getCanHandleURL( URL : TURL ) : THandlingAbility;
          function Instantiate : IURLHandler;
      end;

    TCrimeHandler =
      class( TInterfacedObject, IURLHandler )
        public
          constructor Create;
          destructor  Destroy; override;
        private
          fControl    : TCrimeMainView;
          fClientView : IClientView;
        // IURLHandler
        private
          function  HandleURL( URL : TURL ) : TURLHandlingResult;
          function  HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
          function  getControl : TControl;
          procedure setMasterURLHandler( const URLHandler : IMasterURLHandler );
        private
          fMasterURLHandler : IMasterURLHandler;
      end;

  const
    tidHandlerName_Crime = 'CrimeHandler';

  const
    evnChatOverMap = 2030;
    

implementation

  uses
    SysUtils, ServerCnxHandler, Protocol, Classes, ChatHandler, MapIsoHandler,
    Events, VoyagerUIEvents, ServerCnxEvents, Threads, MetaCrime, ClassStorage,
    WinSockRDOConnection, RDOServer, RDOInterfaces, Variants, RDOObjectProxy,logs;


  // TMetaCrimeHandler

  constructor TMetaCrimeHandler.Create;

    procedure CreateMetaInstances;
      var
        AttrLean     : TMetaAttribute;
        ModLean      : TMetaModifier;
        RoleLean     : TMetaRole;
        AttrModLean  : TAttributeModifier;
        HistItemLean : TMetaHistoryItem;
        CrimLean     : TMetaCriminal;
        CrimSkills   : TStringList;
        ChargeLean   : TMetaCharge;
      begin
        (*
        // Create and Register Attributes

        classId := '11-Skill:Driving';
        AttrLean := TMetaAttribute.Create(classID, 'Driving', 'Driving Skill', 0);
        AttrLean.Register('Attribute');
        classId := '12-Skill:FireArms';
        AttrLean := TMetaAttribute.Create(classID, 'Firearms', 'FireArms Skill', 0);
        AttrLean.Register('Attribute');
        classId := '13-Skill:Computer';
        AttrLean := TMetaAttribute.Create(classID, 'Computer', 'Computer Skill', 0);
        AttrLean.Register('Attribute');
        classId := '14-Skill:Leadership';
        AttrLean := TMetaAttribute.Create(classID, 'Leadership', 'Leadership Skill', 0);
        AttrLean.Register('Attribute');
        classId := '15-Skill:Brawling';
        AttrLean := TMetaAttribute.Create(classID, 'Brawling', 'Brawling Skill', 0);
        AttrLean.Register('Attribute');
        classId := '16-Skill:Demolition';
        AttrLean := TMetaAttribute.Create(classID, 'Demolition', 'Demolition and Fire Setting Skill', 0);
        AttrLean.Register('Attribute');
        classId := '17-Skill:Stealth';
        AttrLean := TMetaAttribute.Create(classID, 'Stealth', 'Stealth and Disguise Skill', 0);
        AttrLean.Register('Attribute');
        classId := '18-Skill:Medicine';
        AttrLean := TMetaAttribute.Create(classID, 'Medicine', 'Cure and Treat Skill', 0);
        AttrLean.Register('Attribute');
        classId := '19-Skill:Forgery';
        AttrLean := TMetaAttribute.Create(classID, 'Forgery', 'Skill of Producing Fake Document and Money', 0);
        AttrLean.Register('Attribute');

        // Create and Register Factors

        classId := '21-Factor:Loyalty';
        AttrLean := TMetaAttribute.Create(classID, 'Loyalty', 'How much the criminal is loyal to his boss', 20);
        AttrLean.Register('Attribute');
        classId := '22-Factor:Stability';
        AttrLean := TMetaAttribute.Create(classID, 'Stability', 'An indication of the mental sanity of the criminal', 0);
        AttrLean.Register('Attribute');
        classId := '23-Factor:Intelligence';
        AttrLean := TMetaAttribute.Create(classID, 'Learning', 'An indication of how well the criminal learn', 0);
        AttrLean.Register('Attribute');

        // Create and Register Modifier

        classId := 'Modifier1:SkillsModifier';
        ModLean := TMetaModifier.Create(classID, 'SkillsModifier', 'Used to modify skills');
        ModLean.Register('Modifier');

        // Create and Register Attribute Modifiers

        classId := 'Driving-11';
        AttrModLean := TAttributeModifier.Create(classID, 'Driving Licence ', 'Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 500, 30, 15, 0, 20);
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-12';
        AttrModLean := TAttributeModifier.Create(classID, 'Driving Non-Automatic Cars ', 'Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 300, 10, 10, 15, 30);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-13';
        AttrModLean := TAttributeModifier.Create(classID, 'Streets Knowledge ', 'Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 200, 20, 10, 15, 30);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-14';
        AttrModLean := TAttributeModifier.Create(classID, 'High Speed Driving ', 'Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 1500, 40, 10, 20, 40);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-15';
        AttrModLean := TAttributeModifier.Create(classID, 'Acrobatic Driving ', 'Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 2000, 60, 10, 35, 45);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-16';
        AttrModLean := TAttributeModifier.Create(classID, 'Reverse Driving ', 'Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 500, 30, 5, 30, 35);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-12']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-17';
        AttrModLean := TAttributeModifier.Create(classID, 'Jumps and Two-Wheels ', 'Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 3000, 80, 10, 55, 60);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-12']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-15']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-18';
        AttrModLean := TAttributeModifier.Create(classID, 'Roadblock Bashing ', 'Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 800, 25, 5, 45, 40);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-19';
        AttrModLean := TAttributeModifier.Create(classID, 'Flat Tires Driving ', 'When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 1200, 20, 5, 40, 45);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-12']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-15']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-20';
        AttrModLean := TAttributeModifier.Create(classID, 'Under Fire Driving ', 'Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 2000, 50, 10, 45, 40);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-15']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-21';
        AttrModLean := TAttributeModifier.Create(classID, 'Matching The Right Car ', 'Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 800, 60, 10, 30, 35);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-13']));
        AttrModLean.Register('AttributeModifier');

        // Create and Register History Items

        //Criminals

        classId := 'Criminal11: Training';
        HistItemLean := TMetaHistoryItem.Create(classId, 'Training', 'Every time the criminal completes a training', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal12: Hire';
        HistItemLean := TMetaHistoryItem.Create(classId, 'Hire', 'Every time the criminal is hired', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal13: Fire';
        HistItemLean := TMetaHistoryItem.Create(classId, 'Fire', 'Every time the criminal is fired', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal14: ChangeTeam';
        HistItemLean := TMetaHistoryItem.Create(classId, 'ChangeTeam', 'Every time the criminal changes team', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal15: StartedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'StartedMission', 'Every time the criminal starts an on-going mission', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal16: AccomplishedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'AccomplishedMission', 'Every time the criminal accomplishes a mission', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal17: AssignedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'AssignedMission', 'Every time the criminal is given a mission', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal18: DeassignedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'DeassignedMission', 'Every time the criminal is deassigned a mission', 'Criminal');
        HistItemLean.Register('HistoryItem');

        //Teams

        classId := 'Team11: TeamCreation';
        HistItemLean := TMetaHistoryItem.Create(classId, 'TeamCreation', 'When the team is born', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team12: HiredCriminal';
        HistItemLean := TMetaHistoryItem.Create(classId, 'HiredCriminal', 'Every time a criminal is hired by the team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team13: FiredCriminal';
        HistItemLean := TMetaHistoryItem.Create(classId, 'FiredCriminal', 'Every time a criminal is fired from the team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team14: CriminalChangeTeam';
        HistItemLean := TMetaHistoryItem.Create(classId, 'CriminalChangeTeam', 'Every time a criminal leave or join the team either to go in another team or coming from another team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team15: MissionStarted';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionStarted', 'Every time the team starts a mission', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team16: MissionAccomplished';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionAccomplished', 'Every time the team accomplishes a mission', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team17: MissionAssigned';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionAssigned', 'Every time a leader assigns a mission to the team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team18: MissionDeassigned';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionDeassigned', 'Every time a leader deassigns a mission to the team', 'Team');
        HistItemLean.Register('HistoryItem');

        //Leaders

        classId := 'Leader11: LeaderBorn';
        HistItemLean := TMetaHistoryItem.Create(classId, 'LeaderBorn', 'When the player alter-ego is created', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader12: TeamCreated';
        HistItemLean := TMetaHistoryItem.Create(classId, 'TeamCreated', 'Every time the leader creates a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader13: TeamDismissed';
        HistItemLean := TMetaHistoryItem.Create(classId, 'TeamDismissed', 'Every time the leader dismisses a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader14: CriminalHired';
        HistItemLean := TMetaHistoryItem.Create(classId, 'CriminalHired', 'Every time the leader hire a criminal in a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader15: CriminalFired';
        HistItemLean := TMetaHistoryItem.Create(classId, 'CriminalFired', 'Every time the leader fire a criminal from a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader16: ChangeTeamToCriminal';
        HistItemLean := TMetaHistoryItem.Create(classId, 'ChangeTeamToCriminal', 'Every time the leader moves a criminal from a team to another', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader17: AssignMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'AssignMission', 'Every time the leader assigns a mission to a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader18: DeassignMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'DeassignMission', 'Every time the leader deassigns a mission to a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader19: MissionCompletedByATeam';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionCompletedByATeam', 'Every time a mission assigned to a team has been accomplished', 'Leader');
        HistItemLean.Register('HistoryItem');

        // Create and Register Mission

        classId := 'Mission1:BankRobbery';
        MisLean := TMetaMission.Create(classID, 'Bank Robbery', 'This is the typical bank robbery. The team will enter a bank during its business hours and collect all the money from the counters and the clients and the vault, if you choose so.', 'One-shot');
        MisLean.Register('Mission');
        classId := 'Mission2:GamblingPlace';
        MisLean := TMetaMission.Create(classID, 'Gambling Place', 'The team will run a illegal gambling place', 'On-Going');
        MisLean.Register('Mission');

        // Create and Register Roles

        classId := 'Role0:Unassigned';
        RoleLean := TMetaRole.Create(classId, '', 'No precise role assigned');
        RoleLean.Register('Role');

        classId := 'Role1:Leader';
        RoleLean := TMetaRole.Create(classId, 'Leader', 'The leader of the team');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']));
        RoleLean.Register('Role');

        classId := 'Role2:Driver';
        RoleLean := TMetaRole.Create(classId, 'Driver', 'Drives your way to or away your destination');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']));
        RoleLean.Register('Role');

        classId := 'Role3:Hacker';
        RoleLean := TMetaRole.Create(classId, 'Hacker', 'Computer Wizard');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']));
        RoleLean.Register('Role');

        classId := 'Role4:Gorilla';
        RoleLean := TMetaRole.Create(classId, 'Gorilla', 'He is big and knows how to beat you up');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:Firearms']));
        RoleLean.Register('Role');

        classId := 'Role5:Doctor';
        RoleLean := TMetaRole.Create(classId, 'Doctor', 'Self-explanatory');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']));
        RoleLean.Register('Role');

        classId := 'Role6:Sniper';
        RoleLean := TMetaRole.Create(classId, 'Sniper', 'Bulls-eye shooter');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:Firearms']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']));
        RoleLean.Register('Role');

        classId := 'Role7:Falsifier';
        RoleLean := TMetaRole.Create(classId, 'Falsifier', 'Can reproduce everything you need');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']));
        RoleLean.Register('Role');

        classId := 'Role8:Stalker';
        RoleLean := TMetaRole.Create(classId, 'Stalker', 'Silent but deadly');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']));
        RoleLean.Register('Role');

        classId := 'Role9:Artificer';
        RoleLean := TMetaRole.Create(classId, 'Artificer', 'Able to use dynamite and set arsons');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']));
        RoleLean.Register('Role');
        *)
    // Create and Register Attributes

        classId := '11-Skill:Driving';
        AttrLean := TMetaAttribute.Create(classID, 'Driving', 'Driving Skill', 0);
        AttrLean.Register('Attribute');
        classId := '12-Skill:FireArms';
        AttrLean := TMetaAttribute.Create(classID, 'Firearms', 'FireArms Skill', 10);
        AttrLean.Register('Attribute');
        classId := '13-Skill:Computer';
        AttrLean := TMetaAttribute.Create(classID, 'Computer', 'Computer Skill', 0);
        AttrLean.Register('Attribute');
        classId := '14-Skill:Leadership';
        AttrLean := TMetaAttribute.Create(classID, 'Leadership', 'Leadership Skill', 0);
        AttrLean.Register('Attribute');
        classId := '15-Skill:Brawling';
        AttrLean := TMetaAttribute.Create(classID, 'Brawling', 'Brawling Skill', 30);
        AttrLean.Register('Attribute');
        classId := '16-Skill:Demolition';
        AttrLean := TMetaAttribute.Create(classID, 'Demolition', 'Demolition and Fire Setting Skill', 0);
        AttrLean.Register('Attribute');
        classId := '17-Skill:Stealth';
        AttrLean := TMetaAttribute.Create(classID, 'Stealth', 'Stealth and Disguise Skill', 10);
        AttrLean.Register('Attribute');
        classId := '18-Skill:Medicine';
        AttrLean := TMetaAttribute.Create(classID, 'Medicine', 'Cure and Treat Skill', 0);
        AttrLean.Register('Attribute');
        classId := '19-Skill:Forgery';
        AttrLean := TMetaAttribute.Create(classID, 'Forgery', 'Skill of Producing Fake Document and Money', 0);
        AttrLean.Register('Attribute');

        // Create and Register Factors

        classId := '21-Factor:Loyalty';
        AttrLean := TMetaAttribute.Create(classID, 'Loyalty', 'How much the criminal is loyal to his boss', 20);
        AttrLean.Register('Attribute');
        classId := '22-Factor:Stability';
        AttrLean := TMetaAttribute.Create(classID, 'Stability', 'An indication of the mental sanity of the criminal', 0);
        AttrLean.Register('Attribute');
        classId := '23-Factor:Learning';
        AttrLean := TMetaAttribute.Create(classID, 'Learning', 'An indication of how well the criminal learn', 20);
        AttrLean.Register('Attribute');

        // Create and Register Modifier

        classId := 'Modifier1:SkillsModifier';
        ModLean := TMetaModifier.Create(classID, 'SkillsModifier', 'Used to modify skills');
        ModLean.Register('Modifier');

        // Create and Register Attribute Modifiers

        classId := 'Driving-11';
        AttrModLean := TAttributeModifier.Create(classID, 'Driving Licence ', 'Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 500, 30, 15, 0, 20);
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-12';
        AttrModLean := TAttributeModifier.Create(classID, 'Driving Non-Automatic Cars ', 'Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 300, 10, 10, 15, 30);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-13';
        AttrModLean := TAttributeModifier.Create(classID, 'Streets Knowledge ', 'Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 200, 20, 10, 15, 30);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-14';
        AttrModLean := TAttributeModifier.Create(classID, 'High Speed Driving ', 'Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 1500, 40, 10, 20, 40);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-15';
        AttrModLean := TAttributeModifier.Create(classID, 'Acrobatic Driving ', 'Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 2000, 60, 10, 35, 45);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-16';
        AttrModLean := TAttributeModifier.Create(classID, 'Reverse Driving ', 'Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 500, 30, 5, 30, 35);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-12']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-17';
        AttrModLean := TAttributeModifier.Create(classID, 'Jumps and Two-Wheels ', 'Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 3000, 80, 10, 55, 60);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-12']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-15']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-18';
        AttrModLean := TAttributeModifier.Create(classID, 'Roadblock Bashing ', 'Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 800, 25, 5, 45, 40);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-19';
        AttrModLean := TAttributeModifier.Create(classID, 'Flat Tires Driving ', 'When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 1200, 20, 5, 40, 45);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-12']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-15']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-20';
        AttrModLean := TAttributeModifier.Create(classID, 'Under Fire Driving ', 'Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 2000, 50, 10, 45, 40);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-14']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-15']));
        AttrModLean.Register('AttributeModifier');
        classId := 'Driving-21';
        AttrModLean := TAttributeModifier.Create(classID, 'Matching The Right Car ', 'Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']), 800, 60, 10, 30, 35);
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-11']));
        AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Driving-13']));
        AttrModLean.Register('AttributeModifier');
        //12-Skill:FireArms
    classId := 'FireArms-11';
    AttrModLean := TAttributeModifier.Create(classID, 'Basic Firearms ', 'Get the basic Firearms licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-12';
    AttrModLean := TAttributeModifier.Create(classID, 'Firearms care ', 'Learn how to properly clean and take care of firearms', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-13';
    AttrModLean := TAttributeModifier.Create(classID, 'Handheld guns ', 'Learn and practice how to use small hand held firearms', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-14';
    AttrModLean := TAttributeModifier.Create(classID, 'Rifle training ', 'Learn and practice how to use powerful rifles', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-15';
    AttrModLean := TAttributeModifier.Create(classID, 'Automatic weapons ', 'Learn and practice how to use automatic weapons', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-16';
    AttrModLean := TAttributeModifier.Create(classID, 'Advanced weapons care ', 'Learn specialised techniques to get the most from your weapons', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-17';
    AttrModLean := TAttributeModifier.Create(classID, 'Advanced target practice ', 'Learn advanced firearms handing for any situation', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-18';
    AttrModLean := TAttributeModifier.Create(classID, 'Long distance shooting ', 'Practice long range shooting for better accuracy', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-19';
    AttrModLean := TAttributeModifier.Create(classID, 'Advanced automatic weapons ', 'Gain more knowledge and control in these powerful weapons', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-20';
    AttrModLean := TAttributeModifier.Create(classID, 'Army Training ', 'Get training from ex-army soldiers to keep calm in hairy situations', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'FireArms-21';
    AttrModLean := TAttributeModifier.Create(classID, 'Matching the right weapons ', 'Learn the details of all firearms so you know which is the right one for any missions', TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:FireArms']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'FireArms-13']));
    AttrModLean.Register('AttributeModifier');
    //13-Skill:Computer
    classId := 'Computer-11';
    AttrModLean := TAttributeModifier.Create(classID, '1Driving Licence ', '1Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-12';
    AttrModLean := TAttributeModifier.Create(classID, '1Driving Non-Automatic Cars ', '1Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-13';
    AttrModLean := TAttributeModifier.Create(classID, '1Streets Knowledge ', '1Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-14';
    AttrModLean := TAttributeModifier.Create(classID, '1High Speed Driving ', '1Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-15';
    AttrModLean := TAttributeModifier.Create(classID, '1Acrobatic Driving ', '1Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-16';
    AttrModLean := TAttributeModifier.Create(classID, '1Reverse Driving ', '1Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-17';
    AttrModLean := TAttributeModifier.Create(classID, '1Jumps and Two-Wheels ', '1Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-18';
    AttrModLean := TAttributeModifier.Create(classID, '1Roadblock Bashing ', '1Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-19';
    AttrModLean := TAttributeModifier.Create(classID, '1Flat Tires Driving ', '1When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-20';
    AttrModLean := TAttributeModifier.Create(classID, '1Under Fire Driving ', '1Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Computer-21';
    AttrModLean := TAttributeModifier.Create(classID, '1Matching The Right Car ', '1Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Computer-13']));
    AttrModLean.Register('AttributeModifier');
    //14-Skill:Leadership
    classId := 'Leadership-11';
    AttrModLean := TAttributeModifier.Create(classID, '2Driving Licence ', '2Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-12';
    AttrModLean := TAttributeModifier.Create(classID, '2Driving Non-Automatic Cars ', '2Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-13';
    AttrModLean := TAttributeModifier.Create(classID, '2Streets Knowledge ', '2Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-14';
    AttrModLean := TAttributeModifier.Create(classID, '2High Speed Driving ', '2Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-15';
    AttrModLean := TAttributeModifier.Create(classID, '2Acrobatic Driving ', '2Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-16';
    AttrModLean := TAttributeModifier.Create(classID, '2Reverse Driving ', '2Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-17';
    AttrModLean := TAttributeModifier.Create(classID, '2Jumps and Two-Wheels ', '2Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-18';
    AttrModLean := TAttributeModifier.Create(classID, '2Roadblock Bashing ', '2Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-19';
    AttrModLean := TAttributeModifier.Create(classID, '2Flat Tires Driving ', '2When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-20';
    AttrModLean := TAttributeModifier.Create(classID, '2Under Fire Driving ', '2Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Leadership-21';
    AttrModLean := TAttributeModifier.Create(classID, '2Matching The Right Car ', '2Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Leadership-13']));
    AttrModLean.Register('AttributeModifier');
    //15-Skill:Brawling
    classId := 'Brawling-11';
    AttrModLean := TAttributeModifier.Create(classID, '3Driving Licence ', '3Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-12';
    AttrModLean := TAttributeModifier.Create(classID, '3Driving Non-Automatic Cars ', '3Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-13';
    AttrModLean := TAttributeModifier.Create(classID, '3Streets Knowledge ', '3Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-14';
    AttrModLean := TAttributeModifier.Create(classID, '3High Speed Driving ', '3Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-15';
    AttrModLean := TAttributeModifier.Create(classID, '3Acrobatic Driving ', '3Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-16';
    AttrModLean := TAttributeModifier.Create(classID, '3Reverse Driving ', '3Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-17';
    AttrModLean := TAttributeModifier.Create(classID, '3Jumps and Two-Wheels ', '3Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-18';
    AttrModLean := TAttributeModifier.Create(classID, '3Roadblock Bashing ', '3Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-19';
    AttrModLean := TAttributeModifier.Create(classID, '3Flat Tires Driving ', '3When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-20';
    AttrModLean := TAttributeModifier.Create(classID, '3Under Fire Driving ', '3Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Brawling-21';
    AttrModLean := TAttributeModifier.Create(classID, '3Matching The Right Car ', '3Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Brawling-13']));
    AttrModLean.Register('AttributeModifier');
    //16-Skill:Demolition
    classId := 'Demolition-11';
    AttrModLean := TAttributeModifier.Create(classID, '4Driving Licence ', '4Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-12';
    AttrModLean := TAttributeModifier.Create(classID, '4Driving Non-Automatic Cars ', '4Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-13';
    AttrModLean := TAttributeModifier.Create(classID, '4Streets Knowledge ', '4Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-14';
    AttrModLean := TAttributeModifier.Create(classID, '4High Speed Driving ', '4Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-15';
    AttrModLean := TAttributeModifier.Create(classID, '4Acrobatic Driving ', '4Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-16';
    AttrModLean := TAttributeModifier.Create(classID, '4Reverse Driving ', '4Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-17';
    AttrModLean := TAttributeModifier.Create(classID, '4Jumps and Two-Wheels ', '4Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-18';
    AttrModLean := TAttributeModifier.Create(classID, '4Roadblock Bashing ', '4Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-19';
    AttrModLean := TAttributeModifier.Create(classID, '4Flat Tires Driving ', '4When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-20';
    AttrModLean := TAttributeModifier.Create(classID, '4Under Fire Driving ', '4Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Demolition-21';
    AttrModLean := TAttributeModifier.Create(classID, '4Matching The Right Car ', '4Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Demolition-13']));
    AttrModLean.Register('AttributeModifier');
    //17-Skill:Stealth
    classId := 'Stealth-11';
    AttrModLean := TAttributeModifier.Create(classID, '5Driving Licence ', '5Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-12';
    AttrModLean := TAttributeModifier.Create(classID, '5Driving Non-Automatic Cars ', '5Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-13';
    AttrModLean := TAttributeModifier.Create(classID, '5Streets Knowledge ', '5Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-14';
    AttrModLean := TAttributeModifier.Create(classID, '5High Speed Driving ', '5Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-15';
    AttrModLean := TAttributeModifier.Create(classID, '5Acrobatic Driving ', '5Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-16';
    AttrModLean := TAttributeModifier.Create(classID, '5Reverse Driving ', '5Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-17';
    AttrModLean := TAttributeModifier.Create(classID, '5Jumps and Two-Wheels ', '5Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-18';
    AttrModLean := TAttributeModifier.Create(classID, '5Roadblock Bashing ', '5Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-19';
    AttrModLean := TAttributeModifier.Create(classID, '5Flat Tires Driving ', '5When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-20';
    AttrModLean := TAttributeModifier.Create(classID, '5Under Fire Driving ', '5Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Stealth-21';
    AttrModLean := TAttributeModifier.Create(classID, '5Matching The Right Car ', '5Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Stealth-13']));
    AttrModLean.Register('AttributeModifier');
    //18-Skill:Medicine
    classId := 'Medicine-11';
    AttrModLean := TAttributeModifier.Create(classID, '6Driving Licence ', '6Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-12';
    AttrModLean := TAttributeModifier.Create(classID, '6Driving Non-Automatic Cars ', '6Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-13';
    AttrModLean := TAttributeModifier.Create(classID, '6Streets Knowledge ', '6Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-14';
    AttrModLean := TAttributeModifier.Create(classID, '6High Speed Driving ', '6Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-15';
    AttrModLean := TAttributeModifier.Create(classID, '6Acrobatic Driving ', '6Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-16';
    AttrModLean := TAttributeModifier.Create(classID, '6Reverse Driving ', '6Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-17';
    AttrModLean := TAttributeModifier.Create(classID, '6Jumps and Two-Wheels ', '6Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-18';
    AttrModLean := TAttributeModifier.Create(classID, '6Roadblock Bashing ', '6Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-19';
    AttrModLean := TAttributeModifier.Create(classID, '6Flat Tires Driving ', '6When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-20';
    AttrModLean := TAttributeModifier.Create(classID, '6Under Fire Driving ', '6Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Medicine-21';
    AttrModLean := TAttributeModifier.Create(classID, '6Matching The Right Car ', '6Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Medicine-13']));
    AttrModLean.Register('AttributeModifier');
    //19-Skill:Forgery
    classId := 'Forgery-11';
    AttrModLean := TAttributeModifier.Create(classID, '7Driving Licence ', '7Get the basic driving licence', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 500, 30, 15, 0, 20);
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-12';
    AttrModLean := TAttributeModifier.Create(classID, '7Driving Non-Automatic Cars ', '7Learn how to drive with Standard Gears', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 300, 10, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-13';
    AttrModLean := TAttributeModifier.Create(classID, '7Streets Knowledge ', '7Deep knowledge of the streets of the city your taking the class in', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 200, 20, 10, 15, 30);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-14';
    AttrModLean := TAttributeModifier.Create(classID, '7High Speed Driving ', '7Learn how to drive at very high speeds', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 1500, 40, 10, 20, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-15';
    AttrModLean := TAttributeModifier.Create(classID, '7Acrobatic Driving ', '7Perform Special Maneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 2000, 60, 10, 35, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-16';
    AttrModLean := TAttributeModifier.Create(classID, '7Reverse Driving ', '7Drive backwards or forward without any differnce', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 500, 30, 5, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-12']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-17';
    AttrModLean := TAttributeModifier.Create(classID, '7Jumps and Two-Wheels ', '7Learn the two most difficult mneuvers', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 3000, 80, 10, 55, 60);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-18';
    AttrModLean := TAttributeModifier.Create(classID, '7Roadblock Bashing ', '7Pass through any police roadblock', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 800, 25, 5, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-14']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-19';
    AttrModLean := TAttributeModifier.Create(classID, '7Flat Tires Driving ', '7When one or more of your tires blows-up', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 1200, 20, 5, 40, 45);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-12']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-20';
    AttrModLean := TAttributeModifier.Create(classID, '7Under Fire Driving ', '7Driving in the middle of flying bullets', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 2000, 50, 10, 45, 40);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-14']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-15']));
    AttrModLean.Register('AttributeModifier');
    classId := 'Forgery-21';
    AttrModLean := TAttributeModifier.Create(classID, '7Matching The Right Car ', '7Learn how to choose the right car for a given mission', TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']), 800, 60, 10, 30, 35);
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-11']));
    AttrModLean.AddPrevModifier(TAttributeModifier(TheClassStorage.ClassById['AttributeModifier', 'Forgery-13']));
    AttrModLean.Register('AttributeModifier');
        // Create and Register History Items

        //Criminals

        classId := 'Criminal11: Training';
        HistItemLean := TMetaHistoryItem.Create(classId, 'Training', 'Every time the criminal completes a training', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal12: Hire';
        HistItemLean := TMetaHistoryItem.Create(classId, 'Hire', 'Every time the criminal is hired', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal13: Fire';
        HistItemLean := TMetaHistoryItem.Create(classId, 'Fire', 'Every time the criminal is fired', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal14: ChangeTeam';
        HistItemLean := TMetaHistoryItem.Create(classId, 'ChangeTeam', 'Every time the criminal changes team', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal15: StartedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'StartedMission', 'Every time the criminal starts an on-going mission', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal16: AccomplishedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'AccomplishedMission', 'Every time the criminal accomplishes a mission', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal17: AssignedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'AssignedMission', 'Every time the criminal is given a mission', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal18: DeassignedMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'DeassignedMission', 'Every time the criminal is deassigned a mission', 'Criminal');
        HistItemLean.Register('HistoryItem');
        classId := 'Criminal19: GivenToAnotherLeader';
        HistItemLean := TMetaHistoryItem.Create(classId, 'GivenToAnotherLeader', 'Every time the criminal is traded to another leader', 'Criminal');
        HistItemLean.Register('HistoryItem');

        //Teams

        classId := 'Team11: TeamCreation';
        HistItemLean := TMetaHistoryItem.Create(classId, 'TeamCreation', 'When the team is born', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team12: HiredCriminal';
        HistItemLean := TMetaHistoryItem.Create(classId, 'HiredCriminal', 'Every time a criminal is hired by the team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team13: FiredCriminal';
        HistItemLean := TMetaHistoryItem.Create(classId, 'FiredCriminal', 'Every time a criminal is fired from the team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team14: CriminalChangeTeam';
        HistItemLean := TMetaHistoryItem.Create(classId, 'CriminalChangeTeam', 'Every time a criminal leave or join the team either to go in another team or coming from another team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team15: MissionStarted';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionStarted', 'Every time the team starts a mission', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team16: MissionAccomplished';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionAccomplished', 'Every time the team accomplishes a mission', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team17: MissionAssigned';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionAssigned', 'Every time a leader assigns a mission to the team', 'Team');
        HistItemLean.Register('HistoryItem');
        classId := 'Team18: MissionDeassigned';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionDeassigned', 'Every time a leader deassigns a mission to the team', 'Team');
        HistItemLean.Register('HistoryItem');

        //Leaders

        classId := 'Leader11: LeaderBorn';
        HistItemLean := TMetaHistoryItem.Create(classId, 'LeaderBorn', 'When the player alter-ego is created', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader12: TeamCreated';
        HistItemLean := TMetaHistoryItem.Create(classId, 'TeamCreated', 'Every time the leader creates a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader13: TeamDismissed';
        HistItemLean := TMetaHistoryItem.Create(classId, 'TeamDismissed', 'Every time the leader dismisses a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader14: CriminalHired';
        HistItemLean := TMetaHistoryItem.Create(classId, 'CriminalHired', 'Every time the leader hire a criminal in a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader15: CriminalFired';
        HistItemLean := TMetaHistoryItem.Create(classId, 'CriminalFired', 'Every time the leader fire a criminal from a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader16: ChangeTeamToCriminal';
        HistItemLean := TMetaHistoryItem.Create(classId, 'ChangeTeamToCriminal', 'Every time the leader moves a criminal from a team to another', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader17: AssignMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'AssignMission', 'Every time the leader assigns a mission to a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader18: DeassignMission';
        HistItemLean := TMetaHistoryItem.Create(classId, 'DeassignMission', 'Every time the leader deassigns a mission to a team', 'Leader');
        HistItemLean.Register('HistoryItem');
        classId := 'Leader19: MissionCompletedByATeam';
        HistItemLean := TMetaHistoryItem.Create(classId, 'MissionCompletedByATeam', 'Every time a mission assigned to a team has been accomplished', 'Leader');
        HistItemLean.Register('HistoryItem');

        // Create and Register Roles

        classId := 'Role0:Unassigned';
        RoleLean := TMetaRole.Create(classId, '', 'No precise role assigned');
        RoleLean.Register('Role');

        classId := 'Role1:Leader';
        RoleLean := TMetaRole.Create(classId, 'Leader', 'The leader of the team');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '14-Skill:Leadership']));
        RoleLean.Register('Role');

        classId := 'Role2:Driver';
        RoleLean := TMetaRole.Create(classId, 'Driver', 'Drives your way to or away your destination');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '11-Skill:Driving']));
        RoleLean.Register('Role');

        classId := 'Role3:Hacker';
        RoleLean := TMetaRole.Create(classId, 'Hacker', 'Computer Wizard');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']));
        RoleLean.Register('Role');

        classId := 'Role4:Gorilla';
        RoleLean := TMetaRole.Create(classId, 'Gorilla', 'He is big and knows how to beat you up');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:Firearms']));
        RoleLean.Register('Role');

        classId := 'Role5:Doctor';
        RoleLean := TMetaRole.Create(classId, 'Doctor', 'Self-explanatory');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '18-Skill:Medicine']));
        RoleLean.Register('Role');

        classId := 'Role6:Sniper';
        RoleLean := TMetaRole.Create(classId, 'Sniper', 'Bulls-eye shooter');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '12-Skill:Firearms']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']));
        RoleLean.Register('Role');

        classId := 'Role7:Falsifier';
        RoleLean := TMetaRole.Create(classId, 'Falsifier', 'Can reproduce everything you need');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '19-Skill:Forgery']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '13-Skill:Computer']));
        RoleLean.Register('Role');

        classId := 'Role8:Stalker';
        RoleLean := TMetaRole.Create(classId, 'Stalker', 'Silent but deadly');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '17-Skill:Stealth']));
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '15-Skill:Brawling']));
        RoleLean.Register('Role');

        classId := 'Role9:Artificer';
        RoleLean := TMetaRole.Create(classId, 'Artificer', 'Able to use dynamite and set arsons');
        RoleLean.AddRequirement(TMetaAttribute(TheClassStorage.ClassById['Attribute', '16-Skill:Demolition']));
        RoleLean.Register('Role');

        //Create and Register Criminal Charges

        classId := 'Charge1:InformaticCrime';
        ChargeLean := TMetaCharge.Create(classID, 'InformaticCrime', 300, 30, 100, 5000, 4380, 26280, 10000 );
        ChargeLean.Register('Charge');

        classId := 'Charge2:BankRobbery';
        ChargeLean := TMetaCharge.Create(classID, 'BankRobbery', 500, 50, 500, 100000, 26280, 131400, 100000 );
        ChargeLean.Register('Charge');

        classId := 'Charge3:BankRobberyWithSafeWreckage';
        ChargeLean := TMetaCharge.Create(classID, 'BankRobberyWithSafeWreckage', 700, 70, 600, 120000, 43800, 175200, 120000 );
        ChargeLean.Register('Charge');

        classId := 'Charge4:BankRobberyWithSafeHacking';
        ChargeLean := TMetaCharge.Create(classID, 'BankRobberyWithSafeHacking', 700, 70, 600, 120000, 43800, 175200, 120000 );
        ChargeLean.Register('Charge');

        classId := 'Charge5:Murder2';
        ChargeLean := TMetaCharge.Create(classID, 'Murder2', 1200, 120, 1000, 200000, 43800, -1, 200000 );
        ChargeLean.Register('Charge');

        classId := 'Charge6:AttemptedMurder';
        ChargeLean := TMetaCharge.Create(classID, 'AttemptedMurder', 1000, 100, 800, 150000, 26280, 87600, 100000 );
        ChargeLean.Register('Charge');

        classId := 'Charge7:Assault';
        ChargeLean := TMetaCharge.Create(classID, 'Assault', 200, 20, 80, 10000, 4380, 8760, 20000 );
        ChargeLean.Register('Charge');

        classId := 'Charge8:AggravatedAssault';
        ChargeLean := TMetaCharge.Create(classID, 'AggravatedAssault', 400, 40, 150, 20000, 8760, 17520, 30000 );
        ChargeLean.Register('Charge');

        classId := 'Charge9:VandalizationWithExplosives';
        ChargeLean := TMetaCharge.Create(classID, 'VandalizationWithExplosives', 300, 30, 120, 10000, 8760, 17520, 20000 );
        ChargeLean.Register('Charge');

        classId := 'Charge9:Vandalization';
        ChargeLean := TMetaCharge.Create(classID, 'Vandalization', 200, 25, 100, 10000, 4380, 17520, 15000 );
        ChargeLean.Register('Charge');

        //Create and Register MetaCriminal

        classId := 'Criminal1';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'High';
        CrimSkills.Values['FireArms'] := 'Middle';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'High';
        CrimSkills.Values['Brawling'] := 'Middle';
        CrimSkills.Values['Demolition'] := 'No';
        CrimSkills.Values['Stealth'] := 'Middle';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '80';
        CrimLean := TMetaCriminal.Create(classId, 'Steve McQueen', 'C:\five\source\illegal\CriminalsPicture\SteveMcQueen.bmp', 5, 35, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal2';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'Low';
        CrimSkills.Values['FireArms'] := 'No';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'Low';
        CrimSkills.Values['Demolition'] := 'No';
        CrimSkills.Values['Stealth'] := 'No';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '30';
        CrimLean := TMetaCriminal.Create(classId, 'Joe Pena', 'C:\five\source\illegal\CriminalsPicture\PETER MEDELARO.bmp', 1, 17, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal3';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'Middle';
        CrimSkills.Values['FireArms'] := 'No';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'No';
        CrimSkills.Values['Demolition'] := 'No';
        CrimSkills.Values['Stealth'] := 'High';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '20';
        CrimLean := TMetaCriminal.Create(classId, 'Jane Linux', 'C:\five\source\illegal\CriminalsPicture\ANNA ELIZABETH YOUNG.bmp', 1, 21, CrimSkills, 'Female');
        CrimLean.Register('Criminal');

        classId := 'Criminal4';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'Low';
        CrimSkills.Values['FireArms'] := 'High';
        CrimSkills.Values['Computer'] := 'Middle';
        CrimSkills.Values['Leadership'] := 'High';
        CrimSkills.Values['Brawling'] := 'No';
        CrimSkills.Values['Demolition'] := 'No';
        CrimSkills.Values['Stealth'] := 'Low';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '70';
        CrimLean := TMetaCriminal.Create(classId, 'Kaiser Sose', 'C:\five\source\illegal\CriminalsPicture\Kaiser Sose.bmp', 4, 32, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal5';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'No';
        CrimSkills.Values['FireArms'] := 'Middle';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'Middle';
        CrimSkills.Values['Demolition'] := 'No';
        CrimSkills.Values['Stealth'] := 'High';
        CrimSkills.Values['Medicine'] := 'Low';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '50';
        CrimLean := TMetaCriminal.Create(classId, 'Mata Hari', 'C:\five\source\illegal\CriminalsPicture\MATA HARI.bmp', 2, 25, CrimSkills, 'Female');
        CrimLean.Register('Criminal');

        classId := 'Criminal6';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'No';
        CrimSkills.Values['FireArms'] := 'No';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'No';
        CrimSkills.Values['Demolition'] := 'Middle';
        CrimSkills.Values['Stealth'] := 'No';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '70';
        CrimLean := TMetaCriminal.Create(classId, 'Steven Pidity', 'C:\five\source\illegal\CriminalsPicture\BRUCE MACKINNON.bmp', 1, 16, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal7';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'No';
        CrimSkills.Values['FireArms'] := 'High';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'Middle';
        CrimSkills.Values['Brawling'] := 'High';
        CrimSkills.Values['Demolition'] := 'Middle';
        CrimSkills.Values['Stealth'] := 'Low';
        CrimSkills.Values['Medicine'] := 'Low';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '40';
        CrimLean := TMetaCriminal.Create(classId, 'Billy The Kid', 'C:\five\source\illegal\CriminalsPicture\BILLY THE KID.bmp', 3, 19, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal8';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'Middle';
        CrimSkills.Values['FireArms'] := 'Low';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'No';
        CrimSkills.Values['Demolition'] := 'No';
        CrimSkills.Values['Stealth'] := 'No';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '80';
        CrimLean := TMetaCriminal.Create(classId, 'Hope Less', 'C:\five\source\illegal\CriminalsPicture\Jane Brown.bmp', 1, 35, CrimSkills, 'Female');
        CrimLean.Register('Criminal');

        classId := 'Criminal9';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'No';
        CrimSkills.Values['FireArms'] := 'High';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'Middle';
        CrimSkills.Values['Demolition'] := 'High';
        CrimSkills.Values['Stealth'] := 'No';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'Low';
        CrimSkills.Values['Stability'] := '10';
        CrimLean := TMetaCriminal.Create(classId, 'Crazy Joe', 'C:\five\source\illegal\CriminalsPicture\Red Ronnie.bmp', 1, 21, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal0';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'No';
        CrimSkills.Values['FireArms'] := 'High';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'No';
        CrimSkills.Values['Demolition'] := 'Middle';
        CrimSkills.Values['Stealth'] := 'No';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '40';
        CrimLean := TMetaCriminal.Create(classId, 'Stupid Bill', 'C:\five\source\illegal\CriminalsPicture\DOUGLAS W. MANGINO.bmp', 1, 22, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal11';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'Low';
        CrimSkills.Values['FireArms'] := 'No';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'No';
        CrimSkills.Values['Demolition'] := 'No';
        CrimSkills.Values['Stealth'] := 'Middle';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '60';
        CrimLean := TMetaCriminal.Create(classId, 'Idiot Ben', 'C:\five\source\illegal\CriminalsPicture\Bill Black.bmp', 1, 23, CrimSkills, 'Male');
        CrimLean.Register('Criminal');

        classId := 'Criminal12';
        CrimSkills := TStringList.Create;
        CrimSkills.Values['Driving'] := 'Low';
        CrimSkills.Values['FireArms'] := 'No';
        CrimSkills.Values['Computer'] := 'No';
        CrimSkills.Values['Leadership'] := 'No';
        CrimSkills.Values['Brawling'] := 'No';
        CrimSkills.Values['Demolition'] := 'Middle';
        CrimSkills.Values['Stealth'] := 'No';
        CrimSkills.Values['Medicine'] := 'No';
        CrimSkills.Values['Forgery'] := 'No';
        CrimSkills.Values['Stability'] := '40';
        CrimLean := TMetaCriminal.Create(classId, 'Homer Simpsons', 'C:\five\source\illegal\CriminalsPicture\Homer Simpsons.bmp', 1, 45, CrimSkills, 'Male');
        CrimLean.Register('Criminal');
      end;

    begin
      inherited Create;
      // >> Get this from XML later
      CreateMetaInstances;
      //logs.Log('crimehandler','metas created');
    end;

  function TMetaCrimeHandler.getName : string;
    begin
      result := tidHandlerName_Crime;
     //logs.Log('crimehandler','get name');
    end;

  function TMetaCrimeHandler.getOptions : TURLHandlerOptions;
    begin
      result := [hopCacheable];
     // logs.Log('crimehandler','get option');
    end;

  function TMetaCrimeHandler.getCanHandleURL( URL : TURL ) : THandlingAbility;
    begin
      result := 0;
     // logs.Log('crimehandler','get can handle url');
    end;

  function TMetaCrimeHandler.Instantiate : IURLHandler;
    begin
      result := TCrimeHandler.Create;
     // logs.Log('crimehandler','instantiate');
    end;


  // TCrimeHandler

  constructor TCrimeHandler.Create;
    begin
      inherited Create;
      fControl := TCrimeMainView.Create( nil );
     // logs.Log('crimehandler','create');
    end;

  destructor TCrimeHandler.Destroy;
    begin
      fControl.Free;
      inherited;
     // logs.Log('crimehandler','destroy');
    end;

  function TCrimeHandler.HandleURL( URL : TURL ) : TURLHandlingResult;
    begin
      fControl.IllSystem        := fcontrol.CreateIllSystemProxy;
      result := urlNotHandled;
     // logs.Log('crimehandler','handle url');
    end;

  function TCrimeHandler.HandleEvent( EventId : TEventId; var info ) : TEventHandlingResult;
    var
      UserListChangeInfo       : TUserListChangeInfo       absolute info;
      ChatMsgInfo              : TChatMsgInfo              absolute info;
      MsgCompositionChangeInfo : TMsgCompositionChangeInfo absolute info;
      ScrollInfo               : TEvnScrollInfo            absolute info;
    begin
      result := evnHandled;
     // logs.Log('crimehandler','handle event');
      case EventId of
        evnHandlerExposed :
          begin
          end;
        evnHandlerUnexposed :
          begin
          end;
        evnRefreshDate :
          begin
            fControl.LeaderModified;
          end;
       evnShutDown :
          begin
            fMasterURLHandler := nil;
            fClientView       := nil;
          end;
        else result := evnNotHandled;
        //logs.Log('crimehandler','event' + inttostr(eventid));
      end;
    end;

  function TCrimeHandler.getControl : TControl;
    begin
      result := fControl;
      //logs.Log('crimehandler','get control');
    end;

  procedure TCrimeHandler.setMasterURLHandler( const URLHandler : IMasterURLHandler );

    function CreateIllSystemProxy : olevariant;
      var
        IBCnx : IRDOConnectionInit;
      begin
        IBCnx        := TWinSockRDOConnection.Create('Illegal Business Component');
        IBCnx.Server := fClientView.getDAAddr;
        IBCnx.Port   := fClientView.getDAPort;
        if IBCnx.Connect( 1000 )
          then
            begin
              result := TRDOObjectProxy.Create as IDispatch;
              result.SetConnection( IBCnx );
              result.BindTo( tidRDOHook_IB );
              //logs.Log('crimehandler','sys prox ' + result);
            end
          else
            begin
            result := null;
           // logs.Log('crimehandler','sys prox is NULL');
            end;
       // logs.Log('crimehandler','createill sys prox ');
      end;

    begin
      fMasterURLHandler := URLHandler;
      fMasterURLHandler.HandleEvent( evnAnswerClientView, fClientView );
      fControl.MasterURLHandler := fMasterURLHandler;
      fcontrol.fibrecon:=true;
      fControl.ClientView       := fClientView;
      //fControl.IllSystem        := CreateIllSystemProxy;
      //fControl.IllSystem        := fcontrol.CreateIllSystemProxy;
      fControl.Refresh(true);

    end;



end.



