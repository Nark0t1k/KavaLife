/* Author: Maximum Description: Placeables for the cop\medic sides.
Disclaimer: Don't be a asshole and pass this off as your own or become a KAI and sell it for profit, Im releasing this for FREE... 
Credits: Killerty69 for a second pare of eyes when mine got to sleepy
P.S. - Don't be a faggot like i know some of you all will be.*/

disableSerialization;
if (!life_barrier_active) exitWith {};
if (life_barrier_activeObj isEqualTo ObjNull) exitWith {};
_currentPos = getPosATL life_barrier_activeObj;
detach life_barrier_activeObj;
life_barrier_activeObj setPos[(getPos life_barrier_activeObj select 0), (getPos life_barrier_activeObj select 1), 0];
life_barrier_activeObj enableSimulationGlobal true;
_uid = getPlayerUID player;
life_bar_placey = life_bar_placey + 1;
life_barrier_active = false;
diag_log format["KAVALOG PLACEITEM ITEM: %1 TYPEOF: %2", life_barrier_activeObj, typeof life_barrier_activeObj];
if((typeOf life_barrier_activeObj) isEqualTo "SignAd_SponsorS_F")then
{
	life_barrier_activeObj setObjectTextureGlobal [0,"textures\stopPolice.paa"];
};
life_barrier_activeObj = ObjNull;
