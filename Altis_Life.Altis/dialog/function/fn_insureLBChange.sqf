#include "..\..\script_macros.hpp"
/*
	File: fn_insureLBChange.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Can't be bothered to answer it.. Already deleted it by accident..
*/
disableSerialization;
private ["_control", "_index", "_type", "_insureType", "_showName", "_multi", "_showInfo", "_className", "_price", "_priceColor"];
_control = SEL(_this,0);
_index = SEL(_this,1);

//Fetch some information.
_type = CONTROL_DATAI(_control,_index);
_insureType = (life_vInact_curTarget getVariable["dbInfo",[]]) select 2;

switch(_type)do
{
	case "light": {_showName = "Assurance Light";_multi = 0.4;_showInfo = "Assure le véhicule jusqu'a la prochaine remise au garage ou reboot du serveur";if(_insureType isEqualTo 0)then{ctrlEnable[3901,true];}else{ctrlEnable[3901,false];};};
	case "standard": {_showName = "Assurance Standard";_multi = 2;_showInfo = "Assure le véhicule jusqu'a sa prochaine destruction";if(_insureType < 2)then{ctrlEnable[3901,true];}else{ctrlEnable[3901,false];};};
	case "premium": {_showName = "Assurance Premium";_multi = 3;_showInfo = "Assure le véhicule jusqu'a sa prochaine destruction ou sa revente au chopshop";if(_insureType < 3)then{ctrlEnable[3901,true];}else{ctrlEnable[3901,false];};};
	case "omium": {_showName = "Assurance Full Omium";_multi = 4;_showInfo = "Assure le véhicule et sa marchandise (inventaire T) jusqu'a ca prochaine destruction ou revente au chopshop (le véhicule revient avec la marchandise au garage)";if(_insureType < 4)then{ctrlEnable[3901,true];}else{ctrlEnable[3901,false];};};
};

_className = typeOf life_vInact_curTarget;

_price = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),3)};
};
_price = _price * _multi;

if(_price < life_KavaBank)then{_priceColor = "#2EFE2E";}else{_priceColor = "#FF0000";};

(CONTROL(3900,3903)) ctrlSetStructuredText parseText format[
"Assurance: %1<br/>Prix: <t color='%4'>%2€</t><br/>Information: %3", _showName,[_price] call life_fnc_numberText,_showInfo,_priceColor];
