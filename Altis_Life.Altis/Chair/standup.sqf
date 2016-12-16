/*
	File: standup.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Stand up from chair
*/

detach player;
[player,""] remoteExec ["life_fnc_animSync",0];
life_sitting = objNull;

_pos = getPosATL player;
_dir = getDir player;
player setPosATL [(_pos select 0) + (0.5 * sin(_dir)), (_pos select 1) + (0.5 * cos(_dir)), _pos select 2];