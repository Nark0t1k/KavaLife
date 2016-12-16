#include "..\..\script_macros.hpp"
/*
	fn_gatherMeca.sqf
	by Nark0t1k for Kavalash
	
	_unit addAction[localize"STR_gatherDisplay",life_fnc_gatherMeca,"",0,false,false,"",' vehicle player isEqualTo player && player distance _target < 10 && playerSide isEqualTo civilian && license_civ_rebel && !life_action_inUse '];
*/

private ["_item", "_nbrStock", "_handle", "_speed"];

_item = _this select 0;
if(isNull _item) exitWith {};

if(life_inv_visseuse < 1 && life_inv_chalumeau < 1) exitWith {hint parseText localize "STR_cantGather";};
_speed = 0.7;
if(life_inv_chalumeau > 0)then {_speed = 0.4;};

_nbrStock = _item getVariable ["stockMeca",0];
if(_nbrStock < 1)then
{
	sleep 1;
	_nbrStock = _item getVariable ["stockMeca",0];
};
if(_nbrStock < 1) exitWith {hint parseText localize "STR_noMoreStock";};

_handle = [localize "STR_gatherMeca",true,5,0.01,_speed,""] spawn life_fnc_handleProgressBar;
waitUntil { sleep 0.2;scriptDone _handle;}; 
if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;};

_nbrStock = _item getVariable ["stockMeca",0];
if(_nbrStock < 1)then
{
	sleep 1;
	_nbrStock = _item getVariable ["stockMeca",0];
};
if(_nbrStock < 1) exitWith {hint parseText localize "STR_noMoreStock";};
_item setVariable ["stockMeca",(_nbrStock-1),true];
[true,"piecemeca",1] call life_fnc_handleInv;
hint parseText localize "STR_gather1Stuck";