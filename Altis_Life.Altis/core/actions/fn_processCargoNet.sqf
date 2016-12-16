#include "..\..\script_macros.hpp"
/*
	fn_processCargoNet.sqf
	by Nark0t1k for Kavalash
	
*/

private ["_item", "_nbrStock", "_handle", "_speed", "_box"];

_spawnPoint = _this select 0;
// _speed = 3;
_speed = 0.3;
_exit = false;

if(life_inv_oilProcessed < 100) exitWith {[localize "STR_needPPetrol"] call life_fnc_showNotification;};


_handle = [localize "STR_craftPetrol",true,5,0.01,_speed,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;};

if(life_inv_oilProcessed < 100) exitWith {[localize "STR_needPPetrol"] call life_fnc_showNotification;};

[false,"oil_processed",100] call life_fnc_handleInv;

_box = createVehicle ["CargoNet_01_box_F",getMarkerPos "craft_filetbox_spawn",[],0,"NONE"];
waitUntil {!isNil "_box" && {!isNull _box}};
_box allowDamage false;
_box setPos (getMarkerPos "craft_filetbox_spawn");

[localize "STR_craftPetrolFinish"] call life_fnc_showNotification;