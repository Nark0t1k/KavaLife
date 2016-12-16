#include "..\..\script_macros.hpp"
/*
	File: fn_vAH_sell.sqf
	Author: Fresqo
	Description: sells items to our auction house and blah blah too much fml
*/

private["_able","_uid","_dialog","_myListbox","_myQuantity","_onGuy","_details","_tquantity","_myTotal","_price","_typeb","_type","_classname","_realName","_bad","_tax","_action","_selectedSell","_quantity","_tochangePriceText","_tochangePriceNumber","_tochangeQuantityText","_tochangeQuantityNumber","_invItem"];
disableSerialization;
_dialog = findDisplay 15600;
_myListbox = _dialog displayCtrl 15601;
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

_price = ctrlText 15603;
_quantity = ctrlText 15602;

if(! ([_price] call TON_fnc_isnumber)) exitWith {hint parseText "You have to enter a number in the price field.";};
if(! ([_quantity] call TON_fnc_isnumber)) exitWith {hint parseText "You have to enter a number in the quantity field.";};
_price = parseNumber _price;
_quantity = parseNumber _quantity;

if (lbCurSel _myListbox < 0) exitWith {hint parseText "Please select an Item";};
_selectedSell = call compile (_myListbox lbData (lbCurSel _myListbox));

_classname = _selectedSell select 0;
if (_classname isEqualTo "yolo") exitWith {};
_typeb = _selectedSell select 1;
_invItem = [_selectedSell,2,3,[3]] call BIS_fnc_param;
if (_invItem != 3) exitWith {hint parseText "You cannot sell an item that is already on the auction house, expired, or sold!"};
if(_typeb isEqualTo "ymenu") then {_type = 0} else {_type = 1};

if (_price < 1) exitWith {hint parseText "Invalid value"};
if (_price > 9000000) exitWith {hint parseText "Invalid value. Must be lower than 9 mil"};

_tax = round (_price * 0.03);

switch (_type) do 
{
	case 0: {
				_realName = ITEM_VARNAME (_classname);
				if (_quantity > 100) then {_bad = true; hint parseText "Are you fucking kidding me, dont be a dickhead, put a proper amount in!"};
			};
	case 1: {
			if ( isClass (configFile >> "CFGweapons" >> _classname)) exitWith {_bad = true;hint "Tu ne peux pas vendre d'armes a l'hotel des ventes";};
			if (_quantity > 1) then 
			{
				_details = [_classname] call life_fnc_fetchCfgDetails;
				if (!(_details select 6 isEqualTo "CfgMagazines")) then {
				hint parseText "You can only sell 1 of any of this item!";_bad = true;};
				_onGuy = {_classname isEqualTo _x} count (magazines player);
				if (_onGuy < _quantity) then {hint parseText "You dont have that many!";_bad = true;}
			};
			_realName = ([_classname] call life_fnc_fetchCfgDetails) select 1;
			};
};

if (_bad) exitWith {closeDialog 0;};

_action = [format["You will be taxed %1€ . Continue?",_tax],"Auction Confirmation","CONTINUE","CANCEL"] call BIS_fnc_guiMessage;
if(_action) then {
		if(life_KavaBank < _tax) exitWith {hint parseText "You don't have enough money in the bank to pay the tax";_bad = true;};
	
	switch (_type) do 
		{
			case 0: {if(!([false,_classname,_quantity] call life_fnc_handleInv)) then {hint parseText "You dont have that many!";_bad = true;};};
			case 1: {
						_tquantity = _quantity +1;
						for [{_i=1}, {_i<_tquantity}, {_i=_i+1}] do 
							{
								[_classname,false] spawn life_fnc_handleItem;
							};
					};
		};
		if (_bad) exitWith {closeDialog 0;};
		[4,_type,_quantity,_price,getPlayerUID player,_classname,_realName,name player] remoteExecCall ["TON_fnc_vAH_update",RSERV];
		hint parseText "Auction Successfully Added";
		life_KavaBank = life_KavaBank - _tax;
		closeDialog 0;
		} else {
			closeDialog 0;
		};