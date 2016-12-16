#include "..\..\script_macros.hpp"
/*
	File: fn_restoreVeh.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Yeah... Gets the vehicle from the garage.
*/
private["_mday","_mdata","_vehicle","_vehicleLife","_vid","_pid","_unit","_price","_spawntext"];
disableSerialization;
if(EQUAL(lbCurSel 2802,-1)) exitWith {hint localize "STR_Global_NoSelection"};
_mdata = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_mdata]) select 0;
_mdata = (call compile format["%1",_mdata]);
_vehicleLife = _vehicle;
_vid = lbValue[2802,(lbCurSel 2802)];
_pid = getPlayerUID player;
_unit = player;
_spawntext = localize "STR_Garage_spawn_Success";
if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};
if(!isClass (missionConfigFile >> "LifeCfgVehicles" >> _vehicleLife)) then {
	_vehicleLife = "Default"; //Use Default class if it doesn't exist
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_vehicle];
};

_price = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),3)};
};
_price = 5 * _price;

if(!(EQUAL(typeName _price,typeName 0)) OR _price < 1) then {_price = 1000};
if(life_KavaBank < _price) exitWith {hint format[(localize "STR_Garage_CashError"),[_price] call life_fnc_numberText];};

if(life_HC_isActive) then {
	[_vid,_pid,_unit] remoteExecCall ["HC_fnc_restoreVehicle",HC_Life];
} else {
	[_vid,_pid,_unit] remoteExec ["TON_fnc_restoreVehicle",RSERV];
};
[format["RESTORE VEH DETRUIT %1(%2) -VEH: %3 -PRIX:%4",name player, getPlayerUID player,_vehicleLife,_price]] remoteExecCall ["A3Log", 2];
hint localize "STR_Garage_RestoreVeh";
SUB(life_KavaBank,_price);
closeDialog 0;
