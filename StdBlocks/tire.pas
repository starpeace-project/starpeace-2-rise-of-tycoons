unit tire;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ElectCompOpenTime  = 1*24;
    ElectCompCloseTime = 1*24;

  type
    TMetatireBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aSiliconMax     : TFluidValue;
                             aChemicalsMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aElectronicsMax : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TtireBlock =
      class(TPolluterWorkCenterBlock)
        private
          fSilicons    : TInputData;
          fChemicals   : TInputData;
          fElectComp   : TOutputData;
      end;

  procedure RegisterBackup;

implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaElectronicIndustryBlock

  constructor TMetatireBlock.Create(anId            : string;
                                                  aCapacities     : array of TFluidValue;
                                                  aSiliconMax     : TFluidValue;
                                                  aChemicalsMax   : TFluidValue;
                                                  aCompMax        : TFluidValue;
                                                  aLegalServMax   : TFluidValue;
                                                  aElectronicsMax : TFluidValue;
                                                  aMaxBudget      : TMoney;
                                                  aBlockClass     : CBlock);
    var
      Sample : TtireBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_tire_Supplies,
        accIdx_tire_Products,
        accIdx_tire_Salaries,
        accIdx_tire_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_rubber,
          inputZero,
          InputData(aSiliconMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_rubber]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fSilicons),
          Sample.Offset(Sample.fSilicons)));

      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_steel,
          inputZero,
          InputData(aChemicalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_steel]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_tires,
          FluidData(aElectronicsMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_tires]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fElectComp),
          Sample.Offset(Sample.fElectComp)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_tires],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_rubber],
              500,
              1));

          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_steel],
              400,
              1));

          // Company Inputs
          if aCompMax > 0
            then RegisterCompanyInput(0, 0.05, 0.05, aCompMax);
          if aLegalServMax > 0
            then RegisterCompanyInput(intcond(aCompMax > 0, 1, 0), 0.03, 0.02, aLegalServMax);

          Register(MetaEvaluatorPool);
        end
    end;

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TtireBlock);
    end;

end.
