#include "..\..\script_macros.hpp"
/*
	fn_InsureCar.sqf
	by Nark0t1k
*/

private ["_type", "_insureType", "_multi", "_nbrInsure", "_className", "_price", "_dbInfo"];

disableSerialization;

if(EQUAL(lbCurSel 3902,-1)) exitWith {hint localize "STR_Global_NoSelection"};
_type = lbData[3902,(lbCurSel 3902)];

_dbInfo = life_vInact_curTarget getVariable ["dbInfo",[]];
switch(_type)do
{
	case "light": {_multi = 0.4;_nbrInsure = 1;};
	case "standard": {_multi = 2;_nbrInsure = 2;};
	case "premium": {_multi = 3;_nbrInsure = 3;};
	case "omium": {_multi = 4;_nbrInsure = 4;};
};

_className = typeOf life_vInact_curTarget;

_price = switch(playerSide) do {
	case civilian: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),0)};
	case west: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),1)};
	case independent: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),2)};
	case east: {SEL(M_CONFIG(getArray,"LifeCfgVehicles",_className,"rentalprice"),3)};
};

_price = _price * _multi;

if(life_KavaBank < _price) exitWith {hint format[(localize "STR_Garage_CashError"),[_price] call life_fnc_numberText];};
_dbInfo set [2,_nbrInsure];
life_vInact_curTarget setVariable["dbInfo",_dbInfo,true];
if(_nbrInsure > 1)then
{	
	if(life_HC_isActive) then {
		[player,(_dbInfo select 1),_nbrInsure] remoteExecCall ["HC_fnc_InsureCar",HC_Life];
	}else
	{
		[player,(_dbInfo select 1),_nbrInsure] remoteExecCall ["TON_fnc_InsureCar",RSERV];
	};
};
hint parseText "Votre vehicule est desormais assure";
SUB(life_KavaBank,_price);
[1] call SOCK_fnc_updatePartial;
closeDialog 0;



