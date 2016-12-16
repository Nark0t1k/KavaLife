/*
	fn_updateMyGroup.sqf
	
*/

if(isNull life_my_group) then
{
	if(isNil {player getVariable "gang_name"})then
	{
		// Alone
		[player] joinSilent (createGroup civilian);
	}else
	{
		// Gang
		_exit = false;
		_nbrGang = life_gangQG getVariable ["gangNbr",0];
		{
			if((_x getVariable ["gangNbr",0]) isEqualTo _nbrGang)exitWith
			{
				[player] joinSilent _x;
				if ((life_gangQG getVariable ["gang_owner",0]) isEqualTo getPlayerUID player) then {
						_x selectLeader player;
						player setRank "COLONEL";
				};
				_exit=true;
			};
		}foreach allGroups;
		if(!_exit)then
		{
			[player] joinSilent (createGroup civilian);
			(group player) setVariable ["gangNbr",_nbrGang,true];
		};
	};
}else
{
	// Group
	{
		if((_x getVariable ["groupNbr",0]) isEqualTo life_my_groupNbr)exitWith
		{
			[player] joinSilent _x;
		};
	}foreach allGroups;
};