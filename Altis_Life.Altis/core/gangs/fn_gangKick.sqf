#include "..\..\script_macros.hpp"
/*
    File: fn_gangKick.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    32 hours...
*/
private ["_unit", "_unitID", "_online", "_members", "_unitIDT", "_QGName"];
disableSerialization;
_unit = objNull;
if ((lbCurSel 2621) isEqualTo -1) exitWith {hint localize "STR_GNOTF_SelectKick"};
_unitID = CONTROL_DATA(2621);
_unitID = call compile format["%1", _unitID];
if((count (life_gangQG getVariable ["gang_war",[]])) != 0)exitWith {hint localize "STR_GNOTF_CantKick";};
_online = false;
{
	if((getPlayerUID _x) isEqualTo _unitID)exitWith {_online=true;_unit=_x;};
}forEach playableUnits;
if ((_unit isEqualTo player) && _online) exitWith {hint localize "STR_GNOTF_KickSelf"};

_members = life_gangQG getVariable "gang_members";
if (isNil "_members") exitWith {};
if (!(_members isEqualType [])) exitWith {};
_unitIDT = getPlayerUID player;
_members = _members - [_unitID];
life_gangQG setVariable ["gang_members",_members,true];
if(_online)then
{
	[_unit] remoteExec ["TON_fnc_clientGangKick",_unit]; //Boot that bitch!
};
_QGName = life_gangQG getVariable ["gang_name",""];
if (life_HC_isActive) then {
    [4,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
} else {
    [4,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
};
{
	if(!isNil {_x getVariable "gang_name"})then
	{
		if((_x getVariable "gang_name") isEqualTo _QGName)then
		{
			if(life_HC_isActive) then {
				[_x,getPlayerUID _x,_members] remoteExecCall ["HC_fnc_queryPlayerFullGang",HC_Life];
			}else
			{
				[_x,getPlayerUID _x,_members] remoteExec ["TON_fnc_queryPlayerFullGang",RSERV];
			};
		};
	};
} forEach playableUnits;

// [] call life_fnc_gangMenu;
