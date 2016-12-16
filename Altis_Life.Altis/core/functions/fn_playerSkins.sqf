#include "..\..\script_macros.hpp"
/*
    File: fn_playerSkins.sqf
    Author: Daniel Stuart

    Description:
    Sets skins for players by their side and uniform.
*/
switch(playerSide) do {
	case civilian: {
		if(life_is_arrested)then
		{
			if(uniform player isEqualTo "U_C_WorkerCoveralls") then {
				player setObjectTextureGlobal [0, "#(rgb,8,8,3)color(0.5,0.1,0,0.8)"];
			};
		};

	};
	case west: {
		if(uniform player isEqualTo "U_Rangemaster") then {
			player setObjectTextureGlobal [0, "textures\Polo_Gendarmerie.paa"];
		};
		if(uniform player isEqualTo "U_B_SpecopsUniform_sgg") then {
			player setObjectTextureGlobal [0, "textures\Uniforme_Polaire_Gendarme.paa"];
		};
		if(uniform player isEqualTo "U_B_CombatUniform_mcam_worn") then {
			player setObjectTextureGlobal [0, "textures\Uniforme_Grand_Froid_Gendarmerie.paa"];
		};
		if(backpack player != "") then {
			(backpackContainer player) setObjectTextureGlobal [0,""];
		};
		
	};
	case independent: {
		if(str player in life_listMedic) then
		{
			if(uniform player isEqualTo "U_Rangemaster") then {
				player setObjectTextureGlobal [0, "textures\med.paa"];
			};
			if(backpack player isEqualTo "B_TacticalPack_rgr") then {
				(backpackContainer player) setObjectTextureGlobal [0,"textures\backpack\backpack.paa"];
			};
		};
		if(str player in life_listMecano) then
		{
			if(uniform player isEqualTo "U_C_WorkerCoveralls") then {
				player setObjectTextureGlobal [0, "textures\unifmeca.paa"];
			};
			if(backpack player isEqualTo "B_Bergen_rgr") then {
				(backpackContainer player) setObjectTextureGlobal [0,"textures\backpack\sacDep.paa"];
			};
		};
	};
};
