{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W+,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}

{$DEFINE USELogs}

library DissidentPack1;
    
uses
  ShareMem,
  SysUtils,
  Windows,
  ClassStorage,
  Kernel in '..\..\Kernel\Kernel.pas',
  Population in '..\..\Kernel\Population.pas',
  Trade in '..\..\Kernel\Trade.pas',
  Protocol in '..\..\Protocol\Protocol.pas',
  EvaluatedBlock in '..\..\StdBlocks\EvaluatedBlock.pas',
  StdFluids in '..\..\StdBlocks\StdFluids.pas',
  PopulatedBlock in '..\..\Kernel\PopulatedBlock.pas',
  ResearchCenter in '..\..\Kernel\ResearchCenter.pas',
  DissidentConst in 'DissidentConst.pas',
  FluidConsts in 'FluidConsts.pas',
  PublicFacility in '..\..\Kernel\PublicFacility.pas',
  ServiceBlock in '..\..\StdBlocks\ServiceBlock.pas',
  Computing in '..\..\StdBlocks\Computing.pas',
  LegalServices in '..\..\StdBlocks\LegalServices.pas',
  Standards in '..\Standards.pas',
  CacheCommon in '..\..\Cache\CacheCommon.pas',
  Environmental in '..\..\StdBlocks\Environmental.pas',
  Environment in '..\..\Kernel\Environment.pas',
  ObjectIndex in '..\..\Kernel\ObjectIndex.pas',
  OutputEvaluators in '..\..\Kernel\OutputEvaluators.pas',
  Headquarters in '..\..\Kernel\Headquarters.pas',
  Land in '..\..\Land\Land.pas',
  OfficeBlock in '..\..\StdBlocks\OfficeBlock.pas',
  NewsServerInterfaces in '..\..\News Server\NewsServerInterfaces.pas',
  Broadcast in '..\..\StdBlocks\Broadcast.pas',
  Movie in '..\..\StdBlocks\Movie.pas',
  BasicAccounts in '..\..\Kernel\BasicAccounts.pas',
  StdAccounts in '..\..\StdBlocks\StdAccounts.pas',
  StdBroadcast in '..\..\StdBlocks\StdBroadcast.pas',
  Banks in '..\..\StdBlocks\Banks.pas',
  WorkCenterBlock in '..\..\Kernel\WorkCenterBlock.pas',
  TransportInterfaces in '..\..\Transport\TransportInterfaces.pas',
  Transport in '..\..\Transport\Transport.pas',
  MatrixLayer in '..\..\Transport\MatrixLayer.pas',
  VisualClassManager in '..\..\Class Packer\VisualClassManager.pas',
  Politics in '..\..\Kernel\Politics.pas',
  FacIds in '..\FacIds.pas',
  TownPolitics in '..\..\Kernel\TownPolitics.pas',
  Logs in '..\..\Logs\Logs.pas',
  ModelServerCache in '..\..\Cache\ModelServerCache.pas',
  Inventions in '..\..\Inventions\Inventions.pas',
  CommonFacs in '..\CommonFacs.pas',
  RankProtocol in '..\..\Protocol\RankProtocol.pas',
  GenIdd in '..\..\Utils\Serial\GenIdd.pas',
  Construction in '..\..\StdBlocks\Construction.pas',
  SimMLS in '..\..\Kernel\SimMLS.pas',

  BusinessMachines in '..\..\StdBlocks\BusinessMachines.pas',
  CarIndustry in '..\..\StdBlocks\CarIndustry.pas',
  CarShop in '..\..\StdBlocks\CarShop.pas',
  Chemical in '..\..\StdBlocks\Chemical.pas',
  ClothesShop in '..\..\StdBlocks\ClothesShop.pas',
  Clothings in '..\..\StdBlocks\Clothings.pas',
  ConstructionIndustry in '..\..\StdBlocks\ConstructionIndustry.pas',
  ElectronicIndustry in '..\..\StdBlocks\ElectronicIndustry.pas',
  Farms in '..\..\StdBlocks\Farms.pas',
  FoodProcessor in '..\..\StdBlocks\FoodProcessor.pas',
  HeavyIndustry in '..\..\StdBlocks\HeavyIndustry.pas',
  HouseHoldingAppliances in '..\..\StdBlocks\HouseHoldingAppliances.pas',
  MetalIndustry in '..\..\StdBlocks\MetalIndustry.pas',
  Mine in '..\..\StdBlocks\Mine.pas',
  TextilIndustry in '..\..\StdBlocks\TextilIndustry.pas',
  FoodStore in '..\..\StdBlocks\FoodStore.pas',
  Bar in '..\..\StdBlocks\Bar.pas',
  HHAStore in '..\..\StdBlocks\HHAStore.pas',
  SuperMarket in '..\..\StdBlocks\SuperMarket.pas',
  Restaurant in '..\..\StdBlocks\Restaurant.pas',
  ToyFactory in '..\..\StdBlocks\ToyFactory.pas',
  ToyStore in '..\..\StdBlocks\ToyStore.pas',
  LiquorFact in '..\..\StdBlocks\LiquorFact.pas',
  ChemMine in '..\..\StdBlocks\ChemMine.pas',
  SiliconMine in '..\..\StdBlocks\SiliconMine.pas',
  StoneMine in '..\..\StdBlocks\StoneMine.pas',
  CoalMine in '..\..\StdBlocks\CoalMine.pas',
  LumberMill in '..\..\StdBlocks\LumberMill.pas',
  FurnitureIndustry in '..\..\StdBlocks\FurnitureIndustry.pas',
  FurnitureStore in '..\..\StdBlocks\FurnitureStore.pas',
  BookStore in '..\..\StdBlocks\BookStore.pas',
  FuneralParlors in '..\..\StdBlocks\FuneralParlors.pas',
  organicwaste in '..\..\StdBlocks\organicwaste.pas',
  fert in '..\..\StdBlocks\fert.pas',
  grainfarma in '..\..\StdBlocks\grainfarma.pas',
  mill in '..\..\StdBlocks\mill.pas',
  cotton in '..\..\StdBlocks\cotton.pas',
  trouser in '..\..\StdBlocks\trouser.pas',
  trousershop in '..\..\StdBlocks\trousershop.pas',
  bakery in '..\..\StdBlocks\bakery.pas',
  ironmine in '..\..\StdBlocks\ironmine.pas',
  SiliconMine2 in '..\..\StdBlocks\SiliconMine2.pas',
  CoalMine2 in '..\..\StdBlocks\CoalMine2.pas',
  steelIndustry in '..\..\StdBlocks\steelIndustry.pas',
  Memory in '..\..\StdBlocks\memory.pas',
  Smallcar in '..\..\StdBlocks\smallcar.pas',
  Tvs in '..\..\StdBlocks\Tvs.pas',
  TVStore in '..\..\StdBlocks\TVStore.pas',
  Smallcarstore in '..\..\StdBlocks\Smallcarstore.pas',
  Mallfood1 in '..\..\StdBlocks\Mallfood1.pas',
  Mallfood2 in '..\..\StdBlocks\Mallfood2.pas',
  glass in '..\..\StdBlocks\glass.pas',
  conveybsys in '..\..\StdBlocks\conveybsys.pas',
  buscomp in '..\..\StdBlocks\buscomp.pas';

procedure RegisterFacilityKinds;
  begin
    with TFacilityKind.Create( tidFacilityKind_DisDistributedDirection ) do
      begin
        Name        := 'Headquarters';
        SuperType   := tidSuperFacKind_Headquarter;
        ClusterName := tidClusterName_Dissident;
        Role        := rolBuyer;
        Register( tidClassFamily_FacilityKinds );
      end;
    with TFacilityKind.Create( tidFacilityKind_DisFarms ) do
      begin
        Name        := 'Farms';
        SuperType   := tidSuperFacKind_Farm;
        ClusterName := tidClusterName_Dissident;
        Technology  := tidInventionKind_IndustrialFacilities;
        Role        := rolProducer;
        Register( tidClassFamily_FacilityKinds );
      end;
    with TFacilityKind.Create( tidFacilityKind_DisIndustrialFacilities ) do
      begin
        Name        := 'Factories';
        SuperType   := tidSuperFacKind_Industry;
        ClusterName := tidClusterName_Dissident;
        Technology  := tidInventionKind_IndustrialFacilities;
        Role        := rolProducer;
        Register( tidClassFamily_FacilityKinds );
      end;
    with TFacilityKind.Create( tidFacilityKind_DisResidentials ) do
      begin
        Name        := 'Residentials';
        SuperType   := tidSuperFacKind_Residential;
        ClusterName := tidClusterName_Dissident;
        Register( tidClassFamily_FacilityKinds );
      end;
    with TFacilityKind.Create( tidFacilityKind_DisServiceFacilities ) do
      begin
        Name        := 'Commerce';
        SuperType   := tidSuperFacKind_Service;
        ClusterName := tidClusterName_Dissident;
        Technology  := tidInventionKind_ServiceFacilities;
        Role        := rolBuyer;
        Register( tidClassFamily_FacilityKinds );
      end;
    with TFacilityKind.Create( tidFacilityKind_DisPublicFacilities ) do
      begin
        Name        := 'Public Facilities';
        SuperType   := tidSuperFacKind_Public;
        ClusterName := tidClusterName_Dissident;
        Technology  := tidInventionKind_PublicFacilities;
        Role        := rolNeutral;
        Register( tidClassFamily_FacilityKinds );
      end;
    with TFacilityKind.Create( tidFacilityKind_DisBusinessFacilities ) do
      begin
        Name        := 'Offices';
        SuperType   := tidSuperFacKind_Business;
        ClusterName := tidClusterName_Dissident;
        Register( tidClassFamily_FacilityKinds );
      end;
    with TFacilityKind.Create( tidFacilityKind_DisSpecial ) do
      begin
        Name        := 'Special';
        SuperType   := tidSuperFacKind_Special;
        ClusterName := tidClusterName_Dissident;
        Role        := rolProducer;
        Register( tidClassFamily_FacilityKinds );
      end;
  end;

type
  TDissidentsCluster =
    class( TCluster )
      public
        function NameNewspaper( TownName : string ) : string; override;
    end;

  function TDissidentsCluster.NameNewspaper( TownName : string ) : string;
    begin
      result := 'Voice of ' + TownName;
    end;


procedure RegisterClusterFacilities;
  begin
    TDissidentsCluster.Create( tidClusterName_Dissident ).Register( tidClassFamily_Clusters );
    RegisterTownHall( tidClusterName_Dissident, tidFacility_DissTownHall, vidFacility_DissTownHall, 6, 6, 250, TPoliticalTownHall );
    RegisterTradeCenter( tidClusterName_Dissident, tidFacility_DissTradeCenter, vidFacility_DissTradeCenter, 3, 3 );
  end;

procedure RegisterInventions;
  begin
  end;

procedure RegisterOffices;
  begin
    // Office A
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissOfficeBuildingConstrA,
      1000000,
      [100, 0, 0],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaOfficeBlock.Create(
      tidBlock_DissOfficeBuildingA,
      30,
      TOfficeBlock ) do
      begin
        Efficiency := 0.6;
        Beauty := 75;
      //BeautyStrength := 1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissOfficeBuildingA, 'Ribs', vidFacility_DissOfficeBuildingA, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_Office;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissOfficeBuildingConstrA])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissOfficeBuildingA])));
        ClusterName := tidClusterName_Dissident;
        TechnologyKind := tidInventionKind_Offices;
        FacilityKind := tidFacilityKind_DisBusinessFacilities;
        MinistryId := nidMinistry_Commerce;
        Register( tidClassFamily_Facilities );
      end;

    // Office B
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissOfficeBuildingConstrB,
      1000000,
      [100, 0, 0],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaOfficeBlock.Create(
      tidBlock_DissOfficeBuildingB,
      20,
      TOfficeBlock ) do
      begin
        Efficiency := 0.65;
        Beauty := 80;
      //BeautyStrength := 1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissOfficeBuildingB, 'Red Ball', vidFacility_DissOfficeBuildingB, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_Office;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissOfficeBuildingConstrB])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissOfficeBuildingB])));
        ClusterName := tidClusterName_Dissident;
        TechnologyKind := tidInventionKind_Offices;
        FacilityKind := tidFacilityKind_DisBusinessFacilities;
        MinistryId := nidMinistry_Commerce;
        Register( tidClassFamily_Facilities );
      end;

    // Office C
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissOfficeBuildingConstrC,
      2000000,
      [100, 0, 0],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaOfficeBlock.Create(
      tidBlock_DissOfficeBuildingC,
      50,
      TOfficeBlock ) do
      begin
        Efficiency := 0.6;
        Beauty := 80;
      //BeautyStrength := 1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissOfficeBuildingC, 'Duango', vidFacility_DissOfficeBuildingC, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_Office;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissOfficeBuildingConstrC])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissOfficeBuildingC])));
        ClusterName := tidClusterName_Dissident;
        TechnologyKind := tidInventionKind_Offices;
        FacilityKind := tidFacilityKind_DisBusinessFacilities;
        MinistryId := nidMinistry_Commerce;
        Register( tidClassFamily_Facilities );
      end;

    // Bank
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissBankConstr,
      10000000,
      [100, 0, 0],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaBankBlock.Create(
      tidBlock_DissBank,
      [5, 25, 10],
      TBankBlock ) do
      begin
        Beauty := 75;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissBank, 'Bank', vidFacility_DissBank, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_Bank;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissBankConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissBank])));
        ClusterName := tidClusterName_Dissident;
        TechnologyKind := tidInventionKind_Banking;
        FacilityKind := tidFacilityKind_DisBusinessFacilities;
        Register( tidClassFamily_Facilities );
      end;
  end;

