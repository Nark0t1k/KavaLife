class Life_Pickup_Items {
	idd = 1520;
	name= "life_pickup_items";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn life_fnc_pickupItems";
	
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
			text = "Ramassage Objets";
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class PickupList : Life_RscListBox 
		{
			idc = 1521;
			text = "";
			sizeEx = 0.035;
			
			x = 0.12; y = 0.26;
			w = 0.56; h = 0.370;
		};

		class CloseLoadMenu : Life_RscButtonMenu {
			idc = -1;
			text = "Fermer";
			onButtonClick = "closeDialog 0;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class PickupJoin : Life_RscButtonMenu {
			idc = 1522;
			text = "Ramasser";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_pickupItem";
			x = 0.32;
			y = 0.65;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};