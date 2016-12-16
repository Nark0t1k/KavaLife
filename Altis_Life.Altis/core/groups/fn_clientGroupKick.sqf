private["_unit","_group"];
_unit = _this select 0;
_group = _this select 1;
if(isNil "_unit" OR isNil "_group") exitWith {};
if(player isEqualTo _unit && (group player) isEqualTo _group) then
{
	life_my_group = ObjNull;
	[] call life_fnc_updateMyGroup;
	hint "Tu as ete kick du groupe.";
	
};
