#include "..\..\script_macros.hpp"
/*
	File: fn_uberMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the spawn point selection menu.
*/
private ["_spCfg", "_ctrl", "_sp", "_dis", "_price"];
disableSerialization;


createDialog "life_Uber_selection";
waitUntil {!isNull (findDisplay 38550)};
_spCfg = [
	["taxi_spawn_1","Kavala","\a3\ui_f\data\map\MapControl\busstop_ca.paa"],
	["taxi_spawn_2","Pyrgos","\a3\ui_f\data\map\MapControl\busstop_ca.paa"],
	["taxi_spawn_3","Athira","\a3\ui_f\data\map\MapControl\busstop_ca.paa"],
	["taxi_spawn_4","Sofia","\a3\ui_f\data\map\MapControl\busstop_ca.paa"],
	["taxi_spawn_5","Agios","\a3\ui_f\data\map\MapControl\busstop_ca.paa"],
	["taxi_spawn_6","Aeroport Athira","\a3\ui_f\data\map\MapControl\powerwind_ca.paa"],
	["taxi_spawn_7","Aeroport Sofia","\a3\ui_f\data\map\MapControl\powerwind_ca.paa"],
	["taxi_spawn_8","Armurerie Telos","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
	["taxi_spawn_9","Armurerie Zaros","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
	["taxi_spawn_10","Armurerie Negades","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
	["taxi_spawn_11","Hopitale Pyrgos","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
	["mark_fourriere_1","Fourriere Kavala","\a3\ui_f\data\map\Markers\NATO\c_car.paa"],
	["mark_fourriere_2","Fourriere Sofia","\a3\ui_f\data\map\Markers\NATO\c_car.paa"],
	["mark_fourriere_3","Fourriere Pyrgos","\a3\ui_f\data\map\Markers\NATO\c_car.paa"],
	["mark_fourriere_4","Fourriere Aeroport","\a3\ui_f\data\map\Markers\NATO\c_car.paa"]
];

_ctrl = ((findDisplay 38550) displayCtrl 38560);
{
	_ctrl lnbAddRow[(_spCfg select _ForEachIndex) select 1,(_spCfg select _ForEachIndex) select 0,""];
	_ctrl lnbSetPicture[[_ForEachIndex,0],(_spCfg select _ForEachIndex) select 2];
	_ctrl lnbSetData[[_ForEachIndex,0],(_spCfg select _ForEachIndex) select 0];
} foreach _spCfg;

_sp = _spCfg select 0; //First option is set by default
life_uberInfo = _sp;
[((findDisplay 38550) displayCtrl 38552),1,0.1,getMarkerPos (_sp select 0)] call life_fnc_setMapPosition;

_dis = round((getMarkerPos (_sp select 0)) distance (getPosWorld player));
_price = round(2 * _dis);
_timer = round(_dis/100);
if(_timer < 30)then{_timer = 30;};
ctrlSetText[38551,format["Menu Taxi - Lieu: %1  Prix: %2$  Distance:  %3   Durée: %4 Sec",_sp select 1,[_price] call life_fnc_numberText,[_dis] call life_fnc_numberText,_timer]];