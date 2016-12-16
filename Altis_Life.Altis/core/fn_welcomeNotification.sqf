/*
	File: fn_welcomeNotification.sqf
	Author:

	Description:
	Called upon first spawn selection and welcomes our player.
*/
disableSerialization;
_display = findDisplay 999999;
_text1 = _display displayCtrl 1100;
_buttonSpoiler = _display displayctrl 2400;
_textSpoiler = _display displayctrl 1101;
_text2 = _display displayCtrl 1102;

_message = "";
_message = _message + "<t align='center' size='8' shadow='0'><img image='textures\KavOr.paa' /></t><br /><br />";
_message = _message + "Utiliser la touche F1 pour plus d information.<br /><br />";
_message = _message + " <a href='http://kavalash.fr' color='#56BDD6'>FORUM</a> -- Rendez vous sur notre forum pour plus d information.<br /><br />";
_message = _message + "Serveur TeamSpeak 3: TS.KAVALASH.FR  <a href='http://www.teamspeak.com/invite/ts.kavalash.fr/' color='#56BDD6'>REJOINDRE</a><br /><br />";


//Fill only the first text
_text1 ctrlSetStructuredText (parseText _message);

//Resize StructuredText component to display the scrollbar if needed
_positionText1 = ctrlPosition _text1;
_yText1 = _positionText1 select 1;
_hText1 = ctrlTextHeight _text1;
_text1 ctrlSetPosition [_positionText1 select 0, _yText1, _positionText1 select 2, _hText1];
_text1 ctrlcommit 0;
//Hide second text, spoiler text and button
_buttonSpoiler ctrlSetFade 1;
_buttonSpoiler ctrlCommit 0;
_buttonSpoiler ctrlEnable false;
_textSpoiler ctrlSetFade 1;
_textSpoiler ctrlCommit 0;
_text2 ctrlSetFade 1;
_text2 ctrlCommit 0;
