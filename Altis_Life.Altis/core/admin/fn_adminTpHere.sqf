#include "..\..\script_macros.hpp"
/*
	File: fn_adminTpHere.sqf
	Author: ColinM9991
	
	Description:
	Teleport selected player to you.
*/
if((call life_adminlevel) < 2) exitWith {closeDialog 0;};

private["_target"];
_target = lbData[2902,lbCurSel (2902)];
_target = call compile format["%1", _target];
if(isNil "_target") exitwith {};
if(isNull _target) exitWith {};
if(_target isEqualTo player) exitWith {hint localize "STR_ANOTF_Error";};
[format['[ADMIN] %1(%2) -TP HERE: %3(%4)',name player, getPlayerUID player,name _target, getPlayerUID _target],"ADMIN"] remoteExecCall ["A3Log",2];
_target setPosWorld (getPosWorld player);
hint format["You have teleported %1 to your location",_target getVariable["realname",name _target]];