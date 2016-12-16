#include "..\..\script_macros.hpp"
/*
	File: fn_civInteractionMenu.sqf
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

private["_display","_curTarget","_prisonMarker","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_arrested"];

disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
_arrested = param [1,false,[false]];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target
if(license_civ_chasseur)then
{
	_arrested = if(_arrested && (_curTarget getVariable ["ActiveWanted",false]))then{true}else{false};
};
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
_Btn8 ctrlShow false;

//Set Repported Button
_Btn0 ctrlShow false;

//Set Unrestrain Button
_Btn1 ctrlSetText localize "STR_pInAct_Unrestrain";
_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_unrestrainCiv; closeDialog 0;";

//Set Escort Button
if((_curTarget getVariable["Escorting",false])) then {
	_Btn2 ctrlSetText localize "STR_pInAct_StopEscort";
	_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_stopEscorting; [life_pInact_curTarget] call life_fnc_civInteractionMenu;";
} else {
	_Btn2 ctrlSetText localize "STR_pInAct_Escort";
	_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_escortAction; closeDialog 0;";
};

_Btn3 ctrlSetText localize "STR_pInAct_PutInCar";
_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_putInCar;";

	
_Btn4 ctrlSetText "Donner Argent";
_Btn4 buttonSetAction "closeDialog 0;[] spawn life_fnc_moneyMenu;";

//Set Check Licenses Button
_Btn5 ctrlSetText "Donner Clefs";
_Btn5 buttonSetAction "closeDialog 0;[true] spawn life_fnc_keyMenu;";

//Set Search Button
_Btn6 ctrlSetText "Donner Objets";
_Btn6 buttonSetAction "closeDialog 0;[] spawn life_fnc_giveMenu;";



if(license_civ_chasseur) then {
	_Btn7 ctrlSetText localize "STR_pInAct_Arrest";
	_Btn7 buttonSetAction "[life_pInact_curTarget, 20] call life_fnc_arrestAction;";
	_Btn7 ctrlShow true;
	if((player distance (getMarkerPos "jail_marker") < 150) OR (player distance (getMarkerPos "police_hq_1") < 30) OR  (player distance (getMarkerPos "police_hq_2") < 30) OR (player distance (getMarkerPos "cop_spawn_3") < 30) OR (player distance (getMarkerPos "cop_spawn_5") < 30)) then  {
		_Btn7 ctrlEnable true;
	}else
	{
		_Btn7 ctrlEnable false;
		
	};
	
}else{
	_Btn7 ctrlShow false;
	if(playerSide isEqualTo independent)then
	{
		if((FETCH_CONST(life_medicLevel)) isEqualTo 2)then
		{
			_Btn7 ctrlSetText "Facture";
			_Btn7 buttonSetAction "closeDialog 0; [life_pInact_curTarget] call life_fnc_showBillDialog;";
			_Btn7 ctrlEnable true;
			_Btn7 ctrlShow true;
		};
	};
	if(_arrested)then
	{
		//Set Check Licenses Button
		_Btn7 ctrlSetText localize "STR_pInAct_checkIdentite";
		_Btn7 buttonSetAction "[player] remoteExecCall [""life_fnc_licenseCheck"",life_pInact_curTarget];";
		_Btn7 ctrlEnable true;
		_Btn7 ctrlShow true;
	};
};
if((FETCH_CONST(life_coplevel) > 3) ||  (FETCH_CONST(life_adminlevel) > 0))then {
	//Set Search Button
	_Btn8 ctrlSetText "Prison Troll";
	_Btn8 buttonSetAction "closeDialog 0;[life_pInact_curTarget] call life_fnc_arrestTrollAction;";
	_Btn8 ctrlShow true;
};
if(!_arrested)then
{
	_Btn1 ctrlShow false;
	_Btn2 ctrlShow false;
	_Btn3 ctrlShow false;
};
