/*
	File: fn_searchAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the searching process.
*/
params [
	["_unit",objNull,[objNull]]
];
if(isNull _unit) exitWith {};
[localize "STR_NOTF_Searching"] call life_fnc_showNotification;
sleep 2;
if(player distance _unit > 5 || !alive player || !alive _unit) exitWith {[localize "STR_NOTF_CannotSearchPerson"] call life_fnc_showNotification;};
[player] remoteExec ["life_fnc_searchClient",_unit];