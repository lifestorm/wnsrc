--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- You can change the default language by setting this in your schema.
ix.config.language = "french"

--[[
	DO NOT CHANGE ANYTHING BELOW THIS.

	This is the Helix main configuration file.
	This file DOES NOT set any configurations, instead it just prepares them.
	To set the configuration, there is a "Config" tab in the F1 menu for super admins and above.
	Use the menu to change the variables, not this file.
--]]

ix.config.Add("maxCharacters", 5, "Nombre de personnages maximum par personne", nil, {
	data = {min = 1, max = 50},
	category = "Personnages"
})
ix.config.Add("color", Color(75, 119, 190, 255), "Couleur principale du gamemode", function(oldValue, newValue)
	if (newValue.a != 255) then
		ix.config.Set("color", ColorAlpha(newValue, 255))
		return
	end

	if (CLIENT) then
		hook.Run("ColorSchemeChanged", newValue)
	end
end, {category = "Apparence"})
ix.config.Add("font", "Roboto Th", "La police utilisée pour afficher les titres.", function(oldValue, newValue)
	if (CLIENT) then
		hook.Run("LoadFonts", newValue, ix.config.Get("genericFont"))
	end
end, {category = "Apparence"})

ix.config.Add("genericFont", "Roboto", "La police utilisée pour afficher les textes.", function(oldValue, newValue)
	if (CLIENT) then
		hook.Run("LoadFonts", ix.config.Get("font"), newValue)
	end
end, {category = "Apparence"})

