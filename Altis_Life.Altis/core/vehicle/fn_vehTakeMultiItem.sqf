#include "..\..\script_macros.hpp"
#define ctrlSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])
/*
	File: fn_vehTakeMultiItem.sqf
	Author: Bryan "Tonic" Boardwine
	Modifier: Nark0t1k
*/
private["_ctrl","_num","_index","_data","_old","_value","_weight","_diff"];
disableSerialization;
if(life_is_processing)exitWith {closeDialog 0;hint "Tu ne peux pas utiliser de vehicule pendant un traitement";};
if(isNull life_trunk_vehicle OR !alive life_trunk_vehicle) exitWith {hint localize "STR_MISC_VehDoesntExist"};
if(!alive player) exitwith {closeDialog 0;};
if((lbCurSel 3502) isEqualTo -1) exitWith {hint localize "STR_Global_NoSelection";};
if((time - life_action_delay) < 1) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;
if((life_trunk_vehicle getVariable ["trunk_id",0]) != (getPlayerUID player)) exitWith {hint localize "STR_MISC_VehInvUse";};
_ctrl = ctrlSelData(3502);
_type = _this select 0;
_num = _this select 1;
if(_num >= 1000) exitWith {};
_index = [_ctrl,((life_trunk_vehicle getVariable "Trunk") select 0)] call TON_fnc_index;
_data = (life_trunk_vehicle getVariable "Trunk") select 0;
_old = life_trunk_vehicle getVariable "Trunk";
if(_index isEqualTo -1) exitWith {};
_value = _data select _index select 1;
if(_type)then
{
	_num = ctrlText 3505;
	_num = parseNumber _num;
}else
{
	if(_num isEqualTo 0) then
	{
		_num = _value;
	};
};

if(_num > _value) exitWith {hint localize "STR_MISC_NotEnough"};
_num = [_ctrl,_num,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_num isEqualTo 0) exitWith {hint localize "STR_NOTF_InvFull"};
_weight = ([_ctrl] call life_fnc_itemWeight) * _num;

if([true,_ctrl,_num] call life_fnc_handleInv) then
{
	if(_num isEqualTo _value) then
	{
		_data set[_index,-1];
		_data = _data - [-1];
	}
		else
	{
		_data set[_index,[_ctrl,(_value - _num)]];
	};
	[format["[TAKE.ITEM.VEH] %1(%2) a retirer %3 %4 dans un vehicule %5",name player, getPlayerUID player,_num,_ctrl,life_trunk_vehicle]] remoteExecCall ["A3Log", 2];
	life_trunk_vehicle setVariable["Trunk",[_data,(_old select 1) - _weight],true];
	[life_trunk_vehicle] call life_fnc_vehInventory;
}
	else
{
	hint localize "STR_NOTF_InvFull";
};
