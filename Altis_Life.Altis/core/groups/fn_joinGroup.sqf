/*
	File: fn_joinGroup.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Joins the selected group if it is open.
*/
private["_dialog","_sel","_gangs","_gang","_group","_locked"];
disableSerialization;

_dialog = findDisplay 2520;
_gangs = _dialog displayCtrl 2521;
_sel = lbCurSel _gangs;
_data = _gangs lbData _sel;

_index = [_data,life_group_list] call life_fnc_index;
if(_index isEqualTo -1) exitWith {hint "Impossible de trouver ce groupe."};
_gang = life_group_list select _index;
_group = _gang select 1;
_password = _gang select 2;

if(!isNull _group) then
{
	if(_password isEqualTo "") then
	{		
		if (count (units _group) < 12) then
		{
			life_my_group = _group;
			[player] joinSilent _group;
			hint format["Tu as rejoins le groupe: %1",_gang select 0];
			closeDialog 0;
		}
		else
		{
			[[0,2], "Le groupe est full. Tu ne peux pas le rejoindre!"] call life_fnc_broadcast;
			closeDialog 0;
		};
	}
	else
	{
		[format["<t align='center'>Entrer un mot de passe pour %1.</t>", _gang select 0], "Entrer Pass Groupe", "Join"] call life_fnc_inputMenu;
		if (life_input_response isEqualTo "") exitWith {[] spawn life_fnc_groupBrowser};
		if (life_input_response isEqualTo _password) then
		{
			if (count (units _group) < 12) then
			{
				[player] joinSilent _group;
				life_my_group = _group;
				hint format["Tu as rejoins le groupe: %1",_gang select 0];
				closeDialog 0;
			}
			else
			{
				[[0,2], "Le groupe est full. Tu ne peux pas le rejoindre!"] call life_fnc_broadcast;
				closeDialog 0;
			};
		}
		else
		{
			hint format["Tu as entre un MAUVAIS pass pour le groupe, %1.",_gang select 0];
			[] spawn life_fnc_groupBrowser;
		};
	};
}
	else
{
	hint "Groupe non valide";
};