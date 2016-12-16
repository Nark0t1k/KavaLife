#include "..\..\script_macros.hpp"
/*
	File: fn_repairTruck.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Main functionality for toolkits, to be revised in later version.
*/
private["_veh","_upp","_ui","_progress","_pgText","_cP","_displayName","_test","_nbrPart","_part","_repairLevel","_sleep"];
_veh = _this select 0;
life_interrupted = false;
if(isNull _veh) exitwith {};
if(!(_veh isKindOf "Car") && !(_veh isKindOf "Ship") && !(_veh isKindOf "Air")) exitWith {hint "Tu ne peux pas reparer cela";};


if(!("ToolKit" in (items player))) exitWith {[localize "STR_Need_repairKit"] call life_fnc_showNotification;};

_sleep = switch (life_skillRepair)do
{
	case 0:{0.5};
	case 1:{0.4};
	case 2:{0.3};
	case 3:{0.25};
	case 4:{0.2};
	case 5:{0.15};
	default {0.5};
};
if((FETCH_CONST(life_medicLevel)) isEqualTo 2)then
{
	_sleep = 0.2;
};
_displayName = FETCH_CONFIG2(getText,"CfgVehicles",(typeOf _veh),"displayName");
_handle = [format[localize "STR_NOTF_Repairing",_displayName,life_skillRepair],false,5,0.01,_sleep,"Acts_carFixingWheel"] spawn life_fnc_handleProgressBar;
waitUntil {sleep 0.2;scriptDone _handle};
player switchMove "";
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 
if(!("ToolKit" in (items player)))exitWith {[localize "STR_Need_repairKit"] call life_fnc_showNotification;};
if(life_interrupted) exitWith {life_interrupted = false; [localize "STR_NOTF_ActionCancel"] call life_fnc_showNotification;};
if(player != vehicle player) exitWith {[localize "STR_NOTF_ActionInVehicle"] call life_fnc_showNotification;};
if((FETCH_CONST(life_medicLevel)) != 2)then
{
	player removeItem "ToolKit";
};
_veh setDamage 0;
["repair",1] call life_fnc_skillsUpdate;
[localize "STR_NOTF_RepairedVehicle"] call life_fnc_showNotification;
