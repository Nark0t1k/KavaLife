#include "script_macros.hpp"
/*
    File: initPlayerLocal.sqf
    Author:

    Description:
    Starts the initialization of the player.
*/
if (!hasInterface && !isServer) exitWith {
    [] call compile PreprocessFileLineNumbers "\life_hc\initHC.sqf";
}; //This is a headless client.

#define CONST(var1,var2) var1 = compileFinal (if (var2 isEqualType "") then {var2} else {str(var2)})
#define EQUAL(condition1,condition2) condition1 isEqualTo condition2
#define LIFE_SETTINGS(TYPE,SETTING) TYPE(missionConfigFile >> "Life_Settings" >> SETTING)

CONST(BIS_fnc_endMission,BIS_fnc_endMission);

{_x setMarkerAlphaLocal 0} forEach ["mission_spawn_1","mission_notspawn_1","mission_notspawn_2","area_champcocaine_allow","area_champheroine_allow","area_champcannabis_allow","area_champcocaine_notallow1","area_champcocaine_notallow2","area_champheroine_notallow1","area_champcannabis_notallow1","area_champcannabis_notallow2","area_labocannabis_allow","area_laboheroine_allow","area_labococaine_allow","area_labococaine_notallow1","area_laboheroine_notallow1","area_laboheroine_notallow2","area_labocannabis_notallow1","weedUsine_1","weed_1","heroin_1","cocaine_1","meth_1","heroinUsine_1","cocaineUsine_1"];

[] execVM "briefing.sqf";
[] execVM "core\init.sqf";
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
enableSentences false;
enableRadio false;
0 fadeRadio 0;
player setVariable ["BIS_noCoreConversations", true];
player disableConversation true;

if (isNil "tm4_handler_disableGroupView") then {
tm4_handler_disableGroupView = [] spawn {
		while {alive player} do {
			waitUntil {sleep .5; cameraView isEqualTo "group"};
			player switchCamera "Internal";
			sleep .5;
		};
		terminate tm4_handler_disableGroupView;
		tm4_handler_disableGroupView = nil; 
	};
};