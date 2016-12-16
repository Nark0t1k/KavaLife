#include "..\..\script_macros.hpp"
/*
	File: fn_requestReceived.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Called by the server saying that we have a response so let's
	sort through the information, validate it and if all valid
	set the client up.
*/
private["_array","_handle"];
life_session_tries = life_session_tries + 1;
if(life_session_completed) exitWith {}; //Why did this get executed when the client already initialized? Fucking arma...
if(life_session_tries > 3) exitWith {cutText[localize "STR_Session_Error","BLACK FADED"]; 0 cutFadeOut 999999999;};

0 cutText [localize "STR_Session_Received","BLACK FADED"];
0 cutFadeOut 9999999;
_checkName = false;
_tmpName = format["%1", profileName];
if(count _tmpName < 8) then {_checkName = true;};
_tmpName = _tmpName splitString " ";
if(count _tmpName < 2) then {_checkName = true;};
if(count SEL(_tmpName,0) < 3) then {_checkName = true;};
if(count SEL(_tmpName,1) < 3) then {_checkName = true;};
if(_checkName) exitWith {
	hint format["Votre pseudonyme : %1",profileName];
	["Pour pouvoir rejoindre le serveur, veuillez utiliser un pseudo RP !<br/><br/>- Un nom et un prénom<br/>- 8 caratère au total minimum<br/>- 3 caratère minimum pour le nom et pour le prenom", "Changement de pseudo", "J'ai compris !"] call BIS_fnc_guiMessage;
	["NameExists",false,false] call BIS_fnc_endMission;
	sleep 30;
};

//Error handling and junk..
if(isNil "_this") exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if(EQUAL(typeName _this,"STRING")) exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if(EQUAL(count _this,0)) exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if(EQUAL(SEL(_this,0),"Error")) exitWith {[] call SOCK_fnc_insertPlayerInfo;};
if(!(EQUAL(getPlayerUID player,SEL(_this,0)))) exitWith {[] call SOCK_fnc_dataQuery;};

//Parse basic player information.
life_KavaCash = parseNumber (SEL(_this,2));
life_KavaBank = parseNumber (SEL(_this,3));
CONST(life_adminlevel,parseNumber (SEL(_this,4)));
CONST(life_donator,parseNumber (SEL(_this,5)));

//Loop through licenses
if(count (SEL(_this,6)) > 0) then {
	{SVAR_MNS [SEL(_x,0),SEL(_x,1)];} foreach (SEL(_this,6));
};

life_gear = SEL(_this,8);
[true] call life_fnc_loadGear;

//Parse side specific information.
switch(playerSide) do {
	case west: {
		life_is_alive = true;
		CONST(life_coplevel, parseNumber(SEL(_this,7)));
		CONST(life_medicLevel,0);
		life_blacklisted = SEL(_this,9);
		life_hunger = SEL(SEL(_this,10),0);
		life_thirst = SEL(SEL(_this,10),1);
		player setDamage SEL(SEL(_this,10),2);
	};

	case civilian: {
		life_is_arrested = SEL(_this,7);
		CONST(life_coplevel, 0);
		CONST(life_medicLevel, 0);
		life_houses = SEL(_this,15);
		life_hunger = SEL(SEL(_this,9),0);
		life_thirst = SEL(SEL(_this,9),1);
		player setDamage SEL(SEL(_this,9),2);
		_tmp = SEL(SEL(_this,9),3);
		for "_i" from 0 to 10 do {
			player setHitIndex [_i, SEL(_tmp,_i)];
		};

		//Position
		life_is_alive = SEL(_this,10);
		life_civ_position = SEL(_this,11);
		if(life_is_alive) then {
			if(count life_civ_position != 3) then {diag_log format["[requestReceived] Bad position received. Data: %1",life_civ_position];life_is_alive =false;};
			if(life_civ_position distance (getMarkerPos "respawn_civilian") < 300) then {life_is_alive = false;};
			if(life_civ_position distance [230.463,30527.4,193.49] < 300) then {life_is_alive = false;};
		};

		life_friendList = SEL(_this,13);
		life_WhiteList = SEL(_this,14);
		{
			_house = nearestBuilding (call compile format["%1", SEL(_x,0)]);
			life_vehicles pushBack _house;
		} foreach life_houses;
		
		life_gangData = SEL(_this,16);
		if(!(EQUAL(count life_gangData,0))) then {
			_handle = [] spawn life_fnc_initGang;
			waitUntil {scriptDone _handle};			
		};
		[] spawn life_fnc_initHouses;
	};

	case independent: {
		life_is_alive = true;
		CONST(life_medicLevel, parseNumber(SEL(_this,7)));
		CONST(life_coplevel,0);
		life_blacklisted = SEL(_this,9);
		life_hunger = SEL(SEL(_this,10),0);
		life_thirst = SEL(SEL(_this,10),1);
		player setDamage SEL(SEL(_this,10),2);

	};
};

if(count (SEL(_this,17)) > 0) then {
	{life_vehicles pushBack _x;} foreach (SEL(_this,17));
};

// if(life_HC_isActive) then {
	// [player] remoteExec ["HC_fnc_getMessages",HC_Life];
// }else
// {
	// [player] remoteExec ["TON_fnc_getMessages",RSERV];
// };

if(life_HC_isActive) then {
	[player,getPlayerUID player] remoteExec ["HC_fnc_queryPlayerSkills",HC_Life];
}else
{
	[player,getPlayerUID player] remoteExec ["TON_fnc_queryPlayerSkills",RSERV];
};

life_session_completed = true;

if(playerSide != civilian) exitWith {};
if (count life_gangData isEqualTo 0) exitWith {};
if(life_HC_isActive) then {
	[player,getPlayerUID player,(life_gangData select 5)] remoteExecCall ["HC_fnc_queryPlayerFullGang",HC_Life];
}else
{
	[player,getPlayerUID player,(life_gangData select 5)] remoteExec ["TON_fnc_queryPlayerFullGang",RSERV];
};

