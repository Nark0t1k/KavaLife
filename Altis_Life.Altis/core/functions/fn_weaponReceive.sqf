#include "..\..\script_macros.hpp"
/*
	fn_weaponReceive.sqf
*/


private ["_item", "_unit", "_type", "_price", "_gang", "_itemInfo", "_funds", "_tmp","_QG"];

_item = [_this,0,"",[""]] call BIS_fnc_param;
_stock = [_this,1,0,[0]] call BIS_fnc_param;
_type = [_this,2,false,[false]] call BIS_fnc_param;
_price = [_this,3,0,[0]] call BIS_fnc_param;
_gang = [_this,4,false,[false]] call BIS_fnc_param;
_ret = [_this,5,[],[[]]] call BIS_fnc_param;
_itemInfo = [_item] call life_fnc_fetchCfgDetails;
life_weaponMarketTrack = _ret;

if(_type) then
{
	_tmp = weapons player;
	if(!(_item in _tmp))exitWith {};
	if((_item isEqualTo handgunWeapon player) || (_item isEqualTo primaryWeapon player))then
	{
		player removeWeapon _item;
	}else
	{
		player removeItem _item;
	};
	ADD(life_KavaCash,_price);
	[format[localize "STR_Shop_Weapon_Sold",_itemInfo select 1,[_price] call life_fnc_numberText]] call life_fnc_showNotification;
	[format["[VENTE-ARME] %1(%2) -CASH AVANT: %3 -ITEM: %4 -PRIX: %5 -CASH APRES: %6",name player, getPlayerUID player,[life_KavaCash-_price] call life_fnc_numberText,_item,_price,[life_KavaCash] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
}else
{
	if(_stock < 1)exitWith {hint parseText "Il n'y as plus d'armes de ce type dans les stocks";};
	if(_gang)then
	{
		_funds = GANG_FUNDS;
		_funds = _funds - _price;
		[format[localize "STR_Shop_Weapon_BoughtGang",_itemInfo select 1,[_price] call life_fnc_numberText]] call life_fnc_showNotification;
		life_gangQG setVariable["gang_bank",_funds,true];
		[_item,true] spawn life_fnc_handleItem;
	}else
	{
		[format[localize "STR_Shop_Weapon_BoughtItem",_itemInfo select 1,[_price] call life_fnc_numberText]] call life_fnc_showNotification;
		SUB(life_KavaCash,_price);
		[_item,true] spawn life_fnc_handleItem;
		[format["[ACHAT-ARME] %1(%2) -CASH AVANT: %3 -ITEM: %4 -PRIX: %5 -CASH APRES: %6",name player, getPlayerUID player,[life_KavaCash+_price] call life_fnc_numberText,_item,_price,[life_KavaCash] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
	};
};

[] call life_fnc_saveGear;
[] call life_fnc_hudUpdate;