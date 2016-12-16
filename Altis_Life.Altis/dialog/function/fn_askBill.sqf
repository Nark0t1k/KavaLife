#include "..\..\script_macros.hpp"
/*
	fn_askBill.sqf
*/
private["_unit","_price","_action"];

_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_price = [_this,1,0,[0]] call BIS_fnc_param;
_action = false;

if(isNull _unit) exitWith {}; //Not valid
if(isNil "_unit") exitwith {}; //Not Valid
if(!(_unit isKindOf "Man")) exitWith {}; //Not a unit
if(!isPlayer _unit) exitWith {}; //Not a human
if(life_KavaBank < _price)exitWith {[false] remoteExec ["life_fnc_paidBill",_unit];};

_action = [
	format["Le mecano %1 viens de te donner une facture de %2$, accepte tu de payer.",_unit getVariable["realname", name _unit],_price],
	"Facture Mecano",
	"Accepter",
	"Refuser"
] call BIS_fnc_guiMessage;

if(_action)then
{
	life_KavaBank = life_KavaBank - _price;
	[true,_price] remoteExec ["life_fnc_paidBill",_unit];
	[1] call SOCK_fnc_updatePartial;
	[] call life_fnc_hudUpdate;
}else
{
	[false] remoteExec ["life_fnc_paidBill",_unit];
};