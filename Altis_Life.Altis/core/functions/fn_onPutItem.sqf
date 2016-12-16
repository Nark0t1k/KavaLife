#include "..\..\script_macros.hpp"
/*
    File: fn_onPutItem.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Syncs changes to containers in houses?
*/
private["_unit","_item","_house","_container"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_container = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
_item = [_this,2,"",[""]] call BIS_fnc_param;

if (isNull _unit || _item isEqualTo "") exitWith {}; //Bad thingies?
if(_container isEqualTo copTempCont1)then
{
	
	clearWeaponCargoGlobal copTempCont1;
	clearMagazineCargoGlobal copTempCont1;
	clearBackpackCargoGlobal copTempCont1;
	clearItemCargoGlobal copTempCont1;
	copTempCont2 addItemCargoGlobal [_item, 1];
	if (life_HC_isActive) then {
        [copTempCont2] remoteExecCall ["HC_fnc_updateHouseContainers",HC_Life];
    } else {
        [copTempCont2] remoteExecCall ["TON_fnc_updateHouseContainers",RSERV];
    };
};