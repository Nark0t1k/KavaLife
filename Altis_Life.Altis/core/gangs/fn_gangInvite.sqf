#include "..\..\script_macros.hpp"
/*
    File: fn_gangInvite.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Prompts the player about an invite.
*/
private ["_action","_grpMembers","_name","_unit","_members","_position","_marker"];
params [
    ["_unit",ObjNull,[ObjNull]],
    ["_gangQG",ObjNull,[ObjNull]]
];
_name = _unit getVariable["realname", name _unit];
if (_name isEqualTo "" || isNull _gangQG) exitWith {}; //Fail horn anyone?
if (!isNil {player getVariable "gang_name"}) exitWith {hint localize "STR_GNOTF_AlreadyInGang";};

_gangName = _gangQG getVariable "gang_name";
_action = [
    format[localize "STR_GNOTF_InviteMSG",_name,_gangName],
    localize "STR_Gang_Invitation",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if (_action) then {
    // [player] join _group;
	life_gangQG = _gangQG;
	player setVariable ["gang_name",_gangName];
	[] call life_fnc_updateMyGroup;
    if (life_HC_isActive) then {
        [5,_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life];
    } else {
        [5,_gangQG] remoteExecCall ["TON_fnc_updateGang",RSERV];
    };
	_members = life_gangQG getVariable "gang_members";
	{
		if(!isNil {_x getVariable "gang_name"})then
		{
			if((_x getVariable "gang_name") isEqualTo _gangName)then
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
	_position = getPos life_gangQG;
	_marker = createMarkerLocal ["gangQG",_position];
	_marker setMarkerTextLocal "QG Gang";
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerTypeLocal "loc_Lighthouse";
} else {
    _grpMembers = _gangQG getVariable "gang_members";
    _grpMembers = _grpMembers - [getPlayerUID player];
    _gangQG setVariable ["gang_members",_grpMembers,true];

    if (life_HC_isActive) then {
        [5,_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life];
    } else {
        [5,_gangQG] remoteExecCall ["TON_fnc_updateGang",RSERV];
    };

};
