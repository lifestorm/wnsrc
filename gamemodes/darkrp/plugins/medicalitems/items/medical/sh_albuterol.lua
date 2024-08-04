--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Albuterol (Soluma)"
ITEM.model = Model("models/props_c17/TrapPropeller_Lever.mdl")
ITEM.description = "Bir inhaler içinde saklanan Albuterol, solunum problemlerinin neden olduğu hırıltılı solunum ve nefes darlığını önlemek ve tedavi etmek için kullanılır. Ayrıca egzersizin yol açtığı astımı önlemek için de kullanılır. Hızlı rahatlatıcı bir ilaçtır ve bir tüp aracılığıyla dağıtılır. Talimat şöyledir; inhaler ağızlığını takın, pistona basın ve derin nefes alın, nefesi beş saniye tutun, sonra verin. Gerektiği kadar tekrarlayın."
ITEM.category = "Pharma"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	bandage = 5,
	disinfectant = 1,
	painkillers = 5
}
ITEM.boosts = {
    agility = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)