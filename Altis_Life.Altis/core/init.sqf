#include "..\script_macros.hpp"
/*
	File: init.sqf
	Author: 
	
	Description:
	Master client initialization file
*/
life_firstSpawn = true;
life_session_completed = false;
private["_handle","_timeStamp"];
0 cutText[localize "STR_Start_Life_1","BLACK FADED"];
0 cutFadeOut 9999999;
_timeStamp = diag_tickTime;
diag_log "------------------------------------------------------------------------------------------------------";
diag_log "--------------------------------- Starting Altis Life Client Init ----------------------------------";
diag_log "------------------------------------------------------------------------------------------------------";
waitUntil {!isNull player && player isEqualTo player}; //Wait till the player is ready

//Setup initial client core functions
diag_log "::Life Client:: Initialization Variables";
[] call compile PreprocessFileLineNumbers "core\configuration.sqf";

//Set bank amount for new players
life_KavaBank = 50000;
switch (playerSide) do {
	case west: {
		life_paycheck = 1000;
	};
	case civilian: {
		life_KavaBank = 50000;
		life_paycheck = 1000;
	};
	case independent: {
		life_KavaBank = 50000;
		life_paycheck = 1500;
	};
};

diag_log "::Life Client:: Variables initialized";
diag_log "::Life Client:: Setting up Eventhandlers";
[] call life_fnc_setupEVH;

diag_log "::Life Client:: Eventhandlers completed";
diag_log "::Life Client:: Setting up user actions";
[] call life_fnc_setupActions;

diag_log "::Life Client:: User actions completed";
diag_log "::Life Client:: Waiting for server functions to transfer..";
waitUntil {(!isNil {TON_fnc_clientGangLeader})};

diag_log "::Life Client:: Received server functions.";
0 cutText [localize "STR_Start_Life_2","BLACK FADED"];
0 cutFadeOut 99999999;

diag_log "::Life Client:: Waiting for the server to be ready..";
waitUntil{!isNil "life_server_isReady"};
waitUntil{(life_server_isReady OR !isNil "life_server_extDB_notLoaded")};

if(!isNil "life_server_extDB_notLoaded" && {life_server_extDB_notLoaded != ""}) exitWith {
	diag_log life_server_extDB_notLoaded;
	999999 cutText [life_server_extDB_notLoaded,"BLACK FADED"];
	999999 cutFadeOut 99999999;
};

[] call SOCK_fnc_dataQuery;
waitUntil {life_session_completed};
0 cutText[localize "STR_Start_Life_3","BLACK FADED"];
0 cutFadeOut 9999999;
//diag_log "::Life Client:: Group Base Execution";
[] spawn life_fnc_escInterupt;

switch (playerSide) do {
	case west: {
		_handle = [] spawn life_fnc_initCop;
		waitUntil {scriptDone _handle};
	};
	case civilian: {
		//Initialize Civilian Settings
		_handle = [] spawn life_fnc_initCiv;
		waitUntil {scriptDone _handle};
	};
	case independent: {
		//Initialize Medics and blah
		_handle = [] spawn life_fnc_initMedic;
		waitUntil {scriptDone _handle};
	};
};

switch (FETCH_CONST(life_donator)) do
{
	case 1: {life_vehGarageMax = life_vehGarageMax + 2;life_houseMax=life_houseMax+1;}; 
	case 2: {life_vehGarageMax = life_vehGarageMax + 3;life_houseMax=life_houseMax+2;}; 
	case 3: {life_vehGarageMax = life_vehGarageMax + 5;life_houseMax=life_houseMax+3;}; 
};

player setVariable ["restrained",false,true];
player setVariable ["restrainedciv",false,true];
player setVariable ["Escorting",false,true];
player setVariable ["transporting",false,true];
player setVariable ["playerSurrender",false];
player setVariable ["askHelp",false,true];
player setVariable ["organ",true,true];
player setVariable ["jump",true];

diag_log "Past Settings Init";
[] execFSM "core\fsm\client.fsm";

diag_log "Executing client.fsm";
waitUntil {!(isNull (findDisplay 46))};

diag_log "Display 46 Found";
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call life_fnc_keyHandler"];
(findDisplay 46) displayAddEventHandler ["KeyUp", "_this call life_fnc_keyUpHandler"];
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["KeyDown", {_this select 1 isEqualTo 29}];
player addRating 99999999;
diag_log "------------------------------------------------------------------------------------------------------";
diag_log format["                End of Altis Life Client Init :: Total Execution Time %1 seconds ",(diag_tickTime) - _timeStamp];
diag_log "------------------------------------------------------------------------------------------------------";

0 cutText ["","BLACK IN"];
[] call life_fnc_hudSetup;
[] call life_fnc_playerTags;
/* Set up frame-by-frame handlers */

// player setVariable ["steam64ID",getPlayerUID player];
player setVariable ["realname",profileName,true];

life_fnc_moveIn = compileFinal
"
	life_disable_getIn = false;
	player moveInCargo (_this select 0);
	life_disable_getOut = true;
";

life_fnc_RequestClientId = player;
publicVariableServer "life_fnc_RequestClientId"; //Variable OwnerID for HeadlessClient

[] spawn life_fnc_survival;

[] spawn {
	while {true} do {
		waitUntil{(!isNull (findDisplay 49)) && (!isNull (findDisplay 602))}; // Check if Inventory and ESC dialogs are open
		(findDisplay 49) closeDisplay 2; // Close ESC dialog
		(findDisplay 602) closeDisplay 2; // Close Inventory dialog
	};
};

DYNAMICMARKET_boughtItems = [];
[player] remoteExec ["TON_fnc_playerLogged",RSERV];

[] execVM "core\fn_setupStationService.sqf";



if(life_HC_isActive) then {
	[getPlayerUID player,player getVariable["realname",name player],player] remoteExecCall ["HC_fnc_wantedProfUpdate",HC_Life];
} else {
	[getPlayerUID player,player getVariable["realname",name player],player] remoteExec ["life_fnc_wantedProfUpdate",RSERV];
};
if(life_HC_isActive) then {
	[player] remoteExec ["HC_fnc_countVehGarage",HC_Life];
}else
{
	[player] remoteExec ["TON_fnc_countVehGarage",RSERV];
};
waitUntil {vAH_loaded};
private["_total","_uid","_toDel"];
_total = 0;
_toDel = [];
_uid = getPlayerUID player;
{if ((_x select 5 isEqualTo _uid) && (_x select 7 isEqualTo 2)) then {_total = _total + (_x select 4);_toDel pushBack (_x select 0)};true;}count all_ah_items;
 if (_total > 0) then {
 {[1,_x] remoteExecCall ["TON_fnc_vAH_update",RSERV];}forEach _toDel;
[[0,7],format["Pendant que tu etais absent tu as vendu pour %1$ a l hotel des ventes",[_total]call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",player];
life_KavaBank = life_KavaBank + _total;
};
[format["[CONNEXION] Joueur: %1(%2) -SIDE: %3 -SLOT: %4 -BANK: %5 -CASH: %6", name player, getPlayerUID player, playerSide, player,life_KavaBank,life_KavaCash]] remoteExecCall ["A3Log", 2];
