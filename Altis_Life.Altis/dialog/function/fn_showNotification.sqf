/*
	File : fn_showNotification.sqf

	Author: UpperM
	
	Edit by Nark0t1k:
	- Set defaut sound: taskSucceeded
	- Add multi message (history 3)
	- Set defaut color: Blue White Red
	
	Description:

	Show some infos with a nice move :-)
	You can edit the script whitout my permission but you are not allow to remove the credit (but you can add "Edit by : Your Name" )
	You are not allowed to sale my script !

	Contact : uppperm@gmail.com
	Youtube : upperm.fr/youtube
	Website : upperm.fr

	Parameter(s):
	_title 		: STRING - Default Value  : ""
	_text 		: STRING - Default Value  : ""
	_stripColor	: ARRAY  - Default Value  : [0.043,0.486,0.769,1]
	_sound 		: STRING - Default Value  : "taskSucceeded"

	If you don't want to use sound, add "" in the fourth params. ["Error","Oops it's not possible my friend",nil,"mySound"]
	If you want a sound but you don't want to change the strip color, use nil as third params : ["Error","Oops it's not possible my friend",nil,""]

	Exemple : ["Error","Oops it's not possible my friend",nil,""] call UPM_fnc_showNotification;

	Returns: -
*/
private ["_display","_ctrlText","_ctrlStrip","_ctrlCommited"];

params [
	["_text","",[""]],
	["_title","Information",[""]]
];

if (_text isEqualTo "") exitWith {diag_log " /!\ ERROR UPM_fnc_showNotification : No text was set as second params !"};
disableSerialization;
if(isNull (uiNamespace getVariable "RscNotification1"))then {
	15 cutRsc ["RscNotification1", "PLAIN"];

	_display = uiNamespace getVariable "RscNotification1";
	_ctrlText = _display displayCtrl 38501;
	_ctrlStrip = _display displayCtrl 38502;

	_ctrlStrip ctrlSetBackgroundColor [0,0,1,1];
	_ctrlText ctrlSetStructuredText parseText format ["<t size='0.8' font='PuristaLight'>%1</t><br/><t size='0.8' font='PuristaLight' color='#c4c4c4'>%2</t>", _title, _text];


	_ctrlText ctrlSetPosition [0.01 * safezoneW + safezoneX, (ctrlPosition _ctrlText) select 1, (ctrlPosition _ctrlText) select 2, ctrlTextHeight _ctrlText];
	_ctrlText ctrlCommit 1;

	_ctrlStrip ctrlSetPosition [0.0055 * safezoneW + safezoneX, (ctrlPosition _ctrlStrip) select 1, (ctrlPosition _ctrlStrip) select 2, ctrlTextHeight _ctrlText];
	_ctrlStrip ctrlCommit 1;

	playSound "taskSucceeded";
}else
{
	if(isNull (uiNamespace getVariable "RscNotification2"))then {
		// Set Notification n2
		16 cutRsc ["RscNotification2", "PLAIN"];

		_display = uiNamespace getVariable "RscNotification2";
		_ctrlText = _display displayCtrl 38601;
		_ctrlStrip = _display displayCtrl 38602;

		_ctrlStrip ctrlSetBackgroundColor [1,1,1,1];
		_ctrlText ctrlSetStructuredText parseText format ["<t size='0.8' font='PuristaLight'>%1</t><br/><t size='0.8' font='PuristaLight' color='#c4c4c4'>%2</t>", _title, _text];


		_ctrlText ctrlSetPosition [0.01 * safezoneW + safezoneX, (ctrlPosition _ctrlText) select 1, (ctrlPosition _ctrlText) select 2, ctrlTextHeight _ctrlText];
		_ctrlText ctrlCommit 1;

		_ctrlStrip ctrlSetPosition [0.0055 * safezoneW + safezoneX, (ctrlPosition _ctrlStrip) select 1, (ctrlPosition _ctrlStrip) select 2, ctrlTextHeight _ctrlText];
		_ctrlStrip ctrlCommit 1;

		playSound "taskSucceeded";
	}else
	{
		// Set Notification n3
		17 cutRsc ["RscNotification3", "PLAIN"];

		_display = uiNamespace getVariable "RscNotification3";
		_ctrlText = _display displayCtrl 38701;
		_ctrlStrip = _display displayCtrl 38702;

		_ctrlStrip ctrlSetBackgroundColor [1,0,0,1];
		_ctrlText ctrlSetStructuredText parseText format ["<t size='0.8' font='PuristaLight'>%1</t><br/><t size='0.8' font='PuristaLight' color='#c4c4c4'>%2</t>", _title, _text];


		_ctrlText ctrlSetPosition [0.01 * safezoneW + safezoneX, (ctrlPosition _ctrlText) select 1, (ctrlPosition _ctrlText) select 2, ctrlTextHeight _ctrlText];
		_ctrlText ctrlCommit 1;

		_ctrlStrip ctrlSetPosition [0.0055 * safezoneW + safezoneX, (ctrlPosition _ctrlStrip) select 1, (ctrlPosition _ctrlStrip) select 2, ctrlTextHeight _ctrlText];
		_ctrlStrip ctrlCommit 1;

		playSound "taskSucceeded";
	};
};
