#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopFilter.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Applies the filter selected and changes the list.
*/
private["_itemList","_index","_config","_priceTag","_itemArray"];
_shop = uiNamespace getVariable ["Weapon_Shop",""];
if(_shop isEqualTo "") exitWith {systemChat "Bad Data Filter"; closeDialog 0;}; //Bad data passing.

//Setup List Control & Purge it.

_priceTag = ((findDisplay 39500) displayCtrl 39504);
_priceTag ctrlSetStructuredText parseText "";
_itemList = ((findDisplay 39500) displayCtrl 39503);
lbClear _itemList;

if(_this in [1,2]) then {
	if(_this isEqualTo 1) then {
		_config = M_CONFIG(getArray,"WeaponShops",_shop,"mags");
		{
			if(SEL(_x,0) in (uiNamespace getVariable ["Magazine_Array",[]])) then {
				_itemInfo = [SEL(_x,0)] call life_fnc_fetchCfgDetails;
				_itemList lbAdd format["%1",if(!(EQUAL(SEL(_x,1),""))) then {SEL(_x,1)} else {_itemInfo select 1}];
				_itemList lbSetData[(lbSize _itemList)-1,_itemInfo select 0];
				_itemList lbSetPicture[(lbSize _itemList)-1,_itemInfo select 2];
				_itemList lbSetValue[(lbSize _itemList)-1,SEL(_x,2)];
			};
		} forEach (_config);
		ctrlEnable [39506,true];
		// ctrlEnable [39507,false];
		// ctrlEnable [39508,true];
	} else {
		_config = M_CONFIG(getArray,"WeaponShops",_shop,"accs");
		{
			if(SEL(_x,0) in (uiNamespace getVariable ["Accessories_Array",[]])) then {
				_itemInfo = [SEL(_x,0)] call life_fnc_fetchCfgDetails;
				_itemList lbAdd format["%1",if(!(EQUAL(SEL(_x,1),""))) then {SEL(_x,1)} else {_itemInfo select 1}];
				_itemList lbSetData[(lbSize _itemList)-1,_itemInfo select 0];
				_itemList lbSetPicture[(lbSize _itemList)-1,_itemInfo select 2];
				_itemList lbSetValue[(lbSize _itemList)-1,SEL(_x,2)];
			};
		} forEach (_config);
		ctrlEnable [39506,true];
		// ctrlEnable [39507,true];
		// ctrlEnable [39508,false];
	};

} else {
	_config = M_CONFIG(getArray,"WeaponShops",_shop,"items");
	{
		_itemInfo = [SEL(_x,0)] call life_fnc_fetchCfgDetails;
		_itemList lbAdd format["%1",if(!(EQUAL(SEL(_x,1),""))) then {SEL(_x,1)} else {_itemInfo select 1}];
		_itemList lbSetData[(lbSize _itemList)-1,_itemInfo select 0];
		_itemList lbSetPicture[(lbSize _itemList)-1,_itemInfo select 2];
		_itemList lbSetValue[(lbSize _itemList)-1,SEL(_x,2)];
	} forEach (_config);
	ctrlEnable [39506,false];
};

((findDisplay 39500) displayCtrl 39503) lbSetCurSel 0;
