#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopSelection.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Checks the weapon & adds the price tag.
*/
private ["_nbrMeca","_control", "_index", "_shop", "_priceTag", "_moneySymbol", "_gFund", "_item", "_classname", "_price", "_reduc", "_stock", "_pictureItem", "_mags", "_itemArray", "_accs", "_weaponArray", "_slotArray", "_weaponsTracking"];
disableSerialization;
_control = [_this,0,controlNull,[controlNull]] call BIS_fnc_param;
_index = [_this,1,-1,[0]] call BIS_fnc_param;
_shop = uiNamespace getVariable ["Weapon_Shop",""];
if(isNull _control) exitWith {closeDialog 0;}; //Bad data
if(_index isEqualTo -1) exitWith {}; //Nothing selected

_priceTag = CONTROL(39500,39504);

if(_shop isEqualTo "gangShop")then
{
	_moneySymbol = "K$";
	_gFund = GANG_FUNDS;
}else
{
	_moneySymbol = "€";
};

_item = CONTROL_DATAI(_control,_index);
_classname = _item;

_price = _control lbValue _index;

_reduc = 0;
_item = CONTROL_DATAI(_control,_index);
_stock = 0;
_nbrMeca = 0;
_weaponsTracking  = 
[
	"arifle_SDAR_F",
	"hgun_PDW2000_F",
	"hgun_Rook40_F",
	"hgun_ACPC2_F",
	"hgun_Pistol_heavy_01_F",
	"hgun_Pistol_heavy_02_F",
	"SMG_02_F",
	"srifle_LRR_camo_F",
	"srifle_EBR_F",
	"arifle_Katiba_F",
	"arifle_MX_F",
	"LMG_Mk200_F",
	"arifle_TRG21_F",
	"arifle_Mk20_plain_F",
	"srifle_DMR_03_woodland_F",
	"srifle_DMR_06_camo_F",
	"srifle_GM6_F",
	"arifle_Mk20C_F",
	"arifle_MX_Black_F",
	"arifle_MXM_Black_F",
	"arifle_MX_SW_Black_F",
	"srifle_LRR_F",
	"srifle_DMR_06_olive_F",
	"srifle_DMR_03_khaki_F",
	"arifle_AKM_F",
	"arifle_SPAR_03_snd_F",
	"arifle_AKS_F",
	"arifle_CTAR_hex_F"
];
if((_item in _weaponsTracking) && (playerSide isEqualTo civilian))then
{
	{
		if(SEL(_x,0) == _item)exitWith {_stock = SEL(_x,1);};
	}foreach life_weaponMarketTrack;
	if(_stock < 1)then
	{	
		CONTROL(39500,39505) ctrlEnable false;
	}else
	{
		CONTROL(39500,39505) ctrlEnable true;
	};
}else
{
	if(_item isEqualTo "ToolKit") then
	{
		_nbrMeca = {(str _x in life_listMecano) && (alive _x) && (side _x isEqualTo independent)} count playableUnits;
		if(_nbrMeca > 0) then
		{
			_stock = "SurTax Mecano +100%";
			_price = round(_price*2);
		}else
		{
			_stock = "Illimité";
		};
	}else
	{
		_stock = "Illimité";
	};
	CONTROL(39500,39505) ctrlEnable true;
};
if(_shop isEqualTo "gangShop")then
{
	if(life_gangAreaOwner != 0) then
	{
		_reduc = life_gangAreaOwner*10;
		_price = _price-(round(_price/100*_reduc));
	};
	if(_price > _gFund) then {
		_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Prix: <t color='#ff0000'>%1</t><br/>Manque: <t color='#8cff9b'>%2%4</t></t><br/>Stock: %3",[(_price)] call life_fnc_numberText,[(_price - _gFund)] call life_fnc_numberText,_stock,_moneySymbol];
		CONTROL(39500,39505) ctrlEnable false;
	} else {
		_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Prix: <t color='#8cff9b'>%1%5 Reduction: %2%3</t></t><br/>Stock: %4",[(_price)] call life_fnc_numberText,_reduc,"%",_stock,_moneySymbol];
		CONTROL(39500,39505) ctrlEnable true;
	};
}else
{
	if(_price > life_KavaCash) then {
		_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Prix: <t color='#ff0000'>%1</t><br/>Manque: <t color='#8cff9b'>%2%4</t></t><br/>Stock: %3",[(_price)] call life_fnc_numberText,[(_price - life_KavaCash)] call life_fnc_numberText,_stock,_moneySymbol];
		CONTROL(39500,39505) ctrlEnable false;
	} else {
		_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Prix: <t color='#8cff9b'>%1%2</t></t><br/>Stock: %3",[(_price)] call life_fnc_numberText,_moneySymbol,_stock];
		CONTROL(39500,39505) ctrlEnable true;
	};
};

_pictureItem = (getText (configFile >> 'CfgWeapons' >> _classname >> 'picture'));
((findDisplay 39500) displayCtrl 39509) ctrlSetText _pictureItem;
if(isClass (configFile >> "CfgWeapons" >> _item)) then {
	//Magazines menu
	if(isArray (configFile >> "CfgWeapons" >> _item >> "magazines")) then {
		_mags = [];
		{
			_mags pushBack (_x select 0);
			true;
		} count M_CONFIG(getArray,"WeaponShops",_shop,"mags");
		_itemArray = FETCH_CONFIG2(getArray,"CfgWeapons",_item,"magazines");
		if(count (_itemArray ArrayIntersect _mags) > 0) then {
			((findDisplay 39500) displayCtrl 39507) ctrlEnable true;
		} else {
			((findDisplay 39500) displayCtrl 39507) ctrlEnable false;
		};
	} else {
		((findDisplay 39500) displayCtrl 39507) ctrlEnable false;
	};

	//Accessories Menu
	if(isClass (configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo")) then {
		private["_slotArray","_weaponArray","_accs"];
		_accs = [];
		{
			_accs pushBack (_x select 0);
		} forEach M_CONFIG(getArray,"WeaponShops",_shop,"accs");
		_weaponArray = [];
		if(isArray (configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems")) then {
			_slotArray = FETCH_CONFIG3(getArray,"CfgWeapons",_item,"WeaponSlotsInfo","CowsSlot","compatibleItems");
			{
				_weaponArray pushBack _x;
			} forEach _slotArray;
		};
		if(isArray (configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")) then {
			_slotArray = FETCH_CONFIG3(getArray,"CfgWeapons",_item,"WeaponSlotsInfo","MuzzleSlot","compatibleItems");
			{
				_weaponArray pushBack _x;
			} forEach _slotArray;
		};
		if(isArray (configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems")) then {
			_slotArray = FETCH_CONFIG3(getArray,"CfgWeapons",_item,"WeaponSlotsInfo","PointerSlot","compatibleItems");
			{
				_weaponArray pushBack _x;
			} forEach _slotArray;
		};
		if(isArray (configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems")) then {
			_slotArray = FETCH_CONFIG3(getArray,"CfgWeapons",_item,"WeaponSlotsInfo","UnderBarrelSlot","compatibleItems");
			{
				_weaponArray pushBack _x;
			} forEach _slotArray;
		};
		if(count (_weaponArray ArrayIntersect _accs) > 0) then {
			((findDisplay 39500) displayCtrl 39508) ctrlEnable true;
		} else {
			((findDisplay 39500) displayCtrl 39508) ctrlEnable false;
		};
	} else {
		((findDisplay 39500) displayCtrl 39508) ctrlEnable false;
	};
};