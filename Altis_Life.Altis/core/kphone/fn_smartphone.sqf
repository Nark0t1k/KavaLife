#include "..\..\script_macros.hpp"
/*
	file: fn_smartphone.sqf	

*/

private ["_pList", "_type", "_data", "_display", "_cPlayerList", "_cFriendList", "_cMessageList", "_cMessageDetail", "_cMessageTarget", "_nameSender", "_msg", "_rowData", "_cServiceList","_uid","_name"];
_data = _this select 0;
_uidDone = [];
if(count _data isEqualTo 0)exitWith {hint "pas de messages";};

disableSerialization;
waitUntil {!isNull findDisplay 88000};
_display = findDisplay 88000;
_cMessageList = _display displayCtrl 88001;

{
	_uid = SEL(_x,0);
	if((getPlayerUID player) isEqualTo _uid)then{_uid = SEL(_x,3);};
	if(!(_uid in _uidDone))then{_uidDone pushBack _uid;};
}forEach _data;
diag_log format["KAVALOG SMART UIDONE LIST: %1", _uidDone];
{
	_uid = SEL(_x,0);
	_name = SEL(_x,1);
	if((getPlayerUID player) isEqualTo _uid)then
	{
		_uid = SEL(_x,3);
		_name = SEL(_x,4);
	};

	if((SEL(_x,0)) in _uidDone)then
	{
		_cMessageList lnbAddRow[format["%1", _name],format["%1 ...",[_x select 2,40] call KRON_StrLeft]];
		_cMessageList lnbSetData[[SEL(lnbSize _cMessageList,0)-1,0],_uid];
		_uidDone = _uidDone - [_uid];
		diag_log format["KAVALOG SMARTPHONE UID: %1 TYPE: %2",_uid, typeName _uid];
	};
}foreach _data;