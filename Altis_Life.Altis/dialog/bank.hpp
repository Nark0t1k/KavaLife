class Life_atm_management {
	idd = 2700;
	name= "life_atm_menu";
	movingEnable = 0;
	enableSimulation = 1;

	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0, 0.509 , 0.121,0.7};
			idc = -1;
			x = 0.35;
			y = 0.2;
			w = 0.3375;
			h = 0.04;
		};

		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.35;
			y = 0.24;
			w = 0.3375;
			h = 0.66;
		};
	};

	class controls {

		class CashTitle : Life_RscStructuredText {
			idc = 2701;
			text = "";
			x = 0.375;
			y = 0.26;
			w = 0.2875;
			h = 0.14;
		};

		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "$STR_ATM_Title";
			x = 0.35;
			y = 0.2;
			w = 0.3375;
			h = 0.04;
		};

		class WithdrawButton : life_RscButtonMenu {
			idc = -1;
			text = "$STR_ATM_Withdraw";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] call life_fnc_bankWithdraw";
			x = 0.3625;
			y = 0.48;
			w = 0.15;
			h = 0.04;
			class Attributes 
			{
				align = "center";
			};
		};

		class DepositButton : life_RscButtonMenu {
			idc = -1;
			text = "$STR_ATM_Deposit";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[false] call life_fnc_bankDeposit";
			x = 0.525;
			y = 0.48;
			w = 0.15;
			h = 0.04;
			class Attributes 
			{
				align = "center";
			};
		};
		
		class DepositAllButton : life_RscButtonMenu {
			idc = -1;
			text = "$STR_ATM_DepositAll";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[true] call life_fnc_bankDeposit;closeDialog 0;";
			x = 0.3625;
			y = 0.54;
			w = 0.3125;
			h = 0.04;
			class Attributes 
			{
				align = "center";
			};
		};

		class moneyEdit : Life_RscEdit {
			idc = 2702;
			text = "1";
			sizeEx = 0.030;
			x = 0.375;
			y = 0.42;
			w = 0.2875;
			h = 0.04;
		};

		class PlayerList : Life_RscCombo {
			idc = 2703;
			x = 0.3625;
			y = 0.6;
			w = 0.3125;
			h = 0.04;
		};

		class TransferButton : life_RscButtonMenu {
			idc = -1;
			text = "$STR_ATM_Transfer";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] call life_fnc_bankTransfer";
			x = 0.3625;
			y = 0.66;
			w = 0.3125;
			h = 0.04;
			class Attributes 
			{
				align = "center";
			};
		};

		class GangWithdraw : TransferButton {
			idc = 2705;
			text = "$STR_ATM_WithdrawGang";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] call life_fnc_gangWithdraw";
			x = 0.3625;
			y = 0.72;
			w = 0.3125;
			h = 0.04;
		};

		class GangDeposit : TransferButton {
			idc = 2706;
			text = "$STR_ATM_DepositGang";
			colorBackground[] = {0, 0.509 , 0.121,0.5};
			onButtonClick = "[] spawn life_fnc_gangDeposit";
			x = 0.3625;
			y = 0.78;
			w = 0.3125;
			h = 0.04;
		};
		
		class BuyVisa : TransferButton {
			idc = 2707;
			text = "$STR_ATM_BuyVisa";
			colorBackground[] = {0.584,0.086,0.086,1};
			onButtonClick = "[] spawn life_fnc_buyVisa";
			x = 0.3625;
			y = 0.84;
			w = 0.3125;
			h = 0.04;
		};

		class CloseButtonKey : Life_RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.35;
			y = 0.9;
			w = 0.15625;
			h = 0.04;
		};
	};
};
