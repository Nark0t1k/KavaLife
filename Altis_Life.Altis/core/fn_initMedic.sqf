#include "..\script_macros.hpp"
/*
	File: fn_initMedic.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Initializes the medic..
*/
private["_end"];
player addRating 99999999;
waitUntil {!(isNull (findDisplay 46))};

if(life_blacklisted) exitWith {
	["Blacklisted",false,true] call BIS_fnc_endMission;
	sleep 30;
};
player setVariable["rankIndep",(FETCH_CONST(life_medicLevel)),true];

// Allow Medic WhiteList Only
if((str(player) in ["medic_3","medic_4","medic_5","medic_6","medic_7","medic_8","medic_9","medic_10"])) then {
	if((FETCH_CONST(life_mediclevel) != 1) && ((call life_adminlevel) in [0,1,2])) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

// Allow Mecano WhiteList Only
if((str(player) in ["mecano_1","mecano_2","mecano_3","mecano_4","mecano_5"])) then {
	if((FETCH_CONST(life_mediclevel) != 2) && ((call life_adminlevel) in [0,1,2])) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

// Allow Mercenaire WhiteList Only
if((str(player) in ["merce_1","merce_2","merce_3","merce_4","merce_5","merce_6","merce_7","merce_8","merce_9","merce_10","merce_11","merce_12","merce_13","merce_14","merce_15"])) then {
	if((FETCH_CONST(life_mediclevel) != 3) && ((call life_adminlevel) in [0,1,2])) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

// Allow Concessionnaire WhiteList Only
if((str(player) in ["conces_1","conces_2","conces_3"])) then {
	if((FETCH_CONST(life_mediclevel) != 4) && ((call life_adminlevel) in [0,1,2])) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

// Allow FreeSlot Medic With WhiteList Medic Online
if((str(player) in ["medic_1","medic_2"])) then {
	if({_x getVariable ["rankIndep",0] isEqualTo 1} count playableUnits < 1)  then {
		["NotOffPolice",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
	if((FETCH_CONST(life_mediclevel) > 1) && ((call life_adminlevel) in [0,1,2])) then {
		["NotOffPolice",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

[] call life_fnc_spawnMenu;
[] spawn life_fnc_placeablesInit;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
