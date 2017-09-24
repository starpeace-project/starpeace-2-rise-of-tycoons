unit sportscar;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  type
    TMetasportscarBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aMetalsMax      : TFluidValue;
                             aFabThrdMax     : TFluidValue;
                             aElectCompMax   : TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aPlasticsMax    : TFluidValue;
                             aCompMax        : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCarMax         : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TsportscarBlock =
      class(TPolluterWorkCenterBlock)
        private
          fMetals     : TInputData;
          fFabThread  : TInputData;
          fElectComp  : TInputData;
          fChemicals  : TInputData;
          fPlastics   : TInputData;
          fCars       : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaCarIndustryBlock

  constructor TMetasportscarBlock.Create(anId            : string;
                                           aCapacities     : array of TFluidValue;
                                           aMetalsMax      : TFluidValue;
                                           aFabThrdMax     : TFluidValue;
                                           aElectCompMax   : TFluidValue;
                                           aChemicalMax    : TFluidValue;
                                           aPlasticsMax    : TFluidValue;
                                           aCompMax        : TFluidValue;
                                           aLegalServMax   : TFluidValue;
                                           aCarMax         : TFluidValue;
                                           aMaxBudget      : TMoney;
                                           aBlockClass     : CBlock);
    var
      Sample : TsportscarBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_sportscar_Supplies,
        accIdx_sportscar_Products,
        accIdx_sportscar_Salaries,
        accIdx_sportscar_Maintenance,
        aBlockClass);
      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_almetal,
          inputZero,
          InputData(aMetalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_almetal]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
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
          sizeof(Sample.fFabThread),
          Sample.Offset(Sample.fFabThread)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_glass,
          inputZero,
          InputData(aElectCompMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_glass]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fElectComp),
          Sample.Offset(Sample.fElectComp)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_tires,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_tires]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_engine,
          inputZero,
          InputData(aPlasticsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_engine]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fPlastics),
          Sample.Offset(Sample.fPlastics)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_sportscar,
          FluidData(aCarMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_sportscar]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fCars),
          Sample.Offset(Sample.fCars)));

      // Cars Evaluator
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_sportscar],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_almetal],
              1000,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_leathersheet],
              100,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_glass],
              500,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_tires],
              250,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_engine],
              250,
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
      BackupInterfaces.RegisterClass(TsportscarBlock);
    end;


end.

