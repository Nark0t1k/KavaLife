class FilterMenu
{
	idd = 9200;
	name = "FilterMenu";
	movingEnabled = 1;
	enableSimulation = 1;
	moving = 1;
	
	class controlsBackground
	{
		class RscMainBackground: Life_RscText
		{
			idc = -1;
			moving = 1;

			x = 1.2625;
			y = -0.2;
			w = 0.2625;
			h = 1.22;
			colorBackground[] = {0,0,0,0.7};
		};
		class Title: Life_RscText
		{
			idc = -1;
			moving = 1;

			text = "Legende (Touche L)"; //--- ToDo: Localize;
			x = 1.2625;
			y = -0.2;
			w = 0.2625;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};		
		class HeaderMission: Life_RscText
		{
			idc = -1;
			shadow = 0;
			moving = 1;

			text = "Afficher/Cacher Tout"; //--- ToDo: Localize;
			x = 1.275;
			y = -0.14;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
			sizeEx = 0.03;
		};
		class TitleShop: Title
		{
			idc = -1;
			moving = 1;

			text = "Disponible"; //--- ToDo: Localize;
			x = 1.2625;
			y = -0.08;
			w = 0.2625;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};

		class Text1: HeaderMission
		{
			idc = -1;
			shadow = 0;
			moving = 1;

			text = "Missions"; //--- ToDo: Localize;
			x = 1.275;
			y = -0.02;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text2: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Champs/Mines"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.04;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text3: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Usines"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.1;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text4: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Marchand Ressource"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.16;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text5: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Vehicules"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.22;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text6: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Rebelle"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.28;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text7: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Magasin"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.34;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text8: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Entreprise"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.4;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text9: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Service Publique"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.46;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text10: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Divers"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.52;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		/*class Text11: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Permis/Formations"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.58;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text12: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Base ArmÃ©e"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.64;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text13: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Service Public"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.7;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text14: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Illegal"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.76;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text15: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Mission Livraison"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.82;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
		class Text16: HeaderMission
		{
			idc = -1;
			moving = 1;

			text = "Mission Livraison"; //--- ToDo: Localize;
			x = 1.275;
			y = 0.88;
			w = 0.1875;
			h = 0.04;
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};*/
	};
	
	class controls
	{
		class MissionONOFF: Life_Checkbox
		{
			idc = 9250;
			onCheckedChanged = "[0,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = -0.14;
			w = 0.03;
			h = 0.04;
			tooltip = "Permet d'afficher ou de cacher tout les marqueurs"; //--- ToDo: Localize;
		};
		class marker1: MissionONOFF
		{
			idc = 9201;
			onCheckedChanged = "[1,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = -0.02;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les missions livraison"; //--- ToDo: Localize;
		};
		class marker2: MissionONOFF
		{
			idc = 9202;
			onCheckedChanged = "[2,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.04;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les champs et mines"; //--- ToDo: Localize;
		};
		class marker3: MissionONOFF
		{
			idc = 9203;
			onCheckedChanged = "[3,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.1;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les usines"; //--- ToDo: Localize;
		};
		class marker4: MissionONOFF
		{
			idc = 9204;
			onCheckedChanged = "[4,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.16;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les marchand de ressources"; //--- ToDo: Localize;
		};
		class marker5: MissionONOFF
		{
			idc = 9205;
			onCheckedChanged = "[5,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.22;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les vendeur et garage vehicules"; //--- ToDo: Localize;
		};
		class marker6: MissionONOFF
		{
			idc = 9206;
			onCheckedChanged = "[6,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.28;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les zones rebel"; //--- ToDo: Localize;
		};
		class marker7: MissionONOFF
		{
			idc = 9207;
			onCheckedChanged = "[7,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.34;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les magasins"; //--- ToDo: Localize;
		};
		class marker8: MissionONOFF
		{
			idc = 9208;
			onCheckedChanged = "[8,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.4;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiches les entreprises"; //--- ToDo: Localize;
		};
		class marker9: MissionONOFF
		{
			idc = 9209;
			onCheckedChanged = "[9,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.46;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les services publique"; //--- ToDo: Localize;
		};
		class marker10: MissionONOFF
		{
			idc = 9210;
			onCheckedChanged = "[10,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.52;
			w = 0.03;
			h = 0.04;
		};
		/*class marker11: MissionONOFF
		{
			idc = 9211;
			onCheckedChanged = "[11,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.58;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les vendeurs de permis/formation"; //--- ToDo: Localize;
		};
		class marker12: MissionONOFF
		{
			idc = 9212;
			onCheckedChanged = "[12,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.64;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les base armÃ©e et de gang"; //--- ToDo: Localize;
		};
		class marker13: MissionONOFF
		{
			idc = 9213;
			onCheckedChanged = "[13,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.7;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les different service public"; //--- ToDo: Localize;
		};
		class marker14: MissionONOFF
		{
			idc = 9214;
			onCheckedChanged = "[14,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.76;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les actions illegales"; //--- ToDo: Localize;
		};

		class marker15: MissionONOFF
		{
			idc = 9215;
			onCheckedChanged = "[15,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.82;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les NPC missions de livraison"; //--- ToDo: Localize;
		};
		class marker16: MissionONOFF
		{
			idc = 9216;
			onCheckedChanged = "[16,_this select 1] call life_fnc_s_onCheckedFilter;";

			x = 1.475;
			y = 0.88;
			w = 0.03;
			h = 0.04;
			tooltip = "Affiche les NPC missions de livraison"; //--- ToDo: Localize;
		};*/
		class CloseButtonKey: Life_RscButtonMenu
		{
			onButtonClick = "closeDialog 0;";

			idc = -1;
			text = "Fermer"; //--- ToDo: Localize;
			x = 1.3125;
			y = 0.96;
			w = 0.15;
			h = 0.04;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.035,0.415,0.035,0.7};
		};
	};
};