unit StdFluids;

interface

  const
    tidFluid_ConstructionForce      = 'Construction';
    tidFluid_Machinery              = 'Machinery';
    tidFluid_BusinessMachines       = 'BusinessMachines';
    tidFluid_LegalServ              = 'LegalServ';
    tidFluid_CompServ               = 'CompServ';
    tidFluid_Films                  = 'Films';
    tidFluid_Advertisement          = 'Advertisement';

    tidFluid_FreshFood              = 'FreshFood';
    tidFluid_OrganicMat             = 'OrganicMat';
    tidFluid_Chemicals              = 'Chemicals';
    tidFluid_Ore                    = 'Ore';
    tidFluid_OreChems               = 'OreChems';
    tidFluid_OreSilicon             = 'OreSilicon';
    tidFluid_OreStone               = 'OreStone';
    tidFluid_OreCoal                = 'OreCoal';
    tidFluid_ElabFood               = 'ElabFood';
    tidFluid_Metals                 = 'Metals';
    tidFluid_Plastics               = 'Plastics';
    tidFluid_Drugs                  = 'Drugs';
    tidFluid_ElectComp              = 'ElectComp';
    tidFluid_Cars                   = 'Cars';
    tidFluid_FabThreads             = 'FabricThreads';
    tidFluid_Clothes                = 'Clothes';
    tidFluid_HouseHoldingAppliances = 'HouseHoldingAppliances';
    tidFluid_Toys                   = 'Toys';
    tidFluid_Oil                    = 'Oil';
    tidFluid_Gasoline               = 'Gasoline';
    tidFluid_Liquors                = 'Liquors';
    
    tidFluid_Timber                 = 'Timber';
    tidFluid_Furniture              = 'Furniture';
    tidFluid_Books                  = 'Books';
    tidFluid_Paper                  = 'Paper';
    tidFluid_CDs                    = 'CDs';
    tidFluid_PrintedMaterial        = 'PrintedMaterial';

    tidFluid_Manure                 = 'Manure';
    tidFluid_Fert             = 'Fertilizer';
    tidFluid_Wheat                  = 'Wheatgrain';
    tidFluid_Cottonmat                 = 'cottonmat';
    tidFluid_Flour                  = 'Flour';
    tidFluid_Cottonsheet            = 'CottonSheet';
    tidFluid_trouser                = 'trouser';//lastadded
    tidFluid_apples                 = 'apples';
    tidFluid_oranges                 = 'oranges';
    tidFluid_rubbertree                 = 'rubbertree';
    tidFluid_rubbersap                 = 'rubbersap';
    tidFluid_rubber                 = 'rubbermat';
    tidFluid_fruitpie                 = 'fruitpie';
    tidFluid_shoes                 = 'shoes';
    tidFluid_carrots                 = 'carrots';
    tidFluid_potatoes                 = 'potatoes';
    tidFluid_stew                 = 'stew';
    tidFluid_organicchems                 = 'orgaincchems';
    tidFluid_polymers                 = 'polymers';
    tidFluid_nylon                 = 'nylon';
    tidFluid_shirts                 = 'shirts';
    tidFluid_beef                 = 'beef';
    tidFluid_leather                 = 'leathermat';
    tidFluid_burgers                 = 'burgers';
    tidFluid_rawchem                 = 'rawchem';
    tidFluid_miningchem                 = 'miningchem';
    tidFluid_leathersheet                 = 'leathersheet';
    tidFluid_leatherjacket                 = 'leatherjacket';   //1
    tidFluid_ironore                 = 'ironore';
    tidFluid_coal                 = 'coal';
    tidFluid_steel                 = 'steel';
    tidFluid_silicon                 = 'silicon';
    tidFluid_memory                 = 'memory';
    tidFluid_smallcar                 = 'smallcar';
    tidFluid_copperore                 = 'copperore';
    tidFluid_ceramicore                 = 'ceramicore';
    tidFluid_pineoil                 = 'pineoil';
    tidFluid_copper                 = 'coppermetal';
    tidFluid_cpu                 = 'cpu';
    tidFluid_sportscar                 = 'sportscar';
    tidFluid_pc                 = 'pc';
    tidFluid_alore                 = 'alore';
    tidFluid_silane                 = 'silane';
    tidFluid_almetal                 = 'almetal';
    tidFluid_cryolite                 = 'cryolite';
    tidFluid_tft                 = 'tft';
    tidFluid_motorbike                 = 'motorbike';
    tidFluid_mphone                 = 'mphone';
    tidFluid_tires                 = 'tires';
    tidFluid_engine                 = 'engine';
    tidFluid_tv                 = 'tv';
    tidFluid_humvee                 = 'humvee';
    tidFluid_glass                 = 'glass';
    tidFluid_cooker                 = 'cooker';
    //x
    tidFluid_concrete                 = 'concrete';
    tidFluid_plasterboard                 = 'plasterboard';
    tidFluid_roboticsys                 = 'roboticsys';
    tidFluid_controlsys                 = 'controlsys';
    tidFluid_conveyersys                 = 'conveyersys';
    tidFluid_networksys                 = 'networksys';
    tidFluid_bcomp                 = 'bcomp';
    tidFluid_servers                 = 'servers';
    tidFluid_gypsum                 = 'gypsum';
    tidFluid_limestone                 = 'limestone';
    tidFluid_gravel                 = 'gravel';



  const
    unid_None          = 0;
    unid_Advertisement = 1;
    unid_CompServ      = 2;
    unid_LegalServ     = 3;

  const
    tidGate_ConstructionForce      = tidFluid_ConstructionForce;
    tidGate_Machinery              = tidFluid_Machinery;
    tidGate_BusinessMachines       = tidFluid_BusinessMachines;
    tidGate_LegalServ              = tidFluid_LegalServ;
    tidGate_CompServ               = tidFluid_CompServ;
    tidGate_Films                  = tidFluid_Films;
    tidGate_Advertisement          = tidFluid_Advertisement;

    tidGate_FreshFood              = tidFluid_FreshFood;
    tidGate_OrganicMat             = tidFluid_OrganicMat;
    tidGate_Chemicals              = tidFluid_Chemicals;
    tidGate_Ore                    = tidFluid_Ore;
    tidGate_ElabFood               = tidFluid_ElabFood;
    tidGate_Metals                 = tidFluid_Metals;
    tidGate_Plastics               = tidFluid_Plastics;
    tidGate_Gasoline               = tidFluid_Gasoline;
    tidGate_Oil                    = tidFluid_Oil;
    tidGate_OreChems               = tidFluid_OreChems;
    tidGate_OreSilicon             = tidFluid_OreSilicon;
    tidGate_OreStone               = tidFluid_OreStone;
    tidGate_OreCoal                = tidFluid_OreCoal;
    tidGate_Drugs                  = tidFluid_Drugs;
    tidGate_ElectComp              = tidFluid_ElectComp;
    tidGate_Cars                   = tidFluid_Cars;
    tidGate_FabThreads             = tidFluid_FabThreads;
    tidGate_Clothes                = tidFluid_Clothes;
    tidGate_HouseHoldingAppliances = tidFluid_HouseHoldingAppliances;
    tidGate_Toys                   = tidFluid_Toys;
    tidGate_Liquors                = tidFluid_Liquors;
    tidGate_Timber                 = tidFluid_Timber;
    tidGate_Furniture              = tidFluid_Furniture;
    tidGate_Books                  = tidFluid_Books;
    tidGate_Paper                  = tidFluid_Paper;
    tidGate_CDs                    = tidFluid_CDs;
    tidGate_PrintedMaterial        = tidFluid_PrintedMaterial;
    tidGate_Manure                 = tidFluid_Manure;  //start new goods

    tidGate_Fert             = tidFluid_Fert;
    tidGate_Wheat                  = tidFluid_Wheat;
    tidGate_Cottonmat                 = tidFluid_Cottonmat;
    tidGate_Flour                  = tidFluid_Flour;
    tidGate_Cottonsheet            = tidFluid_Cottonsheet;
    tidGate_trouser                = tidFluid_trouser; //last added
    tidGate_apples                = tidFluid_apples;
    tidGate_oranges                = tidFluid_oranges;
    tidGate_rubbertree                = tidFluid_rubbertree;
    tidGate_rubbersap                = tidFluid_rubbersap;
    tidGate_rubber                = tidFluid_rubber;
    tidGate_fruitpie                = tidFluid_fruitpie;
    tidGate_shoes                = tidFluid_shoes;
    tidGate_carrots                = tidFluid_carrots;
    tidGate_potatoes                = tidFluid_potatoes;
    tidGate_stew                = tidFluid_stew;
    tidGate_organicchems                = tidFluid_organicchems;
    tidGate_polymers                = tidFluid_polymers;
    tidGate_nylon                = tidFluid_nylon;
    tidGate_shirts                = tidFluid_shirts;
    tidGate_beef                = tidFluid_beef;
    tidGate_leather                = tidFluid_leather;
    tidGate_burgers                = tidFluid_burgers;
    tidGate_rawchem                = tidFluid_rawchem;
    tidGate_miningchem                = tidFluid_miningchem;
    tidGate_leathersheet                = tidFluid_leathersheet;
    tidGate_leatherjacket                = tidFluid_leatherjacket;//1
    tidGate_ironore        = tidFluid_ironore;
    tidGate_coal        = tidFluid_coal;
    tidGate_steel        = tidFluid_steel;
    tidGate_silicon        = tidFluid_silicon;
    tidGate_memory         =tidFluid_memory;
    tidGate_smallcar         =tidFluid_smallcar;
    tidGate_copperore         =tidFluid_copperore;
    tidGate_ceramicore         =tidFluid_ceramicore;
    tidGate_pineoil         =tidFluid_pineoil;
    tidGate_copper         =tidFluid_copper;
    tidGate_cpu         =tidFluid_cpu;
    tidGate_sportscar         =tidFluid_sportscar;
    tidGate_pc         =tidFluid_pc;
    tidGate_alore         =tidFluid_alore;
    tidGate_silane         =tidFluid_silane;
    tidGate_almetal        = tidFluid_almetal;
    tidGate_cryolite        = tidFluid_cryolite;
    tidGate_tft         =tidFluid_tft;
    tidGate_motorbike         =tidFluid_motorbike;
    tidGate_mphone         =tidFluid_mphone;
    tidGate_tires         =tidFluid_tires;
    tidGate_engine         =tidFluid_engine;
    tidGate_tv         =tidFluid_tv;
    tidGate_humvee         =tidFluid_humvee;
    tidGate_glass         =tidFluid_glass;
    tidGate_cooker         =tidFluid_cooker;
    tidGate_concrete         =tidFluid_concrete;
    tidGate_plasterboard         =tidFluid_plasterboard;
    tidGate_roboticsys         =tidFluid_roboticsys;
    tidGate_controlsys         =tidFluid_controlsys;
    tidGate_conveyersys         =tidFluid_conveyersys;
    tidGate_networksys         =tidFluid_networksys;
    tidGate_bcomp         =tidFluid_bcomp;
    tidGate_servers         =tidFluid_servers;
    tidGate_gypsum         =tidFluid_gypsum;
    tidGate_limestone         =tidFluid_limestone;
    tidGate_gravel         =tidFluid_gravel;

  procedure RegisterMetaFluids;

