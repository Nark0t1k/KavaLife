#include "..\..\script_macros.hpp"
/*
	File: fn_bankWithdraw.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Withdraws money from the players account
*/
private["_val"];
_val = parseNumber(ctrlText 2702);
if(_val > 999999) exitWith {[localize "STR_ATM_WithdrawMax"] call life_fnc_showNotification;};
if(_val < 0) exitwith {};
if(!([str(_val)] call life_fnc_isnumeric)) exitWith {[localize "STR_ATM_notnumeric"] call life_fnc_showNotification;};
if(_val > life_KavaBank) exitWith {[localize "STR_ATM_NotEnoughFunds"] call life_fnc_showNotification;};
if(_val < 100 && life_KavaBank > 20000000) exitWith {[localize "STR_ATM_WithdrawMin"] call life_fnc_showNotification;}; //Temp fix for something.
if((time - life_action_delay) < 2) exitWith {hint localize "STR_NOTF_ActionDelay";};
life_action_delay = time;
ADD(life_KavaCash,_val);
SUB(life_KavaBank,_val);
[format [localize "STR_ATM_WithdrawSuccess",[_val] call life_fnc_numberText]] call life_fnc_showNotification;
[] call life_fnc_atmMenu;
[6] call SOCK_fnc_updatePartial;
[] call life_fnc_hudUpdate;
[format["[BANKRET] %1(%2) -BANKAVANT: %3 -CASHAVANT: %4 -MONTANT: %5 -BANK APRES: %6 - CASH APRES: %7", name player, getPlayerUID player, [life_KavaBank+_val] call life_fnc_numberText, [life_KavaCash-_val] call life_fnc_numberText,[_val] call life_fnc_numberText,[life_KavaBank] call life_fnc_numberText, [life_KavaCash] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
