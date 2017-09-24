unit leatherjacket;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetaleatherjacketBlock =
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

    TleatherjacketBlock =
      class(TPolluterWorkCenterBlock)
        private
          fleathersheet      : TInputData;
          fCottonmat     : TInputData;
          //fChemicals      : TInputData;
          fleatherjacket        : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaClothingsIndustryBlock

  constructor TMetaleatherjacketBlock.Create( anId          : string;
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
      Sample    : TleatherjacketBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_leatherjacket_Supplies,
        accIdx_leatherjacket_Products,
        accIdx_leatherjacket_Salaries,
        accIdx_leatherjacket_Maintenance,
        aBlockClass);
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_leathersheet,
          inputZero,
          InputData(aFabThrdMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_leathersheet]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fleathersheet),
          Sample.Offset(Sample.fleathersheet)));
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
          sizeof(Sample.fCottonmat),
          Sample.Offset(Sample.fCottonmat)));
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
          tidGate_leatherjacket,
          FluidData(aClothesMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_leatherjacket]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fleatherjacket),
          Sample.Offset(Sample.fleatherjacket)));

      // Clothes
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_leatherjacket],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_leathersheet],
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
      BackupInterfaces.RegisterClass(TleatherjacketBlock);
    end;


end.

