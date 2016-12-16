#include "..\..\script_macros.hpp"
/*
    File: fn_onFired.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Handles various different ammo types being fired.
*/
private["_ammoType","_projectile"];
_ammoType = _this select 4;
_projectile = _this select 6;

#define SAFETY_ZONES    [["Mark_Safe_Zone_1", 550], ["Mark_Safe_Zone_2", 250], ["Mark_Safe_Zone_3", 100]] // Syntax: [["marker1", radius1], ["marker2", radius2], ...]
#define MESSAGE "Tir impossible en zone safe!"

if (({(_this select 0) distance getMarkerPos (_x select 0) < _x select 1} count SAFETY_ZONES > 0) && playerSide isEqualTo civilian) exitWith
{
	 deleteVehicle (_this select 6);
	 titleText [MESSAGE, "PLAIN", 3];
	 hint parseText "ATTENTION ZONE SAFE, TIR INTERDIT!!!!";
};
if (_ammoType isEqualTo "GrenadeHand_stone") then {
    _projectile spawn {
        private "_position";
        while {!isNull _this} do {
            _position = ASLtoATL (visiblePositionASL _this);
            sleep 0.1;
        };
        [_position] remoteExec ["life_fnc_flashbang",RCLIENT];
    };
};
if(EQUAL(_ammoType,"SmokeShellGreen")) then {
	_projectile spawn {
		private "_position";
		sleep 5;
		_position = ASLtoATL (visiblePositionASL _this);
		[_position] remoteExec ["life_fnc_lacrymo",RCLIENT];
	};
};
