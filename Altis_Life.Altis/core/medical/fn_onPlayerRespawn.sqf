#include "..\..\script_macros.hpp"
/*
	File: fn_onPlayerRespawn.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Does something but I won't know till I write it...
*/
private["_unit","_corpse","_containers"];
_unit = SEL(_this,0);
_corpse = SEL(_this,1);
life_corpse = _corpse;

//Set some vars on our new body.
_unit setVariable ["restrained",false,true];
_unit setVariable ["restrainedciv",false,true];
_unit setVariable ["Escorting",false,true];
_unit setVariable ["transporting",false,true]; //Again why the fuck am I setting this? Can anyone tell me?
_unit setVariable ["playerSurrender",false];
// _unit setVariable ["steam64id",getPlayerUID player,true]; //Reset the UID.
_unit setVariable ["realname",profileName,true]; //Reset the players name.
life_corpse setVariable ["realname",profileName,true]; //Reset the players name.
life_corpse setVariable ["Revive",false,true]; //Set the corpse to a revivable state.
_unit addRating 1e12; //Set our rating to a high value, this is for a ARMA engine thing.
player playMoveNow "amovppnemstpsraswrfldnon";
0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
6 enableChannel false;
[] call life_fnc_setupActions;
