/*	
	fn_arrestDialog_Arrest.sqf
*/

private ["_time"];
if(playerSide != west) exitWith {};
if(isNil "life_pInact_curTarget") exitWith {hint parseText "Cible incorrect."};
//Get minutes
_time = ctrlText 1400;
if(! ([_time] call TON_fnc_isnumber)) exitWith{	hint parseText "Tu dois choisir un nombre correct en minute.";
};
_time = parseNumber _time;
 //requested number_time = round _time;
if(_time < 5 || _time > 60) exitWith { hint hint parseText "Tu peux seulement envoyer en prison pour 5-60 minutes!";
 };
closeDialog 0;
[format["[PRISON] %1(%2) -CIBLE: %3(%4) -DUREE: %5",name player, getPlayerUID player,name life_pInact_curTarget,getPlayerUID life_pInact_curTarget, _time]] remoteExecCall ["A3Log", 2];
[life_pInact_curTarget, _time] call life_fnc_arrestAction;
