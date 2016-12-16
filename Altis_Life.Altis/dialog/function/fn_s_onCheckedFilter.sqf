#include "..\..\script_macros.hpp"
/*
	Author: Nark0t1k inspired by Tonic
	fn_s_onCheckedFilter.sqf
*/
private ["_rebelpo", "_spublic", "_option", "_state", "_missions", "_champ", "_mine", "_process", "_marketress", "_gang", "_vehseller", "_market", "_all", "_tmp", "_index"];
_option = SEL(_this,0);
_state = SEL(_this,1);
_missions = ["dp_1_18_2", "dp_1_18", "dp_1_20", "dp_1_10", "dp_1_9", "dp_1_11", "dp_1_12", "dp_1_5", "dp_1_6", "dp_1_8", "dp_1_7", "dp_1_18_3", "dp_1_15_2", "dp_1_13", "dp_1_14", "dp_1_16", "dp_1_15", "dp_1_14_2", "dp_1_2", "dp_1_4", "dp_1_17", "dp_1_22", "dp_1_3", "dp_1_19", "dp_1_21", "dp_missions_1"];
_champ = ["pdt_1","pdt_2","pdt_3","grotte_1","grotte_2","apple_1","apple_2","apple_3","apple_4","peaches_1","peaches_2","peaches_3","wood_1","malt_1","houblon_1","levure_1","Fouille_1","Fouille_2","sand_mine","rock_quarry","salt_mine","copper_mine","silver_mine","iron_mine","oil_field_1","oil_field_2","diamond_mine","fred_reserve"];
_process = ["mark_usinefrite_1","mark_usineoil_1","mark_usineoil_2","mark_usinepierre_1","mark_usinewood_1","mark_usinebout_1","mark_usinecopper_1","mark_usineiron_1","mark_usinefoss_1","mark_usinevitre_1","mark_usinesilver_1","mark_usineura_1","mark_usineura_2","mark_usinebijoux_1","mark_usinemeth_1","mark_usinesel_1","mark_usinediamond_1","mark_usinemeth_2","mark_usinemeth_3","mark_usinebouteille_1"];
_marketress = ["mark_traderciment_1","mark_tradersilver_1","mark_tradersilver_2","mark_traderwood_1","mark_traderwood_2","mark_traderglass_1","mark_tradermetal_1","mark_tradermetal_2","mark_traderura_1","mark_traderura_2","mark_tradersel_1","mark_tradersel_2","mark_traderfoss_1","mark_traderfoss_2","mark_traderalcol_1","mark_traderalcol_2","mark_traderalcol_3","mark_traderdiamond_1","mark_traderdiamond_2","mark_traderbijoux_1","mark_traderbijoux_2","mark_traderoil_1","gold_bar_dealer_1"];
_vehseller = ["air_serv_2","air_serv_3","mark_garage_1","mark_garage_2","mark_garage_3","mark_garage_4","mark_garage_5","mark_garage_6","mark_garage_7","mark_garage_8","mark_garageair_1","mark_garageair_2","mark_garageair_3","mark_carshop_1","mark_carshop_2","mark_carshop_3","mark_carshop_4","mark_truckshop_1","mark_truckshop_2","mark_truckshop_3","mark_airshop_1","mark_airshop_2","mark_kartshop_1","mark_boatshop_1","civ_ship_1","mark_boatshop_2","civ_ship_3","mark_boatshop_3","civ_ship_2"];
_rebelpo = ["Rebelop_1","Rebelop_2","Rebelop_3","Rebelop_4","chop_shop_1","chop_shop_2","chop_shop_3","chop_shop_4","mark_dealertortue_1","mark_dealertortue_2","mark_dealertortue_3","mark_dealer_1","mark_dealer_2","mark_dealer_3","toxic_truck_1","toxic_truck_2"];
_marketpo = ["mark_alvo_1","mark_alvo_2","mark_alvo_3","mark_alvo_4","mark_alvo_5","mark_vetvictor_1","mark_vetvictor_2","mark_vetvictor_3","mark_vetvictor_4","mark_vetvictor_5","mark_hv_1","mark_hv_2","mark_hv_3","mark_hv_4","mark_genstore_1","mark_genstore_2","mark_genstore_3","mark_genstore_4","mark_genstore_5","mark_genstore_6","mark_assur_1","mark_assur_2","mark_assur_3","mark_assur_4","mark_fishshop_1","mark_fishshop_2","mark_fishshop_3","mark_diveshop_1","mark_diveshop_2","mark_diveshop_3"];
_entreprise = ["mark_ksd_1","mark_ksd_2","mark_janner_1","mark_michelin_1"];
_spublic = ["mark_fourriere_1","mark_fourriere_2","mark_fourriere_3","mark_fourriere_4","hospital_marker_1","hospital_2","hospital_3","hospital_5","hospital_6","mark_jail_1","mark_licshop_1","mark_licshop_2","mark_licshop_3","mark_licshop_4","mark_licshop_5","fed_reserve_1","police_hq_1","cop_spawn_3","cop_spawn_4","cop_spawn_5","mark_checkpoint_1","mark_checkpoint_2","mark_radar_1","mark_radar_2","mark_radar_3","mark_radar_4","mark_radar_5","mark_radar_6","mark_radar_7","mark_gunstore_1","mark_gunstore_2","mark_gunstore_3","mark_gunbuy_1","mark_gunbuy_2","mark_gunbuy_3"];
_divers = ["mark_donateur_1","fuel_storage_1","fuel_storage_2","mark_radio_1","mark_radio_2","mark_radio_3","mark_usinelegal_1","gang_area_1","gang_area_2","gang_area_3","gang_area_4","gang_area_5","gang_area_6","gang_area_7","mark_boxItem_1","mark_boxItem_2","mark_boxItem_3","mark_boxItem_4","mark_boxItem_5","mark_boxItem_6","mark_boxItem_7","mark_craftveh_1","mark_assembleur_1","marker_278","marker_272","marker_275","marker_271","marker_274","marker_277","marker_270","marker_273","marker_276"];

