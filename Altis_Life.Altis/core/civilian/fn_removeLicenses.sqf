#include "..\..\script_macros.hpp"
/*
	File: fn_removeLicenses.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Used for stripping certain licenses off of civilians as punishment.
*/
private "_state";
_state = param [0,1,[0]];

switch (_state) do {
	//Death while being wanted
	case 0: {
		SVAR_MNS [LICENSE_VARNAME("rebel","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("driver","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("trucking","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("pilot","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("marijuana","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("heroin","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("cocaine","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("meth1","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("meth2","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("meth3","civ"),false];
	};

	//Jail licenses
	case 1: {
		[format["[PERTE-LICENSE] %1(%2) a perdu sa license ARMES,VOITURE,REBELLE  si il en avait une cause PRISON",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];
		SVAR_MNS [LICENSE_VARNAME("gun","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("driver","civ"),false];
		SVAR_MNS [LICENSE_VARNAME("rebel","civ"),false];
	};

	//Remove motor vehicle licenses
	case 2: {
		if(GVAR_MNS LICENSE_VARNAME("driver","civ") OR GVAR_MNS LICENSE_VARNAME("pilot","civ") OR GVAR_MNS LICENSE_VARNAME("trucking","civ") OR GVAR_MNS LICENSE_VARNAME("boat","civ")) then {
			SVAR_MNS [LICENSE_VARNAME("pilot","civ"),false];
			SVAR_MNS [LICENSE_VARNAME("driver","civ"),false];
			SVAR_MNS [LICENSE_VARNAME("trucking","civ"),false];
			SVAR_MNS [LICENSE_VARNAME("boat","civ"),false];
			[localize "STR_Civ_LicenseRemove_1"] call life_fnc_showNotification;
		};
	};

	//Killing someone while owning a gun license
	case 3: {
		if(GVAR_MNS LICENSE_VARNAME("gun","civ")) then {
			SVAR_MNS [LICENSE_VARNAME("gun","civ"),false];
			[localize "STR_Civ_LicenseRemove_2"] call life_fnc_showNotification;
		};
	};

	//Illegal et perte de license chasseur de prime
	case 4: {
		[format["[PERTE-LICENSE] %1(%2) a perdu sa license   si il en avait une",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];
		if(GVAR_MNS LICENSE_VARNAME("chasseur","civ")) then {
			SVAR_MNS [LICENSE_VARNAME("chasseur","civ"),false];
			[localize "STR_Civ_LicenseRemove_3"] call life_fnc_showNotification;
		};
	};
	
	//Radar Fix Remove
	case 5: {
		[format["[PERTE-LICENSE] %1(%2) a perdu sa license VOITURE si il en avait une cause RADAR",name player, getPlayerUID player]] remoteExecCall ["A3Log", 2];
		if(GVAR_MNS LICENSE_VARNAME("driver","civ")) then {
			SVAR_MNS [LICENSE_VARNAME("driver","civ"),false];
		};
	};
};
