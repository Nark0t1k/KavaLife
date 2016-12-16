#include "..\..\script_macros.hpp"
/*
	File: fn_giveItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Gives the selected item & amount to the selected player and
	removes the item & amount of it from the players virtual
	inventory.
*/
private["_unit","_val","_sel","_list"];
_type = _this select 0;
_nbr = _this select 1;
_item = lbData [3701,(lbCurSel 3701)];
if(_type)then
{
	_val = ctrlText 3702;
}else
{
	if(_nbr isEqualTo 0)then
	{
		_val = format["%1", ITEM_VALUE(_item)];
	}else
	{
		_val = format["%1", _nbr];
	};
	
};
// ctrlShow[2002,false];
// if((lbCurSel 2023) isEqualTo -1) exitWith {hint parseText "No one was selected!";
// ctrlShow[2002,true];};
_unit = life_pInact_curTarget;

_list = CONTROL(3700,3701);
_sel = lbCurSel _list;
if((_list lbText _sel) isEqualTo "Vous n'avez pas d'objet") exitWith {hint parseText "Vous n'avez pas d'objet";};

if(isNull _unit) exitWith {hint parseText "La personne n'est plus la.";};

if(isNil "_unit") exitWith {hint parseText "La personne n'est plus la.";};
if(_unit isEqualTo player) exitWith {hint parseText "La personne n'est plus la.";};
if(isNull _unit) exitWith {hint parseText "La personne n'est plus la.";};

//A series of checks *ugh*
if(player distance _unit > 10) exitWith {hint parseText "La personne que vous avez selectioné n'est pas à proximité";};
if(!([_val] call TON_fnc_isnumber)) exitWith {hint parseText "You didn't enter an actual number format.";};
if(parseNumber(_val) <= 0) exitWith {hint parseText "You need to enter an actual amount you want to give.";};
if(isNil "_unit") exitWith {hint parseText "The selected player is not within range";};
if(!([false,_item,(parseNumber _val)] call life_fnc_handleInv)) exitWith {hint parseText "Couldn't give that much of that item, maybe you don't have that amount?";};

[_unit,_val,_item,player] remoteExecCall ["life_fnc_receiveItem",_unit];
_type = M_CONFIG(getText,"VirtualItems",_item,"displayName");
hint format["Tu as donné %1 %2",_val,(localize _type)];
[] call life_fnc_p_updateMenu;
[format["[GIVEITEM] %1(%2) -ITEM: %3 -NBR: %4 -CIBLE: %5(%6)", name player, getPlayerUID player, _type,_val,_unit getVariable["realname",name _unit], getPlayerUID _unit]] remoteExecCall ["A3Log", 2];
closeDialog 0;