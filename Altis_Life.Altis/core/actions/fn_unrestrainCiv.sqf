#include "..\..\script_macros.hpp"
/*
	File: fn_unrestrain.sqf
	Author: 
	
	Description:
	
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit OR !(_unit getVariable ["restrainedciv",FALSE])) exitWith {}; //Error check?

_unit setVariable ["restrainedciv",FALSE,TRUE];
_unit setVariable ["Escorting",FALSE,TRUE];
_unit setVariable ["transporting",FALSE,TRUE];
detach _unit;

[[0,7],localize "STR_NOTF_Unrestrain"] remoteExecCall ["life_fnc_broadcast",player];