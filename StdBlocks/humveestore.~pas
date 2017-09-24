unit motorbikestore;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_motorbike = tidFluid_motorbike;

  const
    CarPotencialClients : array[TPeopleKind] of integer = (90, 150, 250);

  type
    TMetamotorbikestoreBlock =
      class(TMetaServiceBlock)
        public
          constructor Create(anId          : string;
                             aCapacities   : array of TFluidValue;
                             aCompMax      : TFluidValue;
                             aLegalServMax : TFluidValue;
                             aCustomerMax  : TFluidValue;
                             aPricePerc    : TPercent;
                             EvlBuyProb    : array of TBuyProbability;
                             aMaxAd        : TFluidValue;
                             aBlockClass   : CBlock);
      end;

    TmotorbikestoreBlock =
      class(TServiceBlock)
        private
          fCars : TInputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    ClassStorage, PyramidalModifier, Classes, BackupInterfaces,
    Population, StdAccounts;

  // TMetaCarShopBlock

  constructor TMetamotorbikestoreBlock.Create(anId          : string;
                                       aCapacities   : array of TFluidValue;
                                       aCompMax      : TFluidValue;
                                       aLegalServMax : TFluidValue;
                                       aCustomerMax  : TFluidValue;
                                       aPricePerc    : TPercent;
                                       EvlBuyProb    : array of TBuyProbability;
                                       aMaxAd        : TFluidValue;
                                       aBlockClass   : CBlock);
    var
      Sample : TmotorbikestoreBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_motorbikestore_Supplies,
        accIdx_motorbikestore_Salaries,
        accIdx_motorbikestore_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_motorbike,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_motorbike]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fCars),
          Sample.Offset(Sample.fCars)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Service: Cars
      with TMetaServiceEvaluator.Create(
        TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_motorbike]),
        'motorbike',
        aPricePerc,
        aCustomerMax,
        100,
        EvlBuyProb) do
        begin
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_motorbike],
              1,
              200));
          Register(self);
        end;
    end;

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TmotorbikestoreBlock);
    end;


end.

