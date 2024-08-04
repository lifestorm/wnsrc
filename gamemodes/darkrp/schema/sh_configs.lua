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
ix.currency.singular = "chip"
ix.currency.plural = "chips"
ix.currency.model = "models/willardnetworks/props/chips3.mdl"

ix.option.Add("ColorModify", ix.type.bool, true, {
    category = "appearance"
})

ix.option.Add("ColorSaturation", ix.type.number, 0, {
	category = "appearance",
	min = -3, max = 3, decimals = 2
})

ix.config.SetDefault("scoreboardRecognition", true)
ix.config.SetDefault("music", "music/hl2_song19.mp3")

ix.config.Add("rationInterval", 4, "How long a person needs to wait in hours to get their next ration", nil, {
	data = {min = 1, max = 10, decimals = 1},
	category = "economy"
})

ix.config.Add("defaultCredits", 25, "Amount of credits that citizens start with. Outcasts only receive half this amount.", nil, {
	data = {min = 1, max = 100},
	category = "economy"
})

ix.config.Add("defaultOutcastChips", 20, "Amount of chips that Outcast characters start with.", nil, {
	data = {min = 1, max = 100},
	category = "economy"
})

-- Overwatch Configuration
ix.config.Add("cityIndex", 17, "The City citizens are residing in.", nil, {
	data = {min = 1, max = 99},
	category = "Overwatch Systems"
})

ix.config.Add("sectorIndex", 10, "The Sector citizens are residing in.", nil, {
	data = {min = 1, max = 30},
	category = "Overwatch Systems"
})

ix.config.Add("operationIndex", 1, "Active operational index.", nil, {
	data = {min = 1, max = 5},
	category = "Overwatch Systems"
})

ix.config.Add("silentConfigs", false, "Whether or not only Staff should be notified for config changes.", nil, {
	category = "server"
})
