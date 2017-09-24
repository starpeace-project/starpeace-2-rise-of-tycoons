unit mill;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ElabFoodStoragePercent = 20;
    
  type
    TMetamillBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aFreshFoodMax   : TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aElabFoodMax    : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TmillBlock =
      class(TPolluterWorkCenterBlock)
        private
          fwheat  : TInputData;
          fcottonsheet  : TInputData;
          fflour   : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaFoodProcessorBlock

  constructor TMetamillBlock.Create(anId            : string;
                                             aCapacities     : array of TFluidValue;
                                             aFreshFoodMax   : TFluidValue;
                                             aChemicalMax    : TFluidValue;
                                             aLegalServMax   : TFluidValue;
                                             aCompMax        : TFluidValue;
                                             aElabFoodMax    : TFluidValue;
                                             aMaxBudget      : TMoney;
                                             aBlockClass     : CBlock);
    var
      Sample : TmillBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_mill_Supplies,
        accIdx_mill_Products,
        accIdx_mill_Salaries,
        accIdx_mill_Maintenance,
        aBlockClass);
        
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_wheat,
          inputZero,
          InputData(aFreshFoodMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_wheat]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fwheat),
          Sample.Offset(Sample.fwheat)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cottonsheet,
          inputZero,
          InputData(aChemicalMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_cottonsheet]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fcottonsheet),
          Sample.Offset(Sample.fcottonsheet)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_flour,
          FluidData(aElabFoodMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_flour]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fflour),
          Sample.Offset(Sample.fflour)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_flour],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_wheat],
              1000,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cottonsheet],
              80,
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
      BackupInterfaces.RegisterClass(TmillBlock);
    end;


end.

