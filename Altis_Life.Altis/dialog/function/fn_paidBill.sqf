#include "..\..\script_macros.hpp"
/*
	fn_paidBill.sqf
*/
private["_price","_type"];
_type = [_this,0,false,[false]] call BIS_fnc_param;

if(_type)then
{
	_price = [_this,1,0,[0]] call BIS_fnc_param;
	[format[localize "STR_Meca_ClientPayd",_price]] call life_fnc_showNotification;
	life_KavaBank = life_KavaBank + _price;
}else
{
	[localize "STR_Meca_ClientNoPayd"] call life_fnc_showNotification;
};