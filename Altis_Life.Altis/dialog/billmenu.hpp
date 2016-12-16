class Life_bill_menu
{
	idd = 3900;
	name="Life_bill_menu";
	movingEnable = 0;
	enableSimulation = 1;
	
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
			h = 0.22;
			colorBackground[] = {0,0,0,0.7};
		};
		class Title: Life_RscTitle
		{
			idc = -1;

			text = "Menu Facturation Mecano"; //--- ToDo: Localize;
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
		class TextClassicBill: Life_RscTitle
		{
			idc = -1;

			text = "Montant facture:"; //--- ToDo: Localize;
			x = 0.2625;
			y = 0.28;
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
		class CarBillBoutton: Life_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0;[player,1500] remoteExec [""life_fnc_askBill"",life_pInact_curTarget];";
			text = "1500$"; //--- ToDo: Localize;
			x = 0.1125;
			y = 0.34;
			w = 0.175;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.509,0.121,0.5};
			class Attributes 
			{
				align = "center";
			};
		};
		class TruckBillBoutton: Life_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0;[player,2500] remoteExec [""life_fnc_askBill"",life_pInact_curTarget];";
			text = "2500$"; //--- ToDo: Localize;
			x = 0.1125;
			y = 0.4;
			w = 0.175;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.509,0.121,0.5};
			class Attributes 
			{
				align = "center";
			};
		};
		class HelicoBillBoutton: Life_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0;[player,5000] remoteExec [""life_fnc_askBill"",life_pInact_curTarget];";
			text = "5000$"; //--- ToDo: Localize;
			x = 0.3375;
			y = 0.34;
			w = 0.175;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.509,0.121,0.5};
			class Attributes 
			{
				align = "center";
			};
		};
		class PlaneBillBoutton: Life_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0;[player,7500] remoteExec [""life_fnc_askBill"",life_pInact_curTarget];";

			text = "7500$"; //--- ToDo: Localize;
			x = 0.5375;
			y = 0.34;
			w = 0.175;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.509,0.121,0.5};
			class Attributes 
			{
				align = "center";
			};
		};
		class ShipBillBoutton: Life_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "closeDialog 0;[player,10000] remoteExec [""life_fnc_askBill"",life_pInact_curTarget];";

			text = "10000$"; //--- ToDo: Localize;
			x = 0.3375;
			y = 0.4;
			w = 0.175;
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
			y = 0.46;
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
