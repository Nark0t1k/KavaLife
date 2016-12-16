#include "..\..\script_macros.hpp"
/*
	File: fn_vehicleShopBuy.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Does something with vehicle purchasing.
*/
private["_gFund","_mode","_spawnPoints","_action","_shop","_className","_basePrice","_multiplicator","_colorIndex","_spawnPoint","_vehicle","_shopSide","_licenses","_licensesName","_exit"];
_mode = SEL(_this,0);
_gFund = 0;
if(_mode && (life_vehGarage >= life_vehGarageMax)) exitWith {[format["Tu ne peux avoir que %1 véhicule dans ton garage.",life_vehGarageMax]] call life_fnc_showNotification;};
_shop = uiNamespace getVariable ["Weapon_Shop",""];
_exit = false;
if((lbCurSel 2302) isEqualTo -1) exitWith {[localize "STR_Shop_Veh_DidntPick"] call life_fnc_showNotification;closeDialog 0;};
_className = lbData[2302,(lbCurSel 2302)];
_vIndex = lbValue[2302,(lbCurSel 2302)];
_classNameLife = _className;
_vehicleList = M_CONFIG(getArray,"CarShops",SEL(life_veh_shop,0),"vehicles");
_shopSide = M_CONFIG(getText,"CarShops",SEL(life_veh_shop,0),"side");

_licenses = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"licenses"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"licenses"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"licenses"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"licenses"),3)};
};

_basePrice = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"rentalprice"),3)};
};
_multiplicator = LIFE_SETTINGS(getNumber,"vehicleShop_BuyMultiplicator");
 if(_mode) then {_basePrice = round(_basePrice * _multiplicator)};
_colorIndex = lbValue[2304,(lbCurSel 2304)];

_licensesName = "";
{
	if(!(EQUAL(_x,"")) && {!(LICENSE_VALUE(_x,_shopSide))}) then {
		ADD(_licensesName,localize M_CONFIG(getText,"Licenses",_x,"displayName") + "<br/>");
		_exit = true;
	};
} foreach _licenses;

if(395180 in getDLCs 2)then
{
	[localize "STR_Shop_Veh_NoApex"] call life_fnc_showNotification;
};

if(_exit)then
{
	_action = [
	"Tu n'as pas le permis pour ce véhicule est tu sur de vouloir l'acheter?",
	"Pas de permis",
	"Acheter",
	"Refuser"
	] call BIS_fnc_guiMessage;
	if(_action) then {_exit=false;}else{_exit=true;};
};

if(_exit) exitWith {[format[(localize "STR_Shop_Veh_NoLicense")+ "<br/><br/>%1",_licensesName]] call life_fnc_showNotification;closeDialog 0;};

if(life_inv_cartevisa != 0) then
{
	_action = [
	"Acheter le bien par carte bancaire?",
	"Carte bancaire",
	"Oui",
	"Non"
	] call BIS_fnc_guiMessage;
	if(_action) then {_exit=true;}else{_exit=false;};
};
if(_basePrice < 0) exitWith {closeDialog 0;}; //Bad price entry
if((life_KavaBank < _basePrice) && _exit) exitWith {[format[localize "STR_Shop_Veh_NotEnough",[_basePrice - life_KavaBank] call life_fnc_numberText]] call life_fnc_showNotification;closeDialog 0;};
if((life_KavaCash < _basePrice) && !_exit) exitWith {[format[localize "STR_Shop_Veh_NotEnough",[_basePrice - life_KavaCash] call life_fnc_numberText]] call life_fnc_showNotification;closeDialog 0;};

_spawnPoints = SEL(life_veh_shop,1);
_spawnPoint = "";

if((SEL(life_veh_shop,0) isEqualTo "med_air_hs")) then {
	if(count(nearestObjects[(getMarkerPos _spawnPoints),["Air"],35]) isEqualTo 0) exitWith {_spawnPoint = _spawnPoints};
} else {
	//Check if there is multiple spawn points and find a suitable spawnpoint.
	if(EQUAL(typeName _spawnPoints,typeName [])) then {
		//Find an available spawn point.
		{if(count(nearestObjects[(getMarkerPos _x),["Car","Ship","Air"],10]) isEqualTo 0) exitWith {_spawnPoint = _x};} forEach _spawnPoints;
	} else {
		if(count(nearestObjects[(getMarkerPos _spawnPoints),["Car","Ship","Air"],10]) isEqualTo 0) exitWith {_spawnPoint = _spawnPoints};
	};
};


