#include "..\..\script_macros.hpp"
/*
    File: fn_gangDisband.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Prompts the user about disbanding the gang and if the user accepts the gang will be
    disbanded and removed from the database.
*/
private "_action";
if((count (life_gangQG getVariable ["gang_war",[]])) != 0)exitWith {hint localize "STR_GNOTF_CantDisolve";};
_action = [
    localize "STR_GNOTF_DisbandWarn",
    localize "STR_Gang_Disband_Gang",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if (_action) then {
    hint localize "STR_GNOTF_DisbandGangPro";

    if (life_HC_isActive) then {
        [life_gangQG] remoteExec ["HC_fnc_removeGang",HC_Life];
    } else {
        [life_gangQG] remoteExec ["TON_fnc_removeGang",RSERV];
    };

} else {
    hint localize "STR_GNOTF_DisbandGangCanc";
};