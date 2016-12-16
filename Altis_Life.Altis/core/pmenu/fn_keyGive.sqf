#include "..\..\script_macros.hpp"
/*
	File: fn_keyGive.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Gives a copy of the key for the selected vehicle to the selected player.
	Player must be within range.
*/
private["_dialog","_list","_plist","_sel","_vehicle","_owners","_index","_unit","_uid"];
disableSerialization;

_dialog = findDisplay 2700;
_list = _dialog displayCtrl 2701;

_sel = lbCurSel _list;
if((_list lbText _sel) isEqualTo "Tu n'as pas de clefs de vehicule") exitWith {hint parseText "Tu n'as pas de clefs de vehicule.";};
_vehicle = _list lbData _sel;
_vehicle = life_vehicles select parseNumber(_vehicle);

// if((lbCurSel 2702) isEqualTo -1) exitWith {hint parseText "You didn't select a player.";};
_unit = life_pInact_curTarget;
if(isNull _unit OR isNil "_unit") exitWith {};
if(_unit isEqualTo player) exitWith {};
if(player distance _unit > 10) exitWith {hint parseText "La personne que vous avez selectioné n'est pas à proximité";ctrlShow[2002,true];};

_uid = getPlayerUID _unit;
_owners = _vehicle getVariable "vehicle_info_owners";
_index = [_uid,_owners] call TON_fnc_index;
if(EQUAL(_index,-1)) then  {
	_owners pushBack [_uid,_unit getVariable ["realname",name _unit]];
	_vehicle setVariable ["vehicle_info_owners",_owners,true];
};

hint format["You have given %1 keys to your %2",_unit getVariable ["realname",name _unit],typeOf _vehicle];
[_vehicle,_unit,profileName] remoteExecCAll ["TON_fnc_clientGetKey",_unit];
