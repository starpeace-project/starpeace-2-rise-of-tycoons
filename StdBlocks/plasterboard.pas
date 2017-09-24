unit plasterboard;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ConstOpenTime  = 1*24;
    ConstCloseTime = 1*24;

  type
    TMetaplasterboardBlock =
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

    TplasterboardBlock =
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

  constructor TMetaplasterboardBlock.Create(anId           : string;
                                                    aCapacities    : array of TFluidValue;
                                                    aOreMax        : TFluidValue;
                                                    aLegalServMax  : TFluidValue;
                                                    aCompMax       : TFluidValue;
                                                    aConstForceMax : TFluidValue;
                                                    aMaxBudget     : TMoney;
                                                    aBlockClass    : CBlock);
    var
      Sample     : TplasterboardBlock;
      strParm    : string;
      ConstBoost : single;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_plasterboard_Supplies,
        accIdx_plasterboard_Products,
        accIdx_plasterboard_Salaries,
        accIdx_plasterboard_Maintenance,
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


      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_plasterboard,
          FluidData(ConstBoost*aConstForceMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_plasterboard]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fConstForce),
          Sample.Offset(Sample.fConstForce)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_plasterboard],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 15;
          FullCloseTime := 17;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_gypsum],
              100,
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
      BackupInterfaces.RegisterClass(TplasterboardBlock);
    end;

end.

