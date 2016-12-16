/*
    File: fn_gangDisbanded.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Notifies members that the gang has been disbanded.
*/
private "_group";
_group = param [0,objNull,[objNull]];
if (isNull _group) exitWith {}; //Fail horn please.
if(isNull life_gangQG) exitWith {};
if(_group != life_gangQG) exitWith {};

if (!isNull (findDisplay 2620)) then {closeDialog 2620};
life_vehicles = life_vehicles - [life_gangQG];
life_gangQG = objNull;
player setVariable ["gang_name",nil,true];
[] call life_fnc_updateMyGroup;
hint localize "STR_GNOTF_DisbandWarn_2";
