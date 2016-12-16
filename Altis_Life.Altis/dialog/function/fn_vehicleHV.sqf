#include "..\..\script_macros.hpp"
/*
	File: fn_vehicleHV.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Vehicle Garage, why did I spawn this in an action its self?
	
	
	this addAction[localize""STR_Garage_Title"",  {   if(life_HC_isActive) then {	[false,getPlayerUID player,playerSide,""Car"",player] remoteExecCall [""HC_fnc_getVehicles"",HC_Life]; } else { [false,getPlayerUID player,playerSide,""Car"",player] remoteExecCall [""TON_fnc_getVehicles"",2];};   createDialog ""Life_impound_menu"";   disableSerialization;   ctrlSetText[2802,""Fetching Vehicles....""];   life_garage_sp = ""cop_car_2""; life_garage_type = ""Car"";life_isImpound = false;  },"""",0,false,false,"""",'playerSide isEqualTo west'];
	this addAction[localize "STR_Garage_Title",life_fnc_vehicleGarage,[["car_g_3","car_g_3_1"],"Car"]];
*/


private["_spawnPos","_dir","_type","_impounded","_tempPos"];



this allowDamage false; this enableSimulation false;this addAction[localize "STR_Garage_Title",{if(life_HC_isActive) then {[player] remoteExecCall ["HC_fnc_getHVVehicles",HC_Life];} else {[player] remoteExec ["TON_fnc_getHVVehicles",RSERV];};createDialog "Life_HV_Vehicle";disableSerialization;ctrlSetText[2502,(localize "STR_ANOTF_QueryHV")];}];