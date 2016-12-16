#include "..\..\script_macros.hpp"
/*
    File: fn_gangNewLeader.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Something about being a quitter.
*/
private["_unit","_unitID","_members","_action","_index"];
disableSerialization;
_unit = objNull;
if ((lbCurSel 2621) isEqualTo -1) exitWith {hint localize "STR_GNOTF_TransferSelect"};
_unitID = CONTROL_DATA(2621);
_unitID = call compile format["%1", _unitID];
_online = false;
{
	if((getPlayerUID _x) isEqualTo _unitID)exitWith {_online=true;_unit=_x;};
}forEach playableUnits;
if ((isNull _unit) && _online) exitWith {}; //Bad unit?
if ((_unit isEqualTo player) && _online) exitWith {hint localize "STR_GNOTF_TransferSelf"};

_action = [
    localize "STR_GNOTF_TransferMSG",
    localize "STR_Gang_Transfer",
    localize "STR_Global_Yes",
    localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if (_action) then {
    if (_unitID isEqualTo "") exitWith {hint localize "STR_GNOTF_badUID";}; //Unlikely?
    life_gangQG setVariable ["gang_owner",_unitID,true];
    group player selectLeader _unit;
	if(_online)then
	{
		[_unit] remoteExec ["TON_fnc_clientGangLeader",_unit]; //Boot that bitch!
	};
    if (life_HC_isActive) then {
        [3,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life]; //Update the database.
    } else {
        [3,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV]; //Update the database.
    };

} else {
    hint localize "STR_GNOTF_TransferCancel";
};
closeDialog 0;
[] call life_fnc_gangMenu;
