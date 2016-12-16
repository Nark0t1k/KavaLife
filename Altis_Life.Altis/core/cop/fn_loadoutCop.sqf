/*
    fn_loadoutCop.sqf
   
*/
private["_type","_rank","_action","_price"];
_type = _this select 3;
_action = false;
_price = 5000;
switch (_type) do
{
    case 0:{_price = 5000;_rank = 1;};
    case 1:{_price = 15000;_rank = 2;};
    case 2:{_price = 25000;_rank = 3;};
    case 3:{_price = 35000;_rank = 4;};
    case 4:{_price = 45000;_rank = 4;};
    case 5:{_price = 50000;_rank = 4;};
    case 6:{_price = 50000;_rank = 5;};
    case 7:{_price = 50000;_rank = 6;};
    case 8:{_price = 50000;_rank = 7;};
    case 9:{_price = 50000;_rank = 8;};
    case 10:{_price = 50000;_rank = 9;};
    case 15:{_price = 5000;_rank = 0;};
    case 16:{_price = 25000;_rank = 2;};
};
 
if((player getVariable ["rank",0]) < _rank)exitWith {hint "Tu na pas acces a ce kit.";};
if(life_KavaBank < _price) exitWith {hint format["Tu as besoin de %1$ pour acheter se kit",[_price] call life_fnc_numberText];};
 
