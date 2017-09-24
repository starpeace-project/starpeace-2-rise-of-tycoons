unit miningchem;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ChemOpenTime  = 10;
    ChemCloseTime = 10;

  type
    TMetaminingchemBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aOreMax         : TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TminingchemBlock =
      class(TPolluterWorkCenterBlock)
        private
          frawchem       : TInputData;
          fminingchem : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaChemicalBlock

  constructor TMetaminingchemBlock.Create(anId            : string;
                                        aCapacities     : array of TFluidValue;
                                        aLegalServMax   : TFluidValue;
                                        aCompMax        : TFluidValue;
                                        aOreMax         : TFluidValue;
                                        aChemicalMax    : TFluidValue;
                                        aMaxBudget      : TMoney;
                                        aBlockClass     : CBlock);
    var
      Sample    : TminingchemBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_miningchem_Supplies,
        accIdx_miningchem_Products,
        accIdx_miningchem_Salaries,
        accIdx_miningchem_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_rawchem,
          inputZero,
          InputData(aOreMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_rawchem]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.frawchem),
          Sample.Offset(Sample.frawchem)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_miningchem,
          FluidData(aChemicalMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_miningchem]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fminingchem),
          Sample.Offset(Sample.fminingchem)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_miningchem],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_rawchem],
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
      BackupInterfaces.RegisterClass(TminingchemBlock);
    end;

end.


