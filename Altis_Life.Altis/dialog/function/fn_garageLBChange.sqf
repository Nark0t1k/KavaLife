#include "..\..\script_macros.hpp"
/*
	File: fn_garageLBChange.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Can't be bothered to answer it.. Already deleted it by accident..
*/
disableSerialization;
private["_basePrice","_mday","_control","_index","_className","_classNameLife","_dataArr","_i","_insure","_tmp","_vehicleColor","_vehicleInfo","_trunkSpace","_sellPrice","_retrievePrice","_multiplicator","_vehicleImpound","_headerPrice"];
_control = SEL(_this,0);
_index = SEL(_this,1);

//Fetch some information.
_dataArr = CONTROL_DATAI(_control,_index);
_dataArr = call compile format["%1",_dataArr];
_className = SEL(_dataArr,0);
_classNameLife = _className;

_vehicleImpound = "<t color='#2EFE2E'>Non</t>";
if(!isClass (missionConfigFile >> "LifeCfgVehicles" >> _classNameLife)) then {
	_classNameLife = "Default"; //Use Default class if it doesn't exist
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_className];
};

_vehicleColor = SEL(SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"textures"),SEL(_dataArr,1)),0);
if(isNil "_vehicleColor") then {_vehicleColor = "Default";};

_vehicleInfo = [_className] call life_fnc_fetchVehInfo;
_trunkSpace = [_className] call life_fnc_vehicleWeightCfg;

_basePrice = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),3)};
};
_multiplicator = LIFE_SETTINGS(getNumber,"vehicleGarage_StorFeeMultiplicator");
_retrievePrice = _multiplicator * _basePrice;

_sellPrice = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),3)};
};
_multiplicator = LIFE_SETTINGS(getNumber,"vehicleGarage_SellMultiplicator");
_sellPrice = _multiplicator * _sellPrice;
if(life_isImpound)then
{
	_sellPrice = round(_sellPrice / 2);
	_mday = switch (SEL(_dataArr,3)) do
	{
		case 5: {2};
		case 4: {2};
		case 3: {3};
		case 2: {3};
		case 1: {4};
		case 0: {4};
	};
	_retrievePrice = _retrievePrice * _mday;
	_vehicleImpound = format["<t color='#FF0000'>Oui %1 Jour(s)</t>",(SEL(_dataArr,3))];
}else
{
	if(SEL(_dataArr,2) isEqualTo 1) then {
		_sellPrice = round(_sellPrice / 2);
		_vehicleImpound = format["<t color='#FF0000'>Oui %1 Jour(s)</t>",(SEL(_dataArr,3))];
		_mday = switch (SEL(_dataArr,3)) do
		{
			case 5: {2};
			case 4: {2};
			case 3: {3};
			case 2: {3};
			case 1: {4};
			case 0: {4};
		};
		_retrievePrice = _retrievePrice * _mday;
	};
};
_insure = switch (SEL(_dataArr,4))do
{
	case 0:{"Pas assure"};
	case 1:{"Light"};
	case 2:{"Standard"};
	case 3:{"Premium"};
	case 4:{"Full Omium"};
	default {"Pas assure"};
};

_headerPrice = (localize "STR_Shop_Veh_UI_RetrievalP");
if(!(EQUAL(typeName _sellPrice,typeName 0)) OR _sellPrice < 1) then {_sellPrice = 1000};
if(!(EQUAL(typeName _retrievePrice,typeName 0)) OR _retrievePrice < 1) then {_retrievePrice = 1000};
if(SEL(_dataArr,5) isEqualTo 0)then
{
	_retrievePrice = _basePrice * 5;
	_headerPrice = (localize "STR_Shop_Veh_UI_RestoreP");
};

(CONTROL(2800,2803)) ctrlSetStructuredText parseText format[
	" %11" + " <t color='#8cff9b'>%1€</t><br/>
	" +(localize "STR_Shop_Veh_UI_SellP")+ " <t color='#8cff9b'>%2€</t><br/>
	" +(localize "STR_Shop_Veh_UI_Color")+ " %8<br/>
	" +(localize "STR_Shop_Veh_UI_MaxSpeed")+ " %3 km/h<br/>
	" +(localize "STR_Shop_Veh_UI_HPower")+ " %4<br/>
	" +(localize "STR_Shop_Veh_UI_PSeats")+ " %5<br/>
	" +(localize "STR_Shop_Veh_UI_Trunk")+ " %6<br/>
	" +(localize "STR_Shop_Veh_UI_Fuel")+ " %7<br/>
	" +(localize "STR_Shop_Veh_UI_Impound")+ " %9<br/>
	" +"Vehicule Assuré:"+ " %10
	",
[_retrievePrice] call life_fnc_numberText,
[_sellPrice] call life_fnc_numberText,
SEL(_vehicleInfo,8),
SEL(_vehicleInfo,11),
SEL(_vehicleInfo,10),
if(_trunkSpace isEqualTo -1) then {"None"} else {_trunkSpace},
SEL(_vehicleInfo,12),
_vehicleColor,
_vehicleImpound,
_insure,
_headerPrice
];
if(SEL(_dataArr,5) isEqualTo 1)then
{
	ctrlShow [2804,true];
	ctrlShow [2805,true];
	ctrlShow [2807,true];
	if((SEL(_dataArr,2) isEqualTo 1) && !life_isImpound) then {
		ctrlEnable [2804,false];
		ctrlEnable [2805,false];
		ctrlEnable [2807,false];
	}else
	{
		ctrlEnable [2804,true];
		ctrlEnable [2805,true];
		ctrlEnable [2807,true];
	};
	ctrlShow [2806,false];
}else
{
	ctrlShow [2804,false];
	ctrlShow [2805,false];
	ctrlShow [2807,false];
	ctrlShow [2806,true];
};
ctrlShow [2803,true];
ctrlShow [2830,true];
if(playerSide != civilian)then{ctrlShow [2807,false];};
