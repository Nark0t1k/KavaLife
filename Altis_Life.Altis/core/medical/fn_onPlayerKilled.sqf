#include "..\..\script_macros.hpp"
/*
	File: fn_onPlayerKilled.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	When the player dies collect various information about that player
	and pull up the death dialog / camera functionality.
*/
private ["_unit", "_nearest", "_distance", "_isVehicle", "_killer", "_handle","_side"];
params [
	["_unit",objNull,[objNull]],
	["_killer",objNull,[objNull]]
];
disableSerialization;
#define PVP_ZONES    [["gang_area_1", 250],["gang_area_2", 250],["gang_area_3", 250],["gang_area_4", 250],["gang_area_5", 250],["gang_area_6", 250],["gang_area_7", 350]]
if((typeName life_WhiteList) isEqualTo (typeName []))exitWith {["FailWhite",true,true] call BIS_fnc_endMission;};
_side = false;
if((vehicle _unit) != _unit) then {
	(vehicle _unit) lock 0;
	UnAssignVehicle _unit;
	_unit action ["getOut", vehicle _unit];
	_unit setPosATL [(getPosATL _unit select 0) + 3, (getPosATL _unit select 1) + 1, 0];
};
life_is_alive = false;
if(playerside isEqualTo civilian)then
{
	life_is_arrested = true;
	[player, getPlayerUID player, 30, life_is_arrested,life_is_alive] remoteExec ["life_fnc_JailPlayer",RSERV];
};

_isVehicle = if((_killer isKindOf 'LandVehicle') || (_killer isKindOf 'Air') || (_killer isKindOf 'Ship') || (_killer isKindOf 'Tank'))then{true}else{false};

