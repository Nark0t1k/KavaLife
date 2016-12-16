#include "..\..\script_macros.hpp"
/*
	fn_amendeLBDialog.sqf
*/


private ["_listContrav", "_typeSel", "_fullListContrav", "_i", "_curConfig", "_title", "_type", "_price", "_multi", "_data"];

disableSerialization;

_listContrav = CONTROL(13000,13002);
_typeSel = lbData[13004,(lbCurSel 13004)];
lbClear _listContrav;


_fullListContrav = missionConfigFile >> "CfgAmende" >> "Amende";
for[{_i = 0},{_i < count(_fullListContrav)},{_i = _i + 1}] do {

	_curConfig = (_fullListContrav select _i);
	_id = getNumber(_curConfig >> "id");
	_title = getText(_curConfig >> "title");
	_type = getText(_curConfig >> "type");
	_price = getNumber(_curConfig >> "price");
	_multi = getNumber(_curConfig >> "multi");
	if(_type isEqualTo _typeSel)then
	{
		_listContrav lbAdd format["#%1 - %2 - %3",_id, _title, _price];
		_data = [_id,_title,_price];
		_listContrav lbSetData [(lbSize _listContrav)-1,str _data];	
	};
};
