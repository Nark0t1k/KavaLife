#include "..\..\script_macros.hpp"
/*
	File: fn_processAction.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Master handling for processing an item.
*/
private ["_skillspeed","_sleeper","_luck", "_vendor", "_type", "_itemInfo", "_oldItem", "_newItem", "_cost", "_upp", "_exit", "_ArrayItem", "_ItemName", "_ItemSelected", "_itemNameInv", "_item", "_var", "_ItemNumber", "_itemNumberNow", "_IndexNow", "_ItemNameLife", "_ItemNumberLife", "_hasLicense", "_oldVal", "_ui", "_progress", "_pgText", "_cP", "_ItemMax", "_calcul", "_ItemMin", "_ItemNameHandle", "_ItemNumberHandle"];

//Ignored Special Variables: _this, _x.
_vendor = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_type = [_this,3,"",[""]] call BIS_fnc_param;
//Error check
if(isNull _vendor OR EQUAL(_type,"") OR (player distance _vendor > 10)) exitWith {};

if(playerSide != civilian) exitWith {hint "Vous ne pouvez pas utiliser cette usine";};
//unprocessed item,processed item, cost if no license,Text to display (I.e Processing  (percent) ..."
_itemInfo = switch (_type) do {
	case "frite": {[[["pdt",1]],[["frite",1]],300,(localize "STR_Process_Frite")];};
	case "woodplank": {[[["wood",1]],[["woodplank",1]],600,(localize "STR_Process_Woodplank")];};
	case "cement": {[[["rock",1]],[["cement",1]],600,(localize "STR_Process_Cement")];};
	case "sand": {[[["sand",1]],[["glass",1]],600,(localize "STR_Process_Sand")];};
	case "bouteille": {[[["glass",1]],[["bouteille",1]],1000,(localize "STR_Process_Bouteille")];};
	case "copper": {[[["copper_unrefined",1]],[["copper_refined",1]],1250,(localize "STR_Process_Copper")];};
	case "iron": {[[["iron_unrefined",1]],[["iron_refined",1]],1250,(localize "STR_Process_Iron")];};
	case "silver": {[[["silver_unrefined",1]],[["silver_refined",1]],1250,(localize "STR_Process_Silver")];};
	case "salt": {[[["salt_unrefined",1]],[["salt_refined",1]],1250,(localize "STR_Process_Salt")];};
	case "oil": {[[["oil_unprocessed",1]],[["oil_processed",1]],1250,(localize "STR_Process_Oil")];};
	case "diamond": {[[["diamond_uncut",1]],[["diamond_cut",1]],1750,(localize "STR_Process_Diamond")];};
	case "diamond2": {[[["diamond_cut",1]],[["diamond_taille",1]],1750,(localize "STR_Process_Diamond")];};
	case "marijuana": {[[["cannabis",1]],[["marijuana",1]],500,(localize "STR_Process_Marijuana")];};
	case "heroin": {[[["heroin_unprocessed",1]],[["heroin_processed",1]],1750,(localize "STR_Process_Heroin")];};
	case "cocaine": {[[["cocaine_unprocessed",1]],[["cocaine_processed",1]],1500,(localize "STR_Process_Cocaine")];};
	case "fouilleeau": {[[["fouilleEau",1]],[["fouilleFosileEau",1]],2500,(localize "STR_Process_FouilleEau")];};
	case "fouilleterre": {[[["fouilleTerre",1]],[["fouilleFosileTerre",1]],2500,(localize "STR_Process_FouilleTerre")];};
	case "wisky1": {[[["levure",1],["malt",1]],[["wiskyFerm",1]],3000,(localize "STR_Process_Wisky")];};
	case "wisky2": {[[["wiskyFerm",1],["bouteille",1]],[["wisky",1]],3000,(localize "STR_Process_Wisky")];};
	case "biere1": {[[["houblon",1],["malt",1]],[["biereFerm",1]],3000,(localize "STR_Process_Biere")];};
	case "biere2": {[[["biereFerm",1],["bouteille",1]],[["biere",1]],3000,(localize "STR_Process_Biere")];};
	case "vodka": {[[["pdt",1],["bouteille",1]],[["vodka",1]],3000,(localize "STR_Process_Vodka")];};
	case "meth1": {[[["methPur",1]],[["methTraite",1]],1500,(localize "STR_Process_Meth")];};
	case "meth2": {[[["methTraite",1]],[["methLave",1]],1500,(localize "STR_Process_Meth")];};
	case "meth3": {[[["methLave",1]],[["methDesinc",1]],1500,(localize "STR_Process_Meth")];};
	case "uranium1": {[[["uranium",1]],[["uraniumDesin",1]],3000,(localize "STR_Process_Uranium")];};
	case "uranium2": {[[["uraniumDesin",1]],[["uraniumPur",1]],3000,(localize "STR_Process_Uranium")];};
	case "ExempleMultiProcess": {[[["peach",2],["cannabis",3],["cocaine_unprocessed",2]],[["diamond_cut",2],["marijuana",5]],350,(localize "STR_Process_Cement")];};
	default {[];};
};

//Error checking
if(EQUAL(count _itemInfo,0)) exitWith {};

