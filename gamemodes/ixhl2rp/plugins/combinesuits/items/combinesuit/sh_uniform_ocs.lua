--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Containment Uniform"
ITEM.model = Model("models/wn7new/metropolice_c8/cpuniform.mdl")
ITEM.description = "Combine issued OCS uniform."
ITEM.category = "Combine"
ITEM.replacement = "models/willardnetworks/combine/antibody.mdl"
ITEM.iconCam = {
    pos = Vector(-1.96, 13.01, 199.57),
    ang = Angle(84.7, 279.39, 0),
    fov = 4.8
}
ITEM.isOTA = true
ITEM.maxArmor = 75
ITEM.channels = {"ota-tac", "tac-3", "tac-4", "tac-5", "cmb", "cca", "mcp", "ccr-tac"}

ITEM.replaceOnDeath = "broken_otauniform"