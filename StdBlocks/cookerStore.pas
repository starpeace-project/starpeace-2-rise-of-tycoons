unit cookerStore;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_cooker = tidFluid_cooker;

  const
    HHAPotencialClients  : array[TPeopleKind] of integer = (90, 150, 250);

  type
    TMetacookerStoreBlock =
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

    TcookerStoreBlock =
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

  constructor TMetacookerStoreBlock.Create(anId         : string;
                                        aCapacities  : array of TFluidValue;
                                        aCustomerMax : TFluidValue;
                                        aPricePerc   : TPercent;
                                        EvlBuyProb   : array of TBuyProbability;
                                        aMaxAd       : TFluidValue;
                                        aBlockClass  : CBlock);
    var
      Sample     : TcookerStoreBlock;
      TVService : TMetaService;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_cookerStore_Supplies,
        accIdx_cookerStore_Salaries,
        accIdx_cookerStore_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;

      // Services
      TVService := TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_cooker]);

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cooker,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cooker]),
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
              InputByName[tidGate_cooker],
              1,
              100));
          Register(self);
        end;
    end;


  // Register backup

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TcookerStoreBlock);
    end;


end.

