--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "T-X"

ITEM.description = "Une pilule raffinée qui vous fait vous sentir ultra-fort. Certains pensent que c'est ce qu'utilisent les soldats transhumains."

ITEM.description = "Une pilule raffinée qui vous fait vous sentir ultra-fort. Certains pensent que c'est ce qu'utilisent les soldats transhumains du Cartel."

ITEM.model = Model("models/willardnetworks/skills/pills2.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
    strength = 7,
    perception = 7
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["sobel"] = 15, ["blueUber"] = 15, ["stealth"] = 15, ["sharpen"] = 15
}
ITEM.junk = "comp_plastic"