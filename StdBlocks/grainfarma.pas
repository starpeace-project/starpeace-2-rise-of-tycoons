unit grainfarma;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators, Accounts,
    BackupInterfaces, PolluterWorkCenter, StdFluids;

  const
    modPollutionRatio  = 3;

  const
    tidWeather_FarmProduction = 'Farm-Weather';

  type
    TMetagrainfarmaBlock =
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

    TgrainfarmaBlock =
      class(TPolluterWorkCenterBlock)
        private
          ffert  : TInputData;
          fwheat  : TOutputData;
          fcottonmat : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    SysUtils, ClassStorage, PyramidalModifier, Classes, SimHints, StdAccounts,
    Standards, MathUtils;


  // TMetaFarmBlock

  constructor TMetagrainfarmaBlock.Create(anId            : string;
                                    aCapacities     : array of TFluidValue;
                                    aChemicalMax    : TFluidValue;
                                    aLegalServMax   : TFluidValue;
                                    aCompMax        : TFluidValue;
                                    aFreshFoodMax   : TFluidValue;
                                    anOrganicMatMax : TFluidValue;
                                    aMaxBudget      : TMoney;
                                    aBlockClass     : CBlock);
    var
      Sample : TgrainfarmaBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_grainfarma_Supplies,
        accIdx_grainfarma_Products,
        accIdx_grainfarma_Salaries,
        accIdx_grainfarma_Maintenance,
        aBlockClass);

      Sample := nil;

      WeatherEnvelope := RegisterWeatherEnvelope(tidWeather_FarmProduction);

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_fert,
          inputZero,
          InputData( aChemicalMax, 100 ),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_fert]),
          5,
          mglAditional,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.ffert),
          Sample.Offset( Sample.ffert )));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_wheat,
          FluidData( aFreshFoodMax, 100 ),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_wheat]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fwheat),
          Sample.Offset( Sample.fwheat )));
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_cottonmat,
          FluidData( anOrganicMatMax, 100 ),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cottonmat]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fcottonmat),
          Sample.Offset( Sample.fcottonmat )));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget/2,
        50,
        OutputByName[tidGate_wheat],
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
              InputByName[tidGate_fert],
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
        OutputByName[tidGate_cottonmat],
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
              InputByName[tidGate_fert],
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
      BackupInterfaces.RegisterClass( TgrainfarmaBlock );
    end;


end.


