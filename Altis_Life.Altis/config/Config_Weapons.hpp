/*
*    Format:
*        level: ARRAY (This is for limiting items to certain things)
*            0: Variable to read from
*            1: Variable Value Type (SCALAR / BOOL / EQUAL)
*            2: What to compare to (-1 = Check Disabled)
*            3: Custom exit message (Optional)
*
*    items: { Classname, Itemname, BuyPrice, SellPrice }
*
*    Itemname only needs to be filled if you want to rename the original object name.
*
*    Weapon classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Weapons
*    Item classnames can be found here: https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Items
*
*/
class WeaponShops {
    //Armory Shops
    class weaponBuy {
        name = "Billy Joe's Firearms";
        side = "civ";
        license = "gun"; 
        level[] = { "", "", -1, "" };
        items[] = {
            { "hgun_P07_snds_F", "", 5000 },
            { "arifle_SDAR_F", "", 35000 },
            { "hgun_PDW2000_F", "", 20000 },
            { "hgun_Rook40_F", "", 15000 },
            { "hgun_ACPC2_F", "", 15000 },
            { "hgun_Pistol_heavy_01_F", "", 15000 },
            { "hgun_Pistol_heavy_02_F", "", 15000 },
            { "SMG_02_F", "", 35000 },
            { "arifle_Mk20_plain_F", "", 50000 },
            { "arifle_Mk20C_F", "", 50000 },
            { "arifle_TRG21_F", "", 50000 },
            { "arifle_Katiba_F", "", 75000 },
            { "arifle_MX_F", "", 75000 },
            { "arifle_MX_Black_F", "", 75000 },
            { "arifle_MXM_Black_F", "", 100000 },
            { "arifle_MX_SW_Black_F", "", 100000 },
            { "LMG_Mk200_F", "", 125000 },
            { "srifle_DMR_03_woodland_F", "", 125000 },
            { "srifle_DMR_03_khaki_F", "", 125000 },
            { "srifle_DMR_06_camo_F", "", 125000 },
            { "srifle_DMR_06_olive_F", "", 125000 },
            { "srifle_EBR_F", "", 125000 },
            { "srifle_LRR_F", "", 600000 },
            { "srifle_LRR_camo_F", "", 600000 },
            { "srifle_GM6_F", "", 600000 },
            { "arifle_AKM_F", "", 150000 },
            { "arifle_SPAR_03_snd_F", "", 130000 },
            { "arifle_AKS_F", "", 70000 },
            { "arifle_CTAR_hex_F", "", 70000 }
        };
        mags[] = {};
        accs[] = {};
    };
	
    //Civil Weapon Shops
    class gun {
        name = "Billy Joe's Firearms";
        side = "civ";
        license = "gun";
        level[] = { "", "", -1, "" };
        items[] = {
            { "arifle_SDAR_F", "", 75000, 20000 },
            { "hgun_PDW2000_F", "", 45000, 17500 },
            { "hgun_Rook40_F", "", 25000, 12500 },
            { "hgun_ACPC2_F", "", 25000, 12500 },
            { "hgun_Pistol_heavy_01_F", "", 25000, 12500 },
            { "hgun_Pistol_heavy_02_F", "", 25000, 12500 }
        };
        mags[] = {
            { "30Rnd_556x45_Stanag_Tracer_Red", "", 5000 },
            { "30Rnd_9x21_Mag", "", 4500 },
            { "16Rnd_9x21_Mag", "", 4500 },
            { "9Rnd_45ACP_Mag", "", 4500 },
            { "11Rnd_45ACP_Mag", "", 4500 },
            { "6Rnd_45ACP_Cylinder", "", 4500 }
        };
        accs[] = {};
    };
	
