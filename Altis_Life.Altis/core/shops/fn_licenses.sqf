#include "..\..\script_macros.hpp"
/*
 fn_licenses.sqf
 
this addAction["Permis",life_fnc_licenses,["driver","boat","trucking","pilot","home","gun"],0,true,true,"",' playerSide isEqualTo civilian ']; this setVariable["realname","Vendeur de Permis"];
this addAction["Formation",life_fnc_licenses,["cement","copper","sand","silver","iron","salt","oil","diamond"],0,true,true,"",' playerSide isEqualTo civilian ']; this setVariable["realname","Formateur"];
this addAction["Illegal",life_fnc_licenses,["marijuana","heroin","cocaine"],0,true,true,"",' playerSide isEqualTo civilian '];


 
*/
private["_display","_listbox","_shortname","_longname","_price","_hasLicense","_displayname"];
 
_buyables = _this select 3; //called from action => select 3rd argument
 
 
if(!dialog) then
{
if(!(createDialog "LicenseShop")) exitWith {};
};
disableSerialization;

 _display = findDisplay 5546;
if(isNull _display) exitWith {};
_listbox = _display displayCtrl 55126;
_mylic = _display displayCtrl 55131;
_struct = "";
 
_side = switch(playerSide) do {case west:{"cop"}; case civilian:{"civ"}; case independent:{"med"};};
if(playerSide isEqualTo independent) then
{
	if((FETCH_CONST(life_medicLevel)) in [0,1]) exitWith {_flag="med";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 2) exitWith {_flag="mecano";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 3) exitWith {_flag="merce";};
	if((FETCH_CONST(life_medicLevel)) isEqualTo 4) exitWith {_flag="conces";};
};
 
{
	_shortname = _x;
	 
	_longname = M_CONFIG(getText,"Licenses",_shortname,"variable");
	_displayname = M_CONFIG(getText,"Licenses",_shortname,"displayName");
	_price = M_CONFIG(getNumber,"Licenses",_shortname,"price");
	_hasLicense = LICENSE_VALUE(_shortname,_side);
	if(!_hasLicense) then
	{
		_listbox lbAdd format["%1 ($%2)",localize _displayname, _price];
		_listbox lbSetData [(lbSize _listbox) - 1, _shortname];
	}
	else
	{
		_mylic lbAdd format["%1",localize _displayname];
		_mylic lbSetData [(lbSize _mylic) - 1, _shortname];
	};
}
foreach _buyables;
 