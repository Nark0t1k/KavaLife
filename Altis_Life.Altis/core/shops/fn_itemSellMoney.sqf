#include "..\..\script_macros.hpp"
/*
	File: fn_itemSellMoney.sqf
*/
private["_type","_index","_price","_amount","_name"];
_type = _this select 0;
_price = _this select 1;
_amount = _this select 2;

if((time - life_action_delay) < 0.2) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;

_name = M_CONFIG(getText,"VirtualItems",_type,"displayName");

hint format[localize "STR_Shop_Virt_SellItem",_amount,(localize _name),[_price] call life_fnc_numberText];
ADD(life_KavaCash,_price);
[] call life_fnc_virt_update;

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
