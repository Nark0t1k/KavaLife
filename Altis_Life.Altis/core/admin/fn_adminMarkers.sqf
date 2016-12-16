#include "..\..\script_macros.hpp"
/*
	File: fn_adminMarkers.sqf
	Sourced from Lystics Player Markers Loop
	Author:

	Description:

*/
private["_PlayerMarkers"];
if((call life_adminlevel) < 3) exitWith {closeDialog 0; hint localize "STR_ANOTF_ErrorLevel";};
life_markersvaar = !life_markersvaar;
if(life_markersvaar) then {
	_PlayerMarkers = [];
	hint localize "STR_ANOTF_MEnabled";
	[format['[ADMIN] %1(%2) -Marqueur ON',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
	while{life_markersvaar} do {
		{
			deleteMarkerLocal str _x;
		} forEach _PlayerMarkers;
		{
			if(alive _x && isplayer _x && side _x isEqualTo west && playerSide != west) then {
				_pSee = createMarkerLocal [str _x,getPosWorld _x];
				_pSee setMarkerTypeLocal "mil_triangle";
				_pSee setMarkerPosLocal getPosWorld _x;
				_pSee setMarkerSizeLocal [1,1];
				_pSee setMarkerTextLocal format['%1',_x getVariable["realname",name _x]];
				_pSee setMarkerColorLocal ("ColorBLUFOR");
				_PlayerMarkers pushBack [_x];
			};
			if(alive _x && isplayer _x && side _x isEqualTo independent) then {
				_pSee = createMarkerLocal [str _x,getPosWorld _x];
				_pSee setMarkerTypeLocal "mil_triangle";
				_pSee setMarkerPosLocal getPosWorld _x;
				_pSee setMarkerSizeLocal [1,1];
				_pSee setMarkerTextLocal format['%1',_x getVariable["realname",name _x]];
				_pSee setMarkerColorLocal ("ColorIndependent");
				_PlayerMarkers pushBack [_x];
			};
			if(alive _x && isplayer _x && side _x isEqualTo civilian) then {
				_pSee = createMarkerLocal [str _x,getPosWorld _x];
				_pSee setMarkerTypeLocal "mil_triangle";
				_pSee setMarkerPosLocal getPosWorld _x;
				_pSee setMarkerSizeLocal [1,1];
				_pSee setMarkerTextLocal format['%1',_x getVariable["realname",name _x]];
				_pSee setMarkerColorLocal ("ColorCivilian");
				_PlayerMarkers pushBack [_x];
			};
		} forEach allUnits;
		sleep 0.2;
		if(!life_markersvaar) exitWith {
			hint localize "STR_ANOTF_MDisabled";
			[format['[ADMIN] %1(%2) -Marqueur OFF',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
			{
				deleteMarkerLocal str _x;
			} forEach _PlayerMarkers;
		
		};
	};
};