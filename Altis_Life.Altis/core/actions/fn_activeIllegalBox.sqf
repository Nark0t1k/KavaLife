#include "..\..\script_macros.hpp"
/*
	File : activeIllegalBox.sqf
	Author: NiiRoZz

	Description:
	Delete Container from house storage
*/
private ["_type","_vehicle", "_containerType", "_house", "_time", "_vehicle_data", "_inv", "_space", "_itemIndex", "_weight", "_sum", "_val", "_itemName", "_itemWeight", "_ressource"];
_vehicle = param [0,ObjNull,[ObjNull]];
_type = _this select 1;
_containerType = typeOf _vehicle;
_house = nearestBuilding (getPosATL player);
if(!(_house in life_vehicles)) exitWith {[localize "STR_ISTR_Box_NotinHouse"] call life_fnc_showNotification;};
if(isNull _vehicle) exitWith {};
closeDialog 0;
_ressource = "cannabis";
if(_type isEqualTo 0) then{_ressource = "cannabis";};
if(_type isEqualTo 1) then{_ressource = "heroin_unprocessed";};
_vehicle setVariable ["mining",true,true]; //Lock the device

["Vous avez demarre une culture"] call life_fnc_showNotification;
for "_i" from 0 to 1 step 0 do {
    if (isNull _vehicle) exitWith {};
    _time = time + 60;

    waitUntil {
         if (round(_time - time) < 1) exitWith {
            true
        };
        sleep 0.2;
        false
    };

    _vehicle_data = _vehicle getVariable ["Trunk",[[],0]];
    _inv = _vehicle_data select 0;
    _space = _vehicle_data select 1;
    _itemIndex = ["",_inv] call TON_fnc_index;
    _weight = [_vehicle] call life_fnc_vehicleWeight;
    _sum = [_ressource,1,_weight select 1,_weight select 0] call life_fnc_calWeightDiff; // Get a sum base of the remaining weight..

    if (_sum < 1) exitWith {
        _vehicle setVariable["mining",nil,true];
    };

    if (_itemIndex isEqualTo -1) then {
        _inv pushBack [_ressource,_sum];
    } else {
        _val = _inv select _itemIndex select 1;
        _inv set[_itemIndex,[_ressource,_val + _sum]];
    };

    _itemName = M_CONFIG(getText,"VirtualItems",_ressource,"displayName");
    _itemWeight = ([_ressource] call life_fnc_itemWeight) * _sum;
    _vehicle setVariable["Trunk",[_inv,_space + _itemWeight],true];
    _weight = [_vehicle] call life_fnc_vehicleWeight;
    _sum = [_ressource,1,_weight select 1,_weight select 0] call life_fnc_calWeightDiff; //Get a sum base of the remaining weight..

    if (_sum < 1) exitWith {
        _vehicle setVariable["mining",nil,true];
    };

    sleep 2;
};