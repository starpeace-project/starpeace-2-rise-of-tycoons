unit bm2;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    BusMachOpenTime  = 5*24; // five days to open
    BusMachCloseTime = 3*24; // three days to close

  type
    TMetabm2Block =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId          : string;
                             aCapacities   : array of TFluidValue;
                             aMetalsMax    : TFluidValue;
                             aChemicalMax  : TFluidValue;
                             aPlasticsMax  : TFluidValue;
                             aCompMax      : TFluidValue;
                             aLegalServMax : TFluidValue;
                             aBussMachMax  : TFluidValue;
                             aMaxBudget    : TMoney;
                             aBlockClass   : CBlock);
      end;

    Tbm2Block =
      class(TPolluterWorkCenterBlock)
        private
          fMetals    : TInputData;
          fChemicals : TInputData;
          fPlastics  : TInputData;
          fItems     : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaBusinessMachinesBlock

  constructor TMetabm2Block.Create(
    anId            : string;
    aCapacities     : array of TFluidValue;
    aMetalsMax      : TFluidValue;
    aChemicalMax    : TFluidValue;
    aPlasticsMax    : TFluidValue;
    aCompMax        : TFluidValue;
    aLegalServMax   : TFluidValue;
    aBussMachMax    : TFluidValue;
    aMaxBudget      : TMoney;
    aBlockClass     : CBlock);
    var
      Sample : Tbm2Block;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_bm2_Supplies,
        accIdx_bm2_Products,
        accIdx_bm2_Salaries,
        accIdx_bm2_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_networksys,
          inputZero,
          InputData(aMetalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_networksys]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_bcomp,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_bcomp]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_servers,
          inputZero,
          InputData(aPlasticsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_servers]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fPlastics),
          Sample.Offset(Sample.fPlastics)));


      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_BusinessMachines,
          FluidData(aBussMachMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_BusinessMachines]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fItems),
          Sample.Offset(Sample.fItems)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_BusinessMachines],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_networksys],
              700,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_bcomp],
              350,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_servers],
              350,
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
      BackupInterfaces.RegisterClass(Tbm2Block);
    end;


end.

