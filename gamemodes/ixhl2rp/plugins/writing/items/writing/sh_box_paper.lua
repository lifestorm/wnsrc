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
ITEM.name = "Pudełko z papierem i szpilkami"
ITEM.description = "Pudełko zawierające zestaw pięciu papierów i pinezek. Jakże wygodne."
ITEM.category = "Boxes"
ITEM.model = "models/items/item_item_crate.mdl"
ITEM.width = 2
ITEM.height = 2

ITEM.colorAppendix = {["red"] = "Upewnij się, że masz 10 wolnych miejsc w ekwipunku, zanim przekonwertujesz ten skrypt na jego indywidualną formę."}

ITEM.functions.Convert = {
	name = "Konwertuj",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("paper", 5)
		inventory:Add("pin", 5)	

		client:Notify("Przekonwertowałeś " .. item.name .. " w odpowiedni zestaw.")
	end
}
