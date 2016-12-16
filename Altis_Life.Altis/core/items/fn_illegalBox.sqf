#include "..\..\script_macros.hpp"
/*
    File : fn_illegalBox.sqf
    Author: NiiRoZz
    Description:
    Create Storage and attachto player;
*/
private["_object","_attachPos","_house","_typeName"];
params [
    ["_type",0,[0]]
];
if (life_container_active) exitWith {hint "Tu place deja un conteneur pour le moment";};
life_container_active = true;
closeDialog 0;

switch(true) do {
	case ((typeOf life_activeObj) isEqualTo "B_supplyCrate_F"): {_typeName = "storagebig"};
	case ((typeOf life_activeObj) isEqualTo "Box_IND_Grenades_F") : {_typeName = "storagesmall"};
	case ((typeOf life_activeObj) isEqualTo "Land_Sink_F") : {_typeName = "illegalbox"};
	case ((typeOf life_activeObj) isEqualTo "CargoNet_01_barrels_F") : {_typeName = "illegalboxbig"};
	case ((typeOf life_activeObj) isEqualTo "Land_OfficeCabinet_01_F") : {_typeName = "armoire"};
	case ((typeOf life_activeObj) isEqualTo "Fridge_01_closed_F") : {_typeName = "frigo"};
	default {_typeName = ""};
};

_house = cursorTarget;
if(!(_house in life_vehicles) OR isNil {_house getVariable "house_owner"}) exitWith {
	[true,_typeName,1] call life_fnc_handleInv;
	hint localize "STR_House_Container_House_Near_Owner";
	life_container_active = false;
};


switch(_type)do
{
	case 0: {_object = "Land_Sink_F" createVehicle [0,0,0];};
	case 1: {_object = "CargoNet_01_barrels_F" createVehicle [0,0,0];};
	case 2: {_object = "Land_OfficeCabinet_01_F" createVehicle [0,0,0];};
	case 3: {_object = "Fridge_01_closed_F" createVehicle [0,0,0];};
};

life_activeObj = _object;
_attachPos = [0.16, 3, ((boundingBoxReal _object) select 1) select 2];
[_object] remoteExecCall ["life_fnc_simDisable",RANY];
_object attachTo[player, _attachPos];

// clearWeaponCargoGlobal _object;
// clearMagazineCargoGlobal _object;
// clearItemCargoGlobal _object;
// clearBackpackCargoGlobal _object;

titleText [localize "STR_NOTF_PlaceContainer", "PLAIN"];

[_typeName] spawn
{
	_typeName = _this select 0;
	sleep 30;
	if(life_activeObj != ObjNull)then
	{

		deleteVehicle life_activeObj;
		[true,_typeName,1] call life_fnc_handleInv;
		hint "Tu as été trop lent pour placer ton objets";
		life_container_active = false;
		life_activeObj = ObjNull;
	};
};