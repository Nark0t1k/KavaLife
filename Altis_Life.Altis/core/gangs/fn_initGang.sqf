#include "..\..\script_macros.hpp"
/*
    File: fn_initGang.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Main initialization for gangs?
*/
private ["_wait", "_QGGang", "_exit", "_groupName", "_random", "_position", "_marker"];
if (playerSide != civilian) exitWith {}; //What in the hell?
[player] join (createGroup civilian);
if (count life_gangData isEqualTo 0) exitWith {}; //Dafuq?

_wait = round(random(5));
sleep _wait;

//Loop through to make sure there is not a group already created with the gang.
_QGGang = call compile format["%1",life_gangData select 6];
_QGGang = nearestObject [_QGGang, "House"];
_exit = false;
{
	if(side _x isEqualTo civilian)then
	{
		_groupName = _x getVariable "gang_name";
		if (!isNil "_groupName") then {
			if ((life_gangData select 2) isEqualTo _groupName) then {
				if(_QGGang getVariable ["gang_qgAct",false])then {_group = group _x;_exit=true;};
			};
		};
	};
	if(_exit)exitWith {};
} forEach playableUnits;

life_gangQG = _QGGang;
life_vehicles pushBack _QGGang;
player setVariable ["gang_name",(life_gangData select 2),true];
player setVariable["gang_qg",_QGGang,true];

if (!isNil "_group") then {
    [player] join _group;
    if ((life_gangData select 1) isEqualTo getPlayerUID player) then {
        _group selectLeader player;
        [player,_group] remoteExecCall ["TON_fnc_clientGangLeader",(units _group)];
    };
} else {
    _group = group player;
    _QGGang setVariable ["gang_qgAct",true,true];
	_random = round(random 10000);
	_group setVariable ["gangNbr",_random,true];
	life_gangQG setVariable ["gangNbr",_random,true];
};

_position = getPos life_gangQG;
_marker = createMarkerLocal ["gangQG",_position];
_marker setMarkerTextLocal "QG Gang";
_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerTypeLocal "loc_Lighthouse";
