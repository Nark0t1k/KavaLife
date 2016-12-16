/*
	File: fn_lacrymo.sqf
	Author: 
	
	Description:
	Handles flash-banging yeahhhh..
*/
if(!hasInterface && !isDedicated)exitWith {};
private["_pos","_bouuum","_time"];
_pos = [_this,0,[],[[]]] call BIS_fnc_param;
if(count _pos isEqualTo 0) exitWith {}; //Badddd

if(player distance _pos > 50) exitWith {}; //Bad again.
_bouuum = false;
_time = time + (1 * 60);

while {true} do
{
	if(player distance _pos < 10) then {
		if(!_bouuum)then
		{
			if (headgear player != "H_CrewHelmetHeli_B") then {
			_bouuum = true;
			"dynamicBlur" ppEffectEnable true; // enables ppeffect
			"dynamicBlur" ppEffectAdjust [20]; // intensity of blur
			"dynamicBlur" ppEffectCommit 3; // time till vision is fully blurred
			enableCamShake true;     // enables camera shake
			addCamShake [10, 45, 10];    // sets shakevalues
			player setFatigue 1; // sets the fatigue to 100%
			5 fadeSound 0.1;     // fades the sound to 10% in 5 seconds

			sleep 15;

			"dynamicBlur" ppEffectEnable true; // enables ppeffect
			"dynamicBlur" ppEffectAdjust [0]; // enables normal vision
			"dynamicBlur" ppEffectCommit 15; // time it takes to normal
			resetCamShake; // resets the shake
			20 fadeSound 1;	 //fades the sound back to normal
			_bouuum = false;
			};
		};
	}; //Bad again.
	sleep 1;
	if(round(_time - time) < 1) exitWith {};
};