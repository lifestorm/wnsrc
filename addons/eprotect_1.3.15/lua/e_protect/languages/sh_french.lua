--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if CLIENT then
    slib.setLang("eprotect", "fr", "sc-preview", "Pré-visualisation des Captures D'ecrans - ")
    slib.setLang("eprotect", "fr", "net-info", "Info des Nets - ")
    slib.setLang("eprotect", "fr", "ip-info", "Info de l'IP - ")
    slib.setLang("eprotect", "fr", "id-info", "Info de l'ID - ")
    slib.setLang("eprotect", "fr", "ip-correlation", "Corrélation de l'IP - ")
    slib.setLang("eprotect", "fr", "table-viewer", "Visionneur de Table")

    slib.setLang("eprotect", "fr", "tab-general", "Général")
    slib.setLang("eprotect", "fr", "tab-identifier", "Identifiant")
    slib.setLang("eprotect", "fr", "tab-netlimiter", "Limiteur de Net")
    slib.setLang("eprotect", "fr", "tab-netlogger", "Sauvegarde de net (logs)")
    slib.setLang("eprotect", "fr", "tab-exploitpatcher", "Correcteur d'Exploit")
    slib.setLang("eprotect", "fr", "tab-exploitfinder", "Rechercheur d'Exploit")
    slib.setLang("eprotect", "fr", "tab-fakeexploits", "Faux Exploit")
    slib.setLang("eprotect", "fr", "tab-datasnooper", "Fouineur de Data")

    slib.setLang("eprotect", "fr", "player-list", "Liste des Joueurs")

    slib.setLang("eprotect", "fr", "ratelimit", "Limite de flux")
    slib.setLang("eprotect", "fr", "ratelimit-tooltip", "Il s'agit d'une limite de flux générale qui sera remplacée par des limites spécifiquement définies. (Xs/Y)")

    slib.setLang("eprotect", "fr", "timeout", "Délai")
    slib.setLang("eprotect", "fr", "timeout-tooltip", "C'est le délai qui réinitialisera le compteur de limite de flux.")
    
    slib.setLang("eprotect", "fr", "overflowpunishment", "Punition d'Overflow")
    slib.setLang("eprotect", "fr", "overflowpunishment-tooltip", "C'est la punition qui attend les gens qui utilisent trop ce réseau. (1 = kick, 2 = ban)")

    slib.setLang("eprotect", "fr", "enable-networking", "Activer la mise en réseau")
    slib.setLang("eprotect", "fr", "disable-networking", "Desactiver la mise en réseau")

    slib.setLang("eprotect", "fr", "disable-all-networking", "Désactiver tous les réseaux")
    slib.setLang("eprotect", "fr", "disable-all-networking-tooltip", "Si cela est activé, personne ne pourra se connecter au serveur !")

    slib.setLang("eprotect", "fr", "player", "Joueur")
    slib.setLang("eprotect", "fr", "net-string", "Chaine de réseaux (string)")
    slib.setLang("eprotect", "fr", "called", "appelée")
    slib.setLang("eprotect", "fr", "len", "Len")
    slib.setLang("eprotect", "fr", "type", "Type")
    slib.setLang("eprotect", "fr", "activated", "Activé")
    slib.setLang("eprotect", "fr", "secure", "Securise")
    slib.setLang("eprotect", "fr", "ip", "Adresse IP")
    slib.setLang("eprotect", "fr", "date", "Date")
    slib.setLang("eprotect", "fr", "country-code", "Code Pays")
    slib.setLang("eprotect", "fr", "status", "Statut")

    slib.setLang("eprotect", "fr", "unknown", "Inconnu")
    slib.setLang("eprotect", "fr", "secured", "Securisé")

    slib.setLang("eprotect", "fr", "check-ids", "Verifier l'ID")
    slib.setLang("eprotect", "fr", "correlate-ip", "corréler l'IP")
    slib.setLang("eprotect", "fr", "family-share-check", "Verifier le partage Familial")

    slib.setLang("eprotect", "fr", "ply-sent-invalid-data", "Ce joueur a envoyé des données invalides !")
    slib.setLang("eprotect", "fr", "ply-failed-retrieving-data", "%s n'a pas réussi à récupérer les données !")

    slib.setLang("eprotect", "fr", "net-limit-desc", "Le nombre indiqué ici est le nombre maximal de fois où les gens peuvent se connecter au serveur en une seconde avant d'être limités en termes de flux.")

    slib.setLang("eprotect", "fr", "capture", "Capture d'Ecran")
    slib.setLang("eprotect", "fr", "check-ips", "Verifier l'IP")
    slib.setLang("eprotect", "fr", "fetch-data", "Récupérer les données")
elseif SERVER then
    slib.setLang("eprotect", "fr", "invalid-player", "Ce joueur n'est pas valide !")
    slib.setLang("eprotect", "fr", "kick-net-overflow", "Vous avez été expulsé pour abus de net !")
    slib.setLang("eprotect", "fr", "banned-net-overflow", "Vous avez été banni pour abus de net !")
    slib.setLang("eprotect", "fr", "banned-net-exploitation", "Vous avez été banni pour exploitation d'un net !")
    slib.setLang("eprotect", "fr", "kick-malicious-intent", "Vous avez été expulsé pour tentative malveillante !")
    slib.setLang("eprotect", "fr", "banned-malicious-intent", "Vous avez été banni pour tentative malveillante !")

    slib.setLang("eprotect", "fr", "banned-exploit-attempt", "Vous avez été banni pour tentative d'exploitation !")

    slib.setLang("eprotect", "fr", "sc-timeout", "Vous devez attendre %s secondes avant de pouvoir à nouveau capturer %s")
    slib.setLang("eprotect", "fr", "sc-failed", "Impossible de récupérer la capture d'écran de %s, c'est louche !")

    slib.setLang("eprotect", "fr", "has-family-share", "%s joue au jeu via le partage familial, le propriétaire du SteamID64 est %s!")
    slib.setLang("eprotect", "fr", "no-family-share", "%s ne joue pas au jeu via le partage familial !")
    slib.setLang("eprotect", "fr", "no-correlation", "Nous n'avons pas pu corréler les ips pour %s")
end