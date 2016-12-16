/*
	File: sitdown.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Sit in a chair!
*/

private ["_chair","_unit","_dir","_z"];

_chair = _this select 0; 
_unit = _this select 1;

if (!isNull life_sitting) exitWith {hint parseText localize "STR_Chair_already";};
if (vehicle _unit != _unit) exitWith {hint parseText localize "STR_Chair_alreadyVeh";};
if (_unit distance _chair > 4) exitWith {hint parseText localize "STR_Chair_notreach";};
if (_unit getVariable ["restrained",false]) exitWith {};
if (_unit getVariable ["restrainedciv",false]) exitWith {};
if (!isNull (_chair getVariable ["sitting", objNull])) exitWith {hint parseText localize "STR_Chair_somebody";};

[player,"Crew"] remoteExec ["life_fnc_animSync",0];
_chairPos = (getPosATL _chair);
_unit setPosATL (getPosATL _chair); 
_unit setDir ((getDir _chair) - 180); 
_action = _unit addAction ["<t color='#0099FF'>Se lever</t>","Chair\standup.sqf"];
life_sitting = _chair;
_chair setVariable ["sitting", _unit, true];

waitUntil { isNull life_sitting || !(alive _unit) || player distance (getPos _chair) > 2 };
_unit removeAction _action;
_chair setVariable ["sitting", nil, true];
