unit humveestore;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_humvee = tidFluid_humvee;

  const
    CarPotencialClients : array[TPeopleKind] of integer = (90, 150, 250);

  type
    TMetahumveestoreBlock =
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

    ThumveestoreBlock =
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

  constructor TMetahumveestoreBlock.Create(anId          : string;
                                       aCapacities   : array of TFluidValue;
                                       aCompMax      : TFluidValue;
                                       aLegalServMax : TFluidValue;
                                       aCustomerMax  : TFluidValue;
                                       aPricePerc    : TPercent;
                                       EvlBuyProb    : array of TBuyProbability;
                                       aMaxAd        : TFluidValue;
                                       aBlockClass   : CBlock);
    var
      Sample : ThumveestoreBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_humveestore_Supplies,
        accIdx_humveestore_Salaries,
        accIdx_humveestore_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_humvee,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_humvee]),
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
        TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_humvee]),
        'humvee',
        aPricePerc,
        aCustomerMax,
        100,
        EvlBuyProb) do
        begin
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_humvee],
              1,
              200));
          Register(self);
        end;
    end;

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(ThumveestoreBlock);
    end;


end.

