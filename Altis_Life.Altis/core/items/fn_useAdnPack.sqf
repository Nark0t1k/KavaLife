#include "..\..\script_macros.hpp"
/*
	File: fn_useAdnPack.sqf
	Author: Bryan "Tonic" Boardwine

*/
private["_unit","_info","_handle"];
_unit = param [0,ObjNull,[ObjNull]];

if(isNull _unit) exitWith {};
if(side _unit != civilian)exitWith {hint "Ne fonctionne que sur les civiles";};
if(!([false,"adnpack",1] call life_fnc_handleInv))exitWith {hint parseText "Tu n'as pas de Kit ADN";};

_handle = [localize "STR_ISTR_Adn_Process",true,5,0.01,0.1,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

_info = format["<t color='#FFCC00'><t size='2'><t align='center'>Recherche ADN<br/></t></t></t><t color='#FFCC00'><t size='1.3'><t align='center'>Citoyen d'Altis<br/></t></t></t><br/><t align='left'><t size='1.4'><t color='#33CC33'>Nom: </t><t color='#ffffff'>%1</t></t></t>",_unit getVariable["realname", name _unit]];

[3,format["%1",_info]] remoteExecCall ["life_fnc_broadcast",player];
[3,format["%1",_info]] remoteExecCall ["life_fnc_broadcast",_unit];