ix.config.Add("maxAttributes", 100, "Le montant maximal que peut atteindre chaque attribut.", nil, {
	data = {min = 0, max = 100},
	category = "Personnages"
})
ix.config.Add("chatAutoFormat", true, "Si oui ou non il faut automatiquement mettre en majuscule et ponctuer le texte en caractères.", nil, {
	category = "Chat"
})
ix.config.Add("chatRange", 280, "La distance maximale que peut parcourir un message de chat IC d'une personne.", nil, {
	data = {min = 10, max = 5000, decimals = 1},
	category = "Chat"
})
ix.config.Add("chatMax", 256, "Le nombre maximum de caractères qui peuvent être envoyés dans le chat.", nil, {
	data = {min = 32, max = 1024},
	category = "Chat"
})
ix.config.Add("chatColor", Color(255, 255, 150), "La couleur par défaut du chat IC.", nil, {category = "Chat"})
ix.config.Add("chatListenColor", Color(175, 255, 150), "La couleur pour le chat IC si vous regardez l'enceinte.", nil, {
	category = "Chat"
})
ix.config.Add("oocDelay", 10, "Le délai avant qu'un joueur puisse à nouveau utiliser le chat OOC en secondes.", nil, {
	data = {min = 0, max = 10000},
	category = "Chat"
})
ix.config.Add("allowGlobalOOC", true, "Si Global OOC est activé ou non.", nil, {
	category = "Chat"
})
ix.config.Add("loocDelay", 0, "Le délai avant qu'un joueur puisse à nouveau utiliser le chat LOOC, en secondes.", nil, {
	data = {min = 0, max = 10000},
	category = "Chat"
})
ix.config.Add("spawnTime", 5, "Le temps qu'il faut pour respawn.", nil, {
	data = {min = 0, max = 10000},
	category = "Personnages"
})
ix.config.Add("inventoryWidth", 6, "Combien d'emplacements en ligne il y a dans un inventaire par défaut.", nil, {
	data = {min = 0, max = 20},
	category = "Personnages"
})
ix.config.Add("inventoryHeight", 4, "Combien d'emplacements dans une colonne il y a dans un inventaire par défaut.", nil, {
	data = {min = 0, max = 20},
	category = "Personnages"
})
ix.config.Add("minNameLength", 4, "Le nombre minimum de caractères dans un nom.", nil, {
	data = {min = 4, max = 64},
	category = "Personnages"
})
ix.config.Add("maxNameLength", 32, "Le nombre maximum de caractères dans un nom.", nil, {
	data = {min = 16, max = 128},
	category = "Personnages"
})
ix.config.Add("minDescriptionLength", 16, "Le nombre minimum de caractères dans une description.", nil, {
	data = {min = 0, max = 300},
	category = "Personnages"
})
ix.config.Add("descriptionDisplayLength", 256,
	"Le nombre de caractères de la description qui sera affichée lorsque quelqu'un regardera le lecteur.", nil, {
	data = {min = 64, max = 2048},
	category = "Personnages"
})
ix.config.Add("saveInterval", 300, "La fréquence de sauvegarde des caractères en secondes.", nil, {
	data = {min = 60, max = 3600},
	category = "Personnages"
})
ix.config.Add("walkSpeed", 130, "La vitesse à laquelle un joueur marche normalement.", function(oldValue, newValue)
	for _, v in ipairs(player.GetAll())	do
		v:SetWalkSpeed(newValue)
	end
end, {
	data = {min = 75, max = 500},
	category = "Personnages"
})
ix.config.Add("runSpeed", 235, "La vitesse à laquelle un joueur court normalement.", function(oldValue, newValue)
	for _, v in ipairs(player.GetAll())	do
		v:SetRunSpeed(newValue)
	end
end, {
	data = {min = 75, max = 500},
	category = "Personnages"
})
ix.config.Add("walkRatio", 0.5, "La vitesse à laquelle on va quand on tient ALT.", nil, {
	data = {min = 0, max = 1, decimals = 1},
	category = "Personnages"
})
ix.config.Add("jumpPower", 200, "How much force is behind ones jump.", function(oldValue, newValue)
	for _, v in ipairs(player.GetAll()) do
		v:SetJumpPower(newValue)
	end
end, {
	data = {min = 100, max = 400},
	category = "characters"
})
ix.config.Add("intro", true, "Whether or not the Helix intro is enabled for new players.", nil, {
	category = "appearance"
})
ix.config.Add("music", "music/hl2_song2.mp3", "La musique par défaut jouée dans le menu des personnages.", nil, {
	category = "Apparence"
})
ix.config.Add("communityURL",
	"https://discord.gg/TkCUtVMRef",
	"L'URL vers laquelle il faut se diriger lorsque l'on clique sur le bouton Communauté.", nil, {
	category = "Apparence"
})
ix.config.Add("communityText", "@community",
	"Le texte à afficher sur le bouton communautaire. Vous pouvez utiliser des expressions linguistiques en les préfixant avec @", nil, {
	category = "Apparence"
})
ix.config.Add("vignette", true, "Affichage ou non de la vignette.", nil, {
	category = "Apparence"
})
ix.config.Add("scoreboardRecognition", false, "Si la reconnaissance est utilisée ou non dans le tableau d'affichage.", nil, {
	category = "Personnages"
})
ix.config.Add("defaultMoney", 0, "Le montant d'argent avec lequel les joueurs commencent.", nil, {
	category = "Personnages",
	data = {min = 0, max = 1000}
})
ix.config.Add("allowVoice", false, "Si le chat vocal est autorisé ou non.", function(oldValue, newValue)
	if (SERVER) then
		hook.Run("VoiceToggled", newValue)
	end
end, {
	category = "Serveur"
})
ix.config.Add("voiceDistance", 600.0, "Jusqu'où la voix peut-elle être entendue ?", function(oldValue, newValue)
	if (SERVER) then
		hook.Run("VoiceDistanceChanged", newValue)
	end
end, {
	category = "Serveur",
	data = {min = 0, max = 5000, decimals = 1}
})
ix.config.Add("weaponAlwaysRaised", false, "Si les armes sont toujours levées ou non.", nil, {
	category = "Serveur"
})
ix.config.Add("weaponRaiseTime", 1, "Le temps qu'il faut pour qu'une arme se lève.", nil, {
	data = {min = 0.1, max = 60, decimals = 1},
	category = "Serveur"
})
ix.config.Add("maxHoldWeight", 100, "Le poids maximum qu'un joueur peut porter dans ses mains.", nil, {
	data = {min = 1, max = 500},
	category = "Intéractions"
})
ix.config.Add("throwForce", 732, "La force avec laquelle un joueur peut lancer l'objet qu'il tient.", nil, {
	data = {min = 0, max = 8192},
	category = "Intéractions"
})
ix.config.Add("allowPush", true, "Si la poussée avec les mains est autorisée ou non.", nil, {
	category = "Intéractions"
})
ix.config.Add("pushOnly", false, "Si les dommages causés par les coups de poing sont activés ou non.", nil, {
	category = "Intéractions"
})
ix.config.Add("itemPickupTime", 0.5, "Le temps qu'il faut pour ramasser et mettre un article dans votre inventaire.", nil, {
	data = {min = 0, max = 5, decimals = 1},
	category = "Intéractions"
})
ix.config.Add("year", 2015, "L'année en cours dans le jeu.", function(oldValue, newValue)
	if (SERVER and !ix.date.bSaving) then
		ix.date.ResolveOffset()
		ix.date.current:setyear(newValue)
		ix.date.Send()
	end
end, {
	data = {min = 1, max = 9999},
	category = "Date"
})
ix.config.Add("month", 1, "Le mois actuel dans le jeu.", function(oldValue, newValue)
	if (SERVER and !ix.date.bSaving) then
		ix.date.ResolveOffset()
		ix.date.current:setmonth(newValue)
		ix.date.Send()
	end
end, {
	data = {min = 1, max = 12},
	category = "Date"
})
ix.config.Add("day", 1, "Le jour actuel du jeu.", function(oldValue, newValue)
	if (SERVER and !ix.date.bSaving) then
		ix.date.ResolveOffset()
		ix.date.current:setday(newValue)
		ix.date.Send()
	end
end, {
	data = {min = 1, max = 31},
	category = "Date"
})
ix.config.Add("secondsPerMinute", 60, "Combien de secondes il faut pour qu'une minute s'écoule dans le jeu.", function(oldValue, newValue)
	if (SERVER and !ix.date.bSaving) then
		ix.date.UpdateTimescale(newValue)
		ix.date.Send()
	end
end, {
	data = {min = 0.01, max = 120},
	category = "Date"
})
