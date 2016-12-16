#include "..\..\script_macros.hpp"
/*
    File: fn_gangUpgrade.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Determinds the upgrade price and blah
*/
private ["_maxMembers", "_slotUpgrade", "_upgradePrice", "_action", "_gangBank"];
_maxMembers = life_gangQG getVariable ["gang_maxMembers",5];
_slotUpgrade = _maxMembers + 1;
if(_maxMembers isEqualTo 20)exitWith {hint "Vous ne pouvez plus ameliorer votre gang";};
_upgradePrice = switch (_maxMembers) do
{
	case 5:{10000};
	case 6:{20000};
	case 7:{30000};
	case 8:{40000};
	case 9:{50000};
	case 10:{100000};
	case 11:{150000};
	case 12:{200000};
	case 13:{250000};
	case 14:{300000};
	case 15:{350000};
	case 16:{400000};
	case 17:{450000};
	case 18:{500000};
	case 19:{550000};
};


_action = [
    format[(localize "STR_GNOTF_MaxMemberMSG")+ "<br/><br/>" +(localize "STR_GNOTF_CurrentMax")+ "<br/>" +(localize "STR_GNOTF_UpgradeMax")+ "<br/>" +(localize "STR_GNOTF_Price")+ " <t color='#8cff9b'>K$%3</t>",_maxMembers,_slotUpgrade,[_upgradePrice] call life_fnc_numberText],
    localize "STR_Gang_UpgradeMax",
    localize "STR_Global_Buy",
    localize "STR_Global_Cancel"
] call BIS_fnc_guiMessage;
_gangBank = GANG_FUNDS;
if (_action) then {
    if (_gangBank < _upgradePrice) exitWith {
        hint parseText format[
            (localize "STR_GNOTF_NotEoughMoney_2")+ "<br/><br/>" +(localize "STR_GNOTF_Current")+ " <t color='#8cff9b'>K$%1</t><br/>" +(localize "STR_GNOTF_Lacking")+ " <t color='#FF0000'>K$%2</t>",
            [_gangBank] call life_fnc_numberText,
            [_upgradePrice - _gangBank] call life_fnc_numberText
        ];
    };
    _gangBank = _gangBank - _upgradePrice;
    life_gangQG setVariable ["gang_maxMembers",_slotUpgrade,true];
    hint parseText format[localize "STR_GNOTF_UpgradeSuccess",_maxMembers,_slotUpgrade,[_upgradePrice] call life_fnc_numberText];
    if (life_HC_isActive) then {
        [2,life_gangQG] remoteExecCall ["HC_fnc_updateGang",HC_Life];
    } else {
        [2,life_gangQG] remoteExec ["TON_fnc_updateGang",RSERV];
    };
	life_gangQG setVariable ["gang_bank",_gangBank,true];
} else {
    hint localize "STR_GNOTF_UpgradeCancel";
};
