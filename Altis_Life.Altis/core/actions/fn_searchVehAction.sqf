#include "..\..\script_macros.hpp"
/*
	File: fn_searchVehAction.sqf
	Author: 
	
	Description:
	
*/
private["_vehicle","_data","_insure"];
_vehicle = cursorTarget;
if((_vehicle isKindOf "Car") || !(_vehicle isKindOf "Air") || !(_vehicle isKindOf "Ship")) then {
	_owners = _vehicle getVariable "vehicle_info_owners";
	if(isNil {_owners}) exitWith {[localize "STR_NOTF_VehCheat"] call life_fnc_showNotification; deleteVehicle _vehicle;};
	
	[localize "STR_NOTF_Searching"] call life_fnc_showNotification;
	sleep 3;
	
	if(player distance _vehicle > 10 || !alive player || !alive _vehicle) exitWith {[localize "STR_NOTF_SearchVehFail"] call life_fnc_showNotification;};
	//_inventory = [(_vehicle getVariable "vehicle_info_inv")] call fnc_veh_inv;
	//if(isNil {_inventory}) then {_inventory = "Nothing in storage."};
	_owners = [_owners] call life_fnc_vehicleOwners;
	_insure = if(((_vehicle getVariable ["dbInfo",[]]) select 2) isEqualTo 0)then{"Non"}else{"Oui"};
	
	if(_owners isEqualTo "any<br/>") then {
		_owners = "No owners, impound it<br/>";
	};
	hint parseText format[localize "STR_NOTF_SearchVeh",_owners,_insure];
};
