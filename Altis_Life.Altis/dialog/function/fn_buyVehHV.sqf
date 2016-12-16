#include "..\..\script_macros.hpp"
/*
	File: fn_buyVehHV.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Yeah... Gets the vehicle from the garage.
*/
private ["_mdata", "_vid", "_vehicle", "_price", "_pid"];
disableSerialization;
_type = _this select 0;
if((life_vehGarage >= life_vehGarageMax) && _type) exitWith {closeDialog 0;[format["Tu ne peux avoir que %1 véhicule dans ton garage.",life_vehGarageMax]] call life_fnc_showNotification;};
if(EQUAL(lbCurSel 4202,-1)) exitWith {hint localize "STR_Global_NoSelection"};
_mdata = lbData[4202,(lbCurSel 4202)];
_mdata = (call compile format["%1",_mdata]);

_vid = _mdata select 0;
_vehicle = _mdata select 1;
_price = _mdata select 3;
_pid = _mdata select 6;
if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};

if(!(EQUAL(typeName _price,typeName 0)) OR _price < 1) then {_price = 1000};
if((life_KavaBank < _price) && _type) exitWith {hint format[(localize "STR_Garage_CashError"),[_price] call life_fnc_numberText];};

if(life_HC_isActive) then {
	[_pid,_vid,player,_type] remoteExecCall ["HC_fnc_buyVehicleHV",HC_Life];
} else {
	[_pid,_vid,player,_type] remoteExec ["TON_fnc_buyVehicleHV",RSERV];
};

life_vehGarage = life_vehGarage + 1;
[format["ACHAT VEHICLE HV %1(%2) -VEH: %3 -PRIX:%4 -SELLER: %5",name player, getPlayerUID player,_vehicle,_price,_pid]] remoteExecCall ["A3Log", 2];
closeDialog 0;
