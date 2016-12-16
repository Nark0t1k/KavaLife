class Socket_Reciever
{
	tag = "SOCK";
	class SQL_Socket
	{
		file = "core\session";
		class requestReceived {};
		class dataQuery {};
		class insertPlayerInfo {};
		class updateRequest {};
		class syncData {};
		class updatePartial {};
	};
};

class Life_Client_Core
{
	tag = "life";

	class Master_Directory
	{
		file = "core";
		class setupActions {};
		class setupEVH {};
		class initCiv {};
		class initCop {};
		class initMedic {};
		class welcomeNotification {};
		class survival {};
	};

	class Admin
	{
		file = "core\admin";
		class admininfo {};
		class adminid {};
		class admingetID {};
		class adminMenu {};
		class adminQuery {};
		class adminSpectate {};
		class adminTeleport {};
		class adminTpHere {};
		class adminDebugCon {};
		class adminCompensate {};
		class adminGodMode {};
		class adminFreeze {};
		class adminMarkers {};
		class adminSleep {};
		class adminESP {};
	};

	class Medical_System
	{
		file = "core\medical";
		class onPlayerKilled {};
		class onPlayerRespawn {};
		class respawned {};
		class revivePlayer {};
		class revived {};
		class medicMarkers {};
		class requestMedic {};
		class medicRequest {};
		class deathScreen {};
		class medicLoadout {};
		class medicSirenLights {};
		class medicLights {};
		class mecanoLights {};
		class medicSiren {};
	};

	class Actions
	{
		file = "core\actions";
		class buyLicense {};
		class healHospital {};
		class pushVehicle {};
		class repairTruck {};
		class serviceChopper {};
		class catchFish {};
		class dpFinish {};
		class dropFishingNet {};
		class getDPMission {};
		class postBail {};
		class processAction {};
		class processActionJail {};
		class processActionWhiteList {};
		class arrestAction {};
		class arrestTrollAction {};
		class escortAction {};
		class impoundAction {};
		class impoundPoliceAction {};
		class pulloutAction {};
		class putInCar {};
		class stopEscorting {};
		class restrainAction {};
		class restrainActionCiv {};
		class searchAction {};
		class searchVehAction {};
		class unrestrain {};
		class unrestrainCiv {};
		class surrender {};
		class pickupItem {};
		class pickupMoney {};
		class ticketAction {};
		class packupSpikes {};
		class storeVehicle {};
		class robAction {};
		class captureHideout {};
		class captureHideoutCustom {};
		class gather {};
		class gatherWater {};
		class removeContainer {};
		class showIdentity {};
		class friendInvitePlayer {};
		class friendAnswerPlayer {};
		class buyWantedIndice {};
		class pumpRepair {};
		class fixBloodPack {};
		class activeIllegalBox {};
		class craftAction {};
		class newsBroadcast {};
		class hackRadio {};
		class reponseIndep {};
		class buyVisa {};
		class supplyRequest {};
		class gatherMeca {};
		class craftVeh {};
		class processMeca {};
		class processCargoNet {};
		class sitdown {};
		class standup {};
		class tazeRagdoll {};
	};

	class Housing
	{
		file = "core\housing";
		class buyHouse {};
		class getBuildingPositions {};
		class houseMenu {};
		class lightHouse {};
		class lightHouseAction {};
		class sellHouse {};
		class initHouses {};
		class copBreakDoor {};
		class raidHouse {};
		class lockupHouse {};
		class copHouseOwner {};
		class lockHouse {};
		class garageRefund {};
		class placeContainer {};
		class PlayerInBuilding {};
		class containerMenu {};
		class rentHouse {};
		class showrentHouse {};
		class buyAlarm {};
	};

	class Config
	{
		file = "core\config";
		class itemWeight {};
		class vehicleAnimate {};
		class vehicleWeightCfg {};
		class houseConfig {};
		class craftCfg {};
	};
	
	class vAH
    {
        file = "core\vAH";
        class vAH_load;
        class vAH_buy;
        class vAH_reciever;
        class vAH_loadInventory;
        class vAH_loadVehicle;
        class vAH_sell;
        class vAH_sellVeh;
        class vAH_checkItem;
        class vAH_takeBack;
        class vAH_select;
    };

	class Player_Menu
	{
		file = "core\pmenu";
		class wantedList {};
		class wantedInfo {};
		class wantedMenu {};
		class wantedMenuChasseur {};
		class pardon {};
		class giveItem {};
		class giveMoney {};
		class p_openMenu {};
		class p_updateMenu {};
		class removeItem {};
		class useItem {};
		class keyMenu {};
		class keyGive {};
		class keyDrop {};
		class s_onSliderChange {};
		class updateViewDistance {};
		class settingsMenu {};
		class s_onChar {};
		class s_onCheckedChange {};
		class wantedAddP {};
		class altisPhone {};
		class friendMenu {};
		class askFriend {};
		class giveMenu {};
		class moneyMenu {};
		class craft {};
		class craft_updateFilter {};
		class craft_update {};
	};

