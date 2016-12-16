#include "..\..\script_macros.hpp"
/*
	File: fn_jailTroll.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the initial process of jailing.
*/
private["_bad","_unit","_time"];
params [
	["_unit",objNull,[objNull]],
	["_bad",false,[false]]
];
if(isNull _unit) exitWith {}; //Dafuq?
if(_unit != player) exitWith {}; //Dafuq?
// if(life_is_arrested) exitWith {}; //Dafuq i'm already arrested
player setVariable ["restrained",false,true];
player setVariable ["restrainedciv",false,true];
player setVariable ["Escorting",false,true];
player setVariable ["transporting",false,true];


player setPosATL [758.877,30000.7,213.832];

//Check to make sure they goto check
if(player distance [758.877,30000.7,213.832] > 150) then {
	player setPosATL [758.877,30000.7,213.832];
};

[format["[PRISON-TROLL] %1(%2) a ete envoyé en prison pour troll",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];

[1] call life_fnc_removeLicenses;

life_is_arrested = true;
life_is_alive = true;
removeAllWeapons player;
{player removeMagazine _x} forEach (magazines player);

if(life_HC_isActive) then {
	[player,_bad] remoteExecCall ["HC_fnc_jailTrollSys",HC_Life];
} else {
	[player,_bad] remoteExecCall ["life_fnc_jailTrollSys",RSERV];
};

[5] call SOCK_fnc_updatePartial;