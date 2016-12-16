class TrunkMenu
{
	idd = 3500;
	name = "TrunkMenu";
	movingEnable = false;
	enableSimulation = true;
	
	class controlsBackground
	{
		class RscTitleBackground : Life_RscText
		{
			colorBackground[] = {0, 0.603, 0,1.0};
			idc = -1;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscBackground : Life_RscText
		{
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.324688 * safezoneW + safezoneX;
			y = 0.3196 * safezoneH + safezoneY;
			w = 0.309375 * safezoneW;
			h = 0.396 * safezoneH;
		};
		
		class RscTitleText : Life_RscTitle
		{
			colorBackground[] = {0, 0, 0, 0};
			idc = 3501;
			text = "";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class VehicleWeight : RscTitleText
		{
			idc = 3504;
			style = 1;
			text = "";
			x = 0.335025 * safezoneW + safezoneX;
			y = 0.335046 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class PlayerWeight: RscTitleText
		{		
			idc = 3507;
			style = 1;
			text = "";
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscTrunkText : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0, 0.603, 0,0.5};
			text = "$STR_Trunk_TInventory";
			sizeEx = 0.04;
			
			x = 0.335 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscPlayerText : Life_RscText
		{
			idc = -1;
			colorBackground[] = {0, 0.603, 0,0.5};
			text = "$STR_Trunk_PInventory";
			sizeEx = 0.04;
			
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};	
	};
	
	class Controls
	{
		class TrunkGear : Life_RscListBox
		{
			idc = 3502;
			text = "";
			sizeEx = 0.030;
			
			x = 0.335 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.253 * safezoneH;
		};
		
		class PlayerGear : Life_RscListBox
		{
			idc = 3503;
			text = "";
			sizeEx = 0.030;
			
			x = 0.486078 * safezoneW + safezoneX;
			y = 0.36712 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.253 * safezoneH;
		};
		
		class TrunkEdit : Life_RscEdit
		{
			idc = 3505;
			text = "1";
			sizeEx = 0.030;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class PlayerEdit : Life_RscEdit
		{
			idc = 3506;
			text = "1";
			sizeEx = 0.030;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class TakeItem : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Trunk_Take";
			colorBackground[] = {0, 0.603, 0,0.5};
			onButtonClick = "[true,0] call life_fnc_vehTakeMultiItem;";
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class StoreItem : Life_RscButtonMenu
		{
			idc = -1;
			text = "$STR_Trunk_Store";
			colorBackground[] = {0, 0.603, 0,0.5};
			onButtonClick = "[true,0] call life_fnc_vehStoreMultiItem;";
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class ButtonClose : Life_RscButtonMenu {
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.335 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0644531 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TakeItem1: Life_RscButtonMenu
		{
			onButtonClick = "[false,1] call life_fnc_vehTakeMultiItem;";

			idc = -1;
			text = "1"; //--- ToDo: Localize;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0154689 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
		class TakeItem5: Life_RscButtonMenu
		{
			onButtonClick = "[false,5] call life_fnc_vehTakeMultiItem;";

			idc = -1;
			text = "5"; //--- ToDo: Localize;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0154689 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
		class TakeItem10: Life_RscButtonMenu
		{
			onButtonClick = "[false,10] call life_fnc_vehTakeMultiItem;";

			idc = -1;
			text = "10"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0154689 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
		class TakeItemAll: Life_RscButtonMenu
		{
			onButtonClick = "[false,0] call life_fnc_vehTakeMultiItem;";

			idc = -1;
			text = "MAX"; //--- ToDo: Localize;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
		class StoreItem1: Life_RscButtonMenu
		{
			onButtonClick = "[false,1] call life_fnc_vehStoreMultiItem;";

			idc = -1;
			text = "1"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0154689 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
		class StoreItem5: Life_RscButtonMenu
		{
			onButtonClick = "[false,5] call life_fnc_vehStoreMultiItem;";

			idc = -1;
			text = "5"; //--- ToDo: Localize;
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0154689 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
		class StoreItem10: Life_RscButtonMenu
		{
			onButtonClick = "[false,10] call life_fnc_vehStoreMultiItem;";

			idc = -1;
			text = "10"; //--- ToDo: Localize;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0154689 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
		class StoreItemAll: Life_RscButtonMenu
		{
			onButtonClick = "[false,0] call life_fnc_vehStoreMultiItem;";

			idc = -1;
			text = "MAX"; //--- ToDo: Localize;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0.603,0,0.5};
		};
	};
};