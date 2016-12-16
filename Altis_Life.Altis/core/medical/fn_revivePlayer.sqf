#include "..\..\script_macros.hpp"
/*
	File: fn_revivePlayer.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Starts the revive process on the player.
*/
private["_target","_revivable","_targetName","_ui","_progressBar","_titleText","_cP"];
_target = param [0,ObjNull,[ObjNull]];
if(isNull _target) exitWith {};
_revivable = _target getVariable ["Revive",FALSE];
if(_revivable) exitWith {};
if(_target getVariable ["Reviving",ObjNull] isEqualTo player) exitWith {hint localize "STR_Medic_AlreadyReviving";};
if(player distance _target > 5) exitWith {}; //Not close enough.

//Fetch their name so we can shout it.
_targetName = _target getVariable ["name","Unknown"];
life_action_inUse = true; //Lockout the controls.

_target setVariable ["Reviving",player,TRUE];

_handle = [format[localize "STR_Medic_Progress",_targetName],false,5,.01,.15,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

if(_target getVariable ["Reviving",ObjNull] != player) exitWith {hint localize "STR_Medic_AlreadyReviving"};
if(_target getVariable ["Revive",FALSE]) exitWith {hint localize "STR_Medic_RevivedRespawned"};
_target setVariable ["Reviving",NIL,TRUE];

ADD(life_KavaBank,5000);

_target setVariable ["Revive",TRUE,TRUE];
[profileName] remoteExecCall ["life_fnc_revived",_target];
titleText[format[localize "STR_Medic_RevivePayReceive",_targetName,[5000] call life_fnc_numberText],"PLAIN"];

sleep .6;
player reveal _target;
