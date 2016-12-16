#include "..\..\script_macros.hpp"
/*
	File: fn_boltcutter.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Breaks the lock on a single door (Closet door to the player).
*/
private["_building","_door","_doors","_cpRate","_title","_progressBar","_titleText","_cp","_ui"];
_building = param [0,ObjNull,[ObjNull]];
if(((getPlayerUID player) != "76561197975687104") && (player distance [14570,17594,0] < 28)) exitWith {hint parseText "Impossible à utiliser ici.";};
if(isNull _building) exitWith {};
if(!(_building isKindOf "House_F")) exitWith {hint parseText "You are not looking at a house door."};
if(((nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"]) isEqualTo _building OR (nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"]) isEqualTo _building) && ({_x getVariable ["rank",0] > 0} count playableUnits < (LIFE_SETTINGS(getNumber,"cops_online_min")))) exitWith {
	hint format [localize "STR_Civ_NotEnoughCops",(LIFE_SETTINGS(getNumber,"cops_online_min"))]
};
if((typeOf _building) isEqualTo "Land_Research_house_V1_F" && life_fed_break isEqualTo 0) exitWith {hint localize "STR_ISTR_Bolt_Exploit"};
if(isNil "life_boltcutter_uses") then {life_boltcutter_uses = 0;};

if((nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"]) isEqualTo _building OR (nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"]) isEqualTo _building) then {
	[[0,1,2,7],"STR_ISTR_Bolt_AlertFed",true,[]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	[format["[BOLT.BANK] %1(%2) a utiliser une pince anglaise sur une porte de la banque",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];
} else {
	[[0,7],"STR_ISTR_Bolt_AlertHouse",true,[profileName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	if(_building getVariable ["house_alarm",false])then
	{
		[_building] remoteExec ["life_fnc_alarmCop",west];
		{
			if(((getPlayerUID _x) isEqualTo ((_building getVariable "house_owner") select 0)) && (side _x isEqualTo civilian)) exitWith {
				[10,"",name player,player] remoteExec ["life_fnc_receiveMessage",_x];
			};
		} foreach playableUnits;
		[_building] spawn
		{
			_building = _this select 0;
			for "_i" from 0 to 5 do {
				[_building,"houseAlarm",75] remoteExec ["life_fnc_playSound",RCLIENT];
				sleep 1;
			};
		};
	};
	[format["[BOLT.MAISON] %1(%2) a utiliser une pince anglaise sur une porte de maison",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];
};

_doors = FETCH_CONFIG2(getNumber,"CfgVehicles",(typeOf _building), "numberOfDoors");

_door = 0;
//Find the nearest door
for "_i" from 1 to _doors do {
	_selPos = _building selectionPosition format["Door_%1_trigger",_i];
	_worldSpace = _building modelToWorld _selPos;
		if(player distance _worldSpace < 2) exitWith {_door = _i;};
};
if(_door isEqualTo 0) exitWith {hint localize "STR_Cop_NotaDoor"}; //Not near a door to be broken into.
if((_building getVariable [format["bis_disabled_Door_%1",_door],0]) isEqualTo 0) exitWith {hint localize "STR_House_Raid_DoorUnlocked"};

switch (typeOf _building) do {
	case "Land_Dome_Big_F": {_cpRate = 0.003;};
	case "Land_Research_house_V1_F": {_cpRate = 0.0015;};
	default {_cpRate = 0.0008;}
};

_handle = [localize "STR_ISTR_Bolt_Process",false,5,_cpRate,0.26,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

life_boltcutter_uses = life_boltcutter_uses + 1;

if(life_boltcutter_uses >= 5) then {
	[false,"boltcutter",1] call life_fnc_handleInv;
	life_boltcutter_uses = 0;
};

switch (typeOf _building) do {
	case "Land_Dome_Big_F": {if(life_fed_break isEqualTo 0) then {life_fed_break = 1;};};
	case "Land_Research_house_V1_F": {life_fed_break = 2;};
};

_building setVariable [format["bis_disabled_Door_%1",_door],0,true]; //Unlock the door.
if((_building getVariable ["locked",false])) then {
	_building setVariable ["locked",false,true];
};
// [4] call life_fnc_removeLicenses;
if(life_HC_isActive) then {
	[getPlayerUID player,profileName,"459"] remoteExecCall ["HC_fnc_wantedAdd",HC_Life];
} else {
	[getPlayerUID player,profileName,"459"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
};
