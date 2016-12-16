#include "..\..\script_macros.hpp"
/*
	File: fn_bankDeposit.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Figure it out.
*/
private "_value";
_type = _this select 0;
if(_type) then
{
	_value = life_KavaCash;
	if(_value > 999999) then {_value = 999999;};
}else
{
	_value = parseNumber(ctrlText 2702);
};
//Series of stupid checks
if(_value > 999999) exitWith {[localize "STR_ATM_GreaterThan"] call life_fnc_showNotification;};
if(_value < 0) exitWith {};
if(!([str(_value)] call life_fnc_isnumeric)) exitWith {[localize "STR_ATM_notnumeric"] call life_fnc_showNotification;};
if(_value > life_KavaCash) exitWith {[localize "STR_ATM_NotEnoughCash"] call life_fnc_showNotification;};
if((time - life_action_delay) < 2) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;
life_KavaCash = life_KavaCash - _value;
life_KavaBank = life_KavaBank + _value;

[format[localize "STR_ATM_DepositSuccess",[_value] call life_fnc_numberText]] call life_fnc_showNotification;
[] call life_fnc_atmMenu;
[6] call SOCK_fnc_updatePartial;
[] call life_fnc_hudUpdate;
[format["[BANKDEP] %1(%2) -BANKAVANT: %3 -CASHAVANT: %4 -MONTANT: %5 -BANK APRES: %6 - CASH APRES: %7", name player, getPlayerUID player, [life_KavaBank-_value] call life_fnc_numberText, [life_KavaCash+_value] call life_fnc_numberText,[_value] call life_fnc_numberText,[life_KavaBank] call life_fnc_numberText, [life_KavaCash] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];