#include "..\..\script_macros.hpp"
/*
	File: fn_searchClient.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Searches the player and he returns information back to the player.
*/
private["_inv","_val","_var","_robber","_totalPrice"];
params [
	["_cop",objNull,[objNull]]
];
if(isNull _cop) exitWith {};

_inv = [];
_robber = false;
_totalPrice = 0;

//Illegal items
{
	_var = configName(_x);
	_val = ITEM_VALUE(_var);
	if(_val > 0) then {
		_inv pushBack [_var,_val];
		_price = M_CONFIG(getNumber,"VirtualItems",_var,"sellPrice");
		_totalPrice = _totalPrice + (_val*_price);
		[false,_var,_val] call life_fnc_handleInv;
	};
} foreach ("getNumber(_x >> 'illegal') isEqualTo 1" configClasses (missionConfigFile >> "VirtualItems"));

if(!life_use_atm) then  {
	life_KavaCash = 0;
	_robber = true;
};

// [player,_inv,_robber] remoteExec ["life_fnc_copSearch",_cop];
[player,_totalPrice,_robber] remoteExec ["life_fnc_copSearchPlayer",_cop];