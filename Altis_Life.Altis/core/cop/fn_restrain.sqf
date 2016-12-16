#include "..\..\script_macros.hpp"
/*
	File: fn_restrain.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Retrains the client.
*/
private["_cop","_player","_vehicle"];
_cop = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;
_player = player;
_vehicle = vehicle player;
if(isNull _cop) exitWith {};

titleText[format[localize "STR_Cop_Retrained",_cop getVariable ["realname",name _cop]],"PLAIN"];

life_disable_getIn = true;
life_disable_getOut = false;

while {player getVariable  "restrained"} do {
	if(vehicle player isEqualTo player) then {
		player playMove "AmovPercMstpSnonWnonDnon_Ease";
	};

	_state = vehicle player;
	waitUntil {animationState player != "AmovPercMstpSnonWnonDnon_Ease" || !(player getVariable "restrained") || vehicle player != _state};

	if(!alive player) exitWith {
		player setVariable ["restrained",false,true];
		player setVariable ["Escorting",false,true];
		player setVariable ["transporting",false,true];
		detach _player;
	};

	if(!alive _cop) then {
		player setVariable ["Escorting",false,true];
		detach player;
	};

	if(vehicle player != player && life_disable_getIn) then {
		player action["eject",vehicle player];
	};

	if((vehicle player != player) && (vehicle player != _vehicle)) then {
		_vehicle = vehicle player;
	};

	if(vehicle player isEqualTo player && life_disable_getOut) then {
		player moveInCargo _vehicle;
	};

	if((vehicle player != player) && life_disable_getOut && (driver (vehicle player) isEqualTo player)) then {
		player action["eject",vehicle player];
		player moveInCargo _vehicle;
	};
};

//disableUserInput false;

if(alive player) then {
	player switchMove "AmovPercMstpSlowWrflDnon_SaluteIn";
	player setVariable ["Escorting",false,true];
	player setVariable ["transporting",false,true];
	detach player;
};
