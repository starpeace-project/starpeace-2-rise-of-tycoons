unit StdAccounts;

interface

  // Industries account Ids
  const
    // Farms
    accIdx_Farms             = 100;
    accIdx_Farms_Supplies    = 101;
    accIdx_Farms_Products    = 102;
    accIdx_Farms_Salaries    = 103;
    accIdx_Farms_Maintenance = 104;

    // BusinessMachines
    accIdx_BusinessMachines             = 110;
    accIdx_BusinessMachines_Supplies    = 111;
    accIdx_BusinessMachines_Products    = 112;
    accIdx_BusinessMachines_Salaries    = 113;
    accIdx_BusinessMachines_Maintenance = 114;

    // CarIndustry
    accIdx_CarIndustry             = 120;
    accIdx_CarIndustry_Supplies    = 121;
    accIdx_CarIndustry_Products    = 122;
    accIdx_CarIndustry_Salaries    = 123;
    accIdx_CarIndustry_Maintenance = 124;

    // Chemical
    accIdx_Chemical             = 130;
    accIdx_Chemical_Supplies    = 131;
    accIdx_Chemical_Products    = 132;
    accIdx_Chemical_Salaries    = 133;
    accIdx_Chemical_Maintenance = 134;

    // ClotheIndustry
    accIdx_ClotheIndustry             = 140;
    accIdx_ClotheIndustry_Supplies    = 141;
    accIdx_ClotheIndustry_Products    = 142;
    accIdx_ClotheIndustry_Salaries    = 143;
    accIdx_ClotheIndustry_Maintenance = 144;

    // ConstIndustry
    accIdx_ConstIndustry             = 150;
    accIdx_ConstIndustry_Supplies    = 151;
    accIdx_ConstIndustry_Products    = 152;
    accIdx_ConstIndustry_Salaries    = 153;
    accIdx_ConstIndustry_Maintenance = 154;

    // ElectIndustry
    accIdx_ElectIndustry             = 160;
    accIdx_ElectIndustry_Supplies    = 161;
    accIdx_ElectIndustry_Products    = 162;
    accIdx_ElectIndustry_Salaries    = 163;
    accIdx_ElectIndustry_Maintenance = 164;

    // FoodProc
    accIdx_FoodProc             = 170;
    accIdx_FoodProc_Supplies    = 171;
    accIdx_FoodProc_Products    = 172;
    accIdx_FoodProc_Salaries    = 173;
    accIdx_FoodProc_Maintenance = 174;

    // HeavyIndustry
    accIdx_HeavyIndustry             = 180;
    accIdx_HeavyIndustry_Supplies    = 181;
    accIdx_HeavyIndustry_Products    = 182;
    accIdx_HeavyIndustry_Salaries    = 183;
    accIdx_HeavyIndustry_Maintenance = 184;

    // HHAIndustry
    accIdx_HHAIndustry             = 190;
    accIdx_HHAIndustry_Supplies    = 191;
    accIdx_HHAIndustry_Products    = 192;
    accIdx_HHAIndustry_Salaries    = 193;
    accIdx_HHAIndustry_Maintenance = 194;

    // ToyIndustry
    accIdx_ToyIndustry             = 195;
    accIdx_ToyIndustry_Supplies    = 196;
    accIdx_ToyIndustry_Products    = 197;
    accIdx_ToyIndustry_Salaries    = 198;
    accIdx_ToyIndustry_Maintenance = 199;

    // MetalIndustry
    accIdx_MetalIndustry             = 200;
    accIdx_MetalIndustry_Supplies    = 201;
    accIdx_MetalIndustry_Products    = 202;
    accIdx_MetalIndustry_Salaries    = 203;
    accIdx_MetalIndustry_Maintenance = 204;

    // Mine
    accIdx_Mine             = 210;
    accIdx_Mine_Supplies    = 211;
    accIdx_Mine_Products    = 212;
    accIdx_Mine_Salaries    = 213;
    accIdx_Mine_Maintenance = 214;

    // OilRig
    accIdx_OilRig             = 215;
    accIdx_OilRig_Supplies    = 216;
    accIdx_OilRig_Products    = 217;
    accIdx_OilRig_Salaries    = 218;
    accIdx_OilRig_Maintenance = 219;

    // TextileIndustry
    accIdx_TextileIndustry             = 220;
    accIdx_TextileIndustry_Supplies    = 221;
    accIdx_TextileIndustry_Products    = 222;
    accIdx_TextileIndustry_Salaries    = 223;
    accIdx_TextileIndustry_Maintenance = 224;

    // Refinery
    accIdx_Refinery             = 225;
    accIdx_Refinery_Supplies    = 226;
    accIdx_Refinery_Products    = 227;
    accIdx_Refinery_Salaries    = 228;
    accIdx_Refinery_Maintenance = 229;

    // Computing
    accIdx_Computing             = 230;
    accIdx_Computing_Supplies    = 231;
    accIdx_Computing_Products    = 232;
    accIdx_Computing_Salaries    = 233;
    accIdx_Computing_Maintenance = 234;

    // PlasticIndustry
    accIdx_PlasticIndustry             = 235;
    accIdx_PlasticIndustry_Supplies    = 236;
    accIdx_PlasticIndustry_Products    = 237;
    accIdx_PlasticIndustry_Salaries    = 238;
    accIdx_PlasticIndustry_Maintenance = 239;

    // LegalServices
    accIdx_LegalServices             = 240;
    accIdx_LegalServices_Supplies    = 241;
    accIdx_LegalServices_Products    = 242;
    accIdx_LegalServices_Salaries    = 243;
    accIdx_LegalServices_Maintenance = 244;

    // PharmaIndustry
    accIdx_PharmaIndustry             = 400;
    accIdx_PharmaIndustry_Supplies    = 401;
    accIdx_PharmaIndustry_Products    = 402;
    accIdx_PharmaIndustry_Salaries    = 403;
    accIdx_PharmaIndustry_Maintenance = 404;

    // LiquorFact
    accIdx_LiquorFact             = 410;
    accIdx_LiquorFact_Supplies    = 411;
    accIdx_LiquorFact_Products    = 412;
    accIdx_LiquorFact_Salaries    = 413;
    accIdx_LiquorFact_Maintenance = 414;

    // LumberMill
    accIdx_LumberMill             = 420;
    accIdx_LumberMill_Supplies    = 421;
    accIdx_LumberMill_Products    = 422;
    accIdx_LumberMill_Salaries    = 423;
    accIdx_LumberMill_Maintenance = 424;

    // FurnitureIndustry
    accIdx_FurnitureIndustry             = 425;
    accIdx_FurnitureIndustry_Supplies    = 426;
    accIdx_FurnitureIndustry_Products    = 427;
    accIdx_FurnitureIndustry_Salaries    = 428;
    accIdx_FurnitureIndustry_Maintenance = 429;

    // MovieStudios
    accIdx_MovieStudios             = 435;
    accIdx_MovieStudios_Supplies    = 436;
    accIdx_MovieStudios_Products    = 437;
    accIdx_MovieStudios_Salaries    = 438;
    accIdx_MovieStudios_Maintenance = 439;

    // PaperIndustry
    accIdx_PaperIndustry             = 440;
    accIdx_PaperIndustry_Supplies    = 441;
    accIdx_PaperIndustry_Products    = 442;
    accIdx_PaperIndustry_Salaries    = 443;
    accIdx_PaperIndustry_Maintenance = 444;

    // PrintingPlant
    accIdx_PrintingPlant             = 450;
    accIdx_PrintingPlant_Supplies    = 451;
    accIdx_PrintingPlant_Products    = 452;
    accIdx_PrintingPlant_Salaries    = 453;
    accIdx_PrintingPlant_Maintenance = 454;

    // CDPlant
    accIdx_CDPlant                   = 460;
    accIdx_CDPlant_Supplies          = 461;
    accIdx_CDPlant_Products          = 462;
    accIdx_CDPlant_Salaries          = 463;
    accIdx_CDPlant_Maintenance       = 464;

    // organicwaste
    accIdx_organicwaste             = 530;
    accIdx_organicwaste_Supplies    = 531;
    accIdx_organicwaste_Products    = 532;
    accIdx_organicwaste_Salaries    = 533;
    accIdx_organicwaste_Maintenance = 534;

    // fert plant
    accIdx_fert             = 535;
    accIdx_fert_Supplies    = 536;
    accIdx_fert_Products    = 537;
    accIdx_fert_Salaries    = 538;
    accIdx_fert_Maintenance = 539;

    // grainfarma
    accIdx_grainfarma             = 540;
    accIdx_grainfarma_Supplies    = 541;
    accIdx_grainfarma_Products    = 542;
    accIdx_grainfarma_Salaries    = 543;
    accIdx_grainfarma_Maintenance = 544;

        // mill plant
    accIdx_mill             = 545;
    accIdx_mill_Supplies    = 546;
    accIdx_mill_Products    = 547;
    accIdx_mill_Salaries    = 548;
    accIdx_mill_Maintenance = 549;

        // cotton
    accIdx_cotton             = 550;
    accIdx_cotton_Supplies    = 551;
    accIdx_cotton_Products    = 552;
    accIdx_cotton_Salaries    = 553;
    accIdx_cotton_Maintenance = 554;

        // trouser
    accIdx_trouser             = 555;
    accIdx_trouser_Supplies    = 556;
    accIdx_trouser_Products    = 557;
    accIdx_trouser_Salaries    = 558;
    accIdx_trouser_Maintenance = 559;

    // fruitfarma
    accIdx_fruitfarma             = 570;
    accIdx_fruitfarma_Supplies    = 571;
    accIdx_fruitfarma_Products    = 572;
    accIdx_fruitfarma_Salaries    = 573;
    accIdx_fruitfarma_Maintenance = 574;
    // shoefact
    accIdx_shoefact             = 575;
    accIdx_shoefact_Supplies    = 576;
    accIdx_shoefact_Products    = 577;
    accIdx_shoefact_Salaries    = 578;
    accIdx_shoefact_Maintenance = 579;
    // rubberfact
    accIdx_rubberfact             = 580;
    accIdx_rubberfact_Supplies    = 581;
    accIdx_rubberfact_Products    = 582;
    accIdx_rubberfact_Salaries    = 583;
    accIdx_rubberfact_Maintenance = 584;
    // rubbersap
    accIdx_rubbersap             = 585;
    accIdx_rubbersap_Supplies    = 586;
    accIdx_rubbersap_Products    = 587;
    accIdx_rubbersap_Salaries    = 588;
    accIdx_rubbersap_Maintenance = 589;
    // rubber tree
    accIdx_rubbertree             = 590;
    accIdx_rubbertree_Supplies    = 591;
    accIdx_rubbertree_Products    = 592;
    accIdx_rubbertree_Salaries    = 593;
    accIdx_rubbertree_Maintenance = 594;
    // fruitpie
    accIdx_fruitpie             = 595;
    accIdx_fruitpie_Supplies    = 596;
    accIdx_fruitpie_Products    = 597;
    accIdx_fruitpie_Salaries    = 598;
    accIdx_fruitpie_Maintenance = 599;
    // vegfarma
    accIdx_vegfarma             = 600;
    accIdx_vegfarma_Supplies    = 601;
    accIdx_vegfarma_Products    = 602;
    accIdx_vegfarma_Salaries    = 603;
    accIdx_vegfarma_Maintenance = 604;
    // stewfact
    accIdx_stewfact             = 605;
    accIdx_stewfact_Supplies    = 606;
    accIdx_stewfact_Products    = 607;
    accIdx_stewfact_Salaries    = 608;
    accIdx_stewfact_Maintenance = 609;
    // organicMine
    accIdx_organicMine             = 610;
    accIdx_organicMine_Supplies    = 611;
    accIdx_organicMine_Products    = 612;
    accIdx_organicMine_Salaries    = 613;
    accIdx_organicMine_Maintenance = 614;
    // polymer
    accIdx_polymer             = 615;
    accIdx_polymer_Supplies    = 616;
    accIdx_polymer_Products    = 617;
    accIdx_polymer_Salaries    = 618;
    accIdx_polymer_Maintenance = 619;
    // nylon
    accIdx_nylon             = 620;
    accIdx_nylon_Supplies    = 621;
    accIdx_nylon_Products    = 622;
    accIdx_nylon_Salaries    = 623;
    accIdx_nylon_Maintenance = 624;
    // shirt
    accIdx_shirt             = 625;
    accIdx_shirt_Supplies    = 626;
    accIdx_shirt_Products    = 627;
    accIdx_shirt_Salaries    = 628;
    accIdx_shirt_Maintenance = 629;
    // Cattlefarma
    accIdx_Cattlefarma            = 630;
    accIdx_Cattlefarma_Supplies    = 631;
    accIdx_Cattlefarma_Products    = 632;
    accIdx_Cattlefarma_Salaries    = 633;
    accIdx_Cattlefarma_Maintenance = 634;
    // burgerfact
    accIdx_burgerfact             = 635;
    accIdx_burgerfact_Supplies    = 636;
    accIdx_burgerfact_Products    = 637;
    accIdx_burgerfact_Salaries    = 638;
    accIdx_burgerfact_Maintenance = 639;
    // rawChemMine
    accIdx_rawChemMine             = 640;
    accIdx_rawChemMine_Supplies    = 641;
    accIdx_rawChemMine_Products    = 642;
    accIdx_rawChemMine_Salaries    = 643;
    accIdx_rawChemMine_Maintenance = 644;
    // miningchem
    accIdx_miningchem             = 645;
    accIdx_miningchem_Supplies    = 646;
    accIdx_miningchem_Products    = 647;
    accIdx_miningchem_Salaries    = 648;
    accIdx_miningchem_Maintenance = 649;
    // leather
    accIdx_leather             = 650;
    accIdx_leather_Supplies    = 651;
    accIdx_leather_Products    = 652;
    accIdx_leather_Salaries    = 653;
    accIdx_leather_Maintenance = 654;
    // leatherjacket
    accIdx_leatherjacket             = 655;
    accIdx_leatherjacket_Supplies    = 656;
    accIdx_leatherjacket_Products    = 657;
    accIdx_leatherjacket_Salaries    = 658;
    accIdx_leatherjacket_Maintenance = 659;
    // Tvs
    accIdx_Tvs             = 700;
    accIdx_Tvs_Supplies    = 701;
    accIdx_Tvs_Products    = 702;
    accIdx_Tvs_Salaries    = 703;
    accIdx_Tvs_Maintenance = 704;

    // Smallcar
    accIdx_Smallcar             = 705;
    accIdx_Smallcar_Supplies    = 706;
    accIdx_Smallcar_Products    = 707;
    accIdx_Smallcar_Salaries    = 708;
    accIdx_Smallcar_Maintenance = 709;
    // ironmine
    accIdx_ironMine             = 710;
    accIdx_ironMine_Supplies    = 711;
    accIdx_ironMine_Products    = 712;
    accIdx_ironMine_Salaries    = 713;
    accIdx_ironMine_Maintenance = 714;
    // SiliconMine2
    accIdx_SiliconMine2             = 715;
    accIdx_SiliconMine2_Supplies    = 716;
    accIdx_SiliconMine2_Products    = 717;
    accIdx_SiliconMine2_Salaries    = 718;
    accIdx_SiliconMine2_Maintenance = 719;
    // CoalMine2
    accIdx_CoalMine2             = 720;
    accIdx_CoalMine2_Supplies    = 721;
    accIdx_CoalMine2_Products    = 722;
    accIdx_CoalMine2_Salaries    = 723;
    accIdx_CoalMine2_Maintenance = 724;
    // steel
    accIdx_steel             = 725;
    accIdx_steel_Supplies    = 726;
    accIdx_steel_Products    = 727;
    accIdx_steel_Salaries    = 728;
    accIdx_steel_Maintenance = 729;
    // Memory
    accIdx_Memory             = 730;
    accIdx_Memory_Supplies    = 731;
    accIdx_Memory_Products    = 732;
    accIdx_Memory_Salaries    = 733;
    accIdx_Memory_Maintenance = 734;

    // coppermine
    accIdx_coppermine             = 735;
    accIdx_coppermine_Supplies    = 736;
    accIdx_coppermine_Products    = 737;
    accIdx_coppermine_Salaries    = 738;
    accIdx_coppermine_Maintenance = 739;
    // ceramicMine
    accIdx_ceramicMine             = 740;
    accIdx_ceramicMine_Supplies    = 741;
    accIdx_ceramicMine_Products    = 742;
    accIdx_ceramicMine_Salaries    = 743;
    accIdx_ceramicMine_Maintenance = 744;
    // pineoil
    accIdx_pineoil             = 745;
    accIdx_pineoil_Supplies    = 746;
    accIdx_pineoil_Products    = 747;
    accIdx_pineoil_Salaries    = 748;
    accIdx_pineoil_Maintenance = 749;
    // copperIndustry
    accIdx_copperIndustry             = 750;
    accIdx_copperIndustry_Supplies    = 751;
    accIdx_copperIndustry_Products    = 752;
    accIdx_copperIndustry_Salaries    = 753;
    accIdx_copperIndustry_Maintenance = 754;
    // CPU
    accIdx_CPU             = 755;
    accIdx_CPU_Supplies    = 756;
    accIdx_CPU_Products    = 757;
    accIdx_CPU_Salaries    = 758;
    accIdx_CPU_Maintenance = 759;
    // sportscar
    accIdx_sportscar             = 760;
    accIdx_sportscar_Supplies    = 761;
    accIdx_sportscar_Products    = 762;
    accIdx_sportscar_Salaries    = 763;
    accIdx_sportscar_Maintenance = 764;
    // PCs
    accIdx_PCs             = 765;
    accIdx_PCs_Supplies    = 766;
    accIdx_PCs_Products    = 767;
    accIdx_PCs_Salaries    = 768;
    accIdx_PCs_Maintenance = 769;
    // almine
    accIdx_almine             = 770;
    accIdx_almine_Supplies    = 771;
    accIdx_almine_Products    = 772;
    accIdx_almine_Salaries    = 773;
    accIdx_almine_Maintenance = 774;
    // cryolite
    accIdx_cryolite             = 775;
    accIdx_cryolite_Supplies    = 776;
    accIdx_cryolite_Products    = 777;
    accIdx_cryolite_Salaries    = 778;
    accIdx_cryolite_Maintenance = 779;
    // silane
    accIdx_silane             = 780;
    accIdx_silane_Supplies    = 781;
    accIdx_silane_Products    = 782;
    accIdx_silane_Salaries    = 783;
    accIdx_silane_Maintenance = 784;
    // alIndustry
    accIdx_alIndustry             = 785;
    accIdx_alIndustry_Supplies    = 786;
    accIdx_alIndustry_Products    = 787;
    accIdx_alIndustry_Salaries    = 788;
    accIdx_alIndustry_Maintenance = 789;
    // tft
    accIdx_tft             = 790;
    accIdx_tft_Supplies    = 791;
    accIdx_tft_Products    = 792;
    accIdx_tft_Salaries    = 793;
    accIdx_tft_Maintenance = 794;
    // motorbike
    accIdx_motorbike             = 795;
    accIdx_motorbike_Supplies    = 796;
    accIdx_motorbike_Products    = 797;
    accIdx_motorbike_Salaries    = 798;
    accIdx_motorbike_Maintenance = 799;
    // mphone
    accIdx_mphone             = 900;
    accIdx_mphone_Supplies    = 901;
    accIdx_mphone_Products    = 902;
    accIdx_mphone_Salaries    = 903;
    accIdx_mphone_Maintenance = 904;

    // engine
    accIdx_engine             = 905;
    accIdx_engine_Supplies    = 906;
    accIdx_engine_Products    = 907;
    accIdx_engine_Salaries    = 908;
    accIdx_engine_Maintenance = 909;
    // tire
    accIdx_tire             = 910;
    accIdx_tire_Supplies    = 911;
    accIdx_tire_Products    = 912;
    accIdx_tire_Salaries    = 913;
    accIdx_tire_Maintenance = 914;
    // humvee
    accIdx_humvee             = 915;
    accIdx_humvee_Supplies    = 916;
    accIdx_humvee_Products    = 917;
    accIdx_humvee_Salaries    = 918;
    accIdx_humvee_Maintenance = 919;
    // cooker
    accIdx_cooker             = 920;
    accIdx_cooker_Supplies    = 921;
    accIdx_cooker_Products    = 922;
    accIdx_cooker_Salaries    = 923;
    accIdx_cooker_Maintenance = 924;
    // glass
    accIdx_glass             = 925;
    accIdx_glass_Supplies    = 926;
    accIdx_glass_Products    = 927;
    accIdx_glass_Salaries    = 928;
    accIdx_glass_Maintenance = 929;
    // conveybsys
    accIdx_conveybsys             = 930;
    accIdx_conveybsys_Supplies    = 931;
    accIdx_conveybsys_Products    = 932;
    accIdx_conveybsys_Salaries    = 933;
    accIdx_conveybsys_Maintenance = 934;

    // buscomp
    accIdx_buscomp             = 935;
    accIdx_buscomp_Supplies    = 936;
    accIdx_buscomp_Products    = 937;
    accIdx_buscomp_Salaries    = 938;
    accIdx_buscomp_Maintenance = 939;
    // concrete
    accIdx_concrete             = 940;
    accIdx_concrete_Supplies    = 941;
    accIdx_concrete_Products    = 942;
    accIdx_concrete_Salaries    = 943;
    accIdx_concrete_Maintenance = 944;
    // machineindy2
    accIdx_machineindy2             = 945;
    accIdx_machineindy2_Supplies    = 946;
    accIdx_machineindy2_Products    = 947;
    accIdx_machineindy2_Salaries    = 948;
    accIdx_machineindy2_Maintenance = 949;
    // servers
    accIdx_servers             = 950;
    accIdx_servers_Supplies    = 951;
    accIdx_servers_Products    = 952;
    accIdx_servers_Salaries    = 953;
    accIdx_servers_Maintenance = 954;
    // plasterboard
    accIdx_plasterboard             = 955;
    accIdx_plasterboard_Supplies    = 956;
    accIdx_plasterboard_Products    = 957;
    accIdx_plasterboard_Salaries    = 958;
    accIdx_plasterboard_Maintenance = 959;
    // roboticsys
    accIdx_roboticsys             = 960;
    accIdx_roboticsys_Supplies    = 961;
    accIdx_roboticsys_Products    = 962;
    accIdx_roboticsys_Salaries    = 963;
    accIdx_roboticsys_Maintenance = 964;
    // bm2
    accIdx_bm2             = 965;
    accIdx_bm2_Supplies    = 966;
    accIdx_bm2_Products    = 967;
    accIdx_bm2_Salaries    = 968;
    accIdx_bm2_Maintenance = 969;
    // gypsum
    accIdx_gypsum             = 970;
    accIdx_gypsum_Supplies    = 971;
    accIdx_gypsum_Products    = 972;
    accIdx_gypsum_Salaries    = 973;
    accIdx_gypsum_Maintenance = 974;
    // limestone
    accIdx_limestone             = 975;
    accIdx_limestone_Supplies    = 976;
    accIdx_limestone_Products    = 977;
    accIdx_limestone_Salaries    = 978;
    accIdx_limestone_Maintenance = 979;
    // gravel
    accIdx_gravel             = 980;
    accIdx_gravel_Supplies    = 981;
    accIdx_gravel_Products    = 982;
    accIdx_gravel_Salaries    = 983;
    accIdx_gravel_Maintenance = 984;
    // const2
    accIdx_const2             = 985;
    accIdx_const2_Supplies    = 986;
    accIdx_const2_Products    = 987;
    accIdx_const2_Salaries    = 988;
    accIdx_const2_Maintenance = 989;
    // controlsys
    accIdx_controlsys             = 990;
    accIdx_controlsys_Supplies    = 991;
    accIdx_controlsys_Products    = 992;
    accIdx_controlsys_Salaries    = 993;
    accIdx_controlsys_Maintenance = 994;
    // networksys
    accIdx_networksys             = 995;
    accIdx_networksys_Supplies    = 996;
    accIdx_networksys_Products    = 997;
    accIdx_networksys_Salaries    = 998;
    accIdx_networksys_Maintenance = 999;
    {}


  // Service blocks account Ids
  const
    // tv
    accIdx_TVStore             = 800;
    accIdx_TVStore_Supplies    = 801;
    accIdx_TVStore_Sales    = 802;
    accIdx_TVStore_Salaries    = 803;
    accIdx_TVStore_Maintenance = 804;
    // Smallcarstore
    accIdx_Smallcarstore             = 805;
    accIdx_Smallcarstore_Supplies    = 806;
    accIdx_Smallcarstore_Sales    = 807;
    accIdx_Smallcarstore_Salaries    = 808;
    accIdx_Smallcarstore_Maintenance = 809;
    // Sportscarstore
    accIdx_Sportscarstore             = 810;
    accIdx_Sportscarstore_Supplies    = 811;
    accIdx_Sportscarstore_Sales    = 812;
    accIdx_Sportscarstore_Salaries    = 813;
    accIdx_Sportscarstore_Maintenance = 814;
      // mobileStore
    accIdx_mobileStore             = 815;
    accIdx_mobileStore_Supplies    = 816;
    accIdx_mobileStore_Sales    = 817;
    accIdx_mobileStore_Salaries    = 818;
    accIdx_mobileStore_Maintenance = 819;
    // motorbikestore
    accIdx_motorbikestore             = 820;
    accIdx_motorbikestore_Supplies    = 821;
    accIdx_motorbikestore_Sales    = 822;
    accIdx_motorbikestore_Salaries    = 823;
    accIdx_motorbikestore_Maintenance = 824;
      // humveestore
    accIdx_humveestore             = 825;
    accIdx_humveestore_Supplies    = 826;
    accIdx_humveestore_Sales    = 827;
    accIdx_humveestore_Salaries    = 828;
    accIdx_humveestore_Maintenance = 829;
    // cookerStore
    accIdx_cookerStore             = 830;
    accIdx_cookerStore_Supplies    = 831;
    accIdx_cookerStore_Sales    = 832;
    accIdx_cookerStore_Salaries    = 833;
    accIdx_cookerStore_Maintenance = 834;
    {  // fruitpie shop
    accIdx_stewShop             = 835;
    accIdx_stewShop_Supplies    = 836;
    accIdx_stewShop_Sales    = 837;
    accIdx_stewShop_Salaries    = 838;
    accIdx_stewShop_Maintenance = 839;
    // leatherjacketShop
    accIdx_leatherjacketShop             = 840;
    accIdx_leatherjacketShop_Supplies    = 841;
    accIdx_leatherjacketShop_Sales    = 842;
    accIdx_leatherjacketShop_Salaries    = 843;
    accIdx_leatherjacketShop_Maintenance = 844;
      // fruitpie shop
    accIdx_stewShop             = 845;
    accIdx_stewShop_Supplies    = 846;
    accIdx_stewShop_Sales    = 847;
    accIdx_stewShop_Salaries    = 848;
    accIdx_stewShop_Maintenance = 849;
    // leatherjacketShop
    accIdx_leatherjacketShop             = 850;
    accIdx_leatherjacketShop_Supplies    = 851;
    accIdx_leatherjacketShop_Sales    = 852;
    accIdx_leatherjacketShop_Salaries    = 853;
    accIdx_leatherjacketShop_Maintenance = 854;
      // fruitpie shop
    accIdx_stewShop             = 855;
    accIdx_stewShop_Supplies    = 856;
    accIdx_stewShop_Sales    = 857;
    accIdx_stewShop_Salaries    = 858;
    accIdx_stewShop_Maintenance = 859;
    // leatherjacketShop
    accIdx_leatherjacketShop             = 860;
    accIdx_leatherjacketShop_Supplies    = 861;
    accIdx_leatherjacketShop_Sales    = 862;
    accIdx_leatherjacketShop_Salaries    = 863;
    accIdx_leatherjacketShop_Maintenance = 864;
      // fruitpie shop
    accIdx_stewShop             = 865;
    accIdx_stewShop_Supplies    = 866;
    accIdx_stewShop_Sales    = 867;
    accIdx_stewShop_Salaries    = 868;
    accIdx_stewShop_Maintenance = 869;
    // leatherjacketShop
    accIdx_leatherjacketShop             = 870;
    accIdx_leatherjacketShop_Supplies    = 871;
    accIdx_leatherjacketShop_Sales    = 872;
    accIdx_leatherjacketShop_Salaries    = 873;
    accIdx_leatherjacketShop_Maintenance = 874;
      // fruitpie shop
    accIdx_stewShop             = 875;
    accIdx_stewShop_Supplies    = 876;
    accIdx_stewShop_Sales    = 877;
    accIdx_stewShop_Salaries    = 878;
    accIdx_stewShop_Maintenance = 879;
    // leatherjacketShop
    accIdx_leatherjacketShop             = 880;
    accIdx_leatherjacketShop_Supplies    = 881;
    accIdx_leatherjacketShop_Sales    = 882;
    accIdx_leatherjacketShop_Salaries    = 883;
    accIdx_leatherjacketShop_Maintenance = 884;
      // fruitpie shop
    accIdx_stewShop             = 885;
    accIdx_stewShop_Supplies    = 886;
    accIdx_stewShop_Sales    = 887;
    accIdx_stewShop_Salaries    = 888;
    accIdx_stewShop_Maintenance = 889;
    // leatherjacketShop
    accIdx_leatherjacketShop             = 890;
    accIdx_leatherjacketShop_Supplies    = 891;
    accIdx_leatherjacketShop_Sales    = 892;
    accIdx_leatherjacketShop_Salaries    = 893;
    accIdx_leatherjacketShop_Maintenance = 894;
      // fruitpie shop
    accIdx_stewShop             = 895;
    accIdx_stewShop_Supplies    = 896;
    accIdx_stewShop_Sales    = 897;
    accIdx_stewShop_Salaries    = 898;
    accIdx_stewShop_Maintenance = 899;
    }

    // burgerbar shop
    accIdx_burgerbar             = 695;
    accIdx_burgerbar_Supplies    = 696;
    accIdx_burgerbar_Sales    = 697;
    accIdx_burgerbar_Salaries    = 698;
    accIdx_burgerbar_Maintenance = 699;
    // leatherjacketShop
    accIdx_leatherjacketShop             = 690;
    accIdx_leatherjacketShop_Supplies    = 691;
    accIdx_leatherjacketShop_Sales    = 692;
    accIdx_leatherjacketShop_Salaries    = 693;
    accIdx_leatherjacketShop_Maintenance = 694;
      // fruitpie shop
    accIdx_stewShop             = 685;
    accIdx_stewShop_Supplies    = 686;
    accIdx_stewShop_Sales    = 687;
    accIdx_stewShop_Salaries    = 688;
    accIdx_stewShop_Maintenance = 689;
       //shirtShop
    accIdx_shirtShop             = 680;
    accIdx_shirtShop_Supplies    = 681;
    accIdx_shirtShop_Sales    = 682;
    accIdx_shirtShop_Salaries    = 683;
    accIdx_shirtShop_Maintenance = 684;
      // shoe shop
    accIdx_shoeshop             = 670;
    accIdx_shoeshop_Supplies    = 671;
    accIdx_shoeshop_Sales    = 672;
    accIdx_shoeshop_Salaries    = 673;
    accIdx_shoeshop_Maintenance = 674;
      // fruitpie shop
    accIdx_pieShop             = 675;
    accIdx_pieShop_Supplies    = 676;
    accIdx_pieShop_Sales    = 677;
    accIdx_pieShop_Salaries    = 678;
    accIdx_pieShop_Maintenance = 679;
      // trouser shop
    accIdx_trousershop             = 560;
    accIdx_trousershop_Supplies    = 561;
    accIdx_trousershop_Sales    = 562;
    accIdx_trousershop_Salaries    = 563;
    accIdx_trousershop_Maintenance = 564;

        // bakery
    accIdx_bakery             = 565;
    accIdx_bakery_Supplies    = 566;
    accIdx_bakery_Sales    = 567;
    accIdx_bakery_Salaries    = 568;
    accIdx_bakery_Maintenance = 569;


    // Car
    accIdx_CarStore           = 250;
    accIdx_CarStore_Supplies  = 251;
    accIdx_CarStore_Salaries  = 252;
    accIdx_CarStore_Sales     = 253;

    // Clothes Shop
    accIdx_ClothesStore          = 260;
    accIdx_ClothesStore_Supplies = 261;
    accIdx_ClothesStore_Salaries = 262;
    accIdx_ClothesStore_Sales    = 263;

    // FoodStore
    accIdx_FoodStore           = 270;
    accIdx_FoodStore_Supplies  = 271;
    accIdx_FoodStore_Salaries  = 272;
    accIdx_FoodStore_Sales     = 273;

    // Bar
    accIdx_Bar           = 280;
    accIdx_Bar_Supplies  = 291;
    accIdx_Bar_Salaries  = 292;
    accIdx_Bar_Sales     = 293;

    // Funeral Store
    accIdx_FuneralParlor           = 295;
    accIdx_FuneralParlor_Supplies  = 296;
    accIdx_FuneralParlor_Salaries  = 297;
    accIdx_FuneralParlor_Sales     = 298;

    // HHA Store
    accIdx_HHAStore           = 300;
    accIdx_HHAStore_Supplies  = 301;
    accIdx_HHAStore_Salaries  = 302;
    accIdx_HHAStore_Sales     = 303;

    // Toy Store
    accIdx_ToyStore           = 305;
    accIdx_ToyStore_Supplies  = 306;
    accIdx_ToyStore_Salaries  = 307;
    accIdx_ToyStore_Sales     = 308;

    // Super Market
    accIdx_SuperMarket           = 310;
    accIdx_SuperMarket_Supplies  = 311;
    accIdx_SuperMarket_Salaries  = 312;
    accIdx_SuperMarket_Sales     = 313;

    // Restaurant
    accIdx_Restaurant           = 320;
    accIdx_Restaurant_Supplies  = 321;
    accIdx_Restaurant_Salaries  = 322;
    accIdx_Restaurant_Sales     = 323;

    // Movie
    accIdx_Movie                = 330;
    accIdx_Movie_Supplies       = 331;
    accIdx_Movie_Salaries       = 332;
    accIdx_Movie_Sales          = 333;

    // Furniture Store
    accIdx_FurnitureStore           = 340;
    accIdx_FurnitureStore_Supplies  = 341;
    accIdx_FurnitureStore_Salaries  = 342;
    accIdx_FurnitureStore_Sales     = 343;

    // Book Store
    accIdx_BookStore           = 345;
    accIdx_BookStore_Supplies  = 346;
    accIdx_BookStore_Salaries  = 347;
    accIdx_BookStore_Sales     = 348;

    // Drug Store
    accIdx_DrugStore           = 500;
    accIdx_DrugStore_Supplies  = 501;
    accIdx_DrugStore_Salaries  = 502;
    accIdx_DrugStore_Sales     = 503;

    // Gas Station
    accIdx_GasStation           = 505;
    accIdx_GasStation_Supplies  = 506;
    accIdx_GasStation_Salaries  = 507;
    accIdx_GasStation_Sales     = 508;

    // Computer Store
    accIdx_ComputerStore          = 510;
    accIdx_ComputerStore_Supplies = 511;
    accIdx_ComputerStore_Salaries = 512;
    accIdx_ComputerStore_Sales    = 513;

    // CD Store
    accIdx_CDStore           = 520;
    accIdx_CDStore_Supplies  = 521;
    accIdx_CDStore_Salaries  = 522;
    accIdx_CDStore_Sales     = 523;

    
  const
    // Warehouses
    accIdx_Warehouses             = 350;
    accIdx_Warehouses_Supplies    = 351;
    accIdx_Warehouses_Products    = 352;
    accIdx_Warehouses_Salaries    = 353;
    accIdx_Warehouses_Maintenance = 354;

  // Media
  const
    // TV
    accIdx_TV             = 360;
    accIdx_TV_Supplies    = 361;
    accIdx_TV_Products    = 362;
    accIdx_TV_Salaries    = 363;
    accIdx_TV_Maintenance = 364;


  procedure RegisterAccounts;

