#include "..\..\script_macros.hpp"
/*
	File: fn_medicLoadout.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Loads the medic out with the default gear.
*/
private["_handle"];
_handle = [] spawn life_fnc_stripDownPlayer;
waitUntil {scriptDone _handle};


if(str player in life_listMedic)then {player addUniform "U_Rangemaster";};
if(str player in life_listMecano)then {player addUniform "U_C_WorkerCoveralls";};
if(str player in life_listMerce)then {player addUniform "U_I_Wetsuit";};
if(str player in life_listConces)then {player addUniform "U_NikosAgedBody";};

player addItem "FirstAidKit";
player addItem "FirstAidKit";
player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemWatch";
player assignItem "ItemWatch";

[] call life_fnc_playerSkins;
[] call life_fnc_saveGear;