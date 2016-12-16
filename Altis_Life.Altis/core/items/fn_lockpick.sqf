#include "..\..\script_macros.hpp"
/*
	File: fn_lockpick.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Main functionality for lock-picking.
*/
#define SAFETY_ZONES    [["Mark_Safe_Zone_1", 550], ["Mark_Safe_Zone_2", 250], ["Mark_Safe_Zone_3", 100]]
private["_curTarget","_distance","_isVehicle","_isParaDrop","_title","_progressBar","_cP","_titleText","_sLock","_alarm","_dice","_badDistance","_rdm"];
closeDialog 0;
_curTarget = cursorTarget;
life_interrupted = false;
if (({player distance getMarkerPos (_x select 0) < _x select 1} count SAFETY_ZONES > 0) && playerSide isEqualTo civilian) exitWith
{
	 hint parseText "ATTENTION ZONE SAFE, VOL DE VEHICULE INTERDIT!!!!";
};
if(life_action_inUse) exitWith {};
if(isNull _curTarget) exitWith {}; //Bad type
_distance = ((boundingBox _curTarget select 1) select 0) + 2;
if(player distance _curTarget > _distance) exitWith {}; //Too far

_isParaDrop = if(typeOf _curTarget isEqualTo "Box_IND_Support_F")then {true} else {false};
_isVehicle = if((_curTarget isKindOf "LandVehicle") OR (_curTarget isKindOf "Ship") OR (_curTarget isKindOf "Air")) then {true} else {false};
if(_isVehicle && _curTarget in life_vehicles) exitWith {[localize "STR_ISTR_Lock_AlreadyHave"] call life_fnc_showNotification;};

//More error checks
if(!_isParaDrop && !_isVehicle && !isPlayer _curTarget) exitWith {};
if(!_isVehicle  && !_isParaDrop && !(_curTarget getVariable ["restrained",false]) && !(_curTarget getVariable ["restrainedciv",false])) exitWith {};
if(_isParaDrop && !(_curTarget getVariable ["locked",false])) exitWith {};

_title = format[localize "STR_ISTR_Lock_Process",if(!_isVehicle) then {"Handcuffs"} else {format["%1 (Niveau: %2) -",getText(configFile >> "CfgVehicles" >> (typeOf _curTarget) >> "displayName"),life_skillLock]}];
if(_isParaDrop) then {_title = format[localize "STR_ISTR_Lock_Process","Box Militaire"];};


_handle = [_title,false,5,0.01,0.26,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

if(_isParaDrop)exitWith
{
	_curTarget setVariable ["locked",false,true];
	[localize "STR_PARA_Unlocked"] call life_fnc_showNotification;
	_light = createVehicle ["SmokeShellGreen", position _curTarget, [], 0, 'NONE'];
};
[false,"lockpick",1] call life_fnc_handleInv;
if(!_isVehicle) then {
	_curTarget setVariable ["restrainedciv",false,true];
	_curTarget setVariable ["restrained",false,true];
	_curTarget setVariable ["Escorting",false,true];
	_curTarget setVariable ["transporting",false,true];
} else {
	if((FETCH_CONST(life_medicLevel)) isEqualTo 2) exitWith
	{
		_curTarget lock 0;
		[_curTarget,0] remoteExecCall ["life_fnc_lockVehicle",_curTarget];
		[localize "STR_ISTR_MecaLock_Success"] call life_fnc_showNotification;
		[true,"lockpick",1] call life_fnc_handleInv;
	};
	_rdm = switch (life_skillLock)do
	{
		case 0:{120};
		case 1:{100};
		case 2:{80};
		case 3:{50};
		case 4:{30};
		case 5:{20};
		default {120};
	};
	["lock",1] call life_fnc_skillsUpdate;
	_dice = random(_rdm);
	if(_dice < 10) then {
		[localize "STR_ISTR_Lock_Success"] call life_fnc_showNotification;
		life_vehicles pushBack _curTarget;
		// [4] call life_fnc_removeLicenses;
		if(life_HC_isActive) then {
			[getPlayerUID player,profileName,"487"] remoteExecCall ["HC_fnc_wantedAdd",HC_Life];
		} else {
			[getPlayerUID player,profileName,"487"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
		};

	} else {
		// [4] call life_fnc_removeLicenses;
		if(life_HC_isActive) then {
			[getPlayerUID player,profileName,"215"] remoteExecCall ["HC_fnc_wantedAdd",HC_Life];
		} else {
			[getPlayerUID player,profileName,"215"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
		};

		[0,"STR_ISTR_Lock_FailedNOTF",true,[profileName]] remoteExecCall ["life_fnc_broadcast",west];
		[localize "STR_ISTR_Lock_Failed"] call life_fnc_showNotification;
	};
};
