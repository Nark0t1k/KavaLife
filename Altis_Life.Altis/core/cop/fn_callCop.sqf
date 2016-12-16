#include "..\..\script_macros.hpp"
/*
	fn_callCop.sqf
	by Nark0t1k
*/

if(license_civ_rebel) exitWith {};
if(player getVariable["askHelp",FALSE])exitWith {};
if(!(player getVariable["askHelp",FALSE]))then
{
	player setVariable["askHelp",TRUE,TRUE];
};
if(playerSide isEqualTo west) then
{
	[[0,7],"STR_COP_Renfort",true,[name player]] remoteExecCall ["life_fnc_broadcast",west];
};


sleep 120;
player setVariable["askHelp",FALSE,TRUE];
