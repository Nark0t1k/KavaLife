#include "..\..\script_macros.hpp"
/*
	File: fn_hudUpdate.sqf
	Author: Daniel Stuart

	Description:
	Updates the HUD when it needs to.
*/
disableSerialization;

if(!life_showHealth) exitWith {};
if(isNull LIFEHealthdisplay) then {[] call life_fnc_hudHealthSetup;};

private["_fullList","_array1","_array2","_array3","_nbrPart","_u","_part","_damage","_partName"];
_fullList = getAllHitPointsDamage player;
_array1 = _fullList select 0;
_array2 = _fullList select 1;
_array3 = _fullList select 2;
_partName = "";

_mess = "<t size='0.8' align='center'><t color='#ff0000'>Etat de Santé</t><br/>";
_damage = getdammage player;
_damage = (1-_damage)*100;
_damage = round(_damage);

_color = switch(true)do
{
	case (_damage < 15): {"#FA0000"};
	case (_damage < 25): {"#FA8E00"};
	case (_damage < 50): {"#FAC800"};
	case (_damage < 75): {"#FAFA00"};
	default {"#00FE19"};
};


_mess = _mess + format["Santé: <t color='%1'>%2 HP</t><br/>",_color, _damage];

for "_i" from 0 to 10 do {
	
	if(_i > 10) exitWith {};
	_part = _array1 select _i;
	_damage = _array3 select _i;
	_damage = round(_damage*100);
	
	switch(_part)do
	{
		case "HitFace": {_partName = "Visage: ";};
		case "HitNeck": {_partName = "Cou: ";};
		case "HitHead": {_partName = "Tête: ";};
		case "HitPelvis": {_partName = "Bassin: ";};
		case "HitAbdomen": {_partName = "Abdomen: ";};
		case "HitDiaphragm": {_partName = "Diaphragme: ";};
		case "HitChest": {_partName = "Poitrine: ";};
		case "HitBody": {_partName = "Corps: ";};
		case "HitArms": {_partName = "Bras: ";};
		case "HitHands": {_partName = "Mains: ";};
		case "HitLegs": {_partName = "Jambes: ";};
		default {_partName = "ERROR";};
	};
	
	_color = switch(true)do
	{
		case (_damage isEqualTo 100): {"#FA0000"};
		case (_damage > 75): {"#FA8E00"};
		case (_damage > 50): {"#FAC800"};
		case (_damage > 25): {"#FAFA00"};
		default {"#00FE19"};
	};
	
	_mess  = _mess + _partName + format["<t color='%1'>%2 %3</t><br/>",_color,_damage,"%"];	
	
};

LIFEHealthctrl(9600) ctrlSetStructuredText parseText (_mess);