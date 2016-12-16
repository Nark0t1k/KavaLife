/*
	fn_warnGangCapture.sqf
*/
if(!hasInterface && !isDedicated)exitWith {};
private ["_flagName","_gangName","_flag","_gangAttack"];
_flagName = _this select 0;
_gangName = _this select 1;
_gangAttack = _this select 2;

if(!alive player) exitWith {};
if(!(isNil {player getVariable "gang_name"}))exitWith {};
if((player getVariable "gang_name") != _gangName) exitWith {};
if((player getVariable "gang_name") isEqualTo _gangAttack) exitWith {};
diag_log format["KAVALOG WARNGANG gang_name: %1 _gangName: %2 _gangAttack: %3", (player getVariable "gang_name"),_gangName, _gangAttack];
_flag = switch (_flagName) do
{
	case flag_gang1_1:{"A"};
	case flag_gang1_2:{"B"};
	case flag_gang1_3:{"C"};
	case flag_gang2_1:{"A"};
	case flag_gang2_2:{"B"};
	case flag_gang2_3:{"C"};
	case flag_gang3_1:{"A"};
	case flag_gang3_2:{"B"};
	case flag_gang3_3:{"C"};
};

[format[localize "STR_Gang_Capture",_flag]] call life_fnc_showNotification;