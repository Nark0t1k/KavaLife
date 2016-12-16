/*
    File: fn_nearOBJ.sqf
*/
private ["_objList","_return"];
_return = false;
_objList = nearestObjects [player, ["Land_BottlePlastic_V1_F","Land_TacticalBacon_F","Land_Can_V3_F","Land_CanisterFuel_F", "Land_Can_V3_F","Land_Money_F","Land_Suitcase_F","Land_Screwdriver_V1_F"], 3];

if(count _objList isEqualTo 0)exitWith {_return;};
{
	if(count (_x getVariable ["item",[]]) > 0)exitWith{_return = true;};
}forEach _objList;
_return;