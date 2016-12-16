#include "..\..\script_macros.hpp"
/*
	File: fn_amendeSend.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Gives a ticket to the targeted player.
*/
private["_dataList","_unit","_typeSel"];
disableSerialization;
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _unit)exitWith {};
_listGiveContrav = CONTROL(13000,13001);
if((lbSize _listGiveContrav) isEqualTo 0) exitWith {hint "Vous ne pouvez pas donner une amendes sans avoir en avoir au moins selectionne une";};
_dataList = [];
for[{_i = 0},{_i < (lbSize _listGiveContrav)},{_i = _i + 1}] do {
	_typeSel = lbData[13001,_i];
	_dataList pushback _typeSel;
};

// [0,"STR_Cop_TicketGive",true,[profileName,_unit getVariable ["realname",name _unit]]] remoteExecCall ["life_fnc_broadcast",west];
[player, _dataList] remoteExec ["life_fnc_amendeReceive",_unit];
closeDialog 0;