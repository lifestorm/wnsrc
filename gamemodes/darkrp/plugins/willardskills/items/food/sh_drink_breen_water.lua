--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Canette d'eau"
ITEM.description = "Une canette en aluminium usagée qui a déjà contenu de l'eau. Elle est désormais vide et prête à être recyclée."
ITEM.category = "Nourriture"
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(25.01, 220.01, 0),
	fov = 0.6
}
ITEM.thirst = 20
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "crafting_water"
ITEM.boosts = {
    perception = -1,
    intelligence = -2
}

ITEM.functions.Convert = {
	name = "Convertir",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("crafting_water", 1, {original = item.uniqueID, spoilTime = item:GetData("spoilTime")})

		client:Notify("Vous avez converti " .. item.name .. " en une cannette craftable.")
	end
}
