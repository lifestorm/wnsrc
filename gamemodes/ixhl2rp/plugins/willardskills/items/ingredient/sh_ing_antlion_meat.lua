--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Surowe mięso z Antliona"
ITEM.description = "Gumiasty, odcięty kawałek mięsa Antliona. Pachnie i wygląda nieco dziwnie."
ITEM.category = "Ingredient"
ITEM.model = "models/willardnetworks/food/raw_alienmeat.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(125.61, 104.91, 78.59),
	ang = Angle(25.01, 219.94, 0),
	fov = 4
}
ITEM.colorAppendix = {["blue"] = "Możesz pokroić martwego Antliona uderzając w niego bronią białą i zdobyć z niego w ten sposób mięso."}
ITEM.hunger = 15

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
