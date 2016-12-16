waitUntil {!isNull player && player isEqualTo player};
if(player diarySubjectExists "rules")exitwith{};

player createDiarySubject ["controls","Raccourci touche"];

player createDiaryRecord ["controls",
	[
		"Raccourci touche",
			"
			Y : Menu Joueur.<br/>
			U : Verrouiller/deverrouiller véhicule.<br/>
			F : Police/Medic - Sirene.<br/>
			T : Inventaire véhicule/maison.<br/>
			L : Legende Map.<br/>
			( , ) : Ouverture Map.<br/>
					Police - activation IEM(Tèlèmettre).<br/><br/>
			1 : A pied - Montrer sa carte d'identité.<br/>
			2 : Police - a pied - Stopper l'escort.<br/>
			3 : Police - Vehicule - envoie message police au supect visé.<br/>
			4 : Telephone.<br/>
			5 : Metre/enlever bouchon d'oreille.<br/>
			6 : Police- Ouvrir/fermer barriere.<br/><br/>
			SHIFT + R (CIV): Assomer(Civ Seulement, utilisé par les voleur).<br/>
			SHIFT + R (Police) : Menoter.<br/>
			SHIFT + L : activation Gyrophare(Police/Medic).<br/>
			SHIFT + G : Ce rendre.<br/>
			SHIFT + H : Ranger arme.<br/>
			CTRL + H : Sortir arme.<br/><br/>
			Windows gauche:<br/>
				-Ouvir ATM.<br/>
				-Attraper du poisson.<br/>
				-Recolter ressources.<br/>
				-Decouper animal.<br/>
				-Ouvrir menu maison.<br/>
				-Reanimer joueur(Medic).<br/>
				-Menu interaction Civil/Police.<br/>
				-Menu interaction vehicule.<br/>
				-Attraper des tortues.<br/>
				-Attraper du poisson.<br/>
				-Ramasser un objet.<br/><br/>
			Espace : <br/>
				-Saut.<br/>
				-Placer Objet Police.<br/><br/>
			"
	]
];