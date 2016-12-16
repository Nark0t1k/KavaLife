/*
	fn_bumpEffect.sqf
	By Nark0t1k And GreenTeam
*/
player switchMove "AmovPpneMstpSnonWnonDnon";
player setAnimSpeedCoef 0;

[] spawn
{
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [20]; 
	"dynamicBlur" ppEffectCommit 3; 
	enableCamShake true;    
	addCamShake [10, 15, 10];  
	player setFatigue 1;
	5 fadeSound 0.1;     
	sleep 1;
	"dynamicBlur" ppEffectEnable true; 
	"dynamicBlur" ppEffectAdjust [0]; 
	"dynamicBlur" ppEffectCommit 15; 
	resetCamShake; 
	20 fadeSound 1;	
};
sleep 1;
_e = 0;
while {true} do
{

	player setAnimSpeedCoef _e;
	sleep 2;
	_e = _e + 0.1;
	if(_e > 1) exitWith {player setAnimSpeedCoef 1;};
	
};



