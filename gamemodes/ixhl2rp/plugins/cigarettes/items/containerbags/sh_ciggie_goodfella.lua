--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Goodfella Cigars"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl")
ITEM.description = "A pack of high-quality debonair cigarillos wrapped in high-grammage tobacco paper containing up to 8 cigarillos manufactured by Tenzhen Industries."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette"}
ITEM.noEquip = true

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
