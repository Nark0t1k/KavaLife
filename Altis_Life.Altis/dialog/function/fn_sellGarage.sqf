#include "..\..\script_macros.hpp"
/*
	File: fn_sellGarage.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Sells a vehicle from the garage.
*/
private["_vehicle","_vehicleLife","_vid","_pid","_unit","_sellPrice","_multiplicator"];
disableSerialization;
if(EQUAL(lbCurSel 2802,-1)) exitWith {hint localize "STR_Global_NoSelection"};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) select 0;
_vehicleLife = _vehicle;
_vid = lbValue[2802,(lbCurSel 2802)];
_pid = getPlayerUID player;
_unit = player;

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};
if((time - life_action_delay) < 1.5) exitWith {hint localize "STR_NOTF_ActionDelay";};
if(!isClass (missionConfigFile >> "LifeCfgVehicles" >> _vehicleLife)) then {
	_vehicleLife = "Default"; //Use Default class if it doesn't exist
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_vehicle];
};

_sellPrice = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_vehicleLife,"rentalprice"),3)};
};
_multiplicator = LIFE_SETTINGS(getNumber,"vehicleGarage_SellMultiplicator");
_sellPrice = _multiplicator * _sellPrice;

if(life_isImpound)then
{
	_price = round(_price / 2);
};

if(!(EQUAL(typeName _sellPrice,typeName 0)) OR _sellPrice < 1) then {_sellPrice = 1000};

if(life_HC_isActive) then {
	[_vid,_pid,_sellPrice,player,life_garage_type] remoteExecCall ["HC_fnc_vehicleDelete",HC_Life];
} else {
	[_vid,_pid,_sellPrice,player,life_garage_type] remoteExecCall ["TON_fnc_vehicleDelete",RSERV];
};

hint format[localize "STR_Garage_SoldCar",[_sellPrice] call life_fnc_numberText];
ADD(life_KavaBank,_sellPrice);
life_vehGarage = life_vehGarage - 1;
[format["[VENTEVEHGARAGE] %1(%2) -VEHICULE: %3 -PRIX: %4 -BANK AVANT: %5 -BANK APRES: %6",name player, getPlayerUID player, _vehicle, [_sellPrice] call life_fnc_numberText, [life_KavaBank+_sellPrice] call life_fnc_numberText, [life_KavaBank] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
life_action_delay = time;
closeDialog 0;
