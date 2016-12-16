#include "..\..\script_macros.hpp"
/*
	File: fn_rentHouse.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Buys the house?
*/
private["_house","_uid","_action","_houseCfg"];
_house = param [0,ObjNull,[ObjNull]];
_uid = getPlayerUID player;

if(isNull _house) exitWith {};
if(!(_house isKindOf "House_F")) exitWith {};
if(!license_civ_home) exitWith {hint localize "STR_House_License"};
closeDialog 0;
if(life_HC_isActive) then {
	[_uid,_house,player] remoteExecCall ["HC_fnc_showrentHouse",HC_Life];
} else {
	[_uid,_house,player] remoteExec ["TON_fnc_showrentHouse",RSERV];
};

