--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Carcasse de sangsue crue"
ITEM.description = "La carcasse crue d'une sangsue."
ITEM.category = "Ingrédients"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/leech.mdl"
ITEM.colorAppendix = {["blue"] = "Obtenez des sangsues crues avec la compétence Troc (nécessite un permis d'ingrédient alimentaire) ou dans un magasin."}
ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(24.92, 219.99, 0),
	fov = 0.48
}
ITEM.maxStackSize = 5
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
