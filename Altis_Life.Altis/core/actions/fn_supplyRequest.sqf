#include "..\..\script_macros.hpp"
/*
	fn_supplyRequest.sqf
*/

private ["_action","_lstObj"];
if(isNil "life_SupplyWait")then
{
	life_SupplyWait = false;
};
if(life_SupplyWait)exitWith {hint"Tu dois encore attendre avant de pouvoir demander des ravaillements (Toutes les 15min)"};
_action = false;

_lstObj = nearestObjects [player, ["Land_ClutterCutter_small_F"], 500];
{
	if(_x getVariable ["supplyCheck",false])exitWith {_action = true;};
}foreach _lstObj;
if(_action) exitWith {hint "Un larguage à déja été effectué dans les 500m";};

_action = [
	format["<t align='center'>Prix: 20.000$<br/>Acceptez vous?</t>",""],
	"Livraison de ravitaillement par parachute",
	"Oui",
	"Non"
] call BIS_fnc_guiMessage;

if(!_action) exitWith {};

if(life_KavaBank < 20000) exitWith {hint "Tu n'as pas assez d'argent";};
SUB(life_KavaBank,20000);

life_SupplyWait = true;

hint "Votre ravitaillement est parachute";
[] spawn 
{
	private ["_chute", "_crate", "_light"];
	_pos = getPos player;
	_pos set [2, 150];
	_chute = createVehicle ["B_Parachute_02_F", [100, 100, 200], [], 0, 'FLY'];
	_chute setPos _pos;
	_crate = createVehicle ["Box_IND_Support_F", position _chute, [], 0, 'NONE'];
	_crate attachTo [_chute, [0, 0, -0.8]];
	_crate allowdamage false;
	_light = createVehicle ["SmokeShellBlue", position _chute, [], 0, 'NONE'];
	_light attachTo [_chute, [0, 0, 0]];

	// clear crate - leaves medkits in place. add clearItemCargoGlobal _crate; to remove medkits
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;
	clearItemCargoGlobal _crate;

	// fill crate with our junk
	_crate addItemCargoGlobal ["ToolKit", 1];

	waitUntil {position _crate select 2 < 1 || isNull _chute};
	detach _crate;
	if(life_HC_isActive) then {
		[_crate] remoteExec ["HC_fnc_supplyCheck",HC_Life];
	}else
	{
		[_crate] remoteExec ["TON_fnc_supplyCheck",RSERV];
	};
	_crate setPos [position _crate select 0, position _crate select 1, 0];
	Sleep 60;
	deleteVehicle _crate;
};
[] spawn 
{
	Sleep 900;
	life_SupplyWait = false;
};
[1] call SOCK_fnc_updatePartial;
//byPlayer2