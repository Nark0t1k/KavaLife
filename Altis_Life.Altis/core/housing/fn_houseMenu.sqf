#include "..\..\script_macros.hpp"
/*
	File: fn_houseMenu.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Building interaction menu
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
#define Title 37401

private["_display","_curTarget","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8","_Btn0","_myGangName","_gangName","_exit","_blackList"];
disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {}; //Bad target
_houseCfg = [(typeOf _curTarget)] call life_fnc_houseConfig;
if(EQUAL(count _houseCfg,0) && playerSide isEqualTo civilian) exitWith {};


if(((getPlayerUID player) != "76561197975687104") && (player distance [14570,17594,0] < 28)) exitWith {hint parseText "Achat interdit ici";};
if(((getPlayerUID player) isEqualTo "76561197975687104") && (player distance [14570,17594,0] < 28)) then {hint parseText "BONJOUR VICTOR BIENVENU CHEZ TOI";};

if(!dialog) then {
	createDialog "pInteraction_Menu";
};

_Btn0 = CONTROL(37400,Btn0);
_Btn1 = CONTROL(37400,Btn1);
_Btn2 = CONTROL(37400,Btn2);
_Btn3 = CONTROL(37400,Btn3);
_Btn4 = CONTROL(37400,Btn4);
_Btn5 = CONTROL(37400,Btn5);
_Btn6 = CONTROL(37400,Btn6);
_Btn7 = CONTROL(37400,Btn7);
_Btn8 = CONTROL(37400,Btn8);
{_x ctrlShow false;} foreach [_Btn0,_Btn1,_Btn2,_Btn3,_Btn4,_Btn5,_Btn6,_Btn7,_Btn8];

life_pInact_curTarget = _curTarget;
if(_curTarget isKindOf "House_F" && playerSide isEqualTo west) exitWith {
	if((nearestObject [[16019.5,16952.9,0],"Land_Dome_Big_F"]) isEqualTo _curTarget OR (nearestObject [[16019.5,16952.9,0],"Land_Research_house_V1_F"]) isEqualTo _curTarget) then {

		_Btn1 ctrlSetText localize "STR_pInAct_Repair";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_repairDoor; closeDialog 0;";
		_Btn1 ctrlShow true;

		_Btn2 ctrlSetText localize "STR_pInAct_CloseOpen";
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_doorAnimate; closeDialog 0;";
		_Btn2 ctrlShow true;

	} else {
		if(!isNil {_curTarget getVariable "house_owner"}) then {
			_Btn1 ctrlSetText localize "STR_House_Raid_Owner";
			_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_copHouseOwner;";
			_Btn1 ctrlShow true;

			_Btn2 ctrlSetText localize "STR_pInAct_BreakDown";
			_Btn2 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_copBreakDoor; closeDialog 0;";
			_Btn2 ctrlShow true;

			_Btn3 ctrlSetText localize "STR_pInAct_SearchHouse";
			_Btn3 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_raidHouse; closeDialog 0;";
			_Btn3 ctrlShow true;

			if(player distance _curTarget > 3.6) then {
				_Btn3 ctrlEnable false;
			};

			_Btn4 ctrlSetText localize "STR_pInAct_LockHouse";
			_Btn4 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_lockupHouse; closeDialog 0;";
			_Btn4 ctrlShow true;
		} else {
			closeDialog 0;
		};
	};
};

if((playerSide isEqualTo civilian) && (typeOf _curTarget isEqualTo "Land_i_Shed_Ind_F"))exitWith
{
	if(_curTarget in life_vehicles) exitWith {
		_Btn1 ctrlSetText localize "STR_ATM_QGTitle";
		_Btn1 buttonSetAction "closeDialog 0;[] spawn life_fnc_atmMenu;";
		_Btn1 ctrlShow true;
		
		_Btn2 ctrlSetText localize "STR_Gang_UpgradeSlots";
		_Btn2 buttonSetAction "closeDialog 0;[] spawn life_fnc_gangUpgrade;";
		_Btn2 ctrlShow true;
		
		_Btn3 ctrlSetText localize "STR_Gang_ViewWars";
		_Btn3 buttonSetAction "closeDialog 0;[] spawn life_fnc_viewWar;";
		_Btn3 ctrlShow true;
	};
	if(isNil {_curTarget getVariable "gang_name"}) then {
		if(!isNull life_gangQG)then
		{
			closeDialog 0;
			hint "Votre gang dispose deja d un QG";
		}else
		{
			_exit = false;
			_blackList = ["gang_area_1","gang_area_2","gang_area_3","mark_michelin_1","chop_shop_1","chop_shop_2","chop_shop_3","chop_shop_4","mark_ksd_1","mark_usineoil_1","mark_usineoil_2","Mark_Safe_Zone_1","Mark_Safe_Zone_2","Mark_Safe_Zone_3"];
			{
				if(player distance (getMarkerPos _x) < 250)exitWith {_exit = true;};
			}foreach _blackList;
			if(_exit)exitWith {hint "Vous ne pouvez pas creer de QG ici";};
			
			_Btn1 ctrlSetText localize "STR_pInAct_CreateQGGang";
			_Btn1 buttonSetAction "closeDialog 0;createDialog ""Life_Create_Gang_Diag"";";
			_Btn1 ctrlShow true;
		};
	}else
	{
		if(isNull life_gangQG)exitWith {hint "Vous devez faire partie d un gang pour interagir avec des gangs ennemis.";};
		_myGangName = life_gangQG getVariable ["gang_name",""];
		_exit = false;
		{
			_gangName = _x select 0;
			if(_gangName isEqualTo _myGangName)exitWith {
				_exit = true;
				_Btn1 ctrlSetText localize "STR_pInAct_StopWar";
				_Btn1 buttonSetAction "closeDialog 0;[life_pInact_curTarget] spawn life_fnc_stopWar";
				_Btn1 ctrlShow true;
			};
		}forEach (life_pInact_curTarget getVariable ["gang_war",[]]);	
		if(_exit)exitWith{};
		_Btn1 ctrlSetText localize "STR_pInAct_CreateWar";
		_Btn1 buttonSetAction "closeDialog 0;createDialog ""Life_start_war"";";
		_Btn1 ctrlShow true;
	};
};

if(!(_curTarget in life_vehicles) OR isNil {_curTarget getVariable "house_owner"}) then {
	if(_curTarget in life_vehicles) then {SUB(life_vehicles,[_curTarget]);};
	_Btn1 ctrlSetText localize "STR_pInAct_BuyHouse";
	_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_buyHouse;";
	_Btn1 ctrlShow true;

	if(!isNil {_curTarget getVariable "house_owner"}) then {
		_Btn1 ctrlEnable false;
	};
} else {
	if((typeOf _curTarget) in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]) then {
		_Btn1 ctrlSetText localize "STR_pInAct_SellGarage";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_sellHouse; closeDialog 0;";
		_Btn1 ctrlShow true;

		if(SEL(_curTarget getVariable "house_owner",0) != getPlayerUID player) then {
			_Btn1 ctrlEnable false;
		};

		_Btn2 ctrlSetText localize "STR_pInAct_AccessGarage";
		_Btn2 buttonSetAction "[life_pInact_curTarget,""Car""] spawn life_fnc_vehicleGarage; closeDialog 0;";
		_Btn2 ctrlShow true;

		_Btn3 ctrlSetText localize "STR_pInAct_StoreVeh";
		_Btn3 buttonSetAction "[life_pInact_curTarget,player] spawn life_fnc_storeVehicle; closeDialog 0;";
		_Btn3 ctrlShow true;
	} else {
		_Btn1 ctrlSetText localize "STR_pInAct_SellHouse";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_sellHouse; closeDialog 0;";
		_Btn1 ctrlShow true;

		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn1 ctrlEnable false;
		};

		if(_curTarget getVariable ["locked",false]) then {
			_Btn2 ctrlSetText localize "STR_pInAct_UnlockStorage";
		} else {
			_Btn2 ctrlSetText localize "STR_pInAct_LockStorage";
		};
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_lockHouse; closeDialog 0;";
		_Btn2 ctrlShow true;

		if(isNull (_curTarget getVariable ["lightSource",ObjNull])) then {
			_Btn3 ctrlSetText localize "STR_pInAct_LightsOn";
		} else {
			_Btn3 ctrlSetText localize "STR_pInAct_LightsOff";
		};
		_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_lightHouseAction; closeDialog 0;";
		_Btn3 ctrlShow true;
		
	};
	_Btn4 ctrlSetText "Voir Location";
	_Btn4 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_showrentHouse; closeDialog 0;";
	_Btn4 ctrlShow true;

	if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
		_Btn4 ctrlEnable false;
	};
	_Btn5 ctrlSetText "Payer Location";
	_Btn5 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_rentHouse; closeDialog 0;";
	_Btn5 ctrlShow true;

	if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
		_Btn5 ctrlEnable false;
	};
	_Btn6 ctrlSetText "Alarme";
	_Btn6 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_buyAlarm; closeDialog 0;";
	_Btn6 ctrlShow true;
};