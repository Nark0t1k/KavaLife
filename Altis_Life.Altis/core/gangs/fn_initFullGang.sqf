#include "..\..\script_macros.hpp"
/*
    File: fn_initFullGang.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Main initialization for gangs?
*/
private["_exitLoop","_group","_wait"];
if (playerSide != civilian) exitWith {}; //What in the hell?
life_fullGangList = _this select 0;



