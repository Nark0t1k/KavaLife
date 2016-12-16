#include "..\..\script_macros.hpp"
/*
	File: fn_hackRadio.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Breaks the lock on a single door (Closet door to the player).
*/
private ["_marker", "_ui", "_progressBar", "_titleText", "_cP"];

if(life_HackRadio)exitWith {hint parseText "Tu as déja hacké la tour radio";};
//Setup the progress bar
[] spawn
{
	_marker = createMarker [format["%1_markerHack",player],getPosWorld player];
	_marker setMarkerColor "ColorRed";
	_marker setMarkerType "mil_warning";
	_marker setMarkerText "Piratage en cours!";
	sleep 180;
	deleteMarker _marker;
};

_handle = [format["Piratage en cours (1%1)...","%"],false,5,0.003,0.26,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

hint parseText "Tu as piraté l'antenne radio tu peux maintenant envoyer des message sans payer pendant 2 minutes";
life_HackRadio = true;
// [4] call life_fnc_removeLicenses;
if(life_HC_isActive) then {
	[getPlayerUID player,profileName,"459"] remoteExecCall ["HC_fnc_wantedAdd",HC_Life];
} else {
	[getPlayerUID player,profileName,"459"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
};

sleep 120;
life_HackRadio = false;