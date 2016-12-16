#include "..\..\script_macros.hpp"
/*
	fn_repaintColorLoad.sqf
*/


private ["_className", "_veh", "_classNameLife", "_ctrl", "_colorArray", "_flagPlayer", "_flag", "_textureName"];
if(isNull (findDisplay 2300)) exitWith {};

_index = lbValue[2302,lbCurSel 2302];
_vehicle = (nearestObjects[getPos player,["Car","Air","Ship"],6]) select _index;
_className = typeOf _vehicle; 
_classNameLife = _className;

_ctrl = CONTROL(2300,2303);
lbClear _ctrl;

if(!isClass (missionConfigFile >> "LifeCfgVehicles" >> _classNameLife)) then {
	_classNameLife = "Default"; //Use Default class if it doesn't exist
	diag_log format["%1: LifeCfgVehicles class doesn't exist",_className];
};
_colorArray = M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"textures");

_flagPlayer = switch(playerSide) do {case west:{"cop"}; case civilian:{"civ"}; case independent:{"med"};};
if(playerSide isEqualTo independent) then
{
	if((FETCH_CONST(life_medicLevel)) in [0,1]) exitWith {_flagPlayer="med";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 2) exitWith {_flagPlayer="mecano";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 3) exitWith {_flagPlayer="merce";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 4) exitWith {_flagPlayer="conces";};
};

{
	_flag = SEL(_x,1);
	_textureName = SEL(_x,0);
	if(EQUAL(_flagPlayer,_flag)) then {
		_ctrl lbAdd _textureName;
		_ctrl lbSetValue [(lbSize _ctrl)-1,_forEachIndex];
	};
} foreach _colorArray;

lbSetCurSel [2303,0];
if((lbSize 2303)-1 != -1) then
{
	ctrlShow[2303,true];
}
	else
{
	ctrlShow[2303,false];
};