implementation

  uses
    Kernel, MediaGates,logs;

  // RegisterMetaFluids

  procedure RegisterMetaFluids;
    begin
   {$IFDEF newpack}     //    cooker
    with TMetaFluid.Create(
        tidFluid_concrete,     // id of the fluid
        'concrete',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        500 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_plasterboard ,     // id of the fluid
        'plasterboard ',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        70 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_roboticsys,     // id of the fluid
        'roboticsys',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        6000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_controlsys,     // id of the fluid
        'controlsys',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        2000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_conveyersys,     // id of the fluid
        'conveyersys',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        3000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_networksys,     // id of the fluid
        'networksys',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_bcomp,     // id of the fluid
        'bcomp',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        3500 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_servers,     // id of the fluid
        'servers',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        7000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_gypsum,     // id of the fluid
        'gypsum',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_limestone,     // id of the fluid
        'limestone',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_gravel,     // id of the fluid
        'gravel',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
   with TMetaFluid.Create(
        tidFluid_cooker,     // id of the fluid
        'cooker',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        500 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
   with TMetaFluid.Create(
        tidFluid_glass,     // id of the fluid
        'glass',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        30 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_humvee,     // id of the fluid
        'humvee',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        9000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_ironore,     // id of the fluid
        'ironore',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_coal,     // id of the fluid
        'coal',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_steel,     // id of the fluid
        'steel',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        50 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_silicon,     // id of the fluid
        'silicon',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_memory ,     // id of the fluid
        'memory',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        75 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_smallcar,     // id of the fluid
        'smallcar',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        4000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_copperore,     // id of the fluid
        'copperore',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_ceramicore,     // id of the fluid
        'ceramicore',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_pineoil,     // id of the fluid
        'pineoil',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        2 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_copper,     // id of the fluid
        'coppermetal',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        30 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_cpu,     // id of the fluid
        'cpu',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        250 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_sportscar,     // id of the fluid
        'sportscar',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        15000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_pc,     // id of the fluid
        'pc',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        750 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_alore,     // id of the fluid
        'alore',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_silane,     // id of the fluid
        'silane',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_almetal,     // id of the fluid
        'almetal',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        45 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_cryolite,     // id of the fluid
        'cryolite',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_tft,     // id of the fluid
        'tft',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        125 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_motorbike,     // id of the fluid
        'motorbike',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        3000 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_mphone,     // id of the fluid
        'mphone',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        72 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_tires,     // id of the fluid
        'tires',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        35 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_engine,     // id of the fluid
        'engine',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        500 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_tv,     // id of the fluid
        'tv',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        250 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
        tidFluid_leatherjacket,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        50 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_leathersheet,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        30 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_miningchem,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        10 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_rawchem,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        4 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_burgers,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_leather,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        2 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;




     with TMetaFluid.Create(
        tidFluid_beef,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        15 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_shirts,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        50 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_nylon,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        25 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_polymers,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        10 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_organicchems,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        3 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_stew,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        4 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
                     

    with TMetaFluid.Create(
        tidFluid_potatoes,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_carrots,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_shoes,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        50 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
       tidFluid_fruitpie,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        4 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
       tidFluid_rubber,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        40 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_rubbersap,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        15 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
        tidFluid_rubbertree,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        50 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
     with TMetaFluid.Create(
       tidFluid_oranges,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;
    with TMetaFluid.Create(
       tidFluid_apples,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;

     //last
      with TMetaFluid.Create(
        tidFluid_trouser,     // id of the fluid
        'trouser',           // name
        'these lovely trousers will keep you warm in the winter',    // desc
        'item',                         // unit nme
        'items/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        50 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;

      with TMetaFluid.Create(
        tidFluid_Cottonsheet,     // id of the fluid
        'Cotton Sheets',           // name
        'Raw cotton is woven into sheets which are cut up for clothing',    // desc
        'Meters',                         // unit nme
        'Meters/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        20 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;

      with TMetaFluid.Create(
        tidFluid_Flour,     // id of the fluid
        'Flour',           // name
        'Flour is ground wheat, use for baking',    // desc
        'kg',                         // unit nme
        'kg/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        8 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;

      with TMetaFluid.Create(
        tidFluid_Cottonmat,     // id of the fluid
        'Raw Cotton',           // name
        'Cotton is grown on farms and woven',    // desc
        'kg',                         // unit nme
        'kg/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        7,                          // ??
        10 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;

     with TMetaFluid.Create(
        tidFluid_Wheat,     // id of the fluid
        'Wheat',           // name
        'The basic of all grains for basic foods',    // desc
        'kg',                         // unit nme
        'kg/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        7 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;

      with TMetaFluid.Create(
        tidFluid_Fert,     // id of the fluid
        'Fertilizer',           // name
        'Manure is processed into fertilizer here which is easier for farmers to use',    // desc
        'kg',                         // unit nme
        'kg/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        5 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;

      with TMetaFluid.Create(
        tidFluid_Manure,     // id of the fluid
        'Manure',           // name
        'Organic waste from the population is collected here and processed',    // desc
        'kg',                         // unit nme
        'kg/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.00005,                       // transp cost
        700,                          // ??
        1 ) do                       // unit cost
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 100000;
          Register( 'Fluids' );
        end;
     {$ENDIF}
    //previous stuff
      with TMetaFluid.Create(
        tidFluid_ConstructionForce,
        'Construction Force',
        'Construction Force',
        'tons',
        'tons/day',
        24,
        0.001,
        1000,
        100 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfConstruction];
          StorageVol := 500000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Machinery,
        'Machinery',
        'Machinery',
        'machines',
        'machines/day',
        24,
        0.0005,
        400,
        8000 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfConstruction];
          StorageVol := 5000;
          Register( 'Fluids' );
        end;
       with TMetaFluid.Create(
        tidFluid_BusinessMachines,
        'Business Machines',
        'Business machines such as computers, printers, photocopiers, ect.',
        'items',
        'items/day',
        24,
        0.001,
        4,
        800 ) do
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable, mfConstruction];
          StorageVol := 10000;
          Register( 'Fluids' );
        end;
       with TMetaFluid.Create(
        tidFluid_LegalServ,
        'Legal Services',
        'Legal counceling services. This will make a facility more competitive.',
        'hours',
        'hours/week',
        7*24,
        0.0001,
        80,
        250 ) do
        begin
          Options  := Options + [mfTradeable, mfCompanyFluid, mfImportable];
          UNId     := unid_LegalServ;
          CnxLimit := 5000;
          StorageVol := 0;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_CompServ,
        'Computer Services',
        'Information management, process automatization.',
        'hours',
        'hours/week',
        7*24,
        0.0001,
        80,
        200 ) do
        begin
          Options  := Options + [mfTradeable, mfCompanyFluid, mfImportable];
          UNId     := unid_CompServ;
          CnxLimit := 5000;
          StorageVol := 0;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Plastics,
        'Plastics',
        'All kind of Plastics ready for industrial applications.',
        'kg',
        'kg/day',
        24,
        0.0001,
        1,
        5 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 20000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Oil,
        'Crude Oil',
        'Oil.',
        'lt',
        'lt/day',
        24,
        0.0002,
        10,
        0.2 ) do
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 100000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Gasoline,
        'Gasoline',
        'Gasoline.',
        'lt',
        'lt/day',
        24,
        0.0002,
        10,
        0.7 ) do
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 100000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Timber,
        'Timber',
        'Any kind of timber',
        'kg',
        'kg/day',
        24,
        0.0005,
        700,
        2 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 500000;
          Register( 'Fluids' );
        end;
      {$ifdef oldbuild}
      logs.log('general','reg old goods for retro');
      with TMetaFluid.Create(
        tidFluid_FreshFood,
        'Fresh Food',
        'Fresh food is produced mainly by farms. It englobes vegetables, grains and meat.',
        'kg',
        'kg/day',
        24,
        0.0008,
        1,
        4 ) do
        begin
          Options := Options + [mfStorable, mfTradeable];
          StorageVol := 5000000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_OrganicMat,
        'Organic Materials',
        'Vegetal fibers and other subproducts of farms.',
        'kg',
        'kg/day',
        24,
        0.0002,
        1,
        10 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 1000000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Chemicals,
        'Chemicals',
        'All kind of chemical products.',
        'kg',
        'kg/day',
        24,
        0.0005,
        1,
        20 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 100000;
          Register( 'Fluids' );
        end;
      
      with TMetaFluid.Create(
        tidFluid_Ore,
        'Ore',
        'All kind of mineral products not ready yet for industrials applications.',
        'kg',
        'kg/day',
        24,
        0.0005,
        1,
        1 ) do
        begin
          Options := Options + [mfImportable, mfTradeable];
          StorageVol := 100000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_OreChems,
        'Raw Chemicals',
        'Raw chemicals. Have to be processed to obtain usable chemical products.',
        'kg',
        'kg/day',
        24,
        0.0005,
        1,
        1 ) do
        begin
          Options := Options + [mfImportable, mfTradeable];
          StorageVol := 100000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_OreSilicon,
        'Silicon',
        'Silicon used at electronic component factories.',
        'kg',
        'kg/day',
        24,
        0.0005,
        1,
        1 ) do
        begin
          Options := Options + [mfImportable, mfTradeable];
          StorageVol := 200000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_OreStone,
        'Stone',
        'Stone is used to produce construction materials.',
        'kg',
        'kg/day',
        24,
        0.0005,
        1,
        1 ) do
        begin
          Options := Options + [mfImportable, mfTradeable];
          StorageVol := 200000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_OreCoal,
        'Coal',
        'Coal is required by metal plants.',
        'kg',
        'kg/day',
        24,
        0.0005,
        1,
        1 ) do
        begin
          Options := Options + [mfImportable, mfTradeable];
          StorageVol := 200000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_ElabFood,
        'Processed Food',
        'All kind of elaborated food ready for consuming.',
        'items',
        'items/day',
        24,
        0.0001,
        1,
        15 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Metals,
        'Metals',
        'All kind of metals ready for industrial applications.',
        'kg',
        'kg/day',
        24,
        0.0005,
        1,
        8 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;

      with TMetaFluid.Create(
        tidFluid_Drugs,
        'Pharmaceutics',
        'Pharmaceutics.',
        'kg',
        'kg/day',
        24,
        0.0004,
        1,
        40 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 10000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_ElectComp,
        'Electronic Components',
        'All kind of metals ready for industrial applications.',
        'items',
        'items/day',
        24,
        0.0002,
        1,
        50 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 10000;
          Register( 'Fluids' );
        end;

      with TMetaFluid.Create(
        tidFluid_HouseHoldingAppliances,
        'Household appliances',
        'Any domestic device, refrigerators, washing machines, air conditioners, etc.',
        'items',
        'items/day',
        24,
        0.0005,
        10,
        110 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 10000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Toys,
        'Toys',
        'Toys.',
        'items',
        'items/day',
        24,
        0.0005,
        10,
        32 ) do
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 10000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Cars,
        'Cars',
        'Cars.',
        'cars',
        'cars/week',
        24*7,
        0.001, // ??????
        800,
        7000 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 200;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_FabThreads,
        'Fabrics and Threads',
        'Fabric and thread ready for looming.',
        'meters',
        'meters/day',
        24,
        0.0002,
        2,
        6 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 10000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Clothes,
        'Clothes',
        'Stuff to wear on.',
        'items',
        'items/day',
        24,
        0.0001,
        1,
        25 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 10000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Liquors,
        'Liquors',
        'Any kind of booze',
        'items',
        'items/day',
        24,
        0.0002,
        1,
        5 ) do
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 2500000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Furniture,
        'Furniture',
        'Furniture for home',
        'items',
        'items/day',
        24,
        0.0005,
        700,
        100 ) do
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 15000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Books,
        'Books',
        'Books in general',
        'books',
        'books/day',
        24,
        0.0001,
        700,
        15 ) do
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 20000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Paper,     // id of the fluid
        'Paper',            // name
        'Paper in general', // desc
        'kg',               // unit nme
        'kg/day',           // fluid name/time
        24,                 // number of hours the above means
        0.0005,             // transp cost
        700,                // ??
        15 ) do             // unit cost
        begin
          Options := Options + [mfTradeable, mfImportable, mfStorable];
          StorageVol := 250000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_CDs,          // id of the fluid
        'Compact Discs',       // name
        'Music Compact Discs', // desc
        'CD',                  // unit nme
        'CD/day',              // fluid name/time
        24,                    // number of hours the above means
        0.0001,                // transp cost
        700,                   // ??
        15 ) do                // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_PrintedMaterial,     // id of the fluid
        'Printed Material',           // name
        'Brochures, Flyers, etc.',    // desc
        'kg',                         // unit nme
        'kg/day',                     // fluid name/time
        24,                           // number of hours the above means
        0.0005,                       // transp cost
        700,                          // ??
        25 ) do                       // unit cost
        begin
          Options := Options + [mfTradeable, mfStorable, mfImportable];
          StorageVol := 25000;
          Register( 'Fluids' );
        end;
      {$endif}
      with TMetaFluid.Create(
        tidFluid_Advertisement,
        'Advertisement',
        'Advertisement',
        'hits',
        'hits/day',
        24,
        0,
        0,
        0.5 ) do
        begin
          Options  := Options + [mfTradeable, mfImportable, mfCompanyFluid];
          UNId     := unid_Advertisement;
          CnxLimit := 5000;
          StorageVol := 0;
          Register( 'Fluids' );
        end;
      with TMetaFluid.Create(
        tidFluid_Films,
        'Films',
        'Movies',
        'Films',
        'Films/day',
        1, // 24
        0.00002,
        1,
        50) do
        begin
          Options  := Options + [mfTradeable, mfStorable, mfImportable];
          CnxLimit := 5000;
          StorageVol := 0;
          Register( 'Fluids' );
        end;
    end;

end.

