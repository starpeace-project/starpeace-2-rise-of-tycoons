unit OfficeBlock;

interface

  uses
    ClassStorageInt, Kernel, Population, Surfaces, BackupInterfaces, Protocol, CacheAgent,
    WorkCenterBlock, Accounts;

  var
    modBeautyRatio:integer = 0;
    modBAPRatio   :integer = 0;
    modCrimeRatio   :integer = 0;
    modPollutionRatio :integer = 0;
    modStrengthOfBAP :integer = 0;
    MaxBAP      :integer = 0; //1000;
    MaxBeauty   :integer = 0; //2000;
    MaxCrime    :integer = 0; //50;
    MaxPollution :integer = 0; //10;

    BAPWeight     :integer = 0;
    BeautyWeight   :integer = 0;
    CrimeWeight    :integer = 0;
    PollWeight     :integer = 0;
    MaintenanceWeight :integer = 0;
    PriceWeight     :integer = 0;
    EfficiencyWeight :integer = 0;

    OfficesPrice :integer = 0;
    ExtraMaintCost:integer = 0;

    ProfitLimit     :integer = 0;     // Minimal occupancy of positive-profit office building
    MinOccupancy    :integer = 0;     // Minimal occupancy of old-looking office building
    BrandNewEffect   :integer = 0; // Minimal age of old-looking residential
    BuildingUglyness :integer = 0;    // For the beauty modifier if in ugly state
    LowBAP         :integer = 0;   // For the BAP modifier if in ugly state
    RepairPriceShare :integer = 0;
    OfsRecovTime   :integer = 0;
    OfsEmigrationProb :integer = 0;
    TotalWeight :integer = 0;


  type
    TOfficeVisualState  = (ofstNormal, ofstReparing, ofstHalfEmpty);
    TOfficeVisualStates = set of TOfficeVisualState;

  type
    TMetaOfficeBlock =
      class( TMetaWorkCenter )
        public
          constructor Create( anId        : string;
                              aCapacity   : TFluidValue;
                              aBlockClass : CBlock );
        private
          fCapacity        : TFluidValue;
          fEfficiency      : single;
          fCrimeResist     : single;
          fPollResist      : single;
          fBAP             : single;
          fAvailableStates : TOfficeVisualStates;
        public
          property Capacity        : TFluidValue         read fCapacity;
          property Efficiency      : single              read fEfficiency      write fEfficiency;
          property CrimeResist     : single              read fCrimeResist     write fCrimeResist;
          property PollResist      : single              read fPollResist      write fPollResist;
          property BAP             : single              read fBAP             write fBAP;
          property AvailableStates : TOfficeVisualStates read fAvailableStates write fAvailableStates;
        protected
          function ModifyStageStack( Stage : TMetaBlock ) : boolean; override;
        published
           function GetConfigParm(name, def : widestring) : olevariant;
        public
          procedure Register( ClassFamily : TClassFamilyId );
      end;

    TOfficeBlock =
      class( TWorkCenter )
        protected
          constructor Create( aMetaBlock : TMetaBlock; aFacility : TFacility ); override;
        public
          destructor  Destroy; override;
        private
          fEmigration  : TPushInputData;
          fInmigration : TPushInputData;
          fRecycleIn   : TPushInputData;
          fDemand      : TOutputData;
          fOfficesRep  : TOutputData;
          fRecycleOut  : TOutputData;
        protected
          function GetSurfaceValue( SurfaceId : TSurfaceId ) : TSurfaceValue; override;
        protected
          function Evaluate : TEvaluationResult; override;
        public
          procedure AutoConnect( loaded : boolean ); override;
        public
          procedure Stop; override;
        protected
          function GetVisualClassId  : TVisualClassId; override;
        protected
          fOffices     : TFluidData;
          fRent        : TPercent;
          fMaintenance : TPercent;
          fRepair      : TPercent;
          fRepairDate  : TVirtDateAbs;
        private
          function  GetRent : TPercent;
          procedure SetRent( aRent : TPercent );
          function  GetMaintenance : TPercent;
          procedure SetMaintenance( aMaintenance : TPercent );
          function  GetOccupancy : TPercent;
        published
          property Rent        : TPercent read GetRent        write SetRent;
          property Maintenance : TPercent read GetMaintenance write SetMaintenance;
          property Occupancy   : TPercent read GetOccupancy;
        published
          procedure RdoRepair(useless : integer);
          procedure RdoStopRepair(useless : integer);
        public
          property Offices : TFluidData read fOffices;
        private
          function GetMarketPrice : TMoney;
        published
          function GetStatusText( kind : TStatusKind; ToTycoon : TTycoon ) : string; override;
          function GetConfigParm(name, def : widestring) : olevariant;
        private
          fBeautyModifier      : TSurfaceModifier;
          fBAPModifier         : TSurfaceModifier;
          fBeautyIntegrator    : TSurfaceIntegrator;
          fPollutionIntegrator : TSurfaceIntegrator;
          fCrimeIntegrator     : TSurfaceIntegrator;
          fBAPIntegrator       : TSurfaceIntegrator;
          fPrivateWorkers      : array[TPeopleKind] of TTownParameter;
          fAdm                 : TAdmitance;
      private
          finvCrimeRes : single;
          finvPollRes  : single;
          finvBeauty   : single;
          finvPrivacy  : single;
          finvMaint    : single;
        private
          function GetBAPPercent   ( value : TSurfaceValue ) : TPercent;
          function GetBeautyPercent( value : TSurfaceValue ) : TPercent;
          function GetCrimePercent ( value : TSurfaceValue ) : TPercent;
          function GetPollPercent  ( value : TSurfaceValue ) : TPercent;
        public
          procedure StoreToCache  ( Cache  : TObjectCache  ); override;
          procedure LoadFromBackup( Reader : IBackupReader ); override;
          procedure StoreToBackup ( Writer : IBackupWriter ); override;
        private
          function LooksUgly : boolean;
        protected
          procedure CopySettingsFrom(Block : TBlock; Options : integer); override;
          function  RenderCloneMenu(lang : string) : string; override;
          procedure Deleted; override;
        protected
          procedure RecalculateInventionsEffect; override;
      end;



  procedure RegisterBackup;

