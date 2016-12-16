#include "..\..\script_macros.hpp"
/*
	fn_gangFilter.sqf
*/
private ["_ownerID", "_data", "_online"];

disableSerialization;
_ownerID = group player getVariable ["gang_owner",""];
if (_ownerID isEqualTo "") exitWith {closeDialog 0;}; //Bad juju

if (_ownerID != getPlayerUID player) exitWith {};
_online = false;
_data = CONTROL_DATA(2621);
_data = call compile format["%1", _data];

{
	if((getPlayerUID _x) isEqualTo _data)exitWith {_online = true;};
}forEach playableUnits;
(CONTROL(2620,2625)) ctrlEnable _online; //Set New Leader

// (CONTROL(2620,2622)) ctrlEnable false; //Upgrade
// (CONTROL(2620,2624)) ctrlEnable false; // Kick
// (CONTROL(2620,2630)) ctrlEnable false; //Invite Player
// (CONTROL(2620,2631)) ctrlEnable false; //Disband Gang
