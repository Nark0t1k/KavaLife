#include "..\..\script_macros.hpp"
/*
	File: fn_buyWantedIndice.sqf

*/
private ["_action", "_spotPoint", "_nearest", "_marker", "_placeName", "_unit", "_distance"];

disableSerialization;
_unit = lbData[2401,(lbCurSel 2401)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitWith {};

if(life_KavaBank < 5000) exitWith {hint parseText "Tu n'as pas 5000€ sur ton compte pour acheter des informations";};
SUB(life_KavaBank,5000);

_spotPoint = [
	["rock_quarry","STR_MAR_Rock_Quarry"],
	["copper_mine","STR_MAR_Copper_Mine"],
	["iron_mine","STR_MAR_Iron_Mine"],
	["diamond_mine","STR_MAR_Diamond_Mine"],
	["silver_mine","STR_MAR_Silver_Mine"],
	["sand_mine","STR_MAR_Sand_Mine"],
	["oil_field_1","STR_MAR_Oil_Field"],
	["oil_field_2","STR_MAR_Oil_Field"],
	
	["oil_trader_1","STR_MAR_Oil_Trader"],
	["diamond_trader_1","STR_MAR_Diamond_Trader"],
	["glass_trader_1","STR_MAR_Glass_Trader"],
	["iron_copper_trader_1","STR_MAR_Iron_Copper_Trader"],
	["oil_trader_3_2","STR_MAR_Cement_Trader"],
	["silver_trader_1","STR_MAR_Silver_Trader"],
	["salt_trader_1","STR_MAR_Salt_Trader"],
	
	["copper_mine_2","STR_MAR_Copper_Processing"],
	["iron_processing_1","STR_MAR_Iron_processing"],
	["diamond_processing_1","STR_MAR_Diamond_Processing"],
	["Silver_processing_1","STR_MAR_Silver_Processing"],
	["sand_processing_1","STR_MAR_Sand_Processing"],
	["salt_processing_1","STR_MAR_Salt_Processing"],
	["rock_processing_1","STR_MAR_Rock_Processing"]
];
_nearest = 100000000;
{
	_marker = _x select 0;
	_distance = _unit distance (getMarkerPos _marker);
	if(_distance < _nearest)then
	{
		_placeName = SEL(_x,1);
		_nearest = _unit distance (getMarkerPos _marker);
	};
}foreach _spotPoint;
[1] call SOCK_fnc_updatePartial;
hint format["La personne a été vue dans la régions de :%1 cela ta couté 5000€", localize _placeName];