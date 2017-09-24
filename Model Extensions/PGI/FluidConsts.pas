unit FluidConsts;

interface

  const
    //new stuff     servers
    // servers
    cost_servers = 70000000;
    budget_servers = 5756.2755;
    input_servers_Metal = 22;
    input_servers_Electroniccomponents = 62;
    input_servers_Chemicals = 23;
    input_servers_Plastics = 18;
    input_servers_ExecutivesWorkForce = 2;
    input_servers_ProfessionalWorkForce = 13;
    input_servers_Workers = 158;
    input_servers_ComputerServices = 2.5;
    input_servers_LegalServices = 0.5;

    output_servers_BusinessMachines = 12.5;
    // machineindy2
    cost_machineindy2 = 70000000;
    budget_machineindy2 = 3062.7755;
    input_machineindy2_Metal = 1500;
    input_machineindy2_Chemicals = 125;
    input_machineindy2_ElectronicComponents = 50;
    input_machineindy2_ExecutivesWorkForce = 2;
    input_machineindy2_ProfessionalWorkForce = 8;
    input_machineindy2_Workers = 190;
    input_machineindy2_ComputerServices = 0.5;
    input_machineindy2_LegalServices = 0.25;

    output_machineindy2_Machinery = 12.5;
    // concrete
    cost_concrete = 73500000;
    budget_concrete = 1881.1393;
    input_concrete_Ore = 300;
    input_concrete_Metal = 62;
    input_concrete_Chemicals = 62;
    input_concrete_Timber = 200;
    input_concrete_ExecutivesWorkForce = 0;
    input_concrete_ProfessionalWorkForce = 6;
    input_concrete_Workers = 237;
    input_concrete_ComputerServices = 1;
    input_concrete_LegalServices = 0.25;

    output_concrete_Construction = 50;
    // PCs small
    cost_PCssmall = 14400000;
    budget_PCssmall = 448.8083;
    input_PCssmall_Metal = 24;
    input_PCssmall_Electroniccomponents = 20;
    input_PCssmall_Chemicals = 8;
    input_PCsSmall_Plastics = 10;
    input_PCssmall_ExecutivesWorkForce = 1;
    input_PCssmall_ProfessionalWorkForce = 4;
    input_PCssmall_Workers = 107;
    input_PCssmall_ComputerServices = 0.320000022649765;
    input_PCssmall_LegalServices = 0.160000011324882;

    output_PCssmall_HouseHoldingAppliances = 9.60000038146973;
    // PCs
    cost_PCs = 63000000;
    budget_PCs = 1381.5479;
    input_PCs_Metal = 85;
    input_PCs_Electroniccomponents = 62;
    input_PCs_Chemicals = 25;
    input_PCs_Plastics = 27;
    input_PCs_ExecutivesWorkForce = 2;
    input_PCs_ProfessionalWorkForce = 6;
    input_PCs_Workers = 190;
    input_PCs_ComputerServices = 1;
    input_PCs_LegalServices = 0.5;

    output_PCs_HouseHoldingAppliances = 30;
    // sportscar
    cost_sportscar = 70000000;
    budget_sportscar = 1542.7755;
    input_sportscar_Metal = 500;
    input_sportscar_FabricsandThreads = 45;
    input_sportscar_Electroniccomponents = 20;
    input_sportscar_Chemicals = 25;
    input_sportscar_Plastics = 4;
    input_sportscar_ExecutivesWorkForce = 2;
    input_sportscar_ProfessionalWorkForce = 5;
    input_sportscar_Workers = 297;
    input_sportscar_ComputerServices = 2.5;
    input_sportscar_LegalServices = 0.75;

    output_sportscar_Nicecars = 0.75;
     // CPU small
    cost_CPUsmall = 14400000;
    budget_CPUsmall = 11.8083;
    input_CPUsmall_Chemicals = 10;
    input_CPUsmall_Metal = 16;
    input_CPUsmall_Metal2 = 16;
    input_CPUsmall_ExecutivesWorkForce = 1;
    input_CPUsmall_ProfessionalWorkForce = 5;
    input_CPUsmall_Workers = 72;
    input_CPUsmall_ComputerServices = 0.200000002980232;
    input_CPUsmall_LegalServices = 0.240000009536743;

    output_CPUsmall_Electroniccomponents = 20.8000011444092;
    // CPU
    cost_CPU = 63000000;
    budget_CPU = 0;
    input_CPU_Chemicals = 30;
    input_CPU_Metal = 50;
    input_CPU_Metal2 = 50;
    input_CPU_ExecutivesWorkForce = 2;
    input_CPU_ProfessionalWorkForce = 9;
    input_CPU_Workers = 126;
    input_CPU_ComputerServices = 0.625;
    input_CPU_LegalServices = 0.75;

    output_CPU_Electroniccomponents = 65;
    // copperIndustry small
    cost_copperIndustrysmall = 16000000;
    budget_copperIndustrysmall = 46.6758;
    input_copperIndustrysmall_Ore = 192;
    input_copperIndustrysmall_Chemicals = 14;
    input_copperIndustrysmall_ExecutivesWorkForce = 0;
    input_copperIndustrysmall_ProfessionalWorkForce = 2;
    input_copperIndustrysmall_Workers = 98;
    input_copperIndustrysmall_ComputerServices = 0.160000011324882;
    input_copperIndustrysmall_LegalServices = 0.0800000056624413;

    output_copperIndustrysmall_Metal = 96;
    // copperIndustry
    cost_copperIndustry = 70000000;
    budget_copperIndustry = 18.7755;
    input_copperIndustry_Ore = 600;
    input_copperIndustry_Chemicals = 45;
    input_copperIndustry_ExecutivesWorkForce = 0;
    input_copperIndustry_ProfessionalWorkForce = 3;
    input_copperIndustry_Workers = 174;
    input_copperIndustry_ComputerServices = 0.5;
    input_copperIndustry_LegalServices = 0.25;

    output_copperIndustry_Metal = 300;
    // pineoil small
    cost_pineoilsmall = 4000000;
    budget_pineoilsmall = 16.1689;
    input_pineoilsmall_Chemicals = 6;
    input_pineoilsmall_ExecutivesWorkForce = 0;
    input_pineoilsmall_ProfessionalWorkForce = 1;
    input_pineoilsmall_Workers = 89;
    input_pineoilsmall_ComputerServices = 0.240000009536743;
    input_pineoilsmall_LegalServices = 0.0800000056624413;

    output_pineoilsmall_Ore = 320;
    // pineoil
    cost_pineoil = 17500000;
    budget_pineoil = 88.3189;
    input_pineoil_Chemicals = 20;
    input_pineoil_ExecutivesWorkForce = 0;
    input_pineoil_ProfessionalWorkForce = 2;
    input_pineoil_Workers = 158;
    input_pineoil_ComputerServices = 0.75;
    input_pineoil_LegalServices = 0.25;

    output_pineoil_Ore = 1000;
    // ceramicMine small
    cost_ceramicMinesmall = 4000000;
    budget_ceramicMinesmall = 16.1689;
    input_ceramicMinesmall_Chemicals = 6;
    input_ceramicMinesmall_ExecutivesWorkForce = 0;
    input_ceramicMinesmall_ProfessionalWorkForce = 1;
    input_ceramicMinesmall_Workers = 89;
    input_ceramicMinesmall_ComputerServices = 0.240000009536743;
    input_ceramicMinesmall_LegalServices = 0.0800000056624413;

    output_ceramicMinesmall_Ore = 320;
    // ceramicMine
    cost_ceramicMine = 17500000;
    budget_ceramicMine = 88.3189;
    input_ceramicMine_Chemicals = 20;
    input_ceramicMine_ExecutivesWorkForce = 0;
    input_ceramicMine_ProfessionalWorkForce = 2;
    input_ceramicMine_Workers = 158;
    input_ceramicMine_ComputerServices = 0.75;
    input_ceramicMine_LegalServices = 0.25;

    output_ceramicMine_Ore = 1000;
    // coppermine small
    cost_copperminesmall = 4000000;
    budget_copperminesmall = 16.1689;
    input_copperminesmall_Chemicals = 6;
    input_copperminesmall_ExecutivesWorkForce = 0;
    input_copperminesmall_ProfessionalWorkForce = 1;
    input_copperminesmall_Workers = 89;
    input_copperminesmall_ComputerServices = 0.240000009536743;
    input_copperminesmall_LegalServices = 0.0800000056624413;

    output_copperminesmall_Ore = 320;
    // coppermine
    cost_coppermine = 17500000;
    budget_coppermine = 88.3189;
    input_coppermine_Chemicals = 20;
    input_coppermine_ExecutivesWorkForce = 0;
    input_coppermine_ProfessionalWorkForce = 2;
    input_coppermine_Workers = 158;
    input_coppermine_ComputerServices = 0.75;
    input_coppermine_LegalServices = 0.25;

    output_coppermine_Ore = 1000;

    // leatherjacket small
    cost_leatherjacketsmall = 6400000;
    budget_leatherjacketsmall = 35.4703;
    input_leatherjacketsmall_FabricsandThreads = 26;
    input_leatherjacketsmall_OrganicMaterials = 6;
    input_leatherjacketsmall_Chemicals = 4;
    input_leatherjacketsmall_ExecutivesWorkForce = 0;
    input_leatherjacketsmall_ProfessionalWorkForce = 1;
    input_leatherjacketsmall_Workers = 72;
    input_leatherjacketsmall_ComputerServices = 0.320000022649765;
    input_leatherjacketsmall_LegalServices = 0.160000011324882;

    output_leatherjacketsmall_Cheapclothing = 24;

     // leatherjacket
    cost_leatherjacket = 28000000;
    budget_leatherjacket = 106.9102;
    input_leatherjacket_FabricsandThreads = 82;
    input_leatherjacket_OrganicMaterials = 20;
    input_leatherjacket_Chemicals = 12;
    input_leatherjacket_ExecutivesWorkForce = 0;
    input_leatherjacket_ProfessionalWorkForce = 2;
    input_leatherjacket_Workers = 126;
    input_leatherjacket_ComputerServices = 1;
    input_leatherjacket_LegalServices = 0.5;

    output_leatherjacket_Cheapclothing = 75;
      // leather small
    cost_leathersmall = 16000000;
    budget_leathersmall = 127.6758;
    input_leathersmall_Ore = 40;
    input_leathersmall_ExecutivesWorkForce = 1;
    input_leathersmall_ProfessionalWorkForce = 5;
    input_leathersmall_Workers = 107;
    input_leathersmall_ComputerServices = 0.320000022649765;
    input_leathersmall_LegalServices = 0.240000009536743;

    output_leathersmall_Chemicals = 40;
    // leather
    cost_leather = 70000000;
    budget_leather = 333.7755;
    input_leather_Ore = 120;
    input_leather_ExecutivesWorkForce = 3;
    input_leather_ProfessionalWorkForce = 12;
    input_leather_Workers = 250;
    input_leather_ComputerServices = 1;
    input_leather_LegalServices = 0.75;

    output_leather_Chemicals = 125;
     // miningchem small
    cost_miningchemsmall = 16000000;
    budget_miningchemsmall = 127.6758;
    input_miningchemsmall_Ore = 320;
    input_miningchemsmall_ExecutivesWorkForce = 1;
    input_miningchemsmall_ProfessionalWorkForce = 5;
    input_miningchemsmall_Workers = 107;
    input_miningchemsmall_ComputerServices = 0.320000022649765;
    input_miningchemsmall_LegalServices = 0.240000009536743;

    output_miningchemsmall_Chemicals = 40;
    // miningchem
    cost_miningchem = 70000000;
    budget_miningchem = 333.7755;
    input_miningchem_Ore = 1000;
    input_miningchem_ExecutivesWorkForce = 2;
    input_miningchem_ProfessionalWorkForce = 9;
    input_miningchem_Workers = 190;
    input_miningchem_ComputerServices = 1;
    input_miningchem_LegalServices = 0.75;

    output_miningchem_Chemicals = 125;

    // rawChemMine small
    cost_rawChemMinesmall = 4000000;
    budget_rawChemMinesmall = 16.1689;
    input_rawChemMinesmall_Chemicals = 6;
    input_rawChemMinesmall_ExecutivesWorkForce = 0;
    input_rawChemMinesmall_ProfessionalWorkForce = 1;
    input_rawChemMinesmall_Workers = 89;
    input_rawChemMinesmall_ComputerServices = 0.240000009536743;
    input_rawChemMinesmall_LegalServices = 0.0800000056624413;

    output_rawChemMinesmall_Ore = 320;
    // rawChemMine
    cost_rawChemMine = 17500000;
    budget_rawChemMine = 88.3189;
    input_rawChemMine_Chemicals = 20;
    input_rawChemMine_ExecutivesWorkForce = 0;
    input_rawChemMine_ProfessionalWorkForce = 2;
    input_rawChemMine_Workers = 158;
    input_rawChemMine_ComputerServices = 0.75;
    input_rawChemMine_LegalServices = 0.25;

    output_rawChemMine_Ore = 1000;
    // burgerfact small
    cost_burgerfactsmall = 4000000;
    budget_burgerfactsmall = 77.3689;
    input_burgerfactsmall_ExecutivesWorkForce = 0;
    input_burgerfactsmall_ProfessionalWorkForce = 1;
    input_burgerfactsmall_Workers = 27;
    input_burgerfactsmall_Chemicals = 10;

    output_burgerfactsmall_FreshFood = 125;
    output_burgerfactsmall_OrganicMaterials = 4;
    // burgerfact
    cost_burgerfact = 17500000;
    budget_burgerfact = 221.8189;
    input_burgerfact_ExecutivesWorkForce = 0;
    input_burgerfact_ProfessionalWorkForce = 2;
    input_burgerfact_Workers = 47;
    input_burgerfact_Chemicals = 30;

    output_burgerfact_FreshFood = 390;
    output_burgerfact_OrganicMaterials = 12.5;
    // Cattlefarma small
    cost_Cattlefarmasmall = 4000000;
    budget_Cattlefarmasmall = 77.3689;
    input_Cattlefarmasmall_ExecutivesWorkForce = 0;
    input_Cattlefarmasmall_ProfessionalWorkForce = 1;
    input_Cattlefarmasmall_Workers = 27;
    input_Cattlefarmasmall_Chemicals = 0.240000009536743;

    output_Cattlefarmasmall_FreshFood = 24;
    output_Cattlefarmasmall_OrganicMaterials = 4;
    // Cattlefarma
    cost_Cattlefarma = 17500000;
    budget_Cattlefarma = 221.8189;
    input_Cattlefarma_ExecutivesWorkForce = 0;
    input_Cattlefarma_ProfessionalWorkForce = 2;
    input_Cattlefarma_Workers = 47;
    input_Cattlefarma_Chemicals = 0.75;

    output_Cattlefarma_FreshFood = 75;
    output_Cattlefarma_OrganicMaterials = 12.5;

    //old stuff
    // Business Machines
    cost_BusinessMachines = 70000000;
    budget_BusinessMachines = 5756.2755;
    input_BusinessMachines_Metal = 22;
    input_BusinessMachines_Electroniccomponents = 62;
    input_BusinessMachines_Chemicals = 23;
    input_BusinessMachines_Plastics = 18;
    input_BusinessMachines_ExecutivesWorkForce = 2;
    input_BusinessMachines_ProfessionalWorkForce = 13;
    input_BusinessMachines_Workers = 158;
    input_BusinessMachines_ComputerServices = 2.5;
    input_BusinessMachines_LegalServices = 0.5;

    output_BusinessMachines_BusinessMachines = 12.5;


    // Car Industry
    cost_CarIndustry = 70000000;
    budget_CarIndustry = 1542.7755;
    input_CarIndustry_Metal = 500;
    input_CarIndustry_FabricsandThreads = 45;
    input_CarIndustry_Electroniccomponents = 20;
    input_CarIndustry_Chemicals = 25;
    input_CarIndustry_Plastics = 25;
    input_CarIndustry_ExecutivesWorkForce = 2;
    input_CarIndustry_ProfessionalWorkForce = 5;
    input_CarIndustry_Workers = 237;
    input_CarIndustry_ComputerServices = 2.5;
    input_CarIndustry_LegalServices = 0.75;

    output_CarIndustry_Nicecars = 0.75;


    // Chemical Plant
    cost_ChemicalPlant = 70000000;
    budget_ChemicalPlant = 333.7755;
    input_ChemicalPlant_Ore = 1000;
    input_ChemicalPlant_ExecutivesWorkForce = 2;
    input_ChemicalPlant_ProfessionalWorkForce = 9;
    input_ChemicalPlant_Workers = 190;
    input_ChemicalPlant_ComputerServices = 1;
    input_ChemicalPlant_LegalServices = 0.75;

    output_ChemicalPlant_Chemicals = 125;


    // Pharmaceutical Industry
    cost_PharmaIndustry = 20000000;
    budget_PharmaIndustry = 133;
    input_PharmaIndustry_ExecutivesWorkForce = 3;
    input_PharmaIndustry_ProfessionalWorkForce = 50;
    input_PharmaIndustry_Workers = 100;
    input_PharmaIndustry_Chemicals = 50;
    input_PharmaIndustry_Plastics  = 50;
    input_PharmaIndustry_ComputerServices = 1;
    input_PharmaIndustry_LegalServices = 0.75;

    output_PharmaIndustry_Drugs = 100;


    // Clothing
    cost_Clothing = 28000000;
    budget_Clothing = 106.9102;
    input_Clothing_FabricsandThreads = 82;
    input_Clothing_OrganicMaterials = 20;
    input_Clothing_Chemicals = 12;
    input_Clothing_ExecutivesWorkForce = 0;
    input_Clothing_ProfessionalWorkForce = 2;
    input_Clothing_Workers = 126;
    input_Clothing_ComputerServices = 1;
    input_Clothing_LegalServices = 0.5;

    output_Clothing_Cheapclothing = 75;


    // Computing Industry
    cost_ComputingIndustry = 52500000;
    budget_ComputingIndustry = 1720.4566;
    input_ComputingIndustry_ExecutivesWorkForce = 3;
    input_ComputingIndustry_ProfessionalWorkForce = 21;
    input_ComputingIndustry_Workers = 16;
    input_ComputingIndustry_LegalServices = 0.20;

    output_ComputingIndustry_ComputerServices = 12.5;


    // Construction
    cost_Construction = 73500000;
    budget_Construction = 1881.1393;
    input_Construction_Ore = 300;
    input_Construction_Metal = 62;
    input_Construction_Chemicals = 62;
    input_Construction_Timber = 200;
    input_Construction_ExecutivesWorkForce = 0;
    input_Construction_ProfessionalWorkForce = 6;
    input_Construction_Workers = 237;
    input_Construction_ComputerServices = 1;
    input_Construction_LegalServices = 0.25;

    output_Construction_Construction = 50;


    // Electronic Industry
    cost_ElectronicIndustry = 63000000;
    budget_ElectronicIndustry = 0;
    input_ElectronicIndustry_Chemicals = 30;
    input_ElectronicIndustry_Metal = 50;
    input_ElectronicIndustry_ExecutivesWorkForce = 2;
    input_ElectronicIndustry_ProfessionalWorkForce = 9;
    input_ElectronicIndustry_Workers = 126;
    input_ElectronicIndustry_ComputerServices = 0.625;
    input_ElectronicIndustry_LegalServices = 0.75;

    output_ElectronicIndustry_Electroniccomponents = 65;


    // Farm
    cost_Farm = 17500000;
    budget_Farm = 221.8189;
    input_Farm_ExecutivesWorkForce = 0;
    input_Farm_ProfessionalWorkForce = 2;
    input_Farm_Workers = 47;
    input_Farm_Chemicals = 0.75;

    output_Farm_FreshFood = 75;
    output_Farm_OrganicMaterials = 12.5;

    // el Farm
    cost_elFarm = 90000000;
    budget_elFarm = 662.8189;
    input_elFarm_ExecutivesWorkForce = 2;
    input_elFarm_ProfessionalWorkForce = 9;
    input_elFarm_Workers = 97;
    input_elFarm_Chemicals = 2;

    output_elFarm_FreshFood = 300;
    output_elFarm_OrganicMaterials = 12.5;

    // Massive Farm
    cost_MassiveFarm = 330000000;
    budget_MassiveFarm = 1900.8189;
    input_MassiveFarm_ExecutivesWorkForce = 7;
    input_MassiveFarm_ProfessionalWorkForce = 30;
    input_MassiveFarm_Workers = 300;
    input_MassiveFarm_Chemicals = 6;

    output_MassiveFarm_FreshFood = 900;
    output_MassiveFarm_OrganicMaterials = 37.5;

    // Food Processing Plant
    cost_FoodProcessingPlant = 52500000;
    budget_FoodProcessingPlant = 34.9566;
    input_FoodProcessingPlant_FreshFood = 100;
    input_FoodProcessingPlant_Chemicals = 20;
    input_FoodProcessingPlant_ExecutivesWorkForce = 0;
    input_FoodProcessingPlant_ProfessionalWorkForce = 2;
    input_FoodProcessingPlant_Workers = 95;
    input_FoodProcessingPlant_ComputerServices = 0.5;
    input_FoodProcessingPlant_LegalServices = 0.25;

    output_FoodProcessingPlant_ProcessedFood = 100;


    // Heavy Industry
    cost_HeavyIndustry = 70000000;
    budget_HeavyIndustry = 3062.7755;
    input_HeavyIndustry_Metal = 1500;
    input_HeavyIndustry_Chemicals = 125;
    input_HeavyIndustry_ElectronicComponents = 50;
    input_HeavyIndustry_ExecutivesWorkForce = 2;
    input_HeavyIndustry_ProfessionalWorkForce = 8;
    input_HeavyIndustry_Workers = 190;
    input_HeavyIndustry_ComputerServices = 0.5;
    input_HeavyIndustry_LegalServices = 0.25;

    output_HeavyIndustry_Machinery = 2.5;


    // House Holding Appliances
    cost_HouseHoldingAppliances = 63000000;
    budget_HouseHoldingAppliances = 1381.5479;
    input_HouseHoldingAppliances_Metal = 85;
    input_HouseHoldingAppliances_Electroniccomponents = 62;
    input_HouseHoldingAppliances_Chemicals = 25;
    input_HouseHoldingAppliances_Plastics = 27;
    input_HouseHoldingAppliances_ExecutivesWorkForce = 2;
    input_HouseHoldingAppliances_ProfessionalWorkForce = 6;
    input_HouseHoldingAppliances_Workers = 190;
    input_HouseHoldingAppliances_ComputerServices = 1;
    input_HouseHoldingAppliances_LegalServices = 0.5;

    output_HouseHoldingAppliances_HouseHoldingAppliances = 30;


    // Legal Services
    cost_LegalServices = 42000000;
    budget_LegalServices = 977.3653;
    input_LegalServices_ExecutivesWorkForce = 3;
    input_LegalServices_ProfessionalWorkForce = 8;
    input_LegalServices_Workers = 16;
    input_LegalServices_ComputerServices = 0.7;

    output_LegalServices_LegalServices = 7.5;


    // Metalurgic
    cost_Metalurgic = 70000000;
    budget_Metalurgic = 18.7755;
    input_Metalurgic_Ore = 600;
    input_Metalurgic_Chemicals = 45;
    input_Metalurgic_ExecutivesWorkForce = 0;
    input_Metalurgic_ProfessionalWorkForce = 3;
    input_Metalurgic_Workers = 174;
    input_Metalurgic_ComputerServices = 0.5;
    input_Metalurgic_LegalServices = 0.25;

    output_Metalurgic_Metal = 300;


    // Mine
    cost_Mine = 17500000;
    budget_Mine = 88.3189;
    input_Mine_Chemicals = 20;
    input_Mine_ExecutivesWorkForce = 0;
    input_Mine_ProfessionalWorkForce = 2;
    input_Mine_Workers = 158;
    input_Mine_ComputerServices = 0.75;
    input_Mine_LegalServices = 0.25;

    output_Mine_Ore = 1000;


    // Textile
    cost_Textile = 21000000;
    budget_Textile = 62;
    input_Textile_OrganicMaterials = 38;
    input_Textile_Chemicals = 12;
    input_Textile_ExecutivesWorkForce = 0;
    input_Textile_ProfessionalWorkForce = 3;
    input_Textile_Workers = 126;
    input_Textile_ComputerServices = 0.12;
    input_Textile_LegalServices = 0.1;

    output_Textile_FabricsandThreads = 125;


    // Business Machines small
    cost_BusinessMachinessmall = 16000000;
    budget_BusinessMachinessmall = 1861.6758;
    input_BusinessMachinessmall_Metal = 20;
    input_BusinessMachinessmall_Electroniccomponents = 20;
    input_BusinessMachinessmall_Chemicals = 8;
    input_BusinessMachinessmall_ExecutivesWorkForce = 1;
    input_BusinessMachinessmall_ProfessionalWorkForce = 7;
    input_BusinessMachinessmall_Workers = 89;
    input_BusinessMachinessmall_ComputerServices = 0.800000011920929;
    input_BusinessMachinessmall_LegalServices = 0.160000011324882;

    output_BusinessMachinessmall_BusinessMachines = 4;


    // Car Industry small
    cost_CarIndustrysmall = 16000000;
    budget_CarIndustrysmall = 520.6758;
    input_CarIndustrysmall_Metal = 160;
    input_CarIndustrysmall_FabricsandThreads = 14;
    input_CarIndustrysmall_Electroniccomponents = 6;
    input_CarIndustrysmall_Chemicals = 16;
    input_CarIndustrysmall_ExecutivesWorkForce = 1;
    input_CarIndustrysmall_ProfessionalWorkForce = 3;
    input_CarIndustrysmall_Workers = 134;
    input_CarIndustrysmall_ComputerServices = 0.800000011920929;
    input_CarIndustrysmall_LegalServices = 0.240000009536743;

    output_CarIndustrysmall_Nicecars = 0.240000009536743;


    // Chemical Plant small
    cost_ChemicalPlantsmall = 16000000;
    budget_ChemicalPlantsmall = 127.6758;
    input_ChemicalPlantsmall_Ore = 320;
    input_ChemicalPlantsmall_ExecutivesWorkForce = 1;
    input_ChemicalPlantsmall_ProfessionalWorkForce = 5;
    input_ChemicalPlantsmall_Workers = 107;
    input_ChemicalPlantsmall_ComputerServices = 0.320000022649765;
    input_ChemicalPlantsmall_LegalServices = 0.240000009536743;

    output_ChemicalPlantsmall_Chemicals = 40;


    // Clothing small
    cost_Clothingsmall = 6400000;
    budget_Clothingsmall = 35.4703;
    input_Clothingsmall_FabricsandThreads = 26;
    input_Clothingsmall_OrganicMaterials = 6;
    input_Clothingsmall_Chemicals = 4;
    input_Clothingsmall_ExecutivesWorkForce = 0;
    input_Clothingsmall_ProfessionalWorkForce = 1;
    input_Clothingsmall_Workers = 72;
    input_Clothingsmall_ComputerServices = 0.320000022649765;
    input_Clothingsmall_LegalServices = 0.160000011324882;

    output_Clothingsmall_Cheapclothing = 24;


    // Computing Industry small
    cost_ComputingIndustrysmall = 12000000;
    budget_ComputingIndustrysmall = 574.5068;
    input_ComputingIndustrysmall_ExecutivesWorkForce = 2;
    input_ComputingIndustrysmall_ProfessionalWorkForce = 12;
    input_ComputingIndustrysmall_Workers = 9;
    input_ComputingIndustrysmall_LegalServices = 0.320000022649765;

    output_ComputingIndustrysmall_ComputerServices = 4;


    // Construction small
    cost_Constructionsmall = 16800000;
    budget_Constructionsmall = 614.1096;
    input_Constructionsmall_Ore = 96;
    input_Constructionsmall_Metal = 20;
    input_Constructionsmall_Chemicals = 20;
    input_Constructionsmall_ExecutivesWorkForce = 0;
    input_Constructionsmall_ProfessionalWorkForce = 4;
    input_Constructionsmall_Workers = 134;
    input_Constructionsmall_ComputerServices = 0.320000022649765;
    input_Constructionsmall_LegalServices = 0.0800000056624413;

    output_Constructionsmall_Construction = 16;


    // Electronic Industry small
    cost_ElectronicIndustrysmall = 14400000;
    budget_ElectronicIndustrysmall = 11.8083;
    input_ElectronicIndustrysmall_Chemicals = 10;
    input_ElectronicIndustrysmall_Metal = 16;
    input_ElectronicIndustrysmall_ExecutivesWorkForce = 1;
    input_ElectronicIndustrysmall_ProfessionalWorkForce = 5;
    input_ElectronicIndustrysmall_Workers = 72;
    input_ElectronicIndustrysmall_ComputerServices = 0.200000002980232;
    input_ElectronicIndustrysmall_LegalServices = 0.240000009536743;

    output_ElectronicIndustrysmall_Electroniccomponents = 20.8000011444092;


    // Farm small
    cost_Farmsmall = 4000000;
    budget_Farmsmall = 77.3689;
    input_Farmsmall_ExecutivesWorkForce = 0;
    input_Farmsmall_ProfessionalWorkForce = 1;
    input_Farmsmall_Workers = 27;
    input_Farmsmall_Chemicals = 0.240000009536743;

    output_Farmsmall_FreshFood = 24;
    output_Farmsmall_OrganicMaterials = 4;


    // Food Processing Plant small
    cost_FoodProcessingPlantsmall = 12000000;
    budget_FoodProcessingPlantsmall = 53.5068;
    input_FoodProcessingPlantsmall_FreshFood = 32;
    input_FoodProcessingPlantsmall_Chemicals = 6;
    input_FoodProcessingPlantsmall_ExecutivesWorkForce = 0;
    input_FoodProcessingPlantsmall_ProfessionalWorkForce = 1;
    input_FoodProcessingPlantsmall_Workers = 54;
    input_FoodProcessingPlantsmall_ComputerServices = 0.160000011324882;
    input_FoodProcessingPlantsmall_LegalServices = 0.0800000056624413;

    output_FoodProcessingPlantsmall_ProcessedFood = 32;


    // Heavy Industry small
    cost_HeavyIndustrysmall = 16000000;
    budget_HeavyIndustrysmall = 1003.6758;
    input_HeavyIndustrysmall_Metal = 480;
    input_HeavyIndustrysmall_Chemicals = 40;
    input_HeavyIndustrysmall_ElectronicComponents = 16;
    input_HeavyIndustrysmall_ExecutivesWorkForce = 1;
    input_HeavyIndustrysmall_ProfessionalWorkForce = 4;
    input_HeavyIndustrysmall_Workers = 107;
    input_HeavyIndustrysmall_ComputerServices = 0.160000011324882;
    input_HeavyIndustrysmall_LegalServices = 0.0800000056624413;

    output_HeavyIndustrysmall_Machinery = 0.800000011920929;


    // House Holding Appliances small
    cost_HouseHoldingAppliancessmall = 14400000;
    budget_HouseHoldingAppliancessmall = 448.8083;
    input_HouseHoldingAppliancessmall_Metal = 24;
    input_HouseHoldingAppliancessmall_Electroniccomponents = 20;
    input_HouseHoldingAppliancessmall_Chemicals = 8;
    input_HouseHoldingAppliancesSmall_Plastics = 10;
    input_HouseHoldingAppliancessmall_ExecutivesWorkForce = 1;
    input_HouseHoldingAppliancessmall_ProfessionalWorkForce = 4;
    input_HouseHoldingAppliancessmall_Workers = 107;
    input_HouseHoldingAppliancessmall_ComputerServices = 0.320000022649765;
    input_HouseHoldingAppliancessmall_LegalServices = 0.160000011324882;

    output_HouseHoldingAppliancessmall_HouseHoldingAppliances = 9.60000038146973;


    // Legal Services small
    cost_LegalServicessmall = 9600000;
    budget_LegalServicessmall = 340.2055;
    input_LegalServicessmall_ExecutivesWorkForce = 2;
    input_LegalServicessmall_ProfessionalWorkForce = 4;
    input_LegalServicessmall_Workers = 9;
    input_LegalServicessmall_ComputerServices = 0.800000011920929;

    output_LegalServicessmall_LegalServices = 2.40000009536743;


    // Metalurgic small
    cost_Metalurgicsmall = 16000000;
    budget_Metalurgicsmall = 46.6758;
    input_Metalurgicsmall_Ore = 192;
    input_Metalurgicsmall_Chemicals = 14;
    input_Metalurgicsmall_ExecutivesWorkForce = 0;
    input_Metalurgicsmall_ProfessionalWorkForce = 2;
    input_Metalurgicsmall_Workers = 98;
    input_Metalurgicsmall_ComputerServices = 0.160000011324882;
    input_Metalurgicsmall_LegalServices = 0.0800000056624413;

    output_Metalurgicsmall_Metal = 96;


    // Mine small
    cost_Minesmall = 4000000;
    budget_Minesmall = 16.1689;
    input_Minesmall_Chemicals = 6;
    input_Minesmall_ExecutivesWorkForce = 0;
    input_Minesmall_ProfessionalWorkForce = 1;
    input_Minesmall_Workers = 89;
    input_Minesmall_ComputerServices = 0.240000009536743;
    input_Minesmall_LegalServices = 0.0800000056624413;

    output_Minesmall_Ore = 320;


    // Textile small
    cost_Textilesmall = 4800000;
    budget_Textilesmall = 10;
    input_Textilesmall_OrganicMaterials = 12;
    input_Textilesmall_Chemicals = 4;
    input_Textilesmall_ExecutivesWorkForce = 0;
    input_Textilesmall_ProfessionalWorkForce = 2;
    input_Textilesmall_Workers = 72;
    input_TextileSmall_ComputerServices = 0;
    input_TextileSmall_LegalServices = 0;

    output_Textilesmall_FabricsandThreads = 40;

implementation

end.