implementation

  uses
    SysUtils, ClassStorage, MathUtils, PyramidalModifier, Classes, SimHints, Languages,
    BasicAccounts, StdFluids, MetaInstances, Construction, PopulatedBlock, Logs,
    ModelServerCache, CloneOptions;

  const
    MoveInDays = 20*TimeUnits;


  // TMetaOfficeBlock

  constructor TMetaOfficeBlock.Create( anId        : string;
                                       aCapacity   : TFluidValue;
                                       aBlockClass : CBlock );
    var
      Sample  : TOfficeBlock;
      Offices : TMetaFluid;
      Total   : single;
    begin
    if modBeautyRatio= 0 then modBeautyRatio:=strtoint(GetConfigParm('offmodBeautyRatio', '10'));
    if modBAPRatio= 0 then modBAPRatio:=strtoint(GetConfigParm('offmodBAPRatio', '12'));
    if modCrimeRatio= 0 then modCrimeRatio:=strtoint(GetConfigParm('modCrimeRatiooff', '3'));
    if modPollutionRatio= 0 then modPollutionRatio:=strtoint(GetConfigParm('offmodPollutionRatio', '4'));
    if modStrengthOfBAP= 0 then modStrengthOfBAP:=strtoint(GetConfigParm('offmodStrengthOfBAP', '40'));
    if MaxBAP= 0 then MaxBAP:=strtoint(GetConfigParm('offMaxBAP', '500'));       //1000;
    if MaxBeauty= 0 then MaxBeauty:=strtoint(GetConfigParm('offMaxBeauty', '100'));     //2000;
    if MaxCrime= 0 then MaxCrime:=strtoint(GetConfigParm('offMaxCrime', '10'));     //50;
    if MaxPollution= 0 then MaxPollution:=strtoint(GetConfigParm('offMaxPollution', '10')); //10;
    if BAPWeight= 0 then BAPWeight:=strtoint(GetConfigParm('offBAPWeight', '150'));
    if BeautyWeight= 0 then BeautyWeight:=strtoint(GetConfigParm('offBeautyWeight', '30'));
    if CrimeWeight= 0 then CrimeWeight:=strtoint(GetConfigParm('offCrimeWeight', '80'));
    if PollWeight= 0 then PollWeight:=strtoint(GetConfigParm('offPollWeight', '70'));
    if MaintenanceWeight= 0 then MaintenanceWeight:=strtoint(GetConfigParm('offMaintenanceWeight', '150'));
    if PriceWeight= 0 then PriceWeight:=strtoint(GetConfigParm('offPriceWeight', '150'));
    if EfficiencyWeight= 0 then EfficiencyWeight:=strtoint(GetConfigParm('offEfficiencyWeight', '100'));
    if OfficesPrice= 0 then OfficesPrice:=strtoint(GetConfigParm('offOfficesPrice', '10'));
    if ExtraMaintCost= 0 then ExtraMaintCost:=strtoint(GetConfigParm('offExtraMaintCost', '2'));
    if ProfitLimit= 0 then ProfitLimit:=strtoint(GetConfigParm('offProfitLimit', '20'));          // Minimal occupancy of positive-profit office building
    if MinOccupancy= 0 then MinOccupancy:=strtoint(GetConfigParm('offMinOccupancy', '15'));      // Minimal occupancy of old-looking office building
    if BrandNewEffect= 0 then BrandNewEffect:=strtoint(GetConfigParm('offBrandNewEffect', '8760')); // Minimal age of old-looking residential
    if BuildingUglyness= 0 then BuildingUglyness:=strtoint(GetConfigParm('offBuildingUglyness', '-40'));    // For the beauty modifier if in ugly state
    if LowBAP= 0 then LowBAP:=strtoint(GetConfigParm('offLowBAP', '-10'));             // For the BAP modifier if in ugly state
    if RepairPriceShare= 0 then RepairPriceShare:=strtoint(GetConfigParm('offRepairPriceShare', '25'));
    if OfsRecovTime= 0 then OfsRecovTime:=strtoint(GetConfigParm('offOfsRecovTime', '8760'));
    if OfsEmigrationProb= 0 then OfsEmigrationProb:=strtoint(GetConfigParm('offOfsEmigrationProb', '30'));
    if TotalWeight= 0 then  TotalWeight := BAPWeight + BeautyWeight + CrimeWeight + PollWeight +  MaintenanceWeight + PriceWeight +  EfficiencyWeight;
      Total := WorkersPerOffice*aCapacity;
      inherited Create( anId, [0.1*Total, 0.2*Total, 0.7*Total], accIdx_None, accIdx_Offices, accIdx_None, aBlockClass );
      fCapacity   := aCapacity;
      fEfficiency := 1;
      Offices     := TMetaFluid(TheClassStorage.ClassById['Fluids', tidFluid_Offices]);
      Sample      := nil;
      fBAP        := 30*aCapacity;
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_OfsInmigration,
          inputZero,
          InputData( aCapacity/MoveInDays, kIlimited ),
          inputZero,
          fCapacity,
          TPushInput,
          Offices,
          1,
          mglBasic,
          [],
          sizeof(Sample.fInmigration),
          Sample.Offset( Sample.fInmigration )));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_OfsEmigration,
          inputZero,
          InputData( aCapacity, kIlimited ),
          inputZero,
          fCapacity,
          TPushInput,
          Offices,
          1,
          mglBasic,
          [],
          sizeof(Sample.fEmigration),
          Sample.Offset( Sample.fEmigration )));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_OfsRecycleIn,
          inputZero,
          InputData( aCapacity, kIlimited ),
          inputZero,
          fCapacity,
          TPushInput,
          Offices,
          1,
          mglBasic,
          [],
          sizeof(Sample.fRecycleIn),
          Sample.Offset( Sample.fRecycleIn )));
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_OfsDemand,
          FluidData( aCapacity, kIlimited ),
          TPushOutput,
          Offices,
          1,
          [],
          sizeof(Sample.fDemand),
          Sample.Offset( Sample.fDemand )));
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_Offices,
          FluidData( aCapacity, kIlimited ),
          TPushOutput,
          Offices,
          1,
          [],
          sizeof(Sample.fOfficesRep),
          Sample.Offset( Sample.fOfficesRep )));
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_OfsRecycleOut,
          FluidData( aCapacity, kIlimited ),
          TPushOutput,
          Offices,
          1,
          [],
          sizeof(Sample.fRecycleOut),
          Sample.Offset( Sample.fRecycleOut )));
      fAvailableStates := [ofstNormal];
      MaxUpgrade := StrToInt(TheGlobalConfigHandler.GetConfigParm('MaxOfficeUpgrade', '10'));
      MinColDist := StrToInt(TheGlobalConfigHandler.GetConfigParm('MinOfficeSep', '4'));
    end;

  function TMetaOfficeBlock.ModifyStageStack( Stage : TMetaBlock ) : boolean;
    var
      OptRent    : single;
      Profit     : TMoney;
      ConstPrice : TMoney;
      Cost       : TMoney;
    begin
      if ObjectIs( TMetaBlockUnderConstruction.ClassName, Stage )
        then
          begin
            OptRent    := realmax(0, 1 + Efficiency/3);
            Profit     := (100 - ProfitLimit)*OptRent*Capacity*OfficesPrice/100;
            Cost       := realmax(0, OfsRecovTime*Profit);
            ConstPrice := TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_ConstructionForce]).MarketPrice;
            TMetaBlockUnderConstruction(Stage).ConstVolumeRequired := Cost/ConstPrice;
            result := true;
          end
        else result := false;
    end;

  procedure TMetaOfficeBlock.Register( ClassFamily : TClassFamilyId );
    var
      i    : integer;
      lang : TLanguageId;
    begin
      for i := 0 to pred(LangList.Count) do
        begin
          lang := LangList[i];
          if Desc_MLS.Values[lang] <> ''
            then Desc_MLS.Values[lang] := Desc_MLS.Values[lang] + ' ';
          Desc_MLS.Values[lang] := Desc + SimHints.GetHintText( mtidDescOffice.Values[lang], [round(Capacity), round(100*Efficiency)] );
        end;
      inherited Register( ClassFamily );
    end;


  // TOfficeBlock

  constructor TOfficeBlock.Create( aMetaBlock : TMetaBlock; aFacility : TFacility );
    begin
      inherited;
      if modBeautyRatio= 0 then modBeautyRatio:=strtoint(GetConfigParm('offmodBeautyRatio', '10'));
    if modBAPRatio= 0 then modBAPRatio:=strtoint(GetConfigParm('offmodBAPRatio', '12'));
    if modCrimeRatio= 0 then modCrimeRatio:=strtoint(GetConfigParm('modCrimeRatiooff', '3'));
    if modPollutionRatio= 0 then modPollutionRatio:=strtoint(GetConfigParm('offmodPollutionRatio', '4'));
    if modStrengthOfBAP= 0 then modStrengthOfBAP:=strtoint(GetConfigParm('offmodStrengthOfBAP', '40'));
    if MaxBAP= 0 then MaxBAP:=strtoint(GetConfigParm('offMaxBAP', '500'));       //1000;
    if MaxBeauty= 0 then MaxBeauty:=strtoint(GetConfigParm('offMaxBeauty', '100'));     //2000;
    if MaxCrime= 0 then MaxCrime:=strtoint(GetConfigParm('offMaxCrime', '10'));     //50;
    if MaxPollution= 0 then MaxPollution:=strtoint(GetConfigParm('offMaxPollution', '10')); //10;
    if BAPWeight= 0 then BAPWeight:=strtoint(GetConfigParm('offBAPWeight', '150'));
    if BeautyWeight= 0 then BeautyWeight:=strtoint(GetConfigParm('offBeautyWeight', '30'));
    if CrimeWeight= 0 then CrimeWeight:=strtoint(GetConfigParm('offCrimeWeight', '80'));
    if PollWeight= 0 then PollWeight:=strtoint(GetConfigParm('offPollWeight', '70'));
    if MaintenanceWeight= 0 then MaintenanceWeight:=strtoint(GetConfigParm('offMaintenanceWeight', '150'));
    if PriceWeight= 0 then PriceWeight:=strtoint(GetConfigParm('offPriceWeight', '150'));
    if EfficiencyWeight= 0 then EfficiencyWeight:=strtoint(GetConfigParm('offEfficiencyWeight', '100'));
    if OfficesPrice= 0 then OfficesPrice:=strtoint(GetConfigParm('offOfficesPrice', '10'));
    if ExtraMaintCost= 0 then ExtraMaintCost:=strtoint(GetConfigParm('offExtraMaintCost', '2'));
    if ProfitLimit= 0 then ProfitLimit:=strtoint(GetConfigParm('offProfitLimit', '20'));          // Minimal occupancy of positive-profit office building
    if MinOccupancy= 0 then MinOccupancy:=strtoint(GetConfigParm('offMinOccupancy', '15'));      // Minimal occupancy of old-looking office building
    if BrandNewEffect= 0 then BrandNewEffect:=strtoint(GetConfigParm('offBrandNewEffect', '8760')); // Minimal age of old-looking residential
    if BuildingUglyness= 0 then BuildingUglyness:=strtoint(GetConfigParm('offBuildingUglyness', '-40'));    // For the beauty modifier if in ugly state
    if LowBAP= 0 then LowBAP:=strtoint(GetConfigParm('offLowBAP', '-10'));             // For the BAP modifier if in ugly state
    if RepairPriceShare= 0 then RepairPriceShare:=strtoint(GetConfigParm('offRepairPriceShare', '25'));
    if OfsRecovTime= 0 then OfsRecovTime:=strtoint(GetConfigParm('offOfsRecovTime', '8760'));
    if OfsEmigrationProb= 0 then OfsEmigrationProb:=strtoint(GetConfigParm('offOfsEmigrationProb', '30'));
    if TotalWeight= 0 then  TotalWeight := BAPWeight + BeautyWeight + CrimeWeight + PollWeight +  MaintenanceWeight + PriceWeight +  EfficiencyWeight;
      fRent        := 100;
      fMaintenance := 100;
    end;

  destructor TOfficeBlock.Destroy;
    begin
      {
      fBeautyModifier.Delete;
      fBAPModifier.Delete;
      fBeautyIntegrator.Delete;
      fPollutionIntegrator.Delete;
      fCrimeIntegrator.Delete;
      fBAPIntegrator.Delete;
      }
      inherited;
    end;

  function TOfficeBlock.GetSurfaceValue( SurfaceId : TSurfaceId ) : TSurfaceValue;
    begin
      if SurfaceId = tidEnvironment_Beauty
        then result := fBeautyIntegrator.Media
        else
          if SurfaceId = tidEnvironment_Pollution
            then result := fPollutionIntegrator.Media
            else
              if SurfaceId = tidEnvironment_Crime
                then result := fCrimeIntegrator.Media
                else
                  if SurfaceId = tidEnvironment_BAP
                    then result := fBAPIntegrator.Media
                    else result := inherited GetSurfaceValue( SurfaceId );
    end;

  function TOfficeBlock.Evaluate : TEvaluationResult;

    function GetBostCurveValue( maxFacCount : integer ) : single;
      var
        Tycoon : TTycoon;
      begin
        Tycoon := Facility.Company.Owner;
        result := realmax(0, (1 - Tycoon.FacCount/maxFacCount)*(1 - Tycoon.NobPoints/500));
      end;

    var
      OfficesIn   : TFluidData;
      OfficesOut  : TFluidData;
      realAdmit   : single;
      Admitance   : TAdmitance;
      Price       : TMoney;
      MarketPrice : TMoney;
      dRepair     : integer;
      MaxCap      : TFluidValue;
      i           : TPeopleKind;
      UpgrLevel   : byte;
      RentMoney   : TMoney;
      MaintMoney  : TMoney;
      MaintRatio  : single;
      OccupRatio  : single;
    begin
     {if var X = 0 then GetConfigParm('X', 'V');
    }
    if modBeautyRatio= 0 then modBeautyRatio:=strtoint(GetConfigParm('offmodBeautyRatio', '10'));
    if modBAPRatio= 0 then modBAPRatio:=strtoint(GetConfigParm('offmodBAPRatio', '12'));
    if modCrimeRatio= 0 then modCrimeRatio:=strtoint(GetConfigParm('modCrimeRatiooff', '3'));
    if modPollutionRatio= 0 then modPollutionRatio:=strtoint(GetConfigParm('offmodPollutionRatio', '4'));
    if modStrengthOfBAP= 0 then modStrengthOfBAP:=strtoint(GetConfigParm('offmodStrengthOfBAP', '40'));
    if MaxBAP= 0 then MaxBAP:=strtoint(GetConfigParm('offMaxBAP', '500'));       //1000;
    if MaxBeauty= 0 then MaxBeauty:=strtoint(GetConfigParm('offMaxBeauty', '100'));     //2000;
    if MaxCrime= 0 then MaxCrime:=strtoint(GetConfigParm('offMaxCrime', '10'));     //50;
    if MaxPollution= 0 then MaxPollution:=strtoint(GetConfigParm('offMaxPollution', '10')); //10;
    if BAPWeight= 0 then BAPWeight:=strtoint(GetConfigParm('offBAPWeight', '150'));
    if BeautyWeight= 0 then BeautyWeight:=strtoint(GetConfigParm('offBeautyWeight', '30'));
    if CrimeWeight= 0 then CrimeWeight:=strtoint(GetConfigParm('offCrimeWeight', '80'));
    if PollWeight= 0 then PollWeight:=strtoint(GetConfigParm('offPollWeight', '70'));
    if MaintenanceWeight= 0 then MaintenanceWeight:=strtoint(GetConfigParm('offMaintenanceWeight', '150'));
    if PriceWeight= 0 then PriceWeight:=strtoint(GetConfigParm('offPriceWeight', '150'));
    if EfficiencyWeight= 0 then EfficiencyWeight:=strtoint(GetConfigParm('offEfficiencyWeight', '100'));
    if OfficesPrice= 0 then OfficesPrice:=strtoint(GetConfigParm('offOfficesPrice', '10'));
    if ExtraMaintCost= 0 then ExtraMaintCost:=strtoint(GetConfigParm('offExtraMaintCost', '2'));
    if ProfitLimit= 0 then ProfitLimit:=strtoint(GetConfigParm('offProfitLimit', '20'));          // Minimal occupancy of positive-profit office building
    if MinOccupancy= 0 then MinOccupancy:=strtoint(GetConfigParm('offMinOccupancy', '15'));      // Minimal occupancy of old-looking office building
    if BrandNewEffect= 0 then BrandNewEffect:=strtoint(GetConfigParm('offBrandNewEffect', '8760')); // Minimal age of old-looking residential
    if BuildingUglyness= 0 then BuildingUglyness:=strtoint(GetConfigParm('offBuildingUglyness', '-40'));    // For the beauty modifier if in ugly state
    if LowBAP= 0 then LowBAP:=strtoint(GetConfigParm('offLowBAP', '-10'));             // For the BAP modifier if in ugly state
    if RepairPriceShare= 0 then RepairPriceShare:=strtoint(GetConfigParm('offRepairPriceShare', '25'));
    if OfsRecovTime= 0 then OfsRecovTime:=strtoint(GetConfigParm('offOfsRecovTime', '8760'));
    if OfsEmigrationProb= 0 then OfsEmigrationProb:=strtoint(GetConfigParm('offOfsEmigrationProb', '30'));
    if TotalWeight= 0 then  TotalWeight := BAPWeight + BeautyWeight + CrimeWeight + PollWeight +  MaintenanceWeight + PriceWeight +  EfficiencyWeight;
    //end those
      result := inherited Evaluate;
      UpgrLevel := max(1, UpgradeLevel);
      MaintRatio := fMaintenance/100;
      if Facility.Trouble and facStoppedByTycoon = 0
        then
          with TMetaOfficeBlock(MetaBlock) do
            begin
              //IntegrateInventions( invCrimeRes, invPollRes, invBeauty, invPrivacy, invMaint );
              // Computing office building quality
              realAdmit :=
                EfficiencyWeight*Efficiency/TotalWeight +
                realmin( 2, BeautyWeight*fBeautyIntegrator.Media/(TotalWeight*MaxBeauty) + finvBeauty) +
                BAPWeight*fBAPIntegrator.Media/(TotalWeight*MaxBAP) -
                realmin( 2, CrimeWeight*(1 - CrimeResist - finvCrimeRes)*realmax(0, fCrimeIntegrator.Media)/(TotalWeight*MaxCrime)) -
                realmin( 2, PollWeight*(1 - PollResist - finvPollRes)*realmax(0, fPollutionIntegrator.Media)/(TotalWeight*MaxPollution)) +
                MaintenanceWeight*fMaintenance/(100*TotalWeight) +
                PriceWeight*(1 - Rent)/(100*TotalWeight);
              Admitance := round(realmin(1, MaintRatio)*(realmax( 0, 10 + 50*realAdmit ) + NewbiewHelp*GetBostCurveValue(500) + 2*UpgrLevel));
              fAdm := Admitance;

              // Acepting inmigration
              OfficesIn.Q := fInmigration.Q + fRecycleIn.Q;
              OfficesIn.K := AverageK( @fInmigration, @fRecycleIn );

              // Population Recycle
              fRecycleOut.Q := realmin( fOffices.Q, sqr(100.0 - fDemand.K)*OfsEmigrationProb*fOffices.Q*dt/(2*100*OfsEmigrationTimeSlope*10000));
              fRecycleOut.K := fOffices.K;
              fRecycleIn.S  := sqr(Admitance) + 1;

              // Emigration
              OfficesOut.Q := fEmigration.Q + fRecycleOut.Q;
              OfficesOut.K := AverageK( @fEmigration, @fRecycleOut );

              // Generate office signals
              if OfficesOut.Q > OfficesIn.Q
                then
                  begin
                    OfficesOut.Q   := OfficesOut.Q - OfficesIn.Q;
                    fOffices.Q     := realmax(0, fOffices.Q - OfficesOut.Q);
                    fRecycleOut.Q  := OfficesOut.Q - fEmigration.Q;
                    fOffices.K     := AverageK( @fOffices, @OfficesOut );
                  end
                else
                  begin
                    OfficesIn.Q := OfficesIn.Q - OfficesOut.Q;
                    fOffices.K := AverageK( @fOffices, @OfficesIn );
                    fRecycleOut.Q := 0;
                    fOffices.Q := fOffices.Q + OfficesIn.Q;
                  end;
              fOffices.Q := realmax(0, realmin( fOffices.Q, UpgrLevel*TMetaOfficeBlock(MetaBlock).Capacity ));

              // Sending demand
              fDemand.Q := Outputs[0].MetaOutput.MaxFluid.Q - fOffices.Q;
              fDemand.K := min( 100, Admitance );

              // Feeding back population
              fOfficesRep.Q := fOffices.Q;
              fOfficesRep.K := fOffices.K;

              // Adjusting Emigration and Inmigration
              fInmigration.S := sqr(Admitance) + 1;
              if Admitance > 0
                then fEmigration.S := 10000 div Admitance
                else fEmigration.S := 0;

              MaxCap := UpgrLevel*TMetaOfficeBlock(MetaBlock).Capacity - fOffices.Q;
              with InputsByName[tidGate_OfsInmigration] do
                begin
                  ActualMaxFluid.Q := MaxCap;
                  MaxCapacity      := MaxCap;
                end;
              with InputsByName[tidGate_OfsEmigration] do
                begin
                  ActualMaxFluid.Q := fOffices.Q;
                  MaxCapacity      := fOffices.Q;
                end;
              with InputsByName[tidGate_OfsRecycleIn] do
                begin
                  ActualMaxFluid.Q := MaxCap;
                  MaxCapacity      := MaxCap;
                end;

              // Generating money
              MarketPrice := GetMarketPrice;
              Price := fRent*MarketPrice/100;
              { >> old way...
              BlockGenMoney( fOffices.Q*Price*dt, accIdx_Offices_Rents );
              BlockGenMoney( -ProfitLimit*realmax(0, fMaintenance/100 - finvMaint)*UpgrLevel*TMetaOfficeBlock(MetaBlock).Capacity*MarketPrice*dt/100, accIdx_Offices_Maintenance );
              }
              RentMoney := fOffices.Q*Price*dt;
              //MaintMoney := -ProfitLimit*realmax(0, MaintRatio - finvMaint)*UpgrLevel*TMetaOfficeBlock(MetaBlock).Capacity*(MarketPrice + ExtraMaintCost)*dt/100;
              MaintMoney := -(0.7)*ProfitLimit*realmax(0, MaintRatio - finvMaint)*UpgrLevel*TMetaOfficeBlock(MetaBlock).Capacity*(MarketPrice + ExtraMaintCost)*dt/100;
              BlockGenMoney( RentMoney, accIdx_Offices_Rents );
              BlockGenMoney( MaintMoney, accIdx_Offices_Maintenance );

              // Modifying environment
              if not LooksUgly
                then
                  begin
                    OccupRatio := fOffices.Q/(UpgrLevel*TMetaOfficeBlock(MetaBlock).Capacity);
                    fBeautyModifier.Value := MaintRatio*MetaBlock.Beauty;
                    fBAPModifier.Value    := realmin(1, 2*MaintRatio - 1)*OccupRatio*7*TMetaOfficeBlock(MetaBlock).BAP;
                  end
                else
                  begin
                    fBeautyModifier.Value := BuildingUglyness;
                    fBAPModifier.Value    := LowBAP;
                  end;
            end;
      // Repairing-wearing
      if fRepair > 0
        then
          if fRepair < 100
            then
              begin
                dRepair := fRepair;
                if fRepair + dt < 100
                  then inc( fRepair, round(dt) )
                  else fRepair := 100;
                dRepair := fRepair - dRepair;
                BlockGenMoney( -dRepair/RepairPriceShare*Facility.MetaFacility.Price, accIdx_Offices_Repairs );
              end
            else
              begin
                fRepairDate := Facility.Town.Timer.GetVirtualTimeAbs;
                fRepair     := 0;
              end;
      if not Facility.CriticalTrouble
        then HireWorkForce( fOffices.Q/(UpgrLevel*TMetaOfficeBlock(MetaBlock).Capacity) )
        else HireWorkForce( 0 );
      // Setting private workers
      for i := low(i) to high(i) do
        fPrivateWorkers[i].CurrValue := fPrivateWorkers[i].CurrValue + fWorkDemand[i].Q;
      // remove mayor/minister/pres offices
     { if facility.Company.Owner.IsRole then destroy;  }
    end;

  procedure TOfficeBlock.AutoConnect( loaded : boolean );
    var
      TownHall : TBlock;
      i        : TPeopleKind;
    begin
      inherited;

      // TownHall connections
      TownHall := TInhabitedTown(Facility.Town).TownHall.CurrBlock;
      InputsByName[tidGate_OfsInmigration].ConnectTo( TownHall.OutputsByName[tidGate_OfsInmigration] );
      InputsByName[tidGate_OfsEmigration].ConnectTo( TownHall.OutputsByName[tidGate_OfsEmigration] );
      InputsByName[tidGate_OfsRecycleIn].ConnectTo( TownHall.OutputsByName[tidGate_OfsRecycleIn] );
      OutputsByName[tidGate_Offices].ConnectTo( TownHall.InputsByName[tidGate_Offices] );
      OutputsByName[tidGate_OfsDemand].ConnectTo( TownHall.InputsByName[tidGate_OfsDemand] );
      OutputsByName[tidGate_OfsRecycleOut].ConnectTo( TownHall.InputsByName[tidGate_OfsRecycleOut] );
      fRepairDate := Facility.Town.Timer.GetVirtualTimeAbs;

      // Environmental stuff
      fBeautyModifier :=
        TPyramidalModifier.Create(
          tidEnvironment_Beauty,
          Point(xOrigin, yOrigin),
          MetaBlock.Beauty,
          MetaBlock.BeautyStrength );
      fBAPModifier :=
        TPyramidalModifier.Create(
          tidEnvironment_BAP,
          Point(xOrigin, yOrigin),
          TMetaOfficeBlock(MetaBlock).BAP,
          modStrengthOfBAP );

      fBeautyIntegrator    := TSurfaceIntegrator.Create( tidEnvironment_Beauty, GetArea( modBeautyRatio, amdIncludeBlock ));
      fPollutionIntegrator := TSurfaceIntegrator.Create( tidEnvironment_Pollution, GetArea( modPollutionRatio, amdIncludeBlock ));
      fCrimeIntegrator     := TSurfaceIntegrator.Create( tidEnvironment_Crime, GetArea( modCrimeRatio, amdExcludeBlock ));
      fBAPIntegrator       := TSurfaceIntegrator.Create( tidEnvironment_BAP, GetArea( modBAPRatio, amdExcludeBlock ));

      // Set town parameters
      for i := low(i) to high(i) do
        fPrivateWorkers[i] := Facility.Town.Parameters[tidTownParameter_PrivateWorkers + PeopleKindPrefix[i]];
    end;

  procedure TOfficeBlock.Stop;
    begin
      inherited;
      fOffices.Q    := 0;
      fOfficesRep.Q := 0;
      fDemand.Q     := 0;
      fRecycleOut.Q := 0;
      fBAPModifier.Value := 0;
    end;

  function TOfficeBlock.GetVisualClassId : TVisualClassId;
    var
      MPB : TMetaOfficeBlock;
    begin
      MPB := TMetaOfficeBlock(MetaBlock);
      case MPB.VisualStages of
        2 :
          if LooksUgly
            then result := 1
            else result := 0;
        else result := 0;
      end;
    end;

  function TOfficeBlock.GetRent : TPercent;
    begin
      Facility.Lock;
      try
        result := fRent;
      finally
        Facility.Unlock;
      end;
    end;

  procedure TOfficeBlock.SetRent( aRent : TPercent );
    begin
      Facility.Lock;
      try
        fRent := aRent;
        ModelServerCache.BackgroundInvalidateCache(Facility); //Facility.UpdateCache(true);
      finally
        Facility.Unlock;
      end;
    end;

  function TOfficeBlock.GetMaintenance : TPercent;
    begin
      Facility.Lock;
      try
        result := fMaintenance
      finally
        Facility.Unlock;
      end;
    end;

  procedure TOfficeBlock.SetMaintenance( aMaintenance : TPercent );
    begin
      Facility.Lock;
      try
        fMaintenance := aMaintenance;
        ModelServerCache.BackgroundInvalidateCache(Facility); //Facility.UpdateCache(true)
      finally
        Facility.Unlock;
      end;
    end;

  function TOfficeBlock.GetOccupancy : TPercent;
    begin
      result := round(100*fOffices.Q/(max(1, UpgradeLevel)*TMetaOfficeBlock(MetaBlock).Capacity));
    end;

  procedure TOfficeBlock.RdoRepair(useless : integer);
    begin
      if Facility.CheckOpAuthenticity
        then fRepair := 1;
    end;

  procedure TOfficeBlock.RdoStopRepair(useless : integer);
    begin
      if Facility.CheckOpAuthenticity
        then fRepair := 0;
    end;

  function TOfficeBlock.GetMarketPrice : TMoney;
    begin
      result := OfficesPrice;
    end;

  function TOfficeBlock.GetStatusText( kind : TStatusKind; ToTycoon : TTycoon ) : string;
    begin
      result := inherited GetStatusText( kind, ToTycoon );
      case kind of
        sttMain :
          begin
            if Facility.Trouble and facStoppedByTycoon = 0
              then
                result :=
                  result +
                  SimHints.GetHintText( mtidOfficeTitle.Values[ToTycoon.Language], [0] ) + LineBreak +
                  SimHints.GetHintText( mtidOfficeOccup.Values[ToTycoon.Language], [Occupancy] )
                  {
                     result +
                     'Office Building' + LineBreak +
                     IntToStr(Occupancy) +
                     '% occupancy'
                  }
              else result := SimHints.GetHintText( mtidResClosedByLine.Values[ToTycoon.Language], [0] );
            if fRepair > 0
              then
                result :=
                  result + LineBreak +
                  SimHints.GetHintText( mtidResRepaired.Values[ToTycoon.Language], [fRepair] );
                  //IntToStr(fRepair) + '% repaired';
          end;
        sttSecondary :
          begin
            result :=
              Format(mtidUpgradeLevel.Values[ToTycoon.Language], [UpgradeLevel]) + ' ' +
              SimHints.GetHintText(
                mtidOfficeReport.Values[ToTycoon.Language],
                [
                round(fOffices.Q),
                fAdm,
                max(0, round(realmin(100, 100*fBAPIntegrator.Media/MaxBAP))),
                max(0, round(realmin(100, 100*fBeautyIntegrator.Media/MaxBeauty))),
                max(0, round(realmin(100, 100*fCrimeIntegrator.Media/MaxCrime))),
                max(0, round(realmin(100, 100*fPollutionIntegrator.Media/MaxPollution)))
                ] );
              {
              IntToStr(round(fOffices.Q)) + ' offices.  ' +
              IntToStr(fAdm) + ' quality index. ' +
              'BAP: ' + IntToStr(max(0, round(realmin(100, 100*fBAPIntegrator.Media/MaxBAP)))) + '% ' +
              'Beauty: ' + IntToStr(max(0, round(realmin(100, 100*fBeautyIntegrator.Media/MaxBeauty)))) + '% ' +
              'Crime: ' + IntToStr(max(0, round(realmin(100, 100*fCrimeIntegrator.Media/MaxCrime)))) + '% ' +
              'Pollution: ' + IntToStr(max(0, round(realmin(100, 100*fPollutionIntegrator.Media/MaxPollution)))) + '%. ';
              }
          end;
        sttHint :
          case Facility.AccessLevelOf( ToTycoon ) of
            acsFull, acsModerate :
              {
              if Facility.Trouble = facNoTrouble
                then
                  begin
                    FillRatio := 100*People.Q/TMetaOfficeBlock(MetaBlock).Capacity;
                    if FillRatio >= (100 + ProfitLimit) div 2
                      then
                        if FillRatio >= 93
                          then result := GetHintText( hidResWorkingFine, [0] )
                          else result := GetHintText( hidResMildUnderPopulated, [0] )
                      else
                        if FillRatio >= ProfitLimit
                          then result := GetHintText( hidResUnderPopulated, [0] )
                          else result := GetHintText( hidResVeryUnderPopulated, [0] )
                  end
                else result := GetHintText( hidVisitWebSite, [0] );
            }
          end;
      end;
    end;

  function TOfficeBlock.GetBAPPercent( value : TSurfaceValue ) : TPercent;
    begin
      result := max(0, round(realmin(100, 100*fBAPIntegrator.Media/MaxBAP)));
    end;

  function TOfficeBlock.GetBeautyPercent( value : TSurfaceValue ) : TPercent;
    begin
      result := max(0, round(realmin(100, 100*value/MaxBeauty)));
    end;

  function TOfficeBlock.GetCrimePercent( value : TSurfaceValue ) : TPercent;
    begin
      result := max(0, round(realmin(100, 100*value/MaxCrime)));
    end;

  function TOfficeBlock.GetPollPercent( value : TSurfaceValue ) : TPercent;
    begin
      result := max(0, round(realmin(100, 100*value/MaxPollution)));
    end;

  procedure TOfficeBlock.StoreToCache( Cache : TObjectCache );
    begin
      inherited;
      Cache.WriteInteger( 'Offices', round(fOffices.Q) );
      Cache.WriteInteger( 'Rent', fRent );
      Cache.WriteInteger( 'Maintenance', fMaintenance );
      Cache.WriteInteger( 'Repair', fRepair );
      Cache.WriteInteger( 'BAP', GetBAPPercent( fBAPIntegrator.Media ));
      Cache.WriteInteger( 'Beauty', GetBeautyPercent( fBeautyIntegrator.Media ));
      Cache.WriteInteger( 'Crime', GetCrimePercent( fCrimeIntegrator.Media ));
      Cache.WriteInteger( 'Pollution', GetPollPercent( fPollutionIntegrator.Media ));
      Cache.WriteString( 'RepairPrice', FormatMoney( (RepairPriceShare/100)*Facility.MetaFacility.Price ));
      with TMetaOfficeBlock(MetaBlock) do
        begin
          Cache.WriteInteger( 'ActualCrime', GetCrimePercent( CrimeResist*fCrimeIntegrator.Media ));
          Cache.WriteInteger( 'ActualPollution', GetPollPercent( PollResist*fPollutionIntegrator.Media ));
          Cache.WriteInteger( 'Efficiency', round( 100*Efficiency ));
        end;
      Cache.WriteInteger( 'InvBeauty', round(100*finvBeauty) );
      Cache.WriteInteger( 'invCrimeRes', round(100*finvCrimeRes) );
      Cache.WriteInteger( 'invPollutionRes', round(100*finvPollRes) );
      Cache.WriteInteger( 'invPrivacy', round(100*finvPrivacy) );
    end;

  procedure TOfficeBlock.LoadFromBackup( Reader : IBackupReader );
    begin
      inherited;
      LoadFluidData( 'Offices', fOffices, Reader );
      fRent := Reader.ReadByte( 'Rent', 100 );
      fMaintenance := Reader.ReadByte( 'Maintenance', 100 );
      fRepair := Reader.ReadByte( 'Repair', 100 );
      fRepairDate := Reader.ReadInteger( 'RepairDate', 0 ); // >>
      vVisualClassId := GetVisualClassId;
    end;

  procedure TOfficeBlock.StoreToBackup( Writer : IBackupWriter );
    begin
      inherited;
      StoreFluidData( 'Offices', fOffices, Writer );
      Writer.WriteByte( 'Rent', fRent );
      Writer.WriteByte( 'Maintenance', fMaintenance );
      Writer.WriteByte( 'Repair', fRepair );
      Writer.WriteInteger( 'RepairDate', fRepairDate );
    end;

  function TOfficeBlock.LooksUgly : boolean;
    begin
      result := (Occupancy < MinOccupancy) and (Facility.Town.Timer.GetVirtualTimeAbs - fRepairDate > BrandNewEffect);
    end;

  procedure TOfficeBlock.CopySettingsFrom(Block : TBlock; Options : integer);
    begin
      if ObjectIs(ClassName, Block)
        then
          try
            if Block.Facility.MetaFacility.FacId = Facility.MetaFacility.FacId
              then
                begin
                  if Options and cloneOption_Rent <> 0
                    then fRent := TOfficeBlock(Block).Rent;
                  if Options and cloneOption_Maint <> 0
                    then fMaintenance := TOfficeBlock(Block).Maintenance;
                end;
          except
            Logs.Log( tidLog_Survival, DateTimeToStr(Now) + ' Error in TOfficeBlock.CopySettingsFrom.');
          end;
    end;

  function TOfficeBlock.RenderCloneMenu(lang : string) : string;
    var
      aux : string;
    begin
      aux := mtidOfficeClone.Values[lang];
      if aux <> ''
        then result := Format(aux, [cloneOption_Rent, cloneOption_Maint]) // FIX MLS 'Rent|%d|Maintenance|%d|'
        else result :=  '';
    end;

  procedure TOfficeBlock.Deleted;
    begin
      fBeautyModifier.Delete;
      fBAPModifier.Delete;
      fBeautyIntegrator.Delete;
      fPollutionIntegrator.Delete;
      fCrimeIntegrator.Delete;
      fBAPIntegrator.Delete;
      inherited;
    end;

  procedure TOfficeBlock.RecalculateInventionsEffect;
    var
      Invention : TResidentialInvention;
      i,a,b,c,d,e,f,g,h,j,k         : integer;
    begin
      finvCrimeRes := 0;
      finvPollRes  := 0;
      finvBeauty   := 0;
      finvPrivacy  := 0;
      finvMaint    := 0;
      for i := 0 to pred(MetaBlock.Inventions.Count) do
        begin
          Invention := TResidentialInvention(MetaBlock.Inventions[i]);
          if Facility.Company.HasInvention[Invention.NumId]
            then
              begin         //     if (>-60) and (<60) then  else 2;
                if invention.CrimeRes3 = 1 then
                  begin
                     if invention.CrimeRes>0 then a:= invention.CrimeRes - (invention.CrimeRes*2) else a:=invention.CrimeRes;
                     if invention.CrimeRes2>0 then b:= invention.CrimeRes2 - (invention.CrimeRes2*2) else b:=invention.CrimeRes2;
                  end
                  else
                  begin
                    a:=invention.CrimeRes;
                    b:=invention.CrimeRes2;
                  end;
                if (Invention.CrimeRes2>-60) and (Invention.CrimeRes2<60) then finvCrimeRes := finvCrimeRes + b else finvCrimeRes := finvCrimeRes + a;
                if invention.PollRes3 = 1 then
                  begin
                     if invention.PollRes>0 then c:= invention.PollRes - (invention.PollRes*2) else c:=invention.PollRes;
                     if invention.PollRes2>0 then d:= invention.PollRes2 - (invention.PollRes2*2) else d:=invention.PollRes2;
                  end
                  else
                  begin
                    c:=invention.PollRes;
                    d:=invention.PollRes2;
                  end;
                if (Invention.PollRes2>-60) and (Invention.PollRes2<60) then finvPollRes  := finvPollRes  + d else finvPollRes  := finvPollRes  + c;
                if invention.Beauty3 = 1 then
                  begin
                     if invention.Beauty>0 then e:= invention.Beauty - (invention.Beauty*2) else e:=invention.Beauty;
                     if invention.Beauty2>0 then f:= invention.Beauty2 - (invention.Beauty2*2) else f:=invention.Beauty2;
                  end
                  else
                  begin
                   e:=invention.Beauty;
                   f:=invention.Beauty2;
                  end;
                if (Invention.Beauty2>-60) and (Invention.Beauty2<60) then finvBeauty   := finvBeauty   + f else finvBeauty   := finvBeauty   + e;
                if invention.Privacy3 = 1 then
                  begin
                     if invention.Privacy>0 then g:= invention.Privacy - (invention.Privacy*2) else g:=invention.Privacy;
                     if invention.Privacy2>0 then h:= invention.Privacy2 - (invention.Privacy2*2) else h:=invention.Privacy2;
                  end
                  else
                  begin
                    g:=invention.Privacy;
                    h:=invention.Privacy2;
                  end;
                if (Invention.Privacy2>-60) and (Invention.Privacy2<60) then finvPrivacy  := finvPrivacy  + h else finvPrivacy  := finvPrivacy  + g;
                if invention.Maintenance3 = 1 then
                  begin
                     if invention.Maintenance>0 then j:= invention.Maintenance - (invention.Maintenance*2) else j:=invention.Maintenance;
                     if invention.Maintenance2>0 then k:= invention.Maintenance2 - (invention.Maintenance2*2) else k:=invention.Maintenance2;
                  end
                  else
                  begin
                     j:=invention.Maintenance;
                     k:=invention.Maintenance2;
                  end;
                if (Invention.Maintenance2>-60) and (Invention.Maintenance2<60) then finvMaint    := finvMaint    + k else finvMaint    := finvMaint    + j;
              end;
        end;
      if finvCrimeRes>50 then finvCrimeRes:=50;
      if finvCrimeRes<-50 then finvCrimeRes:=-50;
      finvCrimeRes := finvCrimeRes/100;
      if finvPollRes>50 then finvPollRes:=50;
      if finvPollRes<-50 then finvPollRes:=-50;
      finvPollRes  := finvPollRes/100;
      if finvBeauty>50 then finvBeauty:=50;
      if finvBeauty<-50 then finvBeauty:=-50;
      finvBeauty   := finvBeauty/100;
      if finvPrivacy>50 then finvPrivacy:=50;
      if finvPrivacy<-50 then finvPrivacy:=-50;
      finvPrivacy  := finvPrivacy/100;
      if finvMaint>50 then finvMaint:=50;
      if finvMaint<-50 then finvMaint:=-50;
      finvMaint    := finvMaint/100;
    end;

  function TMetaOfficeBlock.GetConfigParm(name, def : widestring) : olevariant;
    begin
      result := TheGlobalConfigHandler.GetConfigParm(name, def);
    end;
  function TOfficeBlock.GetConfigParm(name, def : widestring) : olevariant;
    begin
      result := TheGlobalConfigHandler.GetConfigParm(name, def);
    end;
  // RegisterBackup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass( TOfficeBlock );
    end;



end.



