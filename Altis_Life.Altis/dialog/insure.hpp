class Life_insure_menu
{
	idd = 3900;
	name="life_insure_menu";
	movingEnable = 0;
	enableSimulation = 1;
	
	class controlsBackground
	{
		class Life_RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.0125;
			y = 0.22;
			w = 0.8375;
			h = 0.04;
		};
		
		class MainBackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.0125;
			y = 0.22;
			w = 0.8375;
			h = 0.62;
		};
		
		class Title : Life_RscTitle
		{
			idc = -1;
			text = "$STR_GUI_InsureMenu";
			x = 0.0125;
			y = 0.22;
			w = 0.8375;
			h = 0.04;
		};
		
		class VehicleTitleBox : Life_RscText
		{
			idc = -1;
			text = "$STR_GUI_YourInsure";
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			x = 0.0125;
			y = 0.28;
			w = 0.375;
			h = 0.04;
		};
		
		class VehicleInfoHeader : Life_RscText
		{
			idc = -1;
			text = "$STR_GUI_InsureInfo";
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			x = 0.4;
			y = 0.28;
			w = 0.45;
			h = 0.04;
		};
		
		class CloseBtn : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.0125;
			y = 0.8;
			w = 0.15625;
			h = 0.04;
		};
		
		class RentCar : Life_RscButtonMenu
		{
			idc = 3901;
			text = "$STR_vInAct_Insure";
			onButtonClick = "[] call life_fnc_InsureCar;";
			x = 0.225;
			y = 0.8;
			w = 0.15625;
			h = 0.04;
		};
	};
	
	class controls
	{
		class VehicleList : Life_RscListBox
		{
			idc = 3902;
			text = "";
			sizeEx = 0.04;
			colorBackground[] = {0.1,0.1,0.1,0.9};
			onLBSelChanged = "_this call life_fnc_insureLBChange;";
			x = 0.0125;
			y = 0.34;
			w = 0.375;
			h = 0.44;
		};
		
		class vehicleInfomationList : Life_RscStructuredText
		{
			idc = 3903;
			text = "";
			sizeEx = 0.035;
			x = 0.4;
			y = 0.34;
			w = 0.45;
			h = 0.44;
		};
	};
};
