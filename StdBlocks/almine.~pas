unit coppermine;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    BackupInterfaces, PolluterWorkCenter, StdFluids, Accounts;

  const
    MineOpenTime  = 1*24;
    MineCloseTime = 1*24;

  type
    TMetacoppermineBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aOreMax         : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TcoppermineBlock =
      class(TPolluterWorkCenterBlock)
        private
          fminingchem : TInputData;
          fironore       : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;

  // TMetaMineBlock

  constructor TMetacoppermineBlock.Create(anId            : string;
                                    aCapacities     : array of TFluidValue;
                                    aLegalServMax   : TFluidValue;
                                    aCompMax        : TFluidValue;
                                    aChemicalMax    : TFluidValue;
                                    aOreMax         : TFluidValue;
                                    aMaxBudget      : TMoney;
                                    aBlockClass     : CBlock);
    var
      Sample    : TcoppermineBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_coppermine_Supplies,
        accIdx_coppermine_Products,
        accIdx_coppermine_Salaries,
        accIdx_coppermine_Maintenance,
        aBlockClass);

      Sample := nil;

      DesignProfPerc := 20; // override the minimun profit of 45%

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_miningchem,
          inputZero,
          InputData(aChemicalMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_miningchem]),
          5,
          mglAditional,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fminingchem),
          Sample.Offset(Sample.fminingchem)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_copperore,
          FluidData(aOreMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_copperore]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fironore),
          Sample.Offset(Sample.fironore)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        intcond(aMaxBudget > 0, 20, 0),
        OutputByName[tidGate_copperore],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          AdtnQFrac     := 0.2;
          AdtnKFrac     := 0.2;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_miningchem],
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
      BackupInterfaces.RegisterClass(TcoppermineBlock);
    end;

end.

