#include "..\..\script_macros.hpp"
/*
	File: fn_buyAlarm.sqf

*/
private["_house","_uid","_action","_houseCfg","_price"];
_house = param [0,ObjNull,[ObjNull]];
_uid = getPlayerUID player;

if(isNull _house) exitWith {};
if(!(_house isKindOf "House_F")) exitWith {};
closeDialog 0;
if(_house getVariable ["house_alarm",false]) exitWith {hint "Vous avez deja une alarme";};
_houseCfg = [(typeOf _house)] call life_fnc_houseConfig;
_price = 150000;
_action = [
	localize "STR_House_AlarmBuy",localize "STR_HouseAlarm_Purchase",localize "STR_Global_Buy",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if(_action) then {
	if(life_KavaBank < _price) exitWith {hint format [localize "STR_House_NotEnough"]};
	SUB(life_KavaBank,_price);
	
	if(life_HC_isActive) then {
		[_uid,_house] remoteExecCall ["HC_fnc_buyAlarm",HC_Life];
	} else {
		[_uid,_house] remoteExec ["TON_fnc_buyAlarm",RSERV];
	};
	hint parseText "Vous avez achete une alarme pour votre maison.";	
};
[1] call SOCK_fnc_updatePartial;