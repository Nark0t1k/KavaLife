#include "..\..\script_macros.hpp"
/*
	File: fn_askFriend.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Gives a copy of the key for the selected vehicle to the selected player.
	Player must be within range.
*/
private["_dialog","_list","_plist","_sel","_vehicle","_owners","_index","_unit","_uid"];
disableSerialization;

_dialog = findDisplay 6700;
_list = _dialog displayCtrl 6701;
_plist = _dialog displayCtrl 6702;
/*
_sel = lbCurSel _list;
if((_list lbText _sel) isEqualTo "You don't own any vehicles") exitWith {hint parseText "You didn't select a vehicle.";};
_vehicle = _list lbData _sel;
_vehicle = life_vehicles select parseNumber(_vehicle);
*/
if((lbCurSel 6702) isEqualTo -1) exitWith {hint parseText "Tu n'as pas choisi de personne.";};
_sel = lbCurSel _plist;
_unit = _plist lbData _sel;
_unit = call compile format["%1", _unit];
if(isNull _unit OR isNil "_unit") exitWith {};
if(_unit isEqualTo player) exitWith {};

hint format["Tu as envoyer une demande d'amis à %1 ",_unit getVariable ["realname",name _unit]];
[_unit,player] remoteExec ["life_fnc_friendInvitePlayer",_unit];
