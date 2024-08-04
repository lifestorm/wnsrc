--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Cigares Goodfella"
ITEM.category = "Drogues"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl")
ITEM.description = "Un paquet de cigares de haute qualité emballés dans du papier à tabac à grammage élevé contenant jusqu'à 8 cigares."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette"}
ITEM.noEquip = true

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
