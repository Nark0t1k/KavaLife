#include "..\..\script_macros.hpp"
/*
*    File: fn_keyHandler.sqf
*    Author: Bryan "Tonic" Boardwine
*
*    Description:
*    Main key handler for event 'keyDown'
*/
private ["_handled","_shift","_alt","_code","_ctrl","_alt","_ctrlKey","_veh","_locked","_interactionKey","_mapKey","_interruptionKeys"];
_ctrl = _this select 0;
_code = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;
_speed = speed cursorObject;
_handled = false;

if (_code in ((actionKeys "Diary") + (actionKeys "NetworkPlayers") + (actionKeys "forceCommandingMode") + (actionKeys "menuBack"))) then
{
	_handled = true;
};
_interactionKey = if((EQUAL(count (actionKeys "User10"),0))) then {219} else {(actionKeys "User10") select 0};
_mapKey = SEL(actionKeys "ShowMap",0);

_interruptionKeys = [17,30,31,32]; //A,S,W,D

//Menotte Surrender Exit
if ((_code in (actionKeys "GetOver") || _code in (actionKeys "salute") || _code in (actionKeys "SitDown") || _code in (actionKeys "Throw") || _code in (actionKeys "GetIn") || _code in (actionKeys "GetOut") || _code in (actionKeys "Fire") || _code in (actionKeys "ReloadMagazine") || _code in [16,18]) && ((player getVariable ["restrained",false]) || (player getVariable ["restrainedciv",false]) || (player getVariable ["playerSurrender",false]) || life_isknocked || life_istazed)) exitWith {true;};

if(life_action_inUse) exitWith {
	if(!life_interrupted && _code in _interruptionKeys) then {life_interrupted = true;};
	_handled;
};

if (_code in [2,3,4,5,6,7,8,9,10,11,41]) exitWith
{
	[_code,_ctrlKey] spawn 
	{
		private["_code","_handle","_ctrlKey"];
		_code = _this select 0;
		_ctrlKey = _this select 1;
		_handle = [_code,_ctrlKey] spawn life_fnc_skillKeyHandler;
		waitUntil {scriptDone _handle};
		life_action_inUse = false;
	};
	true;
};


//Hotfix for Interaction key not being able to be bound on some operation systems.
if (!(count (actionKeys "User10") isEqualTo 0) && {(inputAction "User10" > 0)}) exitWith {
    //Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)
    if (!life_action_inUse) then {
        [] spawn {
            private "_handle";
            _handle = [] spawn life_fnc_actionKeyHandler;
            waitUntil {scriptDone _handle};
            life_action_inUse = false;
        };
    };
    true;
};

if (life_container_active) then {
    switch (_code) do {
        //space key
        case 57: {
            [] spawn life_fnc_placestorage;
        };
    };
    true;
};

if (life_barrier_active) then {
	switch (_code) do {
		//space key
		case 57: {
			[] spawn life_fnc_placeablesPlaceComplete;
		};
		case 1: {
			[true] call life_fnc_placeableCancel;
		};
	};
	false;
};

