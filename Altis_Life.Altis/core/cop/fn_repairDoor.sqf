#include "..\..\script_macros.hpp"
/*
	File: fn_repairDoor.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Re-locks the door mainly for the federal reserve structures.
*/
private["_building","_doors","_door","_cP","_cpRate","_ui","_title","_titleText"];
_building = param [0,ObjNull,[ObjNull]];
if(isNull _building) exitWith {};
if(!(_building isKindOf "House_F")) exitWith {hint parseText "You are not looking at a house door."};

_doors = 1;
_doors = FETCH_CONFIG2(getNumber,"CfgVehicles",typeOf _building,"NumberOfDoors");

_door = 0;
//Find the nearest door
for "_i" from 1 to _doors do {
	_selPos = _building selectionPosition format["Door_%1_trigger",_i];
	_worldSpace = _building modelToWorld _selPos;
		if(player distance _worldSpace < 5) exitWith {_door = _i;};
};

if(EQUAL(_door,0)) exitWith {hint localize "STR_Cop_NotaDoor"}; //Not near a door to be broken into.
_doorN = _building getVariable [format["bis_disabled_Door_%1",_door],0];
if(EQUAL(_doorN,1)) exitWith {hint localize "STR_House_FedDoor_Locked"};
life_action_inUse = true;

closeDialog 0;

switch (typeOf _building) do {
	case "Land_Dome_Big_F": {_cpRate = 0.008;};
	case "Land_Research_house_V1_F": {_cpRate = 0.005;};
	default {_cpRate = 0.08;}
};

_handle = [localize "STR_Cop_RepairingDoor",false,5,_cpRate,0.26,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

_building animate [format["door_%1_rot",_door],0];
_building setVariable [format["bis_disabled_Door_%1",_door],1,true]; //Unlock the door.