	class Functions
	{
		file = "core\functions";
		class calWeightDiff {};
		class fetchCfgDetails {};
		class handleInv {};
		class hudSetup {};
		class hudHealthSetup {};
		class hudVehHealthSetup {};
		class hudUpdate {};
		class hudHealthUpdate {};
		class hudVehHealthUpdate {};
		class tazeSound {};
		class animSync {};
		class simDisable {};
		class keyHandler {};
		class keyUpHandler {};
		class dropItems {};
		class handleDamage {};
		class numberText {};
		class handleItem {};
		class accType {};
		class receiveItem {};
		class giveDiff {};
		class receiveMoney {};
		class playerTags {};
		class clearVehicleAmmo {};
		class pullOutVeh {};
		class nearUnits {};
		class actionKeyHandler {};
		class playerCount {};
		class fetchDeadGear {};
		class loadDeadGear {};
		class isnumeric {};
		class escInterupt {};
		class onTakeItem {};
		class fetchVehInfo {};
		class pushObject {};
		class onFired {};
		class nearestDoor {};
		class inventoryClosed {};
		class inventoryOpened {};
		class isUIDActive {};
		class saveGear {};
		class loadGear {};
		class stripDownPlayer {};
		class nearATM {};
		class nearOBJ {};
		class playerSkins {};
		class nearestObjects {};
		class teleport {};
		class searchPosEmpty {};
		class hideObj {};
		class personalMarkers {};
		class skillKeyHandler {};
		class getNbrVehGarage {};
		class callCellPhone {};
		class messenger {};
		class areaGangWinWin {};
		class toxicArea {};
		class playSound {};
		class AAN {};
		class postNewsBroadcast {};
		class updateMarketWeapon {};
		class whiteListQuestion {};
		class whiteList {};
		class weaponReceive {};
		class index {};
		class inputMenu {};
		class handleProgressBar {};
		class onPutItem {};
		class moneyFunction {};
		class skillsUpdate {};
		class fetchSkills {};
		class flashEffect {};
	};

	class Network
	{
		file = "core\functions\network";
		class broadcast {};
		class corpse {};
		class jumpFnc {};
		class soundDevice {};
		class setFuel {};
		class say3D {};
	};

	class Civilian
	{
		file = "core\civilian";
		class jailMe {};
		class jailTrollMe {};
		class civMarkers {};
		class jail {};
		class jailTroll {};
		class tazed {};
		class knockedOut {};
		class knockoutAction {};
		class robReceive {};
		class robPerson {};
		class removeLicenses {};
		class demoChargeTimer {};
		class civLoadout {};
		class freezePlayer {};
		class buyIllegalSpot {};
		class civInteractionMenu {};
		class medicInteractionMenu {};
		class restrainCiv {};
		class askJailTime {};
		class adminSleepPlayer {};
		class stealPlace {};
		class rebStopMessage {};
	};

	class Vehicle
	{
		file = "core\vehicle";
		class colorVehicle {};
		class openInventory {};
		class lockVehicle {};
		class vehicleOwners {};
		class vehInventory {};
		class vInteractionMenu {};
		class vehicleWeight {};
		class deviceMine {};
		class addVehicle2Chain {};
		class FuelRefuelcar {};
		class vehiclecolor3DRefresh {};
		class fuelSupply {};
		class fuelStore {};
		class vehTakeMultiItem {};
		class vehStoreMultiItem {};
		class getInVehicle {};
		class getOutVehicle {};
		class vehFlip {};
		class repaintMenu {};
		class repaintVehicle {};
		class repaintColorLoad {};
	};

	class Cop
	{
		file = "core\cop";
		class copMarkers {};
		class copLights {};
		class vehInvSearch {};
		class copSearch {};
		class bountyReceive {};
		class searchClient {};
		class restrain {};
		class ticketGive {};
		class ticketPay {};
		class ticketPrompt {};
		class copSiren {};
		class spikeStripEffect {};
		class radar {};
		class questionDealer {};
		class copInteractionMenu {};
		class sirenLights {};
		class licenseCheck {};
		class licensesRead {};
		class repairDoor {};
		class doorAnimate {};
		class fedCamDisplay {};
		class copLoadout {};
		class ticketPaid {};
		class containerInvSearch {};
		class wantedGrab {};
		class showArrestDialog {};
		class arrestDialog_Arrest {};
		class callCop {};
		class copStopMessage {};
		class loadImpoundPolice {};
		class copSearchPlayer {};
		class copSearchRemove {};
		class alarmCop {};
		class copIncinerator {};
		class loadoutCop {};
		class amendeLoadDialog {};
		class amendeLBDialog {};
		class amendePaid {};
		class amendeSelect {};
		class amendeSend {};
		class amendeReceive {};
	};
	
