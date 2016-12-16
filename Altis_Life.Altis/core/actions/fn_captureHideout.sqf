#include "..\..\script_macros.hpp"
/*
    File: fn_captureHideout.sqf
    Author: Bryan "Tonic" Boardwine
    Description:
    Blah blah.
*/
private ["_hideout", "_ownerHide", "_gangName", "_action", "_cpRate", "_handle", "_flagTexture", "_getAll", "_flagGang1", "_flagGang2", "_flagGang3", "_gangObj", "_gangMark", "_flagNbr", "_aray", "_marker"];
_hideout = _this select 3;
_ownerHide = _hideout getVariable ["gangOwnerName",""];
if (isNil {player getVariable "gang_name"}) exitWith {[localize "STR_GNOTF_CreateGang"] call life_fnc_showNotification;};
if (_ownerHide isEqualTo (player getVariable "gang_name")) exitWith {[localize "STR_GNOTF_Controlled"] call life_fnc_showNotification;};
if ((_hideout getVariable ["inCapture",FALSE])) exitWith {[localize "STR_GNOTF_onePersonAtATime"] call life_fnc_showNotification;};
_gangName = player getVariable ["gang_name",""];
if (_ownerHide != "") then {
    _action = [
        format[localize "STR_GNOTF_AlreadyControlled",_ownerHide],
        localize "STR_GNOTF_CurrentCapture",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call BIS_fnc_guiMessage;

    _cpRate = 0.0025;
} else {
    _cpRate = 0.0025;
};

if (!isNil "_action" && {!_action}) exitWith {titleText[localize "STR_GNOTF_CaptureCancel","PLAIN"];};

[_hideout,_ownerHide,_gangName] remoteExec ["life_fnc_warnGangCapture",civilian];
_hideout setVariable ["inCapture",true,true];
_handle = [localize "STR_GNOTF_Capturing",true,20,_cpRate,0.4,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {_hideout setVariable ["inCapture",false,true];life_interrupted = false;[localize "STR_GNOTF_CaptureCancel"] call life_fnc_showNotification;}; 


titleText["Un drapeau de la zone gang à été capturé.","PLAIN"];
_flagTexture = [
        "\A3\Data_F\Flags\Flag_red_CO.paa",
        "\A3\Data_F\Flags\Flag_green_CO.paa",
        "\A3\Data_F\Flags\Flag_blue_CO.paa",
        "\A3\Data_F\Flags\Flag_white_CO.paa",
        "\A3\Data_F\Flags\flag_fd_red_CO.paa",
        "\A3\Data_F\Flags\flag_fd_green_CO.paa",
        "\A3\Data_F\Flags\flag_fd_blue_CO.paa",
        "\A3\Data_F\Flags\flag_fd_orange_CO.paa"
    ] call BIS_fnc_selectRandom;
_this select 0 setFlagTexture _flagTexture;
_hideout setVariable ["inCapture",false,true];
_hideout setVariable ["gangOwnerName",_gangName,true];


_getAll = false;
_flagGang1 = [flag_gang1_1,flag_gang1_2,flag_gang1_3];
_flagGang2 = [flag_gang2_1,flag_gang2_2,flag_gang2_3];
_flagGang3 = [flag_gang3_1,flag_gang3_2,flag_gang3_3];

_gangObj = gang_obj_1;

if(_hideout in _flagGang1)then
{
	_gangMark = "gang_area_1";
	_gangObj = gang_obj_1;
	_flagNbr = 1;
	if(((flag_gang1_1 getVariable "gangOwnerName") isEqualTo _gangName) && ((flag_gang1_2 getVariable "gangOwnerName") isEqualTo _gangName) && ((flag_gang1_3 getVariable "gangOwnerName") isEqualTo _gangName)) then {_getAll = true;};
	_aray = [[flag_gang1_1,(flag_gang1_1 getVariable "gangOwnerName")],[flag_gang1_2,(flag_gang1_2 getVariable "gangOwnerName")],[flag_gang1_3,(flag_gang1_3 getVariable "gangOwnerName")]];
	
};
if(_hideout in _flagGang2)then
{
	_gangMark = "gang_area_2";
	_gangObj = gang_obj_2;
	_flagNbr = 2;
	if(((flag_gang2_1 getVariable "gangOwnerName") isEqualTo _gangName) && ((flag_gang2_2 getVariable "gangOwnerName") isEqualTo _gangName) && ((flag_gang2_3 getVariable "gangOwnerName") isEqualTo _gangName)) then {_getAll = true;};
	_aray = [[flag_gang2_1,(flag_gang2_1 getVariable "gangOwnerName")],[flag_gang2_2,(flag_gang2_2 getVariable "gangOwnerName")],[flag_gang2_3,(flag_gang2_3 getVariable "gangOwnerName")]];
};
if(_hideout in _flagGang3)then
{
	_gangMark = "gang_area_3";
	_gangObj = gang_obj_3;
	_flagNbr = 3;
	if(((flag_gang3_1 getVariable "gangOwnerName") isEqualTo _gangName) && ((flag_gang3_2 getVariable "gangOwnerName") isEqualTo _gangName) && ((flag_gang3_3 getVariable "gangOwnerName") isEqualTo _gangName)) then	{_getAll = true;};
	_aray = [[flag_gang3_1,(flag_gang3_1 getVariable "gangOwnerName")],[flag_gang3_2,(flag_gang3_2 getVariable "gangOwnerName")],[flag_gang3_3,(flag_gang3_3 getVariable "gangOwnerName")]];
};
if(_getAll)then
{
	[[0,7],"STR_GNOTF_CaptureSuccess",true,[name player,_gangName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	_gangObj setVariable ["gangOwnerName",_gangName,true];
	deleteMarker _gangMark;
	_marker = createMarker [_gangMark,getPosWorld _gangObj];
	_marker setMarkerType "mil_triangle";
	_marker setMarkerPos getPosWorld _gangObj;
	_marker setMarkerText format['Zone Gang Control: %1',_gangName];
	_marker setMarkerColor ("ColorRed");
};

if(life_HC_isActive) then {
	[_gangObj getVariable ["gangOwnerName",""],_aray,_flagNbr] remoteExec ["HC_fnc_updateGangArea",HC_Life]; 
} else {
	[_gangObj getVariable ["gangOwnerName",""],_aray,_flagNbr] remoteExec ["TON_fnc_updateGangArea",RSERV]; 
};
