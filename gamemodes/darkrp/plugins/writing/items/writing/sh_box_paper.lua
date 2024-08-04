--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "bulkbox_paper_pins"
ITEM.name = "Kağıt ve İğne Kutusu"
ITEM.description = "Beş kağıt ve iğneden oluşan bir set içeren bir kutu. Ne kadar uygun."
ITEM.category = "Boxes"
ITEM.model = "models/items/item_item_crate.mdl"
ITEM.width = 2
ITEM.height = 2

ITEM.colorAppendix = {["red"] = "Lütfen bunu açmadan önce 10 adet boş envanter yuvanız olduğundan emin olun."}

ITEM.functions.Convert = {
	name = "Dönüştür",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("paper", 5)
		inventory:Add("pin", 5)	

		client:Notify(item.name .. " adlı öğeyi açtınız.")
	end
}
