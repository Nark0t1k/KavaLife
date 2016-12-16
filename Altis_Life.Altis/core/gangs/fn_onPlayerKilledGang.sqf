#include "..\..\script_macros.hpp"
/*
    File: fn_onPlayerKilledGang.sqf

*/
private ["_killer", "_enemyGangQG", "_GangWar", "_enemyGangWar", "_gangName", "_exit", "_GangHonor", "_enemyGangHonor"];

if (playerSide != civilian) exitWith {}; //What in the hell?
_killer = param [0,ObjNull,[ObjNull]];
if(isNull _killer)exitWith {};
_enemyGangQG = _killer getVariable ["gang_qg",objNull];
if(isNull life_gangQG)exitWith {};
if(isNull _enemyGangQG)exitWith {};
_GangWar = life_gangQG getVariable ["gang_war",[]];
if(count _GangWar isEqualTo 0)exitWith {};
_enemyGangWar = _enemyGangQG getVariable ["gang_war",[]];
if(count _enemyGangWar isEqualTo 0)exitWith {};

_gangName = life_gangQG getVariable ["gang_name",""];
_exit = false;
{
	if((_x select 0) isEqualTo _gangName)exitWith 
	{
		_exit = true;
	};
}forEach _enemyGangWar;
if(!_exit)exitWith {};
_GangHonor = life_gangQG getVariable ["gang_honor",0];
_enemyGangHonor = _enemyGangQG getVariable ["gang_honor",0];
_GangHonor = _GangHonor - 1;
_enemyGangHonor = _enemyGangHonor + 1;
life_gangQG setVariable ["gang_honor",_GangHonor,true];
_enemyGangQG setVariable ["gang_honor",_enemyGangHonor,true];

if (life_HC_isActive) then {
	[7,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
	[7,_enemyGangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
} else {
	[7,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
	[7,_enemyGangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
};

[4,localize "STR_War_WinHonor"] remoteExecCall ["life_fnc_broadcast",_killer];
[4,localize "STR_War_LoseHonor"] remoteExecCall ["life_fnc_broadcast",player];

