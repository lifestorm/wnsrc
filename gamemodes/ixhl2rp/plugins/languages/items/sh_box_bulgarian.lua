--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "languagebox_bulgarian"
ITEM.name = "Bulgarian Audiobook Box"
ITEM.description = "A box containing a full set of Audiobooks. How convenient."
ITEM.category = "Boxes"
ITEM.model = "models/items/item_item_crate.mdl"
ITEM.width = 2
ITEM.height = 2

ITEM.functions.Convert = {
	name = "Convert",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("audiobook_1Bulgarian", 1)
		inventory:Add("audiobook_2Bulgarian", 1)
		inventory:Add("audiobook_3Bulgarian", 1)
		inventory:Add("audiobook_4Bulgarian", 1)
		inventory:Add("audiobook_5Bulgarian", 1)		

		client:Notify("You have converted the " .. item.name .. " into its relevant Audiobook set.")
	end
}
