#include "..\..\script_macros.hpp"
/*
	File: fn_hudVehHealthUpdate.sqf
	Author: Daniel Stuart

	Description:
	Updates the HUD when it needs to.
*/
disableSerialization;
_vehicle = (vehicle player);
if(_vehicle isEqualTo player) exitWith {};
if(!life_showVehHealth) exitWith {};
if(isNull LIFEVehHealthdisplay) then {[] call life_fnc_hudVehHealthSetup;};

private["_fullList","_array1","_array2","_array3","_nbrPart","_u","_part","_damage","_partName"];

_fullList = getAllHitPointsDamage _vehicle;
_array1 = _fullList select 0;
_array2 = _fullList select 1;
_array3 = _fullList select 2;
_partName = "";
_nbrPart = count _array1;
_nbrPart = _nbrPart - 1;

_mess = "<t size='0.8' align='center'><t color='#ff0000'>Etat Vehicule</t><br/>";
_damage = getdammage _vehicle;
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


_mess = _mess + format["Etat: <t color='%1'>%2 HP</t><br/>",_color, _damage];


for "_i" from 0 to _nbrPart do {
	
	if(_i > _nbrPart) exitWith {};
	_part = _array1 select _i;
	if(_part in ["HitLFWheel","HitLF2Wheel","HitRFWheel","HitRF2Wheel","HitFuel","HitEngine","HitBody","HitHull","HitAvionics","HitHRotor","HitVRotor","HitTransmission","HitGear"]) then
	{
		_damage = _array3 select _i;
		_damage = round(_damage*100);
		
		switch(_part)do
		{
			case "HitLFWheel": {_partName = "Pneu AV.G: ";};
			case "HitLF2Wheel": {_partName = "Pneu AR.G: ";};
			case "HitRFWheel": {_partName = "Pneu AV.D: ";};
			case "HitRF2Wheel": {_partName = "Pneu AR.D: ";};
			case "HitFuel": {_partName = "Reservoir: ";};
			case "HitEngine": {_partName = "Moteur: ";};
			case "HitBody": {_partName = "Carrosserie: ";};
			case "HitHull": {_partName = "Coque: ";};
			case "HitAvionics": {_partName = "Fuselage: ";};
			case "HitHRotor": {_partName = "Rotor P: ";};
			case "HitVRotor": {_partName = "Rotor S: ";};
			case "HitTransmission": {_partName = "Rotor S: ";};
			case "HitGear": {_partName = "Equipement: ";};
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
};

LIFEVehHealthctrl(9650) ctrlSetStructuredText parseText (_mess);