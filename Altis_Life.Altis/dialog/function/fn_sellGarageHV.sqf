#include "..\..\script_macros.hpp"
/*
	File: fn_sellGarageHV.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Sells a vehicle from the garage.
*/
private ["_val", "_data", "_vehicle", "_vid", "_pid"];
disableSerialization;
if((time - life_action_delay) < 1.5) exitWith {hint localize "STR_NOTF_ActionDelay";};

_val = ctrlText 2752;
if(!([_val] call TON_fnc_isnumber)) exitWith {hint localize "STR_Cop_TicketNum"};
_val = parseNumber _val;
if(_val < 1000) exitWith {hint localize "STR_Cop_SellHVUnder1"};

_data = life_vSellHV;
_data = (call compile format["%1",_data]);
_vehicle = (call compile format["%1",_data select 0]) select 0;
_vid = _data select 1;
_pid = getPlayerUID player;
if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};

if(life_KavaBank < (round(_val/10))) exitWith {hint format[localize "STR_GarageHV_Sell_NoBank",round(_val/10)];};

_action = [
	format[localize "STR_GARHV_SellPrice",[round(_val/10)] call life_fnc_numberText],
	localize "STR_GARHV_SellHeader",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;
if(!_action)exitWith {};
closeDialog 0;
if(life_KavaBank < (round(_val/10))) exitWith {hint format[localize "STR_GarageHV_Sell_NoBank",round(_val/10)];};
SUB(life_KavaBank,round(_val/10));
if(life_HC_isActive) then {
	[_vid,_pid,_val] remoteExecCall ["HC_fnc_vehicleSellHV",HC_Life];
} else {
	[_vid,_pid,_val] remoteExecCall ["TON_fnc_vehicleSellHV",RSERV];
};

hint format[localize "STR_Garage_SoldHVCar",[_val] call life_fnc_numberText];
[format["[VENTE HV GARAGE] %1(%2) -VEHICULE: %3 -PRIX: %4",name player, getPlayerUID player, _vehicle, [_val] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
life_action_delay = time;
