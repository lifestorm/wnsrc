--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Protéine mixée"
ITEM.description = "Protéine en poudre mélangée avec des analgésiques et de l'eau."
ITEM.model = Model("models/willardnetworks/food/cmb_food1.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/antlion_grub/squashed.wav"
ITEM.hunger = 25
ITEM.boosts = {
    strength = 3,
    perception = 2,
    intelligence = -3
}
ITEM.energyShift = 0.01 -- fatigue_system
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["sobel"] = 15
}
ITEM.junk = "comp_plastic"