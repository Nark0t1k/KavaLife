#include "..\..\script_macros.hpp"
/*
	File: fn_friendAnswerPlayer.sqf

*/

private["_action","_unit","_ask"];
_unit = _this select 0;
_ask = _this select 1;
_type = _this select 2;
if(isNil "_unit" OR isNil "_ask") exitWith {};
if(player isEqualTo _unit) then
{
	if(_type)then
	{
		hint format["%1 a accepter ta demande d'amis", name _ask];
		life_friendList pushBack (getPlayerUID _ask);
		[8] call SOCK_fnc_updatePartial;
	}else
	{
		hint format["%1 a refusé ta demande d'amis", name _ask];
	};
};