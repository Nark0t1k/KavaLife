#include "..\..\script_macros.hpp"
/*
	File: fn_jail.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the initial process of jailing.
*/
private["_bad","_unit","_time"];
params [
	["_unit",objNull,[objNull]],
	["_bad",false,[false]],
	["_time",15,[0]]
];
if(isNull _unit) exitWith {}; //Dafuq?
if(_unit != player) exitWith {}; //Dafuq?
// if(life_is_arrested) exitWith {}; //Dafuq i'm already arrested

player setVariable ["restrained",false,true];
player setVariable ["restrainedciv",false,true];
player setVariable ["Escorting",false,true];
player setVariable ["transporting",false,true];


[localize "STR_Jail_LicenseNOTF"] call life_fnc_showNotification;
player setPos (getMarkerPos "jail_marker");

if(_bad) then {
	waitUntil {alive player};
	sleep 1;
	[localize "STR_Jail_Suicide"] call life_fnc_showNotification;
}else
{
	[localize "STR_Jail_Warn"] call life_fnc_showNotification;
};

//Check to make sure they goto check
if(player distance (getMarkerPos "jail_marker") > 40) then {
	player setPos (getMarkerPos "jail_marker");
};

[1] call life_fnc_removeLicenses;

{
	_amount = ITEM_VALUE(_x);
	if(_amount > 0) then {
		[false,_x,_amount] call life_fnc_handleInv;
	};
} forEach ["heroin_unprocessed","heroin_processed","cannabis","marijuana","cocaine_unprocessed","cocaine_processed","turtle_raw"];

life_is_arrested = true;
life_is_alive = true;

[true,"apple",15] call life_fnc_handleInv;
[true,"waterBottle",5] call life_fnc_handleInv;

removeAllWeapons player;
{player removeMagazine _x;} forEach (magazines player);
removeUniform player;
removeVest player;
removeBackpack player;
removeGoggles player;
removeHeadGear player;
{
    player unassignItem _x;
    player removeItem _x;
	true;
} count (assignedItems player);
player addUniform "U_C_WorkerCoveralls";
[] call life_fnc_playerSkins;

if(life_HC_isActive) then {
	[player,_bad] remoteExecCall ["HC_fnc_jailSys",HC_Life];
} else {
	[player,_bad,_time] remoteExecCall ["life_fnc_jailSys",RSERV];
};

[5] call SOCK_fnc_updatePartial;