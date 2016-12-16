#include "..\..\script_macros.hpp"
/*
fn_loadImpoundPolice.sqf
*/
private["_display","_poste","_type"];
disableSerialization;
waitUntil {!isNull findDisplay 3800};
_display = findDisplay 3800;
_poste = _display displayCtrl 3801;
lbClear _poste;


_poste lbAdd "Poste de Kavala";
_poste lbSetData [(lbSize _poste)-1,"cop_car_1"];
_poste lbAdd "Poste de Athira";
_poste lbSetData [(lbSize _poste)-1,"cop_car_2"];
_poste lbAdd "Poste de Pyrgos";
_poste lbSetData [(lbSize _poste)-1,"cop_car_3"];
_poste lbAdd "Poste de Sofia";
_poste lbSetData [(lbSize _poste)-1,"cop_car_4"];

if(((player distance (getMarkerPos "police_hq_1") < 50) OR  (player distance (getMarkerPos "police_hq_2") < 50) OR (player distance (getMarkerPos "cop_spawn_3") < 30) OR (player distance (getMarkerPos "cop_spawn_5") < 50)) && (FETCH_CONST(life_coplevel) >= 3)) then  {
	_poste lbAdd "Destruction Vehicule";
	_poste lbSetData [(lbSize _poste)-1,"destruction"];
};