//Setup vars.
_oldItem = SEL(_itemInfo,0);
_newItem = SEL(_itemInfo,1);
if(_type isEqualTo "fouilleterre") then
{
	_luck = floor(random 100);
	_newItem = switch (true) do {
		case (_luck >= 0 && _luck < 40): {[["fouilleFosileTerre1",1]]};
		case (_luck >= 40 && _luck < 80): {[["fouilleFosileTerre2",1]]};
		case (_luck >= 80 && _luck <= 100): {[["fouilleFosileTerre3",1]]};
	};
};
if(_type isEqualTo "fouilleeau") then
{
	_luck = floor(random 100);
	_newItem = switch (true) do {
		case (_luck >= 0 && _luck < 60): {[["fouilleFosileEau1",1]]};
		case (_luck >= 60 && _luck < 90): {[["fouilleFosileEau2",1]]};
		case (_luck >= 90 && _luck <= 100): {[["fouilleFosileEau3",1]]};
	};
};
_cost = SEL(_itemInfo,2);
_upp = format["%1 (Niveau: %2) -", SEL(_itemInfo,3), life_skillProcess];
_exit = false;

_ArrayItem = [];
_ItemName = [];
{
	_ItemSelected = _x select 0;
	_ItemName pushBack _ItemSelected;
} forEach _oldItem;

_itemNameInv = [];
{
	_item = _x select 0;
	_var = ITEM_VARNAME(_item);
	_itemNameInv pushBack [_var];
} forEach _oldItem;

_ItemNumber = [];
{
	_itemNumberNow = _x select 1;
	_ItemNumber pushback [_itemNumberNow];
} forEach _oldItem;

_IndexNow = -1;
{
	_IndexNow = _IndexNow + 1;
	_ItemNameLife = (_itemNameInv select _IndexNow) select 0;
	_var = ITEM_VALUE2(_ItemNameLife);
	if(EQUAL(_var,0)) exitWith {
		_exit = true;
	};
	_ItemNumberLife = (_ItemNumber select _IndexNow) select 0;
	if (_var < _ItemNumberLife) exitWith {
		_exit = true;
	};
} forEach _itemNameInv;
if (_exit) exitWith {life_is_processing = false;[format[localize "STR_NOTF_NotEnoughItemProcess",_ItemNumberLife ,(localize ITEM_NAME(_item))]] call life_fnc_showNotification;};

_oldVal = count _ItemName;

//Some more checks
if(EQUAL(_oldVal,0)) exitWith {};

_skillspeed = switch (life_skillProcess)do
{
	case 0:{0.06};
	case 1:{0.05};
	case 2:{0.04};
	case 3:{0.03};
	case 4:{0.02};
	case 5:{0.015};
	default {0.06};
};

_sleeper = _var*_skillspeed;

life_is_processing = true;

_handle = [_upp,true,10,0.01,_sleeper,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

_IndexNow = -1;
_ItemMax = [];
{
	_IndexNow = _IndexNow + 1;
	_ItemNameLife = (_itemNameInv select _IndexNow) select 0;
	_var = ITEM_VALUE2(_ItemNameLife);
	_ItemNumberLife = (_ItemNumber select _IndexNow) select 0;
	_calcul = (floor ((_var)/(_ItemNumberLife)));
	_ItemMax pushBack _calcul;
} forEach _itemNameInv;
_ItemMin = _ItemMax select 0;
{
	if (_x<_ItemMin) then {_ItemMin=_x};
} forEach _ItemMax;
_IndexNow = -1;
if(_type isEqualTo "archeo") then
{
	{
		_IndexNow = _IndexNow + 1;
		_ItemNameHandle = _x select 0;
		_ItemNumberHandle = _x select 1;
		[false,_ItemNameHandle,1] call life_fnc_handleInv;
	} forEach _oldItem;
	{
		_ItemNameHandle = _x select 0;
		_ItemNumberHandle = _x select 1;
		[true,_ItemNameHandle,1] call life_fnc_handleInv;
	} forEach _newItem;
	[format["[PROCESS] %1(%2) a transformer 1 objets au traitement de %4 AVEC LICENSE",name player, getPlayerUID player,((_ItemNumberHandle)*(_ItemMin)),_type]] remoteExecCall ["A3Log", 2];
}else
{
	{
		_IndexNow = _IndexNow + 1;
		_ItemNameHandle = _x select 0;
		_ItemNumberHandle = _x select 1;
		[false,_ItemNameHandle,((_ItemNumberHandle)*(_ItemMin))] call life_fnc_handleInv;
	} forEach _oldItem;
	{
		_ItemNameHandle = _x select 0;
		_ItemNumberHandle = _x select 1;
		[true,_ItemNameHandle,((_ItemNumberHandle)*(_ItemMin))] call life_fnc_handleInv;
	} forEach _newItem;
	[format["[PROCESS] %1(%2) a transformer %3 objets au traitement de %4 AVEC LICENSE",name player, getPlayerUID player,((_ItemNumberHandle)*(_ItemMin)),_type]] remoteExecCall ["A3Log", 2];
};
5 cutText ["","PLAIN"];
[localize "STR_NOTF_ItemProcess"] call life_fnc_showNotification;
["process",((_ItemNumberHandle)*(_ItemMin))] call life_fnc_skillsUpdate;
life_is_processing = false;

