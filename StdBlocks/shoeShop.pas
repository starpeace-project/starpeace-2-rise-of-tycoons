unit shoeShop;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_shoe = tidFluid_shoes + '_Market';

  type
    TMetashoeShopBlock =
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

    TshoeShopBlock =
      class(TServiceBlock)
        private
          fshoe : TInputData;
      end;

  procedure RegisterBackup;

implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaClothesShopBlock

  constructor TMetashoeShopBlock.Create(anId          : string;
                                           aCapacities   : array of TFluidValue;
                                           aCustomerMax  : TFluidValue;
                                           aPricePerc    : TPercent;
                                           EvlBuyProb    : array of TBuyProbability;
                                           aMaxAd        : TFluidValue;
                                           aBlockClass   : CBlock);
    var
      Sample         : TshoeShopBlock;
      shoeService : TMetaService;
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
      shoeService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_shoe]);
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_shoes,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_shoes]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fshoe),
          Sample.Offset(Sample.fshoe)));

      // Service: shoe
      with TMetaServiceEvaluator.Create(
        shoeService,
        'shoe',
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
              InputByName[tidGate_shoes],
              1,
              100));
          Register(self);
        end;
    end;


  // Backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TshoeShopBlock);
    end;


end.

