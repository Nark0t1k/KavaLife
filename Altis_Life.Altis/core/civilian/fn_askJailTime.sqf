#include "..\..\script_macros.hpp"
/*
	fn_askJailTime.sqf
	By Nark0t1k
*/

private["_time","_countDown"];

_time = life_jailTimer;

_countDown = if(round (_time - time) > 60) then 
{
	format["%1 minute(s)",round(round(_time - time) / 60)]
} else {
	format["%1 second(s)",round(_time - time)]
};

if(isNil "life_canpay_bail") then
{
	hintSilent format["Time Remaining:\n %1\n\nCan pay Bail: %3\nBail Amount: $%2",_countDown,[life_bail_amount] call life_fnc_numberText];
}
else
{
	hintSilent format["Time Remaining:\n %1\n",_countDown];
};
_time = round(round(_time - time) / 60);
if(_time < 0) then {_time = 0;};
[player, getPlayerUID player, _time, life_is_arrested,life_is_alive] remoteExec ["life_fnc_JailPlayer",RSERV];