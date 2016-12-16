#include "..\..\script_macros.hpp"
/*
	fn_whiteList.sqf

*/
private ["_type","_money"];

_type = [_this,3,false,[false]] call BIS_fnc_param;

if(_type)then
{
	_money = life_KavaCash + life_KavaBank;
	if(_money < 75000)exitWith {hint parseText "<t size='1.1'>Pour rejoindre l'ile tu as besoin de 75.000$ va récolter des déchets.</t>";};
	hint parseText "<t size='1.1'>Bravo tu as reussi les tests.</t>";
	life_WhiteList=[false,false,0];
	player addItem "ItemMap";
	player assignItem "ItemMap";
	[getPlayerUID player,playerSide,nil,9] remoteExecCall ["DB_fnc_updatePartial",RSERV];
	[] call SOCK_fnc_updateRequest;
	sleep 3;
	["Whitelisted",true,true] call BIS_fnc_endMission;
}else
{
	player unassignItem "itemMap";
	player removeItem "itemMap";
	player unassignItem "ItemGPS";
	player removeItem "ItemGPS";
	life_is_alive = false;
	player allowDamage false;
	player setPosATL [230.463,30527.4,193.49];
	player setDir 346.441;
	life_WhiteList=[false,false,0];
	hint parseText format["<t size='1.1'>Bonjour, %1 tu es arriver dans la zone de transit pour l'ile d'Altis.</t>", profileName];
	sleep 10;
	hint parseText "<t size='1.1'>Tu dois effectuer quelque test avant de pouvoir rejoindre l'ile principal.</t>";
	sleep 5;
	hint parseText "<t size='1.1'>Tu ne pourra pas accéder au reste de l'ile temps que tu n'as pas terminé les tests.</t>";
	sleep 3;
	hint parseText "<t size='1.1'>Pour commencer rend toi vers le personnage avec la fleche rose et parle lui.</t>";
};

