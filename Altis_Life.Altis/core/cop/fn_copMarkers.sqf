#include "..\..\script_macros.hpp"
/*
	File: fn_copMarkers.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Marks cops on the map for other cops. Only initializes when the actual map is open.
*/
private["_markers","_cops"];
_markers = [];
_cops = [];
_stealMark = [];

sleep 0.5;
if(visibleMap) then {
	{if(side _x == west) then {_cops pushBack _x;}} foreach playableUnits; //Fetch list of cops / blufor

	//Create markers
	{
		if(_x != player) then {
			_marker = createMarkerLocal [format["%1_marker",_x],getPosWorld _x];
			_marker setMarkerColorLocal "ColorBLUFOR";
			_marker setMarkerTypeLocal "Mil_dot";
			if(_x getVariable["askHelp",FALSE])then
			{
				_marker setMarkerTextLocal format["HELP: %1", _x getVariable["realname",name _x]];
			}else
			{
				_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];
			};

			_markers pushBack [_marker,_x];
		};
	} foreach _cops;
	
	if(count life_vehicles != 0)then
	{
		{
			if((_x isKindOf 'LandVehicle') || (_x isKindOf 'Air') || (_x isKindOf 'Ship') || (_x isKindOf 'Tank'))then
			{
				_marker = createMarkerLocal [format["%1_marker",_x],getPosWorld _x];
				_marker setMarkerColorLocal "ColorBlack";
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerTextLocal format["VEH: %1", SEL([typeof _x] call life_fnc_fetchVehInfo,3)];
				_markers pushBack [_marker,_x];
			};
		} foreach life_vehicles;
	};
	while {visibleMap} do {
		{
			private["_marker","_unit"];
			_marker = _x select 0;
			_unit = _x select 1;
			if(!isNil "_unit" && !isNull _unit) then {
				_marker setMarkerPosLocal (getPosWorld _unit);
			};
		} foreach _markers;
		if(!visibleMap) exitWith {};
		sleep 0.02;
	};

	{deleteMarkerLocal (_x select 0);} foreach _markers;
	_markers = [];
	_cops = [];
};
