unit const2;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ConstOpenTime  = 1*24;
    ConstCloseTime = 1*24;

  type
    TMetaconst2Block =
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

    Tconst2Block =
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

  constructor TMetaconst2Block.Create(anId           : string;
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
      Sample     : Tconst2Block;
      strParm    : string;
      ConstBoost : single;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_const2_Supplies,
        accIdx_const2_Products,
        accIdx_const2_Salaries,
        accIdx_const2_Maintenance,
        aBlockClass);
      Sample := nil;

      strParm := TheGlobalConfigHandler.GetConfigParm('ConstBoost', '');
      if strParm <> ''
        then ConstBoost := StrToFloat(strParm)
        else ConstBoost := 10; // >> Old value

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_concrete,
          inputZero,
          InputData(aOreMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_concrete]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOre),
          Sample.Offset(Sample.fOre))); 
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_plasterboard,
          inputZero,
          InputData(aMetalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_plasterboard]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_glass,
          inputZero,
          InputData(aChemicalMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_glass]),
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
          tidGate_ConstructionForce,
          FluidData(ConstBoost*aConstForceMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_ConstructionForce]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fConstForce),
          Sample.Offset(Sample.fConstForce)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_ConstructionForce],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 15;
          FullCloseTime := 17;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_concrete],
              300,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_plasterboard],
              250,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_glass],
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
      BackupInterfaces.RegisterClass(Tconst2Block);
    end;

end.

