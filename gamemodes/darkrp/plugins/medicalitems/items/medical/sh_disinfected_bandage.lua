--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bandage désinfecté"
ITEM.model = Model("models/stuff/bandages.mdl")
ITEM.description = "Un rouleau de pansements sanitaires désinfectés. Utilisé pour arrêter les saignements et nettoyer les plaies."
ITEM.category = "Médical"
ITEM.width = 1
ITEM.height = 1

ITEM.maxStackSize = 4
ITEM.healing = {
    bandage = 15,
    disinfectant = 7
}
ITEM.useSound = "willardnetworks/inventory/inv_bandage.wav"