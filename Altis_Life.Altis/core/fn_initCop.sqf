#include "..\script_macros.hpp"
/*
	File: fn_initCop.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Cop Initialization file.
*/
player addRating 9999999;
waitUntil {!(isNull (findDisplay 46))};

if(life_blacklisted) exitWith {
	["Blacklisted",false,true] call BIS_fnc_endMission;
	sleep 30;
};
player setVariable["rank",(FETCH_CONST(life_coplevel)),true];
if(!(str(player) in ["cop_1","cop_2"])) then {
	if((FETCH_CONST(life_coplevel) isEqualTo 0) && ((call life_adminlevel) in [0,1,2])) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};
if((str(player) in ["cop_1","cop_2"])) then {
	if({_x getVariable ["rank",0] > 0} count playableUnits < 1)  then {
		["NotOffPolice",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

switch (FETCH_CONST(life_coplevel)) do
{
	case 1: {life_paycheck = 3000;}; 
	case 2: {life_paycheck = 3500;}; 
	case 3: {life_paycheck = 4000;}; 
	case 4: {life_paycheck = 4500;}; 
	case 5: {life_paycheck = 5000;}; 
	case 6: {life_paycheck = 5500;}; 
	case 7: {life_paycheck = 6000;}; 
	case 8: {life_paycheck = 6500;}; 
	case 9: {life_paycheck = 7000;}; 
};


[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
[] spawn life_fnc_placeablesInit;