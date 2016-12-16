#include "..\..\script_macros.hpp"
/*
	File: fn_uberConfirm.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Spawns the player where he selected.
*/
disableSerialization;
private ["_price", "_dis", "_bank", "_data", "_action", "_timer", "_startPos"];

_price = 0;
_dis = 0;
_bank = false;
_data = life_uberInfo;
_action=false;
if(vehicle player != player)exitWith {hint parseText "Pourquoi commander un taxi si tu as deja un vehicule?";};
if(life_is_processing)exitWith {hint parseText "Tu as déja commandé un Taxi recement";};
_action = [
"Attention le taxi va démarrer si vous partez vous devrez payer des frais!",
"Commande Taxi",
"OK",
"Annuler"
] call BIS_fnc_guiMessage;
if(!_action)exitWith{};
if(life_inv_cartevisa != 0) then
{
	_action = [
	"Acheter le bien par carte bancaire?",
	"Carte bancaire",
	"Oui",
	"Non"
	] call BIS_fnc_guiMessage;
	if(_action) then {_bank=true;}else{_bank=false;};
};

_dis = round((getMarkerPos (SEL(_data,0))) distance (getPosWorld player));
_price = round(2 * _dis);

if(_bank && (life_KavaBank < _price))exitWith {life_is_processing = false;hint parseText format["Le <t color='#8cff9b'>Taxi</t> n'est pas venu, tu n'avais pas l'argent nécessaire sur ton compte!<br/> Tu avais besoin de <t color='#08abc4'>%1$</t>.",[_price] call life_fnc_numberText];}; 
if(!_bank && (life_KavaCash < _price))exitWith {life_is_processing = false;hint parseText format["Le <t color='#8cff9b'>Taxi</t> n'est pas venu, tu n'avais pas l'argent nécessaire en cash!<br/> Tu avais besoin de <t color='#08abc4'>%1$</t>.",[_price] call life_fnc_numberText];}; 


_timer = round(_dis/100);
if(_timer < 30)then{_timer = 30;};

closeDialog 0;
_startPos = getPosWorld player;
hint parseText format["Tu viens de commander un <t color='#8cff9b'>Taxi</t> à destination de <t color='#8cff9b'>%1</t>.<br/> Celui ci arrivera dans<t color='#08abc4'>%2 </t>secondes.<br/>Merci de rester dans les 15m et de prévoir la somme de %3$ pour la course.",(SEL(_data,1)),_timer,[_price] call life_fnc_numberText];
life_is_processing = true;

sleep _timer/2;
hint parseText "Le taxi est a mi chemin reste la ou tu la appele.";
sleep _timer/2;
if((player getVariable ["restrained",FALSE]) OR (player getVariable ["restrainedciv",FALSE]) OR (player getVariable ["Escorting",FALSE]) OR (player getVariable ["transporting",FALSE]) OR (life_is_arrested) OR (life_istazed) OR (life_isknocked))exitWith {hint parseText "Le taxi est arrivé mais vu la situation est repartit aussi tot";};
if((player getVariable ["restrained",FALSE]) OR (player getVariable ["restrainedciv",FALSE]) OR (player getVariable ["Escorting",FALSE]) OR (player getVariable ["transporting",FALSE]) OR (life_is_arrested) OR (life_istazed) OR (life_isknocked))exitWith {hint parseText "Le taxi est arrivé mais vu la situation est repartit aussi tot";};
if(round(_startPos distance (getPosWorld player)) > 15) exitWith
{
	_price = round(_price/5);
	hint parseText format["Le <t color='#8cff9b'>Taxi</t> est arrivé mais tu n'était plus la!.<br/> La somme de <t color='#08abc4'>%1$</t> à été prélevé de ton compte en banque pour le déplacement.",[_price] call life_fnc_numberText];
	if(life_KavaBank < _price)then 
	{
		life_KavaBank = 0;
	}else
	{
		SUB(life_KavaBank,_price);
	};
	life_is_processing = false;
};

if(_bank && (life_KavaBank < _price))exitWith {life_is_processing = false;hint parseText format["Le <t color='#8cff9b'>Taxi</t> est arrivé mais tu n'avais plus l'argent nécessaire sur ton compte!<br/> Tu avais besoin de <t color='#08abc4'>%1$</t>.",[_price] call life_fnc_numberText];}; 
if(!_bank && (life_KavaCash < _price))exitWith {life_is_processing = false;hint parseText format["Le <t color='#8cff9b'>Taxi</t> est arrivé mais tu n'avais plus l'argent nécessaire en cash!<br/> Tu avais besoin de <t color='#08abc4'>%1$</t>.",[_price] call life_fnc_numberText];}; 
if(vehicle player != player)exitWith {hint parseText "Pourquoi commander un taxi si tu as deja un vehicule?";};
disableUserInput true;
titleText ["", "BLACK OUT"];
sleep 2;
player setPos (getMarkerPos (SEL(_data,0)));
titleText ["", "BLACK IN"];
disableUserInput false;
sleep 2;
hint parseText format["Le <t color='#8cff9b'>Taxi</t> est amené à destination.<br/> Tu as payé la somme de <t color='#8cff9b'>%1$</t> pour la course.",[_price] call life_fnc_numberText];
if(_bank)then
{
	if(life_KavaBank < _price)then 
	{
		life_KavaBank = 0;
	}else
	{
		SUB(life_KavaBank,_price);
	};
}else
{
	if(life_KavaCash < _price)then 
	{
		life_KavaCash = 0;
	}else
	{
		SUB(life_KavaCash,_price);
	};
	[] call life_fnc_p_updateMenu;
};
[6] call SOCK_fnc_updatePartial;
sleep 60;
life_is_processing = false;
