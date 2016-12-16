class LicenseShop {
	idd = 5546;
	name= "life_license_shop";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable [""LicenseShop"", _this select 0];";
	objects[] = { };
	class controls {
			 
		class RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.5686, 0.1529, 0.7};
			idc = -1;
			text = "Menu Achat Permis/Formation"; //--- ToDo: Localize;
			x = 0.0499999;
			y = 0.2;
			w = 0.825;
			h = 0.04;
		};
		 
		class Mainbackground : Life_RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = -1;
			x = 0.0499999;
			y = 0.244;
			w = 0.825;
			h = 0.52;
		};
		class listbox: Life_RscListBox
		{
			idc = 55126;
			sizeEx = 0.04;
			x = 0.0625;
			y = 0.3;
			w = 0.45;
			h = 0.4;
		};
		class ShowLicenseslistbox: Life_RscListBox
		{
			idc = 55131;
			sizeEx = 0.04;
			x = 0.5375;
			y = 0.3;
			w = 0.325;
			h = 0.44;
		};
		class MyLicenses : Life_RscText
		{
			idc = 55130;
			text = "Disponible "; //--- ToDo: Localize;
			x = 0.2125;
			y = 0.24;
			w = 0.1375;
			h = 0.04;
		};
		class ShowLicenses : Life_RscText
		{
			idc = 55129;
			text = "Mes Formation"; //--- ToDo: Localize;
			x = 0.625;
			y = 0.24;
			w = 0.1625;
			h = 0.04;
		};
		class buybutton: Life_RscButtonMenu
		{
			idc = 55127;
			text = "$STR_Global_Buy";
			x = 0.2;
			y = 0.72;
			w = 0.15;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.8};
			action = "if( (lbData[55126,lbCurSel (55126)] != """") ) then { [false, false, false, lbData[55126,lbCurSel (55126)]] call life_fnc_buyLicense; closeDialog 0; };";
		};
	};
};