#include "..\..\script_macros.hpp"
/*
	File : containerMenu.sqf
	Author: NiiRoZz

	Description:
	Container interaction menu
*/
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457
#define Title 37401

private["_container","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7"];
disableSerialization;
_container = param [0,ObjNull,[ObjNull]];
if(isNull _container) exitWith {}; //Bad target

if(!dialog) then {
	createDialog "pInteraction_Menu";
};

_Btn1 = CONTROL(37400,Btn1);
_Btn2 = CONTROL(37400,Btn2);
_Btn3 = CONTROL(37400,Btn3);
_Btn4 = CONTROL(37400,Btn4);
_Btn5 = CONTROL(37400,Btn5);
_Btn6 = CONTROL(37400,Btn6);
_Btn7 = CONTROL(37400,Btn7);
{_x ctrlShow false;} foreach [_Btn1,_Btn2,_Btn3,_Btn4,_Btn5,_Btn6,_Btn7];

life_pInact_container = _container;
if(playerSide isEqualTo west) then {
	_Btn1 ctrlSetText localize "STR_vInAct_SearchContainer";
	_Btn1 buttonSetAction "[life_pInact_container] spawn life_fnc_containerInvSearch; closeDialog 0;";
	_Btn1 ctrlShow true;
} else {
	_Btn1 ctrlSetText localize "STR_pInAct_RemoveContainer";
	_Btn1 buttonSetAction "[life_pInact_container] spawn life_fnc_removeContainer; closeDialog 0;";
	_Btn1 ctrlShow true;
	
	if(SEL(_container getVariable "container_owner",0) != getPlayerUID player) then {
		_Btn1 ctrlEnable false;
	};
	
	if((typeOf _container) in ["Land_Sink_F"])then
	{
		_Btn2 ctrlSetText localize "STR_pInAct_ActiveIllegalBox";
		_Btn2 buttonSetAction "[life_pInact_container,0] spawn life_fnc_activeIllegalBox; closeDialog 0;";
		_Btn2 ctrlShow true;
		if(!isNil {(_curTarget getVariable "mining")} OR !local _curTarget && {_curTarget in life_vehicles}) then {
			_Btn2 ctrlEnable false;
		} else {
			_Btn2 ctrlEnable true;
		};
	};
	if((typeOf _container) in ["CargoNet_01_barrels_F"])then
	{
		_Btn2 ctrlSetText localize "STR_pInAct_ActiveIllegalBox";
		_Btn2 buttonSetAction "[life_pInact_container,1] spawn life_fnc_activeIllegalBox; closeDialog 0;";
		_Btn2 ctrlShow true;
		if(!isNil {(_curTarget getVariable "mining")} OR !local _curTarget && {_curTarget in life_vehicles}) then {
			_Btn2 ctrlEnable false;
		} else {
			_Btn2 ctrlEnable true;
		};
	};
	
};
