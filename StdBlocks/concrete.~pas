unit glass;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ConstOpenTime  = 1*24;
    ConstCloseTime = 1*24;

  type
    TMetaglassBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aOreMax         : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aConstForceMax  : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TglassBlock =
      class(TPolluterWorkCenterBlock)
        private
          fOre        : TInputData;
          fConstForce : TOutputData;
      end;

  procedure RegisterBackup;


implementation

  uses
    SysUtils, ClassStorage, MathUtils, StdAccounts;


  // TMetaConstructionIndustryBlock

  constructor TMetaglassBlock.Create(anId           : string;
                                                    aCapacities    : array of TFluidValue;
                                                    aOreMax        : TFluidValue;
                                                    aLegalServMax  : TFluidValue;
                                                    aCompMax       : TFluidValue;
                                                    aConstForceMax : TFluidValue;
                                                    aMaxBudget     : TMoney;
                                                    aBlockClass    : CBlock);
    var
      Sample     : TglassBlock;
      strParm    : string;
      ConstBoost : single;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_glass_Supplies,
        accIdx_glass_Products,
        accIdx_glass_Salaries,
        accIdx_glass_Maintenance,
        aBlockClass);
      Sample := nil;

      strParm := TheGlobalConfigHandler.GetConfigParm('ConstBoost', '');
      if strParm <> ''
        then ConstBoost := StrToFloat(strParm)
        else ConstBoost := 10; // >> Old value

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_silicon,
          inputZero,
          InputData(aOreMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidGate_silicon]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fOre),
          Sample.Offset(Sample.fOre)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_glass,
          FluidData(ConstBoost*aConstForceMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_glass]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fConstForce),
          Sample.Offset(Sample.fConstForce)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_glass],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 15;
          FullCloseTime := 17;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_silicon],
              300,
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
      BackupInterfaces.RegisterClass(TglassBlock);
    end;

end.

