#include "..\..\script_macros.hpp"
/*
    File: fn_viewWar.sqf

*/
private ["_enemyGangQG", "_gangName", "_enemyGangName", "_gangWar", "_enemyGangWar", "_butin", "_gangBank", "_action"];
;
if (playerSide != civilian) exitWith {}; //What in the hell?
if(isNull life_gangQG)exitWith {};

_gangWar = life_gangQG getVariable ["gang_war",[]];
if(count _gangWar isEqualTo 0) exitWith {hint "Ton gang n a pas de guerre en cours";};

disableSerialization;
[
        "",
        0,
        0.2,
        10,
        0,
        0,
        8
] spawn BIS_fnc_dynamicText;

createDialog "RscDisplayWelcome";

_display = findDisplay 999999;
_text1 = _display displayCtrl 1100;
_buttonSpoiler = _display displayCtrl 2400;
_textSpoiler = _display displayCtrl 1101;
_text2 = _display displayCtrl 1102;

_message = "";
_message = _message + "<t size='1.6'>Guerre en cours</t><br />";
{
	_message = _message + format["<t size='1.3'>Gang: %1<br/>Butin: %2</t><br/><br/>", _x select 0, _x select 1];
}forEach _gangWar;


//Fill only the first text
_text1 ctrlSetStructuredText (parseText _message);

//Resize StructuredText component to display the scrollbar if needed
_positionText1 = ctrlPosition _text1;
_yText1 = _positionText1 select 1;
_hText1 = ctrlTextHeight _text1;
_text1 ctrlSetPosition [_positionText1 select 0, _yText1, _positionText1 select 2, _hText1];
_text1 ctrlCommit 0;
//Hide second text, spoiler text and button
_buttonSpoiler ctrlSetFade 1;
_buttonSpoiler ctrlCommit 0;
_buttonSpoiler ctrlEnable false;
_textSpoiler ctrlSetFade 1;
_textSpoiler ctrlCommit 0;
_text2 ctrlSetFade 1;
_text2 ctrlCommit 0;
