/*
	fn_getInVehicle.sqf
	manual getin to replace with new getin in 1.58
*/

private "_veh";
_veh = _this select 2;

if((((_veh getVariable ["dbInfo",[]]) select 2) isEqualTo 0) && (driver _veh isEqualTo player)) then 
{
	["NoInsured",["Le vehicule n'est pas assuré"]] call bis_fnc_showNotification;
};
if(!(currentWeapon player isEqualTo ""))then{life_curWep_h = nil;};
