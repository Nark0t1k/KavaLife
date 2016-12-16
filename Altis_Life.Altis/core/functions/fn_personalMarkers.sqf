/*
	File: fn_personalMarkers.sqf
	Author: Nark0t1K inspired by Tonics
	
	Description:
	player on the map if you get GPS.
*/
if(!("ItemGPS" in (assignedItems player))) exitWith {};
while {true} do
{
	waitUntil {visibleMap};
	_mymark = createMarkerLocal [format ["%1_markerPerso", player], getPosWorld player];
	_mymark setMarkerShapeLocal "ICON";
	_mymark setMarkerSize [2,2];
	_mymark setMarkerTypeLocal "mil_triangle";
	_mymark setMarkerColorLocal ("ColorBLUFOR");
	_mymark setMarkerDirLocal (getDir player);
	_mymark setMarkerAlphaLocal 0.75;
	
			
	while {visibleMap} do
	{
		_mymark setMarkerPosLocal (getPosWorld player);
		if(!visibleMap) exitWith {};
		sleep 0.02;
	};
	deleteMarkerLocal format["%1_markerPerso",player];
	if(!visibleMap) exitWith {};
};