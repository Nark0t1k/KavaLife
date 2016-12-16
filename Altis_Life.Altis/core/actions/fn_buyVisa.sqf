/*
	fn_buyVisa.sqf
	By Nark0t1k
*/

if(life_inv_cartevisa != 0)exitWith {[localize "STR_Visa_already"] call life_fnc_showNotification;};
if(life_KavaBank < 10000)exitWith {[localize "STR_Visa_NoMoney"] call life_fnc_showNotification;};
life_KavaBank = life_KavaBank - 10000;
[true,"cartevisa",1] call life_fnc_handleInv;
[localize "STR_Visa_buyCarte"] call life_fnc_showNotification;
closeDialog 0;
[1] call SOCK_fnc_updatePartial;