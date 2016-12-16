#include "..\..\script_macros.hpp"
/*
	fn_repaintMenu.sqf
	this addAction ["Vehicle Painting", life_fnc_RepaintMenu];
	
	this addAction["Atelier de peinture",life_fnc_repaintMenu,"",0,false,false,"",'playerSide isEqualTo civilian'];
	
*/

private ["_display", "_vehicles", "_vehList", "_color", "_text", "_vehicleInfo"];

if(vehicle player != player) exitWith {};

createDialog "Life_vehicle_repaint";
disableSerialization;
if(isNull (findDisplay 2300)) exitWith {};


_display = findDisplay 2300;
_vehicles = _display displayCtrl 2302;

_vehList = nearestObjects[getPos player,["Car","Air","Ship"],6];

//List vehicles
{
	if(_x in life_vehicles) then {
	
		_color = SEL(SEL(M_CONFIG(getArray,"LifeCfgVehicles",(typeOf _x),"textures"),(_x getVariable "Life_VEH_color")),0);
		if(isNil "_color") then {_color = ""};
		_text = format[" - Couleur: %1",_color];
		if(_text isEqualTo "()") then {
			_text = "";
		};
		
		_vehicleInfo = [typeOf _x] call life_fnc_fetchVehInfo;		
		_vehicles lbAdd format ["%1%2", _vehicleInfo select 3, _text];		
		_vehicles lbSetPicture [(lbSize _vehicles)-1,(_vehicleInfo select 2)];
		_vehicles lbSetValue [(lbSize _vehicles)-1,_forEachindex];
	};		
} foreach _vehList;