unit leatherjacketShop;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_leatherjacket = tidFluid_leatherjacket + '_Market';

  type
    TMetaleatherjacketShopBlock =
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

    TleatherjacketShopBlock =
      class(TServiceBlock)
        private
          fleatherjacket : TInputData;
      end;

  procedure RegisterBackup;

implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaClothesShopBlock

  constructor TMetaleatherjacketShopBlock.Create(anId          : string;
                                           aCapacities   : array of TFluidValue;
                                           aCustomerMax  : TFluidValue;
                                           aPricePerc    : TPercent;
                                           EvlBuyProb    : array of TBuyProbability;
                                           aMaxAd        : TFluidValue;
                                           aBlockClass   : CBlock);
    var
      Sample         : TleatherjacketShopBlock;
      leatherjacketService : TMetaService;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_leatherjacketShop_Supplies,
        accIdx_leatherjacketShop_Salaries,
        accIdx_leatherjacketShop_Sales,
        aMaxAd,
        aBlockClass);
      Sample  := nil;
      // Clothes Service
      leatherjacketService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_leatherjacket]);
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_leatherjacket,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_leatherjacket]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fleatherjacket),
          Sample.Offset(Sample.fleatherjacket)));

      // Service: Clothes
      with TMetaServiceEvaluator.Create(
        leatherjacketService,
        'leatherjacket',
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
              InputByName[tidGate_leatherjacket],
              1,
              100));
          Register(self);
        end;
    end;


  // Backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TleatherjacketShopBlock);
    end;


end.