procedure RegisterResidentials;
  begin
    // Low cost High Class
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLoCostHighClassConstr,
      40000,
      [100, 0, 0],
      7,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissLoCostHighClass,
      pkHigh,
      20,
      TPopulatedBlock ) do
      begin
        Beauty := -200;
        ModifyPrice := false;
        LowCost := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLoCostHighClass, 'Generic high class building', vidFacility_DissLoCostHighClass, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_hiClassLoCost;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLoCostHighClassConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Tower Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLoCostHighClass])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Low cost MiddleClass
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLoCostMiddleClassConstr,
      200000,
      [100, 0, 0],
      7,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissLoCostMiddleClass,
      pkMiddle,
      30,
      TPopulatedBlock ) do
      begin
        Beauty := -200;
        ModifyPrice := false;
        LowCost := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLoCostMiddleClass, 'Generic middle class building', vidFacility_DissLoCostMiddleClass, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_midClassLoCost;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLoCostMiddleClassConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Tower Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLoCostMiddleClass])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Low cost LowClass
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLoCostLowClassConstr,
      100000,
      [100, 0, 0],
      10,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissLoCostLowClass,
      pkLow,
      50,
      TPopulatedBlock ) do
      begin
        Beauty := -200;
        ModifyPrice := false;
        LowCost := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLoCostLowClass, 'Generic low class building', vidFacility_DissLoCostLowClass, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_lowClassLoCost;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLoCostLowClassConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Tower Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLoCostLowClass])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // HighClass Building A
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHighClassBuildingConstrA,
      300000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissHighClassBuildingA,
      pkHigh,
      30,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.7;
        Beauty := 100;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissHighClassBuildingA, 'Needle', vidFacility_DissHighClassBuildingA, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_hiClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingConstrA])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingA])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // HighClass Building B
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHighClassBuildingConstrB,
      150000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissHighClassBuildingB,
      pkHigh,
      15,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.8;
        Beauty := 120;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissHighClassBuildingB, 'Balloon House', vidFacility_DissHighClassBuildingB, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_hiClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingConstrB])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingB])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // HighClass Building C
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHighClassBuildingConstrC,
      550000,
      [100, 0, 0],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissHighClassBuildingC,
      pkHigh,
      50,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.75;
        Beauty := 110;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissHighClassBuildingC, 'Funnel', vidFacility_DissHighClassBuildingC, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_hiClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingConstrC])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingC])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // HighClass Building D
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHighClassBuildingConstrD,
      250000,
      [100, 0, 0],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissHighClassBuildingD,
      pkHigh,
      25,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.7;
        Beauty := 100;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissHighClassBuildingD, 'Cottage', vidFacility_DissHighClassBuildingD, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_hiClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingConstrD])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHighClassBuildingD])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Middle Class Building A
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMiddleClassBuildingConstrA,
      500000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissMiddleClassBuildingA,
      pkMiddle,
      70,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.8;
        Beauty := 100;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMiddleClassBuildingA, 'Dreams Tower', vidFacility_DissMiddleClassBuildingA, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_midClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingConstrA])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingA])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Middle Class Building B
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMiddleClassBuildingConstrB,
      300000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissMiddleClassBuildingB,
      pkMiddle,
      30,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.85;
        Beauty := 120;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMiddleClassBuildingB, 'The Mushrooms', vidFacility_DissMiddleClassBuildingB, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_midClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingConstrB])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingB])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Middle Class Building C
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMiddleClassBuildingConstrC,
      1100000,
      [100, 0, 0],
      27,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissMiddleClassBuildingC,
      pkMiddle,
      110,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.75;
        Beauty := 110;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMiddleClassBuildingC, 'The Bushings', vidFacility_DissMiddleClassBuildingC, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 120;
        FacId := FID_midClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingConstrC])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingC])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Middle Class Building D
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMiddleClassBuildingConstrD,
      1100000,
      [100, 0, 0],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissMiddleClassBuildingD,
      pkMiddle,
      70,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.8;
        Beauty := 120;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMiddleClassBuildingD, 'Screwer', vidFacility_DissMiddleClassBuildingD, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_midClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingConstrD])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingD])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Middle Class Building E
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMiddleClassBuildingConstrE,
      1100000,
      [100, 0, 0],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissMiddleClassBuildingE,
      pkMiddle,
      120,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.8;
        Beauty := 105;
      //BeautyStrength := 0.1;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMiddleClassBuildingE, 'Castles', vidFacility_DissMiddleClassBuildingE, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 120;
        FacId := FID_midClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingConstrE])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingE])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Middle Class Building F
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMiddleClassBuildingConstrF,
      1050000,
      [100, 0, 0],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissMiddleClassBuildingF,
      pkMiddle,
      100,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.8;
        Beauty := 105;
      //BeautyStrength := 0.1;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMiddleClassBuildingF, 'Spire', vidFacility_DissMiddleClassBuildingF, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_midClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingConstrF])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMiddleClassBuildingF])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Low Class Building A
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLowClassDomeConstrA,
      1000000,
      [100, 0, 0],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissLowClassDomeA,
      pkLow,
      120,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.65;
        Beauty := 50;
      //BeautyStrength := 0.1;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLowClassDomeA, 'Recycled Homes', vidFacility_DissLowClassDomeA, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_lowClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeConstrA])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeA])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Low Class Building B
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLowClassDomeConstrB,
      200000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissLowClassDomeB,
      pkLow,
      100,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.65;
        Beauty := 60;
      //BeautyStrength := 0.1;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLowClassDomeB, 'Recycled Buildings', vidFacility_DissLowClassDomeB, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 120;
        FacId := FID_lowClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeConstrB])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeB])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Low Class Building C
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLowClassDomeConstrC,
      500000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissLowClassDomeC,
      pkLow,
      150,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.6;
        Beauty := 50;
      //BeautyStrength := 0.1;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLowClassDomeC, 'Sardine Cans', vidFacility_DissLowClassDomeC, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_lowClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeConstrC])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeC])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

    // Low Class Building D
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLowClassDomeConstrD,
      600000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPopulatedBlock.Create(
      tidBlock_DissLowClassDomeD,
      pkLow,
      200,
      TPopulatedBlock ) do
      begin
        Efficiency := 0.65;
        Beauty := 50;
      //BeautyStrength := 0.1;
        VisualStages := 2;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLowClassDomeD, 'The Barracks', vidFacility_DissLowClassDomeD, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 120;
        FacId := FID_lowClass;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeConstrD])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLowClassDomeD])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisResidentials;
        TechnologyKind := tidInventionKind_OfficeAndResidentials;
        MinistryId := nidMinistry_Housing;
        Register( tidClassFamily_Facilities );
      end;

  end;

