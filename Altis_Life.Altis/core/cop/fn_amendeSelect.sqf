#include "..\..\script_macros.hpp"
/*
	fn_amendeSelect.sqf
	
	0 - 1 right
	1 - 1 left
	2 - All left
	
*/


private ["_type", "_listGiveContrav", "_priceListContrav", "_dataId", "_fullListContrav", "_i", "_curConfig", "_title", "_price", "_multi", "_exit", "_typeSel", "_idBis", "_nbrCount", "_data", "_totalPrice", "_id"];

_type = _this select 0;
disableSerialization;
_listGiveContrav = CONTROL(13000,13001);
_priceListContrav = CONTROL(13000,13003);

switch(_type)do
{
	case 0:
	{
		_dataId = CONTROL_DATA(13002);
		if(_dataId == "")exitWith {hint "Vous devez selectionner une amendes";};
		_dataId = call compile format["%1", _dataId];
		_dataId = _dataId select 0;
		_fullListContrav = missionConfigFile >> "CfgAmende" >> "Amende";
		for[{_i = 0},{_i < count(_fullListContrav)},{_i = _i + 1}] do {

			_curConfig = (_fullListContrav select _i);
			_id = getNumber(_curConfig >> "id");
			_title = getText(_curConfig >> "title");
			_price = getNumber(_curConfig >> "price");
			_multi = getNumber(_curConfig >> "multi");
			if(_id isEqualTo _dataId)exitWith
			{
				_exit = true;
				for[{_i = 0},{_i < (lbSize _listGiveContrav)},{_i = _i + 1}] do {

					_typeSel = lbData[13001,_i];
					_typeSel = call compile format["%1", _typeSel];
					_idBis = _typeSel select 0;
					if(_idBis isEqualTo _id)exitWith
					{
						_exit = false;
						if(_multi isEqualTo 0) exitWith {hint "Cette infraction ne peux pas etre ajoute plusieurs fois.";};
						_nbrCount = _typeSel select 3;
						_nbrCount = _nbrCount + 1;
						lbDelete [13001,_i];
						_listGiveContrav lbAdd format["#%1 | %4x %2 - %3",_id, _title, _price,_nbrCount];
						_data = [_id,_title,_price,_nbrCount];
						_listGiveContrav lbSetData [(lbSize _listGiveContrav)-1,str _data];	
					};
				};
				
				if(_exit)then
				{
					_listGiveContrav lbAdd format["#%1 | 1x %2 - %3",_id, _title, _price];
					_data = [_id,_title,_price,1];
					_listGiveContrav lbSetData [(lbSize _listGiveContrav)-1,str _data];	
				};
			
			};
		};		
	};
	case 1:
	{
		_dataId = CONTROL_DATA(13001);
		if(_dataId == "")exitWith {hint "Vous devez selectionner une amendes";};
		_dataId = (lbCurSel 13001);
		lbDelete [13001,_dataId];
	};
	case 2:
	{
		lbClear _listGiveContrav;
	};
};

_totalPrice = 0;
_price = 0;
for[{_i = 0},{_i < (lbSize _listGiveContrav)},{_i = _i + 1}] do {

	_data = lbData[13001,_i];
	_data = call compile format["%1", _data];
	_price = _data select 2;
	_nbrCount = _data select 3;
	_totalPrice = _totalPrice + (_price*_nbrCount);
};

_priceListContrav ctrlSetText format["%1",[_totalPrice] call life_fnc_numberText];