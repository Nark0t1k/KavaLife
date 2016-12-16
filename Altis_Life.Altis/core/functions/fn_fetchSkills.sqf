#include "..\..\script_macros.hpp"
/*
    File: fn_fetchSkills.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Used in returning information about a vehicle from Config >> "CfgVehicles"

*/
private["_gather","_process","_repair","_lock"];
_gather = [_this,0,[0,0],[[]]] call BIS_fnc_param;
_process = [_this,1,[0,0],[[]]] call BIS_fnc_param;
_repair = [_this,2,[0,0],[[]]] call BIS_fnc_param;
_lock = [_this,3,[0,0],[[]]] call BIS_fnc_param;


life_skillGather = _gather select 0;
life_skillGatherCount = _gather select 1;

life_skillProcess = _process select 0;
life_skillProcessCount = _process select 1;

life_skillRepair = _repair select 0;
life_skillRepairCount = _repair select 1;

life_skillLock = _lock select 0;
life_skillLockCount = _lock select 1;