procedure RegisterPublicFacilities;
  begin
    // Hospital
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHospitalConstr,
      10000000,
      [90, 5, 5],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPublicFacility.Create(
      tidBlock_DissHospital,
      [20, 45, 30],
      [PFInfoDef(tidPublicFac_Health, 40000)],
      TPublicFacility ) do
      begin
        MaintCost := 500;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissHospital, 'Hospital', vidFacility_DissHospital, TFacility ) do
      begin
        XSize := 3;
        YSize := 3;
        Level := 120;
        SlotCount := 0;
        DemoLapse := 1;
        FacId := FID_Hospital;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHospitalConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissHospital])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_PublicFacilities;
        MinistryId := nidMinistry_Health;
        Register( tidClassFamily_Facilities );
      end;

    // School
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSchoolConstr,
      5000000, //7*80000,
      [90, 5, 5],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPublicFacility.Create(
      tidBlock_DissSchool,
      [1, 20, 10],
      [PFInfoDef(tidPublicFac_School, 20000)],
      TPublicFacility ) do
      begin
        MaintCost := 500;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissSchool, 'School', vidFacility_DissSchool, TFacility ) do
      begin
        XSize := 3;
        YSize := 3;
        Level := 120;
        SlotCount := 0;
        DemoLapse := 1;
        FacId := FID_School;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissSchoolConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Building Completed', 'Building is ready', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissSchool])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_PublicFacilities;
         MinistryId := nidMinistry_Education;
        Register( tidClassFamily_Facilities );
      end;

    // Police
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissPoliceConstr,
      5000000,
      [90, 5, 5],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaPublicFacility.Create(
      tidBlock_DissPolice,
      [0, 2, 80],
      [PFInfoDef(tidPublicFac_Police, 5000),
      PFInfoDef(tidPublicFac_Fire, 10000)],
      TPublicFacility ) do
      begin
        MaintCost := 500;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissPolice, 'Police', vidFacility_DissPolice, TFacility ) do
      begin
        XSize := 1;
        YSize := 1;
        Level := 120;
        SlotCount := 0;
        FacId := FID_Police;
        DemoLapse := 1;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissPoliceConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Police Completed', 'Police is done', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissPolice])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_PublicFacilities;
        MinistryId := nidMinistry_Defense;
        Register( tidClassFamily_Facilities );
      end;

    // Small park
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSmallParkConstr,
      1000000,
      [100, 0, 0],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaEnvironmentalBlock.Create(
      tidBlock_DissSmallPark,
      TEnvironmentalBlock ) do
      begin
        RegisterModifier( tidEnvironment_Beauty, 300, 10 );
        RegisterModifier( tidEnvironment_Pollution, -300, 10 );
        MaintCost := 200;
        DissabledStop := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissSmallPark, 'Small Park', vidFacility_DissSmallPark, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 200;
        FacId := FID_Park;
        DemoLapse := 1;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissSmallParkConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Park Completed', 'Park is done', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissSmallPark])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_PublicFacilities;
        Register( tidClassFamily_Facilities );
      end;

    // Medium park
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMediumParkConstr,
      2000000,
      [100, 0, 0],
      22,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaEnvironmentalBlock.Create(
      tidBlock_DissMediumPark,
      TEnvironmentalBlock ) do
      begin
        RegisterModifier( tidEnvironment_Beauty, 400, 10 );
        RegisterModifier( tidEnvironment_Pollution, -400, 10 );
        MaintCost := 250;
        DissabledStop := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMediumPark, 'Park', vidFacility_DissMediumPark, TFacility ) do
      begin
        XSize := 5;
        YSize := 5;
        Level := 300;
        FacId := FID_Park;
        DemoLapse := 1;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMediumParkConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Park Completed', 'Building is done', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissMediumPark])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_PublicFacilities;
        Register( tidClassFamily_Facilities );
      end;

    // Central park
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissCentralParkConstr,
      3000000,
      [100, 0, 0],
      22,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaEnvironmentalBlock.Create(
      tidBlock_DissCentralPark,
      TEnvironmentalBlock ) do
      begin
        RegisterModifier( tidEnvironment_Beauty, 500, 10 );
        RegisterModifier( tidEnvironment_Pollution, -500, 10 );
        MaintCost := 600;
        DissabledStop := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissCentralPark, 'Big Park', vidFacility_DissCentralPark, TFacility ) do
      begin
        XSize := 7;
        YSize := 7;
        Level := 200;
        FacId := FID_Park;
        DemoLapse := 1;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissCentralParkConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Park Completed', 'Building is done', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissCentralPark])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_PublicFacilities;
        Register( tidClassFamily_Facilities );
      end;

    // Statue of Liberty
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLibertyConstr,
      costLiberty,
      [100, 0, 0],
      50,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaEnvironmentalBlock.Create(
      tidBlock_DissLiberty,
      TEnvironmentalBlock ) do
      begin
        Prestige := prestLiberty;
        RegisterModifier( tidEnvironment_Beauty, 500, 10 );
        MinColDist := 5;
        ColIsSameComp := false;
        MaintCost := 2000;
        DissabledStop := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLiberty, 'Statue of Liberty', vidFacility_DissLiberty, TFacility ) do
      begin
        XSize := 4;
        YSize := 4;
        Level := 200;
        FacId := FID_LuxuryFac;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLibertyConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Park Completed', 'Building is done', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissLiberty])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_Monuments;
        Register( tidClassFamily_Facilities );
      end;

    // IFEL Tower
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTowerConstr,
      costIFELTower,
      [100, 0, 0],
      50,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaEnvironmentalBlock.Create(
      tidBlock_DissTower,
      TEnvironmentalBlock ) do
      begin
        Prestige := prestIFELTower;
        RegisterModifier( tidEnvironment_Beauty, 500, 10 );
        MinColDist := 5;
        ColIsSameComp := false;
        MaintCost := 2000;
        DissabledStop := true;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissTower, 'IFEL Tower', vidFacility_DissTower, TFacility ) do
      begin
        XSize := 4;
        YSize := 4;
        Level := 200;
        FacId := FID_LuxuryFac;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Construction, 'Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissTowerConstr])));
        EvlStages.Insert( TEvlStage.Create( tidFacilityStage_Complete, 'Park Completed', 'Building is done', TMetaBlock(TheClassStorage.ClassById[tidClassFamily_Blocks, tidBlock_DissTower])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisPublicFacilities;
        TechnologyKind := tidInventionKind_Monuments;
        Register( tidClassFamily_Facilities );
      end;

    // Common Public services
    CopyCommonFacilities( tidBlock_SRVCOMMON, tidClusterName_Dissident, tidFacilityKind_DisPublicFacilities, tidInventionKind_PublicFacilities );
    // Common Special
    CopyCommonFacilities(tidBlock_SPECIALCOMMON, tidClusterName_Dissident, tidFacilityKind_DisSpecial, '');
    // Common Warehouses
    CopyCommonFacilities(tidBlock_WHCOMMON, tidClusterName_Dissident, tidFacilityKind_DisIndustrialFacilities, '');
  end;

procedure RegisterIndustries;
  begin
    // Equivalences
    TheClassStorage.RegisterEqv(tidClassFamily_Blocks, 'DissFoodDome', tidBlock_DissFoodProc);
    TheClassStorage.RegisterEqv(tidClassFamily_Facilities, 'DissFoodDome', tidFacility_DissFoodProc);
 {$IFDEF oldbuild}
    // Farm Small
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFarmSmallConstr,
      cost_FarmSmall,
      [80, 20, 0],
      15,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFarmBlock.Create(
      tidBlock_DissFarmSmall,
      [input_FarmSmall_ExecutivesWorkForce, input_FarmSmall_ProfessionalWorkForce, input_FarmSmall_Workers],
      input_FarmSmall_Chemicals,
      0, //input_FarmSmall_LegalServices,
      0, //input_FarmSmall_ComputerServices,
      output_FarmSmall_FreshFood,
      output_FarmSmall_OrganicMaterials,
      budget_FarmSmall,
      TFarmBlock ) do
      begin
        VisualStages := 2;
        Beauty := -20;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissFarmSmall, 'Small Farm', vidFacility_DissFarmSmall, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 20;
        FacId := FID_Farm;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFarmSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The farm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFarmSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisFarms;
        TechnologyKind := tidLicence_Farms;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

    // Farm
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFarmConstr,
      cost_Farm,
      [80, 15, 5],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFarmBlock.Create(
      tidBlock_DissFarm,
      [input_Farm_ExecutivesWorkForce, input_Farm_ProfessionalWorkForce, input_Farm_Workers],
      input_Farm_Chemicals,
      0, //input_Farm_LegalServices,
      0, //input_Farm_ComputerServices,
      output_Farm_FreshFood,
      output_Farm_OrganicMaterials,
      budget_Farm,
      TFarmBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissFarm, 'Farm', vidFacility_DissFarm, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 20;
        FacId := FID_Farm;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFarmConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The farm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFarm])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisFarms;
        TechnologyKind := tidInventionKind_LargeFarms;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;       

    //el Farm
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisselFarmConstr,
      cost_elFarm,
      [80, 15, 5],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFarmBlock.Create(
      tidBlock_DisselFarm,
      [input_elFarm_ExecutivesWorkForce, input_elFarm_ProfessionalWorkForce, input_elFarm_Workers],
      input_elFarm_Chemicals,
      0, //input_Farm_LegalServices,
      0, //input_Farm_ComputerServices,
      output_elFarm_FreshFood,
      output_elFarm_OrganicMaterials,
      budget_elFarm,
      TFarmBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DisselFarm, 'Farm', vidFacility_DisselFarm, TFacility ) do
      begin
        xSize := 6;
        ySize := 6;
        Level := 20;
        FacId := FID_Farm;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisselFarmConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The farm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisselFarm])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisFarms;
        TechnologyKind := tidInventionKind_eLargeFarms;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end; 

    // Massive Farm
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMassiveFarmConstr,
      cost_MassiveFarm,
      [80, 15, 5],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFarmBlock.Create(
      tidBlock_DissMassiveFarm,
      [input_MassiveFarm_ExecutivesWorkForce, input_MassiveFarm_ProfessionalWorkForce, input_MassiveFarm_Workers],
      input_MassiveFarm_Chemicals,
      0, //input_Farm_LegalServices,
      0, //input_Farm_ComputerServices,
      output_MassiveFarm_FreshFood,
      output_MassiveFarm_OrganicMaterials,
      budget_MassiveFarm,
      TFarmBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMassiveFarm, 'Farm', vidFacility_DissMassiveFarm, TFacility ) do
      begin
        xSize := 7;
        ySize := 7;
        Level := 20;
        FacId := FID_Farm;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMassiveFarmConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The farm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMassiveFarm])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisFarms;
        TechnologyKind := tidInventionKind_MassiveFarms;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

    // Small Chemical plant
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissChemicalSmallConstr,
      cost_ChemicalPlantSmall,
      [50, 40, 10],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaChemicalBlock.Create(
      tidBlock_DissChemicalSmall,
      [input_ChemicalPlantSmall_ExecutivesWorkForce, input_ChemicalPlantSmall_ProfessionalWorkForce, input_ChemicalPlantSmall_Workers],
      input_ChemicalPlantSmall_LegalServices,
      input_ChemicalPlantSmall_ComputerServices,
      input_ChemicalPlantSmall_Ore,
      output_ChemicalPlantSmall_Chemicals,
      budget_ChemicalPlantSmall,
      TChemicalBlock ) do
      begin
        Beauty := -60;
        //BeautyStrength := 1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissChemicalSmall, 'Small Chemical Plant', vidFacility_DissChemicalSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 15;
        FacId := FID_Chemical;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemicalSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The factory is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemicalSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Chemical;
        Register( tidClassFamily_Facilities );
      end;

    // Chemical plant
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissChemicalConstr,
      cost_ChemicalPlant,
      [50, 40, 10],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaChemicalBlock.Create(
      tidBlock_DissChemical,
      [input_ChemicalPlant_ExecutivesWorkForce, input_ChemicalPlant_ProfessionalWorkForce, input_ChemicalPlant_Workers],
      input_ChemicalPlant_LegalServices,
      input_ChemicalPlant_ComputerServices,
      input_ChemicalPlant_Ore,
      output_ChemicalPlant_Chemicals,
      budget_ChemicalPlant,
      TChemicalBlock ) do
      begin
        Beauty := -70;
      //BeautyStrength := 1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissChemical, 'Chemical Plant', vidFacility_DissChemical, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 15;
        FacId := FID_Chemical;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemicalConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemical])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeChemical;
        Register( tidClassFamily_Facilities );
      end;

    // Ore Mine Small
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMineSmallConstr,
      cost_MineSmall,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaMineBlock.Create(
      tidBlock_DissMineSmall,
      [input_MineSmall_ExecutivesWorkForce, input_MineSmall_ProfessionalWorkForce, input_MineSmall_Workers],
      input_MineSmall_LegalServices,
      input_MineSmall_ComputerServices,
      input_MineSmall_Chemicals,
      output_MineSmall_Ore,
      budget_MineSmall,
      TMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMineSmall, 'Small Mine', vidFacility_DissMineSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_Mine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMineSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMineSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Mines;
        Register( tidClassFamily_Facilities );
      end;

    // Ore Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMineConstr,
      cost_Mine,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaMineBlock.Create(
      tidBlock_DissMine,
      [input_Mine_ExecutivesWorkForce, input_Mine_ProfessionalWorkForce, input_Mine_Workers],
      input_Mine_LegalServices,
      input_Mine_ComputerServices,
      input_Mine_Chemicals,
      output_Mine_Ore,
      budget_Mine,
      TMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissMine, 'Mine', vidFacility_DissMine, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_Mine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMineConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMine])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeMines;
        Register( tidClassFamily_Facilities );
      end;

    // Small Chem Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissChemMineSmallConstr,
      cost_MineSmall, // >>
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaChemMineBlock.Create(
      tidBlock_DissChemMineSmall,
      [input_MineSmall_ExecutivesWorkForce, input_MineSmall_ProfessionalWorkForce, input_MineSmall_Workers],
      input_MineSmall_LegalServices,
      input_MineSmall_ComputerServices,
      input_MineSmall_Chemicals,
      output_MineSmall_Ore,
      budget_MineSmall,
      TChemMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissChemMineSmall, 'Small Chemical Mine', vidFacility_DissChemMineSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_ChemicalMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemMineSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemMineSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_ChemMines;
        Register( tidClassFamily_Facilities );
      end;

    // Chemical Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissChemMineConstr,
      cost_Mine,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaChemMineBlock.Create(
      tidBlock_DissChemMine,
      [input_Mine_ExecutivesWorkForce, input_Mine_ProfessionalWorkForce, input_Mine_Workers],
      input_Mine_LegalServices,
      input_Mine_ComputerServices,
      input_Mine_Chemicals,
      output_Mine_Ore,
      budget_Mine,
      TChemMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissChemMine, 'Chemical Mine', vidFacility_DissChemMine, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_ChemicalMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemMineConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissChemMine])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeChemMines;
        Register( tidClassFamily_Facilities );
      end;

    // Small Silicon Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSiliconMineSmallConstr,
      cost_MineSmall, // >>
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaSiliconMineBlock.Create(
      tidBlock_DissSiliconMineSmall,
      [input_MineSmall_ExecutivesWorkForce, input_MineSmall_ProfessionalWorkForce, input_MineSmall_Workers],
      input_MineSmall_LegalServices,
      input_MineSmall_ComputerServices,
      input_MineSmall_Chemicals,
      output_MineSmall_Ore,
      budget_MineSmall,
      TSiliconMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissSiliconMineSmall, 'Small Silicon Mine', vidFacility_DissSiliconMineSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_SiliconMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMineSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMineSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_SiliconMines;
        Register( tidClassFamily_Facilities );
      end;

    // Silicon Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSiliconMineConstr,
      cost_Mine,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaSiliconMineBlock.Create(
      tidBlock_DissSiliconMine,
      [input_Mine_ExecutivesWorkForce, input_Mine_ProfessionalWorkForce, input_Mine_Workers],
      input_Mine_LegalServices,
      input_Mine_ComputerServices,
      input_Mine_Chemicals,
      output_Mine_Ore,
      budget_Mine,
      TSiliconMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissSiliconMine, 'Silicon Mine', vidFacility_DissSiliconMine, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_SiliconMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMineConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMine])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeSiliconMines;
        Register( tidClassFamily_Facilities );
      end;

    // Small Stone Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissStoneMineSmallConstr,
      cost_MineSmall, // >>
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaStoneMineBlock.Create(
      tidBlock_DissStoneMineSmall,
      [input_MineSmall_ExecutivesWorkForce, input_MineSmall_ProfessionalWorkForce, input_MineSmall_Workers],
      input_MineSmall_LegalServices,
      input_MineSmall_ComputerServices,
      input_MineSmall_Chemicals,
      output_MineSmall_Ore,
      budget_MineSmall,
      TStoneMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissStoneMineSmall, 'Small Stone Mine', vidFacility_DissStoneMineSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_StoneMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissStoneMineSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissStoneMineSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_StoneMines;
        Register( tidClassFamily_Facilities );
      end;

    // Stone Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissStoneMineConstr,
      cost_Mine,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaStoneMineBlock.Create(
      tidBlock_DissStoneMine,
      [input_Mine_ExecutivesWorkForce, input_Mine_ProfessionalWorkForce, input_Mine_Workers],
      input_Mine_LegalServices,
      input_Mine_ComputerServices,
      input_Mine_Chemicals,
      output_Mine_Ore,
      budget_Mine,
      TStoneMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissStoneMine, 'Stone Mine', vidFacility_DissStoneMine, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_StoneMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissStoneMineConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissStoneMine])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeStoneMines;
        Register( tidClassFamily_Facilities );
      end;

    // Small Coal Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissCoalMineSmallConstr,
      cost_MineSmall, // >>
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaCoalMineBlock.Create(
      tidBlock_DissCoalMineSmall,
      [input_MineSmall_ExecutivesWorkForce, input_MineSmall_ProfessionalWorkForce, input_MineSmall_Workers],
      input_MineSmall_LegalServices,
      input_MineSmall_ComputerServices,
      input_MineSmall_Chemicals,
      output_MineSmall_Ore,
      budget_MineSmall,
      TCoalMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissCoalMineSmall, 'Small Coal Mine', vidFacility_DissCoalMineSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_CoalMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMineSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMineSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_CoalMines;
        Register( tidClassFamily_Facilities );
      end;

    // Coal Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissCoalMineConstr,
      cost_Mine,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaCoalMineBlock.Create(
      tidBlock_DissCoalMine,
      [input_Mine_ExecutivesWorkForce, input_Mine_ProfessionalWorkForce, input_Mine_Workers],
      input_Mine_LegalServices,
      input_Mine_ComputerServices,
      input_Mine_Chemicals,
      output_Mine_Ore,
      budget_Mine,
      TCoalMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissCoalMine, 'Coal Mine', vidFacility_DissCoalMine, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_CoalMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMineConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMine])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeCoalMines;
        Register( tidClassFamily_Facilities );
      end;

    // Food Processor Small
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFoodProcSmallConstr,
      cost_FoodProcessingPlantsmall,
      [40, 40, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFoodProcessorBlock.Create(
      tidBlock_DissFoodProcSmall,
      [input_FoodProcessingPlantsmall_ExecutivesWorkForce, input_FoodProcessingPlantsmall_ProfessionalWorkForce, input_FoodProcessingPlantsmall_Workers],
      input_FoodProcessingPlantsmall_FreshFood,
      input_FoodProcessingPlantsmall_Chemicals,
      input_FoodProcessingPlantsmall_LegalServices,
      input_FoodProcessingPlantsmall_ComputerServices,
      output_FoodProcessingPlantsmall_ProcessedFood,
      budget_FoodProcessingPlantsmall,
      TFoodProcessorBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissFoodProcSmall, 'Small Food Processor', vidFacility_DissFoodProcSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_FoodProc;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFoodProcSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFoodProcSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_FoodProc;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

    // Food Processor
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFoodProcConstr,
      cost_FoodProcessingPlant,
      [40, 40, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFoodProcessorBlock.Create(
      tidBlock_DissFoodProc,
      [input_FoodProcessingPlant_ExecutivesWorkForce, input_FoodProcessingPlant_ProfessionalWorkForce, input_FoodProcessingPlant_Workers],
      input_FoodProcessingPlant_FreshFood,
      input_FoodProcessingPlant_Chemicals,
      input_FoodProcessingPlant_LegalServices,
      input_FoodProcessingPlant_ComputerServices,
      output_FoodProcessingPlant_ProcessedFood,
      budget_FoodProcessingPlant,
      TFoodProcessorBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
      //BeautyStrength := 1;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissFoodProc, 'Food Processor', vidFacility_DissFoodProc, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_FoodProc;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFoodProcConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFoodProc])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeFoodProc;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

    // Liquor Factory
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLiquorFactConstr,
      cost_LiquorFact,
      [40, 40, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaLiquorFactoryBlock.Create(
      tidBlock_DissLiquorFact,
      [input_LiquorFact_ExecutivesWorkForce, input_LiquorFact_ProfessionalWorkForce, input_LiquorFact_Workers],
      input_LiquorFact_FreshFood,
      input_LiquorFact_Chemicals,
      input_LiquorFact_LegalServices,
      input_LiquorFact_ComputerServices,
      output_LiquorFact_Liquors,
      budget_LiquorFact,
      TLiquorFactoryBlock ) do
      begin
        VisualStages := 1;
        Beauty := -100;
      //BeautyStrength := 1;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissLiquorFact, 'Liquor plant', vidFacility_DissLiquorFact, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_LiquorFact;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissLiquorFactConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissLiquorFact])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Liquors;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );                               
      end;

    // Small Metal Industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMetalSmallConstr,
      cost_MetalurgicSmall,
      [40, 50, 10],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMetalIndustryBlock.Create(
      tidBlock_DissMetalSmall,
      [0{input_MetalurgicSmall_ExecutivesWorkForce}, input_MetalurgicSmall_ProfessionalWorkForce, input_MetalurgicSmall_Workers],
      input_MetalurgicSmall_Ore,
      input_MetalurgicSmall_Chemicals,
      input_MetalurgicSmall_LegalServices,
      input_MetalurgicSmall_ComputerServices,
      output_MetalurgicSmall_Metal,
      budget_MetalurgicSmall,
      TMetalIndustryBlock ) do
      begin
        Beauty := -120;
      //BeautyStrength := 1;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissMetalSmall, 'Small Metal Industry', vidFacility_DissMetalSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_Metal;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMetalSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMetalSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Metallurgy;
        Register( tidClassFamily_Facilities );
      end;

    // Metal industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMetalConstr,
      cost_Metalurgic,
      [40, 50, 10],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMetalIndustryBlock.Create(
      tidBlock_DissMetal,
      [input_Metalurgic_ExecutivesWorkForce, input_Metalurgic_ProfessionalWorkForce, input_Metalurgic_Workers],
      input_Metalurgic_Ore,
      input_Metalurgic_Chemicals,
      input_Metalurgic_LegalServices,
      input_Metalurgic_ComputerServices,
      output_Metalurgic_Metal,
      budget_Metalurgic,
      TMetalIndustryBlock ) do
      begin
        Beauty := -120;
      //BeautyStrength := 1;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissMetal, 'Metal Industry', vidFacility_DissMetal, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_Metal;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMetalConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMetal])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeMetallurgy;
        Register( tidClassFamily_Facilities );
      end;

    // Small Textile Industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTextileSmallConstr,
      cost_TextileSmall,
      [45, 40, 15],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaTextilIndustryBlock.Create(
      tidBlock_DissTextileSmall,
      [input_TextileSmall_ExecutivesWorkForce, input_TextileSmall_ProfessionalWorkForce, input_TextileSmall_Workers],
      input_TextileSmall_OrganicMaterials,
      input_TextileSmall_Chemicals,
      input_TextileSmall_ComputerServices,
      input_TextileSmall_LegalServices,
      output_TextileSmall_FabricsandThreads,
      budget_TextileSmall,
      TTextilIndustryBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissTextileSmall, 'Small Textile Industry', vidFacility_DissTextileSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_Textile;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTextileSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTextileSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Textile;
        Register( tidClassFamily_Facilities );
      end;

    // Textile industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTextileConstr,
      cost_Textile,
      [45, 40, 15],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaTextilIndustryBlock.Create(
      tidBlock_DissTextile,
      [input_Textile_ExecutivesWorkForce, input_Textile_ProfessionalWorkForce, input_Textile_Workers],
      input_Textile_OrganicMaterials,
      input_Textile_Chemicals,
      input_Textile_ComputerServices,
      input_Textile_LegalServices,
      output_Textile_FabricsandThreads,
      budget_Textile,
      TTextilIndustryBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissTextile, 'Textile Industry', vidFacility_DissTextile, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_Textile;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTextileConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTextile])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeTextile;
        Register( tidClassFamily_Facilities );
      end;

    // Small Clothings industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissClothingsSmallConstr,
      cost_ClothingSmall,
      [50, 40, 10],
      25,
      TBlockUnderConstruction) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaClothingsIndustryBlock.Create(
      tidBlock_DissClothingsSmall,
      [input_ClothingSmall_ExecutivesWorkForce, input_ClothingSmall_ProfessionalWorkForce, input_ClothingSmall_Workers],
      input_ClothingSmall_FabricsandThreads,
      input_ClothingSmall_OrganicMaterials,
      input_ClothingSmall_Chemicals,
      input_ClothingSmall_ComputerServices,
      input_ClothingSmall_LegalServices,
      output_ClothingSmall_Cheapclothing,
      budget_ClothingSmall,
      TClothingsIndustryBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissClothingsSmall, 'Small Clothing Factory', vidFacility_DissClothingsSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Clothes;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissClothingsSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The industry is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissClothingsSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Clothing;
        Register( tidClassFamily_Facilities );
      end;

    // Clothings industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissClothingsConstr,
      cost_Clothing,
      [50, 40, 10],
      25,
      TBlockUnderConstruction) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaClothingsIndustryBlock.Create(
      tidBlock_DissClothings,
      [input_Clothing_ExecutivesWorkForce, input_Clothing_ProfessionalWorkForce, input_Clothing_Workers],
      input_Clothing_FabricsandThreads,
      input_Clothing_OrganicMaterials,
      input_Clothing_Chemicals,
      input_Clothing_ComputerServices,
      input_Clothing_LegalServices,
      output_Clothing_Cheapclothing,
      budget_Clothing,
      TClothingsIndustryBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissClothings, 'Clothing Factory', vidFacility_DissClothings, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Clothes;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissClothingsConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The industry is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissClothings])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeClothes;
        Register( tidClassFamily_Facilities );
      end;

    // Construction industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissConstructionConstr,
      cost_Construction,
      [45, 40, 15],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaConstructionIndustryBlock.Create(
      tidBlock_DissConstruction,
      [input_Construction_ExecutivesWorkForce, input_Construction_ProfessionalWorkForce, input_Construction_Workers],
      input_Construction_Ore,
      input_Construction_Metal,
      input_Construction_Chemicals,
      input_Construction_Timber,
      input_Construction_LegalServices,
      input_Construction_ComputerServices,
      output_Construction_Construction,
      budget_Construction,
      TConstructionIndustryBlock ) do
      begin
        Beauty := -100;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissConstruction, 'Construction Industry', vidFacility_DissConstruction, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_Construction;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissConstructionConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissConstruction])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Construction;
        Register( tidClassFamily_Facilities );
      end;

    // Small Electronic industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissElectronicSmallConstr,
      cost_ElectronicIndustrySmall,
      [40, 40, 20],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaElectronicIndustryBlock.Create(
      tidBlock_DissElectronicSmall,
      [input_ElectronicIndustrySmall_ExecutivesWorkForce, input_ElectronicIndustrySmall_ProfessionalWorkForce, input_ElectronicIndustrySmall_Workers],
      input_ElectronicIndustrySmall_Metal/2,
      input_ElectronicIndustrySmall_Metal/2,
      input_ElectronicIndustrySmall_Chemicals,
      input_ElectronicIndustrySmall_ComputerServices,
      input_ElectronicIndustrySmall_LegalServices,
      output_ElectronicIndustrySmall_Electroniccomponents,
      budget_ElectronicIndustrySmall,
      TElectronicIndustryBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissElectronicSmall, 'Small Electronic Industry', vidFacility_DissElectronicSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_ElectComp;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Electronic materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissElectronicSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissElectronicSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Electronics;
        Register( tidClassFamily_Facilities );
      end;

    // Electronic industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissElectronicConstr,
      cost_ElectronicIndustry,
      [40, 40, 20],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaElectronicIndustryBlock.Create(
      tidBlock_DissElectronic,
      [input_ElectronicIndustry_ExecutivesWorkForce, input_ElectronicIndustry_ProfessionalWorkForce, input_ElectronicIndustry_Workers],
      input_ElectronicIndustry_Metal/2,
      input_ElectronicIndustry_Metal/2,
      input_ElectronicIndustry_Chemicals,
      input_ElectronicIndustry_ComputerServices,
      input_ElectronicIndustry_LegalServices,
      output_ElectronicIndustry_Electroniccomponents,
      budget_ElectronicIndustry,
      TElectronicIndustryBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissElectronic, 'Electronic Industry', vidFacility_DissElectronic, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_ElectComp;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Electronic materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissElectronicConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissElectronic])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeElectComp;
        Register( tidClassFamily_Facilities );
      end;

    // Heavy industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHeavyConstr,
      cost_HeavyIndustry,
      [45, 40, 15],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaHeavyIndustryBlock.Create(
      tidBlock_DissHeavy,
      [input_HeavyIndustry_ExecutivesWorkForce, input_HeavyIndustry_ProfessionalWorkForce, input_HeavyIndustry_Workers],
      input_HeavyIndustry_Metal,
      input_HeavyIndustry_Chemicals,
      input_HeavyIndustry_ElectronicComponents,
      input_HeavyIndustry_ComputerServices,
      input_HeavyIndustry_LegalServices,
      output_HeavyIndustry_Machinery,
      budget_HeavyIndustry,
      THeavyIndustryBlock ) do
      begin
        Beauty := -100;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissHeavy, 'Machinery Industry', vidFacility_DissHeavy, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_Heavy;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHeavyConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHeavy])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Heavy;
        Register( tidClassFamily_Facilities );
      end;

    // Car industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissCarIndustryConstr,
      cost_CarIndustry,
      [40, 45, 15],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaCarIndustryBlock.Create(
      tidBlock_DissCarIndustry,
      [input_CarIndustry_ExecutivesWorkForce, input_CarIndustry_ProfessionalWorkForce, input_CarIndustry_Workers],
      input_CarIndustry_Metal,
      input_CarIndustry_FabricsAndThreads,
      input_CarIndustry_ElectronicComponents,
      input_CarIndustry_Chemicals,
      input_CarIndustry_Plastics,
      input_CarIndustry_ComputerServices,
      input_CarIndustry_LegalServices,
      output_CarIndustry_NiceCars,
      budget_CarIndustry,
      TCarIndustryBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissCarIndustry, 'Car Factory', vidFacility_DissCarIndustry, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Car;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCarIndustryConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCarIndustry])));
        ClusterName    := tidClusterName_Dissident;
        FacilityKind   := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Cars;
        Register( tidClassFamily_Facilities );
      end;

    // Small HHA industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHHAIndustrySmallConstr,
      cost_HouseHoldingAppliancesSmall,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaHouseHoldingAppliancesBlock.Create(
      tidBlock_DissHHAIndustrySmall,
      [input_HouseHoldingAppliancesSmall_ExecutivesWorkForce, input_HouseHoldingAppliancesSmall_ProfessionalWorkForce, input_HouseHoldingAppliancesSmall_Workers],
      input_HouseHoldingAppliancesSmall_Metal,
      input_HouseHoldingAppliancesSmall_ElectronicComponents,
      input_HouseHoldingAppliancesSmall_Chemicals,
      input_HouseHoldingAppliancesSmall_Plastics,
      input_HouseHoldingAppliancesSmall_ComputerServices,
      input_HouseHoldingAppliancesSmall_LegalServices,
      output_HouseHoldingAppliancesSmall_HouseHoldingAppliances,
      budget_HouseHoldingAppliancesSmall,
      THouseHoldingAppliancesBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissHHAIndustrySmall, 'Small Appliances Factory', vidFacility_DissHHAIndustrySmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Household;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHHAIndustrySmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHHAIndustrySmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_HHA;
        Register( tidClassFamily_Facilities );
      end;

    // HHA industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHHAIndustryConstr,
      cost_HouseHoldingAppliances,
      [45, 40, 15],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaHouseHoldingAppliancesBlock.Create(
      tidBlock_DissHHAIndustry,
      [input_HouseHoldingAppliances_ExecutivesWorkForce, input_HouseHoldingAppliances_ProfessionalWorkForce, input_HouseHoldingAppliances_Workers],
      input_HouseHoldingAppliances_Metal,
      input_HouseHoldingAppliances_ElectronicComponents,
      input_HouseHoldingAppliances_Chemicals,
      input_HouseHoldingAppliances_Plastics,
      input_HouseHoldingAppliances_ComputerServices,
      input_HouseHoldingAppliances_LegalServices,
      output_HouseHoldingAppliances_HouseHoldingAppliances,
      budget_HouseHoldingAppliances,
      THouseHoldingAppliancesBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissHHAIndustry, 'Appliances Factory', vidFacility_DissHHAIndustry, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Household;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHHAIndustryConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHHAIndustry])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeHHA;
        Register( tidClassFamily_Facilities );
      end;

    // Toy industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissToyIndustryConstr,
      cost_ToyIndustry,
      [45, 40, 15],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaToysBlock.Create(
      tidBlock_DissToyIndustry,
      [input_ToyIndustry_ExecutivesWorkForce, input_ToyIndustry_ProfessionalWorkForce, input_ToyIndustry_Workers],
      input_ToyIndustry_Plastics,
      input_ToyIndustry_ElectronicComponents,
      input_ToyIndustry_Chemicals,
      input_ToyIndustry_ComputerServices,
      input_ToyIndustry_LegalServices,
      output_ToyIndustry_ToyIndustry,
      budget_ToyIndustry,
      TToysBlock ) do
      begin
        VisualStages := 1;
        Beauty := -40;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissToyIndustry, 'Toy Factory', vidFacility_DissToyIndustry, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 40;
        FacId := FID_Toys;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissToyIndustryConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissToyIndustry])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Toys;
        MinistryId := nidMinistry_LightIndustry;
        Register( tidClassFamily_Facilities );
      end;

    // Business Machines
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissBusinessMachineConstr,
      cost_BusinessMachines,
      [40, 40, 20],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaBusinessMachinesBlock.Create(
      tidBlock_DissBusinessMachine,
      [input_BusinessMachines_ExecutivesWorkForce, input_BusinessMachines_ProfessionalWorkForce, input_BusinessMachines_Workers],
      input_BusinessMachines_Metal,
      input_BusinessMachines_Chemicals,
      input_BusinessMachines_Plastics,
      input_BusinessMachines_ElectronicComponents,
      input_BusinessMachines_ComputerServices,
      input_BusinessMachines_LegalServices,
      output_BusinessMachines_BusinessMachines,
      budget_BusinessMachines,
      TBusinessMachinesBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissBusinessMachine, 'Business Machines Industry', vidFacility_DissBusinessMachine, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_BusMach;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissBusinessMachineConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissBusinessMachine])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_BMIndustry;
        Register( tidClassFamily_Facilities );
      end;

   

    // Furniture Industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFurnitureIndustryConstr,
      50000000,
      [60, 40, 0],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFurnitureIndustryBlock.Create(
      tidBlock_DissFurnitureIndustry,
      [0, 2, 50],
      5*10, // timber (kg)
      5*2,  // OrgMat)k)
      5*2,  // FabThreads(kg)
      5*4,  // Chemicals (kg)
      5*2,  // Plastics (kg)
      5*1,  // Metal (kg)
      0,    // Software
      0.01, // Legal
      10*1, // Total Furniture
      0,    // Budget
      TFurnitureIndustryBlock) do
      begin
        Beauty := -40;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissFurnitureIndustry, 'Furniture Factory', vidFacility_DissFurnitureIndustry, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 40;
        FacId := FID_FurnitureInd;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFurnitureIndustryConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFurnitureIndustry])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_FurnitureInd;
        MinistryId := nidMinistry_LightIndustry;
        Register( tidClassFamily_Facilities );
      end;
 {$ENDIF}
    // Lumber Mill
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLumberMillConstr,
      50000000,
      [60, 40, 0],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaLumberMillBlock.Create(
      tidBlock_DissLumberMill,
      [0, 2, 20],
      5,            // chemicals (kgs)
      1000,         // max timber prod (kgs/hour)
      1000*6*30*24, // timber total (kgs)
      0,            // min timber (kgs)
      24*30*4,      // 4 Month
      1000,         // budget
      TLumberMillBlock) do
      begin
        VisualStages := 7;
        Beauty := -40;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissLumberMill, 'Lumber Mill', vidFacility_DissLumberMill, TFacility ) do
      begin
        xSize := 8;
        ySize := 8;
        Level := 40;
        FacId := FID_LumberMill;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissLumberMillConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissLumberMill])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_LumberMills;
        MinistryId := nidMinistry_HeavyIndustry;
        Register( tidClassFamily_Facilities );
      end;
{$IFDEF newpack}
 //new buildings
 // organic waste - small
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissorganicwasteSmallConstr,
      cost_organicwasteSmall, // >>
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaorganicwasteBlock.Create(
      tidBlock_DissorganicwasteSmall,
      [input_organicwasteSmall_ExecutivesWorkForce, input_organicwasteSmall_ProfessionalWorkForce, input_organicwasteSmall_Workers],
      input_organicwasteSmall_LegalServices,
      input_organicwasteSmall_ComputerServices,
      //input_organicwasteSmall_Chemicals,
      output_organicwasteSmall_Ore,
      budget_organicwasteSmall,
      TorganicwasteBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissorganicwasteSmall, 'Small Organic waste', vidFacility_DissorganicwasteSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_organicwaste;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissorganicwasteSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissorganicwasteSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_organicwaste;
        Register( tidClassFamily_Facilities );
      end;

    // Organic waste large
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissorganicwasteConstr,
      cost_organicwaste,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaorganicwasteBlock.Create(
      tidBlock_Dissorganicwaste,
      [input_organicwaste_ExecutivesWorkForce, input_organicwaste_ProfessionalWorkForce, input_organicwaste_Workers],
      input_organicwaste_LegalServices,
      input_organicwaste_ComputerServices,
      //input_organicwaste_Chemicals,
      output_organicwaste_Ore,
      budget_organicwaste,
      TorganicwasteBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_Dissorganicwaste, 'Organic Waste Facility', vidFacility_Dissorganicwaste, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_organicwaste;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissorganicwasteConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Dissorganicwaste])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_Largeorganicwaste;
        Register( tidClassFamily_Facilities );
      end;
