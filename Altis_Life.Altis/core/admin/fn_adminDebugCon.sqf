#include "..\..\script_macros.hpp"
/*
	File: fn_adminDebugCon.sqf
	Author: ColinM9991

	Description:
	Opens the Debug Console.
*/
if((call life_adminlevel) < 5) exitWith {closeDialog 0; hint parseText "You have no business using this";};
life_admin_debug = true;

createDialog "RscDisplayDebugPublic";
[format['[ADMIN] %1(%2) -Debug Console',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
