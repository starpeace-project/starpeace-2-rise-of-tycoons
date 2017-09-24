unit Mallhha3;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock, FoodStore,
    ClothesShop, HHAStore;

  type
    TMetaMallhha3Block =
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


    TMallhha3Block =
      class(TServiceBlock)
        private
          fElabFood  : TInputData;
          fFreshFood : TInputData;
          fClothes   : TInputData;
          fHHA       : TInputData;
      end;

   const
    mp3playerAveragePrice = 40;
    tidService_mp3player = 'mp3player';
    printerAveragePrice = 80;
    tidService_printer = 'printer';
    tidService_mphone = tidFluid_mphone;
    tidService_pc = tidFluid_pc;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaSuperMarketBlock

  constructor TMetaMallhha3Block.Create(anId          : string;
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
      Sample           : TMallhha3Block;
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
      FreshFoodService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_mphone]);
      ElabFoodService  := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_pc]);
      ClothesService   := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_mp3player]);
      HHAService       := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_printer]);

      // Inputs
      if aFreshFoodMax > 0
        then
          begin
            MetaInputs.Insert(
              TMetaInput.Create(
                tidGate_mphone,
                inputZero,
                InputData(aFreshFoodMax, 100),
                inputZero,
                qIlimited,
                TPullInput,
                TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_mphone]),
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
              tidGate_pc,
              inputZero,
              InputData(aElabFoodMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_pc]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fElabFood),
              Sample.Offset(Sample.fElabFood)));

      if aClotheMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_Plastics,
              inputZero,
              InputData(aClotheMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Plastics]),
              5,
              mglBasic,
              [mgoptCacheable, mgoptEditable],
              sizeof(Sample.fClothes),
              Sample.Offset(Sample.fClothes)));

      if aHHAMax > 0
        then
          MetaInputs.Insert(
            TMetaInput.Create(
              tidGate_cpu,
              inputZero,
              InputData(aHHAMax, 100),
              inputZero,
              qIlimited,
              TPullInput,
              TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cpu]),
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
                  InputByName[tidGate_mphone],
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
                  InputByName[tidGate_pc],
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
                  InputByName[tidGate_Plastics],
                  0.5,
                  100));
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_cpu],
                  0.5,
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
                  0.5,
                  100));
              RegisterInput(
                TMetaServiceEvaluatorInput.Create(
                  InputByName[tidGate_cpu],
                  0.5,
                  100));
              Register(self);
            end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TMallhha3Block);
    end;

end.

