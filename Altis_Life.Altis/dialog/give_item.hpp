class Life_give_item {
	idd = 3700;
	name= "Life_give_item";
	movingEnable = 0;
	enableSimulation = 1;
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.6;
			h = 0.6 - (22 / 250);
		};
	};
	
	class controls {

		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_Keys_Title";
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class ItemList : Life_RscListBox 
		{
			idc = 3701;
			text = "";
			sizeEx = 0.035;
			
			x = 0.12; y = 0.26;
			w = 0.56; h = 0.370;
		};

		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class editItem : Life_RscEdit {
		
		idc = 3702;
		
		text = "1";
		x = 0.2375;
		y = 0.7;
		w = 0.2625;
		h = 0.04;
		
		};
				
		class GiveItem : Life_RscButtonMenu {
			idc = 3703;
			text = "Donner";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[true,0] call life_fnc_giveItem";
			x = 0.525;
			y = 0.7;
			w = 0.15625;
			h = 0.04;
		};
		class Give5Item : Life_RscButtonMenu {
			idc = 3704;
			text = "Donner 5";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[false,5] call life_fnc_giveItem";
			x = 0.125;
			y = 0.64;
			w = 0.15625;
			h = 0.04;
		};
		class Give10Item : Life_RscButtonMenu {
			idc = 3705;
			text = "Donner 10";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[false,10] call life_fnc_giveItem";
			x = 0.325;
			y = 0.64;
			w = 0.15625;
			h = 0.04;
		};
		class Give0Item : Life_RscButtonMenu {
			idc = 3706;
			text = "Donner Max";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[false,0] call life_fnc_giveItem";
			x = 0.5125;
			y = 0.64;
			w = 0.15625;
			h = 0.04;
		};
	};
};

class Life_give_money {
	idd = 3800;
	name= "Life_give_money";
	movingEnable = 0;
	enableSimulation = 1;
	// onLoad = "[] spawn life_fnc_keyMenu;";
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.275;
			y = 0.2;
			w = 0.3375;
			h = 0.04;
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.275;
			y = 0.24;
			w = 0.3375;
			h = 0.52;
		};
	};
	
	class controls {

		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Menu Donner Argent";
			x = 0.275;
			y = 0.2;
			w = 0.3375;
			h = 0.04;
		};
		
		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.3125;
			y = 0.78;
			w = 0.15625;
			h = 0.04;
		};
		
		class editItem : Life_RscEdit {
		
		idc = 3702;
		
		text = "0";
		x = 0.3125;
		y = 0.6;
		w = 0.2375;
		h = 0.04;
		
		};
				
		class GiveItem : Life_RscButtonMenu {
			idc = 3703;
			text = "Donner";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[0] call life_fnc_giveMoney";
			x = 0.3125;
			y = 0.68;
			w = 0.2375;
			h = 0.04;
		};
		class Give5Item : Life_RscButtonMenu {
			idc = 3704;
			text = "Donner 1.000$";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[1000] call life_fnc_giveMoney";
			x = 0.3125;
			y = 0.26;
			w = 0.2375;
			h = 0.04;
		};
		class Give10Item : Life_RscButtonMenu {
			idc = 3705;
			text = "Donner 10.000$";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[10000] call life_fnc_giveMoney";
			x = 0.3125;
			y = 0.32;
			w = 0.2375;
			h = 0.04;
		};
		class Give0Item : Life_RscButtonMenu {
			idc = 3706;
			text = "Donner 100.000$";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[100000] call life_fnc_giveMoney";
			x = 0.3125;
			y = 0.38;
			w = 0.2375;
			h = 0.04;
		};
	};
};