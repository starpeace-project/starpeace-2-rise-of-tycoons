unit TVStore;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_Tv = tidFluid_tv;

  const
    HHAPotencialClients  : array[TPeopleKind] of integer = (90, 150, 250);

  type
    TMetaTVStoreBlock =
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

    TTVStoreBlock =
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

  constructor TMetaTVStoreBlock.Create(anId         : string;
                                        aCapacities  : array of TFluidValue;
                                        aCustomerMax : TFluidValue;
                                        aPricePerc   : TPercent;
                                        EvlBuyProb   : array of TBuyProbability;
                                        aMaxAd       : TFluidValue;
                                        aBlockClass  : CBlock);
    var
      Sample     : TTVStoreBlock;
      TVService : TMetaService;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_TVStore_Supplies,
        accIdx_TVStore_Salaries,
        accIdx_TVStore_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;

      // Services
      TVService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_Tv]);

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_tv,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_tv]),
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
              InputByName[tidGate_tv],
              1,
              100));
          Register(self);
        end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TTVStoreBlock);
    end;


end.

