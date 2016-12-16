#include "..\..\script_macros.hpp"
/*
    File: fn_inventoryClosed.sqf
    Author: Bryan "Tonic" Boardwine
    Modified : NiiRoZz

    Description:
    1 : Used for syncing house container data but when the inventory menu
    is closed a sync request is sent off to the server.
    2 : Used for syncing vehicle inventory when save vehicle gear are activated
*/
private "_container";
_container = param [1,ObjNull,[ObjNull]];
if (isNull _container) exitWith {}; //MEH

if(_container in [copStorageBox1,copStorageBox2,copTempCont1,copTempCont2])then
{
	_container setVariable ["trunk_in_use",false,true];
};

if (((typeOf _container) in ["Box_IND_Grenades_F","B_supplyCrate_F"]) || (_container isEqualTo copTempCont2)) exitWith {

    if (life_HC_isActive) then {
        [_container] remoteExecCall ["HC_fnc_updateHouseContainers",HC_Life];
    } else {
        [_container] remoteExecCall ["TON_fnc_updateHouseContainers",RSERV];
    };

};
