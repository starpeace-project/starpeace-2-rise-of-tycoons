unit polymer;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ChemOpenTime  = 10;
    ChemCloseTime = 10;

  type
    TMetapolymerBlock =
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

    TpolymerBlock =
      class(TPolluterWorkCenterBlock)
        private
          forganicchems       : TInputData;
          fpolymers : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaChemicalBlock

  constructor TMetapolymerBlock.Create(anId            : string;
                                        aCapacities     : array of TFluidValue;
                                        aLegalServMax   : TFluidValue;
                                        aCompMax        : TFluidValue;
                                        aOreMax         : TFluidValue;
                                        afertMax    : TFluidValue;
                                        aMaxBudget      : TMoney;
                                        aBlockClass     : CBlock);
    var
      Sample    : TpolymerBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_polymer_Supplies,
        accIdx_polymer_Products,
        accIdx_polymer_Salaries,
        accIdx_polymer_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_organicchems,
          inputZero,
          InputData(aOreMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_organicchems]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.forganicchems),
          Sample.Offset(Sample.forganicchems)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_polymers,
          FluidData(afertMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_polymers]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fpolymers),
          Sample.Offset(Sample.fpolymers)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_polymers],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_organicchems],
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
      BackupInterfaces.RegisterClass(TpolymerBlock);
    end;

end.


