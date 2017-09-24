unit copperIndustry;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetacopperIndustryBlock =
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

    TcopperIndustryBlock =
      class(TPolluterWorkCenterBlock)
        private
          fOre       : TInputData;
          fOreCoal   : TInputData;
          fMetal     : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts,logs;


  // TMetaMetalIndustryBlock

  constructor TMetacopperIndustryBlock.Create(anId            : string;
                                             aCapacities     : array of TFluidValue;
                                             aOreMax         : TFluidValue;
                                             aLegalServMax   : TFluidValue;
                                             aCompMax        : TFluidValue;
                                             aMetalMax       : TFluidValue;
                                             aMaxBudget      : TMoney;
                                             aBlockClass     : CBlock);
    var
      Sample : TcopperIndustryBlock;
    begin
    logs.Log('copper','1');
      inherited Create(anId,
        aCapacities,
        accIdx_copperIndustry_Supplies,
        accIdx_copperIndustry_Products,
        accIdx_copperIndustry_Salaries,
        accIdx_copperIndustry_Maintenance,
        aBlockClass);

      Sample := nil;
      logs.Log('copper','2');
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_copperore,
          inputZero,
          InputData(aOreMax/2, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_copperore]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOre),
          Sample.Offset(Sample.fOre)));
          logs.Log('copper','3');
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_pineoil,
          inputZero,
          InputData(aOreMax/2, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_pineoil]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOreCoal),
          Sample.Offset(Sample.fOreCoal)));
      logs.Log('copper','4');

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);
      logs.Log('copper','5');
      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_copper,
          FluidData(aMetalMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_copper]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetal),
          Sample.Offset(Sample.fMetal)));
      logs.Log('copper','6');
      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_copper],
        TOutputEvaluator) do                                                   
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_copperore],
              300,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_pineoil],
              300,
              1));

          logs.Log('copper','7');
          // Company Inputs
          if aCompMax > 0
            then RegisterCompanyInput(0, 0.05, 0.05, aCompMax);
          if aLegalServMax > 0
            then RegisterCompanyInput(intcond(aCompMax > 0, 1, 0), 0.03, 0.02, aLegalServMax);
          logs.Log('copper','8');
          Register(MetaEvaluatorPool);
        end;
    end;

  procedure RegisterBackup;
    begin
    logs.Log('copper','9');
      BackupInterfaces.RegisterClass(TcopperIndustryBlock);
      logs.Log('copper','10');
    end;

end.

