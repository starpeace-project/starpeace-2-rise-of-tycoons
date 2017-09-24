unit engine;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetaengineBlock =
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

    TengineBlock =
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

  constructor TMetaengineBlock.Create(anId            : string;
                                             aCapacities     : array of TFluidValue;
                                             aOreMax         : TFluidValue;
                                             aLegalServMax   : TFluidValue;
                                             aCompMax        : TFluidValue;
                                             aMetalMax       : TFluidValue;
                                             aMaxBudget      : TMoney;
                                             aBlockClass     : CBlock);
    var
      Sample : TengineBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_engine_Supplies,
        accIdx_engine_Products,
        accIdx_engine_Salaries,
        accIdx_engine_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_steel,
          inputZero,
          InputData(aOreMax/2, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_steel]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOre),
          Sample.Offset(Sample.fOre)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Plastics,
          inputZero,
          InputData(aOreMax/2, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_Plastics]),
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
          tidGate_engine,
          FluidData(aMetalMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_engine]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetal),
          Sample.Offset(Sample.fMetal)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_engine],
        TOutputEvaluator) do                                                   
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_steel],
              300,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Plastics],
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
      BackupInterfaces.RegisterClass(TengineBlock);
    end;

end.

