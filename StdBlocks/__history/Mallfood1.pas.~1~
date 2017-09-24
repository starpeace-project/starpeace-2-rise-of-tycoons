unit Mallfood1;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock, FoodStore,
    ClothesShop, HHAStore;

  type
    TMetaMallfood1Block =
      class(TMetaServiceBlock)
        public
          constructor Create(anId          : string;
                             aCapacities   : array of TFluidValue;
                             aCompMax      : TFluidValue;
                             aLegalServMax : TFluidValue;
                             aFreshFoodMax : TFluidValue;
                             aElabFoodMax  : TFluidValue;
                             aClotheMax    : TFluidValue;
                             aHHAMax       : TFluidValue;
                             aPricePerc    : TPercent;
                             EvlBuyProb    : array of TBuyProbability;
                             aMaxAd        : TFluidValue;
                             aBlockClass   : CBlock);
      end;


    TMallfood1Block =
      class(TServiceBlock)
        private
          fElabFood  : TInputData;
          fFreshFood : TInputData;
          fClothes   : TInputData;
          fHHA       : TInputData;
      end;

   const
    PlatesAveragePrice = 17;
    tidService_Plates = 'Plates';
    GlassesAveragePrice = 24;
    tidService_Glasses = 'glasses';
    tidService_stew = tidFluid_stew + '_Market';
    tidService_bakery = 'bakery';

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaSuperMarketBlock

  constructor TMetaMallfood1Block.Create(anId          : string;
                                         aCapacities   : array of TFluidValue;
                                         aCompMax      : TFluidValue;
                                         aLegalServMax : TFluidValue;
                                         aFreshFoodMax : TFluidValue;
                                         aElabFoodMax  : TFluidValue;
                                         aClotheMax    : TFluidValue;
                                         aHHAMax       : TFluidValue;
                                         aPricePerc    : TPercent;
                                         EvlBuyProb    : array of TBuyProbability;
                                         aMaxAd        : TFluidValue;
                                         aBlockClass   : CBlock);
    var
      Sample           : TMallfood1Block;
      FreshFoodService : TMetaService;
      ElabFoodService  : TMetaService;
      ClothesService   : TMetaService;
      HHAService       : TMetaService;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_SuperMarket_Supplies,
        accIdx_SuperMarket_Salaries,
        accIdx_SuperMarket_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;

      PresenceFac := 1.25;

      // Services
      FreshFoodService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_stew]);
      ElabFoodService  := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_bakery]);
      ClothesService   := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_Plates]);
      HHAService       := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_Glasses]);

      // Inputs
      if aFreshFoodMax > 0
        then
          begin
            MetaInputs.Insert(
              TMetaInput.Create(
                tidGate_stew,
                inputZero,
                InputData(aFreshFoodMax, 100),
                inputZero,
                qIlimited,
                TPullInput,
                TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_stew]),
                5,
                mglBasic,
                [mgoptCacheable, mgoptEditable],
                sizeof(Sample.fFreshFood),
                Sample.Offset(Sample.fFreshFood)));
          end;

      if aElabFoodMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_flour,
              inputZero,
              InputData(aElabFoodMax/10, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_flour]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fElabFood),
              Sample.Offset(Sample.fElabFood)));

      if aClotheMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_ceramicore,
              inputZero,
              InputData(aClotheMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_ceramicore]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fClothes),
              Sample.Offset(Sample.fClothes)));

      if aHHAMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_glass,
              inputZero,
              InputData(aHHAMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_glass]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fHHA),
              Sample.Offset(Sample.fHHA)));


      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Service: Fresh Food
      if aFreshFoodMax > 0
        then
          with TMetaServiceEvaluator.Create(
            FreshFoodService,
            'Fresh Food',
            aPricePerc,
            aFreshFoodMax,
            25,
            EvlBuyProb) do
            begin
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_stew],
                  1,
                  100));
              Register(self);
            end;

      // Service: Processed Food
      if aElabFoodMax > 0
        then
          with TMetaServiceEvaluator.Create(
            ElabFoodService,
            'Processed Food',
            aPricePerc,
            aElabFoodMax,
            25,
            EvlBuyProb) do
            begin
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_flour],
                  1,
                  100));
              Register(self);
            end;

      // Service: Clothes
      if aClotheMax > 0
        then
          with TMetaServiceEvaluator.Create(
            ClothesService,
            'Clothes',
            aPricePerc,
            aClotheMax,
            25,
            EvlBuyProb) do
            begin
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_ceramicore],
                  1,
                  100));
              Register(self);
            end;

      // Service: House Holding Appliances
      if aHHAMax > 0
        then
          with TMetaServiceEvaluator.Create(
            HHAService,
            'Household Appliances',
            aPricePerc,
            aHHAMax,
            25,
            EvlBuyProb) do
            begin
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_glass],
                  1,
                  100));
              Register(self);
            end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TMallfood1Block);
    end;

end.

