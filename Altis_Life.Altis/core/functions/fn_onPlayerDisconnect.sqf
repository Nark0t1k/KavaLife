/*
	File: fn_onPlayerDisconnect.sqf
	Author: Vampire
	(onPlayerDisconnected example by [KH]Jman on BIStudio Forums)
	
	Description:
	Deletes Weapon Holders within 5m of the disconnecting player.
*/
_id = _this select 0; 
_pname = _this select 1; 
_puid  = _this select 2;

cleanNearItems = {	
	if (_pname != "__SERVER__") then {
		
		_player = objNull;
		{
			if (getPlayerUID _x isEqualTo _puid) exitWith
			{
				_player = _x;
			};
		} forEach allPlayers; 
		
		if (!(isNull _player)) then {
			// Player body found, now we can run our code
		
			_player removeWeapon (primaryWeapon _player);
			_player removeWeapon (handGunWeapon _player);

			{
				deleteVehicle _x
			} forEach nearestObjects [_player, ["GroundWeaponHolder"], 5];
		};
	};
};

call cleanNearItems;