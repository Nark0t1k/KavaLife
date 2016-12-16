#include "..\..\script_macros.hpp"
/*
	File: fn_robReceive.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	
*/
params [
	["_cash",0,[0]],
	["_victim",objNull,[objNull]],
	["_robber",objNull,[objNull]]
];

if(_robber isEqualTo _victim) exitWith {};
if(EQUAL(_cash,0)) exitWith {[localize "STR_Civ_RobFail"] call life_fnc_showNotification;};

ADD(life_KavaCash,_cash);
[format[localize "STR_Civ_Robbed",[_cash] call life_fnc_numberText]] call life_fnc_showNotification;
[] call life_fnc_hudUpdate;