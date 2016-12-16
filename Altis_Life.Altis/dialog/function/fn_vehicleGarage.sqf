#include "..\..\script_macros.hpp"
/*
	File: fn_vehicleGarage.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Vehicle Garage, why did I spawn this in an action its self?
	
	
	this addAction[localize""STR_Garage_Title"",  {   if(life_HC_isActive) then {	[false,getPlayerUID player,playerSide,""Car"",player] remoteExecCall [""HC_fnc_getVehicles"",HC_Life]; } else { [false,getPlayerUID player,playerSide,""Car"",player] remoteExecCall [""TON_fnc_getVehicles"",2];};   createDialog ""Life_impound_menu"";   disableSerialization;   ctrlSetText[2802,""Fetching Vehicles....""];   life_garage_sp = ""cop_car_2""; life_garage_type = ""Car"";life_isImpound = false;  },"""",0,false,false,"""",'playerSide isEqualTo west'];
	this addAction[localize "STR_Garage_Title",life_fnc_vehicleGarage,[["car_g_3","car_g_3_1"],"Car"]];
*/


private["_spawnPos","_dir","_type","_impounded","_tempPos"];
_data = _this select 3;
_spawnPos = _data select 0;
_type = [_data,1,"",[""]] call BIS_fnc_param;
_impounded = [_data,2,false,[false]] call BIS_fnc_param;
_tempPos = "";

if(EQUAL(typeName _spawnPos,typeName [])) then {
	//Find an available spawn point.
	{if(count(nearestObjects[(getMarkerPos _x),["Car","Ship","Air"],7]) isEqualTo 0) exitWith {_tempPos = _x};} forEach _spawnPos;
} else {
	if(count(nearestObjects[(getMarkerPos _spawnPos),["Car","Ship","Air"],7]) isEqualTo 0) exitWith {_tempPos = _spawnPos};
};

if(_tempPos isEqualTo "")exitWith {[localize "STR_ANOTF_NoSpawnGarage"] call life_fnc_showNotification;};
life_garage_sp = _tempPos;
life_garage_type = _type;
if(_tempPos in ["four_c_1","four_c_2","four_c_3","four_c_4","four_a_1","four_a_2","four_a_3","four_a_4"])then{life_isImpound = true;}else{life_isImpound = false;};
if(life_HC_isActive) then {
	[_impounded,getPlayerUID player,playerSide,_type,player] remoteExecCall ["HC_fnc_getVehicles",HC_Life];
} else {
	[_impounded,getPlayerUID player,playerSide,_type,player] remoteExec ["TON_fnc_getVehicles",RSERV];
};

createDialog "Life_impound_menu";
disableSerialization;
ctrlSetText[2802,(localize "STR_ANOTF_QueryGarage")];