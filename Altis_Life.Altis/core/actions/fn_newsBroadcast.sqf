#include "..\..\script_macros.hpp"
/*
    File: fn_newsBroadcast.sqf
    Author: Jesse "tkcjesse" Schultz
    Description:
    Creates the dialog and handles the data in the Channel 7 News Dialog.
*/

private ["_display", "_confirmBtn", "_timer", "_broadcastDelay"];

if((playerSide isEqualTo west) && ((player getVariable ["rank",0]) isEqualTo 0)) exitWith {hint "Tu ne peux pas faire cela.";};

if (!dialog) then {
    createDialog "life_news_broadcast";
};

disableSerialization;
_display = findDisplay 100100;
_confirmBtn = _display displayCtrl 100104;
_confirmBtn ctrlEnable false;

life_radioBroadCost = 150000;
if(playerSide isEqualTo independent)then
{
	life_radioBroadCost = 10000;
};
if(playerSide isEqualTo west) then
{
	life_radioBroadCost = 20000;
};
_timer = ((findDisplay 100100) displayCtrl 100105);
lbClear _timer;
_timer lbAdd "15 secondes - 150.000$";
_timer lbSetData [(lbSize _timer)-1,"15"];
_timer lbAdd "30 secondes - 250.000$";
_timer lbSetData [(lbSize _timer)-1,"30"];
if(!life_HackRadio && playerSide isEqualTo civilian)then
{
	_timer lbAdd "45 secondes - 350.000$";
	_timer lbSetData [(lbSize _timer)-1,"45"];
	_timer lbAdd "60 secondes - 500.000$";
	_timer lbSetData [(lbSize _timer)-1,"60"];
};
((findDisplay 100100) displayCtrl 100105) lbSetCurSel 0;
if ((life_KavaCash < life_radioBroadCost) && !life_HackRadio) then {
    [format[localize "STR_News_NotEnough",[life_radioBroadCost] call life_fnc_numberText]] call life_fnc_showNotification;
} else {
    _confirmBtn ctrlEnable true;
    _confirmBtn buttonSetAction "[ctrlText 100101,ctrlText 100102,profilename,false] call life_fnc_postNewsBroadcast; closeDialog 0;";
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
	CONTROL(100100,100103) ctrlSetStructuredText parseText format[ localize "STR_News_StructuredText",[life_radioBroadCost] call life_fnc_numberText,_broadcastDelay];
};
