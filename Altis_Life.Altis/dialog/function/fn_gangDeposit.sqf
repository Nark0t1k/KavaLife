#include "..\..\script_macros.hpp"
/*
	Author: Bryan "Tonic" Boardwine
	fn_gangDeposit.sqfq
	Description:
	Deposits money into the players gang bank.
*/
private["_value","_valueTax","_action"];
_value = parseNumber(ctrlText 2702);

//Series of stupid checks
if(_value < 10000) exitWith {hint localize "STR_ATM_LowerThan";};
if(_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
if(_value < 0) exitWith {};
if(!([str(_value)] call life_fnc_isnumeric)) exitWith {hint localize "STR_ATM_notnumeric"};
if(_value > life_KavaCash) exitWith {hint localize "STR_ATM_NotEnoughCash"};
_valueTax = round(_value/10);
_action = [
	format["Attention l'argent deposer sur la compte du gang doit subir un taux de change. Somme :%1$ : %2K$",_value,_valueTax],
	"Taux de change pour depot sur le compte de gang",
	"Accepter",
	"Refuser"
] call BIS_fnc_guiMessage;
if(!_action)exitWith {};

SUB(life_KavaCash,_value);
_gFund = GANG_FUNDS;
ADD(_gFund,_valueTax);
life_gangQG setVariable ["gang_bank",_gFund,true];

if(life_HC_isActive) then {
	[1,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life];
} else {
	[1,life_gangQG] remoteExecCall ["TON_fnc_updateGang",RSERV];
};

hint format[localize "STR_ATM_DepositSuccessG",[_valueTax] call life_fnc_numberText];
[] call life_fnc_atmMenu;
[6] call SOCK_fnc_updatePartial; //Silent Sync
[] call life_fnc_hudUpdate;
