class Life_KPhoneMenu {
	idd = 88000;
	name = "Life_KPhoneMenu";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[player] remoteExec [""TON_fnc_getFullMessages"",2];";
	class controlsBackground {
		class MainBackground: Life_RscText{
			idc = -1;
			x = 0;
			y = 0;
			w = 1;
			h = 0.92;
			colorBackground[] = {0,0,0,0.7};
		};
		class PhoneTitleBackground: Life_RscText{
			idc = -1;
			x = 0;
			y = 0;
			w = 1;
			h = 0.12;
			colorBackground[] = {0.588,0.424,0.145,1};
		};
		class HeaderAuteur: Life_RscText{
			idc = -1;
			text = "Auteur";
			x = 0.0125;
			y = 0.14;
			w = 0.15;
			h = 0.04;
			colorBackground[] = {0.588,0.424,0.145,1};
		};
		class HeaderMessPreview: Life_RscText{
			idc = -1;
			text = "Dernier Message";
			x = 0.2625;
			y = 0.14;
			w = 0.2375;
			h = 0.04;
			colorBackground[] = {0.588,0.424,0.145,1};
		};
		class MessageMenuTitle: Life_RscTitle{
			idc = -1;
			text = "Messages";
			x = 0.2;
			y = 0;
			w = 0.6;
			h = 0.12;
			sizeEx = 0.1;
			colorText[] = {0.95,0.95,0.95,1};
			style = ST_CENTER;
		};
	};
	
	class controls {
		class MessageList: Life_RscListNBox{
			idc = 88001;
			text = "Liste des messages";
			// onLBDblClick = "[lbCurSel 88001] call life_fnc_showMessage;";
			onLBDblClick = "[0] call life_fnc_showMessage;";
			x = 0.0125;
			y = 0.2;
			w = 0.975;
			h = 0.7;	
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorBackground[] = {0, 0, 0, 0.0};
			columns[] = {0,0.3};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			rowHeight = 0.050;			
			
		};
		class NewMessButton: Life_RscButtonMenu{
			idc = 88002;
			text = "Nouveau Message";
			x = 0.8;
			y = 0.04;
			w = 0.1875;
			h = 0.04;
			onButtonClick = "createDialog ""Life_KPhoneNew"";";
			
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
		};
		class DeleteAllButton: Life_RscButtonMenu{
			idc = 88003;
			onButtonClick = "[] spawn life_fnc_deleteMess;";
			text = "Supprimer Tout";
			x = 0.0125;
			y = 0.04;
			w = 0.1875;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.584,0.086,0.086,1};
		};
		class CloseButton: Life_RscButtonMenu{
			onButtonClick = "closeDialog 0;";
			idc = -1;
			text = "Fermer";
			x = 0;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};	

	};
};

class Life_KPhoneMessage {
	idd = 88500;
	name = "Life_KPhoneMessage";
	movingEnable = false;
	enableSimulation = true;
	// onLoad = "[] spawn life_fnc_smartphone;";
	class controlsBackground {
		class MainBackground: Life_RscText{
			idc = -1;
			x = 0;
			y = 0;
			w = 1;
			h = 0.92;
			colorBackground[] = {0,0,0,0.7};
		};
		class PhoneTitleBackground: Life_RscText{
			idc = -1;
			x = 0;
			y = 0;
			w = 1;
			h = 0.12;
			colorBackground[] = {0.588,0.424,0.145,1};
		};
		class MessageMenuTitle: Life_RscTitle{
			idc = -1;
			text = "Messages";
			x = 0.2;
			y = 0;
			w = 0.6;
			h = 0.12;
			sizeEx = 0.1;
			colorText[] = {0.95,0.95,0.95,1};
			style = ST_CENTER;
		};
	};
	
