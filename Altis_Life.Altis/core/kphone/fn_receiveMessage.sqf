#include "..\..\script_macros.hpp"
/*
	fn_receiveMessage.sqf
*/
if(!hasInterface && !isDedicated)exitWith {};
private ["_type", "_unit", "_msg", "_loc", "_message", "_tmp", "_admin","_from","_markMecano"];

_type = _this select 0;
_msg = _this select 1;
_from = _this select 2;
_unit = _this select 3;
_loc = _this select 4;
if(isNil "_loc") then {_loc = "Inconnu";};
if(!life_is_alive) exitWith {};
switch(_type) do
{
	case 0: {
		if(!isNull findDisplay 88500)exitWith {};
		_message = format[">>>MESSAGE DE %1: %2",_from,_msg];
		if("ItemRadio" in (assignedItems player))then
		{
			["TextMessage",[format["Tu As Recu Un Nouveau Message Privé De %1",_from]]] call bis_fnc_showNotification;
			systemChat _message;
			hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>Nouveau Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Toi<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2",_from,_msg];
		}else
		{
			hint parseText "Tu n'as pas de telephone (Radio) et ne peux donc pas voir le contenu de message";
		};
		_tmp = [format["%1", getPlayerUID _unit],format["%1",_from],format["%1", _msg]];
		
		// if(life_HC_isActive) then {
			// [_unit,player,_msg] remoteExec ["HC_fnc_sendMessages",HC_Life];
		// }else
		// {
			// [_unit,player,_msg] remoteExec ["TON_fnc_sendMessages",RSERV];
		// };
	};
	case 2: {
		if(side player != west) exitWith {};
		if(player isEqualTo _unit)exitWith {};
		_message = format["--- 911 MESSAGE CITOYEN DE %1: %2",_from,_msg];
		hint parseText format ["<t color='#316dff'><t size='2'><t align='center'>Nouveau Rapport<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>La Gendarmerie<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><t color='#33CC33'>Coords: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3",_from,_loc,_msg];
		["PoliceDispatch",[format["Rapport Citoyen de %1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
		_tmp = [format["%1", getPlayerUID _unit],format["%1",_from],format["%1", _message]];
		
		// if(life_HC_isActive) then {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		// }else
		// {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		// };
	};
	case 3: {
		if(side player != independent) exitWith {};
		if(player isEqualTo _unit)exitWith {};
		if(((FETCH_CONST(life_medicLevel)) != 0) && ((FETCH_CONST(life_medicLevel)) != 1)) exitWith {};
		_message = format["!!! DEMANDE EMS: %1",_msg];
		hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>Demande EMS<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Les médecins<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><t color='#33CC33'>Coords: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3",_from,_loc,_msg];
		["TextMessage",[format["Demande EMS de %1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
		_tmp = [format["%1", getPlayerUID _unit],format["%1",_from],format["%1", _message]];
		
		// if(life_HC_isActive) then {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		// }else
		// {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		// };
	};
	case 5: {
		if((FETCH_CONST(life_adminlevel)) < 1) exitWith {};
		if(!life_is_alive) exitWith {};
		_message = format["!!! DEMANDE ADMIN DE %1: %2",_from,_msg];
		hint parseText format ["<t color='#ffcefe'><t size='2'><t align='center'>Demande Admin<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Les Admins<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><t color='#33CC33'>Coords: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3",_from,_loc,_msg];
		["AdminDispatch",[format["%1 A Demander L'Aide D'un Admin!",_from]]] call bis_fnc_showNotification;
		systemChat _message;
		_tmp = [format["%1", getPlayerUID _unit],format["%1",_from],format["%1", _message]];
		
		// if(life_HC_isActive) then {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		// }else
		// {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		// };
	};
	case 6: {
		_admin = format["Message Admin De: %1", _from];
		_message = format["!!!MESSAGE ADMIN: %1",_msg];
		if(!life_is_alive) exitWith {};
		hint parseText format ["<t color='#FF0000'><t size='2'><t align='center'>Message Admin<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Tous les joueurs<br/><t color='#33CC33'>De: <t color='#ffffff'>Les Admins<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1",_msg];
		["AdminMessage",["Tu As Recu Un Message Des Admins!"]] call bis_fnc_showNotification;
		systemChat _message;
		if((call life_adminlevel) > 0) then {systemChat _admin;};
	};
	case 7: {
		_message = format["!!! MESSAGE ADMIN: %1",_msg];
		_admin = format["Message Admin De: %1", _from];
		hint parseText format ["<t color='#FF0000'><t size='2'><t align='center'>Message Admin<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Toi<br/><t color='#33CC33'>De: <t color='#ffffff'>Les Admins<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1",_msg];
		["AdminMessage",["Tu As Recu Un Message Personnel Des Admins!"]] call bis_fnc_showNotification;
		systemChat _message;
		if((call life_adminlevel) > 0) then {systemChat _admin;};
	};
	case 8: {
		if(side player != independent) exitWith {};
		if(player isEqualTo _unit)exitWith {};
		if((FETCH_CONST(life_medicLevel)) != 2) exitWith {};
		_message = format["!!! DEMANDE MECANO: %1",_msg];
		hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>Demande Mecano<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Les mecano<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><t color='#33CC33'>Coords: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3<br/><t color='#00FFFF'>Appuye sur 8 dans les 20 sec</t> pour l'informer que tu arrive.",_from,_loc,_msg];
		["TextMessage",[format["Demande Mecano de %1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
		last_indep_call = _unit;
		last_indep_time = time;
		_markMecano = createMarkerLocal [format["%1_markerAskMecano",_from],getPosWorld _unit];
		_markMecano setMarkerColorLocal "ColorBlue";
		_markMecano setMarkerTypeLocal "mil_warning";
		_markMecano setMarkerTextLocal format["Demande Mecano: %1", _unit getVariable["realname", name _unit]];
		_tmp = [format["%1", getPlayerUID _unit],format["%1",_from],format["%1", _message]];
		
		// if(life_HC_isActive) then {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		// }else
		// {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		// };
		sleep 60;
		deleteMarkerLocal format["%1_markerAskMecano",_from];
	};
	case 9: {
		if((FETCH_CONST(life_adminlevel)) < 1) exitWith {};
		if(player isEqualTo _unit)exitWith {};
		if(!life_is_alive) exitWith {};
		_message = format["!!! RAPPORT ADMIN DE %1: %2",_from,_msg];
		hint parseText format ["<t color='#ffcefe'><t size='2'><t align='center'>Rapport contre joueur<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Les Admins<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><t color='#33CC33'>Coords: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3",_from,_loc,_msg];
		["AdminDispatch",[format["%1 a rapporté un joueur!",_from]]] call bis_fnc_showNotification;
		systemChat _message;
	};
	case 10: {
		if("ItemRadio" in (assignedItems player))then
		{
			hint parseText "<t color='#FFCC00'><t size='2'><t align='center'>ALARME MAISON<br/><br/><t color='#33CC33'><t align='left'>";
			["TextMessage",["Tu As Recu Une Alerte Pour Ta Maison"]] call bis_fnc_showNotification;
			systemChat "Tu As Recu Une Alerte Pour Ta Maison";
		}else
		{
			hint parseText "Tu n'as pas de telephone (Radio) et ne peux donc pas voir le contenu de message";
		};
	};
	case 11: {
		if(side player != independent) exitWith {};
		if(player isEqualTo _unit)exitWith {};
		if((FETCH_CONST(life_medicLevel)) != 3) exitWith {};
		_message = format["!!! DEMANDE MERCENAIRE: %1",_msg];
		hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>Demande MERCENAIRE<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Les mercenaires<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><t color='#33CC33'>Coords: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3",_from,_loc,_msg];
		["TextMessage",[format["Demande MERCENAIRE de %1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
		_tmp = [format["%1", getPlayerUID _unit],format["%1",_from],format["%1", _message]];
		
		// if(life_HC_isActive) then {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		// }else
		// {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		// };
	};
	case 12: {
		if(side player != independent) exitWith {};
		if(player isEqualTo _unit)exitWith {};
		if((FETCH_CONST(life_medicLevel)) != 4) exitWith {};
		_message = format["!!! DEMANDE CONCESSIONAIRE: %1",_msg];
		hint parseText format ["<t color='#FFCC00'><t size='2'><t align='center'>Demande CONCESSIONAIRE<br/><br/><t color='#33CC33'><t align='left'><t size='1'>Pour: <t color='#ffffff'>Les concessionaires<br/><t color='#33CC33'>De: <t color='#ffffff'>%1<br/><t color='#33CC33'>Coords: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%3",_from,_loc,_msg];
		["TextMessage",[format["Demande CONCESSIONAIRE de %1",_from]]] call bis_fnc_showNotification;
		systemChat _message;
		_tmp = [format["%1", getPlayerUID _unit],format["%1",_from],format["%1", _message]];
		
		// if(life_HC_isActive) then {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["HC_fnc_sendMessages",HC_Life];
		// }else
		// {
			// [getPlayerUID _unit, name _unit,_message,getPlayerUID player, name player] remoteExec ["TON_fnc_sendMessages",RSERV];
		// };
	};
};

