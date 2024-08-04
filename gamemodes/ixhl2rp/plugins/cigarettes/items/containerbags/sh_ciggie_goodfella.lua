--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Cygaretki Goodfella"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl")
ITEM.description = "Paczka cygaretek wysokiej jakości, w której mieści się ich 8 sztuk."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette"}
ITEM.noEquip = true

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
