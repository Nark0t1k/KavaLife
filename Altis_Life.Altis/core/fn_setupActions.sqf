#include "..\script_macros.hpp"
/*
	File: fn_setupActions.sqf
	Author: 
	
	Description:
	Master addAction file handler for all client-based actions.
*/
if(playerSide isEqualTo civilian)then
{
		//Drop fishing net
		life_actions = life_actions + [player addAction[localize "STR_pAct_DropFishingNet",life_fnc_dropFishingNet,"",0,false,false,"",'
		(surfaceisWater (getPos vehicle player)) && (vehicle player isKindOf "Ship") && life_carryWeight < life_maxWeight && speed (vehicle player) < 2 && speed (vehicle player) > -1 && !life_action_inUse']];
		//Rob person
		life_actions = life_actions + [player addAction[localize "STR_pAct_RobPerson",life_fnc_robAction,"",0,false,false,"",'
		!isNull cursorTarget && player distance cursorTarget < 3.5 && isPlayer cursorTarget && animationState cursorTarget == "Incapacitated" && !(cursorTarget getVariable["robbed",FALSE]) ']];
};
// Ceinture ON
life_actions pushBack (player addAction ["<t color='#BBBB00'>Attacher sa ceinture</t>", {life_seatbelt=true}, "", 3, false, true, "", 'vehicle player isKindOf "Car" && !life_seatbelt']);
// Ceinture OFF
life_actions pushBack (player addAction ["<t color='#BBBB00'>Detacher sa ceinture</t>", {life_seatbelt=false}, "", 3, false, true, "", 'vehicle player isKindOf "Car" && life_seatbelt']);


// SitDown
life_actions pushBack (player addAction["<t color='#0099FF'>S'assoir</t>",{[cursorObject,player] execVM "Chair\sitdown.sqf"},true,1,true,true,"""",'player distance cursorObject < 3 && {([str cursorObject,"bench"] call KRON_StrInStr || [str cursorObject,"chair"] call KRON_StrInStr)} ']);