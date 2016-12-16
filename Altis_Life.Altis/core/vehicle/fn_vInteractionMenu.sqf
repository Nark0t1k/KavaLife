#include "..\..\script_macros.hpp"
/*
	File: fn_vInteractionMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Replaces the mass addactions for various vehicle actions
*/
#define Btn0 37449
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457
#define Btn9 37458
#define Title 37401
private["_display","_curTarget","_Btn0","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8","_Btn9","_dlcVehicles","_dbInfo"];
if(!dialog) then {
	createDialog "vInteraction_Menu";
};
disableSerialization;

_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target
_isVehicle = if((_curTarget isKindOf "landVehicle") OR (_curTarget isKindOf "Ship") OR (_curTarget isKindOf "Air")) then {true} else {false};
if(!_isVehicle) exitWith {closeDialog 0;};

_display = findDisplay 37400;
_Btn0 = _display displayCtrl Btn0;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
_Btn9 = _display displayCtrl Btn9;
life_vInact_curTarget = _curTarget;
_dlcVehicles = ["C_Kart_01_Blu_F","C_Kart_01_Red_F","C_Kart_01_Fuel_F","C_Kart_01_Vrana_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_F","O_Heli_Transport_04_F","O_Heli_Transport_04_ammo_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_box_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_fuel_F","O_Heli_Transport_04_medevac_F","O_Heli_Transport_04_repair_F","C_Offroad_02_unarmed_F","C_Plane_Civil_01_F","C_Plane_civil_01_racing_F","B_T_VTOL_01_vehicle_F","C_Scooter_Transport_01_F","I_C_Boat_Transport_02_F","O_T_LSV_02_unarmed_F","B_T_LSV_01_unarmed_F"];

{_x ctrlShow false;} foreach [_Btn0,_Btn1,_Btn2,_Btn3,_Btn4,_Btn5,_Btn6,_Btn7,_Btn8,_Btn9];

//Set Repair Action
_Btn1 ctrlSetText localize "STR_vInAct_Repair";
_Btn1 buttonSetAction "closeDialog 0;[life_vInact_curTarget] spawn life_fnc_repairTruck;";
_Btn1 ctrlShow true;
if("ToolKit" in (items player) && (damage _curTarget < 1)) then {_Btn1 ctrlEnable true;} else {_Btn1 ctrlEnable false;};

if(playerSide isEqualTo west) then {
	_Btn2 ctrlSetText localize "STR_vInAct_Registration";
	_Btn2 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_searchVehAction;";
	_Btn2 ctrlShow true;
	
	_Btn3 ctrlSetText localize "STR_vInAct_SearchVehicle";
	_Btn3 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_vehInvSearch;";
	_Btn3 ctrlShow true;
	
	_Btn4 ctrlSetText localize "STR_vInAct_PullOut";
	_Btn4 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_pulloutAction;";
	_Btn4 ctrlShow true;
	if(count crew _curTarget isEqualTo 0) then {_Btn4 ctrlEnable false;};
	
	_Btn5 ctrlSetText localize "STR_vInAct_Impound";
	_Btn5 buttonSetAction "createDialog ""Life_impoundPolice_menu"";";
	_Btn5 ctrlShow true;
};

if(playerSide isEqualTo civilian) then {
	if(typeOf _curTarget isEqualTo "O_Truck_03_device_F") then {
		_Btn2 ctrlSetText localize "STR_vInAct_DeviceMine";
		_Btn2 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_deviceMine";
		_Btn2 ctrlShow true;
		if(!isNil {(_curTarget getVariable "mining")} OR !local _curTarget && {_curTarget in life_vehicles}) then {
			_Btn2 ctrlEnable false;
		} else {
			_Btn2 ctrlEnable true;
		};
	};

	if(typeOf (_curTarget) in ["C_Van_01_fuel_F","I_Truck_02_fuel_F","B_Truck_01_fuel_F"] && _curTarget in life_vehicles) then {
		if(!isNil {_curTarget getVariable "fuelTankWork"}) then {
			_Btn2 ctrlSetText localize "STR_FuelTank_Stop";
			_Btn2 buttonSetAction "life_vInact_curTarget setVariable [""fuelTankWork"",nil,true];closeDialog 0;";
			_Btn2 ctrlShow true;
		} else {
			if(count (nearestObjects [_curTarget, ["Land_FuelStation_Feed_F","Land_fs_feed_F"], 15]) > 0) then {
				_Btn2 ctrlSetText localize "STR_FuelTank_Supply";
				_Btn2 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_fuelSupply";
				_Btn2 ctrlShow true;
			}else{
				{
					if(player distance (getMarkerPos _x) < 20) exitWith {
						_Btn2 ctrlSetText localize "STR_FuelTank_Store";
						_Btn2 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_fuelStore";
						_Btn2 ctrlShow true;
					};
				} foreach ["fuel_storage_1","fuel_storage_2"];
			};
		};
	};
	
	_Btn3 ctrlSetText localize "STR_vInAct_PullOut";
	_Btn3 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_pulloutAction;";
	if(license_civ_rebel || license_civ_chasseur)then{_Btn3 ctrlShow true;};
	if(count crew _curTarget isEqualTo 0) then {_Btn3 ctrlEnable false;};
	if(locked _curTarget != 0) then {_Btn3 ctrlEnable false;};
	if(!license_civ_rebel && !license_civ_chasseur)then{_Btn3 ctrlShow false;};
};
	
