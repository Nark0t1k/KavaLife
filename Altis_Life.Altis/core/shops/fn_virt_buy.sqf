#include "..\..\script_macros.hpp"
/*
	File: fn_virt_buy.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Buy a virtual item from the store.
*/
private["_type","_price","_amount","_diff","_name","_hideout"];
if((lbCurSel 2401) isEqualTo -1) exitWith {[localize "STR_Shop_Virt_Nothing"] call life_fnc_showNotification;};
_type = lbData[2401,(lbCurSel 2401)];
_price = lbValue[2401,(lbCurSel 2401)];
_amount = ctrlText 2404;
if(!([_amount] call TON_fnc_isnumber)) exitWith {[localize "STR_Shop_Virt_NoNum"] call life_fnc_showNotification;};
_diff = [_type,parseNumber(_amount),life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
_amount = parseNumber(_amount);
if(_diff <= 0) exitWith {[localize "STR_NOTF_NoSpace"] call life_fnc_showNotification;};
_amount = _diff;
_hideout = (nearestObjects[getPosATL player,["FlagPole_F"],50]) select 0;
if((_price * _amount) > life_KavaCash) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};
if((time - life_action_delay) < 0.2) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;

_name = M_CONFIG(getText,"VirtualItems",_type,"displayName");

if(([true,_type,_amount] call life_fnc_handleInv)) then
{

	if((_price * _amount) > life_KavaCash) exitWith {[localize "STR_NOTF_NotEnoughMoney"] call life_fnc_showNotification; [false,_type,_amount] call life_fnc_handleInv;};
	[7,"STR_Shop_Virt_BoughtItem",true,[_amount,(localize _name),(_price * _amount)]] remoteExecCall ["life_fnc_broadcast",player];
	SUB(life_KavaCash,(_price * _amount));
	[] call life_fnc_virt_update;
};

[] call life_fnc_hudUpdate;
[0] call SOCK_fnc_updatePartial;
[3] call SOCK_fnc_updatePartial;
