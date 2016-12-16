/*
	File: fn_discoGang.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Functionality for leaving the group.
*/
private["_index","_gang","_name","_group","_locked","_owner","_ownerID","_new_owner"];
if(isNull life_gangQG) exitWith {};
if(isNil {player getVariable "gang_name"}) exitWith {};
if(!isNull life_my_group) exitWith {};



if(getPlayerUID player isEqualTo _ownerID) then
{
	if(count (units(group player)) > 1) then
	{
		{
			if(_x != player) exitWith
			{
				_new_owner = _x;
			};
		} foreach (units (group player));
		
		life_group_list set[_index,[_name,_group,_locked,str(_new_owner),(getPlayerUID _new_owner)]];
		publicVariable "life_group_list";
		[_new_owner,_group] remoteExecCall ["life_fnc_clientGroupLeader",_new_owner];
	}
		else
	{
		life_group_list set [_index,-1];
		life_group_list = life_group_list - [-1];
		publicVariable "life_group_list";
	};
};

life_my_group = ObjNull;
if(rank player != "PRIVATE") then
{
	player setRank "PRIVATE";
};
[] call life_fnc_updateMyGroup;
hint "Tu as quitte le groupe.";


closeDialog 0;