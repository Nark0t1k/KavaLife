/*
	fn_moneyFunction.sqf
	by Nark0t1k
	TYPE:	0 : Normal		1 : Rate	2 : Reward Target Normal	3 : Reward Target Rate

	[false,10,true] remoteExec ["life_fnc_moneyFunction", cursorTarget];
	
*/
private["_cash","_amount","_rate","_add","_type","_targetReward","_message","_messageAdd","_messageCash","_notif"];
params [
	["_cash",false,[false]],
	["_amount",0,[0]],
	["_add",false,[false]],
	["_type",0,[0]],
	["_notif",false,[false]],
	["_targetReward",objNull,[objNull]]
];

_money = if(_cash)then{life_KavaCash}else{life_KavaBank};

if(_type in [1,3])then
{
	_rate = _amount;
	_amount = round(_money / 100 * _amount);
};

if(_add)then{
	_money = _money + _amount;
	_messageAdd = "recu";
}else
{
	if(_money < _amount)then {_money = 0} else {_money = _money - _amount};
	if(_type in [2,3])then{
		[false,_amount,true,0,true] remoteExeC ["life_fnc_moneyFunction",_targetReward];
	};
	_messageAdd = "perdu";
};

if(_cash)then
{
	life_KavaCash = _money;
	_messageCash = "en cash";
}else
{
	life_KavaBank = _money;
	_messageCash = "sur votre compte bancaire";
};

if(_notif)then
{
	if(_type in [0,2])then
	{
		_message = format["Vous avez %2 %1$ %3.",[_amount] call life_fnc_numberText,_messageAdd,_messageCash];
	}else
	{
		_message = format["Vous avez %4 %1$ %5 soit %2%3 de ce que vous aviez.",[_amount] call life_fnc_numberText,_rate,"%",_messageAdd,_messageCash];
	};
	titleText[format["%1",_message],"PLAIN"];
};
[6] call SOCK_fnc_updatePartial;
[] call life_fnc_hudUpdate;