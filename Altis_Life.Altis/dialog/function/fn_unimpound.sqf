#include "..\..\script_macros.hpp"
/*
	File: fn_unimpound.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Yeah... Gets the vehicle from the garage.
*/
private["_mday","_mdata","_vehicle","_vehicleLife","_vid","_pid","_unit","_price","_multiplicator","_spawntext"];
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
_multiplicator = LIFE_SETTINGS(getNumber,"vehicleGarage_StorFeeMultiplicator");
_price = _multiplicator * _price;
if(life_isImpound)then
{
	_mday = switch (SEL(_mdata,3)) do
	{
		case 5: {1};
		case 4: {2};
		case 3: {2};
		case 2: {3};
		case 1: {3};
		case 0: {4};
	};
	_price = _price * _mday;
};

if(!(EQUAL(typeName _price,typeName 0)) OR _price < 1) then {_price = 1000};
if(life_KavaBank < _price) exitWith {hint format[(localize "STR_Garage_CashError"),[_price] call life_fnc_numberText];};
if(EQUAL(typeName life_garage_sp,typeName [])) then {
	if(life_HC_isActive) then {
		[life_isImpound,_vid,_pid,SEL(life_garage_sp,0),_unit,_price,SEL(life_garage_sp,1),_spawntext] remoteExecCall ["HC_fnc_spawnVehicle",HC_Life];
	} else {
		[life_isImpound,_vid,_pid,SEL(life_garage_sp,0),_unit,_price,SEL(life_garage_sp,1),_spawntext] remoteExec ["TON_fnc_spawnVehicle",RSERV];
	};
	
} else {
	if(life_garage_sp in ["medic_spawn_1","medic_spawn_3"]) then {
		if(life_HC_isActive) then {
			[life_isImpound,_vid,_pid,life_garage_sp,_unit,_price,0,_spawntext] remoteExecCall ["HC_fnc_spawnVehicle",HC_Life];
		} else {
			[life_isImpound,_vid,_pid,life_garage_sp,_unit,_price,0,_spawntext] remoteExec ["TON_fnc_spawnVehicle",RSERV];
		};
		
	} else {
		if(life_HC_isActive) then {
			[life_isImpound,_vid,_pid,(getMarkerPos life_garage_sp),_unit,_price,markerDir life_garage_sp,_spawntext] remoteExecCall ["HC_fnc_spawnVehicle",HC_Life];
		} else {
			[life_isImpound,_vid,_pid,(getMarkerPos life_garage_sp),_unit,_price,markerDir life_garage_sp,_spawntext] remoteExec ["TON_fnc_spawnVehicle",RSERV];
		};
	};
};
[format["SORTIEGARAGE %1(%2) -VEH: %3 -PRIX:%4",name player, getPlayerUID player,_vehicleLife,_price]] remoteExecCall ["A3Log", 2];
hint localize "STR_Garage_SpawningVeh";
SUB(life_KavaBank,_price);
closeDialog 0;
