#include "..\..\script_macros.hpp"
/*
	fn_showIdentity.sqf
	By Nark0t1k
*/
private ["_hasLicGun", "_hasLicHelico", "_hasLicBoat", "_hasLicTruck", "_hasLicCar", "_toShow", "_info", "_rank", "_name"];

_toShow = [_this,0,objNull,[objNull]] call BIS_fnc_param;

if(isNull _toShow) exitWith {};

_name = player getVariable["realname", name player];

switch (playerSide) do
{
	case civilian: 
	{
		if((side _toShow) isEqualTo west) then
		{
			_name = if(!(LICENSE_VALUE("identite","civ"))) then {"<t color='#FF0000'>Non Disponible</t>"}else{player getVariable["realname", name player]};
			_hasLicCar = if(LICENSE_VALUE("driver","civ")) then {"<t color='#2EFE2E'>Oui</t>"}else{"<t color='#FF0000'>Non</t>"};
			_hasLicTruck = if(LICENSE_VALUE("trucking","civ")) then {"<t color='#2EFE2E'>Oui</t>"}else{"<t color='#FF0000'>Non</t>"};
			_hasLicBoat = if(LICENSE_VALUE("boat","civ")) then {"<t color='#2EFE2E'>Oui</t>"}else{"<t color='#FF0000'>Non</t>"};
			_hasLicHelico = if(LICENSE_VALUE("pilot","civ")) then {"<t color='#2EFE2E'>Oui</t>"}else{"<t color='#FF0000'>Non</t>"};
			_hasLicGun = if(LICENSE_VALUE("gun","civ")) then {"<t color='#2EFE2E'>Oui</t>"}else{"<t color='#FF0000'>Non</t>"};
			if(license_civ_chasseur)then
			{
				_info = format["<t color='#FFCC00'><t size='2'><t align='center'>Carte d'identité<br/></t></t></t><t color='#FFCC00'><t size='1.3'><t align='center'>Citoyen d'Altis<br/></t></t></t><br/><t align='left'><t size='1.4'><t color='#33CC33'>Nom: </t><t color='#ffffff'>%1</t><br/><t color='#33CC33'>P. Voiture: </t>%2<br/><t color='#33CC33'>P. Camion: </t>%3<br/><t color='#33CC33'>P. Bateau: </t>%4<br/><t color='#33CC33'>P. Helico: </t>%5</t><br/><t color='#33CC33'>P. Arme: </t>%6</t><br/><t color='#FF0000'>!Chasseur de Prime!</t></t>",_name ,_hasLicCar,_hasLicTruck,_hasLicBoat,_hasLicHelico,_hasLicGun];
			}else
			{
				_info = format["<t color='#FFCC00'><t size='2'><t align='center'>Carte d'identité<br/></t></t></t><t color='#FFCC00'><t size='1.3'><t align='center'>Citoyen d'Altis<br/></t></t></t><br/><t align='left'><t size='1.4'><t color='#33CC33'>Nom: </t><t color='#ffffff'>%1</t><br/><t color='#33CC33'>P. Voiture: </t>%2<br/><t color='#33CC33'>P. Camion: </t>%3<br/><t color='#33CC33'>P. Bateau: </t>%4<br/><t color='#33CC33'>P. Helico: </t>%5<br/><t color='#33CC33'>P. Arme: </t>%6</t></t>",_name ,_hasLicCar,_hasLicTruck,_hasLicBoat,_hasLicHelico,_hasLicGun];
			};
		}else
		{
			_info = format["<t color='#FFCC00'><t size='2'><t align='center'>Carte d'identité<br/></t></t></t><t color='#FFCC00'><t size='1.3'><t align='center'>Citoyen d'Altis<br/></t></t></t><br/><t align='left'><t size='1.4'><t color='#33CC33'>Nom: </t><t color='#ffffff'>%1</t></t></t>",_name];
		};
	};
	case west:
	{
		_rank = switch (FETCH_CONST(life_coplevel)) do
		{
			case 0: {"Agent de Quartier"};
			case 1: {"Gendarme Adjoint Volontaire"};
			case 2: {"Gendarme"};
			case 3: {"Adjudant"};
			case 4: {"Major"};
			case 5: {"Lieutenant"};
			case 6: {"Capitaine"};
			case 7: {"Commandant"};
			case 8: {"Lieutenant Colonel"};
			case 9: {"Colonel"};
			case 10: {"Négociateur"};
			default {"Erreur"};
		};
		_info = format["<t color='#FFCC00'><t size='2'><t align='center'>Carte d'identité<br/></t></t></t><t color='#FFCC00'><t size='1.3'><t align='center'>Policier d'Altis<br/></t></t></t><br/><t align='left'><t size='1.4'><t color='#33CC33'>Nom: </t><t color='#ffffff'>%1</t><br/><t color='#33CC33'>Rang: </t><t color='#ffffff'>%2</t></t></t>", _name, _rank];
	
	};
	case independent: 
	{
		_rank = switch (FETCH_CONST(life_medicLevel)) do
		{
			case 0: {"Médecin d'Altis"};
			case 1: {"Médecin d'Altis"};
			case 2: {"Mécanicien"};
			case 3: {"Mercenaire"};
			case 4: {"Concessionaire"};
			case 5: {"Médecin d'Altis"};
			case 6: {"Médecin d'Altis"};
			case 7: {"Médecin d'Altis"};
			case 8: {"Médecin d'Altis"};
			case 9: {"Médecin d'Altis"};
			case 10: {"Médecin d'Altis"};
			default {"Erreur"};
		};
		
		if((side _toShow) isEqualTo west) then
		{
			_info = format["<t color='#FFCC00'><t size='2'><t align='center'>Carte d'identité<br/></t></t></t><t color='#FFCC00'><t size='1.3'><t align='center'>Independent<br/></t></t></t><br/><t align='left'><t size='1.4'><t color='#33CC33'>Nom: </t><t color='#ffffff'>%1</t><br/><t color='#33CC33'>Métier: </t><t color='#ffffff'>%2</t><br/><t color='#33CC33'>P. Voiture: </t><t color='#2EFE2E'>Oui</t><br/><t color='#33CC33'>P. Camion: </t><t color='#2EFE2E'>Oui</t><br/><t color='#33CC33'>P. Bateau: </t><t color='#2EFE2E'>Oui</t><br/><t color='#33CC33'>P. Helico: </t><t color='#2EFE2E'>Oui</t></t></t></t>", _name, _rank];

		}else
		{
			_info = format["<t color='#FFCC00'><t size='2'><t align='center'>Carte d'identité<br/></t></t></t><t color='#FFCC00'><t size='1.3'><t align='center'>Independent<br/></t></t></t><br/><t align='left'><t size='1.4'><t color='#33CC33'>Nom: </t><t color='#ffffff'>%1</t><br/><t color='#33CC33'>Métier: </t><t color='#ffffff'>%2</t></t></t>", _name, _rank];
		};
		
	};
};

[3,format["%1",_info]] remoteExecCall ["life_fnc_broadcast",player];
[3,format["%1",_info]] remoteExecCall ["life_fnc_broadcast",_toShow];