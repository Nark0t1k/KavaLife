#include "..\..\script_macros.hpp"
/*
	fn_newMessMenu.sqf
*/
private ["_listPlayer", "_BoxBotin", "_BoxSelect"];

disableSerialization;
waitUntil {!isNull findDisplay 89000};
_listPlayer = CONTROL(89000,89001);
_BoxBotin = CONTROL(89000,89006);
_BoxSelect = CONTROL(89000,89007);

lbClear _listPlayer;
lbClear _BoxBotin;
lbClear _BoxSelect;

_BoxSelect lbAdd "Selection";
_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"target"];

if({side _x isEqualTo civilian} count playableUnits > 0) then {
	_BoxBotin lbAdd "Civils";
	_BoxBotin lbSetData [(lbSize _BoxBotin)-1,"civilian"];
};
if({side _x isEqualTo west} count playableUnits > 0) then {
	_BoxBotin lbAdd "Gendarmerie";
	_BoxBotin lbSetData [(lbSize _BoxBotin)-1,"west"];
	_BoxSelect lbAdd "Gendarme";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"west"];
};
if({side _x isEqualTo independent && (str _x in life_listMedic)} count playableUnits > 0) then {
	_BoxBotin lbAdd "Medecin";
	_BoxBotin lbSetData [(lbSize _BoxBotin)-1,"medic"];
	_BoxSelect lbAdd "Medecin";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"medic"];
};
if({side _x isEqualTo independent && (str _x in life_listMecano)} count playableUnits > 0) then {
	_BoxBotin lbAdd "Mecano";
	_BoxBotin lbSetData [(lbSize _BoxBotin)-1,"mecano"];
	_BoxSelect lbAdd "Mecano";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"mecano"];
};
if({side _x isEqualTo independent && (str _x in life_listMerce)} count playableUnits > 0) then {
	_BoxBotin lbAdd "Mercenaire";
	_BoxBotin lbSetData [(lbSize _BoxBotin)-1,"merce"];
	_BoxSelect lbAdd "Mercenaire";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"merce"];
};
if({side _x isEqualTo independent && (str _x in life_listConces)} count playableUnits > 0) then {
	_BoxBotin lbAdd "Concessionaire";
	_BoxBotin lbSetData [(lbSize _BoxBotin)-1,"conces"];
	_BoxSelect lbAdd "Concessionaire";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"conces"];
};
_BoxBotin lbSetCurSel 0;
_BoxSelect lbSetCurSel 0;
if((call life_adminlevel) > 0)then
{
	_BoxSelect lbAdd "Selection Admin";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"adminto"];
	_BoxSelect lbAdd "Tous Admin";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"adminall"];
}else
{
	_BoxSelect lbAdd "Admin";
	_BoxSelect lbSetData [(lbSize _BoxSelect)-1,"admin"];
};
