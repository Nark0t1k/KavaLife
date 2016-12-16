#include "..\..\script_macros.hpp"
/*
	fn_adminSleep.sqf
	by Nark0t1k
	Make them troll sleep a lot
*/

private ["_target"];
_target = [];

{if((alive _x) && (side _x isEqualTo civilian) && (isPlayer _x) && (player distance _x < 100))then{_target pushBack _x;};}forEach playableUnits;

if(count _target isEqualTo 0) exitWith {};

{
	[] remoteExec ["life_fnc_adminSleepPlayer",_x];
}foreach _target;