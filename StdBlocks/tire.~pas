unit tft;

interface

  uses
    Kernel, Population, WorkCenterBlock, Surfaces, OutputEvaluators,
    StdFluids, BackupInterfaces, PolluterWorkCenter, Accounts;

  const
    ElectCompOpenTime  = 1*24;
    ElectCompCloseTime = 1*24;

  type
    TMetatftBlock =
      class(TMetaPolluterWorkCenterBlock)
        public
          constructor Create(anId            : string;
                             aCapacities     : array of TFluidValue;
                             aSiliconMax     : TFluidValue;
                             aMetalsMax      : TFluidValue;
                             aMetalsMax2      : TFluidValue;
                             aChemicalsMax   : TFluidValue;
                             aCompMax        : TFluidValue;
                             aLegalServMax   : TFluidValue;
                             aElectronicsMax : TFluidValue;
                             aMaxBudget      : TMoney;
                             aBlockClass     : CBlock);
      end;

    TtftBlock =
      class(TPolluterWorkCenterBlock)
        private
          fSilicons    : TInputData;
          fSilane    : TInputData;
          fMetals      : TInputData;
          fChemicals   : TInputData;
          fElectComp   : TOutputData;
      end;

  procedure RegisterBackup;

implementation

  uses
    ClassStorage, MathUtils, StdAccounts;


  // TMetaElectronicIndustryBlock

  constructor TMetatftBlock.Create(anId            : string;
                                                  aCapacities     : array of TFluidValue;
                                                  aSiliconMax     : TFluidValue;
                                                  aMetalsMax      : TFluidValue;
                                                  aMetalsMax2      : TFluidValue;
                                                  aChemicalsMax   : TFluidValue;
                                                  aCompMax        : TFluidValue;
                                                  aLegalServMax   : TFluidValue;
                                                  aElectronicsMax : TFluidValue;
                                                  aMaxBudget      : TMoney;
                                                  aBlockClass     : CBlock);
    var
      Sample : TtftBlock;
    begin
      inherited Create(anId,
        aCapacities,
        accIdx_tft_Supplies,
        accIdx_tft_Products,
        accIdx_tft_Salaries,
        accIdx_tft_Maintenance,
        aBlockClass);

      Sample := nil;

      // Inputs
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_silicon,
          inputZero,
          InputData(aSiliconMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_silicon]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fSilicons),
          Sample.Offset(Sample.fSilicons)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_silane,
          inputZero,
          InputData(aMetalsMax2, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_silane]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fSilane),
          Sample.Offset(Sample.fSilane)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_Plastics,
          inputZero,
          InputData(aMetalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_Plastics]),
          5,
          mglBasic,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fMetals),
          Sample.Offset(Sample.fMetals)));
      MetaInputs.Insert(
        TMetaInput.Create(
          tidGate_copper,
          inputZero,
          InputData(aChemicalsMax, 100),
          InputData(0, 0),
          qIlimited,
          TPullInput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_copper]),
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
          tidGate_tft,
          FluidData(aElectronicsMax, 100),
          TPullOutput,
          TMetaFluid(TheClassStorage.ClassById[tidClassFamily_Fluids, tidFluid_tft]),
          5,
          [mgoptCacheable, mgoptEditable],
          sizeof(Sample.fElectComp),
          Sample.Offset(Sample.fElectComp)));

      // MetaEvaluators
      with TMetaOutputEvaluator.Create(
        aMaxBudget,
        0,
        OutputByName[tidGate_tft],
        TOutputEvaluator) do
        begin
          FullOpenTime  := 30;
          FullCloseTime := 31;
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_silicon],
              500,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_Plastics],
              500,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_silane],
              1000,
              1));
          RegisterInput(
            TMetaInputInfo.Create(
              InputByName[tidGate_copper],
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
      BackupInterfaces.RegisterClass(TtftBlock);
    end;

end.
