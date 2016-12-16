#include "..\..\script_macros.hpp"
/*
	File: fn_ticketPay.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pays the ticket.
*/
if(isNil "life_ticket_val" OR isNil "life_ticket_cop") exitWith {};
if(life_KavaCash < life_ticket_val) exitWith {
	if(life_KavaBank < life_ticket_val) exitWith {
		[localize "STR_Cop_Ticket_NotEnough"] call life_fnc_showNotification;
		[[0,7],"STR_Cop_Ticket_NotEnoughNOTF",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
		closeDialog 0;
	};
	
	[format[localize "STR_Cop_Ticket_Paid",[life_ticket_val] call life_fnc_numberText]] call life_fnc_showNotification;
	SUB(life_KavaBank,life_ticket_val);
	life_ticket_paid = true;
	
	[[0,7],"STR_Cop_Ticket_PaidNOTF",true,[profileName,[life_ticket_val] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",west];
	[[0,7],"STR_Cop_Ticket_PaidNOTF_2",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
	[life_ticket_val,player,life_ticket_cop] remoteExecCall ["life_fnc_ticketPaid",life_ticket_cop];
	
	if(life_HC_isActive) then {
		[getPlayerUID player] remoteExecCall ["HC_fnc_wantedRemove",HC_Life];
	} else {
		[getPlayerUID player] remoteExecCall ["life_fnc_wantedRemove",RSERV];
	};
	
	closeDialog 0;
};

SUB(life_KavaCash,life_ticket_val);
life_ticket_paid = true;
[format["[AMENDE.PAYER] %1(%2) -A PAYER UN AMENDE DE %3",name player, getPlayerUID player,[life_ticket_val] call life_fnc_numberText]] remoteExecCall ["A3Log", 2];
if(life_HC_isActive) then {
	[getPlayerUID player] remoteExecCall ["HC_fnc_wantedRemove",HC_Life];
} else {
	[getPlayerUID player] remoteExecCall ["life_fnc_wantedRemove",RSERV];
};
[] call life_fnc_hudUpdate;
[0,"STR_Cop_Ticket_PaidNOTF",true,[profileName,[life_ticket_val] call life_fnc_numberText]] remoteExecCall ["life_fnc_broadcast",west];
closeDialog 0;
[1,"STR_Cop_Ticket_PaidNOTF_2",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
[life_ticket_val,player,life_ticket_cop] remoteExecCall ["life_fnc_ticketPaid",life_ticket_cop];