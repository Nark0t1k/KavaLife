#include "..\..\script_macros.hpp"
/*
	fn_amendeLoadDialog.sqf
*/


private["_listGiveContrav","_listContrav","_fullListContrav","_nbrContrav","_titleContrav","_priceContrav","_displayname","_listType"];

disableSerialization;
if(dialog) then
{
	closeDialog 0;
};

createDialog "AmendeDialog";

life_amende_listL = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];

_listGiveContrav = CONTROL(13000,13001);
_listContrav = CONTROL(13000,13002);
_listType = CONTROL(13000,13004);

lbClear _listGiveContrav;
lbClear _listContrav;
lbClear _listType;

{
	_listType lbAdd _x;
	_listType lbSetData [(lbSize _listType)-1,_x];
}forEach ["Vehicules","Vitesse","Civils","Vols","Delits","Divers"];
_listType lbSetCurSel 0;
