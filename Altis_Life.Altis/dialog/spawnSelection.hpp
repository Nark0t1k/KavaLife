class life_spawn_selection
{
	idd = 38500;
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground
	{
		class life_RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.0125;
			y = 0.2;
			w = 0.8875;
			h = 0.04;
		};
		
		class MainBackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.0124999;
			y = 0.244;
			w = 0.8875;
			h = 0.72;
		};
		
		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = -1;
			text = "$STR_Spawn_Title";
			x = 0.0125;
			y = 0.2;
			w = 0.8875;
			h = 0.04;
		};
		
		class SpawnPointTitle : Title
		{
			idc = 38501;
			style = 1;
			text = "";
		};
		
		class MapView : Life_RscMapControl 
		{
			idc = 38502;
			x = 0.3255;
			y = 0.26;
			w = 0.5625;
			h = 0.68;
			maxSatelliteAlpha = 0.75;//0.75;
			alphaFadeStartScale = 1.15;//0.15;
			alphaFadeEndScale = 1.29;//0.29;
		};
	};
	
	class controls
	{	
		class SpawnPointList: Life_RscListNBox
		{
			idc = 38510;
			text = "";
			sizeEx = 0.041;
			coloumns[] = {0,0,0.9};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			rowHeight = 0.050;
			x = 0.025;
			y = 0.26;
			w = 0.2875;
			h = 0.62;
			onLBSelChanged = "_this call life_fnc_spawnPointSelected;";
		};
		
		class spawnButton : Life_RscButtonMenu
		{
			idc = -1;
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			text = "$STR_Spawn_Spawn";
			onButtonClick = "[] call life_fnc_spawnConfirm";
			x = 0.1125;
			y = 0.9;
			w = 0.2;
			h = 0.04;
		};
	};
};

class life_Uber_selection
{
	idd = 38550;
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground
	{
		class life_RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.0125;
			y = 0.2;
			w = 0.8875;
			h = 0.04;
		};
		
		class MainBackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.0124999;
			y = 0.244;
			w = 0.8875;
			h = 0.72;
		};
		
		class Title : Life_RscTitle
		{
			colorBackground[] = {0,0,0,0};
			idc = 38551;
			text = "Menu Taxi - Choissisez votre destination";
			x = 0.0125;
			y = 0.2;
			w = 0.8875;
			h = 0.04;
		};
		
		class MapView : Life_RscMapControl 
		{
			idc = 38552;
			x = 0.3255;
			y = 0.26;
			w = 0.5625;
			h = 0.68;
			maxSatelliteAlpha = 0.75;//0.75;
			alphaFadeStartScale = 1.15;//0.15;
			alphaFadeEndScale = 1.29;//0.29;
		};
	};
	
	class controls
	{	
		class SpawnPointList: Life_RscListNBox
		{
			idc = 38560;
			text = "";
			sizeEx = 0.041;
			coloumns[] = {0,0,0.9};
			drawSideArrows = 0;
			idcLeft = -1;
			idcRight = -1;
			rowHeight = 0.050;
			x = 0.025;
			y = 0.26;
			w = 0.2875;
			h = 0.62;
			onLBSelChanged = "_this call life_fnc_uberPointSelected;";
		};
		
		class spawnButton : Life_RscButtonMenu
		{
			idc = -1;
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			text = "Commander";
			onButtonClick = "[] spawn life_fnc_uberConfirm";
			x = 0.1125;
			y = 0.9;
			w = 0.2;
			h = 0.04;
		};
	};
};