class playerSettings {

	idd = 2001;
	movingEnable = 1;
	enableSimulation = 1;
	
	class controlsBackground {
	
	class life_RscTitleBackground:life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class MainBackground:life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.8;
			h = 0.6 - (22 / 250);
		};
		
		class Title : life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_PM_Title";
			x = 0.1;
			y = 0.2;
			w = 0.8;
			h = (1 / 25);
		};
		
		class moneyStatusInfo : Life_RscStructuredText
		{
			idc = 2015;
			sizeEx = 0.020;
			text = "";
			x = 0.105;
			y = 0.30;
			w = 0.3; h = 0.6;
		};
		
		class PlayersName : Title {
			idc = 2009;
			style = 1;
			text = "";
		};
	};
	
	class controls {
		
		class itemHeader : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			text = "$STR_PM_cItems";
			sizeEx = 0.04;
			
			x = 0.62; y = 0.26;
			w = 0.275; h = 0.04;
		};
		
		class licenseHeader : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			text = "$STR_PM_Licenses";
			sizeEx = 0.04;
			
			x = 0.336; y = 0.26;
			w = 0.275; h = 0.04;
		};
		
		class moneySHeader : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			text = "$STR_PM_MoneyStats";
			sizeEx = 0.04;
			
			x = 0.11; y = 0.26;
			w = 0.219; h = 0.04;
		};
	
		class itemList : life_RscListBox 
		{
			idc = 2005;
			sizeEx = 0.030;
			
			x = 0.62; y = 0.30;
			w = 0.275; h = 0.3;
		};
							
		class itemEdit : Life_RscEdit {
		
		idc = 2010;
		
		text = "1";
		sizeEx = 0.030;
		x = 0.62; y = 0.61;
		w = 0.275; h = 0.03;
		
		};
				
		class UseButton : life_RscButtonMenu {
			
			text = "$STR_Global_Use";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_useItem;";
			
			x = 0.62;
			y = 0.70;
			w = (5.25 / 40);
			h = (1 / 25);
			
		};
		
		class RemoveButton : life_RscButtonMenu {
			
			text = "$STR_Global_Remove";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] call life_fnc_removeItem;";
			
			x = 0.475;
			y = 0.70;
			w = (5.25 / 40);
			h = (1 / 25);
			
		};
		
		class ButtonClose : life_RscButtonMenu {
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.1;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
		
		class ButtonSettings : life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Settings";
			onButtonClick = "[] call life_fnc_settingsMenu;";
			x = 0.2625;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
		
		class ButtonMyGang : Life_RscButtonMenu {
			idc = 2011;
			text = "$STR_PM_MyGang";
			onButtonClick = "if(isNil ""life_action_gangInUse"") then {if(isNil {player getVariable ""gang_name""}) then {hint ""Tu dois creer un gang via un QG."";} else {[] spawn life_fnc_gangMenu;};};";
			x = 0.425;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
		
		class Licenses_Menu : Life_RscControlsGroup
		{
			idc = -1;
			w = 0.28;
			h = 0.38;
			x = 0.34;
			y = 0.30;
			
			class Controls
			{
				class Life_Licenses : Life_RscStructuredText
				{
					idc = 2014;
					sizeEx = 0.020;
					text = "";
					x = 0;
					y = 0;
					w = 0.27; h = 0.65;
				};
			};
		};
		
		class ButtonInterpol : Life_RscButtonMenu {
			idc = 2012;
			text = "$STR_PM_WantedList";
			onButtonClick = "[] call life_fnc_wantedMenu";
			x = 0.425;
			y = 0.805;
			w = 0.15625;
			h = 0.04;
		};
	
		class ButtonKeys : Life_RscButtonMenu {
			idc = 2013;
			text = "$STR_PM_KeyChain";
			onButtonClick = "[false] spawn life_fnc_keyMenu;";
			x = 0.5875;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
		
		class ButtonCell : Life_RscButtonMenu {
			idc = 2014;
			text = "$STR_PM_CellPhone";
			onButtonClick = "[] call life_fnc_callCellPhone;";
			x = 0.75;
			y = 0.76;
			w = 0.15625;
			h = 0.04;
		};
		
		class ButtonAdminMenu : Life_RscButtonMenu {
			idc = 2021;
			text = "$STR_PM_AdminMenu";
			onButtonClick = "createDialog ""life_admin_menu"";";
			x = 0.2625;
			y = 0.805;
			w = 0.15625;
			h = 0.04;
		};
		class ButtonMarket : Life_RscButtonMenu {
			idc = -1;
			text = "Bourse";
			onButtonClick = "createDialog ""life_dynmarket_prices"";";
			x = 0.5875;
			y = 0.805;
			w = 0.15625;
			h = 0.04;
		};
		class ButtonFriend : Life_RscButtonMenu {
			idc = 2024;
			text = "Amis";
			onButtonClick = "createDialog ""Life_friendlist"";";
			x = 0.75;
			y = 0.805;
			w = 0.15625;
			h = 0.04;
		};
		class ButtonSyncData : life_RscButtonMenu {
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_PM_SyncData";
			onButtonClick = "[] call SOCK_fnc_syncData;";
			x = 0.10125;
			y = 0.805;
			w = 0.15625;
			h = 0.04;
		};
		class ButtonExtra1 : life_RscButtonMenu {
			idc = 2025;
			text = "Objet";
			onButtonClick = "[] spawn life_fnc_placeablesMenu; closeDialog 0;";
			x = 0.101263;
			y = 0.85;
			w = 0.15625;
			h = 0.04;
		};
		class ButtonExtra2 : life_RscButtonMenu {
			idc = 2026;
			text = "Groupe";
			onButtonClick = "[] call life_fnc_groupMenu";
			x = 0.2625;
			y = 0.85;
			w = 0.15625;
			h = 0.04;
		};
		class ButtonExtra3 : life_RscButtonMenu {
			idc = 2027;
			text = "RENFORT";
			onButtonClick = "[] spawn life_fnc_callCop;";
			colorBackground[] = {0,0,1,0.6};
			x = 0.425;
			y = 0.85;
			w = 0.15625;
			h = 0.04;
		};
		// class ButtonExtra4 : life_RscButtonMenu {
			// idc = 2028;
			// text = "Historique";
			// onButtonClick = "[life_KavaNotif] call life_fnc_loadHistory;";
			// x = 0.5875;
			// y = 0.85;
			// w = 0.15625;
			// h = 0.04;
		// };
		class ButtonExtra5 : life_RscButtonMenu {
			idc = 2029;
			text = "$STR_PM_ShowSkills";
			onButtonClick = "hint format[localize ""STR_ShowAll_Client"",life_skillGatherCount,life_skillProcessCount,life_skillRepairCount,life_skillLockCount];closeDialog 0;";
			x = 0.75;
			y = 0.85;
			w = 0.15625;
			h = 0.04;
		};
	};
};