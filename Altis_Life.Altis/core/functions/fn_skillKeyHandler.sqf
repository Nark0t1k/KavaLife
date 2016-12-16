#include "..\..\script_macros.hpp"
/*
	File: fn_skillKeyHandler.sqf
	Author: Nark0t1k
*/
private["_code","_curTarget","_ctrlKey"];
_code = _this select 0;
_ctrlKey = _this select 1;
_curTarget = cursorTarget;
switch (_code) do
{
	// key exposant
	case 41:
	{
		true;
	};
	// Skill key 1: Show identity
	case 2:
	{
		if(vehicle player isEqualTo player)then
		{
			if(isNil "_curTarget" OR isNull _curTarget OR !isPlayer _curTarget) exitWith {};
			[_curTarget] spawn life_fnc_showIdentity;
		};
	};
	// Skill key 2: Stop escort cop
	case 3:
	{
		if(playerSide isEqualTo west) then
		{
			if(vehicle player isEqualTo player)then
			{
				if(_ctrlKey)then
				{
					{if(player distance _x < 2 && (_x getVariable ["Escorting",FALSE])) exitWith {[_x] call life_fnc_stopEscorting;};true;} count playableUnits;
				}else
				{
					if(isNil "_curTarget" OR isNull _curTarget OR !isPlayer _curTarget) exitWith {};
					[_curTarget] spawn life_fnc_copStopMessage;
				};
			}else
			{
				if(isNil "_curTarget" OR isNull _curTarget OR !isPlayer _curTarget) exitWith {};
				[_curTarget] spawn life_fnc_copStopMessage;
			};
		};
		if((playerSide isEqualTo civilian) && license_civ_rebel) then
		{
			if(vehicle player isEqualTo player)then
			{
				if(isNil "_curTarget" OR isNull _curTarget OR !isPlayer _curTarget) exitWith {};
				[_curTarget] spawn life_fnc_rebStopMessage;
			}else
			{
				if(isNil "_curTarget" OR isNull _curTarget OR !isPlayer _curTarget) exitWith {};
				[_curTarget] spawn life_fnc_rebStopMessage;
			};
		};
	};
	// Skill key 3
	case 4:
	{
		if(playerSide isEqualTo west && alive player) then
		{
			if(vehicle player != player)then
			{
				[_curTarget] spawn life_fnc_copStopMessage;
			}
		}else
		{
			true;
		};
	};
		
	// Skill key 4: Open CellPhone
	case 5:
	{
		[] call life_fnc_callCellPhone;
	};
	// Skill key 5: Sound Switch
	case 6:
	{
		switch(life_noSound) do
		{
			case 0:{
				0.5 fadeSound 0.75;
				hint localize "STR_NOSND_75";
				life_noSound = 1;
			};
			case 1:{
				0.5 fadeSound 0.5;
				hint localize "STR_NOSND_50";
				life_noSound = 2;
			};
			case 2:{
				0.5 fadeSound 0.25;
				hint localize "STR_NOSND_25";
				life_noSound = 3;
			};
			case 3:{
				0.5 fadeSound 0.1;
				hint localize "STR_NOSND_10";
				life_noSound = 4;
			};
			case 4:{
				0.5 fadeSound 1;
				hint localize "STR_NOSND_100";
				life_noSound = 0;
			};
		};
	};
	// Skill key 6: Police Cop Opener
	case 7:
	{
		if(playerSide in [west,independent])then
		{
			{
				if (_x animationPhase "Door_1_rot" isEqualTo 1) then {
					_x animate ["Door_1_rot", 0];
				} 
				else 
				{
					_x animate ["Door_1_rot", 1];
				};
			
			} forEach (nearestObjects [player, ["Land_BarGate_F"], 10]);
		}else
		{
			true;
		};
	};
	// Skill key 7: 
	case 8:
	{
		if(vehicle player isKindOf "Car")then
		{
			if(!life_seatbelt)then
			{
				life_seatbelt = true;
				[localize "STR_Ceinture_ON"] call life_fnc_showNotification;
			}else
			{
				life_seatbelt = false;
				[localize "STR_Ceinture_OFF"] call life_fnc_showNotification;
			};
		};
		true;

	};
	// Skill key 8:
	case 9:
	{
		if(playerSide != independent) exitWith {};
		if((FETCH_CONST(life_medicLevel)) in [0,1]) then 
		{
			[0] spawn life_fnc_reponseIndep;
		};
		if((FETCH_CONST(life_medicLevel)) isEqualTo 2) then 
		{
			[1] spawn life_fnc_reponseIndep;
		};
	};
	// Skill key 9: 
	case 10:
	{
		if(isNil "life_viewDistance") then
		{
			life_viewDistance = 0;
		};
		switch (life_viewDistance) do
		{
			case 0: { life_viewDistance = 250; systemChat format["Distance Affichage : %1.", life_viewDistance];};
			case 250: { life_viewDistance = 750; systemChat format["Distance Affichage : %1.", life_viewDistance];};
			case 750: { life_viewDistance = 1250; systemChat format["Distance Affichage : %1.", life_viewDistance];};
			case 1250: { life_viewDistance = 0; systemChat "Distance Affichage Default"; };
            default { life_viewDistance = 0; systemChat "Distance Affichage Default"; };
		};
		[] call life_fnc_updateViewDistance;
		_handled = true;
	};
	
	// Skill key 0: 
	case 11:
	{
		true;
	};
	
	default{true};
};