#include "..\..\script_macros.hpp"
/*
	File: fn_respawned.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Sets the player up if he/she used the respawn option.
*/
private["_handle","_randomPos"];
//Reset our weight and other stuff
if(life_is_arrested) exitWith {
	[player,TRUE] spawn life_fnc_jail;
};
life_is_alive = true;
life_use_atm = true;
life_hunger = 100;
life_thirst = 100;
life_carryWeight = 0;
life_KavaCash = 0; //Make sure we don't get our cash back.
player playMove "amovpercmstpsnonwnondnon";

life_corpse setVariable ["Revive",nil,TRUE];
life_corpse setVariable ["name",nil,TRUE];
life_corpse setVariable ["Reviving",nil,TRUE];
player setVariable ["Revive",nil,TRUE];
player setVariable ["name",nil,TRUE];
player setVariable ["Reviving",nil,TRUE];

//Load gear for a 'new life'
switch(playerSide) do
{
	case west: {
		_handle = [] spawn life_fnc_copLoadout;
	};
	case civilian: {
		_handle = [] spawn life_fnc_civLoadout;
	};
	case independent: {
		_handle = [] spawn life_fnc_medicLoadout;
	};
	waitUntil {scriptDone _handle};
};

//Cleanup of weapon containers near the body & hide it.
if(!isNull life_corpse) then {
	private "_containers";
	life_corpse setVariable ["Revive",TRUE,TRUE];
	deleteVehicle life_corpse;
};

//Destroy our camera...
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

//Bad boy
if(life_is_arrested) exitWith {
	hint localize "STR_Jail_Suicide";
	life_is_arrested = false;
	[player,TRUE] spawn life_fnc_jail;
	[] call SOCK_fnc_updateRequest;
};

//Johnny law got me but didn't let the EMS revive me, reward them half the bounty.
// if(!isNil "life_copRecieve") then {

	// if(life_HC_isActive) then {
		// [getPlayerUID player,player,life_copRecieve,true] remoteExecCall ["HC_fnc_wantedBounty",HC_Life];
	// } else {
		// [getPlayerUID player,player,life_copRecieve,true] remoteExecCall ["life_fnc_wantedBounty",RSERV];
	// };

	// life_copRecieve = nil;
// };


[player, getPlayerUID player, 0, life_is_arrested,life_is_alive] remoteExec ["life_fnc_JailPlayer",RSERV];
_randomPos = ["med_car_1","med_car_2","med_car_3"] call BIS_fnc_selectRandom;
player setPos (getMarkerPos _randomPos);


hint parseText "Vous venez de sortir du coma et vous retrouvez à l'hopital le plus proches";
[] call SOCK_fnc_updateRequest;
[] call life_fnc_hudUpdate; //Request update of hud.
[5] call SOCK_fnc_updatePartial;
if(playerSide isEqualTo west)exitWith {};
if(life_KavaBank < 15000) exitWith {};
sleep 5;
_action = [
	"Vous venez de sortir du coma et vous vous retrouvez à l'hopital le plus proches, vous devez payer 15000€ pour récuperez une partie de vos affaires.",
	"Reveil à l'hopital",
	"Payer",
	"Refuser"
] call BIS_fnc_guiMessage;

if(_action) then
{
	SUB(life_KavaBank,15000);
	[life_save_gear,1] spawn life_fnc_loadDeadGear;
	sleep 1;
	[] call life_fnc_playerSkins;
};
