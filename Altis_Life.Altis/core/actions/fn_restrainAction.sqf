#include "..\..\script_macros.hpp"
/*
	File: fn_restrainAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Retrains the target.
*/
private["_unit"];
_unit = cursorTarget;
if(isNull _unit) exitWith {}; //Not valid
if((player distance _unit > 3)) exitWith {};
if((_unit getVariable "restrained")) exitWith {};
if((_unit getVariable "restrainedciv")) exitWith {};
if(side _unit isEqualTo west) exitWith {};
if(player isEqualTo _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
//Broadcast!

_unit setVariable["restrained",true,true];
[player] remoteExec ["life_fnc_restrain",_unit];
[[0,7],localize "STR_NOTF_Restrained"] remoteExecCall ["life_fnc_broadcast",player];
