--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

ITEM.name = "[Lecteur audio] Apprendre à lire"
ITEM.uniqueID = "audiobook_reading"
ITEM.model = "models/props_lab/reciever01d.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "L'écoute de cet appareil rustique améliorera votre capacité de lecture."
ITEM.category = "Livres Audio"

ITEM.functions.Listen = {
	name = "Écouter",
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()
		
		character:SetCanread(true)
		
		client:NotifyLocalized("Je me sens plus à l'aise avec la lecture.")
	end
}