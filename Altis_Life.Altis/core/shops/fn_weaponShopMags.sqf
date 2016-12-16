#include "..\..\script_macros.hpp"
/*
	File: fn_weaponShopMags.sqf
	Author: Daniel Stuart

	Description:
	Set Weapon Shop in magazine mode
*/
disableSerialization;

private["_weapon"];
_weapon = lbData[39503,lbCurSel (39503)];
_weapon = FETCH_CONFIG2(getArray,"CfgWeapons",_weapon,"magazines");
uiNamespace setVariable["Magazine_Array",_weapon];
