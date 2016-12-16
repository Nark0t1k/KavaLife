#include "..\..\script_macros.hpp"
/*
	File: fn_defuseKit.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Defuses blasting charges for the cops?
*/
private["_vault","_ui","_title","_progressBar","_cP","_titleText"];
_vault = param [0,ObjNull,[ObjNull]];

if(isNull _vault) exitWith {};
if(typeOf _vault != "Land_CargoBox_V1_F") exitWith {};
if(!(_vault getVariable ["chargeplaced",false])) exitWith {hint localize "STR_ISTR_Defuse_Nothing"};

_handle = [localize "STR_ISTR_Defuse_Process",false,5,.0035,0.26,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

_vault setVariable["chargeplaced",false,true];
[[0,7],"STR_ISTR_Defuse_Success"] remoteExecCall ["life_fnc_broadcast",west];