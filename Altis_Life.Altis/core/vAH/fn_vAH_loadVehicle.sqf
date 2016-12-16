#include "..\..\script_macros.hpp"
/*
	File: fn_vAH_loadVehicle.sqf
	Author: Fresqo
	Description: Loads players items from person and auction house and displays it in game UID
	- The load i gear is from Tonics base code pretty sure
*/

[getPlayerUID player,playerSide,player] remoteExec ["TON_fnc_getAllVehicles",RSERV];