--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Amoxicillin (anti-biyotik)"
ITEM.model = Model("models/willardnetworks/skills/pill_bottle.mdl")
ITEM.description = "Bir dizi bakteriyel enfeksiyonu tedavi etmek için kullanılabilen küçük turuncu bir kap antibiyotik ilaç hapı. Tedaviler arasında orta kulak enfeksiyonu, strep boğaz, pnömoni, cilt enfeksiyonları ve idrar yolu enfeksiyonları yer alır."
ITEM.category = "Pharma"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 4
ITEM.healing = {
	bandage = 6,
	disinfectant = 4,
	painkillers = 10
}
ITEM.boosts = {
    strength = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)