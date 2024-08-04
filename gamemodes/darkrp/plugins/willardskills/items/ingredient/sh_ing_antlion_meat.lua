--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Viande crue de fourmillion"
ITEM.description = "Viande crue de fourmilion pour la préparation culinaire."
ITEM.category = "Ingrédients"
ITEM.model = "models/willardnetworks/food/raw_alienmeat.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(125.61, 104.91, 78.59),
	ang = Angle(25.01, 219.94, 0),
	fov = 4
}
ITEM.colorAppendix = {["blue"] = "Vous pouvez massacrer des Fourmilions et acquérir leur viande en frappant une arme de mêlée sur leur carcasse."}
ITEM.hunger = 15

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
