#include "..\..\script_macros.hpp"
/*
	fn_rebStopMessage.sqf
	By Nark0t1k
*/
private ["_hasLicHelico", "_hasLicBoat", "_hasLicTruck", "_hasLicCar", "_toShow", "_info", "_rank", "_name"];
_toShow = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if((time - life_action_delay) < 3) exitWith {};
life_action_delay = time;
if(isNull _toShow) exitWith {};

_info = format["<img size='10' image='textures\stopRebel.paa'/><br/>
<t color='#FFCC00'><t size='1.3'><t align='center'>Menace Rebel<br/></t></t></t><br/>
<t align='left'><t size='1.4'><t color='#33CC33'>Un rebel vient de te menacer!!!</t></t></t>"];

if((_toShow isKindOf "Ship") || (_toShow isKindOf "Air") || (_toShow isKindOf "Car")) then
{
	_pList = crew _toShow;
	[3,format["%1",_info]] remoteExecCall ["life_fnc_broadcast",_pList];

}else
{
	if(isPlayer _toShow)then
	{
		[3,format["%1",_info]] remoteExecCall ["life_fnc_broadcast",_toShow];
	};
};
[player,"warnRebel",300] remoteExec ["life_fnc_playSound",RCLIENT];
[3,format["%1",_info]] remoteExecCall ["life_fnc_broadcast",player];


