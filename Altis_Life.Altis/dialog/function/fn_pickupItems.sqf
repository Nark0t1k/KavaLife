#include "..\..\script_macros.hpp"
/*
	File: fn_pickupItems.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Dialog code for picking up items.
*/
private["_objects","_items","_list","_lastItems","_itemName","_itemInfo","_inUse","_picture"];
disableSerialization;

if (isNull (findDisplay 1520) || life_action_inUse) exitWith {};

life_action_inUse = true;

_list = ((findDisplay 1520) displayCtrl 1521);
_lastItems = [];

while {!isNull (findDisplay 1520)} do
{
	_items = [];
	_objects = nearestObjects [player, [], 4];
	{
		if (count (_x getVariable ["item",[]]) > 0) then { _items pushBack _x; };
	} forEach _objects;
	life_pickup_item_array = _items;
	if (!([_lastItems, _items] call BIS_fnc_areEqual)) then
	{
		ctrlEnable [1522, (count _items > 0)];
		lbClear _list;
		{
			_itemInfo = _x getVariable ["item", ["Unknown",0]];
			_inUse = _x getVariable ["inUse", false];
			if(!_inUse) then{
				if (_itemInfo select 0 isEqualTo "money") then { _list lbAdd format["$%1 Argent Cash", [_itemInfo select 1] call life_fnc_numberText]; }
				else { _list lbAdd format["%1x %2", _itemInfo select 1, (localize ITEM_NAME(_itemInfo select 0))]; };
			};
		} foreach _items;
		if (count _items < 1) then { _list lbAdd "Il n'y a pas d'objet à ramasser à proximité."; };
		_list lbSetSelected [0, true];
	};
	_lastItems = _items;
	sleep 0.5;
};

life_action_inUse = false;