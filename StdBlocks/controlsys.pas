unit controlsys;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    MachOpenTime  = 1*24;
    MachCloseTime = 1*24;

  type
    TMetacontrolsysBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aMetalsMax      : TFluidValue;
                             aChemicalsMax   : TFluidValue;
                             aElectCompMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aMachineryMax   : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TcontrolsysBlock =
      class(TPolluterWorkCenterBlock)
        private
          fMetals      : TInputData;
          fChemicals   : TInputData;
          fElectComp   : TInputData;
          fMachinery   : TOutputData;
      end;

  procedure RegisterBackup;

implementation

  uses
    ClassStorage, MathUtils, StdAccounts;

  // TMetaHeavyIndustryBlock

  constructor TMetacontrolsysBlock.Create(anId            : string;
                                             aCapacities     : array of TFluidValue;
                                             aMetalsMax      : TFluidValue;
                                             aChemicalsMax   : TFluidValue;
                                             aElectCompMax   : TFluidValue;
                                             aCompMax        : TFluidValue;
                                             aLegalServMax   : TFluidValue;
                                             aMachineryMax   : TFluidValue;
                                             aMaxBudget      : TMoney;
                                             aBlockClass     : CBlock);
    var
      Sample : TcontrolsysBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_controlsys_Supplies,
        accIdx_controlsys_Products,
        accIdx_controlsys_Salaries,
        accIdx_controlsys_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_cpu,
          inputZero,
          InputData(aMetalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_cpu]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_almetal,
          inputZero,
          InputData(aChemicalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_almetal]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fChemicals),
          Sample.Offset(Sample.fChemicals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Plastics,
          inputZero,
          InputData(aElectCompMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Plastics]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fElectComp),
          Sample.Offset(Sample.fElectComp)));

      // Company Inputs
      if aCompMax > 0
        then RegisterCompanyInput(tidFluid_CompServ, aCompMax, false);
      if aLegalServMax > 0
        then RegisterCompanyInput(tidFluid_LegalServ, aLegalServMax, false);

      // Outputs
      MetaOutputs.Insert(
        TMetaOutput.Create(
          tidGate_controlsys,
          FluidData(aMachineryMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_controlsys]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMachinery),
          Sample.Offset(Sample.fMachinery)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_controlsys],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_cpu],
              1000,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_almetal],
              400,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Plastics],
              400,
              1));

          // Company Inputs
          if aCompMax > 0
            then RegisterCompanyInput(0, 0.05, 0.05, aCompMax);
          if aLegalServMax > 0
            then RegisterCompanyInput(intcond(aCompMax > 0, 1, 0), 0.03, 0.02, aLegalServMax);

          Register(MetaEvaluatorPool);
        end
    end;

  procedure RegisterBackup;
    begin
      BackupInterfaces.RegisterClass(TcontrolsysBlock);
    end;

end.
