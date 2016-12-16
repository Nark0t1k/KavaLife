#include "..\..\script_macros.hpp"
/*
	File: fn_impoundAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Impounds the vehicle
*/
private["_vehicle","_type","_time","_price","_vehicleData","_ui","_progress","_pgText","_cP","_filters"];
_vehicle = param [0,ObjNull,[ObjNull]];
_filters = ["Car","Air","Ship"];
if(!((KINDOF_ARRAY(_vehicle,_filters)))) exitWith {};
if(player distance cursorTarget > 10) exitWith {};

_vehicleData = _vehicle getVariable ["vehicle_info_owners",[]];
if(EQUAL((count _vehicleData),0)) exitWith {deleteVehicle _vehicle}; //Bad vehicle.
_vehicleName = FETCH_CONFIG2(getText,"CfgVehicles",(typeOf _vehicle),"displayName");
if(playerSide isEqualTo west)then
{
	[0,"STR_NOTF_BeingImpounded",true,[SEL(SEL(_vehicleData,0),1),_vehicleName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
}else
{
	[0,"STR_NOTF_BeingImpoundedMecano",true,[SEL(SEL(_vehicleData,0),1),_vehicleName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
};
_handle = [localize "STR_NOTF_Impounding",true,10,0.01,0.25,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

if(EQUAL(count crew _vehicle,0)) then {
	if(!(KINDOF_ARRAY(_vehicle,_filters))) exitWith {};
	_type = FETCH_CONFIG2(getText,"CfgVehicles",(typeOf _vehicle),"displayName");
	switch (true) do {
		case (_vehicle isKindOf "Car"): {_price = 1500;};
		case (_vehicle isKindOf "Ship"): {_price = 2500;};
		case (_vehicle isKindOf "Air"): {_price = 5000;};
	};
	if(playerSide isEqualTo independent)then
	{
		_price = _price * 3;
	};
	
	life_garage_store = true;
	
	if(life_HC_isActive) then {
		[_vehicle,true,player] remoteExecCall ["HC_fnc_vehicleStore",HC_Life];
	} else {
		[_vehicle,true,player] remoteExec ["TON_fnc_vehicleStore",RSERV];
	};
	
	waitUntil {!life_garage_store};
	[format[localize "STR_NOTF_Impounded",_type,_price]] call life_fnc_showNotification;
	[0,"STR_NOTF_HasImpounded",true,[profileName,SEL(SEL(_vehicleData,0),1),_vehicleName]] remoteExecCall ["life_fnc_broadcast",west];
	ADD(life_KavaBank,_price);
} else {
	[localize "STR_NOTF_ImpoundingCancelled"] call life_fnc_showNotification;
};
