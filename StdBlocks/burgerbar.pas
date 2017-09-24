unit burgerbar;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_burgerbar = 'burgerbar';

  const
    burgerbarAveragePrice = 20;

  const
    RestaurantPotencialClients : array[TPeopleKind] of integer = (500, 1000, 3000);

  type
    TMetaburgerbarBlock =
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

    TburgerbarBlock =
      class(TServiceBlock)
        private
          fburgers : TInputData;
          fFlour  : TInputData;
          fpotatoes     : TInputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, StdAccounts;

  // TMetaRestaurantBlock

  constructor TMetaburgerbarBlock.Create(anId         : string;
                                          aCapacities  : array of TFluidValue;
                                          aCustomerMax : TFluidValue;
                                          aPricePerc   : TPercent;
                                          EvlBuyProb   : array of TBuyProbability;
                                          aMaxAd       : TFluidValue;
                                          aBlockClass  : CBlock);
    var
      Sample        : TburgerbarBlock;
      Service       : TMetaService;
      aFreshFoodMax : TFluidValue;
      aElabFoodMax  : TFluidValue;
      aBoozeMax     : TFluidValue;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_burgerbar_Supplies,
        accIdx_burgerbar_Salaries,
        accIdx_burgerbar_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;
      // Services
      Service := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_burgerbar]);
      // Food Input Limits
      aFreshFoodMax := 1 * aCustomerMax;   //0.5
      aElabFoodMax  := 0.3 * aCustomerMax;
      aBoozeMax     := 0.2 * aCustomerMax;
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_burgers,
          inputZero,
          InputData(aFreshFoodMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_burgers]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fburgers),
          Sample.Offset(Sample.fburgers)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Flour,
          inputZero,
          InputData(aElabFoodMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Flour]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fFlour),
          Sample.Offset(Sample.fFlour)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_potatoes,
          inputZero,
          InputData(aBoozeMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_potatoes]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fpotatoes),
          Sample.Offset(Sample.fpotatoes)));

      // Service: Restaurant
      with TMetaServiceEvaluator.Create(
        Service,
        'burgerbar Service',
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
              17));
          }
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_burgers],
              1,
              150));
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_Flour],
              1,
              75));
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_potatoes],
              1,
              50));
          Register(self);
        end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TburgerbarBlock);
    end;


end.

