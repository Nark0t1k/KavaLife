#include "..\..\..\script_macros.hpp"
/* Author: Maximum Description: Placeables for the cop\medic sides.Disclaimer: Don't be a asshole and pass this off as your own or become a KAI and sell it for profit, Im releasing this for FREE... Credits: Killerty69 for a second pare of eyes when mine got to sleepyP.S. - Don't be a faggot like i know some of you all will be.*/

life_barrier_active = false;
life_barrier_activeObj = ObjNull;
if(playerSide isEqualTo west)then
{
	life_placeables =[
		["Cone","RoadCone_F","textures\placeables\RoadCone_F.jpg"],
		["Cone avec lumiere","RoadCone_L_F","textures\placeables\RoadCone_L_F.jpg"],
		["Panneau Stop Gendarmerie","SignAd_SponsorS_F","textures\stopPolice.paa"],
		["Petit Barriere de securite","RoadBarrier_small_F","textures\placeables\RoadBarrier_small_F.jpg"],
		["Grande Barriere de securite","RoadBarrier_F","textures\placeables\RoadBarrier_F.jpg"],
		["Double Eclairage Chantier","Land_PortableLight_double_F","textures\placeables\Land_PortableLight_double_F.jpg"],
		["Chaisse Pliable","Land_CampingChair_V1_F","textures\placeables\Land_CampingChair_V1_F.jpg"],
		["Deviation Droite","ArrowDesk_R_F","textures\placeables\ArrowDesk_R_F.jpg"],
		["Deviation Gauche","ArrowDesk_L_F","textures\placeables\ArrowDesk_L_F.jpg"],
		
		["Petit Sac de sable","Land_BagFence_Short_F","textures\placeables\Land_BagFence_Short_F.jpg"],
		["Grand Sac de sable","Land_BagFence_Long_F","textures\placeables\Land_BagFence_Long_F.jpg"],
		["Sac de sable Rond","Land_BagFence_Round_F","textures\placeables\Land_BagFence_Round_F.jpg"],
		["Banderole de securite","TapeSign_F","textures\placeables\TapeSign_F.jpg"],
		["Lumiere Securite Bleu","PortableHelipadLight_01_blue_F","textures\placeables\PortableHelipadLight_01_blue_F.jpg"],
		["Panneau Avertissement Militaire","Land_Sign_WarningMilitaryArea_F","textures\placeables\Land_Sign_WarningMilitaryArea_F.jpg"]		
	];
	
	if(FETCH_CONST(life_coplevel) > 4)then
	{
		life_placeables pushBack ["Tour Surveillance Militaire","Land_Cargo_Patrol_V1_F","textures\placeables\Land_Cargo_Patrol_V1_F.jpg"];
	};
	
}else
{
	life_placeables =[
		["Cone","RoadCone_F","textures\placeables\RoadCone_F.jpg"],
		["Cone avec lumiere","RoadCone_L_F","textures\placeables\RoadCone_L_F.jpg"],
		["Petit Barriere de securite","RoadBarrier_small_F","textures\placeables\RoadBarrier_small_F.jpg"],
		["Grande Barriere de securite","RoadBarrier_F","textures\placeables\RoadBarrier_F.jpg"],
		["Double Eclairage Chantier","Land_PortableLight_double_F","textures\placeables\Land_PortableLight_double_F.jpg"],
		["Chaisse Pliable","Land_CampingChair_V1_F","textures\placeables\Land_CampingChair_V1_F.jpg"],
		["Deviation Droite","ArrowDesk_R_F","textures\placeables\ArrowDesk_R_F.jpg"],
		["Deviation Gauche","ArrowDesk_L_F","textures\placeables\ArrowDesk_L_F.jpg"]
	];
};
life_bar_limit = 25;
life_bar_placey = 0;


