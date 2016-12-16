#include "..\..\script_macros.hpp"
/*
	File: fn_adminSleepPlayer.sqf
*/
private["_admin","_timer","_flashDur"];

if(dialog) then {closeDialog 0;};
if(dialog) then {closeDialog 0;};
if(dialog) then {closeDialog 0;};
if(dialog) then {closeDialog 0;};

player allowDamage false;
hint parseText "Vous sentez quelque chose de ... magique dans l'air!";
if(vehicle player != player) then
{
	if((vehicle player) isKindOf "Landvehicle") then
	{
		(vehicle player) setVelocity [0, 0, 0];
		sleep 0.3;
		player action["eject",vehicle player];
	}
};
sleep 2.7;
(vehicle player) setVelocity [0, 0, 0];
disableUserInput true;
player switchMove "AinjPpneMstpSnonWnonDnon";
hint parseText "Il se passe vraiment quelque chose d'etrange ici!";
sleep 3;
playSound "sleepAdmin";
_timer = 30;
_flashDur = 1;
while {true} do
{

	titleText ["", "BLACK OUT"];
	sleep _flashDur;
	titleText ["", "BLACK IN"];
	sleep 1.5;
	
	_flashDur = _flashDur + 0.5;
	
	_timer = _timer - _flashDur - 1.5;
	if(_timer <= 0)exitWith {titleText ["Vous ne savez pas pourquoi mais ... vous vous êtes endormi?!?", "BLACK OUT"];};
};
player switchMove "AinjPpneMstpSnonWnonDnon";
// player playMoveNow "AinjPpneMstpSnonWnonDnon";
sleep 50;
titleText ["", "BLACK IN"];
hint parseText "Vous etes reveillé, apparement cette étrange phénomène n'a touché que les personnes présente dans la zone, il vaudrait mieux quitter cette zone";
player allowDamage true;
disableUserInput false;
player switchMove "AmovPercMstpSlowWrflDnon_SaluteIn";