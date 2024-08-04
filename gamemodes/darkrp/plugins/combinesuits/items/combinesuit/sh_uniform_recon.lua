--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Uniforme OTA - RECON"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.description = "Un uniforme d'OTA , correspondant à celui des RECON,  est une unité de reconnaisance et équipé d'un sniper"
ITEM.category = "Combine"
ITEM.replacement = "models/nemez/combine_soldiers/combine_soldier_recon_h.mdl"
ITEM.iconCam = {
    pos = Vector(-1.96, 13.01, 199.57),
    ang = Angle(84.7, 279.39, 0),
    fov = 4.8
}
ITEM.isOTA = true
ITEM.maxArmor = 125
ITEM.channels = {"ota", "tac-3", "tac-4", "tac-5", "pc", "haa", "ac"}

ITEM.replaceOnDeath = "broken_otauniform"