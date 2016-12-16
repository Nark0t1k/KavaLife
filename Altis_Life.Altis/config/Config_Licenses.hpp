/*
*    class:
*        variable = Variable Name
*        displayName = License Name
*        price = License Price
*        illegal = Illegal License
*        side = side indicator
*/
class Licenses {
    //Civilian Licenses
    class identite {
        variable = "identite";
        displayName = "STR_License_Identite";
        price = 1000;
        illegal = false;
        side = "civ";
    };
	
    class driver {
        variable = "driver";
        displayName = "STR_License_Driver";
        price = 5000;
        illegal = false;
        side = "civ";
    };

    class boat {
        variable = "boat";
        displayName = "STR_License_Boat";
        price = 5000;
        illegal = false;
        side = "civ";
    };

    class pilot {
        variable = "pilot";
        displayName = "STR_License_Pilot";
        price = 50000;
        illegal = false;
        side = "civ";
    };

    class trucking {
        variable = "trucking";
        displayName = "STR_License_Truck";
        price = 30000;
        illegal = false;
        side = "civ";
    };

    class gun {
        variable = "gun";
        displayName = "STR_License_Firearm";
        price = 20000;
        illegal = false;
        side = "civ";
    };

    class dive {
        variable = "dive";
        displayName = "STR_License_Diving";
        price = 2000;
        illegal = false;
        side = "civ";
    };

    class home {
        variable = "home";
        displayName = "STR_License_Home";
        price = 100000;
        illegal = false;
        side = "civ";
    };

    class chasseur {
        variable = "chasseur";
        displayName = "STR_License_Chasseur";
        price = 200000000;
        illegal = false;
        side = "civ";
    };

	// Plan For Craft
    class offroadarmed {
        variable = "offroadarmed";
        displayName = "STR_Plan_Offroadarmed";
        price = 1000000;
        illegal = true;
        side = "civ";
    };
	
    class ifrit {
        variable = "ifrit";
        displayName = "STR_Plan_Ifrit";
        price = 750000;
        illegal = true;
        side = "civ";
    };
	
    class mohawk {
        variable = "mohawk";
        displayName = "STR_Plan_Mohawk";
        price = 1000000;
        illegal = true;
        side = "civ";
    };
    class hemttplan {
        variable = "hemttplan";
        displayName = "STR_Plan_Hemttplan";
        price = 1000000;
        illegal = false;
        side = "civ";
    };

    class tempest {
        variable = "tempest";
        displayName = "STR_Plan_Tempest";
        price = 1000000;
        illegal = false;
        side = "civ";
    };

    class hayonsport {
        variable = "hayonsport";
        displayName = "STR_Plan_HayonS";
        price = 500000;
        illegal = false;
        side = "civ";
    };


    //Cop Licenses
    class cAir {
        variable = "cAir";
        displayName = "STR_License_Pilot";
        price = 15000;
        illegal = false;
        side = "cop";
    };

    class cg {
        variable = "cg";
        displayName = "STR_License_CG";
        price = 8000;
        illegal = false;
        side = "cop";
    };
	
    class rebel {
        variable = "rebel";
        displayName = "STR_License_Rebel";
        price = 500000;
        illegal = true;
        side = "civ";
    };
	
    //Medic Licenses
    class mAir {
        variable = "mAir";
        displayName = "STR_License_Pilot";
        price = 15000;
        illegal = false;
        side = "med";
    };
};
