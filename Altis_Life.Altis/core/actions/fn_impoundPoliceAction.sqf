#include "..\..\script_macros.hpp"
/*
	File: fn_impoundPoliceAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Impounds the vehicle
*/
private["_dbInfo","_rebVeh","_notOwn","_Pos","_poste","_display","_vehicle","_type","_time","_price","_vehicleData","_upp","_ui","_progress","_pgText","_cP","_filters","_spawnPoint","_extractPos"];
_Pos = lbData [3801,lbCurSel 3801];
_spawnPoint = 0;

[_Pos] spawn 
{
	_rebVeh =["B_G_Offroad_01_F","O_T_LSV_02_unarmed_F","B_Heli_Light_01_stripped_F","B_G_Offroad_01_armed_F","O_MRAP_02_F","B_G_Offroad_01_armed_F"];
	_notOwn = false;
	_extractPos = _this select 0;
	_vehicle = life_vInact_curTarget;
	_filters = ["Car","Air","Ship"];
	if(!((KINDOF_ARRAY(_vehicle,_filters)))) exitWith {};
	if(player distance _vehicle > 10) exitWith {};

	_vehicleData = _vehicle getVariable ["vehicle_info_owners",[]];
	{
		if(getPlayerUID player isEqualTo SEL(_x,0)) exitWith {_notOwn = true;};
	}forEach _vehicleData;
	if(_notOwn) exitWith {hint parseText "Vous ne pouvez pas extraire vos propre véhicules";};
	if((_extractPos isEqualTo "destruction") && !((typeOf _vehicle) in _rebVeh))exitWith {hint "Seul les vehicules rebelles peuvent etre detruit";};
	
	if(EQUAL((count _vehicleData),0)) exitWith {deleteVehicle _vehicle}; //Bad vehicle.
	_vehicleName = FETCH_CONFIG2(getText,"CfgVehicles",(typeOf _vehicle),"displayName");
	if(playerSide isEqualTo west)then
	{
		[0,"STR_NOTF_BeingImpounded",true,[SEL(SEL(_vehicleData,0),1),_vehicleName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	}else
	{
		[0,"STR_NOTF_BeingImpoundedMecano",true,[SEL(SEL(_vehicleData,0),1),_vehicleName]] remoteExecCall ["life_fnc_broadcast",RCLIENT];
	};

	_handle = [localize "STR_NOTF_Impounding",true,10,0.01,0.18,""] spawn life_fnc_handleProgressBar;
	waitUntil { sleep 0.2;scriptDone _handle;}; 
	if(errorProgress > 0) exitWith {life_interrupted = false;life_is_processing=false;}; 

	if(EQUAL(count crew _vehicle,0)) then {
		if(_extractPos isEqualTo "destruction")then
		{
			_dbInfo = _vehicle getVariable ["dbInfo",[]];
			[0,"STR_NOTF_HasDestroy",true,[profileName,SEL(SEL(_vehicleData,0),1),_vehicleName]] remoteExecCall ["life_fnc_broadcast",west];
			[format["[COP.DESTROY] %1(%2) a detruit un %3",name player, getPlayerUID player,_vehicleName]] remoteExecCall ["A3Log", 2];
			ADD(life_KavaCash,25000);
			[] call life_fnc_hudUpdate;
			if (count _dbInfo isEqualTo 0) exitWith {};
			if(life_HC_isActive) then {
				[player,_dbInfo] remoteExecCall ["HC_fnc_chopShopSell",HC_Life];
			}else
			{
				[player,_dbInfo] remoteExecCall ["TON_fnc_chopShopSell",RSERV];
			};
			deleteVehicle _vehicle;
		}else
		{
			if(!(KINDOF_ARRAY(_vehicle,_filters))) exitWith {};
			_spawnPoint = count(nearestObjects[(getMarkerPos _extractPos),["Car","Ship","Air"],5]);
			if(_spawnPoint != 0) exitWith {[localize "STR_Shop_Veh_Block"] call life_fnc_showNotification;closeDialog 0;};
			_vehicle setPos (getMarkerPos _extractPos);
			_vehicle lock 0;
			[_vehicle,0] remoteExecCall ["life_fnc_lockVehicle",_vehicle];
			[0,"STR_NOTF_HasImpounded",true,[profileName,SEL(SEL(_vehicleData,0),1),_vehicleName]] remoteExecCall ["life_fnc_broadcast",west];
			[format["[COP.TRANSPORT] %1(%2) a extrait au poste un %3",name player, getPlayerUID player,_vehicleName]] remoteExecCall ["A3Log", 2];
		};
	} else {
		[localize "STR_NOTF_ImpoundingCancelled"] call life_fnc_showNotification;
	};
};