// Small fert plant
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissfertSmallConstr,
      cost_fertSmall,
      [50, 40, 10],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetafertBlock.Create(
      tidBlock_DissfertSmall,
      [input_fertSmall_ExecutivesWorkForce, input_fertSmall_ProfessionalWorkForce, input_fertSmall_Workers],
      input_fertSmall_LegalServices,
      input_fertSmall_ComputerServices,
      input_fertSmall_Ore,
      output_fertSmall_ore,
      budget_fertSmall,
      TfertBlock ) do
      begin
        Beauty := -60;
        //BeautyStrength := 1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissfertSmall, 'Small fert Plant', vidFacility_DissfertSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 15;
        FacId := FID_fert;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissfertSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The factory is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissfertSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_fert;
        Register( tidClassFamily_Facilities );
      end;

    // fert plant
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissfertConstr,
      cost_fert,
      [50, 40, 10],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetafertBlock.Create(
      tidBlock_Dissfert,
      [input_fert_ExecutivesWorkForce, input_fert_ProfessionalWorkForce, input_fert_Workers],
      input_fert_LegalServices,
      input_fert_ComputerServices,
      input_fert_Ore,
      output_fert_ore,
      budget_fert,
      TfertBlock ) do
      begin
        Beauty := -70;
      //BeautyStrength := 1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_Dissfert, 'Chemical Plant', vidFacility_Dissfert, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 15;
        FacId := FID_fert;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissfertConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Dissfert])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_Largefert;
        Register( tidClassFamily_Facilities );
      end;
  // small grain Farm A wheat and cotton
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissgrainFarmaSmallConstr,
      cost_grainFarmaSmall,
      [80, 20, 0],
      15,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetagrainFarmaBlock.Create(
      tidBlock_DissgrainFarmaSmall,
      [input_grainFarmaSmall_ExecutivesWorkForce, input_grainFarmaSmall_ProfessionalWorkForce, input_grainFarmaSmall_Workers],
      input_grainFarmaSmall_Chemicals,
      0, //input_FarmSmall_LegalServices,
      0, //input_FarmSmall_ComputerServices,
      output_grainFarmaSmall_FreshFood,
      output_grainFarmaSmall_OrganicMaterials,
      budget_grainFarmaSmall,
      TgrainFarmaBlock ) do
      begin
        VisualStages := 2;
        Beauty := -20;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissgrainFarmaSmall, 'Small Farm', vidFacility_DissgrainFarmaSmall, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 20;
        FacId := FID_grainFarma;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissgrainFarmaSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The farm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissgrainFarmaSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisFarms;
        TechnologyKind := tidLicence_grainFarma;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

    // grain Farm A wheat and cotton
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissgrainFarmaConstr,
      cost_grainFarma,
      [80, 15, 5],
      25,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetagrainFarmaBlock.Create(
      tidBlock_DissgrainFarma,
      [input_grainFarma_ExecutivesWorkForce, input_grainFarma_ProfessionalWorkForce, input_grainFarma_Workers],
      input_grainFarma_Chemicals,
      0, //input_Farm_LegalServices,
      0, //input_Farm_ComputerServices,
      output_grainFarma_FreshFood,
      output_grainFarma_OrganicMaterials,
      budget_grainFarma,
      TgrainFarmaBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissgrainFarma, 'Farm', vidFacility_DissgrainFarma, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 20;
        FacId := FID_grainFarma;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissgrainFarmaConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The farm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissgrainFarma])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisFarms;
        TechnologyKind := tidInventionKind_LargegrainFarma;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

  // mill Small
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissmillSmallConstr,
      cost_millsmall,
      [40, 40, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetamillBlock.Create(
      tidBlock_DissmillSmall,
      [input_millsmall_ExecutivesWorkForce, input_millsmall_ProfessionalWorkForce, input_millsmall_Workers],
      input_millsmall_FreshFood,
      input_millsmall_Chemicals,
      input_millsmall_LegalServices,
      input_millsmall_ComputerServices,
      output_millsmall_ProcessedFood,
      budget_millsmall,
      TmillBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissmillSmall, 'Small Mill', vidFacility_DissmillSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_mill;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissmillSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissmillSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_mill;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

    // mill
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissmillConstr,
      cost_mill,
      [40, 40, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetamillBlock.Create(
      tidBlock_Dissmill,
      [input_mill_ExecutivesWorkForce, input_mill_ProfessionalWorkForce, input_mill_Workers],
      input_mill_FreshFood,
      input_mill_Chemicals,
      input_mill_LegalServices,
      input_mill_ComputerServices,
      output_mill_ProcessedFood,
      budget_mill,
      TmillBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
      //BeautyStrength := 1;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Dissmill, 'Mill', vidFacility_Dissmill, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_mill;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissmillConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Dissmill])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_Largemill;
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

  // Small cotton Industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisscottonSmallConstr,
      cost_cottonSmall,
      [45, 40, 15],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetacottonBlock.Create(
      tidBlock_DisscottonSmall,
      [input_cottonSmall_ExecutivesWorkForce, input_cottonSmall_ProfessionalWorkForce, input_cottonSmall_Workers],
      input_cottonSmall_OrganicMaterials,
      //input_cottonSmall_Chemicals,
      input_cottonSmall_ComputerServices,
      input_cottonSmall_LegalServices,
      output_cottonSmall_FabricsandThreads,
      budget_cottonSmall,
      TcottonBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DisscottonSmall, 'Small Textile Industry', vidFacility_DisscottonSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_cotton;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisscottonSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisscottonSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_cotton;
        Register( tidClassFamily_Facilities );
      end;

    // cotton industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisscottonConstr,
      cost_cotton,
      [45, 40, 15],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetacottonBlock.Create(
      tidBlock_Disscotton,
      [input_cotton_ExecutivesWorkForce, input_cotton_ProfessionalWorkForce, input_cotton_Workers],
      input_cotton_OrganicMaterials,
      //input_cotton_Chemicals,
      input_cotton_ComputerServices,
      input_cotton_LegalServices,
      output_cotton_FabricsandThreads,
      budget_cotton,
      TcottonBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Disscotton, 'Textile Industry', vidFacility_Disscotton, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_cotton;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisscottonConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Disscotton])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_Largecotton;
        Register( tidClassFamily_Facilities );
      end;

    // Small trouser industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisstrouserSmallConstr,
      cost_trouserSmall,
      [50, 40, 10],
      25,
      TBlockUnderConstruction) do
      begin
        Register( 'Blocks' );
      end;
    with TMetatrouserBlock.Create(
      tidBlock_DisstrouserSmall,
      [input_trouserSmall_ExecutivesWorkForce, input_trouserSmall_ProfessionalWorkForce, input_trouserSmall_Workers],
      input_trouserSmall_FabricsandThreads,
      input_trouserSmall_OrganicMaterials,
      //input_trouserSmall_Chemicals,
      input_trouserSmall_ComputerServices,
      input_trouserSmall_LegalServices,
      output_trouserSmall_Cheapclothing,
      budget_trouserSmall,
      TtrouserBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DisstrouserSmall, 'Small Clothing Factory', vidFacility_DisstrouserSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_trouser;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisstrouserSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The industry is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisstrouserSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_trouser;
        Register( tidClassFamily_Facilities );
      end;

    // trouser industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisstrouserConstr,
      cost_trouser,
      [50, 40, 10],
      25,
      TBlockUnderConstruction) do
      begin
        Register( 'Blocks' );
      end;
    with TMetatrouserBlock.Create(
      tidBlock_Disstrouser,
      [input_trouser_ExecutivesWorkForce, input_trouser_ProfessionalWorkForce, input_trouser_Workers],
      input_trouser_FabricsandThreads,
      input_trouser_OrganicMaterials,
      //input_Clothing_Chemicals,
      input_trouser_ComputerServices,
      input_trouser_LegalServices,
      output_trouser_Cheapclothing,
      budget_trouser,
      TtrouserBlock ) do
      begin
        Beauty := -20;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Disstrouser, 'Clothing Factory', vidFacility_Disstrouser, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_trouser;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisstrouserConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The industry is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Disstrouser])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_Largetrouser;
        Register( tidClassFamily_Facilities );
      end;
    // iron Mine Small
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissironMineSmallConstr,
      cost_ironMineSmall,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaironMineBlock.Create(
      tidBlock_DissironMineSmall,
      [input_ironMineSmall_ExecutivesWorkForce, input_ironMineSmall_ProfessionalWorkForce, input_ironMineSmall_Workers],
      input_ironMineSmall_LegalServices,
      input_ironMineSmall_ComputerServices,
      input_ironMineSmall_Chemicals,
      output_ironMineSmall_Ore,
      budget_ironMineSmall,
      TironMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissironMineSmall, 'Small Mine', vidFacility_DissironMineSmall, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_ironMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissironMineSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissironMineSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_ironMines;
        Register( tidClassFamily_Facilities );
      end;

    // iron Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissironMineConstr,
      cost_ironMine,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaironMineBlock.Create(
      tidBlock_DissironMine,
      [input_ironMine_ExecutivesWorkForce, input_ironMine_ProfessionalWorkForce, input_ironMine_Workers],
      input_ironMine_LegalServices,
      input_ironMine_ComputerServices,
      input_ironMine_Chemicals,
      output_ironMine_Ore,
      budget_ironMine,
      TironMineBlock ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissironMine, 'Mine', vidFacility_DissironMine, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_ironMine;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissironMineConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissironMine])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeironMines;
        Register( tidClassFamily_Facilities );
      end;
    // Small SiliconMine2
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSiliconMine2SmallConstr,
      cost_SiliconMine2Small, // >>
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaSiliconMine2Block.Create(
      tidBlock_DissSiliconMine2Small,
      [input_SiliconMine2Small_ExecutivesWorkForce, input_SiliconMine2Small_ProfessionalWorkForce, input_SiliconMine2Small_Workers],
      input_SiliconMine2Small_LegalServices,
      input_SiliconMine2Small_ComputerServices,
      input_SiliconMine2Small_Chemicals,
      output_SiliconMine2Small_Ore,
      budget_SiliconMine2Small,
      TSiliconMine2Block ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissSiliconMine2Small, 'Small Silicon Mine', vidFacility_DissSiliconMine2Small, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_SiliconMine2;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMine2SmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMine2Small])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_SiliconMines;
        Register( tidClassFamily_Facilities );
      end;

    // Silicon Mine
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSiliconMine2Constr,
      cost_SiliconMine2,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaSiliconMine2Block.Create(
      tidBlock_DissSiliconMine2,
      [input_SiliconMine2_ExecutivesWorkForce, input_SiliconMine2_ProfessionalWorkForce, input_SiliconMine2_Workers],
      input_SiliconMine2_LegalServices,
      input_SiliconMine2_ComputerServices,
      input_SiliconMine2_Chemicals,
      output_SiliconMine2_Ore,
      budget_SiliconMine2,
      TSiliconMine2Block ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissSiliconMine2, 'Silicon Mine', vidFacility_DissSiliconMine2, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_SiliconMine2;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMine2Constr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSiliconMine2])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeSiliconMines;
        Register( tidClassFamily_Facilities );
      end;
   // Small CoalMine2
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissCoalMine2SmallConstr,
      cost_CoalMine2Small, // >>
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaCoalMine2Block.Create(
      tidBlock_DissCoalMine2Small,
      [input_CoalMine2Small_ExecutivesWorkForce, input_CoalMine2Small_ProfessionalWorkForce, input_CoalMine2Small_Workers],
      input_CoalMine2Small_LegalServices,
      input_CoalMine2Small_ComputerServices,
      input_CoalMine2Small_Chemicals,
      output_CoalMine2Small_Ore,
      budget_CoalMine2Small,
      TCoalMine2Block ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissCoalMine2Small, 'Small Coal Mine', vidFacility_DissCoalMine2Small, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_CoalMine2;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMine2SmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMine2Small])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_CoalMines;
        Register( tidClassFamily_Facilities );
      end;

    // CoalMine2
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissCoalMine2Constr,
      cost_CoalMine2,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaCoalMine2Block.Create(
      tidBlock_DissCoalMine2,
      [input_CoalMine2_ExecutivesWorkForce, input_CoalMine2_ProfessionalWorkForce, input_CoalMine2_Workers],
      input_CoalMine2_LegalServices,
      input_CoalMine2_ComputerServices,
      input_CoalMine2_Chemicals,
      output_CoalMine2_Ore,
      budget_CoalMine2,
      TCoalMine2Block ) do
      begin
        VisualStages := 2;
        Beauty := -100;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissCoalMine2, 'Coal Mine', vidFacility_DissCoalMine2, TFacility ) do
      begin
        xSize := 5;
        ySize := 5;
        Level := 12;
        FacId := FID_CoalMine2;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMine2Constr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The mine is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCoalMine2])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeCoalMines;
        Register( tidClassFamily_Facilities );
      end;
      // Small steel Industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisssteelSmallConstr,
      cost_steelSmall,
      [40, 50, 10],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetasteelIndustryBlock.Create(
      tidBlock_DisssteelSmall,
      [0{input_MetalurgicSmall_ExecutivesWorkForce}, input_steelSmall_ProfessionalWorkForce, input_steelSmall_Workers],
      input_steelSmall_Ore,
      input_steelSmall_LegalServices,
      input_steelSmall_ComputerServices,
      output_steelSmall_Metal,
      budget_steelSmall,
      TsteelIndustryBlock ) do
      begin
        Beauty := -120;
      //BeautyStrength := 1;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DisssteelSmall, 'Small Metal Industry', vidFacility_DisssteelSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_steel;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisssteelSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisssteelSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_steel;
        Register( tidClassFamily_Facilities );
      end;

    // steel industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisssteelConstr,
      cost_steel,
      [40, 50, 10],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetasteelIndustryBlock.Create(
      tidBlock_Disssteel,
      [input_steel_ExecutivesWorkForce, input_steel_ProfessionalWorkForce, input_steel_Workers],
      input_steel_Ore,
      input_steel_LegalServices,
      input_steel_ComputerServices,
      output_steel_Metal,
      budget_steel,
      TsteelIndustryBlock ) do
      begin
        Beauty := -120;
      //BeautyStrength := 1;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Disssteel, 'Metal Industry', vidFacility_Disssteel, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 30;
        FacId := FID_steel;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisssteelConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Disssteel])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_Largesteel;
        Register( tidClassFamily_Facilities );
      end;
   // Small Memory industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMemorySmallConstr,
      cost_MemorySmall,
      [40, 40, 20],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMemoryBlock.Create(
      tidBlock_DissMemorySmall,
      [input_MemorySmall_ExecutivesWorkForce, input_MemorySmall_ProfessionalWorkForce, input_MemorySmall_Workers],
      input_MemorySmall_Metal/2,
      input_MemorySmall_Metal/2,
      input_MemorySmall_Chemicals,
      input_MemorySmall_ComputerServices,
      input_MemorySmall_LegalServices,
      output_MemorySmall_Electroniccomponents,
      budget_MemorySmall,
      TMemoryBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissMemorySmall, 'Small Electronic Industry', vidFacility_DissMemorySmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_Memory;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Electronic materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMemorySmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMemorySmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Memory;
        Register( tidClassFamily_Facilities );
      end;

    // Memory industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMemoryConstr,
      cost_Memory,
      [40, 40, 20],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMemoryBlock.Create(
      tidBlock_DissMemory,
      [input_Memory_ExecutivesWorkForce, input_Memory_ProfessionalWorkForce, input_Memory_Workers],
      input_Memory_Metal/2,
      input_Memory_Metal/2,
      input_Memory_Chemicals,
      input_Memory_ComputerServices,
      input_Memory_LegalServices,
      output_Memory_Electroniccomponents,
      budget_Memory,
      TMemoryBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissMemory, 'Electronic Industry', vidFacility_DissMemory, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_Memory;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Electronic materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMemoryConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMemory])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeMemory;
        Register( tidClassFamily_Facilities );
      end;   
   // Smallcar industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSmallcarConstr,
      cost_Smallcar,
      [40, 45, 15],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaSmallcarBlock.Create(
      tidBlock_DissSmallcar,
      [input_Smallcar_ExecutivesWorkForce, input_Smallcar_ProfessionalWorkForce, input_Smallcar_Workers],
      input_Smallcar_Metal,
      input_Smallcar_FabricsAndThreads,
      input_Smallcar_ElectronicComponents,
      input_Smallcar_Chemicals,
      input_Smallcar_Plastics,
      input_Smallcar_ComputerServices,
      input_Smallcar_LegalServices,
      output_Smallcar_NiceCars,
      budget_Smallcar,
      TSmallcarBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissSmallcar, 'Car Factory', vidFacility_DissSmallcar, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Smallcar;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSmallcarConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSmallcar])));
        ClusterName    := tidClusterName_Dissident;
        FacilityKind   := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Smallcar;
        Register( tidClassFamily_Facilities );
      end;
   // Small Tvs
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTvsSmallConstr,
      cost_TvsSmall,
      [45, 40, 15],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaTvsBlock.Create(
      tidBlock_DissTvsSmall,
      [input_TvsSmall_ExecutivesWorkForce, input_TvsSmall_ProfessionalWorkForce, input_TvsSmall_Workers],
      input_TvsSmall_Metal,
      input_TvsSmall_ElectronicComponents,
      input_TvsSmall_Chemicals,
      input_TvsSmall_Plastics,
      input_TvsSmall_ComputerServices,
      input_TvsSmall_LegalServices,
      output_TvsSmall_HouseHoldingAppliances,
      budget_TvsSmall,
      TTvsBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissTvsSmall, 'Small Appliances Factory', vidFacility_DissTvsSmall, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Tvs;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTvsSmallConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTvsSmall])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_Tvs;
        Register( tidClassFamily_Facilities );
      end;

    // Tvs
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTvsConstr,
      cost_Tvs,
      [45, 40, 15],
      35,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaTvsBlock.Create(
      tidBlock_DissTvs,
      [input_Tvs_ExecutivesWorkForce, input_Tvs_ProfessionalWorkForce, input_Tvs_Workers],
      input_Tvs_Metal,
      input_Tvs_ElectronicComponents,
      input_Tvs_Chemicals,
      input_Tvs_Plastics,
      input_Tvs_ComputerServices,
      input_Tvs_LegalServices,
      output_Tvs_HouseHoldingAppliances,
      budget_Tvs,
      TTvsBlock ) do
      begin
        VisualStages := 2;
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissTvs, 'Appliances Factory', vidFacility_DissTvs, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_Tvs;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTvsConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTvs])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidInventionKind_LargeTvs;
        Register( tidClassFamily_Facilities );
      end;
    // glass industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissglassConstr,
      cost_glass,
      [45, 40, 15],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaglassBlock.Create(
      tidBlock_Dissglass,
      [input_glass_ExecutivesWorkForce, input_glass_ProfessionalWorkForce, input_glass_Workers],
      input_glass_Ore,
      input_glass_LegalServices,
      input_glass_ComputerServices,
      output_glass_Construction,
      budget_glass,
      TglassBlock ) do
      begin
        Beauty := -100;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Dissglass, 'Construction Industry', vidFacility_Dissglass, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_glass;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissglassConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Dissglass])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_glass;
        Register( tidClassFamily_Facilities );
      end;

    // conveybsys industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissconveybsysConstr,
      cost_conveybsys,
      [45, 40, 15],
      45,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaconveybsysBlock.Create(
      tidBlock_Dissconveybsys,
      [input_conveybsys_ExecutivesWorkForce, input_conveybsys_ProfessionalWorkForce, input_conveybsys_Workers],
      input_conveybsys_Metal,
      input_conveybsys_Chemicals,
      input_conveybsys_ElectronicComponents,
      input_conveybsys_ComputerServices,
      input_conveybsys_LegalServices,
      output_conveybsys_Machinery,
      budget_conveybsys,
      TconveybsysBlock ) do
      begin
        Beauty := -100;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Dissconveybsys, 'Machinery Industry', vidFacility_Dissconveybsys, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 20;
        FacId := FID_conveybsys;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissconveybsysConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Dissconveybsys])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_conveybsys;
        Register( tidClassFamily_Facilities );
      end;

   // buscomp
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissbuscompConstr,
      cost_buscomp,
      [40, 40, 20],
      40,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetabuscompBlock.Create(
      tidBlock_Dissbuscomp,
      [input_buscomp_ExecutivesWorkForce, input_buscomp_ProfessionalWorkForce, input_buscomp_Workers],
      input_buscomp_Metal,
      input_buscomp_Chemicals,
      input_buscomp_Plastics,
      input_buscomp_ElectronicComponents,
      input_buscomp_ComputerServices,
      input_buscomp_LegalServices,
      output_buscomp_BusinessMachines,
      budget_buscomp,
      TbuscompBlock ) do
      begin
        Beauty := -40;
      //BeautyStrength := 0.5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Dissbuscomp, 'Business Machines Industry', vidFacility_Dissbuscomp, TFacility ) do
      begin
        xSize := 4;
        ySize := 4;
        Level := 40;
        FacId := FID_buscomp;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires Heavy materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissbuscompConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The building is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Dissbuscomp])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisIndustrialFacilities;
        TechnologyKind := tidLicence_buscomp;
        Register( tidClassFamily_Facilities );
      end;

 {$ENDIF}
  end;

