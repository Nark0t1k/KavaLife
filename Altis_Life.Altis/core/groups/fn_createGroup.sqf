/*
	File: fn_createGroup.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Functionality meant for creating groups.
*/
private["_value","_len","_group"];
_value = ctrlText 2522;
_len = [_value] call KRON_StrLen;

if(_len > 25) exitWith {hint "Le nombre de caracter limite pour un groupe est 25."};
if(([_value,life_group_list] call life_fnc_index) != -1) exitWith {hint "Le nom du groupe existe deja!"};

_group = createGroup civilian;

//Set Array
life_group_list pushBack [_value,_group,"",str(player),getPlayerUID player];
publicVariable "life_group_list";
[player] joinSilent _group;
player setRank "CORPORAL";
life_my_group = _group;
_random = round(random 10000);
(group player) setVariable ["groupNbr",_random,true];
life_my_groupNbr = _random;
if(!isNull life_my_group) then
{
	closeDialog 0;
	createDialog "life_my_group_Diag";
	publicVariable "life_group_list";
};