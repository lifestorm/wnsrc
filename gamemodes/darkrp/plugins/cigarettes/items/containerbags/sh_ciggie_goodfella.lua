--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Goodfella Puro"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl")
ITEM.description = "Tenzhen Industries tarafından üretilen 8 adet purarillos içeren yüksek gram tütün kağıdına sarılmış bir paket yüksek kaliteli debonair puraril."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette"}
ITEM.noEquip = true

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
