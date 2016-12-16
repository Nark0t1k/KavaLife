#include "..\..\script_macros.hpp"
/*
    File: fn_gangLeave.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    32 hours later...
*/
private["_unitID ","_members","_QG","_QGName"];
if (getPlayerUID player isEqualTo (life_gangQG getVariable "gang_owner")) exitWith {hint localize "STR_GNOTF_LeaderLeave";};

if((count (life_gangQG getVariable ["gang_war",[]])) != 0)exitWith {hint localize "STR_GNOTF_CantLeave";};

_unitID = getPlayerUID player;
_members = life_gangQG getVariable "gang_members";
if (isNil "_members") exitWith {};
if (!(_members isEqualType [])) exitWith {};

_members = _members - [_unitID];
life_gangQG setVariable ["gang_members",_members,true];

[player] remoteExec ["TON_fnc_clientGangLeft",player];
if (life_HC_isActive) then {
    [4,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
} else {
    [4,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
};
_QGName = life_gangQG getVariable ["gang_name",""];
{
	if(!isNil {_x getVariable "gang_name"})then
	{
		if((_x getVariable "gang_name") isEqualTo _QGName)then
		{
			if(life_HC_isActive) then {
				[_x,getPlayerUID _x,_members] remoteExecCall ["HC_fnc_queryPlayerFullGang",HC_Life];
			}else
			{
				[_x,getPlayerUID _x,_members] remoteExec ["TON_fnc_queryPlayerFullGang",RSERV];
			};
		};
	};
} forEach playableUnits;
closeDialog 0;
