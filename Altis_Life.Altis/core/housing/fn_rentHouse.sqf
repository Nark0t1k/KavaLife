#include "..\..\script_macros.hpp"
/*
	File: fn_rentHouse.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Buys the house?
*/
private["_house","_uid","_action","_houseCfg","_price"];
_house = param [0,ObjNull,[ObjNull]];
_uid = getPlayerUID player;

if(isNull _house) exitWith {};
if(!(_house isKindOf "House_F")) exitWith {};
if(!license_civ_home) exitWith {hint localize "STR_House_License"};
closeDialog 0;

_houseCfg = [(typeOf _house)] call life_fnc_houseConfig;
if(EQUAL(count _houseCfg,0)) exitWith {};
_price = round((_houseCfg select 0)/2);
_action = [
	format[localize "STR_House_rentMSG",
	[_price] call life_fnc_numberText,
	(_houseCfg select 1)],localize "STR_House_Purchase",localize "STR_Global_Buy",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if(_action) then {
	if(life_KavaBank < _price) exitWith {hint format [localize "STR_House_NotEnough"]};
	SUB(life_KavaBank,_price);
	
	if(life_HC_isActive) then {
		[_uid,_house] remoteExecCall ["HC_fnc_rentHouse",HC_Life];
	} else {
		[_uid,_house] remoteExec ["TON_fnc_rentHouse",RSERV];
	};
	hint parseText "Vous avez payer la location de votre maison pour les 30 prochains jours.";	
};
[1] call SOCK_fnc_updatePartial;