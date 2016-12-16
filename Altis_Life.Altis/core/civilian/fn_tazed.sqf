#include "..\..\script_macros.hpp"
/*
	File: fn_tazed.sqf
	Author: Bryan "Tonic" Boardwine
	Editor: Repentz to improve the function

	Description:
	Starts the tazed animation and broadcasts out what it needs to.
*/
private["_unit","_shooter","_curWep","_curMags","_attach"];
_unit = param [0,Objnull,[Objnull]];
_shooter = param [1,Objnull,[Objnull]];
if(isNull _unit OR isNull _shooter) exitWith {player allowDamage true; life_istazed = false;};
if(player getVariable["restrained",false]) exitWith {};
_time = time;
if(_shooter isKindOf "Man" && alive player) then {
	if(!life_istazed) then {
		life_istazed = true;
		[_unit] remoteExecCall ["life_fnc_tazeSound",RCLIENT];
		[[0,7],"STR_NOTF_Tazed",true,[profileName, _shooter getVariable ["realname",name _shooter]]] remoteExecCall ["life_fnc_broadcast",west];
		[format["[TAZED] %1(%2) -CIBLE TAZER: %3(%4) -DISTANCE: %5",_shooter getVariable ["realname",name _shooter], getPlayerUID _shooter,name player,getPlayerUID player, player distance _shooter]] remoteExecCall ["A3Log", 2];
		"DynamicBlur" ppEffectEnable true;
		"DynamicBlur" ppEffectAdjust [20];
		"DynamicBlur" ppEffectCommit 1;
		player allowDamage false;
		if(isNull objectParent player) then {
			for [{_x=1},{_x<=10},{_x=_x+1}] do { call life_fnc_tazeRagdoll; sleep 0.1; if(animationState player == "unconscious") exitWith{}};
		};
		disableUserInput true;
		player setDamage 0;
		waitUntil{animationState player != "unconscious"};
		_anim = if(isNull objectParent player) then {"Incapacitated"} else {"kia_driver_mid01"};
		[player,_anim] remoteExec ["life_client_fnc_animSync",0];
		waitUntil{time - _time >= 15};
		player allowDamage true;
		if(!(player getVariable["Escorting",false])) then {
			detach player;
		};
		"DynamicBlur" ppEffectEnable false;
		life_istazed = false;
		disableUserInput false;
		player playMoveNow "amovppnemstpsraswrfldnon";
    player setFatigue 1; //no running for you
    player setdamage 0.6; //especially no running for you
	};
} else {
	_unit allowDamage true;
	life_istazed = false;
};