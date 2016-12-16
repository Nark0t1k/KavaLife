/*
	toxicArea.sqf
	by Nark0t1k
*/
private["_unit","_oldDamage"];
if(isDedicated) exitWith {diag_log "KAVALOG WTF HOLSTER WHY THIS IS RUNNING???";};
if(isServer) exitWith {diag_log "KAVALOG WTF HOLSTER WHY THIS IS RUNNING???";};
_unit = player;
_oldDamage = 0;
if((player distance (getMarkerPos "fred_reserve")) > 325) exitWith {};
if(life_toxicArea) exitWith {};
life_toxicArea = true;
if(uniform player != "U_C_Scientist") then
{
	hint parseText "Vous commencez a resentir les effects des radiations";
}else
{
	hint parseText "Vous commencez a resentir les effects des radiations mais votre combinaison devrais vous proteger";
};
sleep 5;
while {true} do
{
	if((player distance (getMarkerPos "fred_reserve")) > 325) exitWith {};
	if(uniform player != "U_C_Scientist") then
	{
		_oldDamage = damage _unit;
		_oldDamage = _oldDamage + 0.1;
		if(_oldDamage > 1) then {_oldDamage = 1;};
		_unit setDamage _oldDamage;
		hint parseText "La radiations est trop forte vous ne pouvez rester ici sans equipement!";
	};
	if((player distance (getMarkerPos "fred_reserve")) > 325) exitWith {};
	sleep 15;
};
life_toxicArea = false;