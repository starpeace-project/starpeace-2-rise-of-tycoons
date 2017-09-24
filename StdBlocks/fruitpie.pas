unit fruitpie;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetafruitpieBlock =
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

    TfruitpieBlock =
      class(TPolluterWorkCenterBlock)
        private
          fapples   : TInputData;
          foranges  : TInputData;
          fflour  : TInputData;
          ffruitpie : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaToysBlock

  constructor TMetafruitpieBlock.Create(
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
      Sample        : TfruitpieBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_fruitpie_Supplies,
        accIdx_fruitpie_Products,
        accIdx_fruitpie_Salaries,
        accIdx_fruitpie_Maintenance,
        aBlockClass);
        
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_apples,
          inputZero,
          InputData(aPlasticsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_apples]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fapples),
          Sample.Offset(Sample.fapples)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_oranges,
          inputZero,
          InputData(aElectCompMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_oranges]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.foranges),
          Sample.Offset(Sample.foranges)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_flour,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_flour]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fflour),
          Sample.Offset(Sample.fflour)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_fruitpie,
          FluidData(aAppliancesMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_fruitpie]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.ffruitpie),
          Sample.Offset(Sample.ffruitpie)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_fruitpie],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_apples],
              800,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_oranges],
              750,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_flour],
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
      BackupInterfaces.RegisterClass(TfruitpieBlock);
    end;


end.

