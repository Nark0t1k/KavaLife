#include "..\..\script_macros.hpp"
/*
    File: fn_gangCreated.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Tells the player that the gang is created and throws him into it.
*/
private ["_group","_type","_position","_marker"];
_type = _this select 0;
life_action_gangInUse = nil;
if(_type isEqualTo 0)exitWith 
{
	["Il existe deja un gang avec ce nom."] call life_fnc_showNotification;
};
if(_type isEqualTo 1)exitWith 
{
	["Tu es deja dans un gang tu dois quitter celui-ci pour en creer un."] call life_fnc_showNotification;
};

if (life_KavaBank < (LIFE_SETTINGS(getNumber,"gang_price"))) exitWith {
    hint format[localize "STR_GNOTF_NotEnoughMoney",[((LIFE_SETTINGS(getNumber,"gang_price"))-life_KavaBank)] call life_fnc_numberText];
};

life_KavaBank = life_KavaBank - LIFE_SETTINGS(getNumber,"gang_price");

life_gangQG = _this select 1;
player setVariable["gang_qg",_this select 1,true];
player setVariable["gang_name",_this select 2,true];
life_vehicles pushBack life_gangQG;

_random = round(random 10000);
(group player) setVariable ["gangNbr",_random,true];
life_fullGangList = [[getPlayerUID player,name player]];

_position = getPos life_gangQG;
_marker = createMarkerLocal ["gangQG",_position];
_marker setMarkerTextLocal "QG Gang";
_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerTypeLocal "loc_Lighthouse";

hint format[localize "STR_GNOTF_CreateSuccess",player getVariable "gang_name",[(LIFE_SETTINGS(getNumber,"gang_price"))] call life_fnc_numberText];