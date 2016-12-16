#include "..\..\script_macros.hpp"
/*
	File: fn_surrender.sqf
	Author: 

	Description: Causes player to put their hands on their head.
*/
private["_near_units"];

if( player getVariable ["restrained",false] ) exitWith {};
if( player getVariable ["restrainedciv",false] ) exitWith {};
if( player getVariable ["Escorting",false] ) exitWith {};
if( vehicle player != player ) exitWith {};
if( speed player > 1 ) exitWith {};

if(player getVariable ["playerSurrender",false]) then {
	player setVariable ["playerSurrender",false];
} else {
	player setVariable ["playerSurrender",true];
};

while {player getVariable ["playerSurrender",false]} do {
	player playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	if(!alive player OR (vehicle player) != player) then { player setVariable ["playerSurrender",false]; };
};

player playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
