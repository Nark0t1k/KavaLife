#include "..\..\script_macros.hpp"
/*
	File: fn_hudVehHealthSetup.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Setups the hud for the player?
*/
disableSerialization;
if(life_showVehHealth)then
{
	4 cutRsc ["playerHUDVehHealth","PLAIN"];
	[] call life_fnc_hudVehHealthUpdate;
}else
{
	4 cutRsc ["playerHUDVehHealth","PLAIN"];
};
if(!life_showVehHealth) exitWith {};
[] spawn
{
	private["_dam"];
	while {true} do
	{
		_dam = damage (vehicle player);
		waitUntil {((damage (vehicle player)) != _dam) || (vehicle player isEqualTo player)};
		if(vehicle player isEqualTo player)exitWith{life_showVehHealth=false;4 cutRsc ["playerHUDVehHealth","PLAIN"];};
		if(!life_showVehHealth)exitWith{4 cutRsc ["playerHUDVehHealth","PLAIN"];};
		[] call life_fnc_hudVehHealthUpdate;
	};
};