_all = _missions + _champ + _process + _marketress + _vehseller + _rebelpo + _entreprise + _divers + _marketpo + _spublic;
switch(_option) do {
	case 0: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _all;
		_tmp = if(_state == 1)then{true}else{false};
		CONTROL(9200,9201) cbSetChecked _tmp;
		CONTROL(9200,9202) cbSetChecked _tmp;
		CONTROL(9200,9203) cbSetChecked _tmp;
		CONTROL(9200,9204) cbSetChecked _tmp;
		CONTROL(9200,9205) cbSetChecked _tmp;
		CONTROL(9200,9206) cbSetChecked _tmp;
		CONTROL(9200,9207) cbSetChecked _tmp;
		CONTROL(9200,9208) cbSetChecked _tmp;
		CONTROL(9200,9209) cbSetChecked _tmp;
		CONTROL(9200,9210) cbSetChecked _tmp;
		life_filter = [_tmp,_tmp,_tmp,_tmp,_tmp,_tmp,_tmp,_tmp,_tmp,_tmp];
	};
	case 1: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _missions;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 2: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _champ;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 3: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _process;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 4: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _marketress;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 5: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _vehseller;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 6: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _rebelpo;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 7: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _marketpo;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 8: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _entreprise;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 9: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _spublic;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	case 10: {
		{
			_x setMarkerAlphaLocal _state;
		}forEach _divers;
		_index = _option - 1;
		_tmp = if(_state isEqualTo 1)then{true}else{false};
		life_filter set [_index,_tmp];
	};
	
};
if(false in life_filter) then
{
	CONTROL(9200,9250) cbSetChecked false;
}else
{
	CONTROL(9200,9250) cbSetChecked true;
};
profileNamespace setVariable ["life_KavaFilter",life_filter];