#include "..\..\script_macros.hpp"
/*
	File: fn_useItem.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Main function for item effects and functionality through the player menu.
*/
private "_item";
disableSerialization;
if(life_is_processing)exitWith {hint "Vous ne pouvez pas faire cela pendant un traitement";};
if(EQUAL(lbCurSel 2005,-1)) exitWith {hint localize "STR_ISTR_SelectItemFirst";};
_item = CONTROL_DATA(2005);

switch (true) do {
	case (_item in ["coffee","waterBottle"]): {
		if(([false,_item,1] call life_fnc_handleInv)) then {
			life_thirst = 100;
			player setFatigue 0;
		};
	};
	case (_item isEqualTo "redgull"): {
		if(([false,_item,1] call life_fnc_handleInv)) then {
			life_thirst = 100;
			player setFatigue 0;
			[] spawn {
				titleText[localize "STR_ISTR_RedGullEffect","PLAIN"];
				player enableFatigue false;
				sleep 180;
				player enableFatigue true;
			};
		};
	};

	case (EQUAL(_item,"adnpack")): {
		[cursorTarget] spawn life_fnc_useAdnPack;
		closeDialog 0;
	};

	case (EQUAL(_item,"boltcutter")): {
		[cursorTarget] spawn life_fnc_boltcutter;
		closeDialog 0;
	};

	case (EQUAL(_item,"organ")): {
		closeDialog 0;
		if(player getVariable ["organ",false])exitWith{hint "Vous n avez pas besoin de ceci pour le moment";};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			player setVariable ["organ",true,true];
		};
	};
		
	case (EQUAL(_item,"blastingcharge")): {
		player reveal fed_bank;
		(group player) reveal fed_bank;
		[cursorTarget] spawn life_fnc_blastingCharge;
	};

	case (EQUAL(_item,"defusekit")): {
		[cursorTarget] spawn life_fnc_defuseKit;
	};

	case (EQUAL(_item,"storagesmall")): {
		[false] call life_fnc_storageBox;
	};

	case (EQUAL(_item,"storagebig")): {
		[true] call life_fnc_storageBox;
	};
	
	case (EQUAL(_item,"illegalbox")): {
		[0] call life_fnc_illegalBox;
	};
	
	case (EQUAL(_item,"illegalboxbig")): {
		[1] call life_fnc_illegalBox;
	};
	case (EQUAL(_item,"armoire")): {
		[2] call life_fnc_illegalBox;
	};
	case (EQUAL(_item,"frigo")): {
		[3] call life_fnc_illegalBox;
	};

	case (EQUAL(_item,"spikeStrip")): {
		if(!isNull life_activeObj) exitWith {hint localize "STR_ISTR_SpikesDeployment"};
		if(([false,_item,1] call life_fnc_handleInv)) then {
			[] spawn life_fnc_spikeStrip;
		};
	};

	case (EQUAL(_item,"fuelFull")): {
		if(vehicle player != player) exitWith {hint localize "STR_ISTR_RefuelInVehicle"};
		[] spawn life_fnc_jerryRefuel;
	};

	case (EQUAL(_item,"lockpick")): {
		[] spawn life_fnc_lockpick;
	};
	
	case (EQUAL(_item,"scalpel")): {
		[] spawn life_fnc_scalpel;
	};

	case (_item in ["apple","rabbit","salema","ornate","mackerel","tuna","mullet","catshark","turtle_soup","donuts","tbacon","peach","frite"]): {
		if(!(EQUAL(M_CONFIG(getNumber,"VirtualItems",_item,"edible"),-1))) then {
			if([false,_item,1] call life_fnc_handleInv) then {
				_val = M_CONFIG(getNumber,"VirtualItems",_item,"edible");
				_sum = life_hunger + _val;
				switch (true) do {
					case (_val < 0 && _sum < 1): {life_hunger = 5;}; //This adds the ability to set the entry edible to a negative value and decrease the hunger without death
					case (_sum > 100): {life_hunger = 100;};
					default {life_hunger = _sum;};
				};
			};
		};
	};

	default {
		[localize "STR_ISTR_NotUsable"] call life_fnc_showNotification;
	};
};

[] call life_fnc_p_updateMenu;
[] call life_fnc_hudUpdate;
