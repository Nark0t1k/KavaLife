#include "..\..\script_macros.hpp"
/*	File: fn_jailMe.sqf	
Author Bryan "Tonic" Boardwine		
Description:	Once word is received by the server the rest of the jail execution is completed.*/

private["_ret","_bad","_time","_bail","_esc","_countDown","_time"];
_ret = [_this,0,[],[[]]] call BIS_fnc_param;
_bad = [_this,1,false,[false]] call BIS_fnc_param;
_time = [_this,2,15,[0]] call BIS_fnc_param;
[player, getPlayerUID player, _time, life_is_arrested,life_is_alive] remoteExec ["life_fnc_JailPlayer",RSERV];

 _time = time + (_time * 60);

life_jailTimer = _time;
 
 if(count _ret > 0) then {life_bail_amount = (_ret select 3);} else {life_bail_amount = 20000;};
_esc = false;
_bail = false;
if(life_jailTimer <= 0) then {
	 life_jailTimer = time + (15 * 60);
	 hintC "Please Report to Admin: JAIL_FALLBACK_15, time is zero!";
};
[_bad,_time] spawn{
	_bad = [_this,0,false,[false]] call BIS_fnc_param;
	_time = [_this,1,15,[0]] call BIS_fnc_param;
	life_canpay_bail = false;
	life_bail_amount = life_bail_amount * 5;
	if(_bad) then	{
		sleep (_time * 0.5 );
	}
	else
	{		
		sleep (_time * 0.3 );
	};
	life_canpay_bail = nil;
};
player forceWalk true;
while {true} do{
	if(player distance (getMarkerPos "jail_marker") > 180) exitWith	{_esc = true;};
	if(life_bail_paid) exitWith	{_bail = true;};
	if((round(life_jailTimer - time)) < 1) exitWith {hint parseText ""};
	if(!alive player && ((round(life_jailTimer - time)) > 0)) exitWith{};
	sleep 1;
};
switch (true) do{
	case (_bail) :{
		life_bail_paid = false;
		[localize "STR_Jail_Paid"] call life_fnc_showNotification;
		serv_wanted_remove = [player];
		player setPos (getMarkerPos "jail_release");
		[getPlayerUID player] remoteExecCall ["life_fnc_wantedRemove",RSERV];
		player addUniform "U_C_Poloshirt_blue";
		player addItem "ItemMap";
		player assignItem "ItemMap";
		player addItem "ItemCompass";
		player assignItem "ItemCompass";
		player addItem "ItemWatch";
		player assignItem "ItemWatch";
	};
	case (_esc) :{
		[localize "STR_Jail_EscapeSelf"] call life_fnc_showNotification;
		[[0,7],format["%1 c est echappe de prison!",profileName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
		[getPlayerUID player,profileName,"901"] remoteExecCall ["life_fnc_wantedAdd",RSERV];
	};
	case (alive player && !_esc && !_bail) :{
		[localize "STR_Jail_Released"] call life_fnc_showNotification;
		[getPlayerUID player] remoteExecCall ["life_fnc_wantedRemove",RSERV];
		player setPos (getMarkerPos "jail_release");
		player addUniform "U_C_Poloshirt_blue";
		player addItem "ItemMap";
		player assignItem "ItemMap";
		player addItem "ItemCompass";
		player assignItem "ItemCompass";
		player addItem "ItemWatch";
		player assignItem "ItemWatch";
	};
};
life_is_arrested = false;
[false,"dechet",life_inv_dechet] call life_fnc_handleInv;
[5] call SOCK_fnc_updatePartial;
[3] call SOCK_fnc_updatePartial;
[player, getPlayerUID player, 0, life_is_arrested,life_is_alive] remoteExec ["life_fnc_JailPlayer",RSERV];
player forceWalk false;
