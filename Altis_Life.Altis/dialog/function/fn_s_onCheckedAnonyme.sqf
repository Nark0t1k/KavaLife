#include "..\..\script_macros.hpp"
/*
	Author: Nark0t1k inspired by Tonic
	fn_s_onCheckedAnonyme.sqf
*/
private ["_state", "_timer", "_broadcastDelay", "_display", "_confirmBtn"];
_state = SEL(_this,0);
disableSerialization;
_display = findDisplay 100100;
_confirmBtn = _display displayCtrl 100104;
_timer = lbData [100105,lbCurSel 100105];
if(_state isEqualTo 1)then{_state = 50000;}else{_state = 0;};
switch(_timer)do
{
	case "15": {life_radioBroadCost = 150000 + _state};
	case "30": {life_radioBroadCost = 250000 + _state};
	case "45": {life_radioBroadCost = 350000 + _state};
	case "60": {life_radioBroadCost = 500000 + _state};
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