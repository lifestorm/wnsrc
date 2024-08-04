--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Levothyroxine (thyroid)"
ITEM.model = Model("models/willardnetworks/skills/daytripper.mdl")
ITEM.description = "A synthetic form of the thyroid hormone thyroxine. It is used to treat thyroid hormone deficiency, including a severe form known as myxedema coma. It may also be used to treat and prevent certain types of thyroid tumors. Small pills sit inside this small, green coloured plastic tub."
ITEM.category = "Medical"
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