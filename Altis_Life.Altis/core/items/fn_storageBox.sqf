#include "..\..\script_macros.hpp"
/*
    File : fn_storageBox.sqf
    Author: NiiRoZz
    Description:
    Create Storage and attachto player;
*/
private["_object","_attachPos"];
params [
    ["_size",false,[false]]
];
if (life_container_active) exitWith {hint "Tu place deja un conteneur pour le moment";};
life_container_active = true;
closeDialog 0;

_house = cursorTarget;
if(!(_house in life_vehicles) OR isNil {_house getVariable "house_owner"}) exitWith {
	if(_size)then
	{
		_typeName = "storagebig";
	}else
	{
		_typeName = "storagesmall";
	};
	[true,_typeName,1] call life_fnc_handleInv;
	hint localize "STR_House_Container_House_Near_Owner";
	life_container_active = false;
};

if (_size) then {
    _object = "B_supplyCrate_F" createVehicle [0,0,0];
} else {
    _object = "Box_IND_Grenades_F" createVehicle [0,0,0];
};

life_activeObj = _object;
_attachPos = [0.16, 3, ((boundingBoxReal _object) select 1) select 2];
[_object] remoteExecCall ["life_fnc_simDisable",RANY];
_object attachTo[player, _attachPos];

clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearItemCargoGlobal _object;
clearBackpackCargoGlobal _object;

titleText [localize "STR_NOTF_PlaceContainer", "PLAIN"];