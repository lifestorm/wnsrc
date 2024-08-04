--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Poulet cru"
ITEM.description = "Viande de poulet crue à cuisiner."
ITEM.category = "Ingrédients"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/meat3.mdl"
ITEM.colorAppendix = {["blue"] = "Obtenez du poulet cru avec la compétence Troc (nécessite un permis d'ingrédient alimentaire) ou dans un magasin."}
ITEM.hunger = 20

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
