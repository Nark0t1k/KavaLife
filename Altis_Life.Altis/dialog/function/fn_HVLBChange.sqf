#include "..\..\script_macros.hpp"
/*
	File: fn_HVLBChange.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Can't be bothered to answer it.. Already deleted it by accident..
*/
disableSerialization;
private ["_control", "_index", "_dataArr", "_className", "_classNameLife", "_vehicleColor", "_vehicleInfo", "_trunkSpace", "_sellPrice", "_insure", "_seller"];
_control = SEL(_this,0);
_index = SEL(_this,1);

//Fetch some information.
_dataArr = CONTROL_DATAI(_control,_index);
_dataArr = call compile format["%1",_dataArr];


_className = SEL(_dataArr,1);
_classNameLife = _className;

if(!isClass (missionConfigFile >> "LifeCfgVehicles" >> _classNameLife)) then {
	_classNameLife = "Default"; //Use Default class if it doesn't exist
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_className];
};

_vehicleColor = SEL(SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"textures"),SEL(_dataArr,2)),0);
if(isNil "_vehicleColor") then {_vehicleColor = "Default";};

_vehicleInfo = [_className] call life_fnc_fetchVehInfo;
_trunkSpace = [_className] call life_fnc_vehicleWeightCfg;

_sellPrice = SEL(_dataArr,3);

_insure = switch (SEL(_dataArr,4))do
{
	case 0:{"Pas assure"};
	case 1:{"Light"};
	case 2:{"Standard"};
	case 3:{"Premium"};
	case 4:{"Full Omium"};
	default {"Pas assure"};
};

_seller = SEL(_dataArr,5);

(CONTROL(4200,4203)) ctrlSetStructuredText parseText format[
	(localize "STR_Shop_Veh_UI_SellP")+ " <t color='#8cff9b'>%1€</t><br/>
	" +(localize "STR_Shop_Veh_UI_Seller")+ " %2<br/>
	" +(localize "STR_Shop_Veh_UI_Insure")+ " %3<br/>
	" +(localize "STR_Shop_Veh_UI_Color")+ " %4<br/>
	" +(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %5 km/h<br/>
	" +(localize "STR_Shop_Veh_UI_HPower")+ " %6<br/>
	" +(localize "STR_Shop_Veh_UI_PSeats")+ " %7<br/>
	" +(localize "STR_Shop_Veh_UI_Trunk")+ " %8<br/>
	" +(localize "STR_Shop_Veh_UI_Fuel")+ " %9<br/>
	",
[_sellPrice] call life_fnc_numberText,
_seller,
_insure,
_vehicleColor,
SEL(_vehicleInfo,8),
SEL(_vehicleInfo,11),
SEL(_vehicleInfo,10),
if(_trunkSpace isEqualTo -1) then {"None"} else {_trunkSpace},
SEL(_vehicleInfo,12)
];

if(SEL(_dataArr,6) isEqualTo (getPlayerUID player))then
{
	ctrlShow [4201,false];
	ctrlShow [4206,true];
}else
{
	ctrlShow [4201,true];
	ctrlShow [4206,false];
};