#include "..\..\script_macros.hpp"
/*
	File: fn_knockedOut.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Starts and monitors the knocked out state.
*/
private ["_obj","_obj2","_pos"];
params [
	["_target",objNull,[objNull]],
	["_who","",[""]]
];

if(isNull _target) exitWith {};
if(_target != player) exitWith {};
if(EQUAL(_who,"")) exitWith {};
life_carryWeight = 0;
[format[localize "STR_Civ_KnockedOut",_who]] call life_fnc_showNotification;
player playMoveNow "Incapacitated";

_obj = "Land_ClutterCutter_small_F" createVehicle ASLTOATL(visiblePositionASL player);
_obj setPosATL ASLTOATL(visiblePositionASL player);
if("ItemRadio" in (assignedItems player))then
{
	_pos = player modelToWorld[0,3,0];
	_pos = [SEL(_pos,0), SEL(_pos,1), 0];
	_obj2 = "Item_ItemRadio" createVehicle _pos;
	_obj2 setPos _pos;
	player removeweapon "ItemRadio";
};

[player,false] spawn life_fnc_dropItems;
life_isknocked = true;
player attachTo [_obj,[0,0,0]];
sleep 15;
player playMoveNow "amovppnemstpsraswrfldnon";
detach player;
deleteVehicle _obj;
life_isknocked = false;
player setVariable ["robbed",FALSE,TRUE];
