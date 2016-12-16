#include "..\..\script_macros.hpp"
/*
	File: fn_medicRequest.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Notifies the medics that someone has requested emergency and prompts them
	if they want to take the request or not.
*/
params [
	["_caller",objNull,[objNull]],
	["_callerName","Unknown Player",[""]]
];

if(isNull _caller) exitWith {}; //Bad data
if(!((FETCH_CONST(life_medicLevel)) in [0,1])) exitWith {};
["MedicalRequestEmerg",[format[localize "STR_Medic_Request",_callerName]]] call BIS_fnc_showNotification;
hint parseText format["<t color='#00FF00'><t size='2'>Alerte EMS</t></t><br/>Tu as recu une demande de soin de <t font='PuristaMedium'>%1</t> qui se trouve à <t font='PuristaMedium'>%2 metres</t>. <t color='#00FFFF'>Appuye sur 8 dans les 20 sec</t> pour l'informer que tu arrive.", _callerName, [player distance _caller] call life_fnc_numberText];
last_indep_call = _caller;
last_indep_time = time;