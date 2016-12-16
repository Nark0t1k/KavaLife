#include "..\script_macros.hpp"
/*
	File: configuration.sqf
	Author:

	Description:
	Master Life Configuration File
	This file is to setup variables for the client, there are still other configuration files in the system

*/

//
// System Variable
//
life_session_completed = false;
life_trunk_vehicle = Objnull;
life_sitting = objNull;
life_gangQG = objNull;
life_session_tries = 0;
life_pos_exist = false;
life_pos_attach = [];
life_pickup_item_array = [];
life_fed_break = 0;
life_preview_3D_vehicle_cam = objNull;
life_preview_3D_vehicle_object = objNull;
life_activeObj = ObjNull;
life_clothing_filter = 0;
errorProgress = 0;
life_noSound = 0;
life_my_group = ObjNull;
life_old_group = grpNull;
life_radarSpeed = 70;

//
//	Check Variable
//
life_action_delay = time;
life_garage_store = false;
life_action_inUse = false;
life_interrupted = false;
life_siren_active = false;
life_is_processing = false;
life_bail_paid = false;
life_disable_getIn = false;
life_disable_getOut = false;

//
//	Admin Variable
//
life_god = false;
life_frozen = false;
life_admin_debug = false;
life_markersvaar = false;
life_adminSpyName = false;
life_adminESP = false;

//
// Config Player Variable
//
life_respawnTimer = 0;
life_toxicArea = false;
life_messageTo = "";

//
//	Skills Info
//
life_skillGather = 0;
life_skillGatherCount = 0;
life_skillProcess = 0;
life_skillProcessCount = 0;
life_skillRepair = 0;
life_skillRepairCount = 0;
life_skillLock = 0;
life_skillLockCount = 0;


life_gangAreaOwner = 0;
life_isImpound = false;
life_corpse = objNull;

//Settings
life_settings_viewDistanceFoot = GVAR_PNAS["life_viewDistanceFoot",1250];
life_settings_viewDistanceFoot = GVAR_PNAS["life_viewDistanceFoot",1250];
life_settings_viewDistanceCar = GVAR_PNAS["life_viewDistanceCar",1250];
life_filter = GVAR_PNAS["life_KavaFilter",[true,true,true,true,true,false,true,true,true,true]];

//Uniform price (0),Hat Price (1),Glasses Price (2),Vest Price (3),Backpack Price (4)
life_clothing_purchase = [-1,-1,-1,-1,-1];
/*
*****************************
****** Weight Variables *****
*****************************
*/
life_maxWeight = LIFE_SETTINGS(getNumber,"total_maxWeight");
life_carryWeight = 0; //Represents the players current inventory weight (MUST START AT 0).

/*
*****************************
****** Life Variables *******
*****************************
*/
life_seatbelt = false;
life_save_gear = [];
life_civ_position = [];
life_WhiteList = false;
life_vehGarage = 0;
life_vehGarageMax = 8;
life_houseMax = 4;
life_friendList = [];
life_spotDrugs = [false,false,false,false];
life_jailTimer = 0;
life_HackRadio = false;
life_use_atm = true;
life_is_arrested = false;
life_is_alive = false;
life_delivery_in_progress = false;
life_thirst = 100;
life_hunger = 100;
life_KavaCash = 0;
life_showHealth = false;
life_showVehHealth = false;
life_curWep_h = "";
life_istazed = false;
life_isknocked = false;
life_vehicles = [];
life_chomage = true;
life_makeRapport = false;
life_indep_active = false;


life_listMedic = ["medic_1","medic_2","medic_3","medic_4","medic_5","medic_6","medic_7","medic_8","medic_9","medic_10"];
life_listMecano = ["mecano_1","mecano_2","mecano_3","mecano_4","mecano_5"];
life_listMerce = ["merce_1","merce_2","merce_3","merce_4","merce_5","merce_6","merce_7","merce_8","merce_9","merce_10","merce_11","merce_12","merce_13","merce_14","merce_15"];
life_listConces = ["conces_1","conces_2","conces_3"];

/*
	Notif Var
*/
uiNamespace setVariable ["RscNotification1",objNull];
uiNamespace setVariable ["RscNotification2",objNull];


/*
	Master Array of items?
*/
//Setup variable inv vars.
{
	SVAR_MNS [ITEM_VARNAME(configName _x),0];
	true;
} count ("true" configClasses (missionConfigFile >> "VirtualItems"));

/* Setup the BLAH! */
{
	_varName = getText(_x >> "variable");
	_sideFlag = getText(_x >> "side");

	SVAR_MNS [LICENSE_VARNAME(_varName,_sideFlag),false];
} foreach ("true" configClasses (missionConfigFile >> "Licenses"));

{
	if(!_x)then
	{
		[_forEachIndex+1,0] call life_fnc_s_onCheckedFilter;
	};
}foreach life_filter;