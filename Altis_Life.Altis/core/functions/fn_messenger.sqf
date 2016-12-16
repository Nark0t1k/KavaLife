/*
	fn_messenger.sqf
	by Nark0t1k

*/	
private ["_lstMess","_mess"];

_lstMess = [
	"Forum www.kavalash.fr",
	"TeamSpeak ts.kavalash.fr",
	"Serveur Kavalash Altis Life RP.",
	"Une ame de justicier? 2 places freeslot sont disponible dans la gendarmerie.",
	"Une envie d'aider les autres? 2 places freeslot sont disponible chez les médecins.",
	"Astuce: Tu peux montrer ta carte d'identite avec la touche 1.",
	"Astuce: Conduire un vehicule sans permis est illégal et passible d'amende.",
	"Astuce: Tu peux utiliser TOUS les ATM de Altis avec la touche Windows.",
	"Info: Le serveur reboot a 00h00 - 06h00 - 12h00 et 18h00.",
	"Regle: Toutes tentative d exploit bug est passible de ban permanent.",
	"Regle: Il est interdit de tuer les medecins.",
	"Regle: Le FreeKill (Meurte sans interaction au préalable) est passible de Ban.",
	"Regle: Il est interdit de détruire un véhicule (Revente seulement).",
	"Info: Préférer une interaction orale plutôt qu'un échange de tir!",
	"Regle: Il est interdit de braquer plus de 50% de la marchandise d'une personne.",
	"Info: Si vous vous déconnectez pendant la mort vous reviendrez en prison.",
	"Info: Besoin d'arme? Les stocks sont vide? Rendez vous aux usines d'armes de gang ou légal!",
	"Info: Le freekill (meurte sans interaction au préalable) est autorisé dans les zones PVP.",
	"Astuce: Tu peux afficher ton état de santé détaillé avec la touche CTRL + T.",
	"Astuce: Tu peux afficher l'état détaillé de ton véhicule avec la touch ALT + T",
	"Astuce: N'oublie pas d'attacher ta ceinture en voiture, cela pourrait te sauver la vie."
];

_mess = "";
_mess = _lstMess call BIS_fnc_selectRandom;
_mess = format["<t color='#008620' size='2' font='puristaMedium' align='center'>Kavalash Information</t><br/><t color='#FFFFFF' size='1.5' font='puristaMedium' align='center'>%1</t>",
	_mess
];

[
	parseText _mess,
	[
		0,
		safeZoneY,
		1,
		1
	],
	[10,10],
	15,
	2,
	0
] spawn BIS_fnc_textTiles;

	
	
	
			
	
	
	
	
