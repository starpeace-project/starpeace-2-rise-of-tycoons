unit rubbersap;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ChemOpenTime  = 10;
    ChemCloseTime = 10;

  type
    TMetarubbersapBlock =
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

    TrubbersapBlock =
      class(TPolluterWorkCenterBlock)
        private
          frubbertree       : TInputData;
          frubbersap : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaChemicalBlock

  constructor TMetarubbersapBlock.Create(anId            : string;
                                        aCapacities     : array of TFluidValue;
                                        aLegalServMax   : TFluidValue;
                                        aCompMax        : TFluidValue;
                                        aOreMax         : TFluidValue;
                                        afertMax    : TFluidValue;
                                        aMaxBudget      : TMoney;
                                        aBlockClass     : CBlock);
    var
      Sample    : TrubbersapBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_rubbersap_Supplies,
        accIdx_rubbersap_Products,
        accIdx_rubbersap_Salaries,
        accIdx_rubbersap_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_rubbertree,
          inputZero,
          InputData(aOreMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_rubbertree]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.frubbertree),
          Sample.Offset(Sample.frubbertree)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_rubbersap,
          FluidData(afertMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_rubbersap]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.frubbersap),
          Sample.Offset(Sample.frubbersap)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_rubbersap],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_rubbertree],
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
      BackupInterfaces.RegisterClass(TrubbersapBlock);
    end;

end.