procedure RegisterStores;
  begin
{old buildings}
{$IFDEF oldbuild}
    // Food Store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFoodStoreConstr,
      40000,
      [90, 0, 10],
      15,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFoodStoreBlock.Create(
      tidBlock_DissFoodStore,
      [0, 0, 10],
      70, // people buying per hour
      70, // people buying per hour
      FairPrice,
      [0.6, 0.6, 0.8],
      120,
      TFoodStoreBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissFoodStore, 'Food Store', vidFacility_DissFoodStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_FoodStore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFoodStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The market is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFoodStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        MinistryId := nidMinistry_Agriculture;
        Register( tidClassFamily_Facilities );
      end;

    // Clothes store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissClothesStoreConstr,
      50000,
      [90, 0, 10],
      15,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaClothesShopBlock.Create(
      tidBlock_DissClothesStore,
      [0, 0, 10],
      50,
      FairPrice,
      [0.6, 0.6, 0.7],
      130,
      TClothesShopBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissClothesStore, 'Clothes Store', vidFacility_DissClothesStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_ClotheStore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissClothesStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissClothesStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;

    // HHA store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissHHAStoreConstr,
      50000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaHHAStoreBlock.Create(
      tidBlock_DissHHAStore,
      [0, 1, 10],
      30,
      FairPrice,
      [0.8, 0.8, 0.9],
      100,
      THHAStoreBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissHHAStore, 'Appliances Store', vidFacility_DissHHAStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_HHAStore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHHAStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissHHAStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;

    // Toy store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissToyStoreConstr,
      30000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaToyStoreBlock.Create(
      tidBlock_DissToyStore,
      [0, 1, 10],
      40,
      FairPrice,
      [0.8, 0.8, 0.9],
      100,
      TToyStoreBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissToyStore, 'Toy Store', vidFacility_DissToyStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_ToyStore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissToyStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissToyStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        MinistryId := nidMinistry_LightIndustry;
        Register( tidClassFamily_Facilities );
      end;

    // Car Store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissCarStoreConstr,
      500000,
      [90, 0, 10],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaCarShopBlock.Create(
      tidBlock_DissCarStore,
      [0, 1, 10],
      1/(24*7),
      2/(24*7),
      4,
      FairPrice,
      [0.7, 0.8, 0.9],
      140,
      TCarShopBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissCarStore, 'Car Store', vidFacility_DissCarStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 120;
        FacId := FID_CarStore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCarStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissCarStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;

    // Furniture store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFurnitureStoreConstr,
      3000000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFurnitureStoreBlock.Create(
      tidBlock_DissFurnitureStore,
      [0, 1, 10],
      40,
      FairPrice,
      [0.9, 0.7, 0.5],
      100,
      TFurnitureStoreBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissFurnitureStore, 'Furniture Store', vidFacility_DissFurnitureStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_Furniture;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFurnitureStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFurnitureStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        MinistryId := nidMinistry_LightIndustry;
        Register( tidClassFamily_Facilities );
      end;

    // Book store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissBookStoreConstr,
      2000000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaBookStoreBlock.Create(
      tidBlock_DissBookStore,
      [0, 2, 5],
      60,
      FairPrice,
      [0.7, 0.95, 0.5],
      100,
      TBookStoreBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissBookStore, 'Book Store', vidFacility_DissBookStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_BookStore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissBookStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissBookStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        MinistryId := nidMinistry_HeavyIndustry;
        Register( tidClassFamily_Facilities );
      end;

    // Supermarket A
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSupermarketConstrA,
      1200000,
      [80, 0, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaSuperMarketBlock.Create(
      tidBlock_DissSupermarketA,
      [0, 1, 20],
      2/(24*7),
      1/(24*7),
      52,
      72,
      22,
      12,
      FairPrice,
      [0.9, 0.9, 1],
      200,
      TSuperMarketBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissSupermarketA, 'Big Market', vidFacility_DissSupermarketA, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 20;
        FacId := FID_Supermarket;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketConstrA])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Supermarket is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketA])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_SuperMarkets;
        Register( tidClassFamily_Facilities );
      end;

    // Supermarket B
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSupermarketConstrB,
      500000,
      [80, 0, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaSuperMarketBlock.Create(
      tidBlock_DissSupermarketB,
      [0, 1, 15],
      2/(3*24*7),
      1/(3*24*7),
      30,
      40,
      16,
      10,
      FairPrice,
      [0.7, 0.8, 0.8],
      190,
      TSuperMarketBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissSupermarketB, 'Flea Market', vidFacility_DissSupermarketB, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 20;
        FacId := FID_Supermarket;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketConstrB])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Supermarket is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketB])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_SuperMarkets;
        Register( tidClassFamily_Facilities );
      end;

    // Bar
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissBarConstr,
      150000,
      [90, 0, 10],
      15,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaBarBlock.Create(
      tidBlock_DissBar,
      [0, 0, 15],
      90,
      FairPrice,
      [1, 1, 1],
      120,
      TBarBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissBar, 'Bar', vidFacility_DissBar, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 1000;
        FacId := FID_Bar;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissBarConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Bar is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissBar])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_Bars;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;

    // Funerals
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissFuneralConstr,
      10000000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFuneralBlock.Create(
      tidBlock_DissFuneral,
      [0, 1, 10],
      1,
      FairPrice,
      [0.8, 0.8, 0.8],
      100,
      TFuneralBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissFuneral, 'Funeral Parlor', vidFacility_DissFuneral, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 1000;
        FacId := FID_Funeral;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFuneralConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Funeral is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissFuneral])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_Funerals;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;

    // Restaurant
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissRestaurantConstr,
      300000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaRestaurantBlock.Create(
      tidBlock_DissRestaurant,
      [0, 1, 20],
      60,
      FairPrice,
      [0.7, 0.8, 0.8],
      150,
      TRestaurantBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissRestaurant, 'Restaurant', vidFacility_DissRestaurant, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_Restaurant;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissRestaurantConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Restaurant is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissRestaurant])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_Restaurants;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;

    
{end olf buildingds}
 {$ENDIF} // Movie
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissMovieConstr,
      2500000,
      [100, 0, 0],
      15,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMovieBlock.Create(
      tidBlock_DissMovie,
      [0, 0, 8],
      50,
      FairPrice,
      [0.5, 0.5, 0.7],
      100,
      TMovieBlock,
      1 ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissMovie, 'Movie Theater', vidFacility_DissMovie, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 1000;
        FacId := FID_Movie;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMovieConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Movie is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissMovie])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        //Technology := nidInvention_Movies;
        TechnologyKind := tidInventionKind_MovieTheaters;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;
{new buildings}
 {$IFDEF newpack}
 // Supermarket A
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSupermarketConstrA,
      1200000,
      [80, 0, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMallfood1Block.Create(
      tidBlock_DissSupermarketA,
      [0, 1, 20],
      2/(24*7),
      1/(24*7),
      22,
      220,
      7,
      12,
      FairPrice,
      [0.9, 0.9, 1],
      200,
      TMallfood1Block ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissSupermarketA, 'Big Market', vidFacility_DissSupermarketA, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 20;
        FacId := FID_Supermarket;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketConstrA])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Supermarket is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketA])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_SuperMarkets;
        Register( tidClassFamily_Facilities );
      end;

    // Supermarket B
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSupermarketConstrB,
      500000,
      [80, 0, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMallfood2Block.Create(
      tidBlock_DissSupermarketB,
      [0, 1, 15],
      2/(3*24*7),
      1/(3*24*7),
      10,
      10,
      8,
      5,
      FairPrice,
      [0.7, 0.8, 0.8],
      190,
      TMallfood2Block ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissSupermarketB, 'Flea Market', vidFacility_DissSupermarketB, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 20;
        FacId := FID_Supermarket;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketConstrB])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Supermarket is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSupermarketB])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_SuperMarkets;
        Register( tidClassFamily_Facilities );
      end;
 // Smallcarstore
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissSmallcarstoreConstr,
      500000,
      [90, 0, 10],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaSmallcarstoreBlock.Create(
      tidBlock_DissSmallcarstore,
      [0, 1, 10],
      1/(24*7),
      2/(24*7),
      1,
      FairPrice,
      [0.07, 0.18, 0.5],
      140,
      TSmallcarstoreBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissSmallcarstore, 'Car Store', vidFacility_DissSmallcarstore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 120;
        FacId := FID_Smallcarstore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSmallcarstoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissSmallcarstore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;
 // TVStore
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTVStoreConstr,
      50000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaTVStoreBlock.Create(
      tidBlock_DissTVStore,
      [0, 1, 10],
      8,
      FairPrice,
      [0.8, 0.8, 0.9],
      100,
      TTVStoreBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissTVStore, 'Appliances Store', vidFacility_DissTVStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_TVStore;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTVStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTVStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;
 // trouser store
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DisstrouserStoreConstr,
      500000,
      [90, 0, 10],
      15,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetatrouserShopBlock.Create(
      tidBlock_DisstrouserStore,
      [0, 0, 10],
      20,
      FairPrice,
      [0.6, 0.6, 0.7],
      130,
      TtrouserShopBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Disstrouserstore, 'trouser Store', vidFacility_DisstrouserStore, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_trouserShop;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisstrouserStoreConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Shop is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DisstrouserStore])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_ServiceFacilities;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;

   // bakery
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissbakeryConstr,
      300000,
      [90, 0, 10],
      20,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetabakeryBlock.Create(
      tidBlock_DissBakery,
      [1, 5, 50],
      500,
      FairPrice,
      [0.7, 0.8, 0.8],
      150,
      TbakeryBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_Dissbakery, 'bakery', vidFacility_Dissbakery, TFacility ) do
      begin
        xSize := 1;
        ySize := 1;
        Level := 1000;
        FacId := FID_bakery;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissbakeryConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Restaurant is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_Dissbakery])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisServiceFacilities;
        TechnologyKind := tidInventionKind_bakery;
        DepOnTech := false; // make available even without HQs
        Register( tidClassFamily_Facilities );
      end;
{$ENDIF}
{end new buildings}
  end;

