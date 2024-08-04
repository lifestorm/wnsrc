--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "junk_empty_bobwater"
ITEM.name = "Canette d'eau vide"
ITEM.description = "Une canette en aluminium usagée qui a déjà contenu de l'eau. Elle est désormais vide et prête à être recyclée."
ITEM.category = "Déchets"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/bobdrinks_can.mdl"
ITEM.colorAppendix = {["blue"] = "Cet objet peut être décomposé en ses composants de base avec la compétence Artisanat."}

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