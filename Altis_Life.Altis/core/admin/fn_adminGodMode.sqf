#include "..\..\script_macros.hpp"
/*
	File: fn_adminGodMode.sqf
	Author: Tobias 'Xetoxyc' Sittenauer
 
	Description: Enables God mode for Admin
*/

if((call life_adminlevel) < 4) exitWith {closeDialog 0; hint localize "STR_ANOTF_ErrorLevel";};

[] spawn {
  while {dialog} do {
   closeDialog 0;
   sleep 0.01;
  };
};
 
if(life_god) then {
	life_god = false;
	[format['[ADMIN] %1(%2) -God Mode ON',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
	titleText ["God mode disabled","PLAIN"]; titleFadeOut 2;
	player allowDamage true;
} else {
	life_god = true;
	[format['[ADMIN] %1(%2) -God Mode OFF',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
	titleText ["God mode enabled","PLAIN"]; titleFadeOut 2;
	player allowDamage false;
};