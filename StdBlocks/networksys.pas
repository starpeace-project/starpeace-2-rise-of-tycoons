unit networksys;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    BusMachOpenTime  = 5*24; // five days to open
    BusMachCloseTime = 3*24; // three days to close

  type
    TMetanetworksysBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId          : string;
                             aCapacities   : array of TFluidValue;
                             aMetalsMax    : TFluidValue;
                             aChemicalMax  : TFluidValue;
                             aPlasticsMax  : TFluidValue;
                             aElectCompMax : TFluidValue;
                             aCompMax      : TFluidValue;
                             aLegalServMax : TFluidValue;
                             aBussMachMax  : TFluidValue;
                             aMaxBudget    : TMoney;
                             aBlockClass   : CBlock);
      end;

    TnetworksysBlock =
      class(TPolluterWorkCenterBlock)
        private
          fMetals    : TInputData;
          fChemicals : TInputData;
          fPlastics  : TInputData;
          fElectComp : TInputData;
          fItems     : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaBusinessMachinesBlock

  constructor TMetanetworksysBlock.Create(
    anId            : string;
    aCapacities     : array of TFluidValue;
    aMetalsMax      : TFluidValue;
    aChemicalMax    : TFluidValue;
    aPlasticsMax    : TFluidValue;
    aElectCompMax   : TFluidValue;
    aCompMax        : TFluidValue;
    aLegalServMax   : TFluidValue;
    aBussMachMax    : TFluidValue;
    aMaxBudget      : TMoney;
    aBlockClass     : CBlock);
    var
      Sample : TnetworksysBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_networksys_Supplies,
        accIdx_networksys_Products,
        accIdx_networksys_Salaries,
        accIdx_networksys_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_copper,
          inputZero,
          InputData(aMetalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_copper]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_memory,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_memory]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Plastics,
          inputZero,
          InputData(aPlasticsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_Plastics]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fPlastics),
          Sample.Offset(Sample.fPlastics)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cpu,
          inputZero,
          InputData(aElectCompMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_cpu]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fElectComp),
          Sample.Offset(Sample.fElectComp)));

      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_networksys,
          FluidData(aBussMachMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_networksys]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fItems),
          Sample.Offset(Sample.fItems)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_networksys],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_copper],
              700,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_memory],
              350,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Plastics],
              350,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cpu],
              800,
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
      BackupInterfaces.RegisterClass(TnetworksysBlock);
    end;


end.

