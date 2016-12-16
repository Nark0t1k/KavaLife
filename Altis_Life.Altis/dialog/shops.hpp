class life_weapon_shop
{
	idd = 38400;
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground
	{
		class RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};

		class Mainbackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.1;
			y = 0.244;
			w = 0.325;
			h = 0.54;
		};

		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 38401;
			text = "";
			x = 0.1; y = 0.2;
			w = 0.32; h = (1 / 25);
		};

		class itemInfo : Life_RscStructuredText
		{
			idc = 38404;
			text = "";
			sizeEx = 0.035;
			x = 0.1125;
			y = 0.64;
			w = 0.3;
			h = 0.12;
		};

	};

	class controls
	{
		class itemList : Life_RscListBox
		{
			idc = 38403;
			onLBSelChanged = "_this spawn life_fnc_weaponShopSellSelection";
			sizeEx = 0.035;
			x = 0.11; y = 0.25;
			w = 0.3; h = 0.38;
		};

		class ButtonBuySell : Life_RscButtonMenu
		{
			idc = 38405;
			text = "Vendre";
			onButtonClick = "[] spawn life_fnc_weaponShopSell; true";
			x = 0.1;
			y = 0.78;
			w = 0.15625;
			h = 0.04;
		};

		class ButtonClose : life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.2625;
			y = 0.78;
			w = 0.15625;
			h = 0.04;
		};
	};
};



class life_customweapon_shop
{
	idd = 39500;
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground
	{
		class RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1125;
			y = 0.2;
			w = 0.675;
			h = 0.04;
		};

		class Mainbackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.1125;
			y = 0.24;
			w = 0.675;
			h = 0.6;
		};

		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 39501;
			text = "";
			x = 0.1125;
			y = 0.2;
			w = 0.675;
			h = 0.04;
		};

		class itemInfo : Life_RscStructuredText
		{
			idc = 39504;
			text = "";
			sizeEx = 0.035;
			x = 0.425;
			y = 0.62;
			w = 0.3625;
			h = 0.2;
		};

	};

	class controls
	{
		class itemList : Life_RscListBox
		{
			idc = 39503;
			onLBSelChanged = "_this spawn life_fnc_weaponShopSelection";
			sizeEx = 0.035;
			x = 0.1125;
			y = 0.26;
			w = 0.3;
			h = 0.56;
		};

		class ButtonBuySell : Life_RscButtonMenu
		{
			idc = 39505;
			text = "$STR_Global_Buy";
			onButtonClick = "[] spawn life_fnc_weaponShopBuy; true";
			x = 0.625;
			y = 0.84;
			w = 0.1625;
			h = 0.04;
		};

		class ButtonClose : life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.1125;
			y = 0.84;
			w = 0.15625;
			h = 0.04;
		};

		class ButtonWeap : life_RscButtonMenu
		{
			idc = 39506;
			text = "$STR_Global_Weapons";
			onButtonClick = "0 call life_fnc_weaponShopFilter";
			x = -0.05;
			y = 0.26;
			w = 0.15625;
			h = 0.04;
		};

		class ButtonMags : life_RscButtonMenu
		{
			idc = 39507;
			text = "$STR_Global_Mags";
			onButtonClick = "_this call life_fnc_weaponShopMags; 1 call life_fnc_weaponShopFilter";
			x = -0.05;
			y = 0.32;
			w = 0.15625;
			h = 0.04;
		};

		class ButtonAccs : life_RscButtonMenu
		{
			idc = 39508;
			text = "$STR_Global_Accs";
			onButtonClick = "_this call life_fnc_weaponShopAccs; 2 call life_fnc_weaponShopFilter";
			x = -0.05;
			y = 0.38;
			w = 0.15625;
			h = 0.04;
		};
		class ItemPicture : Life_RscPicture
		{
			idc = 39509;
			text = "textures\KavOr.paa";
			x = 0.425;
			y = 0.26;
			w = 0.3625;
			h = 0.34;
		};
	};
};
