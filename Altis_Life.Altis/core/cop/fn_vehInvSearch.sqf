#include "..\..\script_macros.hpp"
/*
	File: fn_vehInvSearch.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Searches the vehicle for illegal items.
*/
private["_vehicle","_vehicleInfo","_value","_list"];
_vehicle = cursorTarget;
_list = ["Air","Ship","LandVehicle"];
if(isNull _vehicle OR {!(KINDOF_ARRAY(_vehicle,_list))}) exitWith {};

_vehicleInfo = _vehicle getVariable ["Trunk",[]];
if(EQUAL(count _vehicleInfo,0)) exitWith {[localize "STR_Cop_VehEmpty"] call life_fnc_showNotification;};

_value = 0;
_illegalValue = 0;
{
	_var = SEL(_x,0);
	_val = SEL(_x,1);
	_isIllegalItem = M_CONFIG(getNumber,"VirtualItems",_var,"illegal");
	if(_isIllegalItem isEqualTo 1 ) then{
		_illegalPrice = M_CONFIG(getNumber,"VirtualItems",_var,"sellPrice");
		if(!isNull (missionConfigFile >> "VirtualItems" >> _var >> "processedItem")) then {
			_illegalItemProcessed = M_CONFIG(getText,"VirtualItems",_var,"processedItem");
			_illegalPrice = M_CONFIG(getNumber,"VirtualItems",_illegalItemProcessed,"sellPrice");
		};

		_illegalValue = _illegalValue + (round(_val * _illegalPrice / 2));
	};
} foreach (SEL(_vehicleInfo,0));
_value = _illegalValue;
if(_value > 0) then {
	[7,"STR_NOTF_VehContraband",true,[[_value] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	ADD(life_KavaBank,_value);
	_vehicle setVariable ["Trunk",[[],0],true];
} else {
	[localize "STR_Cop_NoIllegalVeh"] call life_fnc_showNotification;
};