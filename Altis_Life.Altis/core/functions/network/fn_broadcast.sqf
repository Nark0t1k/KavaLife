#include "..\..\..\script_macros.hpp"
/*
	File: fn_broadcast.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Broadcast system used in the life mission for multi-notification purposes.
	type
	0 : systemchat (dialog radio)
	1 : hint
	2 : titleText (Centre de l'écran)
	3: Notification 2sec
	4: Notification 5sec
	5: Notification 10sec
	
	[0,format[(localize "STRTEXTLOCALIZE"), _var1, _var2]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	[0,format[(localize "STRTEXTLOCALIZE"), _var1, _var2]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	
	[[0,1],"STR_GNOTF_CaptureSuccess",true,[name player,player getVariable "gang_name"]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	
*/
if(!hasInterface && !isDedicated)exitWith {};
private["_type","_message","_indepType","_exit"];
_type = [_this,0,0,[[],0]] call BIS_fnc_param;
_message = [_this,1,"",[""]] call BIS_fnc_param;
_localize = [_this,2,false,[false]] call BIS_fnc_param;
_indepType = [_this,3,"",[""]] call BIS_fnc_param;
if(_message isEqualTo "") exitwith {};
_exit = false;
if(_indepType != "") then
{
	if(_indepType isEqualTo "medic")then {if(!((FETCH_CONST(life_medicLevel)) in [0,1]))then{_exit=true;};};
	if(_indepType isEqualTo "mecano")then {if(!((FETCH_CONST(life_medicLevel)) isEqualTo 2))then{_exit=true;};};
	if(_indepType isEqualTo "merce")then {if(!((FETCH_CONST(life_medicLevel)) isEqualTo 3))then{_exit=true;};};
	if(_indepType isEqualTo "conces")then {if(!((FETCH_CONST(life_medicLevel)) isEqualTo 4))then{_exit=true;};};
};
if(_exit) exitWith {};

if(_localize) then {
	_arr = _this select 3;
	_msg = switch(count _arr) do {
		case 0: {localize _message;};
		case 1: {format[localize _message,_arr select 0];};
		case 2: {format[localize _message,_arr select 0, _arr select 1];};
		case 3: {format[localize _message,_arr select 0, _arr select 1, _arr select 2];};
		case 4: {format[localize _message,_arr select 0, _arr select 1, _arr select 2, _arr select 3];};
		case 5: {format[localize _message,_arr select 0, _arr select 1, _arr select 2, _arr select 3, _arr select 4];};
	};
	_message = _msg;
};

if(typeName _type isEqualTo typeName []) then
{
	for "_i" from 0 to (count _type)-1 do
	{
		switch((_type select _i)) do
		{
			case 0: {systemChat _message};
			case 1: {hint format["%1", _message]};
			case 2: {titleText[format["%1",_message],"PLAIN"];};
			case 3: {hint parseText format ["%1",_message];};
			case 4: {["ShowInfoLow",[_message]] call BIS_fnc_showNotification;};
			case 5: {["ShowInfoMed",[_message]] call BIS_fnc_showNotification;};
			case 6: {["ShowInfoHigh",[_message]] call BIS_fnc_showNotification;};
			case 7: {[_message] call life_fnc_showNotification;};
		};
	};
}
	else
{
	switch (_type) do
	{
		case 0: {systemChat _message};
		case 1: {hint format["%1", _message]};
		case 2: {titleText[format["%1",_message],"PLAIN"];};
		case 3: {hint parseText format ["%1",_message];};
		case 4: {["ShowInfoLow",[_message]] call BIS_fnc_showNotification;};
		case 5: {["ShowInfoMed",[_message]] call BIS_fnc_showNotification;};
		case 6: {["ShowInfoHigh",[_message]] call BIS_fnc_showNotification;};
		case 7: {[_message] call life_fnc_showNotification;};
	};
};