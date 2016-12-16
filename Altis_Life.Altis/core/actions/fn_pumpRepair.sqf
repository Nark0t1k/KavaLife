#include "..\..\script_macros.hpp"
/*
	File: fn_pumpRepair.sqf
	
	Description:
	Quick simple action that is only temp.
*/
private ["_vehicle", "_method"];

if (life_action_inUse) exitwith {};
if(dialog) exitWith {};
if(life_is_processing) exitwith {};
if(vehicle player != player)then
{
	_vehicle = vehicle player;
}else
{
	_vehicle = player nearEntities ["Car", 50];
};
if(isNull _vehicle)exitWith {hint parseText localize "STR_Vehicle_Notin_Notnear";};
if((isEngineOn _vehicle) || ((speed _vehicle) > 5)) exitWith {hint parseText localize "STR_Vehicle_Need_Stop";};
if(life_KavaCash < 2500) then
{
	if(life_KavaBank < 3000) exitWith {_method = 0;};
	if(life_inv_cartevisa isEqualTo 0) exitWith {_method = 1;};
	_method = 3;
}
	else
{
	_method = 2;
};

if(_method > 1)then
{
	_handle = [localize "STR_Vehicle_Repair",true,5,0.01,0.3,""] spawn life_fnc_handleProgressBar;
	waitUntil { sleep 0.2;scriptDone _handle;}; 
	if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;};
	
	if((isEngineOn _vehicle) || ((speed _vehicle) > 5)) exitWith {hint parseText localize "STR_Vehicle_Need_Stop";};
};
if((isEngineOn _vehicle) || ((speed _vehicle) > 5)) exitWith {};
switch (_method) do
{
	case 0: {["Vous n'avez pas 2500€ en cash ou sur votre compte."] call life_fnc_showNotification;};
	case 1: {["Vous n'avez pas 2500€ en cash et vous n'avez pas de carte VISA."] call life_fnc_showNotification;};
	case 2: {_vehicle setDamage 0; SUB(life_KavaCash,2500); ["Vous avez réparez votre véhicule pour 2500€"] call life_fnc_showNotification;};
	case 3: {_vehicle setDamage 0; SUB(life_KavaBank,2500); ["Vous avez réparez votre véhicule pour 2500€"] call life_fnc_showNotification;};
};
[] call life_fnc_hudUpdate;