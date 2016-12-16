#include "..\..\script_macros.hpp"
/*
	fn_newMessLB.sqf
*/
private ["_listPlayer", "_typeSel", "_tempPlayer"];
disableSerialization;
_listPlayer = CONTROL(89000,89001);
_typeSel = lbData[89006,(lbCurSel 89006)];
lbClear _listPlayer;
_tempPlayer = [];
diag_log format["KAVALOG NEWMESSLB TYPESEL: %1", _typeSel];
switch (_typeSel) do
{
	case "civilian":
	{
		{
			if(((side _x) isEqualTo civilian) && _x != player)then
			{
				_tempPlayer pushBack [_x getVariable["realname", name _x],getPlayerUID _x];
			};
		} forEach playableUnits;
	};
	case "west":
	{
		{
			if((side _x) isEqualTo west && _x != player)then
			{
				_tempPlayer pushBack [_x getVariable["realname", name _x],getPlayerUID _x];
			};
		} forEach playableUnits;
	};
	case "medic":
	{
		{
			if({side _x isEqualTo independent && (str _x in life_listMedic) && _x != player)then
			{
				_tempPlayer pushBack [_x getVariable["realname", name _x],getPlayerUID _x];
			};
		} forEach playableUnits;
	};
	case "mecano":
	{
		{
			if({side _x isEqualTo independent && (str _x in life_listMecano) && _x != player)then
			{
				_tempPlayer pushBack [_x getVariable["realname", name _x],getPlayerUID _x];
			};
		} forEach playableUnits;
	};
	case "merce":
	{
		{
			if({side _x isEqualTo independent && (str _x in life_listMerce) && _x != player)then
			{
				_tempPlayer pushBack [_x getVariable["realname", name _x],getPlayerUID _x];
			};
		} forEach playableUnits;
	};
	case "conces":
	{
		{
			if({side _x isEqualTo independent && (str _x in life_listConces) && _x != player)then
			{
				_tempPlayer pushBack [_x getVariable["realname", name _x],getPlayerUID _x];
			};
		} forEach playableUnits;
	};
};
diag_log format["KAVALOG NEWMESSLB TEMPPLAYER: %1", _tempPlayer];
_tempPlayer sort true;
{
	_listPlayer lbAdd format["%1",(_x select 0)];
	_listPlayer lbSetData [(lbSize _listPlayer)-1,SEL(_x,1)];
}foreach _tempPlayer;