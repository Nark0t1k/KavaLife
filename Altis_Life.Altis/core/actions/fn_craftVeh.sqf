#include "..\..\script_macros.hpp"
/*
	File: fn_craftVeh.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Master handling for processing an item.
*/
private ["_skillspeed","_sleeper","_luck", "_vendor", "_type", "_itemInfo", "_oldItem", "_newItem", "_cost", "_upp", "_exit", "_ArrayItem", "_ItemName", "_ItemSelected", "_itemNameInv", "_item", "_var", "_ItemNumber", "_itemNumberNow", "_IndexNow", "_ItemNameLife", "_ItemNumberLife", "_hasLicense", "_oldVal", "_ui", "_progress", "_pgText", "_cP", "_ItemMax", "_calcul", "_ItemMin", "_ItemNameHandle", "_ItemNumberHandle"];

_type = [_this,3,"",[""]] call BIS_fnc_param;
if(playerSide != civilian) exitWith {hint "Vous ne pouvez pas utiliser cette usine";};
if(life_vehGarage >= life_vehGarageMax) exitWith {[format["Tu ne peux avoir que %1 véhicule dans ton garage.",life_vehGarageMax]] call life_fnc_showNotification;};


// [CargoNet_01_Box_F,B_Slingload_01_Ammo_F,truckWheel,extra],license,stringable
_craftInfo = switch (_type) do {
	case "offroad": {[[1,1,4,"srifle_GM6_F"],license_civ_offroadarmed,(localize "STR_CRAFT_Veh_Offroad"),"B_G_Offroad_01_armed_F"];};
	case "ifrit": {[[0,2,4],license_civ_ifrit,(localize "STR_CRAFT_Veh_Ifrit"),"O_MRAP_02_F"];};
	case "mohawk": {[[1,2,0],license_civ_mohawk,(localize "STR_CRAFT_Veh_Mohawk"),"I_Heli_Transport_02_F"];};
	case "hemttbox": {[[1,2,0],license_civ_hemttplan,(localize "STR_CRAFT_Veh_HemttBox"),"B_Truck_01_box_F"];};
	case "tempestmineur": {[[2,1,2],license_civ_tempest,(localize "STR_CRAFT_Veh_TempestMineur"),"O_Truck_03_device_F"];};
	case "hayonsport": {[[1,0,4],license_civ_hayonsport,(localize "STR_CRAFT_Veh_HayonSport"),"C_Hatchback_01_sport_F"];};
	default {[];};
};

if(count _craftInfo isEqualTo 0)exitWith {};
if(!(SEL(_craftInfo,1)))exitWith {[localize "STR_needPlanCraft"] call life_fnc_showNotification;};

// Check 1
_nbrCargoNet = count (nearestObjects[getPos player,["CargoNet_01_box_F"],25]);
_nbrSlingload = count (nearestObjects[getPos player,["B_Slingload_01_Ammo_F"],25]);
_nbrTruckwheel = life_inv_truckWheel;

_itemNeed = SEL(_craftInfo,0);

if(SEL(_itemNeed,0) > _nbrCargoNet)exitWith {[format [localize "STR_needPackWheels",SEL(_itemNeed,0)]] call life_fnc_showNotification;};
if(SEL(_itemNeed,1) > _nbrSlingload)exitWith {[format [localize "STR_needPieceMeca",SEL(_itemNeed,1)]] call life_fnc_showNotification;};
if(SEL(_itemNeed,2) > _nbrTruckwheel)exitWith {[format [localize "STR_needWheels",SEL(_itemNeed,2)]] call life_fnc_showNotification;};
_exit = false;
if((count _itemNeed) > 3) then{if((currentWeapon player) != (SEL(_itemNeed,3)))exitWith {_exit = true;};};
if(_exit)exitWith {[localize "STR_needLynx"] call life_fnc_showNotification;};


// Progress Bar
life_is_processing = true;
_handle = [SEL(_craftInfo,2),true,5,0.01,0.15,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;};

// Check 2
_nbrCargoNet = count (nearestObjects[getPos player,["CargoNet_01_box_F"],25]);
_nbrSlingload = count (nearestObjects[getPos player,["B_Slingload_01_Ammo_F"],25]);
_nbrTruckwheel = life_inv_truckWheel;

if(SEL(_itemNeed,0) > _nbrCargoNet)exitWith {[format [localize "STR_needPackWheels",SEL(_itemNeed,0)]] call life_fnc_showNotification;};
if(SEL(_itemNeed,1) > _nbrSlingload)exitWith {[format [localize "STR_needPieceMeca",SEL(_itemNeed,1)]] call life_fnc_showNotification;};
if(SEL(_itemNeed,2) > _nbrTruckwheel)exitWith {[format [localize "STR_needWheels",SEL(_itemNeed,2)]] call life_fnc_showNotification;};
_exit = false;
if((count _itemNeed) > 3) then{if((currentWeapon player) != (SEL(_itemNeed,3)))exitWith {_exit = true;};};
if(_exit)exitWith {[localize "STR_needLynx"] call life_fnc_showNotification;};


if(SEL(_itemNeed,0) != 0)then
{
	for '_i' from 1 to (SEL(_itemNeed,0)) do {
		deleteVehicle ((nearestObjects[getPos player,["CargoNet_01_box_F"],25]) select 0);
		sleep 2;
	};	
};
if(SEL(_itemNeed,1) != 0)then
{
	for '_i' from 1 to (SEL(_itemNeed,1)) do {
		deleteVehicle ((nearestObjects[getPos player,["B_Slingload_01_Ammo_F"],25]) select 0);
		sleep 2;
	};	
};
if(SEL(_itemNeed,2) != 0)then
{
	[false,"truckWheel",SEL(_itemNeed,2)] call life_fnc_handleInv;
};

switch (_type) do {
	case "offroad": {license_civ_offroadarmed = false;};
	case "ifrit": {license_civ_ifrit = false;};
	case "mohawk": {license_civ_mohawk = false;};
	case "hemttbox": {license_civ_hemttplan = false;};
	case "tempestmineur": {license_civ_tempest = false;};
	case "hayonsport": {license_civ_hayonsport = false;};
	default {[];};
};
life_is_processing=false;
[SEL(_craftInfo,3)] remoteExecCall ["life_fnc_vehicleCraft",player];
[localize "STR_craftVehEnd"] call life_fnc_showNotification;

[2] call SOCK_fnc_updatePartial;
[3] call SOCK_fnc_updatePartial;
[4] call SOCK_fnc_updatePartial;

[format["[CRAFT VEH] %1(%2) a crafté un %3",name player, getPlayerUID player,SEL(_craftInfo,3)]] remoteExecCall ["A3Log", 2];