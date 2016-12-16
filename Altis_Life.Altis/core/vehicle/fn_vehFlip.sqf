#include "..\..\script_macros.hpp"
/*
	fn_vehFlip.sqf
	By Nark0t1k
*/
if(life_action_inUse) exitWith {};
life_action_inUse = true;
hint parseText "Ecartez vous le véhicules va flip dans 4 seconde";
sleep 4;
life_vInact_curTarget setPos [getPos life_vInact_curTarget select 0, getPos life_vInact_curTarget select 1, (getPos life_vInact_curTarget select 2)+1];
life_action_inUse = false;