#include "..\..\script_macros.hpp"
/*
	File: fn_gangWithdraw.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Withdraws money from the gang bank.
*/
private["_value","_action","_QG"];
_value = parseNumber(ctrlText 2702);

//Series of stupid checks
if(_value > 999999) exitWith {[localize "STR_ATM_WithdrawMax"] call life_fnc_showNotification;};
if(_value < 0) exitWith {};
if(!([str(_value)] call life_fnc_isnumeric)) exitWith {[localize "STR_ATM_notnumeric"] call life_fnc_showNotification;};
_gFund = GANG_FUNDS;
if(_value > _gFund) exitWith {[localize "STR_ATM_NotEnoughFundsG"] call life_fnc_showNotification;};
if(_val < 100 && _gFund > 20000000) exitWith {[localize "STR_ATM_WithdrawMin"] call life_fnc_showNotification;}; //Temp fix for something.
_action = [
	format["Attention l'argent retirer du compte du gang ne subis PAS le taux de change. Somme :%1",_value],
	"Taux de change pour depot sur le compte de gang",
	"Accepter",
	"Refuser"
] call BIS_fnc_guiMessage;
if(!_action)exitWith {};

SUB(_gFund,_value);
ADD(life_KavaCash,_value);
life_gangQG setVariable ["gang_bank",_gFund,true];

if(life_HC_isActive) then {
	[1,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
} else {
	[1,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
};


[format [localize "STR_ATM_WithdrawSuccessG",[_value] call life_fnc_numberText]] call life_fnc_showNotification;
[] call life_fnc_atmMenu;
[6] call SOCK_fnc_updatePartial;
[] call life_fnc_hudUpdate;
