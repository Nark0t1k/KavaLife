#include "..\..\script_macros.hpp"
/*
	fn_sendMessage.sqf
*/
private ["_type", "_msg", "_target","_online"];

_type = _this select 0;
_msg = ctrlText 88506;
if(_msg isEqualTo "") exitWith {hint parseText "Tu dois ecrire un message!";};
_target = life_messageTo;
_online = false;
{
	if(getPlayerUID _x isEqualTo SEL(life_messageTo,0))exitWith {_online = true;_target = _x;};
}forEach playableUnits;
// if(life_messageTo isEqualTo "")exitWith {};
if(_type) then
{
	closeDialog 0;
};
if(typeName _target isEqualTo "ARRAY")then
{
	if(SEL(_target,0) isEqualTo "police")exitWith {[2,_msg,name player,player,mapGridPosition player] remoteExec ["life_fnc_receiveMessage",west];hint format["Tu as envoyer un message à la police: %1", _msg];[] spawn life_fnc_callCop;};
	if(SEL(_target,0) isEqualTo "medecin")exitWith {[3,_msg,name player,player,mapGridPosition player] remoteExec ["life_fnc_receiveMessage",independent];hint format["Tu as envoyer un message au médecins: %1", _msg];};
	if(SEL(_target,0) isEqualTo "mecano")exitWith {[8,_msg,name player,player,mapGridPosition player] remoteExec ["life_fnc_receiveMessage",independent];hint format["Tu as envoyer un message au mecano: %1", _msg];};
	if(SEL(_target,0) isEqualTo "merce")exitWith {[11,_msg,name player,player,mapGridPosition player] remoteExec ["life_fnc_receiveMessage",independent];hint format["Tu as envoyer un message au mercenaire: %1", _msg];};
	if(SEL(_target,0) isEqualTo "conces")exitWith {[12,_msg,name player,player,mapGridPosition player] remoteExec ["life_fnc_receiveMessage",independent];hint format["Tu as envoyer un message au concesionnaire: %1", _msg];};
	if(SEL(_target,0) isEqualTo "admin")exitWith {[5,_msg,name player,player,mapGridPosition player] remoteExec ["life_fnc_receiveMessage",RCLIENT];hint format["Tu as envoyer un message aux Admins: %1", _msg];};
	if(SEL(_target,0) isEqualTo "adminAll")exitWith {[6,_msg,name player,player] remoteExec ["life_fnc_receiveMessage",RCLIENT];hint format["Tu as envoyer un message admin à tout les joueurs: %1", _msg];};
	if(!isNull findDisplay 88500)then
	{
		[3,SEL(_target,0)] spawn life_fnc_showMessage;
	};
	if(!_online)then
	{
		if(life_HC_isActive) then {
			[SEL(_target,0), SEL(_target,1),_msg,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		}else
		{
			[SEL(_target,0), SEL(_target,1),_msg,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		};
	};
	
}else
{
	_target = call compile format["%1",_target];
	if(_type)then
	{
		[7,_msg,name player,player] remoteExec ["life_fnc_receiveMessage",_target];
		hint format["Tu as envoyer un message Admin à %1 Message: %2",name _target, _msg];
	}else
	{
		[0,_msg,name player,player] remoteExec ["life_fnc_receiveMessage",_target];
		[3,getPlayerUID player] remoteExec ["life_fnc_showMessage",_target];
		
		if(life_HC_isActive) then {
			[getPlayerUID _target, name _target,_msg,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		}else
		{
			[getPlayerUID _target, name _target,_msg,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		};
		
		hint format["Tu as envoyer un message à %1 Message: %2",name _target, _msg];
	};
	if(!isNull findDisplay 88500)then
	{
		[3,getPlayerUID _target] spawn life_fnc_showMessage;
	};
};
life_messageTo = nil;