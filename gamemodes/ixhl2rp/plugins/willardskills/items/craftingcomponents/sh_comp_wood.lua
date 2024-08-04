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
ITEM.name = "Odłamki drewna"
ITEM.description = "Kolekcja drewnianych odłamków, które można ponownie wykorzystać do tworzenia przedmiotów."
ITEM.category = "Crafting"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/Gibs/wood_gib01a.mdl"
ITEM.colorAppendix = {["blue"] = "Możesz zdobyć ten przedmiot poprzez umiejętność wytwarzania lub przez przeszukiwanie śmieci.", ["red"] = "Noszenie więcej jak 8 przedmiotów tego typu, może zostać uznane za nielegalne."}

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
