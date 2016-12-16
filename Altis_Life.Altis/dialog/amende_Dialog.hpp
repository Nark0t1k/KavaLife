class AmendeDialog {
	idd = 13000;
	name= "life_amendeDialog";
	movingEnable = false;
	enableSimulation = true;
	// onLoad = "uiNamespace setVariable [""LicenseShop"", _this select 0];";
	objects[] = { };
	class controls {
			 
		class RscTitleBackground: Life_RscText
		{
			idc = -1;

			text = "Menu Amendes"; //--- ToDo: Localize;
			x = 0;
			y = 0.2;
			w = 1;
			h = 0.04;
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class Mainbackground: Life_RscText
		{
			idc = -1;

			x = -9.49949e-008;
			y = 0.244;
			w = 1;
			h = 0.52;
			colorBackground[] = {0,0,0,0.7};
		};
		class giveBoxContrav: Life_RscListBox
		{
			idc = 13001;
			sizeEx = 0.035;
			x = 0.55;
			y = 0.3;
			w = 0.45;
			h = 0.38;
		};
		class lstBoxContrav: Life_RscListBox
		{
			idc = 13002;
			sizeEx = 0.035;
			x = 0;
			y = 0.36;
			w = 0.45;
			h = 0.38;
		};
		class lstHeaderContrav: Life_RscText
		{
			idc = -1;

			text = "Infractions"; //--- ToDo: Localize;
			x = 0.2125;
			y = 0.24;
			w = 0.1375;
			h = 0.04;
		};
		class giveHeaderContrav: Life_RscText
		{
			idc = -1;

			text = "Amende"; //--- ToDo: Localize;
			x = 0.625;
			y = 0.24;
			w = 0.1625;
			h = 0.04;
		};
		class typeHeader: Life_RscText
		{
			idc = -1;
			text = "Type";
			x = 0.025;
			y = 0.3;
			w = 0.0875;
			h = 0.04;
		};		
		class buybutton: Life_RscButtonMenu
		{
			idc = -1;
			action = "[life_pInact_curTarget] spawn life_fnc_amendeSend;closeDialog 0;";
			text = "Donner Amende"; //--- ToDo: Localize;
			x = 0.775;
			y = 0.76;
			w = 0.225;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class closebutton: Life_RscButtonMenu
		{
			idc = -1;
			action = "closeDialog 0;";

			text = "Fermer"; //--- ToDo: Localize;
			x = 0;
			y = 0.76;
			w = 0.15;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
		};
		class moveRbutton: Life_RscButtonMenu
		{
			idc = -1;
			action = "[0] spawn life_fnc_amendeSelect;";

			text = "»";
			x = 0.4625;
			y = 0.38;
			w = 0.0625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class moveLbutton: Life_RscButtonMenu
		{
			idc = -1;
			action = "[1] spawn life_fnc_amendeSelect;";

			text = "«"; //--- ToDo: Localize;
			x = 0.4625;
			y = 0.46;
			w = 0.0625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class moveAllLbutton: Life_RscButtonMenu
		{
			idc = -1;
			action = "[2] spawn life_fnc_amendeSelect;";

			text = "«««"; //--- ToDo: Localize;
			x = 0.4625;
			y = 0.6;
			w = 0.0625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class priceHeader: Life_RscText
		{
			idc = -1;

			text = "Total:"; //--- ToDo: Localize;
			x = 0.55;
			y = 0.7;
			w = 0.0875;
			h = 0.04;
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class priceBox: Life_RscText
		{
			idc = 13003;

			x = 0.65;
			y = 0.7;
			w = 0.2375;
			h = 0.04;
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class listType: Life_RscCombo
		{
			idc = 13004;
			onLBSelChanged = "_this call life_fnc_amendeLBDialog;";
			colorBackground[] = {0,0,0,1};
			x = 0.1375;
			y = 0.3;
			w = 0.275;
			h = 0.04;
		};		
	};
};

class AmendePayDialog {
	idd = 14000;
	name= "life_amendePayDialog";
	movingEnable = false;
	enableSimulation = true;
	// onLoad = "uiNamespace setVariable [""LicenseShop"", _this select 0];";
	objects[] = { };
	class controls {
			 
		class RscTitleBackground: Life_RscText
		{
			idc = -1;

			text = "Menu Amendes"; //--- ToDo: Localize;
			x = 0.2125;
			y = 0;
			w = 0.5375;
			h = 0.04;
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class Mainbackground: Life_RscText
		{
			idc = -1;

			x = 0.2125;
			y = 0.04;
			w = 0.5375;
			h = 0.96;
			colorBackground[] = {0,0,0,0.7};
		};
		class lstBoxContrav: Life_RscListBox
		{
			idc = 14001;
			sizeEx = 0.035;
			x = 0.225;
			y = 0.14;
			w = 0.5125;
			h = 0.68;
		};
		class lstHeaderContrav: Life_RscText
		{
			idc = -1;

			text = "Infractions"; //--- ToDo: Localize;
			x = 0.2625;
			y = 0.08;
			w = 0.1375;
			h = 0.04;
		};
		class giveHeaderContrav: Life_RscText
		{
			idc = -1;

			text = "Amende"; //--- ToDo: Localize;
			x = 0.425;
			y = 0.08;
			w = 0.1625;
			h = 0.04;
		};
		class buybutton: Life_RscButtonMenu
		{
			idc = -1;
			action = "[] spawn life_fnc_amendePaid;closeDialog 0;";
			text = "Payer"; //--- ToDo: Localize;
			x = 0.575;
			y = 0.92;
			w = 0.15;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class closebutton: Life_RscButtonMenu
		{
			idc = -1;
			action = "closeDialog 0;";

			text = "Refuser"; //--- ToDo: Localize;
			x = 0.25;
			y = 0.92;
			w = 0.15;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};	
		class priceHeader: Life_RscText
		{
			idc = -1;

			text = "Total:"; //--- ToDo: Localize;
			x = 0.25;
			y = 0.84;
			w = 0.0875;
			h = 0.04;
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};
		class priceBox: Life_RscText
		{
			idc = 14002;

			x = 0.3625;
			y = 0.84;
			w = 0.3625;
			h = 0.04;
			colorBackground[] = {0,0.5686,0.1529,0.7};
		};	
	};
};