_action = [
    format["L achat du kit coute: %1$",[_price] call life_fnc_numberText],
    localize "Achat de Kit Gendarme",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call BIS_fnc_guiMessage;
 
if(!_action) exitWith {};
 
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;
switch (_type) do
{
    // GAV - Rank 1
    case 0:
    {
        player forceAddUniform "U_B_CombatUniform_mcam_worn";
        player addVest "V_TacVest_gen_F";
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 3 do {player addItemToBackpack "FirstAidKit";};
        for "_i" from 1 to 2 do {player addItemToBackpack "ToolKit";};
        for "_i" from 1 to 6 do {player addItemToBackpack "30Rnd_9x21_Mag_SMG_02";};
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_MilCap_gen_F";
        player addGoggles "G_Squares_Tinted";
        player addWeapon "SMG_02_F";
        player addPrimaryWeaponItem "acc_flashlight";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Gendarme MK20c  - Rank 2
    case 1:
    {
        player forceAddUniform "U_B_CombatUniform_mcam_worn";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_TacVest_gen_F";
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 2 do {player addItemToVest "30Rnd_556x45_Stanag";};
        player addBackpack "B_Carryall_cbr";
        player addItemToBackpack "ToolKit";
        for "_i" from 1 to 4 do {player addItemToBackpack "30Rnd_556x45_Stanag";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_blk";
        player addWeapon "arifle_Mk20_F";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";

    };
    // Adjudant Mx  - Rank 3
    case 2:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_PlateCarrier1_blk";
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 6 do {player addItemToVest "30Rnd_65x39_caseless_mag";};
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "arifle_MX_Black_F";
        player addPrimaryWeaponItem "acc_flashlight";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Major MXM  - Rank 4
    case 3:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_PlateCarrier1_blk";
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 6 do {player addItemToVest "30Rnd_65x39_caseless_mag";};
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "arifle_MXM_Black_F";
        player addPrimaryWeaponItem "bipod_01_F_blk";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Major Spar 16  - Rank 4
    case 4:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_PlateCarrier1_blk";
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 2 do {player addItemToVest "30Rnd_556x45_Stanag";};
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        for "_i" from 1 to 4 do {player addItemToBackpack "30Rnd_556x45_Stanag";};
        for "_i" from 1 to 2 do {player addItemToBackpack "30Rnd_9x21_Mag";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "arifle_SPAR_01_blk_F";
        player addPrimaryWeaponItem "bipod_01_F_blk";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
 
    };
    // Major MX SW - Rank 4
    case 5:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addItemToUniform "30Rnd_9x21_Mag";
        player addVest "V_PlateCarrier1_blk";
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        player addItemToVest "30Rnd_9x21_Mag";
        for "_i" from 1 to 6 do {player addItemToVest "30Rnd_65x39_caseless_mag";};
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "arifle_MX_SW_Black_F";
        player addPrimaryWeaponItem "bipod_01_F_blk";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Lieutenant CAR-95 - Rank 5
    case 6:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addItemToUniform "30Rnd_580x42_Mag_F";
        player addVest "V_PlateCarrier1_blk";
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        for "_i" from 1 to 3 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 5 do {player addItemToVest "30Rnd_580x42_Mag_F";};
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "arifle_CTAR_blk_F";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Capitaine Spar17 - Rank 6
    case 7:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_PlateCarrier2_blk";
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        for "_i" from 1 to 2 do {player addItemToVest "20Rnd_762x51_Mag";};
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        for "_i" from 1 to 4 do {player addItemToBackpack "20Rnd_762x51_Mag";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "arifle_SPAR_03_blk_F";
        player addPrimaryWeaponItem "bipod_01_F_blk";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // COMMANDANT MK14 - Rank 7
    case 8:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 1 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_PlateCarrier2_blk";
        player addItemToVest "FirstAidKit";
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 2 do {player addItemToVest "20Rnd_762x51_Mag";};
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        for "_i" from 1 to 4 do {player addItemToBackpack "20Rnd_762x51_Mag";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "srifle_DMR_06_olive_F";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Lt colonel - Rank 8
    case 9:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_PlateCarrier2_blk";
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        for "_i" from 1 to 2 do {player addItemToVest "16Rnd_9x21_Mag";};
        for "_i" from 1 to 2 do {player addItemToVest "20Rnd_762x51_Mag";};
        player addBackpack "B_Carryall_cbr";
        player addItemToVest "SmokeShellGreen";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        for "_i" from 1 to 4 do {player addItemToBackpack "20Rnd_762x51_Mag";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_02";
        player addWeapon "srifle_DMR_03_khaki_F";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Colonel - Rank 9
    case 10:
    {
        player forceAddUniform "U_B_SpecopsUniform_sgg";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_PlateCarrierSpec_blk";
        for "_i" from 1 to 2 do {player addItemToVest "HandGrenade_Stone";};
        for "_i" from 1 to 6 do {player addItemToVest "20Rnd_762x51_Mag";};
        player addItemToVest "SmokeShellGreen";
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 3 do {player addItemToBackpack "16Rnd_9x21_Mag";};
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        player addItemToBackpack "H_CrewHelmetHeli_B";
        player addItemToBackpack "G_Balaclava_TI_blk_F";
        player addHeadgear "H_Beret_Colonel";
        player addWeapon "srifle_EBR_F";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    }; 
   
    // FreeSlot - Rank 0
    case 15:
    {
        player forceAddUniform "U_Rangemaster";
        for "_i" from 1 to 3 do {player addItemToUniform "16Rnd_9x21_Mag";};
        player addVest "V_TacVest_gen_F";
        for "_i" from 1 to 4 do {player addItemToVest "FirstAidKit";};
        for "_i" from 1 to 3 do {player addItemToVest "16Rnd_9x21_Mag";};
        player addBackpack "B_Carryall_oucamo";
        for "_i" from 1 to 2 do {player addItemToBackpack "ToolKit";};
        player addHeadgear "H_MilCap_gen_F";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
    // Plonger - Rank 2 +
    case 16:
    {
		player forceAddUniform "U_B_Wetsuit";
        for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
        player addVest "V_RebreatherB";
        player addBackpack "B_Carryall_cbr";
        for "_i" from 1 to 1 do {player addItemToBackpack "ToolKit";};
        for "_i" from 1 to 6 do {player addItemToBackpack "30Rnd_556x45_Stanag";};
        for "_i" from 1 to 2 do {player addItemToBackpack "30Rnd_9x21_Mag";};  
		player addGoggles "G_B_Diving";
        player addWeapon "arifle_SDAR_F";
        player addWeapon "hgun_P07_snds_F";
        player addWeapon "Rangefinder";
    };
};
 
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";
player linkItem "NVGoggles_OPFOR";
 
hint format["Vous avez achete un kit pour %1$", [_price] call life_fnc_numberText];
life_KavaBank = life_KavaBank - _price;
[format["[COP.KIT] %1(%2) a recu un Kit numero %3",name player, _type]] remoteExecCall ["A3Log", 2];
[] call life_fnc_playerSkins;
[] call SOCK_fnc_updateRequest;