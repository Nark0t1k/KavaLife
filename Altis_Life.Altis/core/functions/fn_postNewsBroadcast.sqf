#include "..\..\script_macros.hpp"
/*
    File: fn_postNewsBroadcast.sqf
    Author: Jesse "tkcjesse" Schultz
    Description:
    Handles actions after the broadcast button is clicked.
*/
private ["_broadcastHeader", "_broadcastMessage", "_timer", "_length", "_characterByte", "_allowed", "_allowedLength", "_badCharacter", "_anonyme", "_nameShow"];
disableSerialization;
if ((life_KavaCash < life_radioBroadCost) && !life_HackRadio) then {hint parseText "Tu n'as pas assez d'argent";};
_broadcastHeader = ctrlText (CONTROL(100100,100101));
_broadcastMessage = ctrlText (CONTROL(100100,100102));
_timer = lbData [100105,lbCurSel 100105];
_length = count (toArray (_broadcastHeader));
_characterByte = toArray (_broadcastHeader);
_allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ ");
_allowedLength = 60;
_badCharacter = false;
_nameShow = "";
_timer = parseNumber _timer;
if (_length > _allowedLength) exitWith {hint format[localize "STR_News_HeaderLength",_allowedLength];};

{
    if (!(_x in _allowed)) exitWith {_badCharacter = true;};
} forEach _characterByte;

if (_badCharacter) exitWith {hint localize "STR_News_UnsupportedCharacter"};
_anonyme = cbChecked CONTROL(100100,100106);
if(playerSide isEqualTo west)then{_nameShow = "<t color='#002FE9'>Gendarmerie</t>";}else{_nameShow = format["%1",profileName];};
[_broadcastHeader,_broadcastMessage,_nameShow,_timer,_anonyme] remoteExec ['life_fnc_AAN',-2];
[format["[RADIODIF.PAYER] %1(%2) -A DIFFUSER %3 - %4",name player, getPlayerUID player,_broadcastHeader,_broadcastMessage]] remoteExecCall ["A3Log", 2];
if(!life_HackRadio)then
{
	life_KavaCash = life_KavaCash - life_radioBroadCost;
};
[0] call SOCK_fnc_updatePartial;
life_broadcastTimer = time;
publicVariable "life_broadcastTimer";