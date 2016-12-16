#include "..\..\script_macros.hpp"
/*
	File: fn_removeItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Removes the selected item & amount to remove from the players
	virtual inventory.
*/
private["_data","_value","_obj","_total","_var"];
disableSerialization;
_data = lbData[2005,(lbCurSel 2005)];
_value = ctrlText 2010;
if(life_is_processing)exitWith {hint "Vous ne pouvez pas faire cela pendant un traitement";};
if ((time - life_action_delay) < 3) exitWith{ _exit = true; hint parseText "You can only drop items once per 3 seconds. Try dropping more at a time.";};
if(EQUAL(_data,"")) exitWith {hint parseText "You didn't select anything to remove.";};
if(!([_value] call TON_fnc_isnumber)) exitWith {hint parseText "You didn't enter an actual number format."};
if(parseNumber(_value) <= 0) exitWith {hint parseText "You need to enter an actual amount you want to remove."};
if(EQUAL(ITEM_ILLEGAL(_data),1) && ([west,getPos player,100] call life_fnc_nearUnits)) exitWith {titleText["This is an illegal item and cops are near by, you cannot dispose of the evidence","PLAIN"]};
if(player != vehicle player) exitWith {titleText["You cannot remove an item when you are in a vehicle.","PLAIN"]};
if(!([false,_data,(parseNumber _value)] call life_fnc_handleInv)) exitWith {hint parseText "Couldn't remove that much of that item, maybe you don't have that amount?"};

hint format["You have successfully removed %1 %2 from your inventory.",(parseNumber _value),(localize ITEM_NAME(_data))];

_total = missionNamespace getVariable _data;
_value = parseNumber _value;
if (_value > (missionNameSpace getVariable _data)) then { _value = missionNamespace getVariable _data; };
life_action_delay = time;
_var = ITEM_VARNAME(_data);

_model = switch(_var) do
{
	case "life_inv_water": { "Land_BottlePlastic_V1_F" };
	case "life_inv_lockpick": { "Land_Screwdriver_V1_F" };
	case "life_inv_tbacon": { "Land_TacticalBacon_F" };
	case "life_inv_redgull": { "Land_Can_V3_F" };
	case "life_inv_fuelE": { "Land_CanisterFuel_F" };
	case "life_inv_fuelF": { "Land_CanisterFuel_F" };
	case "life_inv_coffee": { "Land_Can_V3_F" };
	default { "Land_Suitcase_F" };
};

if (_value > 0) then
{
	_pos = player modelToWorld[0,3,0];
	_pos = [SEL(_pos,0), SEL(_pos,1), 0];
	_obj = _model createVehicle _pos;
	_obj setPos _pos;
	_obj setVariable ["item",[_data,_value],true];
	_obj setVariable ["inUse",false,true];
};

	
[] call life_fnc_p_updateMenu;