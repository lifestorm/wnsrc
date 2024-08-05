--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "BMDFlagSystem"
FACTION.description = "This is a shitty solution to quickly add a flag system to vendors. God this is awful but fuck it."
FACTION.color = Color(63, 142, 164, 255)
FACTION.isDefault = false

FACTION.factionImage = "materials/willardnetworks/faction_imgs/citizen.png"
FACTION.selectImage = "materials/willardnetworks/charselect/citizen2.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/street.png"

FACTION.humanVoices = true
FACTION.allowRebelForcefieldPassage = true

FACTION.accessFlag = "B"

FACTION.models = {
	female = {
		"models/willardnetworks/citizens/female_01.mdl"
	};
	male = {
		"models/willardnetworks/citizens/male_01.mdl"
	};
};

FACTION_BMDFLAGSYSTEM = FACTION.index
