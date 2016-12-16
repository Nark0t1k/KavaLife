#include "..\..\script_macros.hpp"
/*
    File: fn_startWar.sqf

*/
private["_group","_wait","_exit"];
disableSerialization;
if (playerSide != civilian) exitWith {}; //What in the hell?
_enemyGangQG = param [0,ObjNull,[ObjNull]];
if(isNull _enemyGangQG)exitWith {};
if(isNull life_gangQG)exitWith {};

_val = ctrlText 3351;
if(!([_val] call TON_fnc_isnumber)) exitWith {hint localize "STR_Cop_TicketNum"};
_gangHonor = life_gangQG getVariable ["gang_honor",0];
_maxAmount = switch (true) do
{
	case (_gangHonor < 100): {100000};
	case ((_gangHonor >= 100) && (_gangHonor < 200)): {200000};
	case ((_gangHonor >= 200) && (_gangHonor < 300)): {300000};
	case (_gangHonor >= 300): {400000};
};
if((parseNumber _val) > _maxAmount) exitWith {hint format[localize "STR_War_StartMaximumAmount",_gangHonor,_maxAmount];};
closeDialog 0;
_gangBank = GANG_FUNDS;
_taxVal = round((parseNumber _val)/10);
if(_gangBank < _taxVal) exitWith {hint format[localize "STR_War_StartNotGangBank",_val];};

_gangBank = _gangBank - _taxVal;
life_gangQG setVariable ["gang_bank",_gangBank,true];

_gangName = life_gangQG getVariable ["gang_name","ERROR"];
_enemyGangName = _enemyGangQG getVariable ["gang_name","ERROR"];

_gangWar = life_gangQG getVariable ["gang_war",[]];
_enemyGangWar = _enemyGangQG getVariable ["gang_war",[]];
_gangWar pushBack [_enemyGangName,_val];
_enemyGangWar pushBack [_gangName,_val];
life_gangQG setVariable ["gang_war",_gangWar,true];
_enemyGangQG setVariable ["gang_war",_enemyGangWar,true];
if (life_HC_isActive) then {
	[6,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
	[6,_enemyGangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
} else {
	[6,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
	[6,_enemyGangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
};

[[0,7],"STR_War_StartWarSuccess",true,[_gangName,_enemyGangName,parseNumber _val]] remoteExecCall ["life_fnc_broadcast",RCLIENT];


