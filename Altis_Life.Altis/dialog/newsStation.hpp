class life_news_broadcast {
    idd = 100100;
    name= "life_news_broadcast";
    movingEnable = 0;
    enableSimulation = 1;

    class controlsBackground {
        class Life_RscTitleBackground: Life_RscText {
            colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])", "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])", "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])", "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
			x = 0.0874748;
			y = 0.161683;
			w = 0.65;
			h = 0.04;
        };

        class MainBackground: Life_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
			x = 0.0875;
			y = 0.2;
			w = 0.65;
			h = 0.46;
        };
    };

    class controls {
        class Title: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "$STR_News_DialogTitle";
			x = 0.0875;
			y = 0.16;
			w = 0.647475;
			h = 0.043367;
        };

        class MsgHeader: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "$STR_News_MsgHeader";
			x = 0.1;
			y = 0.213266;
			w = 0.6375;
			h = 0.04;
        };

        class MsgHeaderEdit: Life_RscEdit {
            idc = 100101;
            text = "";
            sizeEx = 0.035;
			x = 0.1;
			y = 0.261481;
			w = 0.6375;
			h = 0.04;
        };

        class MsgText: Life_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "$STR_News_MsgContent";
			x = 0.101263;
			y = 0.314848;
			w = 0.6375;
			h = 0.04;
        };

        class MsgContentEdit: Life_RscEdit {
            idc = 100102;
            text = "";
            sizeEx = 0.035;
			x = 0.101212;
			y = 0.361482;
			w = 0.6375;
			h = 0.04;
        };

        class MessageInfo: Life_RscStructuredText {
            colorBackground[] = {0, 0, 0, 0};
            idc = 100103;
            text = "";
			x = 0.1;
			y = 0.52;
			w = 0.5625;
			h = 0.12;
        };

        class ConfirmButtonKey: Life_RscButtonMenu {
            idc = 100104;
            text = "$STR_News_Broadcast";
			x = 0.475;
			y = 0.66;
			w = 0.2625;
			h = 0.04;
        };

        class CloseButtonKey: Life_RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
			x = 0.0875;
			y = 0.66;
			w = 0.15625;
			h = 0.04;
        };

        class TimeText: Life_RscTitle {
            idc = -1;
            text = "Choisir le temps de diffusion";
			x = 0.1125;
			y = 0.42;
			w = 0.3;
			h = 0.04;
        };

        class AnonymeText: Life_RscTitle {
            idc = -1;
            text = "Envoi Anonyme?";
			x = 0.113636;
			y = 0.471381;
			w = 0.3;
			h = 0.04;
        };

        class TimerButtonKey: Life_RscCombo {
            idc = 100105;
			onLBSelChanged = "_this call life_fnc_timerRadioSelection";
			x = 0.4375;
			y = 0.42;
			w = 0.3;
			h = 0.04;
        };

        class AnonymeButtonKey: Life_Checkbox {
            idc = 100106;
            onCheckedChanged = "[_this select 1] call life_fnc_s_onCheckedAnonyme;";

			x = 0.439394;
			y = 0.47138;
			w = 0.025;
			h = 0.04;
			tooltip = "Permet de masquer sont nom pendant l'envoi du message";
        };
    };
};