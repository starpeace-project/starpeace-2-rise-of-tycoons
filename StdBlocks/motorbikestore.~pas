unit Sportscarstore;

interface

  uses
    Kernel, Surfaces, WorkCenterBlock, StdFluids, ServiceBlock;

  const
    tidService_sportscar = tidFluid_sportscar;

  const
    CarPotencialClients : array[TPeopleKind] of integer = (90, 150, 250);

  type
    TMetaSportscarstoreBlock =
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

    TSportscarstoreBlock =
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

  constructor TMetaSportscarstoreBlock.Create(anId          : string;
                                       aCapacities   : array of TFluidValue;
                                       aCompMax      : TFluidValue;
                                       aLegalServMax : TFluidValue;
                                       aCustomerMax  : TFluidValue;
                                       aPricePerc    : TPercent;
                                       EvlBuyProb    : array of TBuyProbability;
                                       aMaxAd        : TFluidValue;
                                       aBlockClass   : CBlock);
    var
      Sample : TSportscarstoreBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_Sportscarstore_Supplies,
        accIdx_Sportscarstore_Salaries,
        accIdx_Sportscarstore_Sales,
        aMaxAd,
        aBlockClass);
      Sample := nil;
      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_sportscar,
          inputZero,
          InputData(aCustomerMax, 100),
          inputZero,
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_sportscar]),
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
        TMetaService(TheClassStorage.ClassById[tidClassFamily_Services, tidService_sportscar]),
        'sportscar',
        aPricePerc,
        aCustomerMax,
        100,
        EvlBuyProb) do
        begin
          RegisterInput(
            TMetaServiceEvaluatorInput.Create(
              InputByName[tidGate_sportscar],
              1,
              200));
          Register(self);
        end;
    end;

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TSportscarstoreBlock);
    end;


end.

