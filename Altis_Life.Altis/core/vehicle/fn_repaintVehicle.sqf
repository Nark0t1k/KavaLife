#include "..\..\script_macros.hpp"
/*
	fn_repaintVehicle.sqf
*/
private ["_vehicle", "_index", "_className", "_colorIndex"];
if(isNull (findDisplay 2300)) exitWith {};

_index = lbValue[2302,lbCurSel 2302];
_vehicle = (nearestObjects[getPos player,["Car","Air","Ship"],6]) select _index;
_className = typeOf _vehicle; 

_colorIndex = lbValue[2303,(lbCurSel 2303)];

if(!(_vehicle in life_vehicles))exitWith {hint "Ce n est pas votre vehicule";};
if(life_KavaCash < 20000) exitWith {hintSilent "You don't have enough cash!";};
if(player != vehicle player) exitWith {titleText["You must exit the vehicle to paint it!","PLAIN"];};
closeDialog 0;
	
life_KavaCash = life_KavaCash - 20000;

[_vehicle,_colorIndex] call life_fnc_colorVehicle;
if(life_HC_isActive) then {
	[_vehicle,3] remoteExecCall ["HC_fnc_vehicleUpdate",HC_Life];
} else {
	[_vehicle,3] remoteExecCall ["TON_fnc_vehicleUpdate",2];
};
		
[0] call SOCK_fnc_updatePartial;
	