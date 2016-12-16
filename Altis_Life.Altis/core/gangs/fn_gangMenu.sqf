#include "..\..\script_macros.hpp"
/*
    File: fn_gangMenu.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    31 hours of no sleep screw your description.
*/
private ["_ownerID", "_gangName", "_gangBank", "_gangMax", "_members", "_online", "_grpMembers", "_allUnits", "_ctrl", "_gangHonor","_recrutID"];
disableSerialization;
if (isNull (findDisplay 2620)) then {
    if (!(createDialog "Life_My_Gang_Diag")) exitWith {}; //NOOOOOOOOOOOOOOOOOOOOOOOoooooooooooooOOOOOOOOOOOOOOOOOOOOOOOOOOO00000000000000oooooo
};

_ownerID = life_gangQG getVariable ["gang_owner",""];
_recrutID = life_gangQG getVariable ["gang_recrut",[]];
if (_ownerID isEqualTo "") exitWith {closeDialog 0;}; //Bad juju
_gangName = player getVariable "gang_name";
_grpMembers = [];
{
	if(!isNil {_x getVariable "gang_name"})then
	{
		if((_x getVariable "gang_name") isEqualTo _gangName)then
		{
			_grpMembers pushBack _x;
		};
	};
} forEach playableUnits;

_gangBank = GANG_FUNDS;
_gangHonor = life_gangQG getVariable ["gang_honor",0];
if (_ownerID != getPlayerUID player) then {
    (CONTROL(2620,2622)) ctrlEnable false; //Upgrade
    (CONTROL(2620,2624)) ctrlEnable false; // Kick
    (CONTROL(2620,2625)) ctrlEnable false; //Set New Leader
	if(!(getPlayerUID player in _recrutID))then
	{
		(CONTROL(2620,2630)) ctrlEnable false; //Invite Player
	};
    (CONTROL(2620,2631)) ctrlEnable false; //Disband Gang
};

(CONTROL(2620,2629)) ctrlSetText _gangName;
(CONTROL(2620,601)) ctrlSetText format[(localize "STR_GNOTF_Funds")+ " %1 K$",[_gangBank] call life_fnc_numberText];
(CONTROL(2620,602)) ctrlSetText format[(localize "STR_GNOTF_Honor")+ " %1",[_gangHonor] call life_fnc_numberText];

//Loop through the players.
_members = CONTROL(2620,2621);
lbClear _members;

{
	_uid = _x select 0;
	_name = _x select 1;
	_online = false;
	{
		if((getPlayerUID _x) isEqualTo _uid)exitWith {_online = true;};
	}forEach _grpMembers;
	if(_online)then
	{
		{
			if ((getPlayerUID _x) isEqualTo _uid) then {
				if ((getPlayerUID _x) isEqualTo _ownerID) then {
					_members lbAdd format["%1 " +(localize "STR_GNOTF_GangLeader")+" - En Ligne",(_x getVariable ["realname",name _x])];
					_members lbSetData [(lbSize _members)-1,str(getPlayerUID _x)];
				} else {
					if ((getPlayerUID _x) in _recrutID) then {
						_members lbAdd format["%1 " +(localize "STR_GNOTF_GangRecrut")+" - En Ligne",(_x getVariable ["realname",name _x])];
						_members lbSetData [(lbSize _members)-1,str(getPlayerUID _x)];
					}else
					{
						_members lbAdd format["%1 - En Ligne",(_x getVariable ["realname",name _x])];
						_members lbSetData [(lbSize _members)-1,str(getPlayerUID _x)];
					};
				};
			};
		} forEach _grpMembers;
	}else
	{
		if (_uid isEqualTo _ownerID) then {
			_members lbAdd format["%1 " +(localize "STR_GNOTF_GangLeader")+" - Hors Ligne",_name];
			_members lbSetData [(lbSize _members)-1,str(_uid)];
		} else {
			if (_uid in _recrutID) then {
				_members lbAdd format["%1 " +(localize "STR_GNOTF_GangRecrut")+" - Hors Ligne",_name];
				_members lbSetData [(lbSize _members)-1,str(_uid)];
			}else
			{
				_members lbAdd format["%1 - Hors Ligne",_name];
				_members lbSetData [(lbSize _members)-1,str(_uid)];
			};
		};
	};

}forEach life_fullGangList;

_allUnits = playableUnits;

//Clear out the list..
{
    if (_x in _grpMembers || side _x != civilian && isNil {life_gangQG getVariable "gang_id"}) then {
        _allUnits deleteAt _forEachIndex;
    };
} forEach _allUnits;

_ctrl = CONTROL(2620,2632);
lbClear _ctrl; //Purge the list
{
    _ctrl lbAdd format["%1",_x getVariable ["realname",name _x]];
    _ctrl lbSetData [(lbSize _ctrl)-1,str(_x)];
} forEach _allUnits;
