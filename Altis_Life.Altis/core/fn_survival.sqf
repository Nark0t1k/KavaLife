#include "..\script_macros.hpp"
/*
	File: fn_survival.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	All survival? things merged into one thread.
*/
private ["_fnc_food", "_fnc_water", "_fnc_toxic", "_foodTime", "_waterTime", "_uniformTime", "_toxicTime", "_areaGTime", "_walkDis", "_bp", "_lastPos", "_lastState", "_showMess", "_curPos"];

_fnc_food =  {
	if(!life_is_alive) exitWith {};
	if(life_hunger < 2) then {player setdamage 1; hint localize "STR_NOTF_EatMSG_Death";[format["[COMA.INFO] %1(%2) -TOMBE DANS LE COMA A CAUSE DE LA NOURRITURE",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];}
	else
	{
		SUB(life_hunger,10);
		[] call life_fnc_hudUpdate;
		if(life_hunger < 2) then {player setdamage 1; hint localize "STR_NOTF_EatMSG_Death";[format["[COMA.INFO] %1(%2) -TOMBE DANS LE COMA A CAUSE DE LA NOURRITURE",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];};
		switch(life_hunger) do {
			case 30: {[localize "STR_NOTF_EatMSG_1"] call life_fnc_showNotification;};
			case 20: {[localize "STR_NOTF_EatMSG_2"] call life_fnc_showNotification;};
			case 10: {
				[localize "STR_NOTF_EatMSG_3"] call life_fnc_showNotification;
				player setFatigue 1;
			};
		};
	};
};
	
_fnc_water = {
	if(!life_is_alive) exitWith {};
	if(life_thirst < 2) then {player setdamage 1; hint localize "STR_NOTF_DrinkMSG_Death";[format["[COMA.INFO] %1(%2) -TOMBE DANS LE COMA A CAUSE DE L EAU",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];}
	else
	{
		SUB(life_thirst,10);
		[] call life_fnc_hudUpdate;
		if(life_thirst < 2) then {player setdamage 1; hint localize "STR_NOTF_DrinkMSG_Death";[format["[COMA.INFO] %1(%2) -TOMBE DANS LE COMA A CAUSE DE L EAU",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];};
		switch(life_thirst) do  {
			case 30: {[localize "STR_NOTF_DrinkMSG_1"] call life_fnc_showNotification;};
			case 20: {
				[localize "STR_NOTF_DrinkMSG_2"] call life_fnc_showNotification;
				player setFatigue 1;
			};
			case 10: {
				[localize "STR_NOTF_DrinkMSG_3"] call life_fnc_showNotification;
				player setFatigue 1;
			};
		};
	};
};
	
_fnc_toxic = {
	if(!life_is_alive) exitWith {};
	if(life_toxicArea) exitWith {};
	if(uniform player isEqualTo "U_C_Scientist") exitWith {};
	if((player distance (getMarkerPos "fred_reserve")) > 325) exitWith {};
	[] spawn life_fnc_toxicArea;
};

//Setup the time-based variables.
_foodTime = time;
_waterTime = time;
_uniformTime = time;
_toxicTime = time;
_areaGTime = time;
_walkDis = 0;
_bp = "";
_lastPos = getPos player;
_lastPos = (SEL(_lastPos,0)) + (SEL(_lastPos,1));
_lastState = vehicle player;
_showMess = true;

while {true} do {
	if((time - _toxicTime) > 60) then {[] call _fnc_toxic; _toxicTime = time;};
	if((time - _uniformTime) > 180) then {[] call life_fnc_messenger; [] call life_fnc_playerSkins; _uniformTime = time;};
	if((time - _waterTime) > 600) then {[] call _fnc_water; _waterTime = time;};
	if((time - _foodTime) > 850) then {[] call _fnc_food; _foodTime = time;};
	if(playerSide isEqualTo civilian)then
	{
		if((time - _areaGTime) > 900) then {[] call life_fnc_areaGangWinWin; _areaGTime = time;};
	};
	
	
	/* Adjustment of carrying capacity based on backpack changes */
	if(EQUAL(backpack player,"")) then {
		life_maxWeight = LIFE_SETTINGS(getNumber,"total_maxWeight");
		_bp = backpack player;
	} else {
		if(!(EQUAL(backpack player,"")) && {!(EQUAL(backpack player,_bp))}) then {
			_bp = backpack player;
			life_maxWeight = LIFE_SETTINGS(getNumber,"total_maxWeight") + round(FETCH_CONFIG2(getNumber,"CfgVehicles",_bp,"maximumload") / 5);
		};
	};
	
	/* Check if the player's state changed? */
	if(vehicle player != _lastState OR {!alive player}) then {
		[] call life_fnc_updateViewDistance;
		_lastState = vehicle player;
	};
	
	/* Check if the weight has changed and the player is carrying to much */
	if(life_carryWeight > life_maxWeight && {!isForcedWalk player}) then {
		player forceWalk true;
		player setFatigue 1;
		hint localize "STR_NOTF_MaxWeight";
	} else {
		if(isForcedWalk player) then {
			player forceWalk false;
		};
	};
	
	/* Travelling distance to decrease thirst/hunger which is captured every second so the distance is actually greater then 650 */
	if(!alive player) then {_walkDis = 0;} else {
		_curPos = getPos player;
		_curPos = (SEL(_curPos,0)) + (SEL(_curPos,1));
		if(!(EQUAL(_curPos,_lastPos)) && {(vehicle player isEqualTo player)}) then {
			ADD(_walkDis,1);
			if(EQUAL(_walkDis,650)) then {
				_walkDis = 0;
				SUB(life_thirst,5);
				SUB(life_hunger,5);
				[] call life_fnc_hudUpdate;
			};
		};
		_lastPos = getPos player;
		_lastPos = (SEL(_lastPos,0)) + (SEL(_lastPos,1));
	};
	uiSleep 1;
};
	
	
	
