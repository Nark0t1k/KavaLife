#include "..\..\script_macros.hpp"
/*
	File: fn_s_onCheckedChange.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Switching it up and making it prettier..
*/
private["_option","_state"];
_option = SEL(_this,0);
_state = SEL(_this,1);

switch(_option) do {
	case "tags": {};
	
	case "objects": {};
	
	case "sidechat": {};
};