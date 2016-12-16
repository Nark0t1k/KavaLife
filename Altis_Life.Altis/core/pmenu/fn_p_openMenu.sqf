#include "..\..\script_macros.hpp"
/*
	File: fn_p_openMenu.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Opens the players virtual inventory menu
*/
if(!alive player || dialog) exitWith {}; //Prevent them from opening this for exploits while dead.
createDialog "playerSettings";
disableSerialization;

switch(playerSide) do {
	case west: {
		ctrlShow[2011,false];
		ctrlShow[2024,false];
		ctrlShow[2026,false];
		if(FETCH_CONST(life_coplevel) < 1)then
		{
			ctrlShow[2025,false];
			ctrlShow[2012,false];
			ctrlShow[2027,false];
		};
	};

	case civilian: {
		ctrlShow[2012,false];
		ctrlShow[2025,false];
		ctrlShow[2027,false];
	};

	case independent: {
		ctrlShow[2012,false];
		ctrlShow[2011,false];
		ctrlShow[2024,false];
		ctrlShow[2026,false];
		ctrlShow[2027,false];
		if((FETCH_CONST(life_mediclevel) < 1) || (FETCH_CONST(life_mediclevel) > 2))then
		{
			ctrlShow[2025,false];
		};
	};
};

// ctrlShow[2026,false];
// ctrlShow[2028,false];
// ctrlShow[2029,false];

if((call life_adminlevel) < 1) then {
	ctrlShow[2020,false];
	ctrlShow[2021,false];
};

[] call life_fnc_p_updateMenu;
[] call life_fnc_playerSkins;