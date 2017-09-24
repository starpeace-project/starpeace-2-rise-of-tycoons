unit concrete;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ConstOpenTime  = 1*24;
    ConstCloseTime = 1*24;

  type
    TMetaconcreteBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aOreMax         : TFluidValue;
                             aMetalMax       : TFluidValue;
                             aChemicalMax    : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aConstForceMax  : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TconcreteBlock =
      class(TPolluterWorkCenterBlock)
        private
          fOre        : TInputData;
          fMetals     : TInputData;
          fChemicals  : TInputData;
          fConstForce : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    SysUtils, ClassStorage, MathUtils, StdAccounts;


  // TMetaConstructionIndustryBlock

  constructor TMetaconcreteBlock.Create(anId           : string;
                                                    aCapacities    : array of TFluidValue;
                                                    aOreMax        : TFluidValue;
                             aMetalMax       : TFluidValue;
                             aChemicalMax    : TFluidValue;
                                                    aLegalServMax  : TFluidValue;
                                                    aCompMax       : TFluidValue;
                                                    aConstForceMax : TFluidValue;
                                                    aMaxBudget     : TMoney;
                                                    aBlockClass    : CBlock);
    var
      Sample     : TconcreteBlock;
      strParm    : string;
      ConstBoost : single;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_concrete_Supplies,
        accIdx_concrete_Products,
        accIdx_concrete_Salaries,
        accIdx_concrete_Maintenance,
        aBlockClass);
      Sample := nil;

      strParm := TheGlobalConfigHandler.GetConfigParm('ConstBoost', '');
      if strParm <> ''
        then ConstBoost := StrToFloat(strParm)
        else ConstBoost := 10; // >> Old value

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_gypsum,
          inputZero,
          InputData(aOreMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_gypsum]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOre),
          Sample.Offset(Sample.fOre))); 
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_limestone,
          inputZero,
          InputData(aMetalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_limestone]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_gravel,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_gravel]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_concrete,
          FluidData(ConstBoost*aConstForceMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_concrete]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fConstForce),
          Sample.Offset(Sample.fConstForce)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_concrete],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 15;
          FullCloseTime := 17;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_gypsum],
              300,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_limestone],
              250,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_gravel],
              200,
              1));


          // Company Inputs
          if aCompMax > 0
            then RegisterCompanyInput(0, 0.05, 0.05, aCompMax);
          if aLegalServMax > 0
            then RegisterCompanyInput(intcond(aCompMax > 0, 1, 0), 0.03, 0.02, aLegalServMax);

          Register(MetaEvaluatorPool);
        end;
    end;

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TconcreteBlock);
    end;

end.

