#include "..\..\script_macros.hpp"
/*
	fn_deleteMess.sqf
*/
private["_cMessageList","_display"];
if(life_HC_isActive) then {
	[player] remoteExecCall ["HC_fnc_deleteMessages",HC_Life];
}else
{
	[player] remoteExecCall ["TON_fnc_deleteMessages",RSERV];
};
disableSerialization;
waitUntil {!isNull findDisplay 88000};
_display = findDisplay 88000;
life_messageTo = "";
_cMessageList = _display displayCtrl 88003;
_cMessageDetail = _display displayCtrl 88004;
lnbClear _cMessageList;
_cMessageDetail ctrlSetStructuredText parseText "Vous n'avez aucun message";