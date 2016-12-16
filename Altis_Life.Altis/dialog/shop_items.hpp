class shops_menu {
	idd = 2400;
	name= "shops_menu";
	movingEnable = false;
	enableSimulation = true;
	//onLoad = "['guns'] execVM 'gear\switch.sqf'";
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.5686, 0.1529, 0.7};
			idc = -1;
			x = 0;
			y = 0.2;
			w = 0.9;
			h = 0.04;
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0;
			y = 0.24;
			w = 0.9;
			h = 0.52;
		};
		
		class vasText : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0, 0.5686, 0.1529, 0.5};
			text = "$STR_VS_SI";
			sizeEx = 0.04;
			x = 0.0075;
			y = 0.27;
			w = 0.4125;
			h = 0.04;
		};
		
		class vasgText : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0, 0.5686, 0.1529, 0.5};
			text = "$STR_VS_PI";
			sizeEx = 0.04;
			
			x = 0.4875;
			y = 0.27;
			w = 0.3875;
			h = 0.04;
		};
	};
	
	class controls {

		class itemList : Life_RscListBox 
		{
			idc = 2401;
			text = "";
			sizeEx = 0.030;
			//onLBSelChanged = "[] call fnc_selection";
			
			x = 0.0125;
			y = 0.3;
			w = 0.4125;
			h = 0.34;
		};
		
		class pItemlist : Life_RscListBox 
		{
			idc = 2402;
			text = "";
			sizeEx = 0.030;
			//onLBSelChanged = "[2502] execVM 'gear\selection.sqf'";
			
			x = 0.4875;
			y = 0.31;
			w = 0.3875;
			h = 0.34;
		};
			
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2403;
			text = "";
			x = 0;
			y = 0.2;
			w = 0.9;
			h = 0.04;
		};

		class PlayersName : Title {
			idc = 601;
			style = 1;
			text = "";
			x = 0;
			y = 0.2;
			w = 0.9;
			h = 0.04;
		};
		
		class buyEdit : Life_RscEdit 
		{
			idc = 2404;
			
			text = "1";
			sizeEx = 0.030;
			x = 0.05;
			y = 0.66;
			w = 0.27;
			h = 0.03;
		};
	
		class ButtonAddG : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_VS_BuyItem";
			colorBackground[] = {0, 0.5686, 0.1529, 0.5};
			onButtonClick = "[] spawn life_fnc_virt_buy;";
			
			x = 0.1;
			y = 0.7;
			w = 0.15625;
			h = 0.04;
		};
		
		class sellEdit : Life_RscEdit 
		{
			idc = 2405;
			
			text = "1";
			sizeEx = 0.030;
			x = 0.5375;
			y = 0.66;
			w = 0.27;
			h = 0.03;
		};
		class ButtonRemoveG : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_VS_SellItem";
			colorBackground[] = {0, 0.5686, 0.1529, 0.5};
			onButtonClick = "[1] spawn life_fnc_virt_sell";
			
			x = 0.5;
			y = 0.7;
			w = 0.125;
			h = 0.04;
		};
		
		class ButtonRemoveMaxG : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_VS_SellMax";
			colorBackground[] = {0.035,0.415,0.035, 0.7};
			onButtonClick = "[0] spawn life_fnc_virt_sell";
			x = 0.675;
			y = 0.7;
			w = 0.125;
			h = 0.04;
			
		};
		
		class ButtonClose : Life_RscButtonMenu {
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.375;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
	};
};