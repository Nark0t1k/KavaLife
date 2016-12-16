#include "..\..\script_macros.hpp"
/*
	File: fn_filterMenu.sqf
	Author: Nark0t1k
*/
if(dialog) exitWith{};
if(visibleMap) then {
	createDialog "FilterMenu";
	if(false in life_filter) then
	{
		CONTROL(9200,9250) cbSetChecked false;
	}else
	{
		CONTROL(9200,9250) cbSetChecked true;
	};
	CONTROL(9200,9201) cbSetChecked SEL(life_filter,0);
	CONTROL(9200,9202) cbSetChecked SEL(life_filter,1);
	CONTROL(9200,9203) cbSetChecked SEL(life_filter,2);	
	CONTROL(9200,9204) cbSetChecked SEL(life_filter,3);	
	CONTROL(9200,9205) cbSetChecked SEL(life_filter,4);	
	CONTROL(9200,9206) cbSetChecked SEL(life_filter,5);	
	CONTROL(9200,9207) cbSetChecked SEL(life_filter,6);	
	CONTROL(9200,9208) cbSetChecked SEL(life_filter,7);	
	CONTROL(9200,9209) cbSetChecked SEL(life_filter,8);	
	CONTROL(9200,9210) cbSetChecked SEL(life_filter,9);	
	
	while {true} do
	{
		sleep 0.5;
		if(!visibleMap) exitWith
		{
			closeDialog 9200;	
		};
	};
};