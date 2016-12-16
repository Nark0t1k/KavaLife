#include "..\..\script_macros.hpp"
#define INUSE(ENTITY) ENTITY setVariable ["inUse",false,true]
/*
	File: fn_pickupItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master handling for picking up an item.
*/
private ["_itemInfo","_itemName","_illegal","_diff"];
if (isNull (findDisplay 1520)) exitWith {};

_obj = objNull;
if ((lbCurSel 1521) > -1) then
{
	_obj = life_pickup_item_array select (lbCurSel 1521);
};

if(isNil "_obj" OR isNull _obj OR isPlayer _obj) exitWith {};
random sleep 1;
if(_obj getVariable ["inUse",false]) exitWith {["Tu ne peux pas faire cela pour le moment"] call life_fnc_showNotification;};
_obj setVariable ["inUse",true,true];
if((time - life_action_delay) < 2) exitWith {hint localize "STR_NOTF_ActionDelay"; INUSE(_obj);};

_itemInfo = _obj getVariable ["item",[]]; if(EQUAL(count _itemInfo,0)) exitWith {deleteVehicle _obj;};
_itemName = SEL(_itemInfo,0);
if (_itemName isEqualTo "money") exitWith { _obj call life_fnc_pickupMoney; };
_illegal = ITEM_ILLEGAL(SEL(_itemInfo,0));

if(playerSide isEqualTo west && (EQUAL(_illegal,1))) exitWith {
	[format[localize "STR_NOTF_PickedEvidence",_itemName,[round(ITEM_SELLPRICE(SEL(_itemInfo,0)) / 2)] call life_fnc_numberText]] call life_fnc_showNotification;
	ADD(life_KavaBank,round(ITEM_SELLPRICE(SEL(_itemInfo,0)) / 2));
	deleteVehicle _obj;
	life_action_delay = time;
};

life_action_delay = time;
_diff = [SEL(_itemInfo,0),SEL(_itemInfo,1),life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff <= 0) exitWith {hint localize "STR_NOTF_InvFull"; INUSE(_obj);};

if(!(EQUAL(_diff,SEL(_itemInfo,1)))) then {
	if(([true,SEL(_itemInfo,0),_diff] call life_fnc_handleInv)) then {
		player playMove "AinvPknlMstpSlayWrflDnon";
		
		_obj setVariable ["item",[SEL(_itemInfo,0),(SEL(_itemInfo,1)) - _diff],true];
		[format[localize "STR_NOTF_Picked",_diff,localize _itemName]] call life_fnc_showNotification;
		[format["[RAMASSE.ITEM] %1(%2) a ramasser %3 %4",name player, getPlayerUID player,SEL(_itemInfo,1),SEL(_itemInfo,0)]] remoteExecCall ["A3Log", 2];
		INUSE(_obj);
	} else {
		INUSE(_obj);
	};
} else {
	if(([true,SEL(_itemInfo,0),SEL(_itemInfo,1)] call life_fnc_handleInv)) then {
		deleteVehicle _obj;
		//waitUntil{isNull _obj};
		player playMove "AinvPknlMstpSlayWrflDnon";
		[format["[RAMASSE.ITEM] %1(%2) a ramasser %3 %4",name player, getPlayerUID player,SEL(_itemInfo,1),SEL(_itemInfo,0)]] remoteExecCall ["A3Log", 2];
		[format[localize "STR_NOTF_Picked",_diff,localize _itemName]] call life_fnc_showNotification;
	} else {
		INUSE(_obj);
	};
};