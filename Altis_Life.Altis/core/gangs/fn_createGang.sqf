#include "..\..\script_macros.hpp"
/*
    File: fn_createGang.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Pulls up the menu and creates the gang?
*/
private["_gangName","_length","_badChar","_chrByte","_allowed"];
disableSerialization;

_gangName = ctrlText (CONTROL(2520,2522));
_length = count (toArray(_gangName));
_chrByte = toArray (_gangName);
_allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ ");
if (_length > 32) exitWith {[localize "STR_GNOTF_Over32"] call life_fnc_showNotification;};
_badChar = false;
{if (!(_x in _allowed)) exitWith {_badChar = true;};} forEach _chrByte;
if (_badChar) exitWith {[localize "STR_GNOTF_IncorrectChar"] call life_fnc_showNotification;};
if (life_KavaBank < (LIFE_SETTINGS(getNumber,"gang_price"))) exitWith {[format[localize "STR_GNOTF_NotEnoughMoney",[((LIFE_SETTINGS(getNumber,"gang_price")) - life_KavaBank)] call life_fnc_numberText]] call life_fnc_showNotification;};
if(!isNil {life_pInact_curTarget getVariable "gang_name"}) exitWith {hint "Le QG a deja ete achete par un autre gang";};
if (life_HC_isActive) then {
    [player,getPlayerUID player,_gangName,life_pInact_curTarget] remoteExec ["HC_fnc_insertGang",HC_Life];
} else {
    [player,getPlayerUID player,_gangName,life_pInact_curTarget] remoteExec ["TON_fnc_insertGang",RSERV];
};
hint localize "STR_NOTF_SendingData";
closeDialog 0;
life_action_gangInUse = true;