class Life_impoundPolice_menu
{
	idd = 3800;
	name="Life_impoundPolice_menu";
	movingEnable = 0;
	enableSimulation = 1;
		onLoad = "[] spawn life_fnc_loadImpoundPolice;";
	
	class controlsBackground
	{
		class Life_RscTitleBackground: Life_RscText
		{
			idc = -1;

			x = 0.1;
			y = 0.2;
			w = 0.64;
			h = 0.04;
			colorBackground[] = {0,0.509,0.121,0.7};
		};
		class MainBackground: Life_RscText
		{
			idc = -1;

			x = 0.1;
			y = 0.244;
			w = 0.6375;
			h = 0.3;
			colorBackground[] = {0,0,0,0.7};
		};
		class Title: Life_RscTitle
		{
			idc = -1;

			text = "Menu Extraction Vehicule Police"; //--- ToDo: Localize;
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
			class Attributes 
			{
				align = "center";
			};
		};
		class TextClassicImpound: Life_RscTitle
		{
			idc = -1;

			text = "Mise en fourriere"; //--- ToDo: Localize;
			x = 0.125;
			y = 0.3;
			w = 0.2875;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
			class Attributes 
			{
				align = "center";
			};
		};
		class TextPoliceImpound: Life_RscTitle
		{
			idc = -1;

			text = "Remorquage au poste:"; //--- ToDo: Localize;
			x = 0.125;
			y = 0.38;
			w = 0.2875;
			h = 0.04;
			colorText[] = {0.95,0.95,0.95,1};
			class Attributes 
			{
				align = "center";
			};
		};		
	};
	
	class controls
	{
		class PostList: Life_RscCombo
		{
			idc = 3801;

			x = 0.425;
			y = 0.38;
			w = 0.2625;
			h = 0.04;
		};
		class ClassicImpoundBoutton: Life_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0;[life_vInact_curTarget] spawn life_fnc_impoundAction;";

			text = "Mise en fourriere"; //--- ToDo: Localize;
			x = 0.425;
			y = 0.3;
			w = 0.2625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.509,0.121,0.5};
			class Attributes 
			{
				align = "center";
			};
		};
		class ImpoundPoliceButton: Life_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0;[life_vInact_curTarget] call life_fnc_impoundPoliceAction;";

			text = "Remorquage"; //--- ToDo: Localize;
			x = 0.425;
			y = 0.44;
			w = 0.2625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.509,0.121,0.5};
			class Attributes 
			{
				align = "center";
			};
		};
		class CloseButtonKey: Life_RscButtonMenu
		{
			onButtonClick = "closeDialog 0;";

			idc = -1;
			text = "Fermer"; //--- ToDo: Localize;
			x = 0.1;
			y = 0.5;
			w = 0.15625;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			class Attributes 
			{
				align = "center";
			};
		};		
	};
};
