#include "..\..\script_macros.hpp"
/*
    File: fn_saveGear.sqf
    Author: Bryan "Tonic" Boardwine
    Full Gear/Y-Menu Save by Vampire
    Edited: Itsyuka

    Description:
    Saves the players gear for syncing to the database for persistence..
*/
private["_return","_uItems","_bItems","_vItems","_pItems","_hItems","_yItems","_uMags","_vMags","_bMags","_pMag","_hMag","_uni","_ves","_bag","_handled"];
_return = [];


if(playerside isEqualTo civilian)then
{
	if(!((uniform player) in ["U_B_CombatUniform_mcam_worn","U_B_SpecopsUniform_sgg","U_Rangemaster"]))then
	{
		_return pushBack uniform player;
	}else
	{
		_return pushBack "";
	};
	_return pushBack vest player;
	_return pushBack backpack player;
	_return pushBack goggles player;
	if(!((headgear player) in ["H_CrewHelmetHeli_B","G_Balaclava_TI_blk_F","H_Beret_blk","H_Beret_02","H_MilCap_gen_F","H_Beret_Colonel"]))then
	{
		_return pushBack headgear player;
	}else
	{
		_return pushBack "";
	};
	_return pushBack assignedITems player;
	if(!((primaryWeapon player) in ["arifle_SPAR_01_blk_F","arifle_SPAR_03_blk_F","arifle_CTAR_blk_F","srifle_DMR_03_khaki_F"]))then
	{
		_return pushBack primaryWeapon player;
	}else
	{
		_return pushBack "";
	};
}else
{
	_return pushBack uniform player;
	_return pushBack vest player;
	_return pushBack backpack player;
	_return pushBack goggles player;
	_return pushBack headgear player;
	_return pushBack assignedITems player;
	_return pushBack primaryWeapon player;
};
_return pushBack handgunWeapon player;

_uItems = [];
_uMags  = [];
_bItems = [];
_bMags  = [];
_vItems = [];
_vMags  = [];
_pItems = [];
_hItems = [];
_yItems = [];
_uni = [];
_ves = [];
_bag = [];

if (!(uniform player isEqualTo "")) then {
    {
        if (_x in (magazines player)) then {
            _uMags pushBack _x;
        } else {
            _uItems pushBack _x;
        };
    } forEach (uniformItems player);
};

if (!(backpack player isEqualTo "")) then {
    {
        if (_x in (magazines player)) then {
            _bMags pushBack _x;
        } else {
            _bItems pushBack _x;
        };
    } forEach (backpackItems player);
};

if (!(vest player isEqualTo "")) then {
    {
        if (_x in (magazines player)) then {
            _vMags pushBack _x;
        } else {
            _vItems pushBack _x;
        };
    } forEach (vestItems player);
};

if (count (primaryWeaponMagazine player) > 0 && alive player) then {
    _pMag = ((primaryWeaponMagazine player) select 0);

    if (!(_pMag isEqualTo "")) then {
        _uni = player canAddItemToUniform _pMag;
        _ves = player canAddItemToVest _pMag;
        _bag = player canAddItemToBackpack _pMag;
        _handled = false;

        if (_ves) then {
            _vMags pushBack _pMag;
            _handled = true;
        };

        if (_uni && !_handled) then {
            _uMags pushBack _pMag;
            _handled = true;
        };

        if (_bag && !_handled) then {
            _bMags pushBack _pMag;
            _handled = true;
        };
    };
};

if (count (handgunMagazine player) > 0 && alive player) then {
    _hMag = ((handgunMagazine player) select 0);

    if (!(_hMag isEqualTo "")) then {
        _uni = player canAddItemToUniform _hMag;
        _ves = player canAddItemToVest _hMag;
        _bag = player canAddItemToBackpack _hMag;
        _handled = false;

        if (_ves) then {
            _vMags pushBack _hMag;
            _handled = true;
        };

        if (_uni && !_handled) then {
            _uMags pushBack _hMag;
            _handled = true;
        };

        if (_bag && !_handled) then {
            _bMags pushBack _hMag;
            _handled = true;
        };
    };
};

if (count (primaryWeaponItems player) > 0) then {
    {
        _pItems pushBack _x;
    } forEach (primaryWeaponItems player);
};

if (count (handgunItems player) > 0) then {
    {
        _hItems pushBack _x;
    } forEach (handGunItems player);
};

{
    _val = ITEM_VALUE(_x);
    if (_val > 0) then {
        _yItems pushBack [_x,_val];
    };
} forEach ["pickaxe","fuelEmpty","fuelFull", "spikeStrip", "lockpick", "adnpack", "cartevisa", "menotte", "blastingcharge", "boltcutter", "defuseKit","storageSmall","storageBig","illegalbox","armoire","frigo","illegalboxbig","redgull","coffee","waterBottle","apple","peach","tbacon","donuts","rabbit","salema","ornate","mackerel","tuna","mullet","catshark","turtle_soup","truckWheel"];

_return pushBack _uItems;
_return pushBack _uMags;
_return pushBack _bItems;
_return pushBack _bMags;
_return pushBack _vItems;
_return pushBack _vMags;
_return pushBack _pItems;
_return pushBack _hItems;
_return pushBack _yItems;


life_gear = _return;
