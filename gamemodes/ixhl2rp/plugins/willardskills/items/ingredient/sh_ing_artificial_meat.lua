--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Surowe syntetyczne mięso"
ITEM.description = "Substancje mięsne sprasowane w blok białkowy. Mięso jest surowe i nierafinowane."
ITEM.category = "Ingredient"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/steak1.mdl"
ITEM.colorAppendix = {["blue"] = "Syntetyczne mięso nabędziesz przy pomocy umiejętności Handlu (wymaga pozwolenia) lub ze sklepu."}
ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(24.99, 220.01, 0),
	fov = 0.62
}
ITEM.hunger = 15

ITEM.functions.Consume = {
	icon = "icon16/user.png",
	OnRun = function(item)
		local client = item.player
		local character = item.player:GetCharacter()

		character:SetHunger(math.Clamp(character:GetHunger() - (client:Team() == FACTION_BIRD and item.hunger * 2 or item.hunger), 0, 100))
	end,
	OnCanRun = function(item)
		return ix.faction.Get(item.player:Team()).canEatRaw == true
	end
}
