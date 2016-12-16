#include "..\..\script_macros.hpp"
/*
	File: fn_friendMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the key menu
	Will be revised.
*/
private["_display","_friendList","_plist","_friendUnits","_pic","_name","_text","_color","_index"];
disableSerialization;

waitUntil {!isNull (findDisplay 6700)};
_display = findDisplay 6700;
_friendList = _display displayCtrl 6701;
lbClear _friendList;
_plist = _display displayCtrl 6702;
lbClear _plist;
_friendUnits = [];
_noFriendUnits = [];
{
	if(side _x isEqualTo civilian) then
	{
		if(getPlayerUID _x in life_friendList) then 
		{
			_friendUnits pushBack _x;
		}else
		{
			_noFriendUnits pushBack _x;
		};
	};
} foreach playableUnits;

{
	if(!isNull _x && alive _x && _x != player) then {
		_friendList lbAdd format["%1 - Amis",_x getVariable["realname",name _x]];
		_friendList lbSetData [(lbSize _friendList)-1,str(_x)];
	};
} foreach _friendUnits;
{
	if(!isNull _x && alive _x && _x != player) then {
		_plist lbAdd format["%1 - %2",_x getVariable["realname",name _x], side _x];
		_plist lbSetData [(lbSize _plist)-1,str(_x)];
	};
} foreach _noFriendUnits;

if(((lbSize _friendList)-1) isEqualTo -1) then {
	_friendList lbAdd "Tu n'as pas d'amis connecté";
	_friendList lbSetData [(lbSize _friendList)-1,str(ObjNull)];
};
