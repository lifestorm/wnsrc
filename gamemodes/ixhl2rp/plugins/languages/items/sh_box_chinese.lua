--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "languagebox_chinese"
ITEM.name = "Chinese Audiobook Box"
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

		inventory:Add("audiobook_1Chinese", 1)
		inventory:Add("audiobook_2Chinese", 1)
		inventory:Add("audiobook_3Chinese", 1)
		inventory:Add("audiobook_4Chinese", 1)
		inventory:Add("audiobook_5Chinese", 1)		

		client:Notify("You have converted the " .. item.name .. " into its relevant Audiobook set.")
	end
}
