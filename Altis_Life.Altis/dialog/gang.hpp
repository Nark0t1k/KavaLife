class Life_My_Gang_Diag {
	idd = 2620;
	name= "life_my_gang_menu";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = 0.04;
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.24;
			w = 0.6;
			h = 0.52;
		};
	};
	
	class controls {

		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2629;
			text = "";
			x = 0.1;
			y = 0.2;
			w = 0.6;
			h = 0.04;
		};
		
		class GangMemberList : Life_RscListBox 
		{
			idc = 2621;
			text = "";
			sizeEx = 0.035;
			// onLBSelChanged = "[_this] call life_fnc_gangFilter";
			x = 0.1;
			y = 0.33;
			w = 0.375;
			h = 0.42;
		};

		class CloseLoadMenu : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;[] call life_fnc_p_updateMenu";
			x = 0.1;
			y = 0.76;
			w = 0.1625;
			h = 0.04;
		};
		
		class GangLeave : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Gang_Leave";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] call life_fnc_gangLeave";
			x = 0.475;
			y = 0.7;
			w = 0.225;
			h = 0.04;
		};
		
		class GangLock : Life_RscButtonMenu 
		{
			idc = 2622;
			text = "$STR_Gang_RecrutNew";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_gangNewRecrut";
			x = 0.475;
			y = 0.4;
			w = 0.225;
			h = 0.04;
		};
		
		class GangKick : Life_RscButtonMenu 
		{
			idc = 2624;
			text = "$STR_Gang_Kick";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] call life_fnc_gangKick";
			x = 0.475;
			y = 0.46;
			w = 0.225;
			h = 0.04;
		};
		
		class GangLeader : Life_RscButtonMenu 
		{
			idc = 2625;
			text = "$STR_Gang_SetLeader";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_gangNewLeader";
			x = 0.475;
			y = 0.34;
			w = 0.225;
			h = 0.04;
		};
		
		class InviteMember : GangLeader
		{
			idc = 2630;
			text = "$STR_Gang_Invite_Player";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_gangInvitePlayer";
			x = 0.475;
			y = 0.64;
			w = 0.225;
			h = 0.04;
		};
		
		class DisbandGang : InviteMember
		{
			idc = 2631;
			text = "$STR_Gang_Disband_Gang";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_gangDisband";
			x = 0.475;
			y = 0.52;
			w = 0.225;
			h = 0.04;
		};
		
		class ColorList : Life_RscCombo
		{
			idc = 2632;
			x = 0.475;
			y = 0.6;
			w = 0.225;
			h = 0.03;
		};
		
		class GangBank : Life_RscStructuredText {
			idc = 601;
			style = 1;
			text = "";
			x = 0.1;
			y = 0.26;
			w = 0.275;
			h = 0.04;
			class Attributes 
			{
				align = "left";
			};
		};
		
		class GangHonor : Life_RscStructuredText {
			idc = 602;
			style = 1;
			text = "";
			x = 0.425;
			y = 0.26;
			w = 0.275;
			h = 0.04;
			class Attributes 
			{
				align = "left";
			};
		};
	};
};

class Life_Create_Gang_Diag {
	idd = 2520;
	name= "life_my_gang_menu_create";
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "[] spawn {waitUntil {!isNull (findDisplay 2520)}; ((findDisplay 2520) displayCtrl 2523) ctrlSetText format[localize ""STR_Gang_PriceTxt"",[(getNumber(missionConfigFile >> 'Life_Settings' >> 'gang_price'))] call life_fnc_numberText]};";
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.1;
			y = 0.2;
			w = 0.5;
			h = (1 / 25);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.1;
			y = 0.2 + (11 / 250);
			w = 0.5;
			h = 0.3 - (22 / 250);
		};
	};
	
	class controls {
	
		class InfoMsg : Life_RscStructuredText
		{
			idc = 2523;
			sizeEx = 0.020;
			text = "";
			x = 0.1;
			y = 0.25;
			w = 0.5; h = .11;
		};
		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_Gang_Title";
			x = 0.1;
			y = 0.2;
			w = 0.5;
			h = (1 / 25);
		};

		class CloseLoadMenu : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;[] call life_fnc_p_updateMenu;";
			x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.5 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class GangCreateField : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Gang_Create";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] call life_fnc_createGang";
			x = 0.27;
			y = 0.40;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class CreateGangText : Life_RscEdit
		{
			idc = 2522;
			text = "$STR_Gang_YGN";
			
			x = 0.04 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
			y = 0.35;
			w = (13 / 40);
			h = (1 / 25);
		};
	};
};

class Life_start_war {
	idd = 3350;
	name = "life_start_war";
	movingEnable = 0;
	enableSimulation = 1;
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.2;
			y = 0.12;
			w = 0.6;
			h = 0.04;
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.2;
			y = 0.16;
			w = 0.6;
			h = 0.32;
		};
	};
	
	class controls 
	{
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "";
			x = 0.2;
			y = 0.12;
			w = 0.6;
			h = 0.04;
		};
		class HeaderWarAmount : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_War_headerAmount";
			x = 0.2;
			y = 0.28;
			w = 0.3;
			h = 0.04;
		};
		class HeaderWarText1 : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_War_header1";
			x = 0.2;
			y = 0.2;
			w = 0.6;
			h = 0.04;
		};
		class HeaderWarText2 : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_War_header2";
			x = 0.2;
			y = 0.36;
			w = 0.6;
			h = 0.04;
		};
		
		class warAmoutEdit : Life_RscEdit 
		{
			idc = 3351;
			
			text = "0";
			sizeEx = 0.030;
			x = 0.5375;
			y = 0.28;
			w = 0.2625;
			h = 0.04;
		};

		class buttonWar: Life_RscButtonMenu {
			idc = -1;
			text = "$STR_War_StartButton";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[life_pInact_curTarget] call life_fnc_startWar";
			x = 0.575;
			y = 0.44;
			w = 0.225;
			h = 0.04;
		};

		class buttonCancel: Life_RscButtonMenu {
			idc = -1;
			text = "Annuler";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "closeDialog 0;";
			x = 0.2;
			y = 0.44;
			w = 0.15625;
			h = 0.04;
		};
	};
};