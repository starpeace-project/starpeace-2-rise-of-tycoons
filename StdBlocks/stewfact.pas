unit stewfact;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetastewfactBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aPlasticsMax    : TFluidValue;
                             aElectCompMax   : TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aCompMax        : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aAppliancesMax  : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TstewfactBlock =
      class(TPolluterWorkCenterBlock)
        private
          fcarrot   : TInputData;
          fpotatoes  : TInputData;
          fbeef  : TInputData;
          fstew : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaToysBlock

  constructor TMetastewfactBlock.Create(
    anId            : string;
    aCapacities     : array of TFluidValue;
    aPlasticsMax      : TFluidValue;
    aElectCompMax   : TFluidValue;
    aChemicalMax    : TFluidValue;
    aCompMax        : TFluidValue;
    aLegalServMax   : TFluidValue;
    aAppliancesMax  : TFluidValue;
    aMaxBudget      : TMoney;
    aBlockClass     : CBlock);
    var
      Sample        : TstewfactBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_stewfact_Supplies,
        accIdx_stewfact_Products,
        accIdx_stewfact_Salaries,
        accIdx_stewfact_Maintenance,
        aBlockClass);
        
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_carrots,
          inputZero,
          InputData(aPlasticsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_carrots]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fcarrot),
          Sample.Offset(Sample.fcarrot)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_potatoes,
          inputZero,
          InputData(aElectCompMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_potatoes]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fpotatoes),
          Sample.Offset(Sample.fpotatoes)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_beef,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_beef]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fbeef),
          Sample.Offset(Sample.fbeef)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_stew,
          FluidData(aAppliancesMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_stew]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fstew),
          Sample.Offset(Sample.fstew)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_stew],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_carrots],
              800,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_potatoes],
              750,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_beef],
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
      BackupInterfaces.RegisterClass(TstewfactBlock);
    end;


end.

