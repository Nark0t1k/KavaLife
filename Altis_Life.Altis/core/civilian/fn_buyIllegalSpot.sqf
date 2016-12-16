#include "..\..\script_macros.hpp"
/*
	fn_buyIllegalSpot.sqf
	By Nark0t1k
*/
private ["_toShow", "_price","_action"];

_toShow = _this select 3;
if(_toShow isEqualTo "") exitWith {};
_price = 0;

_price = switch (_toShow) do
{
	case "weed": {10000};
	case "heroin": {20000};
	case "cocaine": {30000};
	case "meth": {75000};
	default {0};
};
if(_price isEqualTo 0) exitWith {};

if(life_KavaCash < _price)exitWith{[format["Tu n'as pas assez d'argent tu as besoin de %1$", _price]] call life_fnc_showNotification;};

_action = [
	format["L'achat des informations coute %1$ les acheter?",_price],
	"Achat d'information",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(!(_action)) exitWith {};

SUB(life_KavaCash,_price);

switch (_toShow) do
{
	case "weed":
	{
		life_spotDrugs set [0,true];
		"weed_1" setMarkerAlphaLocal 1;
		"weedUsine_1" setMarkerAlphaLocal 1;
	};
	case "heroin":
	{
		life_spotDrugs set [1,true];
		"heroin_1" setMarkerAlphaLocal 1;
		"heroinUsine_1" setMarkerAlphaLocal 1;
	};
	case "cocaine":
	{
		life_spotDrugs set [2,true];
		"cocaine_1" setMarkerAlphaLocal 1;
		"cocaineUsine_1" setMarkerAlphaLocal 1;
	};
	case "meth":
	{
		life_spotDrugs set [3,true];
		"meth_1" setMarkerAlphaLocal 1;
	};
};
[] call life_fnc_hudUpdate;
[0] call SOCK_fnc_updatePartial;
[[7],format["Tu as acheter les information de %1 pour %2€",_toShow,_price]] remoteExecCall ["life_fnc_broadcast",player];