if((_killer isEqualTo _unit) || (isNull _killer)) then
{
		if (({_unit distance getMarkerPos (_x select 0) < _x select 1} count PVP_ZONES > 0) && playerSide isEqualTo civilian) then
		{
			[0,format["%1 est tombé dans le coma",name _unit]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
			[format["[COMA-PVP] %1(%2) DANSPVP EST TOMBER DANS LE COMA SOLO",name _unit, getPlayerUID _unit]] remoteExecCall ["A3Log", 2];
		}else
		{
			[0,format["%1 est tombé dans le coma",name _unit]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
			[format["[COMA] %1(%2) EST TOMBER DANS LE COMA SOLO",name _unit, getPlayerUID _unit]] remoteExecCall ["A3Log", 2];
		};
}else
{
	if((side _unit isEqualTo civilian) && (side _killer isEqualTo west))then{_side = true;};
	if (({_killer distance getMarkerPos (_x select 0) < _x select 1} count PVP_ZONES > 0) && playerSide isEqualTo civilian) then
	{
		if (({_unit distance getMarkerPos (_x select 0) < _x select 1} count PVP_ZONES > 0) && playerSide isEqualTo civilian) then
		{
			[0,format["%1 a mis %2 dans le coma depuis une zone PVP",name _killer, name _unit]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
			[format["[COMA-PVP] %1(%2) DANSPVP EST TOMBER DANS LE COMA TUEUR: %3(%4) DANSPVP DISTANCE: %5 ARME: %6",name _unit, getPlayerUID _unit,name _killer, getPlayerUID _killer,(_unit distance _killer),currentWeapon _killer]] remoteExecCall ["A3Log", 2];
		}else
		{
			[0,format["%1 a mis %2 dans le coma dans une zone PVP",name _killer, name _unit]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
			[format["[COMA-PVP] %1(%2) PASPVP EST TOMBER DANS LE COMA TUEUR: %3(%4) DANSPVP DISTANCE: %5 ARME: %6",name _unit, getPlayerUID _unit,name _killer, getPlayerUID _killer,(_unit distance _killer),currentWeapon _killer]] remoteExecCall ["A3Log", 2];
		};
	}else
	{
		if (({_unit distance getMarkerPos (_x select 0) < _x select 1} count PVP_ZONES > 0) && playerSide isEqualTo civilian) then
		{
			[0,format["%1 a mis %2 dans le coma dans une zone PVP",name _killer, name _unit]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
			[format["[COMA-PVP] %1(%2) DANSPVP EST TOMBER DANS LE COMA TUEUR: %3(%4) PASPVP DISTANCE: %5 ARME: %6",name _unit, getPlayerUID _unit,name _killer, getPlayerUID _killer,(_unit distance _killer),currentWeapon _killer]] remoteExecCall ["A3Log", 2];
		}else
		{
			if(_isVehicle)then
			{
				[0,format["%1 est tombé dans le coma",name _unit]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
				[format["[COMA] %1(%2) EST TOMBER DANS LE COMA SOLO VEHICLE",name _unit, getPlayerUID _unit]] remoteExecCall ["A3Log", 2];
			}else
			{
				[0,format["%1 a mis %2 dans le coma",name _killer, name _unit]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
				[format["[COMA] %1(%2) EST TOMBER DANS LE COMA TUEUR: %3(%4) DISTANCE: %5 ARME: %6",name _unit, getPlayerUID _unit,name _killer, getPlayerUID _killer,(_unit distance _killer),currentWeapon _killer]] remoteExecCall ["A3Log", 2];
			};
		};
	};

};

if(!isNull life_gangQG)then
{
	if(count (life_gangQG getVariable ["gang_war",[]]) != 0)then
	{
		if(!isNil {_killer getVariable "gang_name"})then
		{
			[_killer] call life_fnc_onPlayerKilledGang;
		};
	};
};

if((vehicle _unit) != _unit) then {
	UnAssignVehicle _unit;
	_unit action ["getOut", vehicle _unit];
	_unit setPosATL [(getPosATL _unit select 0) + 3, (getPosATL _unit select 1) + 1, 0];
};

//Set some vars
_unit setVariable ["Revive",true,true];
_unit setVariable ["name",profileName,true]; //Set my name so they can say my name.
_unit setVariable ["restrained",false,true];
_unit setVariable ["restrainedciv",false,true];
_unit setVariable ["Escorting",false,true];
_unit setVariable ["transporting",false,true]; //Why the fuck do I have this? Is it used?
_unit setVariable ["playerSurrender",false];
// _unit setVariable ["steam64id",(getPlayerUID player),true]; //Set the UID.

//Setup our camera view
life_deathCamera  = "CAMERA" camCreate (getPosATL _unit);
showCinemaBorder TRUE;
life_deathCamera cameraEffect ["Internal","Back"];
createDialog "DeathScreen";
life_deathCamera camSetTarget _unit;
life_deathCamera camSetRelPos [0,3.5,4.5];
life_deathCamera camSetFOV .5;
life_deathCamera camSetFocus [50,0];
life_deathCamera camCommit 0;

(findDisplay 7300) displaySetEventHandler ["KeyDown","if((_this select 1) isEqualTo 1) then {true}"]; //Block the ESC menu

//Create a thread for something?
[_unit,_side] spawn {
	private["_RespawnBtn","_Timer"];
	disableSerialization;
	_RespawnBtn = ((findDisplay 7300) displayCtrl 7302);
	_Timer = ((findDisplay 7300) displayCtrl 7301);
	if(SEL(_this,1))then
	{
		life_respawnTimer = time + (floor random [60,140,240]) + 120;
	}else
	{
		life_respawnTimer = time + (floor random [60,140,240]);
	};
	_RespawnBtn ctrlEnable false;
	waitUntil {_Timer ctrlSetText format[localize "STR_Medic_Respawn",[(life_respawnTimer - time),"MM:SS"] call BIS_fnc_secondsToString];
	round(life_respawnTimer - time) <= 0 OR isNull SEL(_this,0)};
	_RespawnBtn ctrlEnable true;
	_Timer ctrlSetText localize "STR_Medic_Respawn_2";
};

[] spawn life_fnc_deathScreen;

//Create a thread to follow with some what precision view of the corpse.
[_unit] spawn {
	private["_unit"];
	_unit = _this select 0;
	waitUntil {if(speed _unit isEqualTo 0) exitWith {true}; life_deathCamera camSetTarget _unit; life_deathCamera camSetRelPos [0,3.5,4.5]; life_deathCamera camCommit 0;};
};

//Make the killer wanted
if(!isNull _killer && {_killer != _unit} && {side _killer != west} && {alive _killer}) then {
	if(vehicle _killer isKindOf "LandVehicle") then {
	
		if(life_HC_isActive) then {
			[getPlayerUID _killer,_killer getVariable ["realname",name _killer],"187V"] remoteExecCall ["HC_fnc_wantedAdd",HC_Life];
		} else {
			[getPlayerUID _killer,_killer getVariable ["realname",name _killer],"187V"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
		};
		
		//Get rid of this if you don't want automatic vehicle license removal.
		if(!local _killer) then {
			// [2] remoteExecCall ["life_fnc_removeLicenses",_killer];
		};
	} else {
	
		if(life_HC_isActive) then {
			[getPlayerUID _killer,_killer getVariable ["realname",name _killer],"187"] remoteExecCall ["HC_fnc_wantedAdd",HC_Life];
		} else {
			[getPlayerUID _killer,_killer getVariable ["realname",name _killer],"187"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
		};

		if(!local _killer) then {
			// [3] remoteExecCall ["life_fnc_removeLicenses",_killer];
		};
	};
};

life_save_gear = [player] call life_fnc_fetchDeadGear;
//Killed by cop stuff...
if(side _killer isEqualTo west && playerSide != west) then {
	life_copRecieve = _killer;
	//Did I rob the federal reserve?
	if(!life_use_atm && {life_KavaCash > 0}) then {
		[format[localize "STR_Cop_RobberDead",[life_KavaCash] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
		life_KavaCash = 0;
	};
};

_handle = [_unit,true] spawn life_fnc_dropItems;
waitUntil {scriptDone _handle};

life_hunger = 100;
life_thirst = 100;
life_carryWeight = 0;
life_KavaCash = 0;


[] call life_fnc_hudUpdate; //Get our HUD updated.

[0] call SOCK_fnc_updatePartial;
if(playerSide isEqualTo civilian)then
{
	[4] call SOCK_fnc_updatePartial;
	[5] call SOCK_fnc_updatePartial;
};
