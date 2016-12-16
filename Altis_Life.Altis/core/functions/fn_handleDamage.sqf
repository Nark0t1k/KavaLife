#include "..\..\script_macros.hpp"
/*
    File: fn_handleDamage.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Handles damage, specifically for handling the 'tazer' pistol and nothing else.
*/
params [
    ["_unit",objNull,[objNull]],
    ["_part","",[""]],
    ["_damage",0,[0]],
    ["_source",objNull,[objNull]],
    ["_projectile","",[""]],
    ["_index",0,[0]]
];

//Handle the tazer first (Top-Priority).
if (!isNull _source) then {
    if (_source != _unit) then {
        if (currentWeapon _source isEqualTo "hgun_P07_snds_F" && _projectile isEqualTo "B_9x21_Ball") then {
			_damage = damage player;
			if (alive player && !life_istazed && !life_isknocked && !(_unit getVariable ["restrained",false])) then {
				if (_unit distance _source < 35) then {
					if !(isNull objectParent player) then {
						if (typeOf (vehicle player) == "B_Quadbike_01_F") then {
							player action ["Eject",vehicle player];
							[_unit,_source] spawn life_fnc_tazed;
						};
					} else {
						[_unit,_source] spawn life_fnc_tazed;
					};
				};
			};
        };
    };
};

[] spawn life_fnc_hudUpdate;
[] call life_fnc_hudHealthUpdate;
_damage;