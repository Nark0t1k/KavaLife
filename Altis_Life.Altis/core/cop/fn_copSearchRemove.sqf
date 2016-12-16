/*	
File: fn_copSearchRemove.sqf
*/

private ["_uniform","_uid","_cop", "_primaryWeapon", "_handgunWeapon", "_vest", "_headgear", "_goggles", "_illegalStuff", "_weapAccessories", "_backpack", "_vestItems", "_uniformItems"];
_cop = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;

_uid = _this select 1;
if(getPlayerUID player != _uid)exitWith {};
if (isNull _cop) exitWith {};
if (player distance _cop > 5 || !alive player || !alive _cop ) exitWith {};
sleep 3;
_primaryWeapon = primaryWeapon player;
_handgunWeapon = handgunWeapon player;
_vest = vest player;
_headgear = headgear player;
_goggles = goggles player;

_illegalStuff =
[
	"srifle_LRR_camo_F","srifle_EBR_F","arifle_Katiba_F","arifle_MX_F","LMG_Mk200_F","arifle_TRG21_F","arifle_Mk20_plain_F","srifle_DMR_03_woodland_F","srifle_DMR_06_camo_F","srifle_GM6_F","arifle_AKM_F","arifle_SPAR_03_snd_F","arifle_AKS_F","arifle_CTAR_hex_F",
	"hgun_P07_snds_F","SMG_02_F","arifle_Mk20C_F","arifle_MX_Black_F","arifle_MXM_Black_F","arifle_MX_SW_Black_F","srifle_LRR_F","srifle_DMR_06_olive_F","srifle_DMR_03_khaki_F",
	"HandGrenade_Stone","SmokeShellGreen",
	"7Rnd_408_Mag","20Rnd_762x51_Mag","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_mag","200Rnd_65x39_cased_Box_Tracer","5Rnd_127x108_Mag","130Rnd_338_Mag","20Rnd_556x45_UW_mag","100Rnd_65x39_caseless_mag",
	"optic_SOS","optic_DMS","optic_MRCO","optic_Arco","optic_Hamr","optic_LRPS","optic_Aco","optic_NVS","optic_Holosight",
	"muzzle_snds_H","acc_flashlight","muzzle_snds_L",
	"U_BG_Guerilla2_1","U_I_GhillieSuit","U_I_FullGhillie_sard","U_IG_Guerrilla_6_1","U_I_CombatUniform_shortsleeve","U_IG_leader","U_I_G_Story_Protagonist_F","U_B_CTRG_2","U_O_CombatUniform_ocamo","U_O_PilotCoveralls","U_O_GhillieSuit",
	"V_TacVestIR_blk","V_PlateCarrierL_CTRG","V_PlateCarrier1_rgr","V_PlateCarrierIA1_dgtl","V_TacVest_blk","V_TacVest_brn","V_TacVest_oli","V_Chestrig_rgr","V_HarnessO_gry",
	"H_ShemagOpen_tan","H_Shemag_olive","H_ShemagOpen_khk","H_HelmetO_ocamo","H_MilCap_oucamo","H_Bandanna_camo","H_HelmetB_plain_mcamo","H_Booniehat_mcamo","H_MilCap_mcamo"
];

if(_primaryWeapon != "") then {
	_weapAccessories = primaryWeaponItems player;
	{
		if(_x in _illegalStuff) then {
			player removePrimaryWeaponItem _x;
		};
	}forEach _weapAccessories;
	if(_primaryWeapon in _illegalStuff) then {
		player removeWeaponGlobal _primaryWeapon;
	};
};

if(_handgunWeapon != "") then {
	_weapAccessories = handgunItems player;
	{
		if(_x in _illegalStuff) then {
			player removeHandgunItem _x;
		};
	}forEach _weapAccessories;
	if(_handgunWeapon in _illegalStuff) then {
		player removeWeaponGlobal _handgunWeapon;
	};
};

if(backPack player != "") then {
	_backpack = backpackItems player;
	if(count _backpack > 0) then {
		{
			if(_x in _illegalStuff) then {
				player removeItemFromBackpack _x;
			};
		}forEach _backpack;
	};
};

if(_vest != "") then {
	_vestItems = vestItems player;
	if(count _vestItems > 0) then {
		{
			if(_x in _illegalStuff) then {
				player removeItemFromVest _x;
			};
		}forEach _vestItems;
	};
	if(_vest in _illegalStuff) then {
		removeVest player;
	};
};

if(uniform player != "") then {
	_uniformItems = uniformItems player;
	if(count _uniformItems > 0) then {
		{
			if(_x in _illegalStuff) then {
				player removeItemFromUniform _x;
		   };
	   }forEach _uniformItems;
	};
};

if(uniform player != "") then {
	_uniform = uniform player;
	if(_uniform in _illegalStuff) then {removeUniform player;};
};

if(_headgear != "") then {
	if(_headgear in _illegalStuff) then {
		removeHeadgear player;
	};
};

if(_goggles != "") then {
	if(_goggles in _illegalStuff) then {
		removeGoggles player;
	};
};

hint format["%1 a effectué une fouille complete de ton inventaire.",name _cop];
[3] call SOCK_fnc_updatePartial;