if(playerSide isEqualTo independent) then {
	_Btn2 ctrlSetText localize "STR_vInAct_Impound";
	_Btn2 buttonSetAction "closeDialog 0;[life_vInact_curTarget] spawn life_fnc_impoundAction;";
	
	if((FETCH_CONST(life_medicLevel)) isEqualTo 2)then
	{
		_Btn2 ctrlShow true;
	}else
	{
		_Btn2 ctrlShow false;
	};
};

if(_curTarget isKindOf "Ship") then {
	_Btn6 ctrlSetText localize "STR_vInAct_PushBoat";
	_Btn6 buttonSetAction "[] spawn life_fnc_pushObject; closeDialog 0;";
	_Btn6 ctrlShow true;
	if(_curTarget isKindOf "Ship" && {local _curTarget} && {count crew _curTarget isEqualTo 0}) then { _Btn6 ctrlEnable true;} else {_Btn6 ctrlEnable false};
}else
{
	_Btn6 ctrlSetText localize "STR_vInAct_Unflip";
	_Btn6 buttonSetAction "closeDialog 0;[life_vInact_curTarget] spawn life_fnc_vehFlip;";
	_Btn6 ctrlShow true;
	if(count crew _curTarget isEqualTo 0 && {canMove _curTarget}) then { _Btn6 ctrlEnable false;} else {_Btn6 ctrlEnable true;};
};

if((typeOf (_curTarget) in _dlcVehicles) && (!(288520 in getDLCs 1) || !(395180 in getDLCs 1) || !(304380 in getDLCs 1))) then {
	if(_curTarget isKindOf "Air") then {
		_Btn7 ctrlSetText localize "STR_vInAct_GetInHeli";
	} else {
		_Btn7 ctrlSetText localize "STR_vInAct_GetInVehicle";
	};
	_Btn7 ctrlShow true;
	_Btn7 buttonSetAction "player moveInDriver life_vInact_curTarget; closeDialog 0;";
	if(count crew _curTarget isEqualTo 0 && {canMove _curTarget} && {locked _curTarget isEqualTo 0}) then {_Btn7 ctrlEnable true;} else {_Btn7 ctrlEnable false};
};

_Btn8 ctrlSetText localize "STR_vInAct_Insure";
_Btn8 buttonSetAction "closeDialog 0;[] call life_fnc_vehicleInsureMenu;";
_Btn8 ctrlShow true;
if(!(((_curTarget getVariable ["dbInfo",[]]) select 2) isEqualTo 4) && {_curTarget in life_vehicles}) then {
	_Btn8 ctrlEnable true;
} else {
	_Btn8 ctrlEnable false;
};
if(count (_curTarget getVariable ["dbInfo",[]]) isEqualTo 0)then
{
	_Btn8 ctrlEnable false;
};
if(FETCH_CONST(life_adminlevel) > 0)then {
	//Set Search Button
	_dbInfo = _curTarget getVariable ["dbInfo",[]];
	_Btn9 ctrlSetText "Delete Vehi";
	_Btn9 buttonSetAction "closeDialog 0;deleteVehicle life_vInact_curTarget;[player,_dbInfo,false] remoteExecCall [""TON_fnc_chopShopSell"",RSERV];";
	_Btn9 ctrlShow true;
};