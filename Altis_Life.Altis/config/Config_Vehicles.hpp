class CarShops {
    /*
    *    ARRAY FORMAT:
    *        0: STRING (Classname)
    *        1: ARRAY (This is for limiting items to certain things)
    *            0: Variable to read from
    *            1: Variable Value Type (SCALAR / BOOL /EQUAL)
    *            2: What to compare to (-1 = Check Disabled)
    *
    *   BLUFOR Vehicle classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST
    *   OPFOR Vehicle classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_EAST
    *   Independent Vehicle classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_GUER
    *   Civilian Vehicle classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_CIV
    */
    class civ_car {
        side = "civ";
        vehicles[] = {
            { "B_Quadbike_01_F", { "", "", -1 } },
            { "C_Hatchback_01_F", { "", "", -1 } },
            { "C_Offroad_02_unarmed_F", { "", "", -1 } },
            { "C_Offroad_01_F", { "", "", -1 } },
            { "C_SUV_01_F", { "", "", -1 } },
            { "C_Van_01_transport_F", { "", "", -1 } }
        };
    };

    class kart_shop {
        side = "civ";
        vehicles[] = {
            { "C_Kart_01_Blu_F", { "", "", -1 } },
            { "C_Kart_01_Fuel_F", { "", "", -1 } },
            { "C_Kart_01_Red_F", { "", "", -1 } },
            { "C_Kart_01_Vrana_F", { "", "", -1 } }
        };
    };

    class civ_truck {
        side = "civ";
        vehicles[] = {
            { "C_Van_01_box_F", { "", "", -1 } },
            { "I_Truck_02_transport_F", { "", "", -1 } },
            { "I_Truck_02_covered_F", { "", "", -1 } },
            { "O_Truck_03_transport_F", { "", "", -1 } },
            { "B_Truck_01_transport_F", { "", "", -1 } },
            { "O_Truck_03_covered_F", { "", "", -1 } },
            { "O_Truck_03_device_F", { "", "", -1 } },
            { "I_Truck_02_fuel_F", { "", "", -1 } },
            { "B_Truck_01_fuel_F", { "", "", -1 } }
        };
    };

    class civ_air {
        side = "civ";
        vehicles[] = {
            { "B_Heli_Light_01_F", { "", "", -1 } },
            { "C_Heli_Light_01_civil_F", { "", "", -1 } },
            { "O_Heli_Light_02_unarmed_F", { "", "", -1 } },
            { "O_Heli_Transport_04_F", { "", "", -1 } },
            { "O_Heli_Transport_04_bench_F", { "", "", -1 } },
            { "O_Heli_Transport_04_box_F", { "", "", -1 } },
            { "C_Plane_Civil_01_F", { "", "", -1 } },
            { "C_Plane_civil_01_racing_F", { "", "", -1 } },
            { "B_T_VTOL_01_vehicle_F", { "", "", -1 } },
            { "B_Heli_Transport_03_unarmed_F", { "", "", -1 } }
        };
    };

     class civ_ship {
        side = "civ";
        vehicles[] = {
            { "C_Rubberboat", { "", "", -1 } },
            { "C_Scooter_Transport_01_F", { "", "", -1 } },
            { "I_C_Boat_Transport_02_F", { "", "", -1 } },
            { "C_Boat_Civil_01_F", { "", "", -1 } },
            { "B_SDV_01_F", { "", "", -1 } }
        };
    };
	
    class reb_car {
        side = "civ";
        vehicles[] = {
            { "B_Quadbike_01_F", { "", "", -1 } },
            { "B_G_Offroad_01_F", { "", "", -1 } },
            { "O_T_LSV_02_unarmed_F", { "", "", -1 } },
            { "B_Heli_Light_01_stripped_F", { "", "", -1 } },
            { "B_G_Offroad_01_armed_F", { "", "", -1 } }
        };
    };
	
    class mercenaire {
        side = "merce";
        vehicles[] = {
            { "O_Heli_Light_02_unarmed_F", { "", "", -1 } },
            { "B_Heli_Light_01_stripped_F", { "", "", -1 } },
            { "B_T_LSV_01_unarmed_F", { "", "", -1 } },
            { "B_MRAP_01_F", { "", "", -1 } },
            { "I_MRAP_03_F", { "", "", -1 } },
            { "C_SUV_01_F", { "", "", -1 } }
        };
    };
	
    class mercenaireboat {
        side = "merce";
        vehicles[] = {
            { "C_Scooter_Transport_01_F", { "", "", -1 } },
            { "I_C_Boat_Transport_02_F", { "", "", -1 } }
        };
    };

    class med_shop {
        side = "med";
        vehicles[] = {
            { "C_Offroad_01_F", { "", "", -1 } }
        };
    };

    class med_air_hs {
        side = "med";
        vehicles[] = {
            { "B_Heli_Light_01_F", { "", "", -1 } },
            { "O_Heli_Light_02_unarmed_F", { "", "", -1 } }
        };
    };

    class cdd_shop {
        side = "mecano";
        vehicles[] = {
            { "C_Offroad_01_repair_F", { "", "", -1 } }
        };
    };
    class cdd_shop2 {
        side = "mecano";
        vehicles[] = {
            { "B_Heli_Light_01_F", { "", "", -1 } },
            { "C_Heli_Light_01_civil_F", { "", "", -1 } }
        };
    };
		
    class cop_car {
        side = "cop";
        vehicles[] = {
            { "C_Offroad_01_F", { "", "", -1 } },
            { "B_T_LSV_01_unarmed_F", { "life_coplevel", "SCALAR", 1 } },
            { "C_SUV_01_F", { "life_coplevel", "SCALAR", 1 } },
            { "C_Hatchback_01_sport_F", { "life_coplevel", "SCALAR", 3 } },
            { "B_MRAP_01_F", { "life_coplevel", "SCALAR", 4 } },
            { "I_MRAP_03_F", { "life_coplevel", "SCALAR", 6 } },
            { "B_MRAP_01_hmg_F", { "life_coplevel", "SCALAR", 7 } }
        };
    };

    class cop_air {
        side = "cop";
        vehicles[] = {
            { "B_Heli_Light_01_F", { "life_coplevel", "SCALAR", 2 } },
            { "B_Heli_Transport_01_F", { "life_coplevel", "SCALAR", 6 } }
        };
    };

    class cop_ship {
        side = "cop";
        vehicles[] = {
            { "B_Boat_Transport_01_F", { "", "", -1 } },
            { "C_Scooter_Transport_01_F", { "", "", -1 } },
            { "C_Boat_Civil_01_police_F", { "life_coplevel", "SCALAR", 2 } },
            { "I_C_Boat_Transport_02_F", { "life_coplevel", "SCALAR", 2 } },
            { "B_Boat_Armed_01_minigun_F", { "life_coplevel", "SCALAR", 5 } },
            { "B_SDV_01_F", { "", "", 3 } }
        };
    };
};

