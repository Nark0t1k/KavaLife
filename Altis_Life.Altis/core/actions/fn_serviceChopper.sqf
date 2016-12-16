#include "..\..\script_macros.hpp"
/*
	File: fn_serviceChopper.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Main functionality for the chopper service paid, to be replaced in later version.
*/
private ["_serviceCost"];
disableSerialization;
private["_search","_ui","_progress","_cP","_pgText"];
if(life_action_inUse) exitWith {[localize "STR_NOTF_Action"] call life_fnc_showNotification;};

_serviceCost = 5000;
_search = nearestObjects[getPos player, ["Air"],15];

if(EQUAL(count _search,0)) exitWith {[localize "STR_Service_Chopper_NoAir"] call life_fnc_showNotification;};
if(life_KavaCash < _serviceCost) exitWith {[format [localize "STR_Serive_Chopper_NotEnough",_serviceCost]] call life_fnc_showNotification;};

_handle = [localize "STR_Service_Chopper_Servicing",true,5,0.01,0.3,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;};

if(!alive SEL(_search,0) || SEL(_search,0) distance (getPos player) > 15) exitWith {[localize "STR_Service_Chopper_Missing"] call life_fnc_showNotification;};

SUB(life_KavaCash,_serviceCost);
if(!local SEL(_search,0)) then {
	[SEL(_search,0),1] remoteExecCall ["life_fnc_setFuel",SEL(_search,0)];
} else {
	SEL(_search,0) setFuel 1;
};

SEL(_search,0) setDamage 0;
[] call life_fnc_hudUpdate;
titleText [localize "STR_Service_Chopper_Done","PLAIN"];
