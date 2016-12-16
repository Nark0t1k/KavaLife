#include "..\..\script_macros.hpp"
/*
	File: fn_vehicleAHMenu.sqf

*/
private["_statut","_vehicles","_control","_statuts"];
disableSerialization;
_vehicles = param [0,[],[[]]];
createDialog "AH_vehsell";
waitUntil {!isNull (findDisplay 16600)};
_control = CONTROL(16600,16601);
lbClear _control;
if(EQUAL(count _vehicles,0)) exitWith {
	_control lbAdd format ["Tu n'as pas de véhicule dans ton garage ou actuellement en vente!"];
};

{
	_vehicleInfo = [SEL(_x,2)] call life_fnc_fetchVehInfo;
	if(SEL(_x,9) isEqualTo 1) then
	{
		_statuts = "En vente";
		_statut = 0;
	}else
	{
		_statut = 3;
		_statuts = "Garage";
	};
	_control lbAdd format ["(%1) - %2",SEL(_vehicleInfo,3),_statuts];
	_tmp = [SEL(_x,2),SEL(_x,8),_statut,SEL(_x,0)];
	_tmp = str(_tmp);
	_control lbSetData [(lbSize _control)-1,_tmp];
	_control lbSetPicture [(lbSize _control)-1,SEL(_vehicleInfo,2)];
	_control lbSetValue [(lbSize _control)-1,SEL(_x,0)];
} foreach _vehicles;