#include "..\..\script_macros.hpp"
/*
	File : removeContainer.sqf
	Author: NiiRoZz

	Description:
	Delete Container from house storage
*/
private["_house","_action","_container","_containerType","_containers"];
_container = param [0,ObjNull,[ObjNull]];
_containerType = typeOf _container;
_house = nearestBuilding (getPosATL player);
if(!(_house in life_vehicles)) exitWith {[localize "STR_ISTR_Box_NotinHouse"] call life_fnc_showNotification;};
if(isNull _container) exitWith {};
_containers = _house getVariable ["containers",[]];
closeDialog 0;

_action = [
	format[localize "STR_House_DeleteContainerMSG"],localize "STR_pInAct_RemoveContainer",localize "STR_Global_Remove",localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;

if(_action) then {
	private ["_box","_diff"];
	_box = switch (_containerType) do {
		case ("B_supplyCrate_F"): {"storagebig"};
		case ("Box_IND_Grenades_F"): {"storagesmall"};
		case ("Land_Sink_F"): {"illegalbox"};
		case ("CargoNet_01_barrels_F"): {"illegalboxbig"};
		case ("Land_OfficeCabinet_01_F"): {"frigo"};
		case ("Fridge_01_closed_F"): {"armoire"};
		default {"None"};
	};
	if(_box isEqualTo "None") exitWith {};

	_diff = [_box,1,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
	if(EQUAL(_diff,0)) exitWith {hint localize "STR_NOTF_InvFull"};

	if(life_HC_isActive) then {
		[_container] remoteExecCall ["HC_fnc_deleteDBContainer",HC_Life];
	} else {
		[_container] remoteExecCall ["TON_fnc_deleteDBContainer",RSERV];
	};

	{
		if (_x isEqualTo _container) exitWith {
			_containers set [_forEachIndex,666];
		};
	} forEach _containers;
	_containers = _containers - [666];
	_house setVariable ["containers",_containers,true];

	[true,_box,1] call life_fnc_handleInv;
};
