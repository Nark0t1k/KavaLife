/*
	File: sitdown.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Sit in a chair!
*/

private ["_chair","_dir","_data"];

_chair = cursorObject; 
if(!([str cursorObject,"bench"] call KRON_StrInStr || [str cursorObject,"chair"] call KRON_StrInStr))exitWith {};
if (!isNull life_sitting) exitWith {[localize "STR_Chair_already"] call life_fnc_showNotification;};
if (vehicle player != player) exitWith {[localize "STR_Chair_alreadyVeh"] call life_fnc_showNotification;};
if (player distance _chair > 4) exitWith {[localize "STR_Chair_notreach"] call life_fnc_showNotification;};
if (player getVariable ["restrained",false]) exitWith {};
if (player getVariable ["restrainedciv",false]) exitWith {};
if (!isNull (_chair getVariable ["sitting", objNull])) exitWith {[localize "STR_Chair_somebody"] call life_fnc_showNotification;};

[player,"Crew"] remoteExec ["life_fnc_animSync",0];
_chairPos = (getPosATL _chair);
player setPosATL (getPosATL _chair); 
player setDir ((getDir _chair) - 180); 
_action = player addAction ["<t color='#0099FF'>Se lever</t>",life_fnc_standup];
life_sitting = _chair;
_chair setVariable ["sitting", player, true];

waitUntil { isNull life_sitting || !(alive player) || player distance (getPos _chair) > 2 };
player removeAction _action;
_chair setVariable ["sitting", nil, true];
