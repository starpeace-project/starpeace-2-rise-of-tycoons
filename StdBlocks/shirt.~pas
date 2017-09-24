unit trouser;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetatrouserBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId          : string;
                             aCapacities   : array of TFluidValue;
                             aFabThrdMax   : TFluidValue;
                             aOrgMatMax    : TFluidValue;
                             //aChemicalMax  : TFluidValue;
                             aCompMax      : TFluidValue;
                             aLegalServMax : TFluidValue;
                             aClothesMax   : TFluidValue;
                             aMaxBudget    : TMoney;
                             aBlockClass   : CBlock);
      end;

    TtrouserBlock =
      class(TPolluterWorkCenterBlock)
        private
          fcottonsheet      : TInputData;
          fcotton     : TInputData;
          //fChemicals      : TInputData;
          ftrouser        : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaClothingsIndustryBlock

  constructor TMetatrouserBlock.Create( anId          : string;
                                                  aCapacities   : array of TFluidValue;
                                                  aFabThrdMax   : TFluidValue;
                                                  aOrgMatMax    : TFluidValue;
                                                  //aChemicalMax  : TFluidValue;
                                                  aCompMax      : TFluidValue;
                                                  aLegalServMax : TFluidValue;
                                                  aClothesMax   : TFluidValue;
                                                  aMaxBudget    : TMoney;
                                                  aBlockClass   : CBlock);
    var
      Sample    : TtrouserBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_trouser_Supplies,
        accIdx_trouser_Products,
        accIdx_trouser_Salaries,
        accIdx_trouser_Maintenance,
        aBlockClass);
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cottonsheet,
          inputZero,
          InputData(aFabThrdMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cottonsheet]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fcottonsheet),
          Sample.Offset(Sample.fcottonsheet)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cottonmat,
          inputZero,
          InputData(aOrgMatMax, 100),
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
          Sample.Offset(Sample.fChemicals)));  }

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_trouser,
          FluidData(aClothesMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_trouser]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.ftrouser),
          Sample.Offset(Sample.ftrouser)));

      // Clothes
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_trouser],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cottonsheet],
              1000,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cottonmat],
              500,
              1));
          {RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Chemicals],
              400,
              1)); }

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
      BackupInterfaces.RegisterClass(TtrouserBlock);
    end;


end.

