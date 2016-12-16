class Life_impound_menu
{
	idd = 2800;
	name="life_vehicle_shop";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "ctrlShow [2330,false];";
	
	class controlsBackground
	{
		class Life_RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1;
			y = 0.1;
			w = 0.8;
			h = 0.04;
		};
		
		class MainBackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.1;
			y = 0.136;
			w = 0.8;
			h = 0.78;
		};
		
		class Title : Life_RscTitle
		{
			idc = 2801;
			text = "$STR_GUI_Garage";
			x = 0.1;
			y = 0.1;
			w = 0.8;
			h = 0.04;
		};
		
		class VehicleTitleBox : Life_RscText
		{
			idc = -1;
			text = "$STR_GUI_YourVeh";
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			x = 0.1125;
			y = 0.16;
			w = 0.3;
			h = 0.04;
		};
		
		class VehicleInfoHeader : Life_RscText
		{
			idc = 2830;
			text = "$STR_GUI_VehInfo";
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			x = 0.425;
			y = 0.16;
			w = 0.46;
			h = 0.04;
		};
		
		class CloseBtn : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
		};
		
		class RentCar : Life_RscButtonMenu
		{
			idc = 2804;
			text = "$STR_Global_Retrieve";
			onButtonClick = "[] call life_fnc_unimpound;";
			x = 0.2625;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
		};
		
		class GetBackCar : Life_RscButtonMenu
		{
			idc = 2806;
			text = "$STR_Global_GetBack";
			onButtonClick = "[] call life_fnc_restoreVeh;";
			x = 0.2625;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
		};
		
		class BuyCar : life_RscButtonMenu 
		{
			idc = 2805;
			text = "$STR_Global_Sell";
			onButtonClick = "[] call life_fnc_sellGarage; closeDialog 0;";
			x = 0.425;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
		};
		
		class SellHVCar : life_RscButtonMenu 
		{
			idc = 2807;
			text = "$STR_Global_SellHV";
			onButtonClick = "if(lbCurSel 2802 isEqualTo -1)exitWith {hint localize ""STR_Global_NoSelection"";};life_vSellHV = [lbData[2802,(lbCurSel 2802)],lbValue[2802,(lbCurSel 2802)]];closeDialog 0; createDialog ""Life_sellveh_hv"";";
			x = 0.6875;
			y = 0.92;
			w = 0.2125;
			h = 0.04;
		};
	};
	
	class controls
	{
		class VehicleList : Life_RscListBox
		{
			idc = 2802;
			text = "";
			sizeEx = 0.04;
			colorBackground[] = {0.1,0.1,0.1,0.9};
			onLBSelChanged = "_this call life_fnc_garageLBChange;";
			x = 0.11;
			y = 0.212;
			w = 0.3;
			h = 0.7;
		};
		
		class vehicleInfomationList : Life_RscStructuredText
		{
			idc = 2803;
			text = "";
			sizeEx = 0.035;
			x = 0.435;
			y = 0.22;
			w = 0.45;
			h = 0.68;
		};
		
		class MainBackgroundHider : Life_RscText
		{
			colorBackground[] = {0,0,0,1};
			idc = 2810;
			x = 0.1;
			y = 0.14;
			w = 0.8;
			h = 0.78;
		};
		
		class MainHideText : Life_RscText
		{
			idc = 2811;
			text = "$STR_ANOTF_QueryGarage";
			sizeEx = 0.06;
			x = 0.24;
			y = 0.5;
			w = 0.6;
			h = 0.0666667;
		};
	};
};

class Life_sellveh_hv
{
	idd = 2750;
	name = "Life_sellveh_hv";
	movingEnable = 0;
	enableSimulation = 1;
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};
	
	class controls 
	{
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2751;
			text = "$STR_HV_ButSellVeh";
			x = 0.3;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class moneyEdit : Life_RscEdit 
		{
			idc = 2752;
			
			text = "100";
			sizeEx = 0.030;
			x = 0.40; y = 0.30;
			w = 0.25; h = 0.03;
		};

		class sellVehBtn: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_HV_ButSellVeh";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_sellGarageHV";
			x = 0.45;
			y = 0.35;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};

class Life_HV_Vehicle
{
	idd = 4200;
	name="Life_HV_Vehicle";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "ctrlShow [4206,false];";
	
	class controlsBackground
	{
		class Life_RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1;
			y = 0.1;
			w = 0.8;
			h = 0.04;
		};
		
		class MainBackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.1;
			y = 0.136;
			w = 0.8;
			h = 0.78;
		};
		
		class Title : Life_RscTitle
		{
			idc = -1;
			text = "$STR_GUI_GarageHV";
			x = 0.1;
			y = 0.1;
			w = 0.8;
			h = 0.04;
		};
		
		class VehicleTitleBox : Life_RscText
		{
			idc = -1;
			text = "$STR_GUI_HVVeh";
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			x = 0.1125;
			y = 0.16;
			w = 0.3;
			h = 0.04;
		};
		
		class VehicleInfoHeader : Life_RscText
		{
			idc = -1;
			text = "$STR_GUI_VehInfo";
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			x = 0.425;
			y = 0.16;
			w = 0.46;
			h = 0.04;
		};
		
		class CloseBtn : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
		};
		
		class RentCar : Life_RscButtonMenu
		{
			idc = 4201;
			text = "$STR_Global_Buy";
			onButtonClick = "[true] call life_fnc_buyVehHV;";
			x = 0.2625;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
		};
		
		class GetBackCar : Life_RscButtonMenu
		{
			idc = 4206;
			text = "$STR_Global_Retrieve";
			onButtonClick = "[false] call life_fnc_buyVehHV;";
			x = 0.2625;
			y = 0.92;
			w = 0.15625;
			h = 0.04;
		};
	};
	
	class controls
	{
		class VehicleList : Life_RscListBox
		{
			idc = 4202;
			text = "";
			sizeEx = 0.04;
			colorBackground[] = {0.1,0.1,0.1,0.9};
			onLBSelChanged = "_this call life_fnc_HVLBChange;";
			x = 0.11;
			y = 0.212;
			w = 0.3;
			h = 0.7;
		};
		
		class vehicleInfomationList : Life_RscStructuredText
		{
			idc = 4203;
			text = "";
			sizeEx = 0.035;
			x = 0.435;
			y = 0.22;
			w = 0.45;
			h = 0.68;
		};
		
		class MainBackgroundHider : Life_RscText
		{
			colorBackground[] = {0,0,0,1};
			idc = 4205;
			x = 0.1;
			y = 0.14;
			w = 0.8;
			h = 0.78;
		};
		
		class MainHideText : Life_RscText
		{
			idc = 4204;
			text = "$STR_ANOTF_QueryHV";
			sizeEx = 0.06;
			x = 0.24;
			y = 0.5;
			w = 0.6;
			h = 0.0666667;
		};
	};
};