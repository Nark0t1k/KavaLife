#include "..\..\script_macros.hpp"
/*
	File: fn_medicMarkers.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Marks downed players on the map when it's open.
*/
private["_markers","_units","_medics"];
_markers = [];
_markersMedecin = [];
_units = [];
_medics = [];
sleep 0.25;
if(visibleMap) then {
	{if(side _x == independent) then {_medics pushBack _x;}} foreach playableUnits; //Fetch list of cops / blufor
	if((FETCH_CONST(life_medicLevel)) in [0,1])then
	{
		{
			_name = _x getVariable "name";
			_down = _x getVariable ["Revive",false];
			if(!isNil "_name" && !_down) then {
				_units pushBack _x;
			};
		} foreach allDeadMen;
	};

	{
		if(_x != player) then {
			if((str player in life_listMedic) && (str _x in life_listMedic))then{_markerss = createMarkerLocal [format["%1_markerMedic",_x],getPosWorld _x];_markerss setMarkerColorLocal "ColorIndependent";_markerss setMarkerTypeLocal "Mil_dot";_markerss setMarkerTextLocal format["Medic %1", _x getVariable["realname",name _x]];_markersMedecin pushBack [_markerss,_x];};
			if((str player in life_listMecano) && (str _x in life_listMecano))then{_markerss = createMarkerLocal [format["%1_markerMedic",_x],getPosWorld _x];_markerss setMarkerColorLocal "ColorIndependent";_markerss setMarkerTypeLocal "Mil_dot";_markerss setMarkerTextLocal format["Mecano %1", _x getVariable["realname",name _x]];_markersMedecin pushBack [_markerss,_x];};
			if((str player in life_listMerce) && (str _x in life_listMerce))then{_markerss = createMarkerLocal [format["%1_markerMedic",_x],getPosWorld _x];_markerss setMarkerColorLocal "ColorIndependent";_markerss setMarkerTypeLocal "Mil_dot";_markerss setMarkerTextLocal format["Mercenaire %1", _x getVariable["realname",name _x]];_markersMedecin pushBack [_markerss,_x];};
			if((str player in life_listConces) && (str _x in life_listConces))then{_markerss = createMarkerLocal [format["%1_markerMedic",_x],getPosWorld _x];_markerss setMarkerColorLocal "ColorIndependent";_markerss setMarkerTypeLocal "Mil_dot";_markerss setMarkerTextLocal format["Concessionaire %1", _x getVariable["realname",name _x]];_markersMedecin pushBack [_markerss,_x];};
		};
	} foreach _medics;

	//Loop through and create markers.
	{
		_marker = createMarkerLocal [format["%1_dead_marker",_x],getPosWorld _x];
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerTypeLocal "loc_Hospital";
		_marker setMarkerTextLocal format["%1",(_x getVariable["name","Unknown Player"])];
		_markers pushBack _marker;
	} foreach _units;

	while {visibleMap} do {
		{
			private["_marker","_unit"];
			_markersss = _x select 0;
			_unit = _x select 1;
			if(!isNil "_unit") then {
				if(!isNull _unit) then {
					_markersss setMarkerPosLocal (getPosWorld _unit);
				};
			};
		} foreach _markersMedecin;
		if(!visibleMap) exitWith {};
		sleep 0.02;
	};
	{deleteMarkerLocal (_x select 0);} foreach _markersMedecin;
	_markersMedecin = [];
	_medics = [];
	waitUntil {!visibleMap};
	{deleteMarkerLocal _x;} foreach _markers;
};
