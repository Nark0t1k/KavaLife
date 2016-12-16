#include "..\..\script_macros.hpp"
/*
	File: fn_restrainActionCiv.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Retrains the target.
*/
private["_unit"];
_unit = cursorTarget;
if(isNull _unit) exitWith {}; //Not valid
if(!([false,"menotte",1] call life_fnc_handleInv))exitWith {hint parseText "Tu n'as pas de menotte";};
if((player distance _unit > 3)) exitWith {[true,"menotte",1] call life_fnc_handleInv;};
if((_unit getVariable "restrainedciv")) exitWith {[true,"menotte",1] call life_fnc_handleInv;};
if((_unit getVariable "restrained")) exitWith {};
if(player isEqualTo _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
//Broadcast!

_unit setVariable["restrainedciv",true,true];
[player] remoteExec ["life_fnc_restrainCiv",_unit];
[[0,7],localize "STR_NOTF_Restrained"] remoteExecCall ["life_fnc_broadcast",player];
