/* Author: Maximum Description: Placeables for the cop\medic sides.Disclaimer: Don't be a asshole and pass this off as your own or become a KAI and sell it for profit, Im releasing this for FREE... Credits: Killerty69 for a second pare of eyes when mine got to sleepyP.S. - Don't be a faggot like i know some of you all will be.*/


private["_itemList"];

_itemList = nearestObjects [player, ["RoadCone_F","RoadCone_L_F","RoadBarrier_small_F","RoadBarrier_F","Land_PortableLight_double_F","SignAd_SponsorS_F","Land_CampingChair_V1_F","PlasticBarrier_02_yellow_F","ArrowDesk_R_F","ArrowDesk_L_F","Land_BagFence_Short_F","Land_BagFence_Long_F","Land_BagFence_Round_F","TapeSign_F","PortableHelipadLight_01_blue_F","Land_Sign_WarningMilitaryArea_F","Land_Cargo_Patrol_V1_F"], 10];
life_bar_placey = life_bar_placey - (count _itemList);
if(life_bar_placey < 0)then{life_bar_placey = 0};
{
	deleteVehicle _x;
}foreach _itemList;