#include "..\..\script_macros.hpp"
/*
	File: fn_updatePartial.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Sends specific information to the server to update on the player,
	meant to keep the network traffic down with large sums of data flowing
	through remoteExec
*/
private["_mode","_packet","_array","_flag"];
_mode = param [0,0,[0]];
_packet = [getPlayerUID player,playerSide,nil,_mode];
_array = [];
_flag = switch(playerSide) do {case west:{"cop"}; case civilian:{"civ"}; case independent:{"med"};};
if(playerSide isEqualTo independent) then
{
	if((FETCH_CONST(life_medicLevel)) in [0,1]) exitWith {_flag="med";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 2) exitWith {_flag="mecano";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 3) exitWith {_flag="merce";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 4) exitWith {_flag="conces";};
};
switch(_mode) do {
	case 0: {
		_packet set[2,life_KavaCash];
	};

	case 1: {
		_packet set[2,life_KavaBank];
	};

	case 2: {
		{
			_varName = LICENSE_VARNAME(configName _x,_flag);
			_array pushBack [_varName,LICENSE_VALUE(configName _x,_flag)];
		} foreach (format["getText(_x >> 'side') isEqualTo '%1'",_flag] configClasses (missionConfigFile >> "Licenses"));

		_packet set[2,_array];
	};

	case 3: {
		[] call life_fnc_saveGear;
		_packet set[2,life_gear];
	};

	case 4: {
		_packet set[2,life_is_alive];
		_packet set[4,getPosASL player];
	};

	case 5: {
		_packet set[2,life_is_arrested];
	};

	case 6: {
		_packet set[2,life_KavaCash];
		_packet set[4,life_KavaBank];
	};

	case 7: {
		// Tonic is using for keychain..?
	};
	
	case 8: {
		_packet set[2,life_friendList];
	};
	case 10: {
		_packet set[2,[life_skillGather,life_skillGatherCount]];
	};
	case 11: {
		_packet set[2,[life_skillProcess,life_skillProcessCount]];
	};
	case 12: {
		_packet set[2,[life_skillRepair,life_skillRepairCount]];
	};
	case 13: {
		_packet set[2,[life_skillLock,life_skillLockCount]];
	};
};

if(life_HC_isActive) then {
	_packet remoteExecCall ["HC_fnc_updatePartial",HC_Life];
} else {
	_packet remoteExecCall ["DB_fnc_updatePartial",RSERV];
};
