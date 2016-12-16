#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopSellSelection.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Checks the weapon & adds the price tag.
*/
private ["_control", "_index", "_priceTag", "_item", "_itemtmp", "_itemArray", "_price", "_stock", "_dispo", "_oldPrice","_weaponsTracking"];
disableSerialization;
_control = [_this,0,controlNull,[controlNull]] call BIS_fnc_param;
_index = [_this,1,-1,[0]] call BIS_fnc_param;
if(isNull _control) exitWith {closeDialog 0;}; //Bad data
if(_index isEqualTo -1) exitWith {}; //Nothing selected

_priceTag = CONTROL(38400,38404);
_item = CONTROL_DATAI(_control,_index);
_itemArray = M_CONFIG(getArray,"WeaponShops","weaponBuy","items");
_itemtmp = [_item,_itemArray] call TON_fnc_index;
_price = SEL(SEL(_itemArray,_itemtmp),2);
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
	_stock = 0;
	{
		if(SEL(_x,0) isEqualTo _item)exitWith {_stock = SEL(_x,1);};
	}foreach life_weaponMarketTrack;
}else
{
	_stock = 20;
};
_dispo = "Courant";
if((_stock >= 0) && (_stock < 3))then{
_oldPrice = _price;
_price=round(_price+(_price/4));
_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Prix Courant: %1$<br/>Prix (Rare +25%2): <t color='#8cff9b'>%3</t></t>",[(_oldPrice)] call life_fnc_numberText,"%",[(_price)] call life_fnc_numberText];
};

if((_stock >= 3) && (_stock < 25))then{
	_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Prix Courant: <t color='#8cff9b'>%1$</t></t>",[(_price)] call life_fnc_numberText];

};
if(_stock >= 25)then{
_oldPrice = _price;
_price=round(_price-(_price/100*15));
_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Prix Courant: %1$<br/>Prix (Surplus -15%2): %3</t></t>",[(_oldPrice)] call life_fnc_numberText,"%",[(_price)] call life_fnc_numberText];
};
_control lbSetValue[_index,_price];