	class placeables
	{
		file = "core\cop\placeables";
		class placeableCancel {};
		class placeablePlace {};
		class placeablesInit {};
		class placeablesMenu {};
		class placeablesPlaceComplete {};
		class placeablesRemove {};
		class placeablesRemoveAll {};
		class placeablePlaceSwitch {};
	};

	class Gangs
	{
		file = "core\gangs";
		class initGang {};
		class initFullGang {};
		class createGang {};
		class gangCreated {};
		class gangMenu {};
		class gangKick {};
		class gangLeave {};
		class gangNewLeader {};
		class gangNewRecrut {};
		class gangUpgrade {};
		class gangInvitePlayer {};
		class gangInvite {};
		class gangDisband {};
		class gangDisbanded {};
		class gangFilter {};
		class warnGangCapture {};
		class updateMyGroup {};
		class onPlayerKilledGang {};
		class startWar {};
		class stopWar {};
		class viewWar {};
	};

	class Shops
	{
		file = "core\shops";
		class atmMenu {};
		class buyClothes {};
		class changeClothes {};
		class clothingMenu {};
		class clothingFilter {};
		class vehicleShopMenu {};
		class vehicleShopLBChange {};
		class vehicleShopBuy {};
		class weaponShopFilter {};
		class weaponShopMenu {};
		class weaponShopSelection {};
		class weaponShopBuy {};
		class weaponShopMags {};
		class weaponShopAccs {};
		class virt_buy {};
		class virt_menu {};
		class virt_update {};
		class virt_sell {};
		class chopShopMenu {};
		class chopShopSelection {};
		class chopShopSell {};
		class FuelStatOpen {};
		class FuelLBchange {};
		class vehicleShopEnd3DPreview {};
		class vehicleShopInit3DPreview {};
		class vehicleShop3DPreview {};
		class itemSellMoney {};
		// class DisplayPrices {};
		class licenses {};
		class timerRadioSelection {};
		class weaponShopMenuSell {};
		class weaponShopSellSelection {};
		class weaponShopSell {};
		class vehicleCraft {};
	};

	class Items
	{
		file = "core\items";
		class lockpick {};
		class spikeStrip {};
		class jerryRefuel {};
		class flashbang {};
		class lacrymo {};
		class boltcutter {};
		class blastingCharge {};
		class defuseKit {};
		class storageBox {};
		class illegalBox {};
		class placestorage {};
		class scalpel {};
		class useAdnPack {};
	};

	class DynMarket
	{
        file = "core\DynMarket";
        class bought {};
        class updateMarket {};
        class DisplayPrices {};
        class LoadIntoListbox {};
        class ForcePrice {};
        class DYNMARKET_getPrice {};

	};

	class Dialog_Controls
	{
		file = "dialog\function";
		class setMapPosition {};
		class displayHandler {};
		class spawnConfirm {};
		class spawnMenu {};
		class spawnPointCfg {};
		class spawnPointSelected {};
		class progressBar {};
		class impoundMenu {};
		class unimpound {};
		class sellGarage {};
		class bankDeposit {};
		class bankWithdraw {};
		class bankTransfer {};
		class garageLBChange {};
		class safeInventory {};
		class safeOpen {};
		class safeTake {};
		class safeFix {};
		class vehicleGarage {};
		class gangDeposit {};
		class wireTransfer {};
		class gangWithdraw {};
		class vehicleAHMenu {};
		class InsureCar {};
		class filterMenu {};
		class s_onCheckedFilter {};
		class pickupItems {};
		class uberConfirm {};
		class uberPointSelected {};
		class uberMenu {};
		class s_onCheckedAnonyme {};
		class askBill {};
		class paidBill {};
		class showBillDialog {};
		class showNotification {};
		class vehicleInsureMenu {};
		class insureLBChange {};
		class restoreVeh {};
		class sellGarageHV {};
		class vehicleHV {};
		class vehicleHVMenu {};
		class HVLBChange {};
		class buyVehHV {};
	};

	class Kphone
	{
		file = "core\kphone";
		class smartphone {};
		class updateSender {};
		class receiveMessage {};
		class sendMessage {};
		class showMessage {};
		class deleteMess {};
		class newMessMenu {};
		class newMessLB {};
	};
	
	class Group
	{
		file = "core\groups";
		class clientGroupKick {};
		class clientGroupLeader {};
		class createGroup {};
		class groupBrowser {};
		class groupManagement {};
		class groupMenu {};
		class joinGroup {};
		class kickGroup {};
		class leaveGroup {};
		class setGroupLeader {};
		class setGroupPass {};
	};
};
