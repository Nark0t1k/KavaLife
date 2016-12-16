#include "..\..\script_macros.hpp"
/*
	File: fn_chopShopSell.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sells the selected vehicle off.
*/
disableSerialization;
private["_control","_price","_vehicle","_nearVehicles","_dbInfo","_vehType"];
closeDialog 0;
_control = CONTROL(39400,39402);
_price = _control lbValue (lbCurSel _control);
_vehicle = _control lbData (lbCurSel _control);
_vehicle = call compile format["%1", _vehicle];
_nearVehicles = nearestObjects [getMarkerPos life_chopShop,["Car","Truck"],25];
_vehicle = SEL(_nearVehicles,_vehicle);
_vehicle setVariable ["uidSelling",getPlayerUID player,true];
[localize "STR_Shop_ChopShopSelling"] call life_fnc_showNotification;
if((_vehicle getVariable ["uidSelling",""]) != (getPlayerUID player)) exitWith {closeDialog 0;hint "Le vehicule est deja en cours de vente par une autre personne";};
if(isNull _vehicle) exitWith {};
_displayName = FETCH_CONFIG2(getText,"CfgVehicles",typeOf _vehicle, "displayName");
_dbInfo = _vehicle getVariable ["dbInfo",[]];
_vehType = typeOf _vehicle;
if((_vehicle getVariable ["uidSelling",""]) != (getPlayerUID player)) exitWith {closeDialog 0;hint "Le vehicule est deja en cours de vente par une autre personne";};
deleteVehicle _vehicle;

ADD(life_KavaCash,_price);

if(license_civ_rebel)then
{
	if(_vehType in ["I_Truck_02_transport_F","I_Truck_02_covered_F","B_Truck_01_transport_F","B_Truck_01_box_F","O_Truck_03_transport_F","O_Truck_03_covered_F","O_Truck_03_device_F","I_Truck_02_fuel_F","B_Truck_01_fuel_F"])then
	{
		[true,"truckWheel",1] call life_fnc_handleInv;
	};
};

life_action_inUse = false;
[7,format[(localize "STR_NOTF_ChopSoldCar"),_displayName,[_price] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",player];
closeDialog 0;
[] call life_fnc_hudUpdate;
[0] call SOCK_fnc_updatePartial;
[format["[VENTECHOPVEH] %1(%2) -VEHICULE: %3 -PRIX: %4 -CASH AVANT: %5 -CASH APRES: %6",name player, getPlayerUID player, _displayName, [_price] call life_fnc_numberText, [life_KavaCash] call life_fnc_numberText,[life_KavaCash+_price] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
if (count _dbInfo isEqualTo 0) exitWith {};
if(life_HC_isActive) then {
	[player,_dbInfo] remoteExecCall ["HC_fnc_chopShopSell",HC_Life];
} else {
	[player,_dbInfo] remoteExecCall ["TON_fnc_chopShopSell",RSERV];
};


