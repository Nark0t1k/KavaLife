#include "..\..\script_macros.hpp"
/*
	fn_copIncinerator.sqf
	By Nark0t1k for Kavalash
	this addAction[""Activer Incinerateur"",life_fnc_copIncinerator,0];
	this addAction[""Activer Incinerateur"",life_fnc_copIncinerator,1];
*/

private ["_copBox", "_type", "_boxStorage", "_weapList", "_craftList", "_i", "_nbr", "_iron", "_uranium", "_gold", "_weap", "_ressource", "_listGat", "_ctrl", "_num", "_veh_data", "_inv", "_fullItemWeight", "_index", "_val"];
_type = _this select 3;
if(_type isEqualTo 0) then
{
	_copBox = copStorageBox1;
}else
{
	_copBox = copStorageBox2;
};
if(playerSide != west) exitWith {hint "Seul les gendarmes peuvents faire cela";};
if(life_action_inUse)exitWith {hint parseText localize "STR_NOTF_ActionBusy"};
_boxStorage = getWeaponCargo _copBox;
if(count (_boxStorage select 0) isEqualTo 0) exitWith {hint localize "STR_Cop_BoxEmpty"};
if(_copBox getVariable ["trunk_in_use",false]) exitWith {hint localize "STR_MISC_copStorageUse"};
life_action_inUse = true;
_copBox setVariable ["trunk_in_use",true,true];


clearWeaponCargoGlobal _copBox;
clearMagazineCargoGlobal _copBox;
clearBackpackCargoGlobal _copBox;
clearItemCargoGlobal _copBox;

_weapList = [
	"arifle_SDAR_F",
	"hgun_PDW2000_F",
	"hgun_Rook40_F", 
	"hgun_ACPC2_F",
	"hgun_Pistol_heavy_01_F", 
	"hgun_Pistol_heavy_02_F", 
	"srifle_LRR_camo_F", 
	"srifle_EBR_F", 
	"arifle_Katiba_F",
	"arifle_MX_F",
	"LMG_Mk200_F",
	"arifle_TRG21_F",
	"arifle_Mk20_plain_F",
	"srifle_DMR_03_woodland_F",
	"srifle_DMR_06_camo_F",
	"srifle_GM6_F",
	"SMG_02_F",
	"arifle_Mk20C_F",
	"arifle_MX_Black_F",
	"arifle_MXM_Black_F",
	"arifle_MX_SW_Black_F",
	"srifle_LRR_F",
	"srifle_DMR_06_olive_F",
	"srifle_DMR_03_khaki_F",
	"arifle_AKM_F",
	"arifle_SPAR_03_snd_F",
	"arifle_AKS_F",
	"arifle_CTAR_hex_F"
];

_craftList = [
	["arifle_SDAR_F", [["iron_refined",6]]],
	["hgun_PDW2000_F", [["iron_refined",4]]],
	["hgun_Rook40_F", [["iron_refined",3]]],
	["hgun_ACPC2_F", [["iron_refined",3]]],
	["hgun_Pistol_heavy_01_F", [["iron_refined",3]]],
	["hgun_Pistol_heavy_02_F", [["iron_refined",3]]],
	["srifle_LRR_camo_F", [["iron_refined",5],["goldbar",12]]],
	["srifle_EBR_F", [["iron_refined",15],["uraniumPur",5]]],
	["arifle_Katiba_F", [["iron_refined",16]]],
	["arifle_MX_F", [["iron_refined",16]]],
	["LMG_Mk200_F", [["iron_refined",15],["uraniumPur",5]]],
	["arifle_TRG21_F", [["iron_refined",12]]],
	["arifle_Mk20_plain_F", [["iron_refined",12]]],
	["srifle_DMR_03_woodland_F", [["iron_refined",15],["uraniumPur",5]]],
	["srifle_DMR_06_camo_F", [["iron_refined",15],["uraniumPur",5]]],
	["srifle_GM6_F", [["iron_refined",5],["goldbar",12]]],
	["SMG_02_F", [["iron_refined",6]]],
	["arifle_Mk20C_F", [["iron_refined",12]]],
	["arifle_MX_Black_F", [["iron_refined",16]]],
	["arifle_MXM_Black_F", [["iron_refined",25]]],
	["arifle_MX_SW_Black_F", [["iron_refined",25]]],
	["srifle_LRR_F", [["iron_refined",5],["goldbar",12]]],
	["srifle_DMR_06_olive_F", [["iron_refined",15],["uraniumPur",5]]],
	["srifle_DMR_03_khaki_F", [["iron_refined",15],["uraniumPur",5]]],
	["arifle_AKM_F", [["iron_refined",5],["uraniumPur",15]]],
	["arifle_SPAR_03_snd_F", [["iron_refined",5],["uraniumPur",15]]],
	["arifle_AKS_F", [["iron_refined",10],["uraniumPur",10]]],
	["arifle_CTAR_hex_F", [["iron_refined",10],["uraniumPur",10]]]
];

_i = 0;
_nbr = 0;
_iron = 0;
_uranium = 0;
_gold = 0;
{
	_weap = _x;
	_nbr = (_boxStorage select 1) select _i;
	if(_weap in _weapList)then
	{
				{
			if(_weap isEqualTo (_x select 0))exitWith 
			{
				_ressource = _x select 1;
				{
					switch (_x select 0) do
					{
						case "iron_refined": {_iron = _iron + (_x select 1)};
						case "uraniumPur": {_uranium = _uranium + (_x select 1)};
						case "goldbar": {_gold = _gold + (_x select 1)};
					};
				}foreach _ressource;
			};
		}forEach _craftList;
	};
	_i = _i + 1;
}foreach (_boxStorage select 0);

_listGat = [_iron,_uranium,_gold];

_i = 0;
{
	if(_x > 0) then
	{
		switch(_i)do
		{
			case 0:{_ctrl="iron_refined";_num = _iron;};
			case 1:{_ctrl="uraniumPur";_num = _uranium;};
			case 2:{_ctrl="goldbar";_num = _gold;};
		};
		_veh_data = _copBox getVariable ["Trunk",[[],0]];
		_inv = _veh_data select 0;
		_fullItemWeight = ([_ctrl] call life_fnc_itemWeight) * _num;

		_index = [_ctrl,_inv] call TON_fnc_index;
		if(_index isEqualTo -1) then
		{
			_inv pushBack [_ctrl,_num];
		}
			else
		{
			_val = _inv select _index select 1;
			_inv set[_index,[_ctrl,_val + _num]];
		};
	};
	_i = _i + 1;
}forEach _listGat;
if((_iron isEqualTo 0) && (_uranium isEqualTo 0) && (_gold isEqualTo 0)) then
{
	hint format["L'incinerateur a finit le travail mais aucun des objets dans le coffre ne pouvait etre recycler.",_iron,_uranium,_gold];
}else
{
	hint format["L'incinerateur a finit le travail vous avez recycler %1 Lingot de fer %2 Morceau d Uranium Pur et %3 Lingot d or.",_iron,_uranium,_gold];
};
_copBox setVariable["Trunk",[_inv,(_veh_data select 1) + _fullItemWeight],true];
life_action_inUse = false;
_copBox setVariable ["trunk_in_use",false,true];