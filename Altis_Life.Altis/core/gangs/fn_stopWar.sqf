#include "..\..\script_macros.hpp"
/*
    File: fn_stopWar.sqf

*/
private ["_enemyGangQG", "_gangName", "_enemyGangName", "_gangWar", "_enemyGangWar", "_butin", "_gangBank", "_action"];
;
if (playerSide != civilian) exitWith {}; //What in the hell?
_enemyGangQG = param [0,ObjNull,[ObjNull]];
if(isNull _enemyGangQG)exitWith {};
if(isNull life_gangQG)exitWith {};

_gangName = life_gangQG getVariable ["gang_name","ERROR"];
_enemyGangName = _enemyGangQG getVariable ["gang_name","ERROR"];

_gangWar = life_gangQG getVariable ["gang_war",[]];
_enemyGangWar = _enemyGangQG getVariable ["gang_war",[]];

{
	if((_x select 0) isEqualTo _enemyGangName)exitWith {_butin = _x select 1;};
}forEach _gangWar;
if(isNil "_butin")exitWith {hint "Tu n es pas en guerre";};
_gangBank = GANG_FUNDS;
if(_gangBank < (parseNumber _butin))exitWith {hint format["Ton gang ne dispose pas de %1K$ pour payer le butin de guerre",(parseNumber _butin)];};

_action = [
	format["Votre gang doit payer %1K$ pour terminer la guerre contre le gang %2.",(parseNumber _butin),_enemyGangName],
	"Faire la paix",
	"Accepter",
	"Refuser"
] call BIS_fnc_guiMessage;

if(!_action)exitWith{};
_gangBank = GANG_FUNDS;
if(_gangBank < (parseNumber _butin))exitWith {hint format["Ton gang ne dispose pas de %1K$ pour payer le butin de guerre",(parseNumber _butin)];};
_gangBank = _gangBank - (parseNumber _butin);
_gangWar = _gangWar - [[_enemyGangName,_butin]];
_enemyGangWar = _enemyGangWar - [[_gangName,_butin]];

life_gangQG setVariable ["gang_bank",_gangBank,true];
_ennemyGangBank = _enemyGangQG getVariable ["gang_bank",0];
_ennemyGangBank = _ennemyGangBank + (parseNumber _butin);
_enemyGangQG setVariable ["gang_bank",_ennemyGangBank,true];
life_gangQG setVariable ["gang_war",_gangWar,true];
_enemyGangQG setVariable ["gang_war",_enemyGangWar,true];

if (life_HC_isActive) then {
	[6,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
	[6,_enemyGangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
} else {
	[6,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
	[6,_enemyGangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
};
[[0,7],"STR_War_StartWarPaid",true,[_gangName,_butin,_enemyGangName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];


