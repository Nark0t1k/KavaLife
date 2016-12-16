#include "..\..\script_macros.hpp"
/*
	File: fn_vehicleInsureMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Vehicle Garage, why did I spawn this in an action its self?
*/
private["_spawnPos","_dir","_type","_insureType"];
disableSerialization;
_vehicle = life_vInact_curTarget;
_insureType = (_vehicle getVariable["dbInfo",[]]) select 2;
if(_insureType isEqualTo 4) exitWith {hint "Le vehicule a deja une assurance Full Omium";};
if(dialog)then
{
	closeDialog 0;
};
createDialog "Life_insure_menu";


_control = CONTROL(3900,3902);
lbClear _control;

if(_insureType isEqualTo 0)then{
	_control lbAdd "Light";
	_control lbSetData [(lbSize _control)-1,"light"];
};
if(_insureType < 2)then{
	_control lbAdd "Standard";
	_control lbSetData [(lbSize _control)-1,"standard"];
};
if(_insureType < 3)then{
	_control lbAdd "Premium";
	_control lbSetData [(lbSize _control)-1,"premium"];
};
if(_insureType < 4)then{
	_control lbAdd "Full Omium";
	_control lbSetData [(lbSize _control)-1,"omium"];
};

ctrlEnable[3901,false];