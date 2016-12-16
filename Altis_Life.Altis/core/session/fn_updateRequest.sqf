#include "..\..\script_macros.hpp"
/*
	File: fn_updateRequest.sqf
	Author: Tonic

	Description:

*/
private["_packet","_array","_flag","_alive","_position"];
_packet = [getPlayerUID player,(profileName),playerSide,life_KavaCash,life_KavaBank];
_array = [];
_alive = life_is_alive;
_position = getPosASL player;
_flag = switch(playerSide) do {case west:{"cop"}; case civilian:{"civ"}; case independent:{"med"};};
if(playerSide isEqualTo independent) then
{
	if((FETCH_CONST(life_medicLevel)) in [0,1]) exitWith {_flag="med";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 2) exitWith {_flag="mecano";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 3) exitWith {_flag="merce";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 4) exitWith {_flag="conces";};
};


{
	_varName = LICENSE_VARNAME(configName _x,_flag);
	_array pushBack [_varName,LICENSE_VALUE(configName _x,_flag)];
} foreach (format["getText(_x >> 'side') isEqualTo '%1'",_flag] configClasses (missionConfigFile >> "Licenses"));

_packet pushBack _array;
[] call life_fnc_saveGear;
_packet pushBack life_gear;

_array = [];
_array pushBack life_hunger;
_array pushBack life_thirst;
_array pushBack (damage player);
if(playerSide isEqualTo civilian) then
{
	_tmp = SEL(getAllHitPointsDamage player,2);
	_i = 0;
	{
		_tch = _x;
		_tch = round(_tch * 100)/100;
		_tmp set[_i,_tch];
		_i = _i + 1;
	}forEach _tmp;
	_array pushBack _tmp;
	_array pushBack 5000;
	_array pushBack 0;
	_array pushBack 0;
	_packet pushBack _array;
	_packet pushBack life_is_arrested;
	_packet pushBack _alive;
	_packet pushBack _position;
	
}else
{
	_packet pushBack _array;
};

if(life_HC_isActive) then {
	_packet remoteExecCall ["HC_fnc_updateRequest",HC_Life];
} else {
	_packet remoteExecCall ["DB_fnc_updateRequest",RSERV];
};
