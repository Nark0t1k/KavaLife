#include "..\..\script_macros.hpp"
/*
	File: fn_knockoutAction.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Knocks out the target.
*/
private "_target";
#define SAFETY_ZONES    [["Mark_Safe_Zone_1", 550], ["Mark_Safe_Zone_2", 250], ["Mark_Safe_Zone_3", 100]]
_target = param [0,ObjNull,[ObjNull]];

//Error checks
if(isNull _target) exitWith {};
if(!isPlayer _target) exitWith {};
if(player distance _target > 4) exitWith {};
if (({player distance getMarkerPos (_x select 0) < _x select 1} count SAFETY_ZONES > 0) && playerSide isEqualTo civilian) exitWith
{
	 hint parseText "ATTENTION ZONE SAFE, VOL DE VEHICULE INTERDIT!!!!";
};
[player,"AwopPercMstpSgthWrflDnon_End2"] remoteExecCall ["life_fnc_animSync",RCLIENT];
sleep 0.08;
[_target,name player] remoteExec ["life_fnc_knockedOut",_target];

sleep 3;
