--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Syntoniseur radio de la Résistance"
ITEM.description = "Un syntoniseur radio capable de modifier les fréquences qu'une radio peut capter. Il s'agit d'un syntoniseur de gamme supérieure capable d'atteindre des fréquences de diffusion lointaines."
ITEM.category = "Radio"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/circuit.mdl"
ITEM.colorAppendix = {["blue"] = "You can acquire this item via the Crafting skill.", ["red"] = "It is suspicious to carry this item."}
ITEM.maxStackSize = 1
ITEM.functions.install = {
    name = "Install",
    tip = "Install this item into the radio you're looking at.",
    icon = "icon16/wrench.png",
    OnRun = function(item)
        ix.musicRadio:InstallTuner(item.player, true)
    end
}
