--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Levothyroxine (tiroid)"
ITEM.model = Model("models/willardnetworks/skills/daytripper.mdl")
ITEM.description = "Tiroid hormonu tiroksinin sentetik bir formu. Miksödem koması olarak bilinen ciddi bir form da dahil olmak üzere tiroid hormonu eksikliğini tedavi etmek için kullanılır. Ayrıca belirli tiroid tümörlerini tedavi etmek ve önlemek için de kullanılabilir. Bu küçük, yeşil renkli plastik küvetin içinde küçük haplar bulunur."
ITEM.category = "Pharma"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	bandage = 5,
	disinfectant = 5,
	painkillers = 5
}
ITEM.boosts = {
    intelligence = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)