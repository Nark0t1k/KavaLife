#include "..\..\script_macros.hpp"
/*
	File: fn_processActionWhiteList.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Master handling for processing an item.
*/
private ["_nbrTransfo", "_vendor", "_upp", "_ui", "_progress", "_pgText", "_cP"];
if(!(life_WhiteList select 1)) exitWith {hint parseText "Tu n'as pas finit l'etapes du questionnaire.";};
_nbrTransfo = life_WhiteList select 2;
// if(_nbrTransfo > 4)exitWith {hint parseText "Tu as finit cette etapes";};
//Ignored Special Variables: _this, _x.
_vendor = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_upp = localize "STR_Process_Dechet";

//Error check
if(isNull _vendor OR (player distance _vendor > 10)) exitWith {};
if (life_inv_dechet < 10) exitWith {life_is_processing = false;hint parseText "Tu as besoins de 10Kg de dechet pour traiter";};

//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = GVAR_UINS "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

life_is_processing = true;

while{true} do {
	sleep  0.58;
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(player distance _vendor > 10) exitWith {};
};
if(player distance _vendor > 10) exitWith {[localize "STR_Process_Stay"] call life_fnc_showNotification; 5 cutText ["","PLAIN"]; life_is_processing = false;};

if(!([false,"dechet",10] call life_fnc_handleInv))exitWith {hint parseText "<t size='1.1'>Tu n'as plus les ressources a transformer.</t>";};

5 cutText ["","PLAIN"];
life_is_processing = false;
_nbrTransfo = _nbrTransfo + 1;
hint parseText format["<t size='1.1'>Tu as traité 10kg de déchet. Tu as realise %1/5 traitement nécessaire et gagné 2.500$</t>", _nbrTransfo];
if(_nbrTransfo > 4)then
{
	life_WhiteList=[true,true,_nbrTransfo];
	[false,"dechet",life_inv_dechet] call life_fnc_handleInv;
	ADD(life_KavaCash,5000);
	hint parseText "<t size='1.1'>Tu as terminer de recolter tu as gagné 3.000$ va maintenant parler au NPC du Marche.</t>";
}else
{
	ADD(life_KavaCash,2500);
	life_WhiteList=[false,true,_nbrTransfo];
};
[] call life_fnc_hudUpdate;

