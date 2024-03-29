unit cotton;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetacottonBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aOrganicMatMax  : TFluidValue;
                             //aChemicalMax    : TFluidValue;
                             aCompMax        : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aFabThreadsMax  : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TcottonBlock =
      class(TPolluterWorkCenterBlock)
        private
          fcotton : TInputData;
          //fChemicals  : TInputData;
          fcottonsheet : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;

  // TMetaTextilIndustryBlock

  constructor TMetacottonBlock.Create(anId            : string;
                                              aCapacities     : array of TFluidValue;
                                              aOrganicMatMax  : TFluidValue;
                                              //aChemicalMax    : TFluidValue;
                                              aCompMax        : TFluidValue;
                                              aLegalServMax   : TFluidValue;
                                              aFabThreadsMax  : TFluidValue;
                                              aMaxBudget      : TMoney;
                                              aBlockClass     : CBlock);
    var
      Sample    : TcottonBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_cotton_Supplies,
        accIdx_cotton_Products,
        accIdx_cotton_Salaries,
        accIdx_cotton_Maintenance,
        aBlockClass);
        
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cottonmat,
          inputZero,
          InputData(aOrganicMatMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cottonmat]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fcotton),
          Sample.Offset(Sample.fcotton)));
      {MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Chemicals,
          inputZero,                                            
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Chemicals]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals))); }

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_cottonsheet,
          FluidData(aFabThreadsMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cottonsheet]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fcottonsheet),
          Sample.Offset(Sample.fcottonsheet)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_cottonsheet],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cottonmat],
              1000,
              1));
          {RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Chemicals],
              400,
              1));}

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
      BackupInterfaces.RegisterClass(TcottonBlock);
    end;


end.

