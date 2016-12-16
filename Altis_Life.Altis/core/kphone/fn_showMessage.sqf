#include "..\..\script_macros.hpp"
/*
	fn_showMessage.sqf
*/
private ["_type", "_display", "_data", "_cMessageList", "_who", "_cMessageDetail","_uid","_mess","_sender","_ostatut"];
diag_log format["KAVALOG SHOWMESS THIS: %1", _this];
_type = _this select 0;

if(_type isEqualTo 3)exitWith
{
	if(!isNull findDisplay 88500)then
	{
		[player,_this select 1] remoteExec ["TON_fnc_getMessages",2];
	};
};

if(_type isEqualTo 0)exitWith
{
	disableSerialization;
	waitUntil {!isNull findDisplay 88000};
	_display = findDisplay 88000;
	
	_uid = lnbData[88001,[(lnbCurSelRow 88001),0]];
	diag_log format["KAVALOG SHOWMESS 1 UID: %1 TYPE: %2", _uid, typeName _uid];
	[player,_uid] remoteExec ["TON_fnc_getMessages",2];
	createDialog "Life_KPhoneMessage";
};
if(_type isEqualTo 1)exitWith
{
	_data = _this select 1;
	waitUntil {!isNull findDisplay 88500};
	_display = findDisplay 88500;
	_cMessageList = _display displayCtrl 88501;
	lbClear _cMessageList;
	_tmpData = _data select 0;
	_ostatut = CONTROL(88500,88507);
	if(SEL(_tmpData,0) isEqualTo (getPlayerUID player))then{
		_sender = SEL(_tmpData,3);
		life_messageTo = [SEL(_tmpData,4),SEL(_tmpData,3)];
		if([SEL(_tmpData,4)] call life_fnc_isUIDActive)then
		{
			_ostatut ctrlSetStructuredText parseText "<img size='1' image='textures\online.paa'/>";
		}else
		{
			_ostatut ctrlSetStructuredText parseText "<img size='1' image='textures\offline.paa'/>";
		};
	}else{
		_sender = SEL(_tmpData,1);
		life_messageTo = [SEL(_tmpData,0),SEL(_tmpData,1)];
		if([SEL(_tmpData,0)] call life_fnc_isUIDActive)then
		{
			_ostatut ctrlSetStructuredText parseText "<img size='1' image='textures\online.paa'/>";
		}else
		{
			_ostatut ctrlSetStructuredText parseText "<img size='1' image='textures\offline.paa'/>";
		};
	};
	{
		_who = if(SEL(_x,0) isEqualTo (getPlayerUID player))then{"Vous:"}else{"Lui:"};
		_cMessageList lbAdd format["%1 %2",_who,SEL(_x,2)];
		if(SEL(_x,0) isEqualTo (getPlayerUID player))then{
			_cMessageList lbSetColor [(lbSize _cMessageList)-1, [0, 0.509 , 0.121,0.7]];
		};
	}forEach _data;
	_cMessageList lbSetCurSel (lbSize _cMessageList);
	_cMessageDetail = _display displayCtrl 88505;
	_cMessageDetail ctrlSetText format["Auteur: %1",_sender];
};
