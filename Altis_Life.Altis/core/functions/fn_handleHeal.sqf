#include "..\..\script_macros.hpp"
/*
	File: fn_handleHeal.sqf

*/
private ["_unit"];

_injured = _this select 0;
_healer = _this select 1;
_canHeal = _this select 2;
_damage = damage _injured;
if (_injured isEqualTo _healer) then {
	waitUntil {damage _injured != _damage};
	if (damage _injured < _damage) then {
		_injured setDamage 0;
	};
};