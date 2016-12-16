/*
    File: init.sqf
    Author: 
    
    Description:
    
*/
StartProgress = false;
enableSaving[false,false];

setTerrainGrid 25;
setViewDistance 1000;
setObjectViewDistance [800,50];
if (!getRemoteSensorsDisabled) then {disableRemoteSensors true;};

[] execVM "KRON_Strings.sqf";

0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
6 enableChannel false;

StartProgress = true;

0 setOvercast 0;
0 setRain 0;
0 setFog 0;

[] spawn
{
	while {true} do
	{
		0 setfog 0;
		sleep 300;
	};  
};