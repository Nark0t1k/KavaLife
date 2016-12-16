#include "..\..\script_macros.hpp"
/*
	File: fn_craft_update.sqf
	Description: Crafting System
	Created by EdgeKiller
    Coder: EdgeKiller
*/
private ["_dialog", "_inv", "_mats", "_struct", "_item", "_itemFilter", "_config", "_matsNeed", "_invSize", "_str", "_matsNum"];
disableSerialization; //Disable Serialization

_dialog = findDisplay 666; //find the craft dialog/window
_inv = _dialog displayCtrl 669; //find the listbox of items can be created
_mats = _dialog displayCtrl 672;
_struct = "";
if((lbCurSel 669) isEqualTo -1) exitWith {hint localize "STR_ISTR_SelectItemFirst";};
_item = lbData[669,(lbCurSel 669)];
_itemFilter = lbData[673,(lbCurSel 673)];



_config = [_itemFilter] call life_fnc_craftCfg;
{

	if(_item isEqualTo _x select 0)then
	{
		_matsNeed = _x select 1;
		_invSize = count _matsNeed;
		{
			_str = localize(M_CONFIG(getText,"VirtualItems",(_x select 0),"displayName"));
			_matsNum = _x select 1;
			_struct = _struct + format["%1x %2<br/>",_matsNum,_str];
		}foreach _matsNeed;
	};
} foreach (_config);

if(_struct isEqualTo "") then
{
	_struct = "No material needed";
};

_mats ctrlSetStructuredText parseText format["
<t size='0.8px'>
%1
</t>
",_struct]; 