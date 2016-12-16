#include "..\..\script_macros.hpp"
/*
	File: fn_bankTransfer.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Figure it out again.
*/
private["_val","_unit","_tax"];
_val = parseNumber(ctrlText 2702);
_unit = call compile format["%1",(lbData[2703,(lbCurSel 2703)])];
if(isNull _unit) exitWith {};
if((lbCurSel 2703) isEqualTo -1) exitWith {[localize "STR_ATM_NoneSelected"] call life_fnc_showNotification;};
if(isNil "_unit") exitWith {[localize "STR_ATM_DoesntExist"] call life_fnc_showNotification;};
if(_val > 999999) exitWith {[localize "STR_ATM_TransferMax"] call life_fnc_showNotification;};
if(_val < 0) exitwith {};
if(!([str(_val)] call life_fnc_isnumeric)) exitWith {[localize "STR_ATM_notnumeric"] call life_fnc_showNotification;};
if(_val > life_KavaBank) exitWith {[localize "STR_ATM_NotEnough"] call life_fnc_showNotification;};
_tax = round(_val / 15);
if((_val + _tax) > life_KavaBank) exitWith {[format[localize "STR_ATM_SentMoneyFail",_val,_tax]] call life_fnc_showNotification;};

life_KavaBank = life_KavaBank - (_val + _tax);

[_val,profileName] remoteExecCall ["life_fnc_wireTransfer",_unit];
[] call life_fnc_atmMenu;
[format[localize "STR_ATM_SentMoneySuccess",[_val] call life_fnc_numberText,_unit getVariable["realname",name _unit],[_tax] call life_fnc_numberText]] call life_fnc_showNotification;
[1] call SOCK_fnc_updatePartial;
[format["[BANKTRANS] %1(%2) -BANK AVANT: %3 -MONTANT.TTC: %4 -TAX: %5 -CIBLE: %6(%7) -BANK APRES: %8", name player, getPlayerUID player, [BANK + (_val + _tax)] call life_fnc_numberText,[_val] call life_fnc_numberText,_tax ,_unit getVariable["realname",name _unit], getPlayerUID _unit,[BANK] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];