if(EQUAL(_spawnPoint,"")) exitWith {[localize "STR_Shop_Veh_Block"] call life_fnc_showNotification;closeDialog 0;};

if(_exit)then
{
	SUB(life_KavaBank,_basePrice);
}else
{
	SUB(life_KavaCash,_basePrice);
};

[format[localize "STR_Shop_Veh_Bought",getText(configFile >> "CfgVehicles" >> _className >> "displayName"),[_basePrice] call life_fnc_numberText]] call life_fnc_showNotification;

//Spawn the vehicle and prep it.
if((life_veh_shop select 0) isEqualTo "med_air_hs") then {
	_vehicle = createVehicle [_className,(_hs modelToWorld [-0.4,-4,12.65]),[], 0, "NONE"];
	
	waitUntil {!isNil "_vehicle" && {!isNull _vehicle}}; //Wait?
	_vehicle allowDamage false;
	_hs = nearestObjects[getMarkerPos _spawnPoint,["Land_Hospital_side2_F"],50] select 0;
	_vehicle setPosATL (_hs modelToWorld [-0.4,-4,12.65]);
	sleep 0.6;
} else {
	_vehicle = createVehicle [_className, (getMarkerPos _spawnPoint), [], 0, "NONE"];
	waitUntil {!isNil "_vehicle" && {!isNull _vehicle}}; //Wait?
	_vehicle allowDamage false; //Temp disable damage handling..
	_vehicle setPos (getMarkerPos _spawnPoint);
	_vehicle setVectorUp (surfaceNormal (getMarkerPos _spawnPoint));
	_vehicle setDir (markerDir _spawnPoint);
};
_vehicle lock 2;
[_vehicle,_colorIndex] call life_fnc_colorVehicle;
[_vehicle] call life_fnc_clearVehicleAmmo;
[_vehicle,"trunk_in_use",false,true] remoteExecCall ["TON_fnc_setObjVar",RSERV];
[_vehicle,"vehicle_info_owners",[[getPlayerUID player,profileName]],true] remoteExecCall ["TON_fnc_setObjVar",RSERV];
_vehicle disableTIEquipment true; //No Thermals.. They're cheap but addictive.

//Side Specific actions.
switch(playerSide) do {
	case west: {
		[_vehicle,"cop_offroad",true] spawn life_fnc_vehicleAnimate;
	};

	case civilian: {
		if(EQUAL(SEL(life_veh_shop,2),"civ") && {_className isEqualTo "B_Heli_Light_01_F"}) then {
			[_vehicle,"civ_littlebird",true] spawn life_fnc_vehicleAnimate;
		};
	};

	case independent: {
		[_vehicle,"med_offroad",true] spawn life_fnc_vehicleAnimate;
	};
};

_vehicle allowDamage true;

//life_vehicles set[count life_vehicles,_vehicle]; //Add err to the chain.
life_vehicles pushBack _vehicle;
[getPlayerUID player,playerSide,_vehicle,1] remoteExecCall ["TON_fnc_keyManagement",RSERV];

if(_mode) then {
	life_vehGarage = life_vehGarage + 1;
	if(!(_className in ["B_G_Offroad_01_armed_F","B_MRAP_01_hmg_F","B_Boat_Armed_01_minigun_F","B_Heli_Transport_01_F"])) then {
	
		if(life_HC_isActive) then {
			[player,playerSide,_vehicle,_colorIndex] remoteExecCall ["HC_fnc_vehicleCreate",HC_Life];
		} else {
			[player,playerSide,_vehicle,_colorIndex] remoteExecCall ["TON_fnc_vehicleCreate",RSERV];
		};
	};
	[format["[ACHATVEH] %1(%2) -VEH: %3 -PRIX:%4",name player, getPlayerUID player,_className,_basePrice]] remoteExecCall ["A3Log", 2];
}else
{
	[format["[LOCATIONVEH] %1(%2) -VEH: %3 -PRIX:%4",name player, getPlayerUID player,_className,_basePrice]] remoteExecCall ["A3Log", 2];
};

if(_className in ["I_Truck_02_transport_F","I_Truck_02_covered_F","B_Truck_01_transport_F"]) then
{
	_vehicle enableRopeAttach false;
};
[6] call SOCK_fnc_updatePartial;
[] call life_fnc_hudUpdate;
closeDialog 0; //Exit the menu.
true;
