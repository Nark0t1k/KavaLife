#include "..\..\script_macros.hpp"
/*
	fn_updateSender.sqf
	0 Plist 
	1 Flist
	2 Cop
	3 Medic
	5 Admin
	6 AdminToAll
	
*/
private ["_type","_target","_showName"];

_type = _this select 0;

switch(_type) do
{
	case 0:{
		_target = lbData[88005,(lbCurSel 88005)];
		life_messageTo = call compile format["%1",_target];
		ctrlSetText[88002, format["Cible Actuel: %1",name life_messageTo]];
		ctrlEnable[88008,true];
	};
	case 1:{
		_target = lbData[88006,(lbCurSel 88006)];
		life_messageTo = call compile format["%1",_target];
		ctrlSetText[88002, format["Cible Actuel: %1",name life_messageTo]];
		ctrlEnable[88008,true];
	};
	case 2:{
		_target = lbData[88016,(lbCurSel 88016)];
		life_messageTo = _target;
		_showName = switch (_target) do
		{
			case "police": {"Gendarmerie"};
			case "medic": {"Medecin"};
			case "mecano": {"Mecano"};
			case "merce": {"Mercenaire"};
			case "conces": {"Concessionaire"};
			case "worker": {"Fabricant"};
			default {"Personne"};
		};
		ctrlSetText[88002,format["Cible Actuel: %1", _showName]];
		if(_target != "")then
		{
			ctrlEnable[88008,true];
		};
	};
	case 5:{
		life_messageTo = "admin";
		ctrlSetText[88002,"Cible Actuel: Admin"];
		ctrlEnable[88008,true];
	};
	case 6:{
		life_messageTo = "adminAll";
		ctrlSetText[88002,"Cible Actuel: Tous"];
		ctrlEnable[88008,true];
	};
	case 7:{
		_target = lbData[88005,(lbCurSel 88005)];
		life_messageTo = call compile format["%1",_target];
		ctrlSetText[88002, format["Cible Actuel: %1",name life_messageTo]];
		ctrlEnable[88008,true];
	};
	case 8:{
		ctrlSetText[88002, format["Cible Actuel: %1",name life_messageTo]];
		ctrlEnable[88008,true];
	};
};