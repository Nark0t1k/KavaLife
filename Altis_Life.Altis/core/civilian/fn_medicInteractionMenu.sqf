#include "..\..\script_macros.hpp"
/*
	File: fn_medicInteractionMenu.sqf
	Author: Bryan "Tonic" Boardwine
*/
#define Btn0 37449
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457
#define Title 37401

private["_display","_curTarget","_prisonMarker","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7"];

disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target

if(!dialog) then {
	createDialog "pInteraction_Menu";
};
	
if(!isPlayer _curTarget && side _curTarget isEqualTo civilian) exitWith {closeDialog 0;}; //Bad side check?
if(player distance _curTarget > 4 ) exitWith {closeDialog 0;}; // Prevents menu accessing from far distances.

_display = findDisplay 37400;
_Btn0 = _display displayCtrl Btn0;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
life_pInact_curTarget = _curTarget;

_Btn0 ctrlShow false;
_Btn1 ctrlShow false;
_Btn2 ctrlShow false;

//Set Repair Atele Button
// _Btn1 ctrlSetText "Atele";
// _Btn1 buttonSetAction "[player] remoteExec [""life_fnc_fixBrokenLeg"",life_pInact_curTarget];closeDialog 0;";
// if(life_inv_atele != 0)then{_Btn1 ctrlEnable true}else{_Btn1 ctrlEnable false};

//Set Search Button
// _Btn2 ctrlSetText "Poche de Sang";
// _Btn2 buttonSetAction "[player] remoteExec [""life_fnc_fixBloodPack"",life_pInact_curTarget];closeDialog 0;";
// if(life_inv_transpack != 0)then{_Btn2 ctrlEnable true}else{_Btn2 ctrlEnable false};

_Btn4 ctrlSetText "Donner Argent";
_Btn4 buttonSetAction "closeDialog 0;[] spawn life_fnc_moneyMenu;";

//Set Check Licenses Button
_Btn5 ctrlSetText "Donner Clefs";
_Btn5 buttonSetAction "closeDialog 0;[true] spawn life_fnc_keyMenu;";

//Set Search Button
_Btn6 ctrlSetText "Donner Objets";
_Btn6 buttonSetAction "closeDialog 0;[] spawn life_fnc_giveMenu;";


if(playerSide != independent)then
{
	if((FETCH_CONST(life_medicLevel)) != 1)then
	{
		_Btn1 ctrlShow false;
		_Btn2 ctrlShow false;
	};
};
_Btn3 ctrlShow false;
_Btn7 ctrlShow false;
_Btn8 ctrlShow false;
if((FETCH_CONST(life_coplevel) > 3) ||  (FETCH_CONST(life_adminlevel) > 0))then {
	//Set Search Button
	_Btn8 ctrlSetText "Prison Troll";
	_Btn8 buttonSetAction "closeDialog 0;[life_pInact_curTarget] call life_fnc_arrestTrollAction;";
	_Btn8 ctrlShow true;
};
