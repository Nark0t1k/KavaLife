#include "..\..\script_macros.hpp"
/*
	File: fn_processActionJail.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Master handling for processing an item.
*/
private ["_vendor", "_type", "_itemInfo", "_oldItem", "_newItem", "_cost", "_upp", "_exit", "_ArrayItem", "_ItemName", "_ItemSelected", "_itemNameInv", "_item", "_var", "_ItemNumber", "_itemNumberNow", "_IndexNow", "_ItemNameLife", "_ItemNumberLife", "_hasLicense", "_oldVal", "_ui", "_progress", "_pgText", "_cP", "_ItemMax", "_calcul", "_ItemMin", "_ItemNameHandle", "_ItemNumberHandle"];

//Ignored Special Variables: _this, _x.
_vendor = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_type = [_this,3,"",[""]] call BIS_fnc_param;
_upp = localize "STR_Process_Dechet";
_var = ITEM_VALUE2("dechet");
_var = ITEM_VALUE("life_dechet");

//Error check
if(isNull _vendor OR (player distance _vendor > 10)) exitWith {};
if (life_inv_dechet < 10) exitWith {life_is_processing = false;hint parseText "Tu as besoins de 10Kg de dechet pour traiter";};

//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = GVAR_UINS "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

life_is_processing = true;

while{true} do {
	sleep  0.38;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(player distance _vendor > 10) exitWith {};
};
if(player distance _vendor > 10) exitWith {[localize "STR_Process_Stay"] call life_fnc_showNotification; 5 cutText ["","PLAIN"]; life_is_processing = false;};

[false,"dechet",10] call life_fnc_handleInv;

5 cutText ["","PLAIN"];
life_is_processing = false;
["Tu as traité 10kg de déchet ta peine à été réduite de 2 minutes"] call life_fnc_showNotification;

life_jailTimer = life_jailTimer - 120;


