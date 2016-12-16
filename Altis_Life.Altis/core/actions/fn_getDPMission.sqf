#include "..\..\script_macros.hpp"
/*
    File: fn_getDPMission.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Selects a random DP point for a delivery mission.
    Needs to be revised.
*/
private["_dp","_target"];
_target = param [0,ObjNull,[ObjNull]];
if (str(_target) in LIFE_SETTINGS(getArray,"delivery_points")) then {
    private "_point";
    _point = LIFE_SETTINGS(getArray,"delivery_points");
    _point deleteAt (_point find (str(_target)));
    _dp = _point call BIS_fnc_selectRandom;
} else {
    _dp = LIFE_SETTINGS(getArray,"delivery_points") call BIS_fnc_selectRandom;
};

life_dp_start = _target;

life_delivery_in_progress = true;
life_dp_point = call compile format["%1",_dp];

_dp = [_dp,"_"," "] call KRON_Replace;
life_cur_task = player createSimpleTask [format["Delivery_%1",life_dp_point]];
life_cur_task setSimpleTaskDescription [format[localize "STR_NOTF_DPStart",toUpper _dp],"Delivery Job",""];
life_cur_task setSimpleTaskDestination (getPosWorld life_dp_point);
life_cur_task setTaskState "Assigned";
player setCurrentTask life_cur_task;

["DeliveryAssigned",[format[localize "STR_NOTF_DPTask",toUpper _dp]]] call bis_fnc_showNotification;
(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw","
	(_this select 0) drawLine [
		getPosWorld player,
		getPosWorld life_dp_point,
		[0,0,1,1]
	];
"];

[] spawn {
	waitUntil {!life_delivery_in_progress OR !alive player};
	(findDisplay 12 displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
	if(!alive player) then {
		life_cur_task setTaskState "Failed";
		player removeSimpleTask life_cur_task;
		["DeliveryFailed",[localize "STR_NOTF_DPFailed"]] call BIS_fnc_showNotification;
		life_delivery_in_progress = false;
		life_dp_point = nil;
	};
};