    //Rebel Weapon Shops
    class rebel {
        name = "Mohammed's Jihadi Shop";
        side = "civ";
        license = "rebel";
        level[] = { "", "", -1, "" };
        items[] = {
			{ "SMG_02_F", "", 40000, -1 },
            { "arifle_Mk20_plain_F", "", 60000, -1 },
            { "arifle_TRG21_F", "", 60000, -1 },
			{ "arifle_Mk20C_F", "", 64000, -1 },
            { "arifle_Katiba_F", "", 80000, -1 },
            { "arifle_MX_F", "", 80000, -1 },
			{ "arifle_MX_Black_F", "", 80000, -1 },
            { "arifle_AKS_F", "", 112000, -1 },
            { "arifle_CTAR_hex_F", "", 112000, -1 },			
            { "arifle_MXM_Black_F", "", 112000, -1 },
			{ "arifle_MX_SW_Black_F", "", 112000, -1 },
            { "srifle_DMR_03_woodland_F", "", 160000, -1 },
            { "srifle_DMR_06_camo_F", "", 160000, -1 },
            { "LMG_Mk200_F", "", 160000, -1 },
            { "srifle_DMR_03_khaki_F", "", 160000, -1 },
            { "srifle_DMR_06_olive_F", "", 160000, -1 },
            { "srifle_EBR_F", "", 200000, -1 },
            { "arifle_SPAR_03_snd_F", "", 208000, -1 },
            { "arifle_AKM_F", "", 240000, -1 },
            { "srifle_LRR_camo_F", "", 800000, -1 },
			{ "srifle_LRR_F", "", 800000, -1 },
            { "srifle_GM6_F", "", 1200000, -1 }
        };
        mags[] = {
            { "30Rnd_556x45_Stanag_Tracer_Red", "", 2000 },
			{ "30Rnd_9x21_Mag", "", 1000 },
            { "16Rnd_9x21_Mag", "", 1000 },
            { "9Rnd_45ACP_Mag", "", 1000 },
            { "11Rnd_45ACP_Mag", "", 1000 },
            { "30Rnd_545x39_Mag_Tracer_F", "", 1000 },
            { "6Rnd_45ACP_Cylinder", "", 1000 },
            { "7Rnd_408_Mag", "", 8000 },
            { "20Rnd_762x51_Mag", "", 2000 },
            { "30Rnd_65x39_caseless_green", "", 2000 },
            { "30Rnd_762x39_Mag_F", "", 2000 },
            { "30Rnd_65x39_caseless_mag", "", 2000 },
            { "200Rnd_65x39_cased_Box_Tracer", "", 8000 },
            { "5Rnd_127x108_Mag", "", 12000 },
			{ "130Rnd_338_Mag", "", 12000 },
            { "20Rnd_556x45_UW_mag", "", 2000 },
            { "100Rnd_65x39_caseless_mag", "", 4000 }
        };
        accs[] = {
			{ "optic_SOS", "", 15000 },
			{ "optic_DMS", "", 10000 },
			{ "optic_MRCO", "", 7500 },
			{ "optic_Arco", "", 7500 },
			{ "optic_Hamr", "", 7500 },
			{ "optic_LRPS", "", 7500 },
			{ "optic_Aco", "", 7500 },
			{ "optic_NVS", "", 15000 },
			{ "optic_Holosight", "", 4800 }
		};
    };

