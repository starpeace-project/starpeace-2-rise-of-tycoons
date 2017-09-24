unit shirt;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetashirtBlock =
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

    TshirtBlock =
      class(TPolluterWorkCenterBlock)
        private
          fnylon      : TInputData;
          fcotton     : TInputData;
          //fChemicals      : TInputData;
          fshirts        : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaClothingsIndustryBlock

  constructor TMetashirtBlock.Create( anId          : string;
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
      Sample    : TshirtBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_shirt_Supplies,
        accIdx_shirt_Products,
        accIdx_shirt_Salaries,
        accIdx_shirt_Maintenance,
        aBlockClass);
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_nylon,
          inputZero,
          InputData(aFabThrdMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_nylon]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fnylon),
          Sample.Offset(Sample.fnylon)));
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
          tidGate_shirts,
          FluidData(aClothesMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_shirts]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fshirts),
          Sample.Offset(Sample.fshirts)));

      // Clothes
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_shirts],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_nylon],
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
      BackupInterfaces.RegisterClass(TshirtBlock);
    end;


end.

