#include "..\..\script_macros.hpp"
/*
    File: fn_inventoryOpened.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    For the mean time it blocks the player from opening another persons backpack
*/
private["_container","_unit","_list","_exit"];
if (count _this isEqualTo 1) exitWith {false};
_unit = _this select 0;
_container = _this select 1;
_exit = false;
if(_container in [copStorageBox1,copStorageBox2,copTempCont1,copTempCont2])then
{
	if(playerSide != west) exitWith {_exit = true;};
	if((player getVariable ["rank",0] < 6) && (_container in [copStorageBox1,copStorageBox2,copTempCont2]))exitWith {_exit = true;};
	if(_container getVariable ["trunk_in_use",false]) exitWith {_exit = true;};
	_container setVariable ["trunk_in_use",true,true];
};
if(_exit) exitWith {hint "Vous ne pouvez pas ouvrir se coffre";true;};
_isPack = FETCH_CONFIG2(getNumber,"CfgVehicles",typeOf _container,"isBackpack");
if (_isPack isEqualTo 1) exitWith {
    hint localize "STR_MISC_Backpack";
    true;
};

if ((typeOf _container) in ["Box_IND_Grenades_F","B_supplyCrate_F","Land_Sink_F","CargoNet_01_barrels_F","Land_OfficeCabinet_01_F","Fridge_01_closed_F"]) exitWith {
    _house = nearestObject [player, "House"];
    if (!(_house in life_vehicles) && (_house getVariable ["locked",true])) exitWith {
        hint localize "STR_House_ContainerDeny";
        true;
    };
};

if ((typeOf _container) in ["Box_IND_Support_F"]) exitWith {
    _exit = (_container getVariable ["locked",false]);
    if (_exit) then {
        hint localize "STR_PARA_Locked";
        true;
    };
};

_list = ["LandVehicle","Ship","Air"];
if (KINDOF_ARRAY(_container,_list)) exitWith {
    if (!(_container in life_vehicles) && (_container getVariable ["locked",true])) exitWith {
        hint localize "STR_MISC_VehInventory";
        true;
    };
};

//Allow alive players who've been knocked out to be looted, just not the dead ones
if (_container isKindOf "Man" && !alive _container) exitWith {
    hint localize "STR_NOTF_NoLootingPerson";
    true;
};
