--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

LANGUAGE = {
	schemaName = "Half-Life 2 - Echo One",
	tying = "Attache...",
	unTying = "Détache...",
	isTied = "Attaché",
	fTiedUp = "Vous êtes attaché.",
	fBeingTied = "Vous êtes en train d'être attaché.",
	tiedUp = "Ils sont attachés.",
	beingTied = "Ils sont en train d'être attachés.",
	beingUntied = "Ils sont en train d'être détachés.",
	needRequestDevice = "Vous avez besoin d'un dispositif de demande pour faire cela.",
	cantViewData = "Vous ne pouvez pas voir les données de cette personne.",
	cid = "CID",
	citizenid = "ID de citoyen",
	lastEdit = "Dernière révision par",
	lastEditDate = "Dernière révision le",
	objectivesTitle = "Objectifs actuels",
	searchingCorpse = "Recherche du cadavre...",
	radioNotOn = "Votre radio n'est pas allumée !",
	radioRequired = "Vous avez besoin d'une radio pour faire cela.",
	radioAlreadyOn = "Vous avez déjà une radio allumée !",
	economy = "Économie",
	itemAlreadyEquipped = "Vous avez déjà cet objet équipé !",

	-- messages d'affichage pour la combine
	cViewData = "Téléchargement des données de profil du citoyen...",
	cViewDataExpired = "ERREUR ! Échec du téléchargement des données de profil mises à jour du citoyen...",
	cViewDataUpdate = "Téléchargement des données de profil mises à jour du citoyen...",
	cViewDataFiller = "Mise en cache de la base de données de profil du citoyen mise à jour...",
	cViewObjectives = "Téléchargement du manifeste des objectifs d'Overwatch...",
	cViewObjectivesUpdate = "Mise à jour du manifeste des objectifs d'Overwatch...",
	cViewObjectivesFiller = "Récupération du manifeste des objectifs d'Overwatch en cours (RÉVISION %d)...",
	cCivilJudgement = "Préparation des protocoles d'administration de jugement civil...",
	cRequest = "Téléchargement du paquet de demande...",
	cCitizenLoaded = "Reconstruction du manifeste de citoyen...",
	cCombineLoaded = "Mise à jour des coordonnées de biosignal...",
	cLostBiosignal = "Téléchargement du biosignal perdu...",
	cLostBiosignalLocation = "AVERTISSEMENT ! BIOSIGNAL PERDU POUR L'UNITÉ %s",
	cUnitCriticallyInjured = "AVERTISSEMENT ! L'UNITÉ %s A BESOIN D'UNE ASSITANCE MÉDICALE IMMÉDIATE",
	cTrauma = "AVERTISSEMENT ! %s traumatisme détecté.",
	cDroppingVitals = "AVERTISSEMENT ! SIGNES VITAUX EN CHUTE, RECHERCHEZ UNE ASSITANCE MÉDICALE IMMÉDIATE",
	cStaminaLost = "ATTENTION : Utilisation excessive de l'utilisateur, administration d'un stimulant...",
	cStaminaGained = "STIMULANT ADMINISTRÉ",
	cLosingContact = "Téléchargement des informations de contact radio perdues...",
	cLostContact = "AVERTISSEMENT ! Contact radio perdu pour l'unité à une position inconnue...",

	voices = "Voix",
	dispatchsound = "Son de dispatch",
	
	optColorModify = "Modifier la couleur du dessin",
	optdColorModify = "Active ou désactive la modification de couleur du dessin.",
	
	optColorSaturation = "Saturation des couleurs",
	optdColorSaturation = "La saturation des couleurs de l'écran. Ne fait rien si 'Modifier la couleur du dessin' est désactivé.",
	
	administration = "Administration",
	notice = "Notifications",
	civilprot = "Protection Civile",

	optSeeGlobalOOC = "Afficher le tchat OOC global",
	optdSeeGlobalOOC = "Afficher le tchat OOC global dans votre boîte de discussion.",
	optIconIncognitoMode = "Mode incognito pour l'icône admin OOC/LOOC",
	optdIconIncognitoMode = "Afficher/ne pas afficher l'icône admin dans le tchat LOOC et OOC.",
	optStandardIconsEnabled = "Activer les icônes standards",
	optdStandardIconsEnabled = "Activer/désactiver les icônes standards de discussion devant chaque message.",

	dispatchTypoWarning = "Ce que vous êtes sur le point de diffuser n'est pas une commande vocale valide. Envoyez à nouveau dans les 5 secondes pour confirmer.",
	textDoubleCommand = "Votre texte avait un texte supplémentaire '%s' au début, mais il a été filtré. Faites attention !",
	cmdPunch = "Permet à l'unité OTA de donner un coup de poing à quelqu'un, le mettant instantanément KO.",
	cmdListColors = "Affiche toutes les couleurs disponibles dans la console.",
	ColorsPrinted = "Toutes les couleurs disponibles ont été imprimées dans la console.",
	cmdVisorMessage = "Affiche un message sur le visor à toutes les unités Transhumaines de Surveillance.",
	cmdPlyNotify = "Envoyer une notification à un joueur spécifique.",
	notificationSent = "Notification envoyée.",
	cmdWD = "Chuchoter quelque chose à une personne spécifique à proximité de vous. Utilisez pour cibler la personne devant vous.",
	targetTooFar = "Cette personne est trop loin pour entendre votre chuchotement !",
	cmdGetCWUFlags = "Donnez-vous temporairement des permissions PET pour les quarts de travail.",
	cwuFlagsCooldown = "Vous devez attendre une heure avant d'utiliser cette commande !",
	cwuFlagsGivenAdmins = "%s (%s) s'est donné temporairement des permissions PET grâce à la commande /GetCWUFlags !",
	cwuFlagsGivenPlayer = "Vous vous êtes donné des permissions PET pour une (1) heure. L'abus ou la mauvaise utilisation de cette commande sera puni.",
	cmdUnstuck = "Vous sortir d'un endroit où vous êtes coincé, si vous êtes coincé dans un mur, si vous avez été tué par un objet, etc. L'abus sera puni.",
	unstuckCooldown = "Vous devez attendre une heure avant d'utiliser cette commande !",
	unstuckAdmins = "%s (%s) a utilisé la commande /UnStuck à %s ! La raison pour laquelle ils ont exécuté la commande /UnStuck est : %s",
	unstuckPlayer = "Vous vous êtes débloqué. Les membres du personnel ont été informés.",
	unstuckAnswerIncorrect = "Ce n'est pas la bonne réponse !",
	unstuckAnswerInvalid = "Ce n'est pas une réponse valide !"
}
