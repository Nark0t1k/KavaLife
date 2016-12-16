#include "..\..\script_macros.hpp"
/*
	File: fn_scalpel.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Main functionality for lock-picking.
*/
#define SAFETY_ZONES    [["Mark_Safe_Zone_1", 550], ["Mark_Safe_Zone_2", 250], ["Mark_Safe_Zone_3", 100]]
private["_curTarget","_distance","_isVehicle","_isParaDrop","_title","_progressBar","_cP","_titleText","_sLock","_alarm","_dice","_badDistance"];
_curTarget = cursorTarget;
life_interrupted = false;
if (({player distance getMarkerPos (_x select 0) < _x select 1} count SAFETY_ZONES > 0) && playerSide isEqualTo civilian) exitWith
{
	 hint parseText "ATTENTION ZONE SAFE, VOL D ORGANE INTERDIT!!!!";
};
if(life_action_inUse) exitWith {};
if(isNull _curTarget) exitWith {}; //Bad type
_distance = ((boundingBox _curTarget select 1) select 0) + 2;
if(player distance _curTarget > _distance) exitWith {}; //Too far
if(!isPlayer _curTarget) exitWith {};
if(!(_curTarget getVariable ["organ",false])) exitWith {hint "La personne a deja perdu un organe..";};


_handle = [localize "STR_ISTR_Scalpel_Process",false,5,0.01,0.46,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

[true,"organ",1] call life_fnc_handleInv;
_curTarget setVariable ["organ",false,true];
titleText[localize "STR_ISTR_Scalpel_Success","PLAIN"];
