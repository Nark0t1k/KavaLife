/*
	File: fn_radar.sqf
	Author: Silly Aussie kid named Jaydon
	
	Description:
	Looks like weird but radar?
*/
if(playerSide != west) exitWith {};
private ["_speed","_vehicle"];
_vehicle = param [0,Objnull,[Objnull]];
_speed = round speed _vehicle;

if((time - life_action_delay) < 5) exitWith {[localize "STR_NOTF_ActionDelay"] call life_fnc_showNotification;};
if(_vehicle isKindOf "Car") then
{
	if(_speed > life_radarSpeed)then
	{
		life_action_delay = time;
		hint parseText format ["<t color='#ffffff'><t size='2'><t align='center'>" +(localize "STR_Cop_Radar")+ "<br/><t color='#FF0000'><t align='center'><t size='1'>" +(localize "STR_Cop_VehSpeed")+ "<br/>Reglage Radar: %2",round  _speed,life_radarSpeed];
		if(count (crew _vehicle) isEqualto 0)exitWith {};
		[] remoteExec ["life_fnc_flashEffect",crew _vehicle];	
	}else
	{
		hint parseText format ["<t color='#ffffff'><t size='2'><t align='center'>" +(localize "STR_Cop_Radar")+ "<br/><t color='#33CC33'><t align='center'><t size='1'>" +(localize "STR_Cop_VehSpeed")+ "<br/>Reglage Radar: %2",round  _speed,life_radarSpeed];
	};
};