procedure RegisterHeadquarters;
  begin
    // General
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissGeneralHeadquarterConstr,
      5000000,
      [60, 0, 40],
      10,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMainHeadquarter.Create(
      tidBlock_DissGeneralHeadquarter,
      [50, 25, 10],
      tidInventionKind_Direction,
      //nidInvention_DistributedDirection,
      TMainHeadquarter ) do
      begin
        //RegisterInventions([nidInvention_TV]);
        Beauty := 100;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissGeneralHeadquarter, 'Company Headquarters', vidFacility_DissGeneralHeadquarter, TFacility ) do
      begin
        Desc  := '';
        xSize := 4;
        ySize := 4;
        Level := 5000;
        FacId := FID_MainHeadquarter;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissGeneralHeadquarterConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The facility is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidFacility_DissGeneralHeadquarter])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisDistributedDirection;
        Register( tidClassFamily_Facilities );
      end;

    // General Standalone
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissGeneralHeadquarterConstr + 'STA',
      4000000,
      [60, 0, 40],
      10,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaMainHeadquarter.Create(
      tidBlock_DissGeneralHeadquarter + 'STA',
      [15, 7, 1],
      tidInventionKind_Direction,
      TMainHeadquarter ) do
      begin
        Beauty     := 100;
        Standalone := true;
        VisualStages := 5;
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissGeneralHeadquarter + 'STA', 'Company Headquarters', 651, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 5000;
        FacId := FID_MainHeadquarter;
        Options := Options - [mfcGenerateName];
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissGeneralHeadquarterConstr + 'STA'])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The facility is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidFacility_DissGeneralHeadquarter + 'STA'])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisDistributedDirection;
        UniquenessMask := $00000001;
        Register( tidClassFamily_Facilities );
      end;

    // Industries
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissIndHeadquarterConstr,
      2000000,
      [60, 0, 40],
      10,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaHeadquarterBlock.Create(
      tidBlock_DissIndHeadquarter,
      [30, 25, 10],
      tidInventionKind_IndustrialFacilities,
      THeadquarterBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissIndHeadquarter, 'Industry Headquarters', vidFacility_DissIndHeadquarter, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 5000;
        FacId := FID_IndHeadquarter;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissIndHeadquarterConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The facility is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidFacility_DissIndHeadquarter])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisDistributedDirection;
        TechnologyKind := tidInventionKind_Direction;
        Register( tidClassFamily_Facilities );
      end;

    // Markets
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissServiceHeadquarterConstr,
      2000000,
      [60, 0, 40],
      10,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaHeadquarterBlock.Create(
      tidBlock_DissServiceHeadquarter,
      [30, 25, 10],
      tidInventionKind_ServiceFacilities,
      THeadquarterBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissServiceHeadquarter, 'Commerce Headquarters', vidFacility_DissServiceHeadquarter, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 5000;
        FacId := FID_CommHeadquarter;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissServiceHeadquarterConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The facility is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidFacility_DissServiceHeadquarter])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisDistributedDirection;
        TechnologyKind := tidInventionKind_Direction;
        Register( tidClassFamily_Facilities );
      end;

    // Residential Headquarter
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissResHeadquarterConstr,
      2000000,
      [60, 0, 40],
      10,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaHeadquarterBlock.Create(
      tidBlock_DissResHeadquarter,
      [33, 7, 12],
      tidInventionKind_OfficeAndResidentials,
      THeadquarterBlock ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissResHeadquarter, 'Real Estates Headquarters', vidFacility_DissResHeadquarter, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 5000;
        FacId := FID_OffcHeadquarter;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissResHeadquarterConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The facility is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidFacility_DissResHeadquarter])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisDistributedDirection;
        TechnologyKind := tidInventionKind_Direction;
        Register( tidClassFamily_Facilities );
      end;

    // Public Facilities
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissPubHeadquarterConstr,
      2000000,
      [60, 0, 40],
      10,
      TBlockUnderConstruction ) do
      begin
        Register( 'Blocks' );
      end;
    with TMetaPublicAffairsHeadquarter.Create(
      tidBlock_DissPubHeadquarter,
      [33, 7, 12],
      tidInventionKind_PublicFacilities,
      //nidInvention_PublicFacilities,
      maxHQAdv,
      TPublicAffairsHeadquarter ) do
      begin
        //RegisterInvention( nidInvention_Monuments );
        Register( 'Blocks' );
      end;
    with TMetaFacility.Create( tidFacility_DissPubHeadquarter, 'Civic Affairs Headquarters', vidFacility_DissPubHeadquarter, TFacility ) do
      begin
        XSize := 2;
        YSize := 2;
        Level := 5000;
        FacId := FID_PubHeadquarter;
        Options := Options - [mfcGenerateName, mfcInTown];
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'RequiPub construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissPubHeadquarterConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The facility is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidFacility_DissPubHeadquarter])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisDistributedDirection;
        //Technology := nidInvention_DistributedDirection;
        TechnologyKind := tidInventionKind_Direction;
        Register( tidClassFamily_Facilities );
      end;
  end;

