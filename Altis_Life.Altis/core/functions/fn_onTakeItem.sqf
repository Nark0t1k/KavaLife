#include "..\..\script_macros.hpp"
/*
    File: fn_onTakeItem.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Blocks the unit from taking something they should not have.
*/
private["_unit","_item","_exit"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_container = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
_item = [_this,2,"",[""]] call BIS_fnc_param;

if(isNull _unit OR _item isEqualTo "") exitWith {}; //Bad thingies?
if((time - life_action_delay) > 1)then
{
	[format["[TAKEITEM] %1(%2) -ITEM: %3 -CONTAINER: %4 ",name _unit, getPlayerUID _unit,_item,_container]] remoteExecCall ["A3Log", 2];
};
life_action_delay = time;
switch(playerSide) do
{
	case west: {
		if(_item in ["U_Rangemaster","U_B_SpecopsUniform_sgg","U_B_CombatUniform_mcam_worn","B_Carryall_cbr"]) then {
			[] call life_fnc_playerSkins;
		};
	};
	case civilian: {
		//Currently stoping the civilians from taking the Rangemaster clothing from medics or cops.
		if(_item in ["U_Rangemaster"]) then {
			[_item,false,false,false,false] call life_fnc_handleItem;
		};
		// if(_item in ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Commoner1_1"]) then {
			// [] call life_fnc_playerSkins;
		// };
	};
	case independent: {
		if(_item in ["U_Rangemaster","B_TacticalPack_rgr"]) then {
			[] call life_fnc_playerSkins;
		};
	};
};
_exit = false;
if(_container in [copStorageBox1,copStorageBox2,copTempCont1,copTempCont2])then
{
	if(playerSide != west) exitWith {_exit = true;};
	if((player getVariable ["rank",0] < 6) && (_container in [copStorageBox1,copStorageBox2,copTempCont2]))exitWith {_exit = true;};
};
if(_exit) exitWith {hint "Vous ne pouvez pas prendre d'objet dans ce coffre";_container addItemCargoGlobal [_item, 1];player removeitem _item;player removeWeapon _item;closeDialog 0;};

if ((typeOf _container) in ["Box_IND_Grenades_F","B_supplyCrate_F"]) exitWith {

    if (life_HC_isActive) then {
        [_container] remoteExecCall ["HC_fnc_updateHouseContainers",HC_Life];
    } else {
        [_container] remoteExecCall ["TON_fnc_updateHouseContainers",RSERV];
    };

};