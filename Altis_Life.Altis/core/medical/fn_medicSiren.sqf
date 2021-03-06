#include "..\..\script_macros.hpp"
/*
	File: fn_medicSiren.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the medic siren sound for other players
*/
if(!hasInterface && !isDedicated)exitWith {};
private["_vehicle"];
_vehicle = param [0,ObjNull,[ObjNull]];

if(isNull _vehicle) exitWith {};
if(isNil {_vehicle getVariable "siren"}) exitWith {};

while {true} do {
	if(!(_vehicle getVariable "siren")) exitWith {};
	if(EQUAL(count crew _vehicle,0)) then {_vehicle setVariable ["siren",false,true]};
	if(!alive _vehicle) exitWith {};
	if(isNull _vehicle) exitWith {};
	_vehicle say3D "medicSiren";//Class/name specified in description.ext
	sleep 4.275;//Exactly matches the length of the audio file.
	if(!(_vehicle getVariable "siren")) exitWith {};
};