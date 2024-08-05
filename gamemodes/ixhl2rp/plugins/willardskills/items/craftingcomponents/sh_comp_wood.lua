--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "comp_wood"
ITEM.name = "Wooden chippings"
ITEM.description = "A collection of wooden chippings which can be reused for crafting items."
ITEM.category = "Crafting"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/Gibs/wood_gib01a.mdl"
ITEM.colorAppendix = {["blue"] = "You can acquire this item via the Crafting skill Breakdown functionality or searching trash piles.", ["red"] = "It is suspicious to carry more than 8 items of this kind."}

ITEM.maxStackSize = 24

ITEM.functions.Breakdown = {
	icon = "icon16/link_break.png",
	OnRun = function(item)
		local client = item.player

		client:GetCharacter():GetInventory():Add("woodstick", 10)
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item.player:Team() == FACTION_BIRD
	end
}
