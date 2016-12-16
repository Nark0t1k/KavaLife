/*
	fn_whiteListQuestion.sqf
*/
	
private ["_badAnswer", "_goodAnswer", "_whiteList", "_quest", "_random", "_text", "_goodResp", "_action"];
if(life_WhiteList select 1) exitWith {hint parseText "<t size='1.1'>Tu dois as déja finit le test du questionaire. Tu Dois maintenant aller recolter des dechets pret de la fleche verte</t>";};
if(life_is_processing)exitWith {hint parseText "<t size='1.1'>Desolé mais tu n'as pas reussi. Va relire les informations du forum tu pourras ré-essayer dans 3min.</t>";};
life_is_processing = true;	
_goodAnswer = 0;
_badAnswer = 0;
	
_whiteList = 
[
	[0,true,"On peut faire un FreeKill dans les zones de gang.","Les zones de gang sont des zones PVP"],
	[1,false,"J'ai le droit de me balader arme en main dans Kavala.","Dans Kavala les armes doivent être rangées dans le sac à dos."],
	[2,false,"Rester dans Kavala est une bonne chose.","Kavala ne vous permet pas d'évoluer."],
	[3,true,"Si quelqu'un me braque avec une arme j'ai le droit de le tuer.","Si une personne vous braque une action RP commence."],
	[4,false,"Si on me braque et que l'on me tue alors que je prennais la fuite c'est un FreeKill.","Si une personne vous braque une action RP commence."],
	[5,false,"J'ai le droit tirer sur les policiers que je croise.","Il est interdit de tirer sur les policiers sans raison."],
	[6,false,"Je peux braquer un médecin.","Il est interdit de braquer un médecin."],
	[7,true,"Si un civil refuse d'obtemperer je peux le tuer.","Si vous braquer quelqu'un une action RP commence."],
	[8,true,"Il faut 5 policiers connecté pour pouvoir vendre de la drogue.","5 Policiers doivent être presents pour vendre des drogues au dealer."],
	[9,false,"Il faut 3 policiers connecté pour pouvoir faire un braquage de banque.","Il faut 5 policiers connectés."],
	[10,false,"Si j'ai un probleme l'ideal est de contacter un admin ingame.","L'ideal est de poster sur le forum ou de le contacter via TeamSpeak."],
	[11,false,"Quand je meurs je commence une nouvelle vie et j'ai oublié tout ce qui c'est passé.","On ne meurt pas mais on tombe dans le coma, on n'oublie donc pas les actions passés."],
	[12,false,"Pour reparer un véhicule je doit ouvrir un menu avec la touche E.","La touche d'interaction est la touche Windows."],
	[13,false,"Si je suis victime de FreeKill j'ai le droit de me faire rembourser mon equipement.","Seul le remboursement de véhicule dans le cas de bug du serveur est possible."],
	[14,true,"Si j'essai d'échaper à un policier celui-ci peux me taser.","Un policier à l'autorisation de braquer une personne "],
	[15,true,"Pour travailler je peux recolter du cuivre, le transformer et en suite le revendre.","Il existe different métier similaire  (Voir la bourse)"],
	[16,true,"Je peux récolter des peches et autre objet via la touche Windows","La touche windows est la touche interaction qui permet d'effectuer plusieurs interaction"],
	[17,true,"Je peux poster mes idées pour le serveur sur le forum www.kavalash.fr","Il est conseillé de poster vos idées sur le forum avec des arguments en faveur de celles-ci."],
	[18,false,"J'ai le droit de prendre un otage pour faire un braquage de banque","Il est interdit de prendre quelqu'un en otage afin de braquer la banque."],
	[19,true,"Si je réalise un Freekill les admins on le droit de prendre de l'argent sur mon compte pour rembourser la victime","Les admins on la droit prendre de l'argent pour rembourser une victime."],
	[20,false,"Si je trouve un véhicule abandonée j'ai le droit de détruire celui-ci","Il est interdit de détruire un véhicule sans motif valable (au minimum un contact avec le propriétaire auparavant)."],
	[21,true,"Si mon véhicule explose dans le véhicule d'un autre joueur à cause d'une désynchro j'ai le droit d'être rembrousé","Une desynchro est le resultat d'un lag de joueur et non du serveur, aucun remboursement ne sera effectué (penser à prendre une assurance)"],
	[22,true,"Je ne peux me connecter en FreeSlot Gendarme que si des Gendarmes officiel sont présents","Il faut au minimum 1 gendarme officiel de présent pour pouvoir accéder au freeslot."],
	[23,false,"J'ai le droit de foncer de manière répété dans le véhicules dans autre joueur","Les collisions volontaires et répétées avec des véhicules peuvent être considérées comme du troll et donc passible de ban permanent."],
	[24,false,"Il est autorisé de crocheter/voler un véhicule de médecin/mécano","Le vole de véhicule de médecin ou de mecano est interdit."],
	[25,true,"La gendarmerie peut sortir un Hunter/Strider si elle croise un Ifrit","La gendarmerie à l'autorisation de sortir des véhicules blindé pour répondre à la menace des ifrits."],
	[26,false,"Il est nécessaire de télécharger des mods pour rejoindre le serveur.","Le serveur Kavalash ne nécessite aucun mods."],
	[27,false,"On peut avoir 3 snipers dans un même groupe","1 lynx ou 1 M320 limité par groupe"],
	[28,false,"Je suis médecin ! Je peux suivre mon groupe rebelle","Un médic ne pourra pas jouer rebelle."],
	[29,false,"Le serveur reboot à 8h00-12h00-16h00-20h00-4h00","6h00-12h00-18h00-00h00"]
];

_quest = (_whiteList select 0);

while {true} do
{
	_quest = _whiteList call BIS_fnc_selectRandom;

	_text = _quest select 2;
	_goodResp = _quest select 1;
	_action = [
		parseText format["%1",_text],
		"Question Vrai / Faux",
		"VRAI",
		"FAUX"
	] call BIS_fnc_guiMessage;

	if((_action && _goodResp) || (!_action && !_goodResp))then
	{
		_goodAnswer = _goodAnswer + 1;
		hint parseText format["<t size='1.1' color='#2EFE2E'>Bravo bonne réponse. Compteur Bonne Réponse: %1/10</t>",_goodAnswer];
	}else
	{
		_badAnswer = _badAnswer + 1;
		hint parseText format["<t size='1.1' color='#FF0000'>Mauvaise réponse. Compteur Mauvaise Réponse: %1/5<br/>Info: %2</t>",_badAnswer,(_quest select 3)];
	};
	if(_goodAnswer > 9)exitWith {hint parseText "<t size='1.1'>Bravo tu as reussi le test du question réponse! Félicitation<br/>Tu Dois maintenant aller recolter des dechets pret de la fleche verte</t>";life_WhiteList=[false,true,0];life_is_processing = false;};
	if(_badAnswer > 4)exitWith {hint parseText "<t size='1.1'>Desolé mais tu n'as pas reussi. Va relire les informations du forum tu pourra ré-essayé dans 3min.</t>";};
};
if(_badAnswer > 4) then
{
	sleep 180;
	life_is_processing = false;
	hint parseText "<t size='1.1'>Tu peux maintenant re-tester le test du vrai/faux.</t>";
};