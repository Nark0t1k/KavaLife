#include "..\..\script_macros.hpp"
/*
	File: fn_timerRadioSelection.sqf
	Author: Bryan "Tonic" Boardwine

*/
private ["_control", "_index", "_timer", "_anonyme", "_broadcastDelay", "_display", "_confirmBtn"];
_control = [_this,0,controlNull,[controlNull]] call BIS_fnc_param;
_index = [_this,1,-1,[0]] call BIS_fnc_param;

disableSerialization;
_display = findDisplay 100100;
_confirmBtn = _display displayCtrl 100104;
if(isNull _control) exitWith {closeDialog 0;}; //Bad data
if(_index isEqualTo -1) exitWith {}; //Nothing selected
_timer = CONTROL_DATAI(_control,_index);
_anonyme = cbChecked CONTROL(100100,100106);
if(_anonyme)then{_anonyme = 50000;}else{_anonyme = 0;};
switch(_timer)do
{
	case "15": {life_radioBroadCost = 150000 + _anonyme};
	case "30": {life_radioBroadCost = 250000 + _anonyme};
	case "45": {life_radioBroadCost = 350000 + _anonyme};
	case "60": {life_radioBroadCost = 500000 + _anonyme};
	
};
if(playerSide isEqualTo independent)then
{
	life_radioBroadCost = 10000;
};
if(playerSide isEqualTo west) then
{
	life_radioBroadCost = 20000;
};

if (isNil "life_broadcastTimer" || {(time - life_broadcastTimer) > 900}) then {
    _broadcastDelay = localize "STR_News_Now";
} else {
    _broadcastDelay = [(900 - (time - life_broadcastTimer))] call BIS_fnc_secondsToString;
    _confirmBtn ctrlEnable false;
};

if(life_HackRadio)then
{
	CONTROL(100100,100103) ctrlSetStructuredText parseText format[ localize "STR_News_StructuredText","Gratuit Pirater",_broadcastDelay];
}else
{
	if(life_KavaCash < life_radioBroadCost)then
	{
		_confirmBtn ctrlEnable false;
	}else
	{
		_confirmBtn ctrlEnable true;
	};
	CONTROL(100100,100103) ctrlSetStructuredText parseText format[ localize "STR_News_StructuredText",[life_radioBroadCost] call life_fnc_numberText,_broadcastDelay];
};