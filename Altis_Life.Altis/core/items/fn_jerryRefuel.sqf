#include "..\..\script_macros.hpp"
/*
	File: fn_jerryRefuel.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Refuels the vehicle if the player has a fuel can.
*/
private["_vehicle","_displayName","_upp","_ui","_progress","_pgText","_cP","_previousState"];
_vehicle = cursorTarget;
life_interrupted = false;

if(isNull _vehicle) exitWith {hint localize "STR_ISTR_Jerry_NotLooking"};
if(!(_vehicle isKindOF "LandVehicle") && !(_vehicle isKindOf "Air") && !(_vehicle isKindOf "Ship")) exitWith {};
if(player distance _vehicle > 7.5) exitWith {hint localize "STR_ISTR_Jerry_NotNear"};

if(!([false,"fuelFull",1] call life_fnc_handleInv)) exitWith {};



_displayName = FETCH_CONFIG2(getText,"CfgVehicles",(typeOf _vehicle),"displayName");
_handle = [format[localize "STR_ISTR_Jerry_Process",_displayName],false,5,0.01,0.2,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

switch (true) do {
	case (_vehicle isKindOF "LandVehicle"): {
		if(!local _vehicle) then {
			[_vehicle,(Fuel _vehicle) + 0.2] remoteExecCall ["life_fnc_setFuel",_vehicle];
		} else {
			_vehicle setFuel ((Fuel _vehicle) + 0.2);
		};
	};

	case (_vehicle isKindOf "Air"): {
		if(!local _vehicle) then {
			[_vehicle,(Fuel _vehicle) + 0.2] remoteExecCall ["life_fnc_setFuel",_vehicle];
		} else {
			_vehicle setFuel ((Fuel _vehicle) + 0.2);
		};
	};

	case (_vehicle isKindOf "Ship"): {
		if(!local _vehicle) then {
			[_vehicle,(Fuel _vehicle) + 0.25] remoteExecCall ["life_fnc_setFuel",_vehicle];
		} else {
			_vehicle setFuel ((Fuel _vehicle) + 0.25);
		};
	};
};
titleText[format[localize "STR_ISTR_Jerry_Success",_displayName],"PLAIN"];
[true,"fuelEmpty",1] call life_fnc_handleInv;
