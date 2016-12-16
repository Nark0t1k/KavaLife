/*
	File: fn_deathScreen.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Handles stuff being displayed on the death screen while
	it is currently active.
*/
private["_medicsOnline","_medicsNear","_nbrMedic","_RespawnBtn","_MedicBtn"];
disableSerialization;

_medicsOnline = ((findDisplay 7300) displayCtrl 7304);
_medicsNear = ((findDisplay 7300) displayCtrl 7305);
_nbrMedic = 0;
// _RespawnBtn = ((findDisplay 7300) displayCtrl 7302);
// _RespawnBtn ctrlEnable false;
_MedicBtn = ((findDisplay 7300) displayCtrl 7303);
_MedicBtn ctrlEnable false;
{
	if (alive _x && _x != player && (str _x in life_listMedic)) exitWith
	{
		_MedicBtn ctrlEnable true;
	};
} foreach playableUnits;

waitUntil {
	_nearby = 99999;
	_nbrMedic = 0;
	{
		if (_x != player && (str _x in life_listMedic)) then
		{
			_distance = (getPosATL life_corpse) distance _x;
			if (_distance < _nearby) then { _nearby = _distance; };
			_nbrMedic = _nbrMedic + 1;
		};
	} foreach playableUnits;
	_medicsOnline ctrlSetText format["Medics Online: %1",_nbrMedic];
	if (_nearby isEqualTo 99999) then { _medicsNear ctrlSetText format["Medic Proche: Non",_nearby]; }
	else { _medicsNear ctrlSetText format["Medic Proche: %1m",[(round _nearby)] call life_fnc_numberText]; };
	sleep 1;
	(isNull (findDisplay 7300))
};
