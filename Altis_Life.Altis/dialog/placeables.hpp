class Life_Cop_Placeables {
	idd = 20000;
    name= "life_cop_placeables";
    movingEnable = false;
    enableSimulation = true;
    onLoad = "";
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MainBackground:Life_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.264 * safezoneH;
        };
    };
	class controls {
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Available placeables";
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.319688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class PlaceablesList : Life_RscListBox {
			idc = 20001;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "[] call life_fnc_placeablePlaceSwitch;";
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.264 * safezoneH;
		};
		class CloseButtonKey : Life_RscButtonMenu {            
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Remove : life_RscButtonMenu {
			idc = -1;
			text = "Supprimer Type";
			onButtonClick = "[] call life_fnc_placeablesRemove";
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;    
		};				
		class RemoveAll : life_RscButtonMenu {
			idc = -1;
			text = "Supprimer TT";
			onButtonClick = "[] call life_fnc_placeablesRemoveAll";
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class Place : Life_RscButtonMenu {
			idc = -1;
			text = "Place";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick = "[] spawn life_fnc_placeablePlace;";
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class ItemPicture : Life_RscPicture
		{
			idc = 20002;
			text = "textures\KavOr.paa";
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.121 * safezoneH;
		};
    };
};
