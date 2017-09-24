unit shirtShop;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_shirts = tidFluid_shirts + '_Market';

  type
    TMetashirtShopBlock =
      class(TMetaServiceBlock)
        public
          constructor Create(anId          : string;
                             aCapacities   : array of TFluidValue;
                             aCustomerMax  : TFluidValue;
                             aPricePerc    : TPercent;
                             EvlBuyProb    : array of TBuyProbability;
                             aMaxAd        : TFluidValue;
                             aBlockClass   : CBlock);
      end;

    TshirtShopBlock =
      class(TServiceBlock)
        private
          fshirts : TInputData;
      end;

  procedure RegisterBackup;

implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaClothesShopBlock

  constructor TMetashirtShopBlock.Create(anId          : string;
                                           aCapacities   : array of TFluidValue;
                                           aCustomerMax  : TFluidValue;
                                           aPricePerc    : TPercent;
                                           EvlBuyProb    : array of TBuyProbability;
                                           aMaxAd        : TFluidValue;
                                           aBlockClass   : CBlock);
    var
      Sample         : TshirtShopBlock;
      shirtsService : TMetaService;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_shoeShop_Supplies,
        accIdx_shoeShop_Salaries,
        accIdx_shoeShop_Sales,
        aMaxAd,
        aBlockClass);
      Sample  := nil;
      // Clothes Service
      shirtsService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_shirts]);
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_shirts,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_shirts]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fshirts),
          Sample.Offset(Sample.fshirts)));

      // Service: shoe
      with TMetaServiceEvaluator.Create(
        shirtsService,
        'shirts',
        aPricePerc,
        aCustomerMax,
        100,
        EvlBuyProb) do
        begin
          {
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[PeopleKindPrefix[pkHigh] + tidGate_WorkForce],
              1,
              10));
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[PeopleKindPrefix[pkMiddle] + tidGate_WorkForce],
              1,
              15));
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[PeopleKindPrefix[pkLow] + tidGate_WorkForce],
              1,
              12));
          }
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_shirts],
              1,
              100));
          Register(self);
        end;
    end;


  // Backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TshirtShopBlock);
    end;


end.

