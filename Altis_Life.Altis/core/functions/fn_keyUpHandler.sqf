#include "..\..\script_macros.hpp"
/*
	File: fn_keyUpHandler.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main key handler for event 'keyDown'
*/
private ["_ctrl","_shift","_ctrlKey","_isSpeaking","_handled","_code","_speakKey2","_speakKey"];
_ctrl = SEL(_this,0);
_code = SEL(_this,1);
_shift = SEL(_this,2);
_ctrlKey = SEL(_this,3);
_handled = false;

if(_ctrl isEqualTo 22)then{_handled = true;};

_handled;