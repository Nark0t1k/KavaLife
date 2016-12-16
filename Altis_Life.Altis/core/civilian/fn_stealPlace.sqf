#include "..\..\script_macros.hpp"
/*
	fn_stealPlace.sqf

*/
private["_target","_rdm","_money"];
_target = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(currentWeapon player isEqualTo "") exitWith {hint parseText "Tu ne peux pas braquer la station service sans arme";};
if(_target getVariable ["steal", FALSE])exitWith {hint parseText "La station à déja été braqué il y peu tu dois attendre..";};
_target setVariable ["steal", true, true];
hint parseText "Tu braque la station service";
[[3,7],"Une station service se fait braqué"] remoteExecCall ["life_fnc_broadcast",west];
sleep 180;
if(player distance _target > 25)exitWith {_target setVariable ["steal", false, true];hint parseText "Tu es trop loins de la station pour finir le braquage";};
_rdm = floor(random 40000);
_money = 10000 +_rdm;
hint format["Tu as braque la station service et gagner: %1$", _money];
ADD(life_KavaCash,_money);
if(life_HC_isActive) then {
	[_target] remoteExec ["HC_fnc_stealTimer",HC_Life];
}else
{
	[_target] remoteExec ["TON_fnc_stealTimer",RSERV];
};
[] call life_fnc_hudUpdate;