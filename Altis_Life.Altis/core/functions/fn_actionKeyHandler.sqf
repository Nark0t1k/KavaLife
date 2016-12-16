#include "..\..\script_macros.hpp"
/*
    File: fn_actionKeyHandler.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Master action key handler, handles requests for picking up various items and
    interacting with other players (Cops = Cop Menu for unrestrain,escort,stop escort, arrest (if near cop hq), etc).
*/
private ["_curTarget", "_curObject", "_isWater", "_fishconfig", "_fishTypes", "_fish", "_handle", "_containers", "_house", "_container", "_animalTypes"];
_curTarget = cursorTarget;
_curObject = cursorObject;
if (life_action_inUse) exitWith {}; //Action is in use, exit to prevent spamming.
if (life_interrupted) exitWith {life_interrupted = false;};
_isWater = surfaceIsWater (visiblePositionASL player);


//Check if the player is near an ATM.
if ((call life_fnc_nearATM) && {!dialog}) exitWith {
	[] call life_fnc_atmMenu;
};
if(typeName life_WhiteList isEqualTo typeName []) exitWith
{
	if((player distance whitelistGather) < 10)then
	{
		if(playerSide isEqualTo civilian && !life_action_inUse) then {
			if(life_action_inUse) exitWith {}; //Action is in use, exit to prevent spamming.
			life_action_inUse = true;
			_handle = [] spawn life_fnc_gather;
			waitUntil {scriptDone _handle};
			life_action_inUse = false;
		};
	};	
};

if ((call life_fnc_nearOBJ) && {!dialog}) exitWith {
	createDialog "life_pickup_items";
};
if(isNull _curTarget) exitWith {
	if(_isWater) then {
		_fishconfig = LIFE_SETTINGS(getArray,"animaltypes_fish");
		_fishTypes = [position player, _fishconfig, 3] call life_fnc_nearestObjects;
		if(count _fishTypes > 0) then {
			_fish = _fishTypes select 0;
			if ((typeOf _fish) isEqualTo "Turtle_F" && !alive _fish) then {
				[_fish] call life_fnc_catchFish;
			} else {
				if (!((typeOf _fish) isEqualTo "Turtle_F")) then {
					[_fish] call life_fnc_catchFish;
				};
			};
		};
	} else {
		if(playerSide isEqualTo civilian && !life_action_inUse) then {
			if(life_action_inUse) exitWith {}; //Action is in use, exit to prevent spamming.
			life_action_inUse = true;
			_handle = [] spawn life_fnc_gather;
			waitUntil {scriptDone _handle};
			life_action_inUse = false;
		};
	};
};
_containers = [getPosATL player, ["Box_IND_Grenades_F","B_supplyCrate_F","Land_Sink_F","CargoNet_01_barrels_F","Land_OfficeCabinet_01_F","Fridge_01_closed_F"], 2.5] call life_fnc_nearestObjects;
if (count _containers > 0) exitWith {
	_house = nearestBuilding (getPosATL player);
	if(!(_house in life_vehicles) && (_house getVariable ["locked",true])) exitWith {
		hint localize "STR_House_ContainerDeny";
		true;
	};
	_container = _containers select 0;
	[_container] call life_fnc_containerMenu;
};

// if((_curTarget isKindOf "B_supplyCrate_F" OR _curTarget isKindOf "Box_IND_Grenades_F" OR _curTarget isKindOf "Land_Sink_F") && {player distance _curTarget < 3} ) exitWith {
	// if(alive _curTarget) then {
		// [_curTarget] call life_fnc_containerMenu;
	// };
// };
if(playerSide != independent && _curTarget isKindOf "House_F" && {player distance _curTarget < 12} OR ((nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"]) isEqualTo _curTarget OR (nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"]) isEqualTo _curTarget)) exitWith {
	[_curTarget] call life_fnc_houseMenu;
};

if (dialog) exitWith {}; //Don't bother when a dialog is open.
if (vehicle player != player) exitWith {}; //He's in a vehicle, cancel!
life_action_inUse = true;
//Temp fail safe.
[] spawn {
    sleep 30;
    life_action_inUse = false;
};


//Check if it's a dead body.
if(_curTarget isKindOf "Man" && {!alive _curTarget} && !(_curTarget getVariable["Revive",false]) && {playerSide isEqualTo independent}) exitWith {
	//Hotfix code by ins0
	if((playerSide isEqualTo independent) && {"Medikit" in (items player)} && ((FETCH_CONST(life_medicLevel)) in [0,1])) then {
		[_curTarget] call life_fnc_revivePlayer;
	};
};

//If target is a player then check if we can use the cop menu.
if(isPlayer _curTarget && _curTarget isKindOf "Man") then {
	if(!dialog && playerSide isEqualTo west) exitWith {
		[_curTarget,(_curTarget getVariable ["restrained",false])] call life_fnc_copInteractionMenu;
	};
	if(!dialog && playerSide isEqualTo civilian) exitWith {
		[_curTarget,(_curTarget getVariable ["restrainedciv",false])] call life_fnc_civInteractionMenu;
	};
	if(!dialog && ((FETCH_CONST(life_medicLevel)) in [0,1])) then {
		[_curTarget] call life_fnc_medicInteractionMenu;
	}else
	{
		[_curTarget,(_curTarget getVariable ["restrainedciv",false])] call life_fnc_civInteractionMenu;
	};
} else {
    //OK, it wasn't a player so what is it?
    private["_isVehicle","_miscItems","_money","_list"];
	_list = ["landVehicle","Ship","Air"];
    _isVehicle = if (KINDOF_ARRAY(_curObject,_list)) then {true} else {false};
	//It's a vehicle! open the vehicle interaction key!
	if(_isVehicle) then {
		if(!dialog) then {
			if(player distance _curTarget < SEL(SEL(boundingBox _curTarget,1),0)+2) then {
				[_curTarget] call life_fnc_vInteractionMenu;
			};
		};
	};
};