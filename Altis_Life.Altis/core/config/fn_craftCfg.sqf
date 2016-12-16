#include "..\..\script_macros.hpp"
/*
	File: fn_craftCfg.sqf
	Author: EdgeKiller

	Description:
	Master configuration file for the crafting menu.

*/
private ["_craft", "_return"];
_craft = [_this,0,"",[""]] call BIS_fnc_param;
if(_craft isEqualTo "") exitWith {closeDialog 0}; //Bad shop type passed.

if(_craft isEqualTo "weapon")then
{
	_return = [
		["arifle_SDAR_F", [["iron_refined",6]]],
		["hgun_PDW2000_F", [["iron_refined",4]]],
		["hgun_Rook40_F", [["iron_refined",3]]],
		["hgun_ACPC2_F", [["iron_refined",3]]],
		["hgun_Pistol_heavy_01_F", [["iron_refined",3]]],
		["hgun_Pistol_heavy_02_F", [["iron_refined",3]]],
		["srifle_LRR_camo_F", [["iron_refined",5],["goldbar",12]]],
		["srifle_EBR_F", [["iron_refined",15],["uraniumPur",5]]],
		["arifle_Katiba_F", [["iron_refined",16]]],
		["arifle_MX_F", [["iron_refined",16]]],
		["LMG_Mk200_F", [["iron_refined",15],["uraniumPur",5]]],
		["arifle_TRG21_F", [["iron_refined",12]]],
		["arifle_Mk20_plain_F", [["iron_refined",12]]],
		["srifle_DMR_03_woodland_F", [["iron_refined",15],["uraniumPur",5]]],
		["srifle_DMR_06_camo_F", [["iron_refined",15],["uraniumPur",5]]],
		["srifle_GM6_F", [["iron_refined",5],["goldbar",12]]],
		["SMG_02_F", [["iron_refined",6]]],
		["arifle_Mk20C_F", [["iron_refined",12]]],
		["arifle_MX_Black_F", [["iron_refined",16]]],
		["arifle_MXM_Black_F", [["iron_refined",25]]],
		["arifle_MX_SW_Black_F", [["iron_refined",25]]],
		["srifle_LRR_F", [["iron_refined",5],["goldbar",12]]],
		["srifle_DMR_06_olive_F", [["iron_refined",15],["uraniumPur",5]]],
		["srifle_DMR_03_khaki_F", [["iron_refined",15],["uraniumPur",5]]],
		["arifle_AKM_F", [["iron_refined",5],["uraniumPur",15]]],
		["arifle_SPAR_03_snd_F", [["iron_refined",5],["uraniumPur",15]]],
		["arifle_AKS_F", [["iron_refined",10],["uraniumPur",10]]],
		["arifle_CTAR_hex_F", [["iron_refined",10],["uraniumPur",10]]]
	];
};

if(_craft isEqualTo "weaponLeg")then
{
	_return = [
		//[Object classname, [item #1,quantity item #1,item #2,quantity item #2]],]
		["arifle_SDAR_F", [["copper_refined",9]]],
		["hgun_PDW2000_F", [["copper_refined",6]]],
		["hgun_Rook40_F", [["copper_refined",5]]],
		["hgun_ACPC2_F", [["copper_refined",5]]],
		["hgun_Pistol_heavy_01_F", [["copper_refined",5]]],
		["hgun_Pistol_heavy_02_F", [["copper_refined",5]]]
	];
};
_return; 