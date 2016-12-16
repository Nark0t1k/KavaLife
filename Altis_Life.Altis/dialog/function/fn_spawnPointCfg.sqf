/*
	File: fn_spawnPointCfg.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration for available spawn points depending on the units side.
	
	Return:
	[Spawn Marker,Spawn Name,Image Path]
*/
private["_side","_return"];
_side = [_this,0,civilian,[civilian]] call BIS_fnc_param;

//Spawn Marker, Spawn Name, PathToImage
switch (_side) do
{
	case west:
	{
		_return = [
			["cop_spawn_1","Kavala HQ","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
			["cop_spawn_2","Pyrgos HQ","\a3\ui_f\data\map\MapControl\fuelstation_ca.paa"],
			["cop_spawn_3","Athira HQ","\a3\ui_f\data\map\GroupIcons\badge_rotate_0_gs.paa"],
			["cop_spawn_4","Air HQ","\a3\ui_f\data\map\Markers\NATO\b_air.paa"],
			["cop_spawn_5","HW Patrol","\a3\ui_f\data\map\GroupIcons\badge_rotate_0_gs.paa"]
		];
	};
	
	case civilian:
	{
		
		if(license_civ_rebel) then {
			_return = [
				["civ_spawn_2","Pyrgos","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["civ_spawn_3","Athira","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["civ_spawn_4","Sofia","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["rebel_spawn_1","Camp Rebel Abdera","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["rebel_spawn_2","Camp Rebel Ile","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["rebel_spawn_3","Camp Rebel Sofia","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
			];
		}else
		{
			_return = [
				["civ_spawn_1","Kavala","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["civ_spawn_2","Pyrgos","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["civ_spawn_3","Athira","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["civ_spawn_4","Sofia","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
				["civ_spawn_5","Agios","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
			];
		};
		
		if(life_is_alive) then {
			_marker = createMarkerLocal [format["LastPos_%1",getPlayerUID player], life_civ_position];
			_return pushBack [format["LastPos_%1",getPlayerUID player],"Last Pos","\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
		};
		
		if(!(count life_gangData isEqualTo 0)) then
		{
			if(!(isNull life_gangQG)) then
			{
				_return pushBack ["gangQG","QG de Gang","\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
			};
			if((gang_obj_1 getVariable ["gangOwnerName","NOP"]) isEqualTo (player getVariable ["gang_name",""]))then
			{
				_return pushBack ["player_gang_spawn_1","Zone de Gang 1","\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
			};
			if((gang_obj_2 getVariable ["gangOwnerName","NOP"]) isEqualTo (player getVariable ["gang_name",""]))then
			{
				_return pushBack ["player_gang_spawn_2","Zone de Gang 2","\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
			};
			if((gang_obj_3 getVariable ["gangOwnerName","NOP"]) isEqualTo (player getVariable ["gang_name",""]))then
			{
				_return pushBack ["player_gang_spawn_3","Zone de Gang 3","\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
			};
		};
		
		if(count life_houses > 0) then {
			{
				_pos = call compile format["%1",_x select 0];
				_house = nearestBuilding _pos;
				_houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
				
				_return pushBack [format["house_%1",_house getVariable "uid"],_houseName,"\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
			} foreach life_houses;
		};
	};
	
	case independent: {
	
		switch(player getVariable ["rankIndep", 0]) do
		{
			case 0: {
				_return = [
					["medic_spawn_1","Kavala Hospital","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
					["medic_spawn_2","Athira Regional","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
					["medic_spawn_3","Pygros Hospital","\a3\ui_f\data\map\MapControl\hospital_ca.paa"]
				];
			};
			case 1: {
				_return = [
					["medic_spawn_1","Kavala Hospital","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
					["medic_spawn_2","Athira Regional","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
					["medic_spawn_3","Pygros Hospital","\a3\ui_f\data\map\MapControl\hospital_ca.paa"]
				];
			};
			case 2: {
				_return = [
					["civ_spawn_1","Kavala","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
					["civ_spawn_2","Pyrgos","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
					["civ_spawn_3","Athira","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
					["civ_spawn_4","Sofia","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
					["civ_spawn_5","Agios","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
					["dep_spawn_1","CDD","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
					["dep_spawn_2","QG CDD","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
				];
			};
			case 3: {
				_return = [
						["civ_spawn_1","Kavala","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_2","Pyrgos","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_3","Athira","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_4","Sofia","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_5","Agios","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["merce_spawn_1","QG Mercenaire","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
					];
			};
			case 4: {
				_return = [
						["civ_spawn_1","Kavala","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_2","Pyrgos","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_3","Athira","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_4","Sofia","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
						["civ_spawn_5","Agios","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
					];
			};
		};
	};
};

_return;