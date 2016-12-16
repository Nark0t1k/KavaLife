/*
	File: fn_civMarkers.sqf
	Author: 

	Description:
	Add markers for civilians in groups.
*/
private["_markers","_members","_membersG"];
_markers = [];
_members = [];

if((isNull life_my_group) && (isNull life_gangQG))exitWith {};

if(!isNull life_gangQG)then
{
	_membersG = [];
	{
	if(_x getVariable ["gang_qg",objNull] isEqualTo life_gangQG)then{_membersG pushBack _x;};
	}foreach playableunits;
};
while {true} do
{
	sleep 1;
	if(visibleMap) then
	{
		if(!alive player) exitWith {};
		if(!isNull life_my_group)then
		{
			_members = units (life_my_group);
			{
				if(_x != player) then {
					_marker = createMarkerLocal [format["%1_marker",_x],getPosWorld _x];
					_marker setMarkerColorLocal "ColorGreen";
					_marker setMarkerTypeLocal "Mil_dot";
					_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];
					_markers pushBack [_marker,_x];
				};
			} foreach _members;
		};
		if(!isNull life_gangQG)then
		{
			{
				if((_x != player) && (!(_x in [_members]))) then {
					_marker = createMarkerLocal [format["%1_marker",_x],getPosWorld _x];
					_marker setMarkerColorLocal "ColorRed";
					_marker setMarkerTypeLocal "Mil_dot";
					_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];
					_markers pushBack [_marker,_x];
				};
			} foreach _membersG;
		};

		while {visibleMap} do
		{
			{
				private["_marker","_unit"];
				_marker = _x select 0;
				_unit = _x select 1;
				if(!isNil "_unit" && !isNull _unit) then {
					  _marker setMarkerPosLocal (getPosWorld _unit);
				};
			} foreach _markers;
			if(!visibleMap) exitWith {};
			sleep 1;
		};

		{deleteMarkerLocal (_x select 0);} foreach _markers;
		_markers = [];
		_members = [];
	};
	if(!visibleMap) exitWith {};
};
