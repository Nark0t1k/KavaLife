#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopMenuSell.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Something
*/
private ["_shopTitle", "_shopSide", "_license", "_priceTag", "_itemList", "_config", "_listedItems", "_itemArray", "_iS", "_itemInfo", "_itemCount"];
_shopTitle = M_CONFIG(getText,"WeaponShops",(SEL(_this,3)),"name");
_shopSide = M_CONFIG(getText,"WeaponShops",(SEL(_this,3)),"side");
_license = M_CONFIG(getText,"WeaponShops",(SEL(_this,3)),"license");
[player] remoteExecCall ["TON_fnc_askMarketWeapon",RSERV];
if(playerSide != civilian) exitWith {hint parseText "Tu ne peux pas acceder a se magasin";};
[player] remoteExecCall ["TON_fnc_askMarketWeapon",RSERV];
disableSerialization;
if(!(createDialog "life_weapon_shop")) exitWith {};
_priceTag = ((findDisplay 38400) displayCtrl 38404);
_priceTag ctrlSetStructuredText parseText "";
_itemList = ((findDisplay 38400) displayCtrl 38403);
lbClear _itemList;
ctrlSetText[38401,_shopTitle];
_config = [];
_listedItems = [];
//Go through weapons
if(primaryWeapon player != "") then {_config pushBack primaryWeapon player;};
if(secondaryWeapon player != "") then {_config pushBack secondaryWeapon player;};
if(handgunWeapon player != "") then {_config pushBack handgunWeapon player;};

//Go through items
_config = _config + primaryWeaponItems player;
_config = _config + (assignedItems player);
_config = _config + (uniformItems player);
_config = _config + (vestItems player);
_config = _config + (backPackItems player);

((findDisplay 38400) displayCtrl 38405) ctrlSetText localize "STR_Global_Sell";
ctrlShow [38402,true];

_itemArray = M_CONFIG(getArray,"WeaponShops","weaponBuy","items");
{
	if(!(_x in _listedItems) && _x != "") then {
		_iS = [_x,_itemArray] call TON_fnc_index;
		if(_iS != -1) then {
			if(!(EQUAL(SEL(SEL(_itemArray,_iS),2),-1))) then {
				_itemInfo = [_x] call life_fnc_fetchCfgDetails;
				_listedItems pushBack _x;
				_itemList lbAdd format["%1",_itemInfo select 1];
				_itemList lbSetData[(lbSize _itemList)-1,_itemInfo select 0];
				_itemList lbSetPicture[(lbSize _itemList)-1,_itemInfo select 2];
			};
		};
	};
} forEach _config;
