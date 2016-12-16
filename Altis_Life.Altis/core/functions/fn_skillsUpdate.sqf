/*
	fn_skillsUpdate.sqf

*/

private["_type","_nbr","_skillLvl"];

params [
	["_type","",[""]],
	["_nbr",0,[0]]
];

if((_type isEqualTo "gather") && (life_skillGather >= 5))exitWith {};
if((_type isEqualTo "process") && (life_skillProcess >= 5))exitWith {};

switch(_type)do
{
	case "gather": {
		life_skillGatherCount = life_skillGatherCount + _nbr;
		_skillLvl = switch (true) do
		{
			case (life_skillGatherCount < 200):{0};
			case ((life_skillGatherCount >= 200) && (life_skillGatherCount < 1000)):{1};
			case ((life_skillGatherCount >= 1000) && (life_skillGatherCount < 2000)):{2};
			case ((life_skillGatherCount >= 2000) && (life_skillGatherCount < 4000)):{3};
			case ((life_skillGatherCount >= 4000) && (life_skillGatherCount < 8000)):{4};
			case (life_skillGatherCount >= 8000):{5};
		};
		if(_skillLvl != life_skillGather)then
		{
			life_skillGather = _skillLvl;
			[format["Vous avez ameliorer votre competences Recolte au niveau %1", life_skillGather]] call life_fnc_showNotification;
		};
		[10] call SOCK_fnc_updatePartial;
	};
	case "process": {
		life_skillProcessCount = life_skillProcessCount + _nbr;
		_skillLvl = switch (true) do
		{
			case (life_skillProcessCount < 100):{0};
			case ((life_skillProcessCount >= 100) && (life_skillProcessCount < 500)):{1};
			case ((life_skillProcessCount >= 500) && (life_skillProcessCount < 1000)):{2};
			case ((life_skillProcessCount >= 1000) && (life_skillProcessCount < 3000)):{3};
			case ((life_skillProcessCount >= 3000) && (life_skillProcessCount < 8000)):{4};
			case (life_skillProcessCount >= 8000):{5};
		};
		if(_skillLvl != life_skillProcess)then
		{
			life_skillProcess = _skillLvl;
			[format["Vous avez ameliorer votre competences Traitement au niveau %1", life_skillProcess]] call life_fnc_showNotification;
		};
		[11] call SOCK_fnc_updatePartial;
	};
	case "repair": {
		life_skillRepairCount = life_skillRepairCount + _nbr;
		_skillLvl = switch (true) do
		{
			case (life_skillRepairCount < 15):{0};
			case ((life_skillRepairCount >= 15) && (life_skillRepairCount < 50)):{1};
			case ((life_skillRepairCount >= 50) && (life_skillRepairCount < 100)):{2};
			case ((life_skillRepairCount >= 100) && (life_skillRepairCount < 200)):{3};
			case ((life_skillRepairCount >= 200) && (life_skillRepairCount < 300)):{4};
			case (life_skillRepairCount >= 300):{5};
		};
		if(_skillLvl != life_skillRepair)then
		{
			life_skillRepair = _skillLvl;
			[format["Vous avez ameliorer votre competences Reparation au niveau %1", life_skillRepair]] call life_fnc_showNotification;
		};
		[12] call SOCK_fnc_updatePartial;
	};
	case "lock": {
		life_skillLockCount = life_skillLockCount + _nbr;
		_skillLvl = switch (true) do
		{
			case (life_skillLockCount < 15):{0};
			case ((life_skillLockCount >= 15) && (life_skillLockCount < 50)):{1};
			case ((life_skillLockCount >= 50) && (life_skillLockCount < 100)):{2};
			case ((life_skillLockCount >= 100) && (life_skillLockCount < 200)):{3};
			case ((life_skillLockCount >= 200) && (life_skillLockCount < 300)):{4};
			case (life_skillLockCount >= 300):{5};
		};
		if(_skillLvl != life_skillLock)then
		{
			life_skillLock = _skillLvl;
			[format["Vous avez ameliorer votre competences Crochetage au niveau %1", life_skillLock]] call life_fnc_showNotification;
		};
		[13] call SOCK_fnc_updatePartial;
	};
};