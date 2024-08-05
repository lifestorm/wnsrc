--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Combine Approved Radio Tuner"
ITEM.description = "A radio tuner which can be used to modify the frequencies a radio can tune to."
ITEM.category = "Technology"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/circuit.mdl"
ITEM.colorAppendix = {["blue"] = "You can acquire this item via the Crafting skill."}
ITEM.maxStackSize = 1
ITEM.functions.install = {
    name = "Install",
    tip = "Install this item into the radio you're looking at.",
    icon = "icon16/wrench.png",
    OnRun = function(item)
        ix.musicRadio:InstallTuner(item.player, false)
    end
}
