#include "..\..\script_macros.hpp"
/*
	File: fn_giveMoney.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Gives the selected amount of money to the selected player.
*/
private["_unit","_amount","_old"];
_type = _this select 0;
if(_type isEqualTo 0)then
{
	_amount = ctrlText 3702;
}else
{
	_amount=format["%1",_type];
};
_unit = life_pInact_curTarget;
if(isNil "_unit") exitWith {};
if(_unit isEqualTo player) exitWith {};
if(isNull _unit) exitWith {};
if(player distance _unit > 10) exitWith {hint parseText "La personne n'est pas prêt de vous";};
if((time - life_action_delay) < 2) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;
//A series of checks *ugh*
if(!life_use_atm) exitWith {hint parseText "You recently robbed the bank! You can't give money away just yet.";};
if(!([_amount] call TON_fnc_isnumber)) exitWith {hint parseText "You didn't enter an actual number format.";};
if(parseNumber(_amount) <= 0) exitWith {hint parseText "You need to enter an actual amount you want to give.";};
if(parseNumber(_amount) > life_KavaCash) exitWith {hint parseText "You don't have that much to give!";};
if(isNull _unit) exitWith {};
if(isNil "_unit") exitWith {hint parseText "The selected player is not within range";};

[format["Tu as donné %1$",[(parseNumber(_amount))] call life_fnc_numberText]] call life_fnc_showNotification;
life_KavaCash = life_KavaCash - (parseNumber(_amount));

[0] call SOCK_fnc_updatePartial;
[_unit,_amount,player] remoteExecCall ["life_fnc_receiveMoney",_unit];
[] call life_fnc_p_updateMenu;
[] call life_fnc_hudUpdate;
[format["[MONEYGIVE] %1(%2) -MONTANT: %3 -CASH APRES: %4 -CIBLE: %5(%6)", name player, getPlayerUID player, [life_KavaCash] call life_fnc_numberText,_amount,_unit getVariable["realname",name _unit], getPlayerUID _unit]] remoteExecCall ["A3Log", 2];