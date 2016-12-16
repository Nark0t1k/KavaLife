#include "..\..\script_macros.hpp"
/*
	File: fn_friendInvitePlayer.sqf

*/
private["_action","_unit","_ask"];
_unit = _this select 0;
_ask = _this select 1;
if(isNil "_unit" OR isNil "_ask") exitWith {};
_action = false;
if(player isEqualTo _unit) then
{
	_action = [
		format["%1 ta fait une demande d'amis accepte tu? (Attention permanent)",_ask getVariable["realname", name _ask]],
		"Demande d'amis",
		"Accepter",
		"Refuser"
	] call BIS_fnc_guiMessage;
	if(_action)then
	{
		[_ask,_unit,true] remoteExec ["life_fnc_friendAnswerPlayer",_ask];
		life_friendList pushBack (getPlayerUID _ask);
		[8] call SOCK_fnc_updatePartial;
	}else
	{
		[_ask,_unit,false] remoteExec ["life_fnc_friendAnswerPlayer",_ask];
	};
};