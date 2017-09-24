unit mphone;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetamphoneBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aMetalsMax      : TFluidValue;
                             aElectCompMax   : TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aPlasticsMax    : TFluidValue;
                             aCompMax        : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aAppliancesMax  : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TmphoneBlock =
      class(TPolluterWorkCenterBlock)
        private
          fMetals     : TInputData;
          fElectComp  : TInputData;
          fChemicals  : TInputData;
          fPlastics   : TInputData;
          fAppliances : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaHouseHoldingAppliancesBlock

  constructor TMetamphoneBlock.Create(
    anId            : string;
    aCapacities     : array of TFluidValue;
    aMetalsMax      : TFluidValue;
    aElectCompMax   : TFluidValue;
    aChemicalMax    : TFluidValue;
    aPlasticsMax    : TFluidValue;
    aCompMax        : TFluidValue;
    aLegalServMax   : TFluidValue;
    aAppliancesMax  : TFluidValue;
    aMaxBudget      : TMoney;
    aBlockClass     : CBlock);
    var
      Sample        : TmphoneBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_mphone_Supplies,
        accIdx_mphone_Products,
        accIdx_mphone_Salaries,
        accIdx_mphone_Maintenance,
        aBlockClass);
        
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Plastics,
          inputZero,
          InputData(aMetalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Plastics]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_tft,
          inputZero,
          InputData(aElectCompMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_tft]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fElectComp),
          Sample.Offset(Sample.fElectComp)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cpu,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cpu]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_copper,
          inputZero,
          InputData(aPlasticsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_copper]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fPlastics),
          Sample.Offset(Sample.fPlastics)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_mphone,
          FluidData(aAppliancesMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_mphone]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fAppliances),
          Sample.Offset(Sample.fAppliances)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_mphone],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Plastics],
              800,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_tft],
              750,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cpu],
              200,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_copper],
              200,
              1));

          // Company Inputs
          if aCompMax > 0
            then RegisterCompanyInput(0, 0.05, 0.05, aCompMax);
          if aLegalServMax > 0
            then RegisterCompanyInput(intcond(aCompMax > 0, 1, 0), 0.03, 0.02, aLegalServMax);

          Register(MetaEvaluatorPool);
        end;
    end;

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TmphoneBlock);
    end;


end.


