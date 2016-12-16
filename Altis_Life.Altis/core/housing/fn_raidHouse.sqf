#include "..\..\script_macros.hpp"
/*
	File: fn_raidHouse.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Raids the players house?
*/
private["_house","_uid","_cpRate","_cP","_title","_titleText","_ui","_houseInv","_houseInvData","_houseInvVal"];
_house = param [0,ObjNull,[ObjNull]];

if(isNull _house OR !(_house isKindOf "House_F")) exitWith {};
if(isNil {(_house getVariable "house_owner")}) exitWith {hint localize "STR_House_Raid_NoOwner"};

_uid = SEL((_house getVariable "house_owner"),0);

if(!([_uid] call life_fnc_isUIDActive)) exitWith {hint localize "STR_House_Raid_OwnerOff"};

_houseInv = _house getVariable ["Trunk",[[],0]];
if(_houseInv isEqualTo [[],0]) exitWith {hint localize "STR_House_Raid_Nothing"};


_handle = [localize "STR_House_Raid_Searching",false,5,0.0075,0.26,"AinvPknlMstpSnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;sleep 0.2;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 


_houseInvData = SEL(_houseInv,0);
_houseInvVal = SEL(_houseInv,1);
_value = 0;
{
	_var = SEL(_x,0);
	_val = SEL(_x,1);
	
	if(EQUAL(ITEM_ILLEGAL(_var),1)) then {
		if(!(EQUAL(ITEM_SELLPRICE(_var),-1))) then {
			_houseInvData set[_forEachIndex,-1];
			SUB(_houseInvData,[-1]);
			SUB(_houseInvVal,(([_var] call life_fnc_itemWeight) * _val));
			ADD(_value,(_val * ITEM_SELLPRICE(_var)));
		};
	};
} foreach (SEL(_houseInv,0));

if(_value > 0) then {
	[[0,7],"STR_House_Raid_Successful",true,[[_value] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	ADD(life_KavaBank,round(_value / 2));
	
	_house setVariable ["Trunk",[_houseInvData,_houseInvVal],true];
	
	if(life_HC_isActive) then {
		[_house] remoteExecCall ["HC_fnc_updateHouseTrunk",HC_Life];
	} else {
		[_house] remoteExecCall ["TON_fnc_updateHouseTrunk",RSERV];
	};
	
} else {
	hint localize "STR_House_Raid_NoIllegal";
};
