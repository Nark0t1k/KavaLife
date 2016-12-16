#include "..\..\script_macros.hpp"
/*
	File: fn_hudHealthSetup.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Setups the hud for the player?
*/
disableSerialization;

if(life_showHealth)then
{
	3 cutRsc ["playerHUDHealth","PLAIN"];
	[] call life_fnc_hudHealthUpdate;
}else
{
	3 cutRsc ["playerHUDHealth","PLAIN"];
};
if(!life_showHealth) exitWith {};
[] spawn
{
	private["_dam"];
	while {true} do
	{
		_dam = damage player;
		waitUntil {(damage player) != _dam};
		if(!life_showHealth)exitWith{3 cutRsc ["playerHUDHealth","PLAIN"];};
		[] call life_fnc_hudHealthUpdate;
	};
};
