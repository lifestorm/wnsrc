--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Tuner radiowy zatwierdzony przez Kombinat"
ITEM.description = "Tuner radiowy, za pomocą którego można zmieniać częstotliwości odbieranych przez radio, na które można się dostroić."
ITEM.category = "Technology"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/circuit.mdl"
ITEM.colorAppendix = {["blue"] = "Przedmiot ten można zdobyć za pomocą umiejętności Wytwarzania."}
ITEM.maxStackSize = 1
ITEM.functions.install = {
    name = "Zainstaluj",
    tip = "Zainstaluj ten przedmiot do radia na które się patrzysz.",
    icon = "icon16/wrench.png",
    OnRun = function(item)
        ix.musicRadio:InstallTuner(item.player, false)
    end
}
