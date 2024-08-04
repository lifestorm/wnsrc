--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "comp_wood"
ITEM.name = "Bout de bois"

ITEM.description = "Ce bout de bois peut sembler banal, mais il peut être utilisé pour une variété de projets créatifs. Il peut être taillé pour créer une sculpture, utilisé comme poignée pour un outil, ou même transformé en un jouet artisanal pour enfant. Le bois est un matériau naturellement durable, résistant à la décomposition et facile à travailler. Avec un peu d'inspiration, ce simple bout de bois peut devenir l'élément clé d'un projet créatif qui sera apprécié pendant des années."

ITEM.description = "Un morceau naturel et brut de bois, probablement tombé d'un arbre. Sa surface est rugueuse, portant les stries et les marques de l'écorce qui l'entourait autrefois. "

ITEM.category = "Crafting"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/Gibs/wood_gib01a.mdl"
ITEM.colorAppendix = {["blue"] = "Vous pouvez acquérir cet objet via la fonctionnalité de répartition des compétences d'artisanat ou en recherchant des tas de déchets.", ["red"] = "Il est suspect de transporter plus de 8 objets de ce genre."}

ITEM.maxStackSize = 8

ITEM.functions.Breakdown = {
	icon = "icon16/link_break.png",
	name = "Briser",
	OnRun = function(item)
		local client = item.player

		client:GetCharacter():GetInventory():Add("woodstick", 10)
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item.player:Team() == FACTION_BIRD
	end
}
