#include "..\..\script_macros.hpp"
/*	File: fn_copSearchPlayer.sqf	
Author: Pojus/Pearlwar [ALI] Altis Life Italia    Modificato da: Al Morise(Sink)	
Description:	Ricerca armi e caricatori nei giocatori*/

private ["_viIllegal","_unit", "_weapon", "_magazine", "_bpack", "_veste", "_vestContainer", "_uniformeItems", "_cappello", "_illegalStuff", "_primaryWeapon", "_handgunWeapon", "_vest", "_headgear", "_illegalAccessory", "_displayName", "_illegalCheck", "_backpack", "_vestItems", "_uniformItems"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_viIllegal = _this select 1;
_weapon = "";
_magazine = "";
_bpack = "";
_veste = "";
_vestContainer = "";
_uniformeItems = "";
_cappello = "";
    //_unit = cursorTarget;
if (isNull _unit) exitWith {};

_illegalStuff =
[
	"srifle_LRR_camo_F","srifle_EBR_F","arifle_Katiba_F","arifle_MX_F","LMG_Mk200_F","arifle_TRG21_F","arifle_Mk20_plain_F","srifle_DMR_03_woodland_F","srifle_DMR_06_camo_F","srifle_GM6_F","arifle_AKM_F","arifle_SPAR_03_snd_F","arifle_AKS_F","arifle_CTAR_hex_F",
	"hgun_P07_snds_F","SMG_02_F","arifle_Mk20C_F","arifle_MX_Black_F","arifle_MXM_Black_F","arifle_MX_SW_Black_F","srifle_LRR_F","srifle_DMR_06_olive_F","srifle_DMR_03_khaki_F",
	"HandGrenade_Stone","SmokeShellGreen",
	"7Rnd_408_Mag","20Rnd_762x51_Mag","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_mag","200Rnd_65x39_cased_Box_Tracer","5Rnd_127x108_Mag","130Rnd_338_Mag","20Rnd_556x45_UW_mag","100Rnd_65x39_caseless_mag",
	"optic_SOS","optic_DMS","optic_MRCO","optic_Arco","optic_Hamr","optic_LRPS","optic_Aco","optic_NVS","optic_Holosight",
	"muzzle_snds_H","acc_flashlight","muzzle_snds_L",
	"U_BG_Guerilla2_1","U_I_GhillieSuit","U_I_FullGhillie_sard","U_IG_Guerrilla_6_1","U_I_CombatUniform_shortsleeve","U_IG_leader","U_I_G_Story_Protagonist_F","U_B_CTRG_2","U_O_CombatUniform_ocamo","U_O_PilotCoveralls","U_O_GhillieSuit",
	"V_TacVestIR_blk","V_PlateCarrierL_CTRG","V_PlateCarrier1_rgr","V_PlateCarrierIA1_dgtl","V_TacVest_blk","V_TacVest_brn","V_TacVest_oli","V_Chestrig_rgr","V_HarnessO_gry",
	"H_ShemagOpen_tan","H_Shemag_olive","H_ShemagOpen_khk","H_HelmetO_ocamo","H_MilCap_oucamo","H_Bandanna_camo","H_HelmetB_plain_mcamo","H_Booniehat_mcamo","H_MilCap_mcamo"
];

hint parseText "Fouille en cours, vérification des armes";
[7,"Un policier effectue une fouille de ton equipement!"] remoteExec ["life_fnc_broadcast",_unit];
sleep 1.5;
if (player distance _unit > 5 || !alive player || !alive _unit) exitWith {hint parseText "La personne est trop loins."};
_primaryWeapon = primaryWeapon _unit;
_handgunWeapon = handgunWeapon _unit;
_vest = vest _unit;
_headgear = headgear _unit;
_illegalAccessory = false;

if(_primaryWeapon != "") then {
	_displayName = getText(configFile >> "CfgWeapons" >> _primaryWeapon >> "displayName");
	if(_primaryWeapon in _illegalStuff)then
	{
		_illegalCheck = true;
		_weapon = format["<t color='#FF0000'>%1%2</t><br/>", _weapon, _displayName];
	}else
	{
		_weapon = format["<t color='#00FF00'>%1%2</t><br/>", _weapon, _displayName];
	};
};
				
if(_handgunWeapon != "") then {
	_displayName = getText(configFile >> "CfgWeapons" >> _handgunWeapon >> "displayName");
	if(_handgunWeapon in _illegalStuff)then
	{
		_illegalCheck = true;
		_weapon = format["<t color='#FF0000'>%1%2</t><br/>", _weapon, _displayName];
	}else
	{
		_weapon = format["<t color='#00FF00'>%1%2</t><br/>", _weapon, _displayName];
	};
};
if(_weapon isEqualTo "") then {_weapon = "Aucune Armes<br/>";};

hint parseText "Fouille en cours, vérification du sac à dos";
sleep 1.5;

if(backPack _unit != "") then {
	_backpack = backpackItems _unit;
	
    if(count _backpack > 0) then {
		{
			if(isClass (configFile >> "CfgWeapons" >> _x)) then {
				_displayName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
			}else {
				if(isClass (configFile >> "CfgMagazines" >> _x)) then {
					_displayName = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
				} else {
					if(isClass(configFile >> "CfgVehicles" >> "Vest_"+_x)) then {
						_displayName = getText(configFile >> "CfgVehicles" >> "Vest_"+_x >> "displayName");
					} else {
						if(isClass(configFile >> "CfgVehicles" >> "Headgear_"+_x)) then {
							_displayName = getText(configFile >> "CfgVehicles" >> "Headgear_"+_x >> "displayName");
						}else {
							_displayName = _x;
						};
					};
				};
			};
			
			if(_x in _illegalStuff) then {
				_bpack = format["<t color='#FF0000'>%1%2</t><br/>", _bpack,_displayName];
			} else {
				_bpack = format["<t color='#00FF00'>%1%2</t><br/>", _bpack,_displayName];
			};
		}forEach _backpack;
    } else {
		_bpack = "Le sac est vide.<br/>";
    };
} else {
	_bpack = "La personne n'a pas de sac.<br/>";
};

hint parseText "Fouille en cours, vérification de la veste";
sleep 1.5;

if( _vest != "" ) then {
    _vestItems = vestItems _unit;
	if(isClass (configFile >> "CfgVehicles" >> "Vest_"+_vest)) then {
		_displayName = getText(configFile >> "CfgVehicles" >> "Vest_"+_vest >> "displayName");
	}else {
		_displayName = _vest;
	};
    if(!(_vest in _illegalStuff)) then {
		_veste = format["<t color='#00FF00'>%1</t><br/>",_displayName];
    }else {
		_veste = format["<t color='#FF0000'>%1</t><br/>",_displayName];
	};
	 
	if(count _vestItems > 0) then {
		{	     
			if(isClass (configFile >> "CfgWeapons" >> _x)) then {
			_displayName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
			}else {		     
			if(isClass (configFile >> "CfgMagazines" >> _x)) then {
				_displayName = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
				} else {
					if(isClass(configFile >> "CfgVehicles" >> "Vest_"+_x)) then {
						_displayName = getText(configFile >> "CfgVehicles" >> "Vest_"+_x >> "displayName");
					} else {
						if(isClass(configFile >> "CfgVehicles" >> "Headgear_"+_x)) then {
							_displayName = getText(configFile >> "CfgVehicles" >> "Headgear_"+_x >> "displayName");
						}else {
							_displayName = _x;
						};
					};
				};
			};
			if(_x in _illegalStuff) then {
				_vestContainer = format["<t color='#FF0000'>%1%2</t><br/>", _vestContainer,_displayName];
			} else {
				_vestContainer = format["<t color='#00FF00'>%1%2</t><br/>", _vestContainer,_displayName];
			};
		}forEach _vestItems;
		
	}else {
		_vestContainer = "Pas d'objet dans la veste. <br/>";
	};
} else {
_veste = "La personne n'a pas de veste.<br/>";
};

hint parseText "Fouille en cours, vérification du chapeau/casque";
sleep 1.5;

if(_headgear != "") then {
   if(isClass(configFile >> "CfgVehicles" >> "Headgear_"+_headgear)) then {
   _displayName = getText(configFile >> "CfgVehicles" >> "Headgear_"+_headgear >> "displayName");
   }else {
	_displayName = _headgear;
	};
	if(!(_headgear in _illegalStuff)) then {
		_cappello = format["<t color='#00FF00'>%1</t><br/>",_displayName];
	}else {
		_cappello = format["<t color='#FF0000'>%1</t><br/>",_displayName];
	};
} else {
	_cappello = "La personne n'a pas de chapeau/casque.<br/>";
};

hint parseText "Fouille en cours, vérification de la tenue";
sleep 1.5;

if(uniform _unit != "") then {
	_uniformItems = uniformItems _unit;
	_uniform = uniform player;
	
	if(count _uniformItems > 0) then {
		{
			if(isClass (configFile >> "CfgWeapons" >> _x)) then {
				_displayName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
			}else {
				if(isClass (configFile >> "CfgMagazines" >> _x)) then {
					_displayName = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
				} else {
					if(isClass(configFile >> "CfgVehicles" >> "Vest_"+_x)) then {
						_displayName = getText(configFile >> "CfgVehicles" >> "Vest_"+_x >> "displayName");
					} else {
						if(isClass(configFile >> "CfgVehicles" >> "Headgear_"+_x)) then {
							_displayName = getText(configFile >> "CfgVehicles" >> "Headgear_"+_x >> "displayName");
						}else {
							_displayName = _x;
						};
					};
				};
			};
			if(_x in  _illegalStuff) then {
				_uniformeItems = format["<t color='#FF0000'>%1%2</t><br/>", _uniformeItems,_displayName];
			} else {
				_uniformeItems = format["<t color='#00FF00'>%1%2</t><br/>", _uniformeItems,_displayName];
			};
	   }forEach _uniformItems;
   }else {
	_uniformeItems = "Pas d'objet dans la tenue.<br/>";
	};
} else {
	_uniformeItems = "La personne n'a pas de tenue.<br/>";
};


hint parseText format["<t color='#FFFFFF'><t size='1'>Arme Equipé:</t></t><br/><t size ='0.7'>%1</t><br/><t color='#FFFFFF'><t size='1'>Contenu Sac</t></t><br/><t size ='0.7'>%2</t><br/><t color='#FFFFFF'><t size='1'>Veste</t></t><br/><t size ='0.7'>%3</t><br/><t color='#FFFFFF'><t size='1'>Contenu Veste</t></t><br/><t size ='0.7'>%4</t><br/><t color='#FFFFFF'><t size='1'>Chapeau/Casque</t></t><br/><t size ='0.7'>%5</t><br/><t color='#FFFFFF'><t size='1'>Contenu Uniform</t></t><br/><t size ='0.7'>%6</t><br/>Marchandise Illegal: %7$", _weapon,_bpack,_veste,_vestContainer,_cappello,_uniformeItems,_viIllegal];
_viIllegal = round(_viIllegal/4);
ADD(life_KavaBank,_viIllegal);

[player,getPlayerUID _unit] remoteExec ["life_fnc_copSearchRemove",_unit];