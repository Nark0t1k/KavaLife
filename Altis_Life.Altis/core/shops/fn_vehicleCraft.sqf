#include "..\..\script_macros.hpp"
/*
	File: fn_vehiclecraft.sqf
	Author: Bryan "Tonic" Boardwine
	
*/
private["_color","_vehicleType","_gFund","_mode","_spawnPoints","_action","_shop","_className","_basePrice","_multiplicator","_colorIndex","_spawnPoint","_vehicle","_shopSide","_licenses","_licensesName","_exit"];
if(life_vehGarage >= life_vehGarageMax) exitWith {titleText[format["Tu ne peux avoir que %1 véhicule dans ton garage.",life_vehGarageMax],"PLAIN"];};

_vehicleType = _this select 0;
_color = 0;
_vehicle = createVehicle [_vehicleType, (getMarkerPos "craft_ifrit_spawn"), [], 0, "NONE"];
waitUntil {!isNil "_vehicle" && {!isNull _vehicle}}; //Wait?
_vehicle allowDamage false; //Temp disable damage handling..
_vehicle setPos (getMarkerPos "craft_ifrit_spawn");
_vehicle setVectorUp (surfaceNormal (getMarkerPos "craft_ifrit_spawn"));
_vehicle setDir (markerDir "craft_ifrit_spawn");

_vehicle lock 2;
if(_vehicleType isEqualTo "O_MRAP_02_F")then
{
	_color = 1;
	[_vehicle,1] call life_fnc_colorVehicle;
};
[_vehicle] call life_fnc_clearVehicleAmmo;
[_vehicle,"trunk_in_use",false,true] remoteExecCall ["TON_fnc_setObjVar",RSERV];
[_vehicle,"vehicle_info_owners",[[getPlayerUID player,profileName]],true] remoteExecCall ["TON_fnc_setObjVar",RSERV];
_vehicle disableTIEquipment true; //No Thermals.. They're cheap but addictive.
_vehicle allowDamage true;

life_vehicles pushBack _vehicle;

[getPlayerUID player,playerSide,_vehicle,1] remoteExecCall ["TON_fnc_keyManagement",RSERV];

if(life_HC_isActive) then {
	[player,playerSide,_vehicle,_color] remoteExecCall ["HC_fnc_vehicleCreate",HC_Life];
} else {
	[player,playerSide,_vehicle,_color] remoteExecCall ["TON_fnc_vehicleCreate",RSERV];
};

[6] call SOCK_fnc_updatePartial;
[] call life_fnc_hudUpdate;
closeDialog 0; //Exit the menu.
true;