    //Gang Weapon Shops
    class gangShop {
        name = "Hideout Armament";
        side = "civ";
        license = "rebel";
        level[] = { "", "", -1, "" };
		items[] = {
			{ "SMG_02_F", "", 10000, -1 },
            { "arifle_Mk20_plain_F", "", 15000, -1 },
            { "arifle_TRG21_F", "", 16000, -1 },
			{ "arifle_Mk20C_F", "", 20000, -1 },
            { "arifle_Katiba_F", "", 20000, -1 },
            { "arifle_MX_F", "", 20000, -1 },
			{ "arifle_MX_Black_F", "", 20000, -1 },
            { "arifle_AKS_F", "", 28000, -1 },
            { "arifle_CTAR_hex_F", "", 28000, -1 },			
            { "arifle_MXM_Black_F", "", 28000, -1 },
			{ "arifle_MX_SW_Black_F", "", 28000, -1 },
            { "LMG_Mk200_F", "", 40000, -1 },
            { "srifle_DMR_03_woodland_F", "", 40000, -1 },
            { "srifle_DMR_06_camo_F", "", 40000, -1 },
            { "srifle_DMR_03_khaki_F", "", 40000, -1 },
            { "srifle_DMR_06_olive_F", "", 40000, -1 },
            { "srifle_EBR_F", "", 50000, -1 },
            { "arifle_SPAR_03_snd_F", "", 52000, -1 },
            { "arifle_AKM_F", "", 60000, -1 },
            { "srifle_LRR_camo_F", "", 200000, -1 },
			{ "srifle_LRR_F", "", 200000, -1 },
            { "srifle_GM6_F", "", 300000, -1 }
        };
        mags[] = {
            { "30Rnd_556x45_Stanag_Tracer_Red", "", 500 },
			{ "30Rnd_9x21_Mag", "", 250 },
            { "16Rnd_9x21_Mag", "", 250 },
            { "9Rnd_45ACP_Mag", "", 250 },
            { "11Rnd_45ACP_Mag", "", 250 },
            { "30Rnd_545x39_Mag_Tracer_F", "", 250 },
            { "6Rnd_45ACP_Cylinder", "", 250 },
            { "7Rnd_408_Mag", "", 2000 },
            { "20Rnd_762x51_Mag", "", 500 },
            { "30Rnd_65x39_caseless_green", "", 500 },
            { "30Rnd_762x39_Mag_F", "", 500 },
            { "30Rnd_65x39_caseless_mag", "", 500 },
            { "200Rnd_65x39_cased_Box_Tracer", "", 2000 },
            { "5Rnd_127x108_Mag", "", 3000 },
			{ "130Rnd_338_Mag", "", 3000 },
            { "20Rnd_556x45_UW_mag", "", 500 },
            { "100Rnd_65x39_caseless_mag", "", 1000 }
        };
        accs[] = {
			{ "optic_SOS", "", 3750 },
			{ "optic_DMS", "", 2500 },
			{ "optic_MRCO", "", 1875 },
			{ "optic_Arco", "", 1875 },
			{ "optic_Hamr", "", 1875 },
			{ "optic_LRPS", "", 1875 },
			{ "optic_Aco", "", 1875 },
			{ "optic_NVS", "", 3750 },
			{ "optic_Holosight", "", 1200 }
		};
    };

    //Cop Viseur
    class cop_viseur {
        name = "Altis Sergeant Officer Shop";
        side = "cop";
        license = "";
        level[] = {"life_coplevel", "SCALAR", 1, "Vous devez être gendarme officiel!"};
        items[] = {
			{ "optic_SOS", "", 5000 },
			{ "optic_DMS", "", 3000 },
            { "optic_MRCO", "", 2500 },
            { "optic_Arco", "", 2500 },
            { "optic_Hamr", "", 2500 },
			{ "optic_LRPS", "", 2500 },
			{ "optic_Aco", "", 2500 },
			{ "optic_NVS", "", 5000 },
			{ "optic_Holosight", "", 1200 },
			{ "acc_flashlight", "", 750 },
			{ "7Rnd_408_Mag", "", 5000 },
			{ "20Rnd_762x51_Mag", "", 800 },
            { "30Rnd_65x39_caseless_mag", "", 500 },
			{ "30Rnd_556x45_Stanag", "", 300 },
            { "30Rnd_9x21_Mag", "", 300 },
			{ "5Rnd_127x108_Mag", "", 10000 },
			{ "30Rnd_580x42_Mag_Tracer_F", "", 1000 },
			{ "30Rnd_556x45_Stanag_red", "", 500 },
			{ "30Rnd_9x21_Mag_SMG_02", "", 300 }
        };
        mags[] = {};
        accs[] = {};
    };
   
