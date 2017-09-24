unit nylon;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ChemOpenTime  = 10;
    ChemCloseTime = 10;

  type
    TMetanylonBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aOreMax         : TFluidValue;
                             afertMax    : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TnylonBlock =
      class(TPolluterWorkCenterBlock)
        private
          fpolymers       : TInputData;
          fnylon          : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaChemicalBlock

  constructor TMetanylonBlock.Create(anId            : string;
                                        aCapacities     : array of TFluidValue;
                                        aLegalServMax   : TFluidValue;
                                        aCompMax        : TFluidValue;
                                        aOreMax         : TFluidValue;
                                        afertMax    : TFluidValue;
                                        aMaxBudget      : TMoney;
                                        aBlockClass     : CBlock);
    var
      Sample    : TnylonBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_nylon_Supplies,
        accIdx_nylon_Products,
        accIdx_nylon_Salaries,
        accIdx_nylon_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_polymers,
          inputZero,
          InputData(aOreMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_polymers]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fpolymers),
          Sample.Offset(Sample.fpolymers)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_nylon,
          FluidData(afertMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_nylon]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fnylon),
          Sample.Offset(Sample.fnylon)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_nylon],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_polymers],
              1000,
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
      BackupInterfaces.RegisterClass(TnylonBlock);
    end;

end.