	class controls {
		class MessageList: life_RscListBox{
			idc = 88501;
			text = "Liste des messages";
			x = 0.0125;
			y = 0.22;
			w = 0.975;
			h = 0.6;	
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";			
		};
		class ReturnButton: Life_RscButtonMenu{
			idc = 88502;
			text = "Retour";
			x = 0.0125;
			y = 0.04;
			w = 0.1875;
			h = 0.04;
			onButtonClick = "closeDialog 0;";
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
		};
		class SendButton: Life_RscButtonMenu{
			idc = 88503;
			text = "->";
			x = 0.9375;
			y = 0.84;
			w = 0.05;
			h = 0.06;
			onButtonClick = "[false] call life_fnc_sendMessage;";
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
		};
		class DeleteAllButton: Life_RscButtonMenu{
			idc = 88504;
			onButtonClick = "[] spawn life_fnc_deleteMess;";
			text = "Supprimer Tout";
			x = 0.8;
			y = 0.04;
			w = 0.1875;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.584,0.086,0.086,1};
		};
		class HeaderAuteur: Life_RscText{
			idc = 88505;
			text = "Auteur:";
			x = 0.3375;
			y = 0.14;
			w = 0.2625;
			h = 0.06;
			colorBackground[] = {0.588,0.424,0.145,1};
		};
		class CloseButton: Life_RscButtonMenu{
			onButtonClick = "closeDialog 0;closeDialog 0;";
			idc = -1;
			text = "Fermer";
			x = 0;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};	
		class MessageWrite : Life_RscEdit {
			idc = 88506;
			text = "";
			x = 0.0125;
			y = 0.84;
			w = 0.9125;
			h = 0.06;
		};
		class OnlineStatut : Life_RscStructuredText{
			idc = 88507;
			text = "";
			x = 0.275;
			y = 0.14;
			w = 0.05;
			h = 0.06;
		};
	};
};

class Life_KPhoneNew {
	idd = 89000;
	name = "Life_KPhoneNew";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn life_fnc_newMessMenu;";
	class controlsBackground {
		class MainBackground: Life_RscText{
			idc = -1;
			x = 0;
			y = 0;
			w = 1;
			h = 0.92;
			colorBackground[] = {0,0,0,0.7};
		};
		class PhoneTitleBackground: Life_RscText{
			idc = -1;
			x = 0;
			y = 0;
			w = 1;
			h = 0.12;
			colorBackground[] = {0.588,0.424,0.145,1};
		};
		class MessageMenuTitle: Life_RscTitle{
			idc = -1;
			text = "Messages";
			x = 0.2;
			y = 0;
			w = 0.6;
			h = 0.12;
			sizeEx = 0.1;
			colorText[] = {0.95,0.95,0.95,1};
			style = ST_CENTER;
		};
		class HeaderSendTo : Life_RscText{
			idc = -1;
			text = "Envoyer a:";
			x = 0.275;
			y = 0.66;
			w = 0.1625;
			h = 0.04;
		};
	};
	
	class controls {
		class PlayerList: life_RscListBox{
			idc = 89001;
			text = "Liste des messages";
			x = 0.0125;
			y = 0.2;
			w = 0.25;
			h = 0.7;	
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";			
		};
		class HeaderBotin: Life_RscText{
			idc = -1;
			text = "Annuaire:";
			x = 0.0125;
			y = 0.14;
			w = 0.125;
			h = 0.04;
			colorBackground[] = {0.588,0.424,0.145,1};
		};
		class ReturnButton: Life_RscButtonMenu{
			idc = 89002;
			text = "Retour";
			x = 0.0125;
			y = 0.04;
			w = 0.1875;
			h = 0.04;
			onButtonClick = "closeDialog 0;";
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
		};
		class SendButton: Life_RscButtonMenu{
			idc = 89003;
			text = "Envoyer";
			x = 0.7625;
			y = 0.66;
			w = 0.2125;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
		};
		class DeleteAllButton: Life_RscButtonMenu{
			idc = 89004;
			// onButtonClick = "[] spawn life_fnc_deleteMess;";
			text = "Supprimer Tout";
			x = 0.8;
			y = 0.04;
			w = 0.1875;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.584,0.086,0.086,1};
		};
		class CloseButton: Life_RscButtonMenu{
			onButtonClick = "closeDialog 0;";
			idc = -1;
			text = "Fermer";
			x = 0;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};	
		class MessageWrite : Life_RscEdit{
			idc = 89005;
			style = ST_MULTI;
			text = "";
			x = 0.275;
			y = 0.2;
			w = 0.7125;
			h = 0.44;
		};
		class BoxBotin : Life_RscCombo{
			idc = 89006;
			text = "";
			x = 0.15;
			y = 0.14;
			w = 0.2125;
			h = 0.04;
			onLBSelChanged = "[] call life_fnc_newMessLB;";
			colorBackground[] = {0,0,0,1};
		};
		class BoxSelect : Life_RscCombo{
			idc = 89007;
			text = "";
			x = 0.4625;
			y = 0.66;
			w = 0.2125;
			h = 0.04;
			colorBackground[] = {0,0,0,1};
		};
	};
};