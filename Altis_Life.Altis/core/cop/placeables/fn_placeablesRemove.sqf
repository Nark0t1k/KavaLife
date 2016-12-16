/*	Author: TheRick	Description: Addition to Maximums placeables
	fn_placeablesRemove.sqf

*/

private ["_display","_placeables","_tmp","_className","_itemList"];

_display = findDisplay 20000;
_placeables = _display displayCtrl 20001;
_tmp = call compile (lbData[20001, lbCurSel (20001)]);
_className = _tmp select 0;
_itemList = nearestObjects [player, [_className], 10];
life_bar_placey = life_bar_placey - (count _itemList);
if(life_bar_placey < 0)then{life_bar_placey = 0};
{
	deleteVehicle _x;
}foreach _itemList;