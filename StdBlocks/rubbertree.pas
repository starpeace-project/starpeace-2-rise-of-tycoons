unit rubbertree;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ChemOpenTime  = 10;
    ChemCloseTime = 10;

  type
    TMetarubbertreeBlock =
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

    TrubbertreeBlock =
      class(TPolluterWorkCenterBlock)
        private
          ffert       : TInputData;
          frubbertree : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaChemicalBlock

  constructor TMetarubbertreeBlock.Create(anId            : string;
                                        aCapacities     : array of TFluidValue;
                                        aLegalServMax   : TFluidValue;
                                        aCompMax        : TFluidValue;
                                        aOreMax         : TFluidValue;
                                        afertMax    : TFluidValue;
                                        aMaxBudget      : TMoney;
                                        aBlockClass     : CBlock);
    var
      Sample    : TrubbertreeBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_rubbertree_Supplies,
        accIdx_rubbertree_Products,
        accIdx_rubbertree_Salaries,
        accIdx_rubbertree_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_fert,
          inputZero,
          InputData(aOreMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_fert]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.ffert),
          Sample.Offset(Sample.ffert)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_rubbertree,
          FluidData(afertMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_rubbertree]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.frubbertree),
          Sample.Offset(Sample.frubbertree)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_rubbertree],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_fert],
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
      BackupInterfaces.RegisterClass(TrubbertreeBlock);
    end;

end.


