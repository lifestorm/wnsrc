--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "OTA Takım Lideri Üniforması"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.description = "Combine tarafından verilen OTA Komutan üniforması."
ITEM.category = "Combine"
ITEM.replacement = "models/wn/ota_commander.mdl"
ITEM.iconCam = {
    pos = Vector(-1.96, 13.01, 199.57),
    ang = Angle(84.7, 279.39, 0),
    fov = 4.8
}
ITEM.isOTA = true
ITEM.maxArmor = 100

ITEM.channels = {"ota-tac", "tac-3", "tac-4", "tac-5", "cmb", "cca", "ccg", "osi", "cca-cwu", "moc", "boe", "dob", "cwu", "cmru", "mcp"}

ITEM.replaceOnDeath = "broken_otauniform"