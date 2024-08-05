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
ITEM.name = "Paper and Pins Box"
ITEM.description = "A box containing a set of five papers and pins. How convenient."
ITEM.category = "Boxes"
ITEM.model = "models/items/item_item_crate.mdl"
ITEM.width = 2
ITEM.height = 2

ITEM.colorAppendix = {["red"] = "Please ensure you have 10 free inventory slots before converting this into it's individual script form."}

ITEM.functions.Convert = {
	name = "Convert",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("paper", 5)
		inventory:Add("pin", 5)	

		client:Notify("You have converted the " .. item.name .. " into its relevant set.")
	end
}
