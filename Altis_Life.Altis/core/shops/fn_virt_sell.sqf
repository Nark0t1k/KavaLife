#include "..\..\script_macros.hpp"
/*
	File: fn_virt_sell.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Sell a virtual item to the store / shop
*/
private["_max","_type","_index","_price","_amount","_name","_bourseItem","_oldAmount","_rdmAction"];
if(EQUAL(lbCurSel 2402,-1)) exitWith {};
_max = _this select 0;
_type = lbData[2402,(lbCurSel 2402)];
_price = M_CONFIG(getNumber,"VirtualItems",_type,"sellPrice");
_rdmAction = round(random 10000);
life_currentAction = _rdmAction;
if(EQUAL(_price,-1)) exitWith {};
if(life_currentAction != _rdmAction)exitWith{};
_bourseItem =
[
	"frite",
	"cement","woodplank","glass","salt_refined",
	"copper_refined","silver_refined","iron_refined","diamond_cut","diamond_taille","oil_processed",
	"biere","vodka","wisky",
	"marijuana","heroin_processed","cocaine_processed","methDesinc","uraniumPur","turtle_raw"
];
if(_type in _bourseItem)then
{
	_price = 0.0;
	_itemNameToSearchFor = _type;
	{
		_curItemName = _x select 0;
		_curItemPrice = _x select 1;
		if (_curItemName==_itemNameToSearchFor) then {_price=_curItemPrice};
	} forEach DYNMARKET_prices;
};
if(_max isEqualTo 0) then
{
	_amount = format["%1",(ITEM_VALUE(_type))];
}else
{
	_amount = ctrlText 2405;
};
if(life_currentAction != _rdmAction)exitWith{};
if(!([_amount] call TON_fnc_isnumber)) exitWith {[localize "STR_Shop_Virt_NoNum"] call life_fnc_showNotification;};
_amount = parseNumber (_amount);
if(_amount > (ITEM_VALUE(_type))) exitWith {[localize "STR_Shop_Virt_NotEnough"] call life_fnc_showNotification;};

if((time - life_action_delay) < 0.2) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;

if(({side _x isEqualTo west} count playableUnits < 3) && (EQUAL(life_shop_type,"drugdealer"))) exitWith {
 	[format [localize "STR_Civ_NotEnoughCops",3]] call life_fnc_showNotification;
};
if(life_currentAction != _rdmAction)exitWith{};
_price = round(_price);
_price = (_price * _amount);
_name = M_CONFIG(getText,"VirtualItems",_type,"displayName");
if(([false,_type,_amount] call life_fnc_handleInv)) then {
	[format[localize "STR_Shop_Virt_SellItem",_amount,(localize _name),[_price] call life_fnc_numberText]] call life_fnc_showNotification;
	ADD(life_KavaCash,_price);
	[format["[VENTEITEMVIRTUEL] %1(%2) -CASH AVANT: %3 -ITEM: %4 -NBR:%5 -PRIXTOT: %6 -CASH APRES: %7",name player, getPlayerUID player,[life_KavaCash-_price] call life_fnc_numberText,_name,_amount,_price,[life_KavaCash] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
	[] call life_fnc_virt_update;	
	DYNAMICMARKET_boughtItems pushBack [_type,_amount];
};

if(EQUAL(life_shop_type,"drugdealer")) then {
	private["_array","_ind","_val"];
	_array = life_shop_npc getVariable["sellers",[]];
	_ind = [getPlayerUID player,_array] call TON_fnc_index;
	if(!(EQUAL(_ind,-1))) then {
		_val = SEL(SEL(_array,_ind),2);
		ADD(_val,_price);
		_array set[_ind,[getPlayerUID player,profileName,_val]];
		life_shop_npc setVariable["sellers",_array,true];
	} else {
		_array pushBack [getPlayerUID player,profileName,_price];
		life_shop_npc setVariable["sellers",_array,true];
	};
};

if(EQUAL(life_shop_type,"gold") && (LIFE_SETTINGS(getNumber,"noatm_timer")) > 0) then {
	[] spawn {
		life_use_atm = false;
		sleep ((LIFE_SETTINGS(getNumber,"noatm_timer")) * 60);
		life_use_atm = true;
	};
};
[] call life_fnc_hudUpdate;
[0] call SOCK_fnc_updatePartial;
[3] call SOCK_fnc_updatePartial;
