/*
	File: fn_handleProgressBar.sqf
	Author: Bryan "Tonic" Boardwine
	Edited by : Joker @ Altisdev
	Adjusted by Nark0t1k
	
	Description:
	Generic method to display a progress bar
	
	_handle = ["Piratage en cours..."] spawn life_fnc_handleProgressBar;
	_handle = ["Piratage en cours...",true,5,0.01,0.3,"AinvPknlMstpsnonWnonDnon_medic_1"] spawn life_fnc_handleProgressBar;
	waitUntil { sleep 0.2;scriptDone _handle;}; 
	if(errorProgress > 0) exitWith {}; 
	
	errorProgress = 0 = OK
	errorProgress = 1 = Out Of Range
	errorProgress = 2 = Interrup Key
	errorProgress = 3 = Assomé ou Taser
		
*/

params [
	["_txt",""],
	["_canMove",false],
	["_maxDist",6],
	["_cpUp",0.01],
	["_sleeper",0.3],
	["_animation",""]
];

disableSerialization;
4 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_txt];
errorProgress = 0;

_progress progressSetPosition 0.01;
_cP = 0.01;
_pos = getPosATL player;
life_action_inUse = true;
while{true} do
{
	sleep _sleeper;
	if(_animation != "" && (animationState player != _animation) ) then {
		player action ["SwitchWeapon", player, player, 100];
		player playMove _animation; 
		player playActionNow "stop";
		player playMove _animation;
		player playActionNow "stop";
		player playMove _animation;
	};
	_cP = _cP + _cpUp;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_txt];
	if(_cP >= 1) exitWith {};
	if(player distance _pos > _maxDist) exitWith {errorProgress = 1;};
	if(!_canMove && (life_interrupted)) exitWith {errorProgress = 2;};
	if (life_istazed) exitWith {errorProgress = 3;};
    if (life_isknocked) exitWith {errorProgress = 3;};
	if(!alive player) exitWith {errorProgress = 4;};
};
player switchMove "";
life_action_inUse = false;
if(errorProgress isEqualTo 1) exitWith {hint parseText localize "STR_NOTF_ActionCancelMove"; 4 cutText ["","PLAIN"];};
if(errorProgress isEqualTo 2) exitWith {hint parseText localize "STR_NOTF_ActionCantMove"; 4 cutText ["","PLAIN"];};
if(errorProgress isEqualTo 3) exitWith {hint parseText localize "STR_NOTF_ActionCancelTase"; 4 cutText ["","PLAIN"];};
if(errorProgress isEqualTo 4) exitWith {4 cutText ["","PLAIN"];};
4 cutText ["","PLAIN"];