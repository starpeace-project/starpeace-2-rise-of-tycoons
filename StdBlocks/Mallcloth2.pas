unit Mallcloth2;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock, FoodStore,
    ClothesShop, HHAStore;

  type
    TMetaMallcloth2Block =
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


    TMallcloth2Block =
      class(TServiceBlock)
        private
          fElabFood  : TInputData;
          fFreshFood : TInputData;
          fClothes   : TInputData;
          fHHA       : TInputData;
      end;

   const
    underwearAveragePrice = 10;
    tidService_underwear = 'underwear';
    hatsAveragePrice = 15;
    tidService_hats = 'hats';
    tidService_trouser = tidFluid_trouser + '_Market';
    tidService_Socks = 'Socks';
    SocksAveragePrice = 10;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaSuperMarketBlock

  constructor TMetaMallcloth2Block.Create(anId          : string;
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
      Sample           : TMallcloth2Block;
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
      FreshFoodService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_trouser]);
      ElabFoodService  := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_Socks]);
      ClothesService   := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_hats]);
      HHAService       := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_underwear]);

      // Inputs
      if aFreshFoodMax > 0
        then
          begin
            MetaInputs.Insert(
              TMetaInput.Create(
                tidGate_trouser,
                inputZero,
                InputData(aFreshFoodMax, 100),
                inputZero,
                qIlimited,
                TPullInput,
                TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_trouser]),
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
              tidGate_nylon,
              inputZero,
              InputData(aElabFoodMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_nylon]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fElabFood),
              Sample.Offset(Sample.fElabFood)));

      if aClotheMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_Cottonmat,
              inputZero,
              InputData(aClotheMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Cottonmat]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fClothes),
              Sample.Offset(Sample.fClothes)));

      if aHHAMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_Cottonsheet,
              inputZero,
              InputData(aHHAMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Cottonsheet]),
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
                  InputByName[tidGate_trouser],
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
                  InputByName[tidGate_nylon],
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
                  InputByName[tidGate_Cottonmat],
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
                  InputByName[tidGate_Cottonsheet],
                  1,
                  100));
              Register(self);
            end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TMallcloth2Block);
    end;

end.

