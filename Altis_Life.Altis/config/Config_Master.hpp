#define true 1
#define false 0

/*
    Master settings for various features and functionality
*/
class Life_Settings {

/* Database Related Settings */

    /* Vehicle Data Saving */
    save_vehicle_virtualItems = false; //Save virtual items inside the vehicle (all sides)(-- See defined items on next line --)
    save_vehicle_items[] = { "pickaxe","fuelEmpty","fuelFull", "spikeStrip", "lockpick", "defuseKit","storageSmall","storageBig","redgull","coffee","waterBottle","apple","peach","tbacon","donuts","rabbit","salema","ornate","mackerel","tuna","mullet","catshark","turtle_soup","hen","rooster","goat","truckWheel" };
    save_vehicle_illegal = false; //This will allow cops to be advised when a vehicle, with illegal items in it, is impounded. This will also save illegal items as proof of crime, and needs "save_vehicle_virtualItems" set as true. Illegal items don't need to be set in save_vehicle_items[] for being saved, if it's enabled.

    noatm_timer = 10; //Time in minutes that players cannot deposit money after selling stolen gold.

	 cops_online_min = 5;
    /* Basic System Configurations */
    total_maxWeight = 30; //Static variable for the maximum weight allowed without having a backpack

	paycheck_period = 10; //Scaled in minutes
	
	gang_price = 1000000;
	
	
    /* Fuel Station & Heli Service settings */
    fuel_cost = 25; //Cost of fuel per liter at fuel stations (if not defined for the vehicle already).
  
    /* Skins settings */
    civ_skins = false; //Enable or disable civilian skins. Before enabling, you must add all the SEVEN files to textures folder. (It must be named as: civilian_uniform_1.jpg, civilian_uniform_2.jpg...civilian_uniform_6.jpg, civilian_uniform_7.jpg)

    /* Vehicle Settings */
    vehicleShop_rentalOnly[] = { "B_MRAP_01_hmg_F", "B_G_Offroad_01_armed_F", "B_Boat_Armed_01_minigun_F","B_Heli_Transport_01_F" };
    vehicleShop_BuyMultiplicator = 6;
    vehicleGarage_SellMultiplicator = 2;
    vehicleGarage_InsureMultiplicator = 2;
    vehicleGarage_StorFeeMultiplicator = 0.2;
    vehicleChopShop_Multiplicator = 1.5;

    /* Job-related stuff */
    delivery_points[] = { "dp_1", "dp_2", "dp_3", "dp_4", "dp_5", "dp_6", "dp_7", "dp_8", "dp_9", "dp_10", "dp_11", "dp_12", "dp_13", "dp_14", "dp_15", "dp_15", "dp_16", "dp_17", "dp_18", "dp_19", "dp_20", "dp_21", "dp_22", "dp_23", "dp_24", "dp_25" };

    /* FuelTank Mission */
    FuelTank_WinMultiplier = 1; //Win Multiplier in FuelTank Missions. Increase for more Money! Default = 1

    /* Animal settings */
    animaltypes_fish[] = { "Salema_F", "Ornate_random_F", "Mackerel_F", "Tuna_F", "Mullet_F", "CatShark_F", "Turtle_F" };

    /* Wanted System Settings *
    /* crimes[] = {String, Bounty, Code} */
    crimes[] = {
        {"Meurtre avec un vehicule","75000","187V"},
        {"Meurtre","50000","187"},
        {"Evasion de Prison","75000","901"},
        {"Tentative de vol de véhicule","1500","215"},
        {"Utilisation d'explosif","50000","213"},
        {"Braquage","15000","211"},
        {"Kidnapping","50000","207"},
        {"Tentative de Kidnapping","25000","207A"},
        {"Intoxication publique","5000","390"},
        {"Vol de véhicule","25000","487"},
        {"Tentative de vol","10000","488"},
        {"Vol a l'araché","15000","480"},
        {"Possesion de drogue","25000","481"},
        {"Intention de revente","50000","482"},
        {"Trafique de drogues","50000","483"},
        {"Cambriolage","25000","459"},
        {"Hack Station Radio","25000","460"},
        {"Evasion Fiscal","100000","666"},
        {"Terrorisme","150000","667"},
        {"Chasse sans permis","5000","668"},
        {"Absence du permis de conduire","5000","1"},
        {"Conduite sur le mauvais côté de la route","5000","2"},
        {"Non respect des signalisations","10000","3"},
        {"Excès de vitesse 0-25km","5000","4"},
        {"Excès de vitesse 25-50km","15000","4b"},
        {"Excès de vitesse 50km et +","30000","4c"},
        {"Absence de phare la nuit","5000","5"},
        {"Non-port du casque en Kart","5000","6"},
        {"Véhicule mal garé","5000","7"},
        {"Véhicule rebel non armé","15000","8"},
        {"Vol de véhicule civil (Voiture)","25000","9"},
        {"Vol de véhicule civil (Camion)","50000","9b"},
        {"Vol de véhicule civil (Helico)","75000","9c"},
        {"Vol de véhicule de Police","50000","10"},
        {"Véhicules blindés","45000","11"},
        {"Survol de ville sans autorisation","5000","12"},
        {"Interdiction de se poser sans autorisation","5000","13"},
        {"Arme légale visible en ville","5000","14"},
        {"Armes rebelles","25000","15"},
        {"Vêtements illégaux","10000","16"},
        {"Cacher son visage","5000","17"},
        {"Refus d'obtempérer","5000","18"},
        {"Délit de fuite","15000","19"},
        {"Insulte envers un civil","5000","20"},
        {"Insulte envers un Policier","10000","21"},
        {"Trafique de drogue","50000","22"},
        {"Intrusion dans le coffre de la banque","100000","23"},
        {"Meurtre d'un civil","50000","24"},
        {"Meurtre d'un Policier","100000","25"}
    };
};

#include "Config_Clothing.hpp"
#include "Config_Licenses.hpp"
#include "Config_Vehicles.hpp"
#include "Config_vItems.hpp"
#include "Config_Weapons.hpp"
#include "Config_Gather.hpp"
#include "Config_Amende.hpp"
