unit mobileStore;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_mphone = tidFluid_mphone;

  const
    HHAPotencialClients  : array[TPeopleKind] of integer = (90, 150, 250);

  type
    TMetamobileStoreBlock =
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

    TmobileStoreBlock =
      class(TServiceBlock)
        private
          fHHA : TInputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, MathUtils, StdAccounts;

  // TMetaHHAStoreBlock

  constructor TMetamobileStoreBlock.Create(anId         : string;
                                        aCapacities  : array of TFluidValue;
                                        aCustomerMax : TFluidValue;
                                        aPricePerc   : TPercent;
                                        EvlBuyProb   : array of TBuyProbability;
                                        aMaxAd       : TFluidValue;
                                        aBlockClass  : CBlock);
    var
      Sample     : TmobileStoreBlock;
      TVService : TMetaService;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_mobileStore_Supplies,
        accIdx_mobileStore_Salaries,
        accIdx_mobileStore_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;

      // Services
      TVService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_mphone]);

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_mphone,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_mphone]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fHHA),
          Sample.Offset(Sample.fHHA)));

      // Service: House Holding Appliances
      with TMetaServiceEvaluator.Create(
        TVService,
        'Tv',
        aPricePerc,
        aCustomerMax,
        100,
        EvlBuyProb) do
        begin
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_mphone],
              1,
              100));
          Register(self);
        end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TmobileStoreBlock);
    end;


end.

