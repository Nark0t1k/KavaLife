/*
	File: fn_playSound.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Plays a sound, allowing for MP.
*/
if(!hasInterface && !isDedicated)exitWith {};
private["_source","_sound","_distance"];
_source = _this select 0;
_sound = _this select 1;
_distance = _this select 2;

if (player distance _source > _distance) exitWith {};

_source say3D _sound;