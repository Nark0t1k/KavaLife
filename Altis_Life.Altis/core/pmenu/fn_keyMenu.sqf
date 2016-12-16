#include "..\..\script_macros.hpp"
/*
	File: fn_keyMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the key menu
	Will be revised.
*/
private["_display","_vehicles","_plist","_near_units","_pic","_name","_text","_color","_index"];
disableSerialization;
_type = _this select 0;
createDialog "Life_key_management";
waitUntil {!isNull (findDisplay 2700)};
_display = findDisplay 2700;
_vehicles = _display displayCtrl 2701;
lbClear _vehicles;
ctrlShow[2703,false];
if(_type)then
{
	ctrlShow[2703,true];
};

for "_i" from 0 to (count life_vehicles)-1 do {
	_veh = life_vehicles select _i;
	if(!isNull _veh && alive _veh) then {
		_color = SEL(SEL(M_CONFIG(getArray,"LifeCfgVehicles",(typeOf _veh),"textures"),(_veh getVariable "Life_VEH_color")),0);
		if(isNil "_color") then {_color = ""};
		_text = format["(%1)",_color];
		if(_text isEqualTo "()") then {
			_text = "";
		};
		
		_name = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
		_pic = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "picture");
		_vehicles lbAdd format["%1 %3 - [Distance: %2m]",_name,round(player distance _veh),_text];
		if(_pic != "pictureStaticObject") then {
			_vehicles lbSetPicture [(lbSize _vehicles)-1,_pic];
		};
		_vehicles lbSetData [(lbSize _vehicles)-1,str(_i)];
	};
};

if(((lbSize _vehicles)-1) isEqualTo -1) then {
	_vehicles lbAdd "Tu n'as pas de clefs de vehicule";
	_vehicles lbSetData [(lbSize _vehicles)-1,str(ObjNull)];
};
