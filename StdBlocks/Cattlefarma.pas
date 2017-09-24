unit Cattlefarma;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators, Accounts,
    BackupInterfaces, PolluterWorkCenter, StdFluids;

  const
    modPollutionRatio  = 3;

  const
    tidWeather_FarmProductionb = 'Farm-Weatherb';

  type
    TMetaCattlefarmaBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aFreshFoodMax   : TFluidValue;
                             anOrganicMatMax : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock );
      end;

    TCattlefarmaBlock =
      class(TPolluterWorkCenterBlock)
        private
          fWheat  : TInputData;
          fbeef  : TOutputData;
          fleather : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    SysUtils, ClassStorage, PyramidalModifier, Classes, SimHints, StdAccounts,
    Standards, MathUtils;


  // TMetaFarmBlock

  constructor TMetaCattlefarmaBlock.Create(anId            : string;
                                    aCapacities     : array of TFluidValue;
                                    aChemicalMax    : TFluidValue;
                                    aLegalServMax   : TFluidValue;
                                    aCompMax        : TFluidValue;
                                    aFreshFoodMax   : TFluidValue;
                                    anOrganicMatMax : TFluidValue;
                                    aMaxBudget      : TMoney;
                                    aBlockClass     : CBlock);
    var
      Sample : TCattlefarmaBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_Cattlefarma_Supplies,
        accIdx_Cattlefarma_Products,
        accIdx_Cattlefarma_Salaries,
        accIdx_Cattlefarma_Maintenance,
        aBlockClass);

      Sample := nil;

      WeatherEnvelope := RegisterWeatherEnvelope(tidWeather_FarmProductionb);

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Wheat,
          inputZero,
          InputData( aChemicalMax, 100 ),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Wheat]),
          5,
          mglAditional,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fWheat),
          Sample.Offset( Sample.fWheat )));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_beef,
          FluidData( aFreshFoodMax, 100 ),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_beef]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fbeef),
          Sample.Offset( Sample.fbeef )));
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_leather,
          FluidData( anOrganicMatMax, 100 ),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_leather]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fleather),
          Sample.Offset( Sample.fleather )));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget/2,
        50,
        OutputByName[tidGate_beef],
        TOutputEvaluator ) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          WFPerc        := 70;
          Importance    := 60;
          AdtnQFrac     := 0.1;
          AdtnKFrac     := 0.1;
          PrdWthrEnv    := WeatherEnvelope;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Wheat],
              1000,
              0.5));

          // Company Inputs
          if aCompMax > 0
            then RegisterCompanyInput(0, 0.05, 0.05, aCompMax);
          if aLegalServMax > 0
            then RegisterCompanyInput(intcond(aCompMax > 0, 1, 0), 0.03, 0.02, aLegalServMax);

          Register( MetaEvaluatorPool );
        end;
      with TMetaOutputEvaluator.Create(
        aMaxBudget/2,
        50,
        OutputByName[tidGate_leather],
        TOutputEvaluator ) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          WFPerc        := 30;
          Importance    := 40;
          AdtnQFrac     := 0.1;
          AdtnKFrac     := 0.1;
          PrdWthrEnv    := WeatherEnvelope;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Wheat],
              300,
              0.5));

          // Company Inputs
          if aCompMax > 0
            then RegisterCompanyInput(0, 0.05, 0.05, aCompMax);
          if aLegalServMax > 0
            then RegisterCompanyInput(intcond(aCompMax > 0, 1, 0), 0.03, 0.02, aLegalServMax);

          Register( MetaEvaluatorPool );
        end;
    end;

  // RegisterBackup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass( TCattlefarmaBlock );
    end;


end.


