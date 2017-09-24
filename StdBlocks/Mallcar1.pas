unit Mallcar1;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock, FoodStore,
    ClothesShop, HHAStore;

  type
    TMetaMallcar1Block =
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


    TMallcar1Block =
      class(TServiceBlock)
        private
          fElabFood  : TInputData;
          fFreshFood : TInputData;
          fClothes   : TInputData;
          fHHA       : TInputData;
      end;

   const
    fluffydiceAveragePrice = 10;
    tidService_fluffydice = 'fluffydice';
    airfreshenerAveragePrice = 10;
    tidService_airfreshener = 'airfreshener';
    polishAveragePrice = 27;
    tidService_polish = 'polish';
    carwashkitAveragePrice = 34;
    tidService_carwashkit = 'carwashkit';

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaSuperMarketBlock

  constructor TMetaMallcar1Block.Create(anId          : string;
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
      Sample           : TMallcar1Block;
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

      // Services       fluffydice
      FreshFoodService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_fluffydice]);
      ElabFoodService  := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_airfreshener]);
      ClothesService   := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_polish]);
      HHAService       := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_carwashkit]);

      // Inputs
      if aFreshFoodMax > 0
        then
          begin
            MetaInputs.Insert(
              TMetaInput.Create(
                tidGate_Cottonmat,
                inputZero,
                InputData(aFreshFoodMax, 100),
                inputZero,
                qIlimited,
                TPullInput,
                TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Cottonmat]),
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
              tidGate_Plastics,
              inputZero,
              InputData(aElabFoodMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Plastics]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fElabFood),
              Sample.Offset(Sample.fElabFood)));

      if aClotheMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_pineoil,
              inputZero,
              InputData(aClotheMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_pineoil]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fClothes),
              Sample.Offset(Sample.fClothes)));

      if aHHAMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_Oil,
              inputZero,
              InputData(aHHAMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Oil]),
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
                  InputByName[tidGate_Cottonmat],
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
                  InputByName[tidGate_pineoil],
                  0.5,
                  100));
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_Cottonmat],
                  0.5,
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
                  InputByName[tidGate_pineoil],
                  0.3,
                  100));
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_Oil],
                  0.3,
                  100));
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_Plastics],
                  0.4,
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
                  InputByName[tidGate_Plastics],
                  1,
                  100));
              Register(self);
            end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TMallcar1Block);
    end;

end.