switch (_code) do {
    //Space key for Jumping
    case 57: {
        if (isNil "jumpActionTime") then {jumpActionTime = 0;};
        if (_shift && {!(animationState player isEqualTo "AovrPercMrunSrasWrflDf")} && {isTouchingGround player} && {stance player isEqualTo "STAND"} && {speed player > 2} && {!life_is_arrested} && {((velocity player) select 2) < 2.5} && {time - jumpActionTime > 1.5}) then {
            jumpActionTime = time; //Update the time.
            [player] remoteExec ["life_fnc_jumpFnc",RANY]; //Global execution
            _handled = true;
        };
    };

    //Surrender (Shift + B)
    case 48: {
        if (_shift) then {
            if (player getVariable ["playerSurrender",false]) then {
                player setVariable ["playerSurrender",false];
            } else {
                [] spawn life_fnc_surrender;
            };
            _handled = true;
        };
    };
	
	//Map Key
	case _mapKey: {
		switch (playerSide) do {
			case west: {if(!visibleMap) then {[] spawn life_fnc_copMarkers;}};
			case independent: {if(!visibleMap) then {[] spawn life_fnc_medicMarkers;}};
			case civilian: {if(!visibleMap) then {[] spawn life_fnc_civMarkers;}};
		};
		[] spawn life_fnc_personalMarkers;
	};

    // Holster / recall weapon. (Shift + H)
    case 35: {
        if (_shift && !_ctrlKey && !(currentWeapon player isEqualTo "")) then {
            life_curWep_h = currentWeapon player;
            player action ["SwitchWeapon", player, player, 100];
            player switchCamera cameraView;
			if(vehicle player != player)then{hint "Arme Range";};
        };

        if (!_shift && _ctrlKey && !isNil "life_curWep_h" && {!(life_curWep_h isEqualTo "")}) then {
            if (life_curWep_h in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
                player selectWeapon life_curWep_h;
				life_curWep_h = nil;
				if(vehicle player != player)then{hint "Arme Sortie";};
            };
        };
    };
	
	case 60:
	{
		if(isNil "life_viewDistance") then
		{
			life_viewDistance = 0;
		};
		switch (life_viewDistance) do
		{
			case 0: { life_viewDistance = 250; systemChat format["Distance Affichage : %1.", life_viewDistance];};
			case 250: { life_viewDistance = 750; systemChat format["Distance Affichage : %1.", life_viewDistance];};
			case 750: { life_viewDistance = 1250; systemChat format["Distance Affichage : %1.", life_viewDistance];};
			case 1250: { life_viewDistance = 0; systemChat "Distance Affichage Default"; };
            default { life_viewDistance = 0; systemChat "Distance Affichage Default"; };
		};
		[] call life_fnc_updateViewDistance;
		_handled = true;
	};
	
	case 66:
	{
		if((call life_adminlevel) < 1) exitWith {true};
		[format['[ADMIN] %1(%2) -ACTIVE/DESACTIVE SPY NAME',name player, getPlayerUID player],"ADMIN"] remoteExecCall ["A3Log",2];
		if(isNil "life_adminSpyName") then
		{
			life_adminSpyName = false;
		};
		life_adminSpyName = !life_adminSpyName;
	};
	

	//Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)
	case _interactionKey: {
		if(!life_action_inUse) then {
			[] spawn  {
				private "_handle";
				_handle = [] spawn life_fnc_actionKeyHandler;
				waitUntil {scriptDone _handle};
				life_action_inUse = false;
			};
		};
	};

	//Restraining (Shift + R)
	case 19: {
		if(_shift) then {_handled = true;};
		if(playerSide isEqualTo west) then
		{
			if(_shift && {!isNull cursorTarget} && {cursorTarget isKindOf "Man"} && {(isPlayer cursorTarget)} && {(side cursorTarget in [civilian,independent])} && {alive cursorTarget} && {cursorTarget distance player < 3.5} && {!(cursorTarget getVariable "Escorting")} && {!(cursorTarget getVariable "restrained")} && {!(cursorTarget getVariable "restrainedciv")} && {speed cursorTarget < 1}) then {
				[] call life_fnc_restrainAction;
			};
		}else
		{
			if(_shift && playerSide isEqualTo independent && ((player getVariable ["rankIndep",0]) isEqualTo 3) && {!isNull cursorTarget} && {cursorTarget isKindOf "Man"} && {(isPlayer cursorTarget)} && {alive cursorTarget} && {cursorTarget distance player < 3.5} && {!(cursorTarget getVariable "Escorting")} && {!(cursorTarget getVariable "restrained")} && {!(cursorTarget getVariable "restrainedciv")} && {speed cursorTarget < 1}) then {
				[] call life_fnc_restrainActionCiv;
			};
			if(_shift && license_civ_rebel && {!isNull cursorTarget} && {cursorTarget isKindOf "Man"} && {(isPlayer cursorTarget)} && {alive cursorTarget} && {cursorTarget distance player < 3.5} && {!(cursorTarget getVariable "Escorting")} && {!(cursorTarget getVariable "restrained")} && {!(cursorTarget getVariable "restrainedciv")} && {speed cursorTarget < 1}) then {
				[] call life_fnc_restrainActionCiv;
			};
			if(_shift && license_civ_chasseur && {!isNull cursorTarget} && {cursorTarget isKindOf "Man"} && {(!(getPlayerUID cursorTarget in life_friendList))} && {(isPlayer cursorTarget)} && {alive cursorTarget} && {cursorTarget distance player < 3.5} && {!(cursorTarget getVariable "Escorting")} && {!(cursorTarget getVariable "restrained")} && {(cursorTarget getVariable "ActiveWanted")} && {!(cursorTarget getVariable "restrainedciv")} && {speed cursorTarget < 1}) then {
				[] call life_fnc_restrainActionCiv;
			};
		};
	};

	//Knock out, this is experimental and yeah... (Shift + G)
	case 34: {
		if(_shift) then {_handled = true;};
		if(_shift && playerSide in [civilian,independent] && !isNull cursorTarget && cursorTarget isKindOf "Man" && isPlayer cursorTarget && alive cursorTarget && cursorTarget distance player < 4 && speed cursorTarget < 1) then {
			if((animationState cursorTarget) != "Incapacitated" && (currentWeapon player isEqualTo primaryWeapon player OR currentWeapon player isEqualTo handgunWeapon player) && currentWeapon player != "" && !life_action_inUse && !(player getVariable ["restrained",false]) && !(player getVariable ["restrainedciv",false]) && !life_istazed && !life_isknocked) then {
				[cursorTarget] spawn life_fnc_knockoutAction;
			};
		};
	};

	//T Key (Trunk)
	case 20: {
		if(!_alt && !_ctrlKey && !dialog && {!life_action_inUse}) then {
			if(life_is_processing)exitWith {hint "Vous ne pouvez pas faire cela pendant un traitement";};
			if(vehicle player != player && alive vehicle player) then {
				if((vehicle player) in life_vehicles) then {
					[vehicle player] spawn life_fnc_openInventory;
				};
			} else {
				private ["_list","_house"];
				_containers = [getPosATL player, ["Box_IND_Grenades_F","B_supplyCrate_F","Land_Sink_F","CargoNet_01_barrels_F","Land_OfficeCabinet_01_F","Fridge_01_closed_F"], 2.5] call life_fnc_nearestObjects;
				if (count _containers > 0) then {
					_house = nearestBuilding (getPosATL player);
					if(!(_house in life_vehicles) && (_house getVariable ["locked",true])) exitWith {
						hint localize "STR_House_ContainerDeny";
						true;
					};
					_container = _containers select 0;
					[_container] spawn life_fnc_openInventory;
				} else {
					_list = ["landVehicle","Air","Ship"];
					if(KINDOF_ARRAY(cursorTarget,_list) && {player distance cursorTarget < 7} && {vehicle player isEqualTo player} && {alive cursorTarget} && {!life_action_inUse}) then {
						if((cursorTarget in life_vehicles) || ((locked cursorTarget) isEqualTo 0)) then {
							[cursorTarget] spawn life_fnc_openInventory;
						};
					};
					if((cursorTarget in [copStorageBox1,copStorageBox2,copTempCont1,copTempCont2]) && {player distance cursorTarget < 7} && {vehicle player isEqualTo player} && {!life_action_inUse}) then {
						if(playerSide isEqualTo west) then
						{
							[cursorTarget] spawn life_fnc_openInventory;
						}else
						{
							hint "Vous ne pouvez pas ouvrir se coffre";
						};
					};
				};
			};
		};
		if(!_alt && _ctrlKey && !_shift &&  !dialog) then
		{
			life_showHealth = !life_showHealth;
			[] call life_fnc_hudHealthSetup;
		};
		if(_alt && !_ctrlKey && !_shift && !dialog) then
		{
			if(vehicle player isEqualTo player) exitWith {};
			life_showVehHealth = !life_showVehHealth;
			[] call life_fnc_hudVehHealthSetup;
		};
	};

	//L Key?
	case 38: {
		if(visibleMap) exitWith {if (isNull (findDisplay 9200)) then {[] spawn life_fnc_filterMenu;}else{closedialog 9200;};};
		//If cop run checks for turning lights on.
		if(_shift && playerSide in [west,independent]) then {
			if(vehicle player != player && (typeOf vehicle player) in ["C_Offroad_01_F","B_MRAP_01_F","C_SUV_01_F","C_Hatchback_01_sport_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","C_Offroad_01_repair_F"]) then {
				if(!isNil {vehicle player getVariable "lights"}) then {
					if(playerSide isEqualTo west) then {
						[vehicle player] call life_fnc_sirenLights;
					} else {
						if((player getVariable ["rankIndep",0]) isEqualTo 3) exitWith {};
						[vehicle player] call life_fnc_medicSirenLights;
					};
					_handled = true;
				};
			};
		};

		if(!_alt && !_ctrlKey) then {
			if(playerSide != west)exitWith {};
			if((currentWeapon player) isEqualTo "Rangefinder")then
			{
				[cursorTarget] call life_fnc_radar;
			};
		};
	};
	
	case 201: {
		if(!_alt && !_ctrlKey) then {
			if(playerSide != west)exitWith {};
			if((currentWeapon player) isEqualTo "Rangefinder")then
			{
				life_radarSpeed = switch (life_radarSpeed) do
				{
					case 30: {50};
					case 50: {70};
					case 70: {90};
					case 90: {120};
					case 120: {30};
				};
				hint format["Reglage Vitesse Radar: %1", life_radarSpeed];
			};
		};
	};

	//Y Player Menu
	case 21: {
		if(!_alt && !_ctrlKey && !dialog && !(player getVariable ["restrained",false]) && !(player getVariable ["restrainedciv",false]) && {!life_action_inUse}) then {
			[] call life_fnc_p_openMenu;
		};
	};
	
	case 47: {
		if(!isNull life_sitting)then {[] execVM "Chair\standup.sqf";};
	};

	//F Key
	case 33: {
		if(playerSide isEqualTo independent && !((FETCH_CONST(life_medicLevel)) in [0,1]))exitWith {};
		if(playerSide in [west,independent] && {vehicle player != player} && {!life_siren_active} && {((driver vehicle player) isEqualTo player)}) then {
			[] spawn {
				life_siren_active = true;
				sleep 4.7;
				life_siren_active = false;
			};

			_veh = vehicle player;
			if(isNil {_veh getVariable "siren"}) then {_veh setVariable ["siren",false,true];};
			if((_veh getVariable "siren")) then {
				titleText [localize "STR_MISC_SirensOFF","PLAIN"];
				_veh setVariable ["siren",false,true];
			} else {
				titleText [localize "STR_MISC_SirensON","PLAIN"];
				_veh setVariable ["siren",true,true];
				if(playerSide isEqualTo west) then {
					[_veh] remoteExec ["life_fnc_copSiren",RCLIENT];
				} else {
					[_veh] remoteExec ["life_fnc_medicSiren",RCLIENT];
				};
			};
		};
	};

	//U Key
	case 22: {
		if(!_alt && !_ctrlKey) then {
			if(vehicle player isEqualTo player) then {
				_veh = cursorTarget;
			} else {
				_veh = vehicle player;
			};

			if(_veh isKindOf "House_F" && {playerSide isEqualTo civilian}) then {
				if(_veh in life_vehicles && player distance _veh < 20) then {
					_door = [_veh] call life_fnc_nearestDoor;
					if(EQUAL(_door,0)) exitWith {hint localize "STR_House_Door_NotNear"};
					_locked = _veh getVariable [format["bis_disabled_Door_%1",_door],0];

					if(EQUAL(_locked,0)) then {
						_veh setVariable [format["bis_disabled_Door_%1",_door],1,true];
						_veh animate [format["door_%1_rot",_door],0];
						systemChat localize "STR_House_Door_Lock";
					} else {
						_veh setVariable [format["bis_disabled_Door_%1",_door],0,true];
						_veh animate [format["door_%1_rot",_door],1];
						systemChat localize "STR_House_Door_Unlock";
					};
				};
			} else {
				_locked = locked _veh;
				if(_veh in life_vehicles && player distance _veh < 20) then {
					if(EQUAL(_locked,2)) then {
						if(local _veh) then {
							_veh lock 0;
							// BI
							_veh animateDoor ["door_back_R",1];
							_veh animateDoor ["door_back_L",1];
							_veh animateDoor ['door_R',1];
							_veh animateDoor ['door_L',1];
							_veh animateDoor ['Door_L_source',1];
							_veh animateDoor ['Door_rear',1];
							_veh animateDoor ['Door_rear_source',1];
							_veh animateDoor ['Door_1_source',1];
							_veh animateDoor ['Door_2_source',1];
							_veh animateDoor ['Door_3_source',1];
							_veh animateDoor ['Door_LM',1];
							_veh animateDoor ['Door_RM',1];
							_veh animateDoor ['Door_LF',1];
							_veh animateDoor ['Door_RF',1];
							_veh animateDoor ['Door_LB',1];
							_veh animateDoor ['Door_RB',1];
							_veh animateDoor ['DoorL_Front_Open',1];
							_veh animateDoor ['DoorR_Front_Open',1];
							_veh animateDoor ['DoorL_Back_Open',1];
							_veh animateDoor ['DoorR_Back_Open ',1];
						} else {
							[_veh,0] remoteExecCall ["life_fnc_lockVehicle",_veh];							
							_veh animateDoor ["door_back_R",1];
							_veh animateDoor ["door_back_L",1];
							_veh animateDoor ['door_R',1];
							_veh animateDoor ['door_L',1];
							_veh animateDoor ['Door_L_source',1];
							_veh animateDoor ['Door_rear',1];
							_veh animateDoor ['Door_rear_source',1];
							_veh animateDoor ['Door_1_source',1];
							_veh animateDoor ['Door_2_source',1];
							_veh animateDoor ['Door_3_source',1];
							_veh animateDoor ['Door_LM',1];
							_veh animateDoor ['Door_RM',1];
							_veh animateDoor ['Door_LF',1];
							_veh animateDoor ['Door_RF',1];
							_veh animateDoor ['Door_LB',1];
							_veh animateDoor ['Door_RB',1];
							_veh animateDoor ['DoorL_Front_Open',1];
							_veh animateDoor ['DoorR_Front_Open',1];
							_veh animateDoor ['DoorL_Back_Open',1];
							_veh animateDoor ['DoorR_Back_Open ',1];
						};
						systemChat localize "STR_MISC_VehUnlock";
						hint composeText [ image "icons\unlock.paa", "  OUVERT" ];
					} else {
						if(local _veh) then {
							_veh lock 2;

							_veh animateDoor ["door_back_R",0];
							_veh animateDoor ["door_back_L",0];
							_veh animateDoor ['door_R',0];
							_veh animateDoor ['door_L',0];
							_veh animateDoor ['Door_L_source',0];
							_veh animateDoor ['Door_rear',0];
							_veh animateDoor ['Door_rear_source',0];
							_veh animateDoor ['Door_1_source',0];
							_veh animateDoor ['Door_2_source',0];
							_veh animateDoor ['Door_3_source',0];
							_veh animateDoor ['Door_LM',0];
							_veh animateDoor ['Door_RM',0];
							_veh animateDoor ['Door_LF',0];
							_veh animateDoor ['Door_RF',0];
							_veh animateDoor ['Door_LB',0];
							_veh animateDoor ['Door_RB',0];
							_veh animateDoor ['DoorL_Front_Open',0];
							_veh animateDoor ['DoorR_Front_Open',0];
							_veh animateDoor ['DoorL_Back_Open',0];
							_veh animateDoor ['DoorR_Back_Open ',0];
						} else {
							[_veh,2] remoteExecCall ["life_fnc_lockVehicle",_veh];

							_veh animateDoor ["door_back_R",0];
							_veh animateDoor ["door_back_L",0];
							_veh animateDoor ['door_R',0];
							_veh animateDoor ['door_L',0];
							_veh animateDoor ['Door_L_source',0];
							_veh animateDoor ['Door_rear',0];
							_veh animateDoor ['Door_rear_source',0];
							_veh animateDoor ['Door_1_source',0];
							_veh animateDoor ['Door_2_source',0];
							_veh animateDoor ['Door_3_source',0];
							_veh animateDoor ['Door_LM',0];
							_veh animateDoor ['Door_RM',0];
							_veh animateDoor ['Door_LF',0];
							_veh animateDoor ['Door_RF',0];
							_veh animateDoor ['Door_LB',0];
							_veh animateDoor ['Door_RB',0];
							_veh animateDoor ['DoorL_Front_Open',0];
							_veh animateDoor ['DoorR_Front_Open',0];
							_veh animateDoor ['DoorL_Back_Open',0];
							_veh animateDoor ['DoorR_Back_Open ',0];
						};
						systemChat localize "STR_MISC_VehLock";
						hint composeText [ image "icons\lock.paa", "  FERMER" ];
					};
				};
			};
		};
	};
	
	// Enter key
	case 28:
	{
		if(!isNull findDisplay 88500)then
		{
			[false] call life_fnc_sendMessage;
			CONTROL(88500,88506) ctrlSetText "";
		};
	};
};

_handled;