procedure RegisterSpecialFacilities;
  begin
    // Computing Industry
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissComputingIndustryConstr,
      cost_ComputingIndustry,
      [70, 0, 30],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaSoftwareBlock.Create(
      tidBlock_DissComputingIndustry,
      [input_ComputingIndustry_ExecutivesWorkForce, input_ComputingIndustry_ProfessionalWorkForce, input_ComputingIndustry_Workers],
      input_ComputingIndustry_LegalServices,
      output_ComputingIndustry_ComputerServices,
      budget_ComputingIndustry,
      TSoftwareBlock ) do
      begin
        Beauty := 100;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissComputingIndustry, 'Software Firm', vidFacility_DissComputingIndustry, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 40;
        FacId := FID_SoftwareFirm;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissComputingIndustryConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Computing Industry is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissComputingIndustry])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisBusinessFacilities;
        //Technology := nidInvention_SoftwareFirms;
        TechnologyKind := tidInventionKind_Software;
        Register( tidClassFamily_Facilities );
      end;

    // Legal Services
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissLegalServicesConstr,
      cost_LegalServices,
      [80, 0, 20],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaLegalServiceBlock.Create(
      tidBlock_DissLegalServices,
      [input_LegalServices_ExecutivesWorkForce, input_LegalServices_ProfessionalWorkForce, input_LegalServices_Workers],
      input_LegalServices_ComputerServices,
      output_LegalServices_LegalServices,
      budget_LegalServices,
      TSoftwareBlock ) do
      begin
        Beauty := 100;
      //BeautyStrength := 0.1;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissLegalServices, 'Lawyers Firm', vidFacility_DissLegalServices, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 40;
        FacId := FID_LawyerFirm;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissLegalServicesConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Firm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissLegalServices])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisBusinessFacilities;
        //Technology := nidInvention_LegalServices;
        TechnologyKind := tidInventionKind_LegalServices;
        Register( tidClassFamily_Facilities );
      end;
  end;

