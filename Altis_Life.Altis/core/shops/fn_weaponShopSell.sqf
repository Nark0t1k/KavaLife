#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopSell.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master handling of the weapon shop for buying / selling an item.
*/
disableSerialization;
private ["_price", "_item", "_itemInfo", "_bad", "_weaponsTracking"];
if((lbCurSel 38403) isEqualTo -1) exitWith {hint localize "STR_Shop_Weapon_NoSelect"};
closeDialog 0;
_price = lbValue[38403,(lbCurSel 38403)]; 
if(isNil "_price") then {_price = 0;};
_item = lbData[38403,(lbCurSel 38403)];
_itemInfo = [_item] call life_fnc_fetchCfgDetails;
_weaponsTracking  = 
[
	"arifle_SDAR_F",
	"hgun_PDW2000_F",
	"hgun_Rook40_F",
	"hgun_ACPC2_F",
	"hgun_Pistol_heavy_01_F",
	"hgun_Pistol_heavy_02_F",
	"SMG_02_F",
	"srifle_LRR_camo_F",
	"srifle_EBR_F",
	"arifle_Katiba_F",
	"arifle_MX_F",
	"LMG_Mk200_F",
	"arifle_TRG21_F",
	"arifle_Mk20_plain_F",
	"srifle_DMR_03_woodland_F",
	"srifle_DMR_06_camo_F",
	"srifle_GM6_F",
	"arifle_Mk20C_F",
	"arifle_MX_Black_F",
	"arifle_MXM_Black_F",
	"arifle_MX_SW_Black_F",
	"srifle_LRR_F",
	"srifle_DMR_06_olive_F",
	"srifle_DMR_03_khaki_F",
	"arifle_AKM_F",
	"arifle_SPAR_03_snd_F",
	"arifle_AKS_F",
	"arifle_CTAR_hex_F"
];
if(_item in _weaponsTracking)exitWith
{
	[_item,player,true,_price] remoteExecCall ["TON_fnc_buyWeaponMarket",RSERV];
};