	//Mercenaire Weapon Shops
    class mercenaire {
        name = "Mercenaire";
        side = "merce";
        license = "";
        level[] = { "", "", -1, "" };
        items[] = {
            { "srifle_EBR_F", "", 95000, 0 },
            { "srifle_LRR_F", "", 250000, 0 },
            { "LMG_Mk200_F", "", 150000, 0 },
            { "arifle_MXM_F", "", 75000, 0 },
            { "arifle_MX_Black_F", "", 50000, 0 },
            { "arifle_SDAR_F", "", 20000, 0 },
            { "arifle_SPAR_03_khk_F", "", 75000, 0 },
            { "arifle_SPAR_01_khk_F", "", 55000, 0 },
            { "arifle_CTAR_ghex_F", "", 50000, 0 },
        };
        mags[] = {
			{ "20Rnd_762x51_Mag", "", 6000 },
			{ "7Rnd_408_Mag", "", 8000 },
			{ "200Rnd_65x39_cased_Box_Tracer", "", 15000 },
			{ "30Rnd_65x39_caseless_mag_Tracer", "", 3000 },
			{ "30Rnd_556x45_Stanag_Tracer_Green", "", 2000 },
			{ "30Rnd_580x42_Mag_Tracer_F", "", 4000 }
		};
        accs[] = {
			{ "optic_MRCO", "", 3000 },
			{ "optic_Arco", "", 3000 },
			{ "optic_SOS", "", 5000 },
			{ "optic_DMS", "", 5000 },
			{ "optic_LRPS", "", 6000 },
			{ "optic_NVS", "", 6000 }
		};
    };
    
	//Civil Item Shops
	class genstore {
        name = "Altis General Store";
        side = "";
        license = "";
        level[] = { "", "", -1, "" };
        items[] = {
            { "Binocular", "", 150, -1 },
            { "ItemGPS", "", 100, 45 },
            { "ItemMap", "", 50, 35 },
            { "ItemCompass", "", 50, 25 },
            { "ItemWatch", "", 50, -1 },
            { "ToolKit", "", 5000, 75 },
            { "FirstAidKit", "", 150, 65 },
            { "NVGoggles", "", 2000, 980 },
            { "ItemRadio", "Telephone", 500, 45 },
            { "Chemlight_red", "", 300, -1 },
            { "Chemlight_yellow", "", 300, 50 },
            { "Chemlight_green", "", 300, 50 },
            { "Chemlight_blue", "", 300, 50 }
        };
        mags[] = {};
        accs[] = {};
    };

    //Cop Item Shops
    class cop_item {
        name = "Altis Cop Shop";
        side = "cop";
        license = "";
        level[] = { "", "", -1, "" };
        items[] = {
            { "Binocular", "", 150, -1 },
            { "ItemGPS", "", 250, 45 },
            { "ItemRadio", "Telephone", 250, 45 },
            { "Rangefinder", "", 1000, 45 },
            { "ToolKit", "", 5000, 75 },
            { "FirstAidKit", "", 500, 65 },
            { "NVGoggles", "", 1500, 980 },
            { "hgun_P07_snds_F", "", 5000, 2500 }
        };
        mags[] = {
			 { "30Rnd_9x21_Mag", "", 300 }
		};
        accs[] = {};
    };

    //Medic Shops
    class med_basic {
        name = "store";
        side = "med";
        license = "";
        level[] = { "", "", -1, "" };
        items[] = {
            { "ItemGPS", "", 100, 45 },
            { "Binocular", "", 150, -1 },
            { "ToolKit", "", 5000, 75 },
			{ "ItemRadio", "Telephone", 250, 45 },
            { "FirstAidKit", "", 150, 65 },
            { "Medikit", "", 500, 450 },
            { "NVGoggles", "", 1200, 980 }
        };
        mags[] = {};
        accs[] = {};
    };
	
