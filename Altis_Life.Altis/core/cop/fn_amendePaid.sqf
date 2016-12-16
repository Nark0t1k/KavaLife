#include "..\..\script_macros.hpp"
/*
	File: fn_amendePaid.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pays the ticket.
*/

if(life_KavaCash < life_ticket_val) exitWith {
	if(life_KavaBank < life_ticket_val) exitWith {
		hint localize "STR_Cop_Ticket_NotEnough";
		[1,"STR_Cop_Ticket_NotEnoughNOTF",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
		closeDialog 0;
	};
	hint format[localize "STR_Cop_Ticket_Paid",[life_ticket_val] call life_fnc_numberText];
	SUB(life_KavaBank,life_ticket_val);
	life_ticket_paid = true;
	hint format["Tu as paye une amende de %1$", life_ticket_val];

	[1,"STR_Cop_Ticket_PaidNOTF_2",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
	[false,life_ticket_val,true,0,true] remoteExeC ["life_fnc_moneyFunction",life_ticket_cop];
	closeDialog 0;
};

SUB(life_KavaCash,life_ticket_val);
life_ticket_paid = true;
hint format["Tu as paye une amende de %1$", life_ticket_val];
closeDialog 0;
[1,"STR_Cop_Ticket_PaidNOTF_2",true,[profileName]] remoteExecCall ["life_fnc_broadcast",life_ticket_cop];
[false,life_ticket_val,true,0,true] remoteExeC ["life_fnc_moneyFunction",life_ticket_cop];