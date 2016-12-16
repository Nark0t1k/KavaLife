#include "..\..\script_macros.hpp"
/*
	File: fn_gather.sqf
	Author: Devilfloh

	Description:
	Main functionality for gathering.
*/
private["_maxGather","_resource","_amount","_maxGather","_requiredItem","_total","_itemName","_rdmAction"];
if((vehicle player) != player) exitWith {};
if((player getVariable "restrained")) exitWith {[localize "STR_NOTF_isrestrained"] call life_fnc_showNotification;};
if((player getVariable "restrainedciv")) exitWith {[localize "STR_NOTF_isrestrained"] call life_fnc_showNotification;};
if((player getVariable "playerSurrender")) exitWith {[localize "STR_NOTF_surrender"] call life_fnc_showNotification;};
_total = 0;
_zone = "";
_requiredItem = "";
_zoneSize = (getNumber(missionConfigFile >> "CfgGather" >> "zoneSize"));
_exit = false;

_resourceCfg = missionConfigFile >> "CfgGather" >> "Resources";
for[{_i = 0},{_i < count(_resourceCfg)},{_i = _i + 1}] do {

	_curConfig = (_resourceCfg select _i);
	_resource = configName _curConfig;
	_maxGather = getNumber(_curConfig >> "amount");
	_resourceZones = getArray(_curConfig >> "zones");
	_requiredItem = getText(_curConfig >> "item");

	{
		if((player distance (getMarkerPos _x)) < _zoneSize) exitWith {_zone = _x;};
		if((_x isEqualTo "whiteList_marker") && ((player distance whitelistGather) < 10)) exitWith {_zone = _x;};
	} foreach _resourceZones;
	if(_zone != "") exitWith {};
};

if(_zone isEqualTo "") exitWith {};
if((time - life_action_delay) < 5) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;
life_interrupted = false;
if (_requiredItem != "") then
{
	_valItem = GVAR_MNS "life_inv_" + _requiredItem;

	if (_valItem < 1) exitWith
	{
		switch (_requiredItem) do
		{
			case "pickaxe": {titleText[(localize "STR_NOTF_Pickaxe"),"PLAIN"];};
		};
		_exit = true;
	};
};
if((_zone isEqualTo "fred_reserve") && !(EQUAL(uniform player,"U_C_Scientist"))) exitWith {hint parseText "Tu dois avoir une tenue de protection pour récolter."};
if(_exit) exitWith {};

_itemName = M_CONFIG(getText,"VirtualItems",_resource,"displayName");

_maxGather = _maxGather + life_skillGather;
_rdmAction = round(random 10000);
life_currentAction = _rdmAction;


while {true}do
{
	_amount = round(random(_maxGather)) + 1;
	_diff = [_resource,_amount,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
	if(_diff isEqualTo 0) exitWith {
		[localize "STR_NOTF_InvFull"] call life_fnc_showNotification;
		life_interrupted = true;
	};
	if(life_interrupted) exitWith {};
	switch (_requiredItem) do
	{
		case "pickaxe": {player say3D "mining";};
		default {player say3D "harvest";};
	};
	
	for "_i" from 0 to 4 do
	{
		player playMoveNow "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
		waitUntil{animationState player != "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
		sleep 0.5;
		if(vehicle player != player) exitWith {};
		if(speed player > 1) exitWith {};
		if(life_interrupted) exitWith {};
	};
	if(life_interrupted) exitWith {};
	if(vehicle player != player) exitWith {};
	if(speed player > 1) exitWith {};
	if(life_currentAction != _rdmAction)exitWith{};
	if(([true,_resource,_diff] call life_fnc_handleInv)) then
	{
		titleText[format[localize "STR_NOTF_Gather_Success",(localize _itemName),_diff],"PLAIN"];
		_total = _total + _diff;
	};
	
	sleep 1;
};
if(life_interrupted && _total != 0) then {
	[[7],"STR_NOTF_GatherTotal_Success",true,[(localize _itemName),[_total] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",player];
	if(!(_resource in ["apple","peach","pdt","dechet"]))then{["gather",_total] call life_fnc_skillsUpdate;};
	[format["[RECOLTE] %1(%2) a recolte %3 %4",name player, getPlayerUID player,_total,_itemName]] remoteExecCall ["A3Log", 2];
};
life_interrupted = false;