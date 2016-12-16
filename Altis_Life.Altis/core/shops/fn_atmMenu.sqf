#include "..\..\script_macros.hpp"
/*
	File: fn_atmMenu.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Opens and manages the bank menu.
*/
private["_units","_type"];
if(!life_use_atm) exitWith {
	hint format [localize "STR_Shop_ATMRobbed",(LIFE_SETTINGS(getNumber,"noatm_timer"))];
};
if(dialog)then
{
	closeDialog 0;
};
if(!dialog) then {
	if(!(createDialog "Life_atm_management")) exitWith {};
};

disableSerialization;
_units = CONTROL(2700,2703);

lbClear _units;
CONTROL(2700,2701) ctrlSetStructuredText parseText format["<img size='1.7' image='icons\ico_bank.paa'/> %1€<br/><img size='1.6' image='icons\ico_money.paa'/> %2€",[life_KavaBank] call life_fnc_numberText,[life_KavaCash] call life_fnc_numberText];

{
	_name = _x getVariable ["realname",name _x];
	if(alive _x && (!(EQUAL(_name,profileName)))) then {
		switch (side _x) do {
			case west: {_type = "Cop"};
			case civilian: {_type = "Civ"};
			case independent: {
				if(str _x in life_listMedic) exitWith {_type="Medecin";};
				if(str _x in life_listMecano) exitWith {_type="Mecano";};
				if(str _x in life_listMerce) exitWith {_type="Merce";};
				if(str _x in life_listConces) exitWith {_type="Conces";};
			};
		};
		_units lbAdd format["%1 (%2)",_x getVariable ["realname",name _x],_type];
		_units lbSetData [(lbSize _units)-1,str(_x)];
	};
	true;
} count playableUnits;

lbSetCurSel [2703,0];

if(isNil {(player getVariable "gang_name")}) then {
	(CONTROL(2700,2705)) ctrlEnable false;
	(CONTROL(2700,2706)) ctrlEnable false;
};
if(life_inv_cartevisa != 0) then {(CONTROL(2700,2707)) ctrlEnable false;};
