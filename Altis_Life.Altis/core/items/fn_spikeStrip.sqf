#include "..\..\script_macros.hpp"
/*
	File: fn_spikeStrip.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Creates a spike strip and preps it.
*/
private["_position","_spikeStrip"];
_spikeStrip = "Land_Razorwire_F" createVehicle [0,0,0];
_spikeStrip attachTo[player,[0,5.5,0]];
_spikeStrip setDir 90;
_spikeStrip setVariable["item","spikeDeployed",true];

life_action_spikeStripDeploy = player addAction[localize "STR_ISTR_Spike_Place",{if(!isNull life_activeObj) then {detach life_activeObj; life_activeObj = ObjNull;}; player removeAction life_action_spikeStripDeploy; life_action_spikeStripDeploy = nil;},"",999,false,false,"",'!isNull life_activeObj'];
life_activeObj = _spikeStrip;
waitUntil {isNull life_activeObj};

if(!isNil "life_action_spikeStripDeploy") then {player removeAction life_action_spikeStripDeploy;};
if(isNull _spikeStrip) exitWith {life_activeObj = ObjNull;};

_spikeStrip setPos [(getPos _spikeStrip select 0),(getPos _spikeStrip select 1),0];
_spikeStrip setDamage 1;

life_action_spikeStripPickup = player addAction[localize "STR_ISTR_Spike_Pack",life_fnc_packupSpikes,"",0,false,false,"",
' _spikes = nearestObjects[getPos player,["Land_Razorwire_F"],8] select 0; !isNil "_spikes" && !isNil {(_spikes getVariable "item")}'];

if(life_HC_isActive) then {
	[_spikeStrip] remoteExecCall ["HC_fnc_spikeStrip",HC_Life]; //Send it to the HeadlessClient for monitoring.
} else {
	[_spikeStrip] remoteExec ["TON_fnc_spikeStrip",RSERV]; //Send it to the server for monitoring.
};