	//Mercenaire Item Shops
    class mercenaireMarket {
        name = "Mercenaire";
        side = "merce";
        license = "";
        level[] = { "", "", -1, "" };
        items[] = {
            { "Binocular", "", 150, -1 },
            { "ItemGPS", "", 100, 45 },
            { "ItemMap", "", 50, 35 },
            { "ItemCompass", "", 50, 25 },
            { "ItemWatch", "", 50, -1 },
            { "ToolKit", "", 5000, 75 },
            { "FirstAidKit", "", 150, 65 },
            { "NVGoggles", "", 2000, 980 },
            { "ItemRadio", "Telephone", 500, 45 },
            { "Chemlight_red", "", 300, -1 },
            { "Chemlight_yellow", "", 300, 50 },
            { "Chemlight_green", "", 300, 50 },
            { "Chemlight_blue", "", 300, 50 }
        };
        mags[] = {};
        accs[] = {};
    };
    
	//Chasseur Shops
    class chasseurstore {
        name = "Altis Chasseur";
        side = "civ";
        license = "chasseur";
        level[] = { "", "", -1, "" };
        items[] = {
            { "Binocular", "", 150, -1 },
            { "ItemGPS", "", 100, 45 },
            { "ItemMap", "", 50, 35 },
            { "ItemCompass", "", 50, 25 },
            { "ItemWatch", "", 50, -1 },
			{ "ItemRadio", "Telephone", 250, 45 },
            { "ToolKit", "", 5000, 75 },
            { "FirstAidKit", "", 150, 65 },
            { "NVGoggles", "", 2000, 980 },
            { "hgun_P07_snds_F", "Taser", 1500, -1 },
			{ "16Rnd_9x21_Mag", "Mun Taser", 25 }
        };
        mags[] = {};
        accs[] = {};
    };

    //Basic Shops
    class antirad {
        name = "Altis Antirad Store";
        side = "civ";
        license = "";
        level[] = { "", "", -1, "" };
        items[] = {
            { "U_C_Scientist", "", 20000, -1 }
        };
        mags[] = {};
        accs[] = {};
    };
	
    class f_station_store {
        name = "Altis Fuel Station Store";
        side = "";
        license = "";
        level[] = { "", "", -1, "" };
        items[] = {
            { "Binocular", "", 750, -1 },
            { "ItemGPS", "", 500, 45 },
            { "ItemMap", "", 250, 35 },
            { "ItemCompass", "", 250, 25 },
            { "ItemWatch", "", 250, -1 },
			{ "ItemRadio", "Telephone", 2500, 45 },
            { "ToolKit", "", 10000, 75 },
            { "FirstAidKit", "", 750, 65 },
            { "NVGoggles", "", 10000, 980 },
            { "Chemlight_red", "", 1500, -1 },
            { "Chemlight_yellow", "", 1500, 50 },
            { "Chemlight_green", "", 1500, 50 },
            { "Chemlight_blue", "", 1500, 50 }
        };
        mags[] = {};
        accs[] = {};
    };

    class f_station_cdd {
        name = "Altis Fuel Station Store";
        side = "mecano";
        license = "";
		level[] = { "life_mediclevel", "SCALAR", 2, "Vous devez être mecanicien!" };
        items[] = {
            { "Binocular", "", 750, -1 },
            { "ItemGPS", "", 500, 45 },
            { "ItemMap", "", 250, 35 },
            { "ItemCompass", "", 250, 25 },
            { "ItemWatch", "", 250, -1 },
			{ "ItemRadio", "Telephone", 250, 45 },
            { "ToolKit", "", 5000, 75 },
            { "FirstAidKit", "", 750, 65 },
            { "NVGoggles", "", 2000, 980 },
            { "Chemlight_red", "", 1500, -1 },
            { "Chemlight_yellow", "", 1500, 50 },
            { "Chemlight_green", "", 1500, 50 },
            { "Chemlight_blue", "", 1500, 50 }
        };
        mags[] = {};
        accs[] = {};
    };
	
};