procedure RegisterSpecial;
  begin
    // TV Station
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTVStationConstr,
      30000000,
      [70, 0, 30],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaBroadcaster.Create(
      tidBlock_DissTVStation,
      tidBroadcast_TV,
      200,
      [5, 50, 35],
      accIdx_TV_Supplies,
      accIdx_TV_Products,
      accIdx_TV_Salaries,
      TBroadcaster ) do
      begin
        Beauty := 200;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissTVStation, 'TV', vidFacility_DissTVStation, TFacility ) do
      begin
        xSize := 3;
        ySize := 3;
        Level := 60;
        FacId := FID_TVStation;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTVStationConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Firm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTVStation])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisSpecial;
        //Technology := nidInvention_TV;
        TechnologyKind := tidInventionKind_Television;
        Register( tidClassFamily_Facilities );
      end;

    // TV Antenna
    with TMetaBlockUnderConstruction.Create(
      tidBlock_DissTVAntennaConstr,
      500000,
      [90, 0, 10],
      30,
      TBlockUnderConstruction ) do
      begin
        Register( tidClassFamily_Blocks );
      end;
    with TMetaAntenna.Create(
      tidBlock_DissTVAntenna,
      [0, 0, 4],
      accIdx_TV_Supplies,
      accIdx_TV_Products,
      accIdx_TV_Salaries,
      TAntenna ) do
      begin
        BroadcastId := tidBroadcast_TV;
        Beauty      := -100;
        Power       := 50;
        Register( tidClassFamily_Blocks );
      end;
    with TMetaFacility.Create( tidFacility_DissTVAntenna, 'TV Antenna', vidFacility_DissTVAntenna, TFacility ) do
      begin
        xSize := 2;
        ySize := 2;
        Level := 50;
        FacId := FID_TVAntena;
        EvlStages.Insert( TEvlStage.Create( 'Construction', 'Under Construction', 'Requires construction materials to advance to the next stage.', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTVAntennaConstr])));
        EvlStages.Insert( TEvlStage.Create( 'Complete', 'Completed', 'The Firm is ready to operate', TMetaBlock(TheClassStorage.ClassById['Blocks', tidBlock_DissTVAntenna])));
        ClusterName := tidClusterName_Dissident;
        FacilityKind := tidFacilityKind_DisSpecial;
        //Technology := nidInvention_TV;
        TechnologyKind := tidInventionKind_Television;
        Register( tidClassFamily_Facilities );
      end;
  end;

procedure RegisterPackFacilities;
  begin
    RegisterHeadquarters;
    RegisterIndustries;
    RegisterStores;
    RegisterResidentials;
    RegisterPublicFacilities;
    RegisterSpecialFacilities;
    RegisterOffices;
    RegisterSpecial;
  end;

function ModelExtensionId : string; export;
  begin
    result := 'DissidentPack1';
  end;

function GetDependances : string; export;
  begin
    result := 'GeneralPack1';
  end;

procedure RegisterModelExtension; export;
  begin
    SimMLS.LoadMLS;
    InitVisualClasses;
    RegisterFacilityKinds;
    RegisterClusterFacilities;
    RegisterInventions;
    RegisterPackFacilities;
  end;

procedure PostRegisterModelExtension; export;
  begin
    ModelServerCache.EnabledLogs := true;
  end;

exports
  ModelExtensionId,
  GetDependances,
  RegisterModelExtension,
  PostRegisterModelExtension;

{$E mdx}

begin
end.



