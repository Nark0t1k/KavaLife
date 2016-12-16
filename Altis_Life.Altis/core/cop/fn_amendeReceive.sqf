#include "..\..\script_macros.hpp"
/*
	File: fn_amendeReceive
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Prompts the player that he is being ticketed.
*/
private["_cop","_listContrav","_fullListContrav","_nbrContrav","_titleContrav","_priceContrav","_price","_priceListContrav"];
disableSerialization;
if(!isNull (findDisplay 14000)) exitwith {}; //Already at the ticket menu, block for abuse?
_cop = SEL(_this,0);
life_ticket_cop = _cop;
if(isNull _cop) exitWith {};
_ticketList = SEL(_this,1);
_price = 0;
createDialog "AmendePayDialog";
waitUntil {!isnull (findDisplay 14000)};

_listContrav = CONTROL(14000,14001);
_priceListContrav = CONTROL(14000,14002);

lbClear _listContrav;
_totalPrice = 0;
_price = 0;
for[{_i = 0},{_i < count(_ticketList)},{_i = _i + 1}] do {
	_curConfig = call compile format["%1", (_ticketList select _i)];
	_title = SEL(_curConfig,1);
	_price = SEL(_curConfig,2);
	_multi = SEL(_curConfig,3);
	_totalPrice = _totalPrice + (_price*_multi);
	_listContrav lbAdd format["%3x %1 - %2", _title, _price, _multi];
};

_priceListContrav ctrlSetText format["%1",[_totalPrice] call life_fnc_numberText];

life_ticket_paid = false;
life_ticket_val = _totalPrice;

[] spawn {
	disableSerialization;
	waitUntil {life_ticket_paid OR (isNull (findDisplay 14000))};
	if(isNull (findDisplay 14000) && !life_ticket_paid) then {
		[1,localize "STR_Cop_Ticket_Refuse"] remoteExec ["life_fnc_broadcast",life_ticket_cop];
	};
};