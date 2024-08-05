--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Raw Chicken"
ITEM.description = "An industry collectivized in distant lands, set in foul conditions and factories to produce meat."
ITEM.category = "Ingredient"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/meat3.mdl"
ITEM.colorAppendix = {["blue"] = "Acquire Raw Chicken with the Bartering skill (requires a food ingredient permit) or from a shop."}
ITEM.hunger = 20

ITEM.functions.Consume = {
	icon = "icon16/user.png",
	OnRun = function(item)
		local client = item.player
		local character = item.player:GetCharacter()

		character:SetHunger(math.Clamp(character:GetHunger() - (client:Team() == FACTION_BIRD and item.hunger * 2 or item.hunger), 0, 100))
	end,
	OnCanRun = function(item)
		return ix.faction.Get(item.player:Team()).canEatRaw
	end
}