class LifeCfgVehicles {
    /*
    *    Vehicle Configs (Contains textures and other stuff)
    *       1: ARRAY (Rental Price)
    *         Ex: { 200, 200 , 200 , 200 } //civilian, west, independent, east
    *       2: ARRAY (license required)
    *         Ex: { "driver", "" , "" , "" } //civilian, west, independent, east
    *         licenses[] = { {"CIV"}, {"COP"}, {"MEDIC"}, {"EAST"} };
    *    Textures config follows { Texture Name, side, {texture(s)path}}
    *    Texture(s)path follows this format:
    *    INDEX 0: Texture Layer 0
    *    INDEX 1: Texture Layer 1
    *    INDEX 2: Texture Layer 2
    *    etc etc etc
    *
    */

    class Default {
        vItemSpace = -1;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };

    class I_Truck_02_medical_F {
        vItemSpace = 150;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, 25000, -1 };
        textures[] = {};
    };

    class O_Truck_03_medical_F {
        vItemSpace = 200;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, 45000, -1 };
        textures[] = {};
    };

    class B_Truck_01_medical_F {
        vItemSpace = 250;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, 60000, -1 };
        textures[] = {};
    };


    class C_Rubberboat {
        vItemSpace = 30;
        licenses[] = { {"boat"}, {""}, {""}, {""} };
        rentalprice[] = { 1500, -1, -1, -1 };
        textures[] = { };
    };

    class B_Heli_Transport_01_F {
        vItemSpace = 200;
        licenses[] = { {""}, {"cAir"}, {""}, {""} };
        rentalprice[] = { -1, 300000, -1, -1 };
        textures[] = {};
    };

    class I_Heli_light_03_unarmed_F {
        vItemSpace = -1;
        licenses[] = { {""}, {"cAir"}, {""}, {""} };
        rentalprice[] = { -1, 50000, -1, -1 };
        textures[] = {};
    };

    class B_MRAP_01_hmg_F {
        vItemSpace = 100;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, 200000, -1, -1 };
        textures[] = {};
    };

    class B_Boat_Armed_01_minigun_F {
        vItemSpace = 100;
        licenses[] = { {""}, {"cg"}, {""}, {""} };
        rentalprice[] = { -1, 50000, -1, -1 };
        textures[] = { };
    };

    class B_Boat_Transport_01_F {
        vItemSpace = 30;
        licenses[] = { {""}, {"cg"}, {""}, {""} };
        rentalprice[] = { -1, 5000, -1, -1 };
        textures[] = { };
    };

    class O_Truck_03_transport_F {
        vItemSpace = 400;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 110000, -1, -1, -1 };
        textures[] = { };
    };

    class O_Truck_03_device_F {
        vItemSpace = 400;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 500000, -1, -1, -1 };
        textures[] = { };
    };

    class Land_CargoBox_V1_F {
        vItemSpace = 5000;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };

    class Box_IND_Grenades_F {
        vItemSpace = 350;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };

    class Land_Sink_F {
        vItemSpace = 100;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };
	
    class CargoNet_01_barrels_F {
        vItemSpace = 75;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };
	
    class Land_OfficeCabinet_01_F {
        vItemSpace = 50;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };
	
    class Fridge_01_closed_F {
        vItemSpace = 50;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };
	
    class Land_MetalCase_01_large_F {
        vItemSpace = 5000;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };

    class B_supplyCrate_F {
        vItemSpace = 700;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, -1, -1, -1 };
        textures[] = {};
    };

    class B_G_Offroad_01_armed_F {
        vItemSpace = 50;
        licenses[] = { {"rebel"}, {""}, {""}, {""} };
        rentalprice[] = { 750000, -1, -1, -1 };
        textures[] = { };
    };

    class C_Boat_Civil_01_F {
        vItemSpace = 80;
        licenses[] = { {"boat"}, {""}, {""}, {""} };
        rentalprice[] = { 7500, -1, -1, -1 };
        textures[] = { };
    };

    class C_Boat_Civil_01_police_F {
        vItemSpace = 80;
        licenses[] = { {""}, {"cg"}, {""}, {""} };
        rentalprice[] = { -1, 7500, -1, -1 };
        textures[] = { };
    };

    class B_Truck_01_box_F {
        vItemSpace = 600;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 200000, -1, -1, -1 };
        textures[] = {
			{ "Kavalash", "civ", {
				"textures\vehicle\civil_hmtt0.paa",
				"textures\vehicle\civil_hmtt1.paa"
            } }			
		};
    };

    class B_Truck_01_transport_F {
        vItemSpace = 450;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 140000, -1, -1, -1 };
		textures[] = {
        	{ "Classique", "civ", {
                "\a3\soft_f_beta\Truck_01\Data\truck_01_ext_01_co.paa",
                "\a3\soft_f_beta\Truck_01\Data\truck_01_ext_02_co.paa"
            } },
			{ "Kavalash", "civ", {
				"textures\vehicle\civil_hmtt0.paa",
				"textures\vehicle\civil_hmtt1.paa"
            } }
        };
    };

    class O_MRAP_02_F {
        vItemSpace = 150;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 350000, -1, -1, -1 };
        textures[] = {
        	{ "Classique", "civ", {
                "\A3\soft_F\MRAP_02\Data\mrap_02_ext_01_co.paa",
                "\A3\soft_F\MRAP_02\Data\mrap_02_ext_02_co.paa"
            } },
			{ "Kavalash", "civ", {
				"textures\vehicle\mrap_02_ext_01_c.paa",
				"textures\vehicle\mrap_02_ext_02_co.paa"
            } }
        };
    };

    class B_T_LSV_01_unarmed_F {
        vItemSpace = 150;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 200000, 5000, 3000, -1 };
        textures[] = { };
    };

    class O_T_LSV_02_unarmed_F {
        vItemSpace = 150;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 250000, -1, -1, -1 };
        textures[] = { };
    };

    class C_Offroad_01_F {
        vItemSpace = 115;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 4400, 4400, 1000, -1 };
        textures[] = {
            { "Red", "civ", {
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_co.paa",
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_co.paa"
            } },
            { "Yellow", "civ", {
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE01_CO.paa",
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE01_CO.paa"
            } },
            { "White", "civ", {
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE02_CO.paa",
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE02_CO.paa"
            } },
            { "Blue", "civ", {
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE03_CO.paa",
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE03_CO.paa"
            } },
            { "Dark Red", "civ", {
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE04_CO.paa",
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE04_CO.paa"
            } },
            { "Blue / White", "civ", {
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE05_CO.paa",
                "\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE05_CO.paa"
            } },
            { "Taxi", "civ", {
                "#(argb,8,8,3)color(0.6,0.3,0.01,1)"
            } },
            { "Gendarmerie", "cop", {
                "textures\vehicle\police_offroad.paa"
            } },
            { "EMS", "med", {
                "textures\vehicle\medic_offroad.paa"
            } }
        };
    };
	
    class C_Offroad_02_unarmed_F {
        vItemSpace = 100;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 4400, 4400, 4400, -1 };
        textures[] = {
			{ "Noir", "civ", {
				"\A3\Soft_F_Exp\Offroad_02\Data\offroad_02_ext_black_co.paa"
			} },
			{ "Bleu", "civ", {
				"\A3\Soft_F_Exp\Offroad_02\Data\offroad_02_ext_blue_co.paa"
			} },
			{ "Vert", "civ", {
				"\A3\Soft_F_Exp\Offroad_02\Data\offroad_02_ext_green_co.paa"
			} },
			{ "Orange", "civ", {
				"\A3\Soft_F_Exp\Offroad_02\Data\offroad_02_ext_orange_co.paa"
			} },
			{ "Rouge", "civ", {
				"\A3\Soft_F_Exp\Offroad_02\Data\offroad_02_ext_red_co.paa"
			} },
			{ "Blanc", "civ", {
				"\A3\Soft_F_Exp\Offroad_02\Data\offroad_02_ext_white_co.paa"
			} }
		};
    };
	
	class B_G_Offroad_01_F : C_Offroad_01_F {
        vItemSpace = 115;
		rentalprice[] = { 5000, 5000, -1, -1 };
        textures[] = {};
    };
	
	class C_Offroad_01_repair_F : C_Offroad_01_F {
        vItemSpace = 115;
		rentalprice[] = { 5000, 4000, 2000, -1 };
        textures[] = {
			{ "Mecano", "mecano", {
                "textures\vehicle\offmeca.paa"
            } }
		};
    };

    class C_Kart_01_Blu_F {
        vItemSpace = 10;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 25000, -1, -1, -1, 5000 };
        textures[] = {};
    };
