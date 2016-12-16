#include "..\..\script_macros.hpp"
/*
	File: fn_alarmCop.sqf

*/
private["_building"];
_building = param [0,ObjNull,[ObjNull]];

if(playerSide != west)exitWith {};
if(isNull _building) exitWith {};

_marker = createMarkerLocal [format["%1_houseBreak",_building],getPosWorld _building];
_marker setMarkerColorLocal "ColorBLUFOR";
_marker setMarkerTypeLocal "Mil_dot";
_marker setMarkerTextLocal "Cambriolage en cours!!!";

sleep 180;

deleteMarkerLocal _marker;

