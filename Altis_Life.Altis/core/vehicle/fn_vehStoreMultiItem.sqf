#include "..\..\script_macros.hpp"
#define ctrlSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])
/*
	File: fn_vehStoreMultiItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Used in the vehicle trunk menu, stores the selected item and puts it in the vehicles virtual inventory
	if the vehicle has room for the item.
*/
private["_ctrl","_num","_free","_totalWeight","_itemWeight","_fullItemWeight","_veh_data","_inv","_index","_val","_type"];
disableSerialization;
if(life_is_processing)exitWith {closeDialog 0;hint "Tu ne peux pas utiliser de vehicule pendant un traitement";};
_ctrl = ctrlSelData(3503);
_type = _this select 0;
_num = _this select 1;
// if(!([_num] call TON_fnc_isnumber)) exitWith {hint parseText "Invalid Number format";};
if(_type)then
{
	_num = ctrlText 3506;
	_num = parseNumber _num;
}else
{
	if(_num isEqualTo 0) then
	{
		_num = ITEM_VALUE(_ctrl);
	};
};

if((time - life_action_delay) < 1) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;
if((life_trunk_vehicle getVariable ["trunk_id",0]) != (getPlayerUID player)) exitWith {hint localize "STR_MISC_VehInvUse";};
if(life_trunk_vehicle isKindOf "House_F") then {
	_mWeight = 0;
	{_mWeight = _mWeight + ([(typeOf _x)] call life_fnc_vehicleWeightCfg);true;} count (life_trunk_vehicle getVariable["containers",[]]);
	_totalWeight = [_mWeight,(life_trunk_vehicle getVariable["Trunk",[[],0]]) select 1];
} else {
	_totalWeight = [life_trunk_vehicle] call life_fnc_vehicleWeight;
};
_itemWeight = [_ctrl] call life_fnc_itemWeight;
_fullItemWeight = ([_ctrl] call life_fnc_itemWeight) * _num;
_veh_data = life_trunk_vehicle getVariable ["Trunk",[[],0]];
_inv = _veh_data select 0;
if(_ctrl isEqualTo "goldBar" && {!(life_trunk_vehicle isKindOf "LandVehicle" OR life_trunk_vehicle isKindOf "House_F")}) exitWith {hint parseText "You cannot store that in anything but a land vehicle!"};

if(((_totalWeight select 1) + _fullItemWeight) > (_totalWeight select 0)) then 
{
	_free = (_totalWeight select 0) - (_totalWeight select 1);
	_num = floor (_free/_itemWeight);
	_fullItemWeight = ([_ctrl] call life_fnc_itemWeight) * _num;
};
if(((_totalWeight select 1) + _fullItemWeight) > (_totalWeight select 0)) exitWith {hint parseText "Le véhicule est plein et ne peux pas contenir plus."};

if(!([false,_ctrl,_num] call life_fnc_handleInv)) exitWith {hint parseText "Il n'y a plus de place dans le véhicule.";};
_index = [_ctrl,_inv] call TON_fnc_index;
if(_index isEqualTo -1) then
{
	_inv pushBack [_ctrl,_num];
}
	else
{
	_val = _inv select _index select 1;
	_inv set[_index,[_ctrl,_val + _num]];
};
[format["[STORE.ITEM.VEH] %1(%2) a deposer %3 %4 dans un vehicule %5",name player, getPlayerUID player,_num,_ctrl,life_trunk_vehicle]] remoteExecCall ["A3Log", 2];
life_trunk_vehicle setVariable["Trunk",[_inv,(_veh_data select 1) + _fullItemWeight],true];
[life_trunk_vehicle] call life_fnc_vehInventory;

