#include "..\..\script_macros.hpp"
/*
	fn_reponseIndep.sqf
*/
private ["_type","_targets","_money"];
_type = _this select 0;
_targets = [];
_money = 1500;

if(life_indep_active) exitWith {hint parseText "Tu ne peux pas accepter une nouvelle requête car tu as déja une requête en cours.";};
if (!isNil "last_indep_call") then
{
	if ((time - last_indep_time) < 20) then
	{
		if (!isNull last_indep_call || !alive last_indep_call) then
		{
			if(_type isEqualTo 0) then
			{
				_money = 3000;
				[7,format["Le medecin %1 à repondu a l'appel à l'aide de %2",player getVariable ["realname", "Inconnu"],last_indep_call getVariable ["realname", "An unknown civilian"]],false,"medic"] remoteExecCall ["life_fnc_broadcast",independent];
				[[0,2,7],"Un medecin est en route"] remoteExecCall ["life_fnc_broadcast",last_indep_call];
			};
			if(_type isEqualTo 1) then
			{
				_money = 1500;
				[7,format["Le mecano %1 à repondu a l'appel à l'aide de %2",player getVariable ["realname", "Inconnu"],last_indep_call getVariable ["realname", "An unknown civilian"]],false,"mecano"] remoteExecCall ["life_fnc_broadcast",independent];
				[[0,2,7],"Un mecano est en route"] remoteExecCall ["life_fnc_broadcast",last_indep_call];
			};
			

			life_indep_active = true;
					
			life_cur_task = player createSimpleTask [format["IndepTask_%1",last_indep_call]];
			life_cur_task setSimpleTaskDescription ["Venez en aide a une personne","Help Job",""];
			life_cur_task setSimpleTaskDestination (getPos last_indep_call);
			life_cur_task setTaskState "Assigned";
			player setCurrentTask life_cur_task;

			["HelpIndep",["Aider une personne"]] call BIS_fnc_showNotification;
			(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw","
				(_this select 0) drawLine [
					getPos player,
					getPos last_indep_call,
					[0,0,1,1]
				];
			"];
			
			[_money] spawn {
				_money = _this select 0;
				_time = time + 300;
				waitUntil {(player distance (getPos last_indep_call) < 50) OR !alive player OR (round(_time - time) < 1)};
				(findDisplay 12 displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
				if(player distance (getPos last_indep_call) < 50) exitWith {
					["HelpIndepSucceeded",[format["Bravo tu a participer a aider la personne et tu gagne %1$",_money]]] call bis_fnc_showNotification;
					life_cur_task setTaskState "Succeeded";
					player removeSimpleTask life_cur_task;
					ADD(life_KavaBank,_money);
					life_indep_active = false;
				};
				life_indep_active = false;
				life_cur_task setTaskState "Failed";
				player removeSimpleTask life_cur_task;
			};
				
				
		}else
		{
			hint parseText "La personne n'a plus besoin d'aide.";
		};
	};
};

