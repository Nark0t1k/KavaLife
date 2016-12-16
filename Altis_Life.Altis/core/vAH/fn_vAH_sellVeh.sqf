#include "..\..\script_macros.hpp"
/*
	File: fn_vAH_sellVeh.sqf
	Author: Fresqo
	Description: sells items to our auction house and blah blah too much fml
*/

private["_able","_uid","_dialog","_myListbox","_uidVeh","_myQuantity","_onGuy","_details","_tquantity","_myTotal","_price","_typeb","_type","_classname","_realName","_bad","_tax","_action","_selectedSell","_quantity","_tochangePriceText","_tochangePriceNumber","_tochangeQuantityText","_tochangeQuantityNumber","_invItem"];
disableSerialization;
_dialog = findDisplay 16600;
_myListbox = CONTROL(16600,16601);
_able = 3;
if (!vAH_loaded) exitWith {hint parseText "Auction house is busy at the moment, please try again in a short while!"};

_bad = false;
_realName = "";
switch (FETCH_CONST(life_donator)) do
{
	case 0: {_able = 3;}; 
	case 1: {_able = 4;}; 
	case 2: {_able = 5;}; 
	case 3: {_able = 6;}; 
};

_uid = getPlayerUID player;
if (({_x select 5 isEqualTo _uid} count all_ah_items) >= _able) exitWith {hint format["You can only have %1 items listed",_able];closeDialog 0;};
if (count all_ah_items >= 80) exitWith {hint parseText "The auction house has reached its listing limit, please wait for an item expiry and try again";closeDialog 0;};

_price = ctrlText 16603;

if(! ([_price] call TON_fnc_isnumber)) exitWith {hint parseText "You have to enter a number in the price field.";};
_price = parseNumber _price;

if((lbCurSel 16601) isEqualTo -1) exitWith {hint parseText "Merci de choisir un vehicule";};
_selectedSell = call compile (_myListbox lbData (lbCurSel _myListbox));

_classname = _selectedSell select 0;
_uidVeh = _selectedSell select 3;
if (_classname isEqualTo "yolo") exitWith {};
_invItem = [_selectedSell,2,3,[3]] call BIS_fnc_param;
if (_invItem != 3) exitWith {hint parseText "You cannot sell an item that is already on the auction house, expired, or sold!"};

if (_price < 1) exitWith {hint parseText "Invalid value"};
if (_price > 9000000) exitWith {hint parseText "Invalid value. Must be lower than 9 mil"};

_tax = round (_price * 0.03);

_action = [format["You will be taxed %1€ . Continue?",_tax],"Auction Confirmation","CONTINUE","CANCEL"] call BIS_fnc_guiMessage;
if(_action) then {
	if(life_KavaBank < _tax) exitWith {hint parseText "You don't have enough money in the bank to pay the tax";_bad = true;};
	[4,2,_uidVeh,_price,getPlayerUID player,_classname,_classname,name player] remoteExecCall ["TON_fnc_vAH_update",RSERV];
	hint parseText "Auction Successfully Added";
	life_KavaBank = life_KavaBank - _tax;
	[getPlayerUID player,_uidVeh,1] remoteExecCall ["TON_fnc_HV_updateVeh",RSERV];
	closeDialog 0;
} else {
	closeDialog 0;
};