/*
To edit another information in this classes you can use this exemple.
class C_Kart_01_Fuel_F : C_Kart_01_Blu_F{
    vItemSpace = 40;
    rentalprice[] = { 25000, -1, -1, -1 };
};

will modify the virtual space and the price of the vehicle, but other information such as license and textures will pick up the vehicle declare at : Vehicle {};
*/
    class C_Kart_01_Fuel_F : C_Kart_01_Blu_F{}; // Get all information of C_Kart_01_Blu_F
    class C_Kart_01_Red_F  : C_Kart_01_Blu_F{};
    class C_Kart_01_Vrana_F : C_Kart_01_Blu_F{};

    class C_Hatchback_01_sport_F {
        vItemSpace = 95;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 10000, 7500, 25000, -1 };
        textures[] = {
            { "Red", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport01_co.paa"
            } },
            { "Dark Blue", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport02_co.paa"
            } },
            { "Orange", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport03_co.paa"
            } },
            { "Black / White", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport04_co.paa"
            } },
            { "Beige", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport05_co.paa"
            } },
            { "Green", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport06_co.paa"
            } },
            { "Bleu", "cop", {
                "#(ai,64,64,1)Fresnel(1.3,7)"
            } },
            { "Gendarmerie", "cop", {
                "textures\vehicle\police_hatchback.paa"
            } },
            { "Mecano", "mecano", {
                "textures\vehicle\hayonS.paa"
            } }
        };
    };

    class C_Quadbike_01_F {
        vItemSpace = 35;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 1750, -1, -1, -1 };
        textures[] = {};
    };

    class B_Quadbike_01_F {
        vItemSpace = 35;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 1500, -1, -1, -1 };
        textures[] = {
            { "Brown", "cop", {
                "\A3\Soft_F\Quadbike_01\Data\Quadbike_01_co.paa"
            } },
            { "Digi Desert", "reb", {
                "\A3\Soft_F\Quadbike_01\Data\quadbike_01_opfor_co.paa"
            } },
            { "Black", "civ", {
                "\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_black_co.paa"
            } },
            { "Blue", "civ", {
                "\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_blue_co.paa"
            } },
            { "Red", "civ", {
                "\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_red_co.paa"
            } },
            { "White", "civ", {
                "\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_civ_white_co.paa"
            } },
            { "Digi Green", "civ", {
                "\A3\Soft_F_beta\Quadbike_01\Data\quadbike_01_indp_co.paa"
            } },
            { "Hunter Camo", "civ", {
                "\a3\soft_f_gamma\Quadbike_01\data\quadbike_01_indp_hunter_co.paa"
            } },
            { "Rebel Camo", "reb", {
                "\a3\soft_f_gamma\Quadbike_01\data\quadbike_01_indp_hunter_co.paa"
            } }
        };
    };

    class I_Truck_02_covered_F {
        vItemSpace = 300;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 85000, -1, -1, -1 };
		textures[] = {};
    };

    class I_Truck_02_transport_F {
        vItemSpace = 300;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 65000, -1, -1, -1 };
        textures[] = {
            { "Orange", "civ", {
                "\A3\Soft_F_Beta\Truck_02\data\truck_02_kab_co.paa",
                "\a3\soft_f_beta\Truck_02\data\truck_02_kuz_co.paa"
            } },
            { "Black", "cop", {
                "#(argb,8,8,3)color(0.05,0.05,0.05,1)"
            } }
        };
    };

    class O_Truck_03_covered_F {
        vItemSpace = 475;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 160000, -1, -1, -1 };
        textures[] = {};
    };

    class C_Hatchback_01_F {
        vItemSpace = 70;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 2500, -1, -1, -1 };
        textures[] = {
            { "Beige", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base01_co.paa"
            } },
            { "Green", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base02_co.paa"
            } },
            { "Blue", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base03_co.paa"
            } },
            { "Dark Blue", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base04_co.paa"
            } },
            { "Yellow", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base06_co.paa"
            } },
            { "White", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base07_co.paa"
            } },
            { "Grey", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base08_co.paa"
            } },
            { "Black", "civ", {
                "\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base09_co.paa"
            } }
        };
    };

    class C_SUV_01_F {
        vItemSpace = 100;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 25000, 5000, 3000, -1 };
        textures[] = {
            { "Dark Red", "civ", {
                "\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_co.paa"
            } },
            { "Silver", "civ", {
                "\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_03_co.paa"
            } },
            { "Orange", "civ", {
                "\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_04_co.paa"
            } },
            { "Gendarmerie", "cop", {
                "\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_02_co.paa"
            } },
            { "Gendarmerie", "cop", {
                "textures\vehicle\police_suv.paa"
            } },
            { "Mercenaire", "merce", {
                "textures\vehicle\SuvMercenaire.paa"
            } }
        };
    };

    class C_Van_01_transport_F {
        vItemSpace = 150;
        licenses[] = { {"driver"}, {""}, {""}, {""} };
        rentalprice[] = { 20000, -1, -1, -1 };
        textures[] = {
            { "White", "civ", {
                "\a3\soft_f_gamma\Van_01\Data\van_01_ext_co.paa"
            } },
            { "Red", "civ", {
                "\a3\soft_f_gamma\Van_01\Data\van_01_ext_red_co.paa"
            } }
        };
    };

    class C_Van_01_box_F {
        vItemSpace = 200;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 35000, -1, -1, -1 };
        textures[] = {
            { "White", "civ", {
                "\a3\soft_f_gamma\Van_01\Data\van_01_ext_co.paa"
            } },
            { "Red", "civ", {
                "\a3\soft_f_gamma\Van_01\Data\van_01_ext_red_co.paa"
            } }
        };
    };

    class B_MRAP_01_F {
        vItemSpace = 100;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { 1000, 50000, 2000, -1 };
        textures[] = {
            { "Black", "cop", {
                "#(argb,8,8,3)color(0.05,0.05,0.05,1)",
                "#(argb,8,8,3)color(0.05,0.05,0.05,1)"
            } },
            { "Gendarmerie", "cop", {
                "textures\vehicle\police_hunter.paa"
            } },
            { "Mercenaire", "merce", {
                "textures\vehicle\HunterMercenaire.paa"
            } }
        };
    };

    class I_MRAP_03_F {
        vItemSpace = 150;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { -1, 75000, 3000, -1 };
        textures[] = {
			{ "Gendarmerie", "cop", {
                "textures\vehicle\police_strider.paa"
            } },
			{ "Mercenaire", "merce", {
                "\a3\soft_f_beta\MRAP_03\Data\mrap_03_ext_co.paa"
            } }
		};
    };

     class B_Heli_Light_01_stripped_F {
        vItemSpace = 35;
        licenses[] = { {""}, {""}, {""}, {""} };
        rentalprice[] = { 60000, -1, 2000, -1 };
        textures[] = {
            { "Rebel Digital", "reb", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_digital_co.paa"
            } },
            { "Mercenaire", "merce", {
                "textures\vehicle\helimercenaire.paa"
            } }
        };
    };

     class O_Heli_Transport_04_black_F {
        vItemSpace = 115;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 50000, -1, -1, -1 };
        textures[] = {};
    };
	
     class O_Heli_Transport_04_bench_F : Default {
		vItemSpace = 50;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 150000, 150000, -1, -1 };
        textures[] = {};
    };
	
     class C_Plane_Civil_01_F : Default {
		vItemSpace = 50;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 80000, -1, -1, -1 };
        textures[] = {
			{ "Course (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Course", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"
			} },
			{ "Ligne rouge (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Ligne rouge", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"
			} },
			{ "Vert (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Vert", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"
			} },
			{ "Blue wave (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Blue wave", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"}
			}
		};
    };
	
     class C_Plane_civil_01_racing_F  : Default {
		vItemSpace = 50;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 100000, -1, -1, -1 };
        textures[] = {
			{ "Course (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Course", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Racer_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"
			} },
			{ "Ligne rouge (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Ligne rouge", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_RedLine_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"
			} },
			{ "Vert (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Vert", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Tribal_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"
			} },
			{ "Blue wave (Intérieur brun)", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_tan_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_tan_co.paa"
			} },
			{ "Blue wave", "civ", {
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_01_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_ext_02_Wave_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
				"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"}
			}
		};
    };
	
     class B_T_VTOL_01_vehicle_F : Default {
		vItemSpace = 100;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 600000, -1, -1, -1 };
        textures[] = {};
    };
		
     class I_C_Boat_Transport_02_F : Default {
		vItemSpace = 100;
        licenses[] = { {"boat"}, {""}, {""}, {""} };
        rentalprice[] = { 30000, 15000, 15000, -1 };
        textures[] = {};
    };
	
     class C_Scooter_Transport_01_F : Default {
		vItemSpace = 30;
        licenses[] = { {"boat"}, {""}, {""}, {""} };
        rentalprice[] = { 20000, 10000, 10000, -1 };
        textures[] = {
			{ "Noir", "civ", {
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_Black_CO.paa",
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_VP_Black_CO.paa"
			} },
			{ "Bleu", "civ", {
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_Blue_co.paa",
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_VP_Blue_co.paa"
			} },
			{ "Gris", "civ", {
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_Grey_co.paa",
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_VP_Grey_co.paa"
			} },
			{ "Vert", "civ", {
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_Lime_co.paa",
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_VP_Lime_co.paa"
			} },
			{ "Rouge", "civ", {
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_Red_CO.paa",
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_VP_CO.paa"
			} },
			{ "Blanc", "civ", {
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_CO.paa",
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_VP_CO.paa"
			} },
			{ "Jaune", "civ", {
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_Yellow_CO.paa",
				"\A3\Boat_F_Exp\Scooter_Transport_01\Data\Scooter_Transport_01_VP_Yellow_CO.paa"
			} }
		};
    };
	
     class O_Heli_Transport_04_box_F : Default {
		vItemSpace = 50;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 180000, -1, -1, -1 };
        textures[] = {};
    };
	
     class B_Heli_Transport_03_unarmed_F : Default {
		vItemSpace = 90;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 400000, -1, -1, -1 };
        textures[] = {};
    };

     class I_Heli_Transport_02_F {
        vItemSpace = 200;
        licenses[] = { {"pilot"}, {""}, {""}, {""} };
        rentalprice[] = { 400000, -1, -1, -1 };
		textures[] = {
        	{ "Ion", "civ", {
                "\a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_ion_co.paa",
                "\a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_ion_co.paa",
                "\a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_ion_co.paa"
            } },
            { "Dahoman", "civ", {
                "\a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa",
                "\a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa",
                "\a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa"
            } },
            { "TeamNaz", "civ", {
                "textures\vehicle\m00_0_co.paa",
                "textures\vehicle\m01_1_co.paa",
                "textures\vehicle\m02_2_co.paa"
            } }
        };
    };

    class B_Heli_Light_01_F {
        vItemSpace = 25;
        licenses[] = { {"pilot"}, {"cAir"}, {"mAir"}, {""} };
        rentalprice[] = { 60000, 50000, 2000, -1 };
        textures[] = {
            { "Gendarmerie", "cop", {
                "textures\vehicle\police_hummingbird.paa"
            } },
            { "Sheriff", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_sheriff_co.paa"
            } },
            { "Civ Blue", "civ", {
                "\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_blue_co.paa"
            } },
            { "Civ Red", "civ", {
                "\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_co.paa"
            } },
            { "Blueline", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_blueline_co.paa"
            } },
            { "Elliptical", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_elliptical_co.paa"
            } },
            { "Furious", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_furious_co.paa"
            } },
            { "Jeans Blue", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_jeans_co.paa"
            } },
            { "Speedy Redline", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_speedy_co.paa"
            } },
            { "Sunset", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_sunset_co.paa"
            } },
            { "Vrana", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_vrana_co.paa"
            } },
            { "Waves Blue", "civ", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_wave_co.paa"
            } },
            { "Rebel Digital", "reb", {
                "\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_digital_co.paa"
            } },
            { "Digi Green", "reb", {
                "\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa"
            } },
            { "EMS White", "med", {
                "textures\vehicle\medic_hummingbird.paa"
            } },
			{ "Mecano", "mecano", {
                "textures\vehicle\helimeca.paa"
            } },
			{ "Mercenaire", "merce", {
                "textures\vehicle\helimercenaire.paa"
            } }
        };
    };


    class C_Heli_Light_01_civil_F : B_Heli_Light_01_F {
        vItemSpace = 25;
        rentalprice[] = { 60000, 15000, 2000, -1 };
    };

    class O_Heli_Light_02_unarmed_F {
        vItemSpace = 60;
        licenses[] = { {"pilot" }, {""}, {""}, {""} };
        rentalprice[] = { 180000, -1, 2000, -1 };
        textures[] = {
            { "Black", "cop", {
                "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_co.paa"
            } },
            { "White / Blue", "civ", {
                "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_civilian_co.paa"
            } },
            { "Digi Green", "civ", {
                "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa"
            } },
            { "Kavalash", "civ", {
                "textures\vehicle\civil_Orca.paa"
            } },
            { "Desert Digi", "reb", {
                "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_opfor_co.paa"
            } },
            { "EMS White", "med", {
                 "textures\vehicle\medic_orca.paa"
            } },
            { "Mercenaire", "merce", {
                 "textures\vehicle\orcaCamo.paa"
            } }
        };
    };

    class O_Heli_Transport_04_F {
        vItemSpace = 50;
        licenses[] = { {"pilot" }, {""}, {"mAir"}, {""} };
        rentalprice[] = { 155000, 155000, -1, -1 };
        textures[] = {};
    };

    class B_SDV_01_F {
        vItemSpace = 120;
        licenses[] = { {"boat"}, {"cg"}, {""}, {""} };
        rentalprice[] = { 17500, 10000, -1, -1 };
        textures[] = {};
    };

        class C_Van_01_fuel_F {
        vItemSpace = 20;
        vFuelSpace = 19500;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 120000, -1, -1, -1 };
        textures[] = {
            { "White", "civ", {
                "\A3\soft_f_gamma\Van_01\data\van_01_ext_co.paa",
                "\A3\soft_f_gamma\Van_01\data\van_01_tank_co.paa"
            } },
            { "Red", "civ", {
                "\A3\soft_f_gamma\Van_01\data\van_01_ext_red_co.paa",
                "\A3\soft_f_gamma\Van_01\data\van_01_tank_red_co.paa"
            } }
        };
    };

    class I_Truck_02_fuel_F {
        vItemSpace = 40;
        vFuelSpace = 30000;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 50000, -1, -1, -1 };
        textures[] = {
            { "White", "civ", {
                "\A3\Soft_F_Beta\Truck_02\data\truck_02_kab_co.paa",
                "\A3\Soft_F_Beta\Truck_02\data\truck_02_fuel_co.paa"
            } }
        };
    };

    class B_Truck_01_fuel_F {
        vItemSpace = 50;
        vFuelSpace = 50000;
        licenses[] = { {"trucking"}, {""}, {""}, {""} };
        rentalprice[] = { 125000, -1, -1, -1 };
        textures[] = {};
    };
};
