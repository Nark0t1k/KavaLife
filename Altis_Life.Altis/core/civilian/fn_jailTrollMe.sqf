#include "..\..\script_macros.hpp"
/*	File: fn_jailTrollMe.sqf	
Author Bryan "Tonic" Boardwine		
Description:	Once word is received by the server the rest of the jail execution is completed.*/

private["_ret","_bad","_time","_bail","_esc","_countDown","_time"];
_ret = [_this,0,[],[[]]] call BIS_fnc_param;
[player, getPlayerUID player, 15, life_is_arrested,life_is_alive] remoteExec ["life_fnc_JailPlayer",RSERV];
hint parseText "Vous avez ete place en Prison pour troll pour 15min! Surveillez votre comportement! Si vous tentez de vous deconnecter vous reviendrais en prison avec une peine plus longue.";
 _time = time + (15 * 60);
life_thirst = 100;
life_hunger = 100;
player setdamage 0;

life_jailTimer = _time;

if(life_jailTimer <= 0) then {
	 life_jailTimer = time + (15 * 60);
	 hintC "Please Report to Admin: JAIL_FALLBACK_15, time is zero!";
};

while {true} do{
	if(player distance (getMarkerPos "adminjail_marker") > 200) then {player setPosATL [758.877,30000.7,213.832];};
	if((round(life_jailTimer - time)) < 1) exitWith {};
	if(!alive player && ((round(life_jailTimer - time)) > 0)) exitWith{};
	sleep 1;
};
if(alive player) then{
	life_is_arrested = false;
	hint parseText "Vous avez été retirez de la prison pour troll. Surveillez votre comportement!";
	player setPos (getMarkerPos "jail_release");
	[5] call SOCK_fnc_updatePartial;
};

[player, getPlayerUID player, 0, life_is_arrested,life_is_alive] remoteExec ["life_fnc_JailPlayer",RSERV];

