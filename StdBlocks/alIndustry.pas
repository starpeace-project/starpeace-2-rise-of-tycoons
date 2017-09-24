unit alIndustry;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetaalIndustryBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aOreMax         : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aMetalMax       : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TalIndustryBlock =
      class(TPolluterWorkCenterBlock)
        private
          fOre       : TInputData;
          fOreCoal   : TInputData;

          fMetal     : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaMetalIndustryBlock

  constructor TMetaalIndustryBlock.Create(anId            : string;
                                             aCapacities     : array of TFluidValue;
                                             aOreMax         : TFluidValue;
                                             aLegalServMax   : TFluidValue;
                                             aCompMax        : TFluidValue;
                                             aMetalMax       : TFluidValue;
                                             aMaxBudget      : TMoney;
                                             aBlockClass     : CBlock);
    var
      Sample : TalIndustryBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_alIndustry_Supplies,
        accIdx_alIndustry_Products,
        accIdx_alIndustry_Salaries,
        accIdx_alIndustry_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_alore,
          inputZero,
          InputData(aOreMax/2, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_alore]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOre),
          Sample.Offset(Sample.fOre)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cryolite,
          inputZero,
          InputData(aOreMax/2, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_cryolite]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOreCoal),
          Sample.Offset(Sample.fOreCoal)));


      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_almetal,
          FluidData(aMetalMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_almetal]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetal),
          Sample.Offset(Sample.fMetal)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_almetal],
        TOutputEvaluator) do                                                   
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_alore],
              300,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cryolite],
              300,
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
      BackupInterfaces.RegisterClass(TalIndustryBlock);
    end;

end.

