#include "..\..\script_macros.hpp"
/*
	File: fn_adminESP.sqf
	Sourced from Lystics Player Markers Loop
*/
if((call life_adminlevel) < 4) exitWith {closeDialog 0; hint localize "STR_ANOTF_ErrorLevel";};
life_adminESP = !life_adminESP;

if(life_adminESP) then {
	[format['[ADMIN] %1(%2) -ACTIVE ESP',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
	hint localize "STR_AESP_Enabled";
	myIcons = addMissionEventHandler["draw3d",{
			{
				if(alive _x) then
				{
					if(side _x isEqualTo civilian) then {
					  drawIcon3D ["", [0.517,0,0.537,0.7], visibleposition _x, 1, 1, 45, (format ["%2:%1m",player distance _x, name _x]), 1, 0.03, "PuristaMedium"];
					} else {
					  drawIcon3D ["", [0.113,0.309,0.964,0.7], visibleposition _x, 1, 1, 45, (format ["%2:%1m",player distance _x, name _x]), 1, 0.03, "PuristaMedium"];
					};
				};
			} foreach playableUnits;
		}
	];
} else {
	[format['[ADMIN] %1(%2) -DESACTIVE ESP',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
	removeMissionEventHandler ["draw3d",myIcons];
	hint localize "STR_AESP_Disabled";
};