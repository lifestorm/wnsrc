--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Chair de crabe crue"
ITEM.description = "De la chair crue de crabe."
ITEM.category = "Ingrédients"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/meat5.mdl"
ITEM.colorAppendix = {["blue"] = "Vous pouvez massacrer des Headcrabs et acquérir leur viande en frappant une arme de mêlée sur leur carcasse."}
ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(24.97, 220.02, 0),
	fov = 0.87
}
ITEM.hunger = 12

ITEM.functions.Consume = {
	name = "Consommer",
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
