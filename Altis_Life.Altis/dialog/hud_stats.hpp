#define ST_CENTER         0x02
/*
	Author: Daniel Stuart

	File: hud_stats.hpp
*/

class playerHUD {
	idd = -1;
	duration = 10e10;
	movingEnable = 0;
	fadein = 0;
	fadeout = 0;
	name = "playerHUD";
	onLoad = "uiNamespace setVariable ['playerHUD',_this select 0]";
	objects[] = {};
	controls[] = {
		Life_RscBackground_HUD,
		Life_RscProgress_HUDHealth,
		Life_RscProgress_HUDWater,
		Life_RscProgress_HUDFood,
		Life_RscText_HUDHealth,
		Life_RscText_HUDWater,
		Life_RscText_HUDFood,
		Life_RscText_HUDMoney
	};

	/* Background */
	class Life_RscBackground_HUD : Life_RscBackground {
		colorBackground[] = {0,0,0,0.35};
		x = 0.907344 * safezoneW + safezoneX;
		y = 0.759 * safezoneH + safezoneY;
		w = 0.0876563 * safezoneW;
		h = 0.165 * safezoneH;
	};

	/* Progress Bars */
	class LIFE_RscProgress_HUDCommon : Life_RscProgress {
		colorFrame[] = {0, 0, 0, 0.8};
		y = 0.972223 * safezoneH + safezoneY;
		w = 0.0462964 * safezoneW;
		h = 0.0222222 * safezoneH;
	};

	class Life_RscProgress_HUDHealth : LIFE_RscProgress_HUDCommon {
		idc = 2201;
		colorBar[] = {0.85,0.05,0,0.65};
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.797 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
	};

	class Life_RscProgress_HUDWater : LIFE_RscProgress_HUDCommon {
		idc = 2202;
		colorBar[] = {0,0.25,0.65,0.65};
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.83 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
	};

	class Life_RscProgress_HUDFood : LIFE_RscProgress_HUDCommon {
		idc = 2200;
		colorBar[] = {0,0.50,0,0.65};
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.863 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
	};

	// class Life_RscProgress_HUDBlood : LIFE_RscProgress_HUDCommon {
		// idc = 2203;
		// colorBar[] = {0.85,0.05,0,0.75};
		// x = 0.9125 * safezoneW + safezoneX;
		// y = 0.896 * safezoneH + safezoneY;
		// w = 0.0773437 * safezoneW;
		// h = 0.022 * safezoneH;
	// };

	/* Texts */
	class Life_RscText_HUDCommon : Life_RscText {
		SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		style = ST_CENTER;
		y = 0.970023 * safezoneH + safezoneY;
		w = 0.0462964 * safezoneW;
		h = 0.0222222 * safezoneH;
	};

	class Life_RscText_HUDMoney : Life_RscStructuredText {
		idc = 1205;
		text = "$STR_HUD_MMoney";
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.764 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes 
		{
			align = "center";
		};
	};
	class Life_RscText_HUDHealth : Life_RscStructuredText {
		idc = 1201;
		text = "$STR_HUD_Health";
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.797 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes 
		{
			align = "center";
		};
	};

	class Life_RscText_HUDWater : Life_RscStructuredText {
		idc = 1202;
		text = "$STR_HUD_Water";
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.83 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes 
		{
			align = "center";
		};
	};

	class Life_RscText_HUDFood : Life_RscStructuredText {
		idc = 1200;
		text = "$STR_HUD_Food";
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.863 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes 
		{
			align = "center";
		};
	};	
	
	// class Life_RscText_HUDBlood : Life_RscText_HUDCommon {
		// idc = 1203;
		// text = "$STR_HUD_Blood";
		// x = 0.9125 * safezoneW + safezoneX;
		// y = 0.896 * safezoneH + safezoneY;
		// w = 0.0773437 * safezoneW;
		// h = 0.022 * safezoneH;
	// };
	
	// class Life_RscText_HUDState : Life_RscText_HUDCommon {
		// idc = 1204;
		// text = "$STR_HUD_State";
		// x = 0.9125 * safezoneW + safezoneX;
		// y = 0.929 * safezoneH + safezoneY;
		// w = 0.0773437 * safezoneW;
		// h = 0.022 * safezoneH;
	// };

};

class playerHUDHealth {
	idd = -1;
	duration = 10e10;
	movingEnable = 0;
	fadein = 0;
	fadeout = 0;
	name = "playerHUDHealth";
	onLoad = "uiNamespace setVariable ['playerHUDHealth',_this select 0]";
	objects[] = {};
	controls[] = {
		Life_RscText_HUDHealth
	};

	
	class Life_RscText_HUDHealth : Life_RscStructuredText {
		idc = 9600;
		style = ST_CENTER;
		// sizeEx = 0.035;
		sizeEx = "0.035 / (getResolution select 5)";
		text = "";
		x = 0.0101562 * safezoneW + safezoneX;
		y = 0.093 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.33 * safezoneH;
	};

};

class playerHUDVehHealth {
	idd = -1;
	duration = 10e10;
	movingEnable = 0;
	fadein = 0;
	fadeout = 0;
	name = "playerHUDVehHealth";
	onLoad = "uiNamespace setVariable ['playerHUDVehHealth',_this select 0]";
	objects[] = {};
	controls[] = {
		Life_RscText_HUDVehHealth
	};

	
	class Life_RscText_HUDVehHealth : Life_RscStructuredText {
		idc = 9650;
		style = ST_CENTER;
		sizeEx = 0.035;
		text = "";
		x = 0.0101562 * safezoneW + safezoneX;
		y = 0.445 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.33 * safezoneH;
	};

};

