#include "..\..\script_macros.hpp"
/*
	File: fn_giveMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the key menu
	Will be revised.
*/
private["_display","_vehicles","_plist","_near_units","_pic","_name","_text","_color","_index"];
disableSerialization;
if(life_is_processing)exitWith {hint "Vous ne pouvez pas faire cela pendant un traitement";};
createDialog "Life_give_item";
waitUntil {!isNull (findDisplay 3700)};
_inv = CONTROL(3700,3701);
lbClear _inv;


{
	if(ITEM_VALUE(configName _x) > 0) then {
		_weight = [(configName _x)] call life_fnc_itemWeight;
		_inv lbAdd format["%1x %2 [%3Kg]",ITEM_VALUE(configName _x),localize (getText(_x >> "displayName")),((ITEM_VALUE(configName _x))*_weight)];
		_inv lbSetData [(lbSize _inv)-1,configName _x];
		_icon = M_CONFIG(getText,"VirtualItems",configName _x,"icon");
		if(!(EQUAL(_icon,""))) then {
			_inv lbSetPicture [(lbSize _inv)-1,_icon];
		};
	};
} foreach ("true" configClasses (missionConfigFile >> "VirtualItems"));


if(((lbSize _inv)-1) isEqualTo -1) then {
	_inv lbAdd "Vous n'avez pas d'objet";
	_inv lbSetData [(lbSize _inv)-1,str(ObjNull)];
};
