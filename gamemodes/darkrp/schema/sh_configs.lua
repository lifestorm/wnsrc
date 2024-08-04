--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.currency.symbol = ""
ix.currency.singular = "jeton"
ix.currency.plural = "jetons"
ix.currency.model = "models/willardnetworks/props/chips3.mdl"

ix.option.Add("ColorModify", ix.type.bool, true, {
    category = "Apparence"
})

ix.option.Add("ColorSaturation", ix.type.number, 0, {
	category = "Apparence",
	min = -3, max = 3, decimals = 2
})

ix.config.SetDefault("scoreboardRecognition", true)
ix.config.SetDefault("music", "willardnetworks/charactercreation/wn_phaneron.mp3")

ix.config.Add("rationInterval", 4, "Combien de temps une personne doit-elle attendre en heures pour obtenir sa prochaine ration", nil, {
	data = {min = 1, max = 10, decimals = 1},
	category = "Économie"
})

ix.config.Add("defaultCredits", 25, "Montant des crédits dont disposent les citoyens au départ. Les parias ne reçoivent que la moitié de ce montant.", nil, {
	data = {min = 1, max = 100},
	category = "Économie"
})

ix.config.Add("defaultOutcastChips", 20, "Quantité de crédits avec laquelle les personnages d'Outcast commencent.", nil, {
	data = {min = 1, max = 100},
	category = "Économie"
})

-- Overwatch Configuration
ix.config.Add("cityIndex", 8, "Les Citoyens de la ville y résident.", nil, {
	data = {min = 1, max = 99},
	category = "Systèmes Overwatch"
})

ix.config.Add("sectorIndex", 8, "Le secteur dans lequel résident les citoyens.", nil, {
	data = {min = 1, max = 30},
	category = "Systèmes Overwatch"
})

ix.config.Add("operationIndex", 1, "Indice opérationnel actif.", nil, {
	data = {min = 1, max = 5},
	category = "Systèmes Overwatch"
})

ix.config.Add("silentConfigs", false, "Si oui ou non, seul le personnel doit être informé des changements de configuration.", nil, {
	category = "Serveur"
})

