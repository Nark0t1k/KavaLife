#include "..\..\script_macros.hpp"
/*
	File: fn_adminSpectate.sqf
	Author: ColinM9991
	
	Description:
	Spectate the chosen player.
*/
if((call life_adminlevel) < 2) exitWith {closeDialog 0;};

private["_unit"];
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(_unit isEqualTo player) exitWith {hint localize "STR_ANOTF_Error";};

[] spawn {
  while {dialog} do {
   closeDialog 0;
   sleep 0.01;
  };
};

_unit switchCamera "INTERNAL";
hint format["You are now spectating %1 \n\n Press F10 to stop Spectating.",_unit getVariable["realname",name _unit]];
[format['[ADMIN] %1(%2) -Spectacle: %3(%4)',name player, getPlayerUID player, name _unit, getPlayerUID _unit],"ADMIN"] remoteExecCall ["A3Log",2];
AM_Exit = (findDisplay 46) displayAddEventHandler ["KeyDown","if((_this select 1) isEqualTo 68) then {(findDisplay 46) displayRemoveEventHandler ['KeyDown',AM_Exit];player switchCamera 'INTERNAL';hint 'You have stopped spectating';};false"];