implementation

  uses
    Accounts, BasicAccounts,logs;

  procedure RegisterAccounts;
    begin
    logs.Log('stdaccounts','start');
    //newstuff      networksys
    {$IFDEF newpack}
    //networksys
      with TMetaAccount.Create(
        accIdx_networksys,
        accIdx_Industries,
        'networksys',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_networksys_Products,
        accIdx_networksys,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_networksys_Supplies,
        accIdx_networksys,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_networksys_Salaries,
        accIdx_networksys,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_networksys_Maintenance,
        accIdx_networksys ,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //controlsys
      with TMetaAccount.Create(
        accIdx_controlsys,
        accIdx_Industries,
        'controlsys',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_controlsys_Products,
        accIdx_controlsys,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_controlsys_Supplies,
        accIdx_controlsys,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_controlsys_Salaries,
        accIdx_controlsys,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_controlsys_Maintenance,
        accIdx_controlsys,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //const2
      with TMetaAccount.Create(
        accIdx_const2,
        accIdx_Industries,
        'const2',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_const2_Products,
        accIdx_const2,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_const2_Supplies,
        accIdx_const2,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_const2_Salaries,
        accIdx_const2,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_const2_Maintenance,
        accIdx_const2,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //gravel
      with TMetaAccount.Create(
        accIdx_gravel,
        accIdx_Industries,
        'gravel',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gravel_Products,
        accIdx_gravel,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gravel_Supplies,
        accIdx_gravel,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gravel_Salaries,
        accIdx_gravel,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gravel_Maintenance,
        accIdx_gravel,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //limestone
      with TMetaAccount.Create(
        accIdx_limestone,
        accIdx_Industries,
        'limestone',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_limestone_Products,
        accIdx_limestone,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_limestone_Supplies,
        accIdx_limestone,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_limestone_Salaries,
        accIdx_limestone,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_limestone_Maintenance,
        accIdx_limestone,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //gypsum
      with TMetaAccount.Create(
        accIdx_gypsum,
        accIdx_Industries,
        'gypsum',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gypsum_Products,
        accIdx_gypsum,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gypsum_Supplies,
        accIdx_gypsum,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gypsum_Salaries,
        accIdx_gypsum,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_gypsum_Maintenance,
        accIdx_gypsum,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //bm2
      with TMetaAccount.Create(
        accIdx_bm2,
        accIdx_Industries,
        'bm2',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bm2_Products,
        accIdx_bm2,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bm2_Supplies,
        accIdx_bm2,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bm2_Salaries,
        accIdx_bm2,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bm2_Maintenance,
        accIdx_bm2,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //roboticsys
      with TMetaAccount.Create(
        accIdx_roboticsys,
        accIdx_Industries,
        'roboticsys',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_roboticsys_Products,
        accIdx_roboticsys,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_roboticsys_Supplies,
        accIdx_roboticsys,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_roboticsys_Salaries,
        accIdx_roboticsys,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_roboticsys_Maintenance,
        accIdx_roboticsys,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //plasterboard
      with TMetaAccount.Create(
        accIdx_plasterboard,
        accIdx_Industries,
        'plasterboard',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_plasterboard_Products,
        accIdx_plasterboard,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_plasterboard_Supplies,
        accIdx_plasterboard,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_plasterboard_Salaries,
        accIdx_plasterboard,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_plasterboard_Maintenance,
        accIdx_plasterboard,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //servers
      with TMetaAccount.Create(
        accIdx_servers,
        accIdx_Industries,
        'servers',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_servers_Products,
        accIdx_servers,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_servers_Supplies,
        accIdx_servers,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_servers_Salaries,
        accIdx_servers,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_servers_Maintenance,
        accIdx_servers,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //machineindy2
      with TMetaAccount.Create(
        accIdx_machineindy2,
        accIdx_Industries,
        'machineindy2',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_machineindy2_Products,
        accIdx_machineindy2,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_machineindy2_Supplies,
        accIdx_machineindy2,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_machineindy2_Salaries,
        accIdx_machineindy2,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_machineindy2_Maintenance,
        accIdx_machineindy2,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //concrete
      with TMetaAccount.Create(
        accIdx_concrete,
        accIdx_Industries,
        'concrete',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_concrete_Products,
        accIdx_concrete,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_concrete_Supplies,
        accIdx_concrete,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_concrete_Salaries,
        accIdx_concrete,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_concrete_Maintenance,
        accIdx_concrete,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //buscomp
      with TMetaAccount.Create(
        accIdx_buscomp,
        accIdx_Industries,
        'buscomp',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_buscomp_Products,
        accIdx_buscomp,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_buscomp_Supplies,
        accIdx_buscomp,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_buscomp_Salaries,
        accIdx_buscomp,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_buscomp_Maintenance,
        accIdx_buscomp,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //conveybsys
      with TMetaAccount.Create(
        accIdx_conveybsys,
        accIdx_Industries,
        'conveybsys',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_conveybsys_Products,
        accIdx_conveybsys,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_conveybsys_Supplies,
        accIdx_conveybsys,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_conveybsys_Salaries,
        accIdx_conveybsys,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_conveybsys_Maintenance,
        accIdx_conveybsys,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //glass
      with TMetaAccount.Create(
        accIdx_glass,
        accIdx_Industries,
        'glass',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_glass_Products,
        accIdx_glass,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_glass_Supplies,
        accIdx_glass,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_glass_Salaries,
        accIdx_glass,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_glass_Maintenance,
        accIdx_glass,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //cooker
      with TMetaAccount.Create(
        accIdx_cooker,
        accIdx_Industries,
        'cooker',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cooker_Products,
        accIdx_cooker,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cooker_Supplies,
        accIdx_cooker,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cooker_Salaries,
        accIdx_cooker,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cooker_Maintenance,
        accIdx_cooker,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //humvee
      with TMetaAccount.Create(
        accIdx_humvee,
        accIdx_Industries,
        'humvee',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humvee_Products,
        accIdx_humvee,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humvee_Supplies,
        accIdx_humvee,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humvee_Salaries,
        accIdx_humvee,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humvee_Maintenance,
        accIdx_humvee,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //tire
      with TMetaAccount.Create(
        accIdx_tire,
        accIdx_Industries,
        'tire',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tire_Products,
        accIdx_tire,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tire_Supplies,
        accIdx_tire,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tire_Salaries,
        accIdx_tire,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tire_Maintenance,
        accIdx_tire,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // motorbike
      with TMetaAccount.Create(
        accIdx_engine,
        accIdx_Industries,
        'engine',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_engine_Products,
        accIdx_engine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_engine_Supplies,
        accIdx_engine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_engine_Salaries,
        accIdx_engine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_engine_Maintenance,
        accIdx_engine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // mphone
      with TMetaAccount.Create(
        accIdx_mphone,
        accIdx_Industries,
        'mphone',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mphone_Products,
        accIdx_mphone,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mphone_Supplies,
        accIdx_mphone,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mphone_Salaries,
        accIdx_mphone,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mphone_Maintenance,
        accIdx_mphone,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // motorbike
      with TMetaAccount.Create(
        accIdx_motorbike,
        accIdx_Industries,
        'motorbike',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbike_Products,
        accIdx_motorbike,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbike_Supplies,
        accIdx_motorbike,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbike_Salaries,
        accIdx_motorbike,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbike_Maintenance,
        accIdx_motorbike,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // tft
      with TMetaAccount.Create(
        accIdx_tft,
        accIdx_Industries,
        'tft',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tft_Products,
        accIdx_tft,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tft_Supplies,
        accIdx_tft,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tft_Salaries,
        accIdx_tft,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_tft_Maintenance,
        accIdx_tft,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // alIndustry
      with TMetaAccount.Create(
        accIdx_alIndustry,
        accIdx_Industries,
        'alIndustry',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_alIndustry_Products,
        accIdx_alIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_alIndustry_Supplies,
        accIdx_alIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_alIndustry_Salaries,
        accIdx_alIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_alIndustry_Maintenance,
        accIdx_alIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // silane
      with TMetaAccount.Create(
        accIdx_silane,
        accIdx_Industries,
        'silane',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_silane_Products,
        accIdx_silane,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_silane_Supplies,
        accIdx_silane,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_silane_Salaries,
        accIdx_silane,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_silane_Maintenance,
        accIdx_silane,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // cryolite
      with TMetaAccount.Create(
        accIdx_cryolite,
        accIdx_Industries,
        'cryolite',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cryolite_Products,
        accIdx_cryolite,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cryolite_Supplies,
        accIdx_cryolite,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cryolite_Salaries,
        accIdx_cryolite,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cryolite_Maintenance,
        accIdx_cryolite,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // almine
      with TMetaAccount.Create(
        accIdx_almine,
        accIdx_Industries,
        'almine',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_almine_Products,
        accIdx_almine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_almine_Supplies,
        accIdx_almine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_almine_Salaries,
        accIdx_almine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_almine_Maintenance,
        accIdx_almine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // PCs
      with TMetaAccount.Create(
        accIdx_PCs,
        accIdx_Industries,
        'PCs',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PCs_Products,
        accIdx_PCs,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PCs_Supplies,
        accIdx_PCs,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PCs_Salaries,
        accIdx_PCs,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PCs_Maintenance,
        accIdx_PCs,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // sportscar
      with TMetaAccount.Create(
        accIdx_sportscar,
        accIdx_Industries,
        'sportscar',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_sportscar_Products,
        accIdx_sportscar,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_sportscar_Supplies,
        accIdx_sportscar,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_sportscar_Salaries,
        accIdx_sportscar,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_sportscar_Maintenance,
        accIdx_sportscar,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // CPU
      with TMetaAccount.Create(
        accIdx_CPU,
        accIdx_Industries,
        'CPU',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CPU_Products,
        accIdx_CPU,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CPU_Supplies,
        accIdx_CPU,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CPU_Salaries,
        accIdx_CPU,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CPU_Maintenance,
        accIdx_CPU,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // copperIndustry
      with TMetaAccount.Create(
        accIdx_copperIndustry,
        accIdx_Industries,
        'copperIndustry',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_copperIndustry_Products,
        accIdx_copperIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_copperIndustry_Supplies,
        accIdx_copperIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_copperIndustry_Salaries,
        accIdx_copperIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_copperIndustry_Maintenance,
        accIdx_copperIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // pineoil
      with TMetaAccount.Create(
        accIdx_pineoil,
        accIdx_Industries,
        'pineoil',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pineoil_Products,
        accIdx_pineoil,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pineoil_Supplies,
        accIdx_pineoil,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pineoil_Salaries,
        accIdx_pineoil,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pineoil_Maintenance,
        accIdx_pineoil,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // ceramicMine
      with TMetaAccount.Create(
        accIdx_ceramicMine,
        accIdx_Industries,
        'ceramicMine',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ceramicMine_Products,
        accIdx_ceramicMine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ceramicMine_Supplies,
        accIdx_ceramicMine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ceramicMine_Salaries,
        accIdx_ceramicMine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ceramicMine_Maintenance,
        accIdx_ceramicMine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // coppermine
      with TMetaAccount.Create(
        accIdx_coppermine,
        accIdx_Industries,
        'coppermine',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_coppermine_Products,
        accIdx_coppermine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_coppermine_Supplies,
        accIdx_coppermine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_coppermine_Salaries,
        accIdx_coppermine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_coppermine_Maintenance,
        accIdx_coppermine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // Tvs
     with TMetaAccount.Create(
        accIdx_Tvs,
        accIdx_Industries,
        'Tvs',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Tvs_Products,
        accIdx_Tvs,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Tvs_Supplies,
        accIdx_Tvs,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Tvs_Salaries,
        accIdx_Tvs,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Tvs_Maintenance,
        accIdx_Tvs,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // Smallcar
      with TMetaAccount.Create(
        accIdx_Smallcar,
        accIdx_Industries,
        'Smallcar',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcar_Products,
        accIdx_Smallcar,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcar_Supplies,
        accIdx_Smallcar,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcar_Salaries,
        accIdx_Smallcar,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcar_Maintenance,
        accIdx_Smallcar,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // Memory
      with TMetaAccount.Create(
        accIdx_Memory,
        accIdx_Industries,
        'Memory',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Memory_Products,
        accIdx_Memory,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Memory_Supplies,
        accIdx_Memory,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Memory_Salaries,
        accIdx_Memory,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Memory_Maintenance,
        accIdx_Memory,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // steel
      with TMetaAccount.Create(
        accIdx_steel,
        accIdx_Industries,
        'steel',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_steel_Products,
        accIdx_steel,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_steel_Supplies,
        accIdx_steel,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_steel_Salaries,
        accIdx_steel,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_steel_Maintenance,
        accIdx_steel,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
     // CoalMine2
      with TMetaAccount.Create(
        accIdx_CoalMine2,
        accIdx_Industries,
        'CoalMine2',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CoalMine2_Products,
        accIdx_CoalMine2,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CoalMine2_Supplies,
        accIdx_CoalMine2,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CoalMine2_Salaries,
        accIdx_CoalMine2,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CoalMine2_Maintenance,
        accIdx_CoalMine2,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // SiliconMine2
      with TMetaAccount.Create(
        accIdx_SiliconMine2,
        accIdx_Industries,
        'SiliconMine2',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_SiliconMine2_Products,
        accIdx_SiliconMine2,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_SiliconMine2_Supplies,
        accIdx_SiliconMine2,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_SiliconMine2_Salaries,
        accIdx_SiliconMine2,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_SiliconMine2_Maintenance,
        accIdx_SiliconMine2,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // ironMine
      with TMetaAccount.Create(
        accIdx_ironMine,
        accIdx_Industries,
        'ironMine',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ironMine_Products,
        accIdx_ironMine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ironMine_Supplies,
        accIdx_ironMine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ironMine_Salaries,
        accIdx_ironMine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ironMine_Maintenance,
        accIdx_ironMine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      logs.Log('stdaccounts','ironmine');
    // leather jacket
      with TMetaAccount.Create(
        accIdx_leatherjacket,
        accIdx_Industries,
        'leatherjacket',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacket_Products,
        accIdx_leatherjacket,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacket_Supplies,
        accIdx_leatherjacket,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacket_Salaries,
        accIdx_leatherjacket,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacket_Maintenance,
        accIdx_leatherjacket,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // leather
      with TMetaAccount.Create(
        accIdx_leather,
        accIdx_Industries,
        'leather',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leather_Products,
        accIdx_leather,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leather_Supplies,
        accIdx_leather,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leather_Salaries,
        accIdx_leather,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leather_Maintenance,
        accIdx_leather,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // miningchem
      with TMetaAccount.Create(
        accIdx_miningchem,
        accIdx_Industries,
        'miningchem',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_miningchem_Products,
        accIdx_miningchem,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_miningchem_Supplies,
        accIdx_miningchem,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_miningchem_Salaries,
        accIdx_miningchem,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_miningchem_Maintenance,
        accIdx_miningchem,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // rawChemMine
      with TMetaAccount.Create(
        accIdx_rawChemMine,
        accIdx_Industries,
        'rawChemMine',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rawChemMine_Products,
        accIdx_rawChemMine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rawChemMine_Supplies,
        accIdx_rawChemMine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rawChemMine_Salaries,
        accIdx_rawChemMine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rawChemMine_Maintenance,
        accIdx_rawChemMine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // burgerfact
      with TMetaAccount.Create(
        accIdx_burgerfact,
        accIdx_Industries,
        'burgerfact',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerfact_Products,
        accIdx_burgerfact,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerfact_Supplies,
        accIdx_burgerfact,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerfact_Salaries,
        accIdx_burgerfact,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerfact_Maintenance,
        accIdx_burgerfact,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // Cattlefarma
      with TMetaAccount.Create(
        accIdx_Cattlefarma,
        accIdx_Industries,
        'Cattlefarma',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Cattlefarma_Products,
        accIdx_Cattlefarma,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Cattlefarma_Supplies,
        accIdx_Cattlefarma,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Cattlefarma_Salaries,
        accIdx_Cattlefarma,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Cattlefarma_Maintenance,
        accIdx_Cattlefarma,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // shirt
      with TMetaAccount.Create(
        accIdx_shirt,
        accIdx_Industries,
        'shirt',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirt_Products,
        accIdx_shirt,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirt_Supplies,
        accIdx_shirt,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirt_Salaries,
        accIdx_shirt,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirt_Maintenance,
        accIdx_shirt,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // nylon
      with TMetaAccount.Create(
        accIdx_nylon,
        accIdx_Industries,
        'nylon',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_nylon_Products,
        accIdx_nylon,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_nylon_Supplies,
        accIdx_nylon,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_nylon_Salaries,
        accIdx_nylon,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_nylon_Maintenance,
        accIdx_nylon,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // polymer
      with TMetaAccount.Create(
        accIdx_polymer,
        accIdx_Industries,
        'polymer',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_polymer_Products,
        accIdx_polymer,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_polymer_Supplies,
        accIdx_polymer,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_polymer_Salaries,
        accIdx_polymer,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_polymer_Maintenance,
        accIdx_polymer,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // organicMine
      with TMetaAccount.Create(
        accIdx_organicMine,
        accIdx_Industries,
        'organicMine',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicMine_Products,
        accIdx_organicMine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicMine_Supplies,
        accIdx_organicMine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicMine_Salaries,
        accIdx_organicMine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicMine_Maintenance,
        accIdx_organicMine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // stewfact
      with TMetaAccount.Create(
        accIdx_stewfact,
        accIdx_Industries,
        'stewfact',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewfact_Products,
        accIdx_stewfact,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewfact_Supplies,
        accIdx_stewfact,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewfact_Salaries,
        accIdx_stewfact,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewfact_Maintenance,
        accIdx_stewfact,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // vegfarm a
      with TMetaAccount.Create(
        accIdx_vegfarma,
        accIdx_Industries,
        'vegfarma',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_vegfarma_Products,
        accIdx_vegfarma,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_vegfarma_Supplies,
        accIdx_vegfarma,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_vegfarma_Salaries,
        accIdx_vegfarma,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_vegfarma_Maintenance,
        accIdx_vegfarma,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    // fruitfarm a
      with TMetaAccount.Create(
        accIdx_fruitfarma,
        accIdx_Industries,
        'fruitfarma',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitfarma_Products,
        accIdx_fruitfarma,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitfarma_Supplies,
        accIdx_fruitfarma,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitfarma_Salaries,
        accIdx_fruitfarma,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitfarma_Maintenance,
        accIdx_fruitfarma,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    //shoefact
    with TMetaAccount.Create(
        accIdx_shoefact,
        accIdx_Industries,
        'shoefact',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoefact_Products,
        accIdx_shoefact,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoefact_Supplies,
        accIdx_shoefact,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoefact_Salaries,
        accIdx_shoefact,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoefact_Maintenance,
        accIdx_shoefact,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

    // rubberfact
    with TMetaAccount.Create(
        accIdx_rubberfact,
        accIdx_Industries,
        'rubberfact',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubberfact_Products,
        accIdx_rubberfact,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubberfact_Supplies,
        accIdx_rubberfact,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubberfact_Salaries,
        accIdx_rubberfact,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubberfact_Maintenance,
        accIdx_rubberfact,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

    // rubbersap
    with TMetaAccount.Create(
        accIdx_rubbersap,
        accIdx_Industries,
        'rubbersap',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbersap_Products,
        accIdx_rubbersap,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbersap_Supplies,
        accIdx_rubbersap,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbersap_Salaries,
        accIdx_rubbersap,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbersap_Maintenance,
        accIdx_rubbersap,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

    // rubbertree
    with TMetaAccount.Create(
        accIdx_rubbertree,
        accIdx_Industries,
        'rubbertree',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbertree_Products,
        accIdx_rubbertree,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbertree_Supplies,
        accIdx_rubbertree,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbertree_Salaries,
        accIdx_rubbertree,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_rubbertree_Maintenance,
        accIdx_rubbertree,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

    // fruitpie
    with TMetaAccount.Create(
        accIdx_fruitpie,
        accIdx_Industries,
        'fruitpie',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitpie_Products,
        accIdx_fruitpie,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitpie_Supplies,
        accIdx_fruitpie,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitpie_Salaries,
        accIdx_fruitpie,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fruitpie_Maintenance,
        accIdx_fruitpie,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      logs.Log('stdaccounts','doing commerce');

     //put com here   cookerStore
     //  humveestore
      with TMetaAccount.Create(
        accIdx_cookerStore,
        accIdx_Commerce,
        'cookerStore',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cookerStore_Sales,
        accIdx_cookerStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cookerStore_Supplies,
        accIdx_cookerStore,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cookerStore_Salaries,
        accIdx_cookerStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cookerStore_Maintenance,
        accIdx_cookerStore,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
     //  humveestore
      with TMetaAccount.Create(
        accIdx_humveestore,
        accIdx_Commerce,
        'humveestore',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humveestore_Sales,
        accIdx_humveestore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humveestore_Supplies,
        accIdx_humveestore,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humveestore_Salaries,
        accIdx_humveestore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_humveestore_Maintenance,
        accIdx_humveestore,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
     //  motorbikestore
      with TMetaAccount.Create(
        accIdx_motorbikestore,
        accIdx_Commerce,
        'motorbikestore',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbikestore_Sales,
        accIdx_motorbikestore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbikestore_Supplies,
        accIdx_motorbikestore,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbikestore_Salaries,
        accIdx_motorbikestore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_motorbikestore_Maintenance,
        accIdx_motorbikestore,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
     // mobilestore
      with TMetaAccount.Create(
        accIdx_mobileStore,
        accIdx_Commerce,
        'mobileStore',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mobileStore_Sales,
        accIdx_mobileStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mobileStore_Supplies,
        accIdx_mobileStore,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mobileStore_Salaries,
        accIdx_mobileStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mobileStore_Maintenance,
        accIdx_mobileStore,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // Sportscarstore
      with TMetaAccount.Create(
        accIdx_Sportscarstore,
        accIdx_Commerce,
        'Sportscarstore',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Sportscarstore_Sales,
        accIdx_Sportscarstore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Sportscarstore_Supplies,
        accIdx_Sportscarstore,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Sportscarstore_Salaries,
        accIdx_Sportscarstore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Sportscarstore_Maintenance,
        accIdx_Sportscarstore,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       // smallcar
      with TMetaAccount.Create(
        accIdx_Smallcarstore,
        accIdx_Commerce,
        'Smallcarstore',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcarstore_Sales,
        accIdx_Smallcarstore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcarstore_Supplies,
        accIdx_Smallcarstore,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcarstore_Salaries,
        accIdx_Smallcarstore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Smallcarstore_Maintenance,
        accIdx_Smallcarstore,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // TVStore
      with TMetaAccount.Create(
        accIdx_TVStore,
        accIdx_Commerce,
        'TVStore',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TVStore_Sales,
        accIdx_TVStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TVStore_Supplies,
        accIdx_TVStore,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TVStore_Salaries,
        accIdx_TVStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TVStore_Maintenance,
        accIdx_TVStore,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       logs.Log('stdaccounts','end new commerce');
      // burgerbar
      with TMetaAccount.Create(
        accIdx_burgerbar,
        accIdx_Commerce,
        'burgerbar',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerbar_Sales,
        accIdx_burgerbar,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerbar_Supplies,
        accIdx_burgerbar,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerbar_Salaries,
        accIdx_burgerbar,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_burgerbar_Maintenance,
        accIdx_burgerbar,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
        logs.Log('stdaccounts','bbar');
      // leatherjacketShop
      with TMetaAccount.Create(
        accIdx_leatherjacketShop,
        accIdx_Commerce,
        'leatherjacketShop',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacketShop_Sales,
        accIdx_leatherjacketShop,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacketShop_Supplies,
        accIdx_leatherjacketShop,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacketShop_Salaries,
        accIdx_leatherjacketShop,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_leatherjacketShop_Maintenance,
        accIdx_leatherjacketShop,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
        logs.Log('stdaccounts','ljshop');

      // stew Shop
      with TMetaAccount.Create(
        accIdx_stewShop,
        accIdx_Commerce,
        'stewShop',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewShop_Sales,
        accIdx_stewShop,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewShop_Supplies,
        accIdx_stewShop,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewShop_Salaries,
        accIdx_stewShop,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_stewShop_Maintenance,
        accIdx_stewShop,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       logs.Log('stdaccounts','stew');
      // shirtShop
      with TMetaAccount.Create(
        accIdx_shirtShop,
        accIdx_Commerce,
        'shirtShop',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirtShop_Sales,
        accIdx_shirtShop,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirtShop_Supplies,
        accIdx_shirtShop,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirtShop_Salaries,
        accIdx_shirtShop,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shirtShop_Maintenance,
        accIdx_shirtShop,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       logs.Log('stdaccounts','shirt');
      // shoe shop
      with TMetaAccount.Create(
        accIdx_shoeshop,
        accIdx_Commerce,
        'shoeshop',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoeshop_Sales,
        accIdx_shoeshop,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoeshop_Supplies,
        accIdx_shoeshop,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoeshop_Salaries,
        accIdx_shoeshop,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_shoeshop_Maintenance,
        accIdx_shoeshop,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      logs.Log('stdaccounts','shoe');
      // fruitpie shop
      with TMetaAccount.Create(
        accIdx_pieShop,
        accIdx_Commerce,
        'pieShop',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pieShop_Sales,
        accIdx_pieShop,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pieShop_Supplies,
        accIdx_pieShop,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pieShop_Salaries,
        accIdx_pieShop,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_pieShop_Maintenance,
        accIdx_pieShop,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      logs.Log('stdaccounts','pie');
    // bakery
      with TMetaAccount.Create(
        accIdx_bakery,
        accIdx_Commerce,
        'bakery',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bakery_Sales,
        accIdx_bakery,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bakery_Supplies,
        accIdx_bakery,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bakery_Salaries,
        accIdx_bakery,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_bakery_Maintenance,
        accIdx_bakery,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      logs.Log('stdaccounts','bake');
    // trouser shop
      with TMetaAccount.Create(
        accIdx_trousershop,
        accIdx_Commerce,
        'trouser shop',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trousershop_Sales,
        accIdx_trousershop,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trousershop_Supplies,
        accIdx_trousershop,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trousershop_Salaries,
        accIdx_trousershop,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trousershop_Maintenance,
        accIdx_trousershop,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      logs.Log('stdaccounts','tshop');
    // trouser
      with TMetaAccount.Create(
        accIdx_trouser,
        accIdx_Industries,
        'trouser',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trouser_Products,
        accIdx_trouser,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trouser_Supplies,
        accIdx_trouser,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trouser_Salaries,
        accIdx_trouser,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_trouser_Maintenance,
        accIdx_trouser,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       logs.Log('stdaccounts','trouser indy');
    // cotton
      with TMetaAccount.Create(
        accIdx_cotton,
        accIdx_Industries,
        'cotton',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cotton_Products,
        accIdx_cotton,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cotton_Supplies,
        accIdx_cotton,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cotton_Salaries,
        accIdx_cotton,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_cotton_Maintenance,
        accIdx_cotton,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
     logs.Log('stdaccounts','cotton');
    // mill
      with TMetaAccount.Create(
        accIdx_mill,
        accIdx_Industries,
        'mill',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mill_Products,
        accIdx_mill,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mill_Supplies,
        accIdx_mill,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mill_Salaries,
        accIdx_mill,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_mill_Maintenance,
        accIdx_mill,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       logs.Log('stdaccounts','mill');
    // grainfarma
      with TMetaAccount.Create(
        accIdx_grainfarma,
        accIdx_Industries,
        'grainfarma',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_grainfarma_Products,
        accIdx_grainfarma,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_grainfarma_Supplies,
        accIdx_grainfarma,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_grainfarma_Salaries,
        accIdx_grainfarma,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_grainfarma_Maintenance,
        accIdx_grainfarma,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      logs.Log('stdaccounts','grain');
    // fert
      with TMetaAccount.Create(
        accIdx_fert,
        accIdx_Industries,
        'fert',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fert_Products,
        accIdx_fert,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fert_Supplies,
        accIdx_fert,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fert_Salaries,
        accIdx_fert,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_fert_Maintenance,
        accIdx_fert,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       logs.Log('stdaccounts','fert');
      // organicwaste
      with TMetaAccount.Create(
        accIdx_organicwaste,
        accIdx_Industries,
        'Organic Waste',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicwaste_Products,
        accIdx_organicwaste,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicwaste_Supplies,
        accIdx_organicwaste,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicwaste_Salaries,
        accIdx_organicwaste,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_organicwaste_Maintenance,
        accIdx_organicwaste,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
    {$ENDIF}
    logs.Log('stdaccounts','start both stuff 1');
    // LumberMill
      with TMetaAccount.Create(
        accIdx_LumberMill,
        accIdx_Industries,
        'Lumber Mills',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LumberMill_Products,
        accIdx_LumberMill,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LumberMill_Supplies,
        accIdx_LumberMill,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LumberMill_Salaries,
        accIdx_LumberMill,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LumberMill_Maintenance,
        accIdx_LumberMill,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
     // MovieStudios
      with TMetaAccount.Create(
        accIdx_MovieStudios,
        accIdx_Industries,
        'Movie Studios',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MovieStudios_Products,
        accIdx_MovieStudios,
        'Licences revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MovieStudios_Supplies,
        accIdx_MovieStudios,
        'Cost of materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MovieStudios_Salaries,
        accIdx_MovieStudios,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MovieStudios_Maintenance,
        accIdx_MovieStudios,
        'Production costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // PlasticIndustry
      with TMetaAccount.Create(
        accIdx_PlasticIndustry,
        accIdx_Industries,
        'Plastics',
        '',
        TAccount ) do
        begin
          Rankeable := true;
          Taxable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PlasticIndustry_Products,
        accIdx_PlasticIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PlasticIndustry_Supplies,
        accIdx_PlasticIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PlasticIndustry_Salaries,
        accIdx_PlasticIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PlasticIndustry_Maintenance,
        accIdx_PlasticIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // OilRig
      with TMetaAccount.Create(
        accIdx_OilRig,
        accIdx_Industries,
        'Oil rigs',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_OilRig_Products,
        accIdx_OilRig,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_OilRig_Supplies,
        accIdx_OilRig,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_OilRig_Salaries,
        accIdx_OilRig,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_OilRig_Maintenance,
        accIdx_OilRig,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Refinery
      with TMetaAccount.Create(
        accIdx_Refinery,
        accIdx_Industries,
        'Refineries',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Refinery_Products,
        accIdx_Refinery,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Refinery_Supplies,
        accIdx_Refinery,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Refinery_Salaries,
        accIdx_Refinery,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Refinery_Maintenance,
        accIdx_Refinery,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
     logs.Log('stdaccounts','end both stuff 1');
    //oldstuff
    {$ifdef oldbuild}
      // Farms
      with TMetaAccount.Create(
        accIdx_Farms,
        accIdx_Industries,
        'Farms',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Farms_Products,
        accIdx_Farms,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Farms_Supplies,
        accIdx_Farms,
        'Cost of raw materials',  // Cost of raw materials // Cost of goods sold // Sales revenue
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Farms_Salaries,
        accIdx_Farms,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Farms_Maintenance,
        accIdx_Farms,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

    // BusinessMachines
      with TMetaAccount.Create(
        accIdx_BusinessMachines,
        accIdx_Industries,
        'Business Machines',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_BusinessMachines_Products,
        accIdx_BusinessMachines,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_BusinessMachines_Supplies,
        accIdx_BusinessMachines,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_BusinessMachines_Salaries,
        accIdx_BusinessMachines,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_BusinessMachines_Maintenance,
        accIdx_BusinessMachines,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // CarIndustry
      with TMetaAccount.Create(
        accIdx_CarIndustry,
        accIdx_Industries,
        'Car industries',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CarIndustry_Products,
        accIdx_CarIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CarIndustry_Supplies,
        accIdx_CarIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CarIndustry_Salaries,
        accIdx_CarIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CarIndustry_Maintenance,
        accIdx_CarIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Chemical
      with TMetaAccount.Create(
        accIdx_Chemical,
        accIdx_Industries,
        'Chemical plants',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Chemical_Products,
        accIdx_Chemical,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Chemical_Supplies,
        accIdx_Chemical,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Chemical_Salaries,
        accIdx_Chemical,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Chemical_Maintenance,
        accIdx_Chemical,
        'Operating costs',                                
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // ClotheIndustry
      with TMetaAccount.Create(
        accIdx_ClotheIndustry,
        accIdx_Industries,
        'Clothes',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ClotheIndustry_Products,
        accIdx_ClotheIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ClotheIndustry_Supplies,
        accIdx_ClotheIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ClotheIndustry_Salaries,
        accIdx_ClotheIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ClotheIndustry_Maintenance,
        accIdx_ClotheIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // ConstIndustry
      with TMetaAccount.Create(
        accIdx_ConstIndustry,
        accIdx_Industries,
        'Construction',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ConstIndustry_Products,
        accIdx_ConstIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ConstIndustry_Supplies,
        accIdx_ConstIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ConstIndustry_Salaries,
        accIdx_ConstIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ConstIndustry_Maintenance,
        accIdx_ConstIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // ElectIndustry
      with TMetaAccount.Create(
        accIdx_ElectIndustry,
        accIdx_Industries,
        'Electronic',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ElectIndustry_Products,
        accIdx_ElectIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ElectIndustry_Supplies,
        accIdx_ElectIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ElectIndustry_Salaries,
        accIdx_ElectIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ElectIndustry_Maintenance,
        accIdx_ElectIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // FoodProc
      with TMetaAccount.Create(
        accIdx_FoodProc,
        accIdx_Industries,
        'Food Processing',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FoodProc_Products,
        accIdx_FoodProc,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FoodProc_Supplies,
        accIdx_FoodProc,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FoodProc_Salaries,
        accIdx_FoodProc,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FoodProc_Maintenance,
        accIdx_FoodProc,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // LiquorFact
      with TMetaAccount.Create(
        accIdx_LiquorFact,
        accIdx_Industries,
        'Liquor Production',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LiquorFact_Products,
        accIdx_LiquorFact,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LiquorFact_Supplies,
        accIdx_LiquorFact,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LiquorFact_Salaries,
        accIdx_LiquorFact,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LiquorFact_Maintenance,
        accIdx_LiquorFact,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      

      // FurnitureIndustry
      with TMetaAccount.Create(
        accIdx_FurnitureIndustry,
        accIdx_Industries,
        'Furniture',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FurnitureIndustry_Products,
        accIdx_FurnitureIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FurnitureIndustry_Supplies,
        accIdx_FurnitureIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FurnitureIndustry_Salaries,
        accIdx_FurnitureIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FurnitureIndustry_Maintenance,
        accIdx_FurnitureIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // PaperIndustry
      with TMetaAccount.Create(
        accIdx_PaperIndustry,
        accIdx_Industries,
        'Paper',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PaperIndustry_Products,
        accIdx_PaperIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PaperIndustry_Supplies,
        accIdx_PaperIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PaperIndustry_Salaries,
        accIdx_PaperIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PaperIndustry_Maintenance,
        accIdx_PaperIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // PrintingPlant
      with TMetaAccount.Create(
        accIdx_PrintingPlant,
        accIdx_Industries,
        'Books',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PrintingPlant_Products,
        accIdx_PrintingPlant,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PrintingPlant_Supplies,
        accIdx_PrintingPlant,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PrintingPlant_Salaries,
        accIdx_PrintingPlant,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PrintingPlant_Maintenance,
        accIdx_PrintingPlant,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // CDPlant
      with TMetaAccount.Create(
        accIdx_CDPlant,
        accIdx_Industries,
        'CD',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CDPlant_Products,
        accIdx_CDPlant,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CDPlant_Supplies,
        accIdx_CDPlant,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CDPlant_Salaries,
        accIdx_CDPlant,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CDPlant_Maintenance,
        accIdx_CDPlant,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;



      // HeavyIndustry
      with TMetaAccount.Create(
        accIdx_HeavyIndustry,
        accIdx_Industries,
        'Heavy industry',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HeavyIndustry_Products,
        accIdx_HeavyIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HeavyIndustry_Supplies,
        accIdx_HeavyIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HeavyIndustry_Salaries,
        accIdx_HeavyIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HeavyIndustry_Maintenance,
        accIdx_HeavyIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // HHAIndustry
      with TMetaAccount.Create(
        accIdx_HHAIndustry,
        accIdx_Industries,
        'Household',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HHAIndustry_Products,
        accIdx_HHAIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HHAIndustry_Supplies,
        accIdx_HHAIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HHAIndustry_Salaries,
        accIdx_HHAIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HHAIndustry_Maintenance,
        accIdx_HHAIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // MetalIndustry
      with TMetaAccount.Create(
        accIdx_MetalIndustry,
        accIdx_Industries,
        'Metallurgic industry',
        '',
        TAccount ) do
        begin
          Rankeable := true;
          Taxable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MetalIndustry_Products,
        accIdx_MetalIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MetalIndustry_Supplies,
        accIdx_MetalIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MetalIndustry_Salaries,
        accIdx_MetalIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_MetalIndustry_Maintenance,
        accIdx_MetalIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      

      // Mine
      with TMetaAccount.Create(
        accIdx_Mine,
        accIdx_Industries,
        'Mines',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Mine_Products,
        accIdx_Mine,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Mine_Supplies,
        accIdx_Mine,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Mine_Salaries,
        accIdx_Mine,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Mine_Maintenance,
        accIdx_Mine,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      
      // Textile Industry
      with TMetaAccount.Create(
        accIdx_TextileIndustry,
        accIdx_Industries,
        'Textile industry',
        '',
        TAccount ) do
        begin
          Rankeable := true;
          Taxable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TextileIndustry_Products,
        accIdx_TextileIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TextileIndustry_Supplies,
        accIdx_TextileIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TextileIndustry_Salaries,
        accIdx_TextileIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TextileIndustry_Maintenance,
        accIdx_TextileIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      



      // Pharmaceutics
      with TMetaAccount.Create(
        accIdx_PharmaIndustry,
        accIdx_Industries,
        'Pharmaceutics',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PharmaIndustry_Products,
        accIdx_PharmaIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PharmaIndustry_Supplies,
        accIdx_PharmaIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PharmaIndustry_Salaries,
        accIdx_PharmaIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_PharmaIndustry_Maintenance,
        accIdx_PharmaIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Toys
      with TMetaAccount.Create(
        accIdx_ToyIndustry,
        accIdx_Industries,
        'Toys',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ToyIndustry_Products,
        accIdx_ToyIndustry,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ToyIndustry_Supplies,
        accIdx_ToyIndustry,
        'Cost of raw materials',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ToyIndustry_Salaries,
        accIdx_ToyIndustry,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ToyIndustry_Maintenance,
        accIdx_ToyIndustry,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       {$endif}
       // Computing
      with TMetaAccount.Create(
        accIdx_Computing,
        accIdx_Firms,
        'Software',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Computing_Products,
        accIdx_Computing,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Computing_Supplies,
        accIdx_Computing,
        'Cost of services',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Computing_Salaries,
        accIdx_Computing,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Computing_Maintenance,
        accIdx_Computing,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
         // Legal Services
      with TMetaAccount.Create(
        accIdx_LegalServices,
        accIdx_Firms,
        'Legal Services',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LegalServices_Products,
        accIdx_LegalServices,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LegalServices_Supplies,
        accIdx_LegalServices,
        'Cost of services',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LegalServices_Salaries,
        accIdx_LegalServices,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_LegalServices_Maintenance,
        accIdx_LegalServices,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // Warehouses
      with TMetaAccount.Create(                       
        accIdx_Warehouses,
        accIdx_Special,
        'Warehouses',
        '',
        TAccount ) do
        begin
          Rankeable := true;
          Taxable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Warehouses_Products,
        accIdx_Warehouses,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Warehouses_Supplies,
        accIdx_Warehouses,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Warehouses_Salaries,
        accIdx_Warehouses,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Warehouses_Maintenance,
        accIdx_Warehouses,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      {$ifdef oldbuild}
     // Cars
      with TMetaAccount.Create(
        accIdx_CarStore,
        accIdx_Commerce,
        'Cars',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CarStore_Sales,
        accIdx_CarStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CarStore_Supplies,
        accIdx_CarStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CarStore_Salaries,
        accIdx_CarStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Clothes Shop
      with TMetaAccount.Create(
        accIdx_ClothesStore,
        accIdx_Commerce,
        'Clothes',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ClothesStore_Sales,
        accIdx_ClothesStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ClothesStore_Supplies,
        accIdx_ClothesStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ClothesStore_Salaries,
        accIdx_ClothesStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

     // FoodStore
      with TMetaAccount.Create(
        accIdx_FoodStore,
        accIdx_Commerce,
        'Food',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FoodStore_Sales,
        accIdx_FoodStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FoodStore_Supplies,
        accIdx_FoodStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FoodStore_Salaries,
        accIdx_FoodStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Bar
      with TMetaAccount.Create(
        accIdx_Bar,
        accIdx_Commerce,
        'Bars',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Bar_Sales,
        accIdx_Bar,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Bar_Supplies,
        accIdx_Bar,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Bar_Salaries,
        accIdx_Bar,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Funeral
      with TMetaAccount.Create(
        accIdx_FuneralParlor,
        accIdx_Commerce,
        'Funerals',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FuneralParlor_Sales,
        accIdx_FuneralParlor,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FuneralParlor_Supplies,
        accIdx_FuneralParlor,
        'Cost of funeral',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FuneralParlor_Salaries,
        accIdx_FuneralParlor,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // HHA Store
      with TMetaAccount.Create(
        accIdx_HHAStore,
        accIdx_Commerce,
        'Household Appliances',                   
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HHAStore_Sales,
        accIdx_HHAStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HHAStore_Supplies,
        accIdx_HHAStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_HHAStore_Salaries,
        accIdx_HHAStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Toy Store
      with TMetaAccount.Create(
        accIdx_ToyStore,
        accIdx_Commerce,
        'Toys',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ToyStore_Sales,
        accIdx_ToyStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ToyStore_Supplies,
        accIdx_ToyStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ToyStore_Salaries,
        accIdx_ToyStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Furniture Store
      with TMetaAccount.Create(
        accIdx_FurnitureStore,
        accIdx_Commerce,
        'Furniture',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FurnitureStore_Sales,
        accIdx_FurnitureStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FurnitureStore_Supplies,
        accIdx_FurnitureStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_FurnitureStore_Salaries,
        accIdx_FurnitureStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Book Store
      with TMetaAccount.Create(
        accIdx_BookStore,
        accIdx_Commerce,
        'Books',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_BookStore_Sales,
        accIdx_BookStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_BookStore_Supplies,
        accIdx_BookStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_BookStore_Salaries,
        accIdx_BookStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // CD Store
      with TMetaAccount.Create(
        accIdx_CDStore,
        accIdx_Commerce,
        'CDs',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CDStore_Sales,
        accIdx_CDStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CDStore_Supplies,
        accIdx_CDStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_CDStore_Salaries,
        accIdx_CDStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

      // Computer Store
      with TMetaAccount.Create(
        accIdx_ComputerStore,
        accIdx_Commerce,
        'Computers',                      
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ComputerStore_Sales,
        accIdx_ComputerStore,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ComputerStore_Supplies,
        accIdx_ComputerStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_ComputerStore_Salaries,
        accIdx_ComputerStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;

     

    // Restaurant
      with TMetaAccount.Create(
        accIdx_Restaurant,
        accIdx_Commerce,
        'Restaurants',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Restaurant_Sales,
        accIdx_Restaurant,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Restaurant_Supplies,
        accIdx_Restaurant,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Restaurant_Salaries,
        accIdx_Restaurant,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // Drug store
      with TMetaAccount.Create(
        accIdx_DrugStore,
        accIdx_Commerce,
        'Drug Stores',
        '',
        TAccount ) do
        begin
          Rankeable := true;
          Taxable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_DrugStore_Sales,
        accIdx_DrugStore,
        'Sales revenues',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_DrugStore_Supplies,
        accIdx_DrugStore,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_DrugStore_Salaries,
        accIdx_DrugStore,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      {$endif}
      logs.Log('stdaccounts','old stuff over');
       // Super Market
      with TMetaAccount.Create(
        accIdx_SuperMarket,
        accIdx_Commerce,
        'Supermarkets',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_SuperMarket_Sales,
        accIdx_SuperMarket,
        'Sales revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_SuperMarket_Supplies,
        accIdx_SuperMarket,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_SuperMarket_Salaries,
        accIdx_SuperMarket,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // Gas station
      with TMetaAccount.Create(
        accIdx_GasStation,
        accIdx_Commerce,
        'Gas Stations',
        '',
        TAccount ) do
        begin
          Rankeable := true;
          Taxable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_GasStation_Sales,
        accIdx_GasStation,
        'Revenues',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_GasStation_Supplies,
        accIdx_GasStation,
        'Cost of goods sold',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_GasStation_Salaries,
        accIdx_GasStation,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       // Movie
      with TMetaAccount.Create(
        accIdx_Movie,
        accIdx_Commerce,
        'Movie Theaters',
        '',
        TAccount ) do
        begin
          Rankeable := true;
          Taxable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Movie_Sales,
        accIdx_Movie,
        'Movie revenues',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Movie_Supplies,
        accIdx_Movie,
        'Cost of movie licenses',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_Movie_Salaries,
        accIdx_Movie,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      // TV
      with TMetaAccount.Create(
        accIdx_TV,
        accIdx_Special,
        'TV',
        '',
        TAccount ) do
        begin
          Taxable := true;
          Rankeable := true;
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TV_Products,
        accIdx_TV,
        'Advertisement revenue',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TV_Supplies,
        accIdx_TV,
        'Production costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TV_Salaries,
        accIdx_TV,
        'Salaries',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
      with TMetaAccount.Create(
        accIdx_TV_Maintenance,
        accIdx_TV,
        'Operating costs',
        '',
        TAccount ) do
        begin
          Register( tidClassFamily_Accounts );
        end;
       logs.Log('stdaccounts','end');
    end;

end.


