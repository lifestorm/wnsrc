--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Uniforme de décontamination"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.description = "Uniforme de décontamination conçu par le cartel."
ITEM.category = "Combine"
ITEM.replacement = "models/willardnetworks/combine/antibody.mdl"
ITEM.iconCam = {
    pos = Vector(-1.96, 13.01, 199.57),
    ang = Angle(84.7, 279.39, 0),
    fov = 4.8
}
ITEM.isOTA = true
ITEM.maxArmor = 100
ITEM.channels = {"ota", "tac-3", "tac-4", "tac-5", "pc", "haa", "ac"}

ITEM.replaceOnDeath = "broken_otauniform"