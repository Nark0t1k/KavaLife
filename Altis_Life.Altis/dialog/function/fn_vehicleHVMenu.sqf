#include "..\..\script_macros.hpp"
/*
	File: fn_vehicleHVMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Not actually a impound menu, may act as confusion to some but that is what I wanted.
	The purpose of this menu is it is now called a 'Garage' where vehicles are stored (persistent ones).
*/
private["_vehicles","_control","_tmp"];
disableSerialization;
_vehicles = param [0,[],[[]]];
ctrlShow[4204,false];
ctrlShow[4205,false];


if(EQUAL(count _vehicles,0)) exitWith {
	ctrlSetText[4202,localize "STR_Garage_NoVehicles"];
};

_control = CONTROL(4200,4202);
lbClear _control;
{
	_vehicleInfo = [SEL(_x,1)] call life_fnc_fetchVehInfo;
	_control lbAdd format["%1",SEL(_vehicleInfo,3)];
	_tmp = [SEL(_x,0),SEL(_x,1),SEL(_x,2),SEL(_x,3),SEL(_x,4),SEL(_x,5),SEL(_x,6)];
	_control lbSetData [(lbSize _control)-1,str _tmp];
	_control lbSetPicture [(lbSize _control)-1,SEL(_vehicleInfo,2)];
} foreach _vehicles;