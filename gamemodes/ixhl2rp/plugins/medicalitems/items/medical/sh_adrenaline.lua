--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Adrenalina"
ITEM.model = Model("models/willardnetworks/skills/adrenaline.mdl")
ITEM.description = "Strzykawka wypełniona adrenaliną. Zapewnia tymczasową ulgę w bólach o średnim nasileniu."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	painkillers = 60
}
ITEM.boosts = {
    agility = 4,
}
-- Drug effects list declared in plugins/drugs/sh_plugin.lua
ITEM.drug = {
    ["sharpen"] = 5
}

ITEM.outlineColor = Color(255, 204, 0, 100)

ITEM.usableInCombat = true
