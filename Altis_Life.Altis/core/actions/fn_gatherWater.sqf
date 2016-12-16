#include "..\..\script_macros.hpp"
/*
	File: fn_gatherWater.sqf
	Author: Devilfloh

	Description:
	Main functionality for gathering.
*/
private["_maxGather","_resource","_amount","_maxGather","_requiredItem","_total","_itemName"];
if(life_action_inUse) exitWith {};
[] spawn
{
	if((vehicle player) != player) exitWith {};
	_total = 0;
	life_action_inUse = true;
	life_interrupted = false;

	_resource = "fouilleEau";
	_maxGather = 0;
	_requiredItem = "pickaxe";

	if(life_inv_pickaxe isEqualTo 0)exitWith {[localize "STR_NOTF_Pickaxe"] call life_fnc_showNotification;life_action_inUse = false;};

	if(_exit) exitWith {life_action_inUse = false;};
	_itemName = M_CONFIG(getText,"VirtualItems",_resource,"displayName");
	while {true}do
	{
		_amount = round(random(_maxGather)) + 1;
		_diff = [_resource,_amount,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
		if(_diff isEqualTo 0) exitWith {
			[localize "STR_NOTF_InvFull"] call life_fnc_showNotification;
			life_action_inUse = false;
			life_interrupted = true;
		};
		if(life_interrupted) exitWith {};
		switch (_requiredItem) do
		{
			case "pickaxe": {player say3D "mining";};
			default {player say3D "harvest";};
		};
		if(life_interrupted) exitWith {};
		if(([true,_resource,_diff] call life_fnc_handleInv)) then
		{
			titleText[format[localize "STR_NOTF_Gather_Success",(localize _itemName),_diff],"PLAIN"];
			_total = _total + _diff;
		};
		
		sleep 4;
	};
	if(life_interrupted) then {[[7],"STR_NOTF_GatherTotal_Success",true,[(localize _itemName),[_total] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",player];};
	life_action_inUse = false;
	life_interrupted = false;
};