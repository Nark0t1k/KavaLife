/* 
	fn_placeablePlaceSwitch.sqf
	
*/
private ["_display","_pictureTxt","_tmp","_picture"];
disableSerialization;

_display = findDisplay 20000;
_pictureTxt = _display displayCtrl 20002;
_tmp = call compile (lbData[20001, lbCurSel (20001)]);
_picture = _tmp select 1;
_pictureTxt ctrlSetText _picture;


