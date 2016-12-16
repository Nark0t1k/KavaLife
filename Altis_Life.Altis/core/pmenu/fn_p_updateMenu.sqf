#include "..\..\script_macros.hpp"
/*
	File: fn_p_updateMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Updates the player menu (Virtual Interaction Menu)
*/
private["_inv","_lic","_licenses","_near","_near_units","_mstatus","_shrt","_side","_struct"];
disableSerialization;

if((call life_adminlevel) < 1) then {
	ctrlShow[2020,false];
	ctrlShow[2021,false];
};

_side = switch(playerSide) do {case west:{"cop"}; case civilian:{"civ"}; case independent:{"med"};};
if(playerSide isEqualTo independent) then
{
	if((FETCH_CONST(life_medicLevel)) in [0,1]) exitWith {_side="med";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 2) exitWith {_side="mecano";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 3) exitWith {_side="merce";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 4) exitWith {_side="conces";};
};

_inv = CONTROL(2001,2005);
_lic = CONTROL(2001,2014);
// _near = CONTROL(2001,2022);
// _near_i = CONTROL(2001,2023);
_mstatus = CONTROL(2001,2015);
_struct = "";
lbClear _inv;
// lbClear _near;
// lbClear _near_i;

//Near players
_near_units = [];

_mstatus ctrlSetStructuredText parseText format["<img size='1.3' image='icons\ico_bank.paa'/> <t size='0.8px'>%1€</t><br/><img size='1.2' image='icons\ico_money.paa'/> <t size='0.8'>%2€</t>",[life_KavaBank] call life_fnc_numberText,[life_KavaCash] call life_fnc_numberText];
ctrlSetText[2009,format["Joueurs: %3           %1 / %2Kg", round(life_carryWeight*10)/10, life_maxWeight,count playableUnits]];

{
	if(ITEM_VALUE(configName _x) > 0) then {
		_inv lbAdd format["%2 [x%1]",ITEM_VALUE(configName _x),localize (getText(_x >> "displayName"))];
		_inv lbSetData [(lbSize _inv)-1,configName _x];
		_icon = M_CONFIG(getText,"VirtualItems",configName _x,"icon");
		if(!(EQUAL(_icon,""))) then {
			_inv lbSetPicture [(lbSize _inv)-1,_icon];
		};
	};
} foreach ("true" configClasses (missionConfigFile >> "VirtualItems"));

{
	_displayName = getText(_x >> "displayName");
	
	if(LICENSE_VALUE(configName _x,_side)) then {
		_struct = _struct + format["%1<br/>",localize _displayName];
	};
} foreach (format["getText(_x >> 'side') isEqualTo '%1'",_side] configClasses (missionConfigFile >> "Licenses"));

if(EQUAL(_struct,"")) then {
	_struct = "No Licenses";
};

_lic ctrlSetStructuredText parseText format["
<t size='0.8px'>
%1
</t>
",_struct];