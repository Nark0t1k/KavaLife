#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopMenu.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Something
*/
private["_shopSide","_shopSide","_license","_itemInfo","_itemList","_license","_flag","_exit","_level","_levelAssert","_levelName","_levelType","_levelValue","_levelMsg","_posList","_nbrOwner","_hideout","_group"];
_exit = false;
_shopTitle = M_CONFIG(getText,"WeaponShops",(SEL(_this,3)),"name");
_shopSide = M_CONFIG(getText,"WeaponShops",(SEL(_this,3)),"side");
_license = M_CONFIG(getText,"WeaponShops",(SEL(_this,3)),"license");
_levelAssert = M_CONFIG(getArray,"WeaponShops",(SEL(_this,3)),"level");
_levelName = SEL(_levelAssert,0);
_levelType = SEL(_levelAssert,1);
_levelValue = SEL(_levelAssert,2);
_levelMsg = SEL(_levelAssert,3);
[player] remoteExecCall ["TON_fnc_askMarketWeapon",RSERV];
if((SEL(_this,3)) in ["gun","rebel","gangShop","mercenaire"])then{sleep (random 1);};
if(!(EQUAL(_shopSide,""))) then {
	_flag = switch(playerSide) do {case west:{"cop"}; case civilian:{"civ"}; case independent:{"med"};};
	if(playerSide isEqualTo independent) then
	{
		if((FETCH_CONST(life_medicLevel)) in [0,1]) exitWith {_flag="med";};
		if((FETCH_CONST(life_medicLevel)) isEqualTo 2) exitWith {_flag="mecano";};
		if((FETCH_CONST(life_medicLevel)) isEqualTo 3) exitWith {_flag="merce";};
		if((FETCH_CONST(life_medicLevel)) isEqualTo 4) exitWith {_flag="conces";};
	};
	if(!(EQUAL(_flag,_shopSide))) then {_exit = true;};
};
if(_exit) exitWith {};

if(!(EQUAL(_license,""))) then {
	_flag = M_CONFIG(getText,"Licenses",_license,"side");
	if(!(LICENSE_VALUE(_license,_flag))) exitWith {hint localize "STR_Shop_Veh_NoLicense"; _exit = true;};
};
if(_exit) exitWith {};

if(!(EQUAL(_levelValue,-1))) then {
	_level = GVAR_MNS _levelName;
	if(typeName _level isEqualTo typeName {}) then {_level = FETCH_CONST(_level);};

	_flag = switch(_levelType) do {
		case "SCALAR": {_level >= _levelValue};
		case "BOOL": {_level};
		case "EQUAL": {EQUAL(_level,_levelValue)};
		default {false};
	};
	if(!(_flag)) then {
		_exit = true;
		if(EQUAL(_levelMsg,"")) then {
			_levelMsg = (localize "STR_Shop_Veh_NotAllowed");
		};
	};
};
if(_exit) exitWith {hint _levelMsg;};

uiNamespace setVariable ["Weapon_Shop",SEL(_this,3)];
uiNamespace setVariable["Weapon_Magazine",0];
uiNamespace setVariable["Weapon_Accessories",0];
uiNamespace setVariable["Magazine_Array",[]];
uiNamespace setVariable["Accessories_Array",[]];

if(!(createDialog "life_customweapon_shop")) exitWith {};
if(!isClass(missionConfigFile >> "WeaponShops" >> (SEL(_this,3)))) exitWith {}; //Bad config entry.

if((SEL(_this,3)) isEqualTo "gangShop") then
{
	_nbrOwner = 0;
	{
		if((_x getVariable ["gangOwnerName",""]) isEqualTo (player getVariable "gang_name"))then {_nbrOwner = _nbrOwner + 1;};
	}foreach [gang_obj_1,gang_obj_2,gang_obj_3];
	life_gangAreaOwner = _nbrOwner;
};



disableSerialization;

ctrlSetText[39501,_shopTitle];

// _filters = ((findDisplay 38400) displayCtrl 38402);
// lbClear _filters;

if((uiNamespace getVariable ["Weapon_Shop",""]) in ["gun","rebel","gangShop","mercenaire"])then
{

ctrlEnable [39506,false];
ctrlEnable [39507,true];
ctrlEnable [39508,true];
}else
{
	ctrlShow [39506,false];
	ctrlShow [39507,false];
	ctrlShow [39508,false];
};
// _filters lbAdd localize "STR_Shop_Weapon_ShopInv";
// _filters lbAdd localize "STR_Shop_Weapon_YourInv";

// _filters lbSetCurSel 0;
0 call life_fnc_weaponShopFilter