#include "..\..\script_macros.hpp"
/*
	File: fn_adminTeleport.sqf
	Author: ColinM9991
	Credits: To original script author(s)
	Description:
	Teleport to chosen position.
*/
if((call life_adminlevel) < 4) exitWith {closeDialog 0;};
[format['[ADMIN] %1(%2) -USE TP',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
[] spawn {
  while {dialog} do {
   closeDialog 0;
   sleep 0.01;
  };
};

openMap [true, false];
onMapSingleClick "[_pos select 0, _pos select 1, _pos select 2] call life_fnc_teleport";
