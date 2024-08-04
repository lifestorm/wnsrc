--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

PLUGIN.proxyList = {
    "HeadGearColor",
    "HairColor",
    "TorsoColor",
    "ShirtColor",
    "PantsColor",
	"ShoesColor"
}

ix.char.RegisterVar("proxyColors", {
	field = "proxyColors",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true
})
