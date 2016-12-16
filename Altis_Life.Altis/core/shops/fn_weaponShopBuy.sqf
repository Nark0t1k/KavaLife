#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopBuy.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master handling of the weapon shop for buying / selling an item.
*/
disableSerialization;
private ["_price", "_item", "_itemInfo", "_shop", "_stock", "_funds", "_reduc","_nbrMeca","_weaponsTracking"];
if((lbCurSel 39503) isEqualTo -1) exitWith {[localize "STR_Shop_Weapon_NoSelect"] call life_fnc_showNotification;};
_price = lbValue[39503,(lbCurSel 39503)]; if(isNil "_price") then {_price = 0;};
_item = lbData[39503,(lbCurSel 39503)];
_itemInfo = [_item] call life_fnc_fetchCfgDetails;
_shop = uiNamespace getVariable ["Weapon_Shop",""];
_nbrMeca = 0;
if((_itemInfo select 6) != "CfgVehicles") then {
	if((_itemInfo select 4) in [4096,131072]) then {
		if(!(player canAdd _item)) exitWith {_bad = (localize "STR_NOTF_NoRoom")};
	};
};

if(playerSide isEqualTo civilian)then
{
	if(_item isEqualTo "ToolKit") then
	{
		_nbrMeca = {(str _x in life_listMecano) && (alive _x) && (side _x isEqualTo independent)} count playableUnits;
		if(_nbrMeca > 0) then{_price = round(_price*2);};
	}else
	{
		_stock = 20;
	};
};

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
if(_shop isEqualTo "gangShop") then {
	_funds = GANG_FUNDS;
	_reduc = 0;
	if(life_gangAreaOwner != 0) then
	{
		_reduc = life_gangAreaOwner*10;
		_price = _price-(round(_price/100*_reduc));
	};
	if(_price > _funds) exitWith {[localize "STR_NOTF_NotEnoughMoney"] call life_fnc_showNotification;};
	if((_item in _weaponsTracking) && (playerside isEqualTo civilian))exitWith
	{
		closedialog 0;
		if((time - life_action_delay) < 2) exitWith {hint localize "STR_NOTF_ActionDelay";};
		life_action_delay = time;
		sleep 1;
		[_item,player,false,_price,true] remoteExecCall ["TON_fnc_buyWeaponMarket",RSERV];
	};
	_funds = _funds - _price;
	[format[localize "STR_Shop_Weapon_BoughtGang",_itemInfo select 1,[_price] call life_fnc_numberText]] call life_fnc_showNotification;
	life_gangQG setVariable["gang_bank",_funds,true];
	[_item,true] spawn life_fnc_handleItem;
	if(life_HC_isActive) then {
		[1,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life];
	} else {
		[1,life_gangQG] remoteExecCall ["TON_fnc_updateGang",RSERV];
	};
	[format["[ACHATOBJETREEL.GANG] %1(%2) -BANK.GANG AVANT: %3 -ITEM: %4 -PRIX: %5 -BANK.GANG APRES: %6",name player, getPlayerUID player,[_funds+_price] call life_fnc_numberText,_item,_price,[_funds] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
	
} else {
	if(_price > life_KavaCash) exitWith {[localize "STR_NOTF_NotEnoughMoney"] call life_fnc_showNotification;};
	if((_item in _weaponsTracking) && (playerside isEqualTo civilian))exitWith
	{
		closedialog 0;
		hint parseText "Vérification des stocks...";
		sleep (random 3);
		[_item,player,false,_price] remoteExecCall ["TON_fnc_buyWeaponMarket",RSERV];
	};
	[format[localize "STR_Shop_Weapon_BoughtItem",_itemInfo select 1,[_price] call life_fnc_numberText]] call life_fnc_showNotification;
	SUB(life_KavaCash,_price);
	[_item,true] spawn life_fnc_handleItem;
	[format["[ACHATOBJETREEL] %1(%2) -CASH AVANT: %3 -ITEM: %4 -PRIX: %5 -CASH APRES: %6",name player, getPlayerUID player,[life_KavaCash+_price] call life_fnc_numberText,_item,_price,[life_KavaCash] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
};
[] call life_fnc_saveGear;
[0] call SOCK_fnc_updatePartial;
[3] call SOCK_fnc_updatePartial;
[] call life_fnc_hudUpdate;