--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Raw Beef"
ITEM.description = "A raw slab of beef, a rather rare commodity these days."
ITEM.category = "Ingredient"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/meat3.mdl"
ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(24.95, 220.02, 0),
	fov = 0.86
}
ITEM.hunger = 32

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
