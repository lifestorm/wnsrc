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

ITEM.name = "[Odtwarzacz Audio] Naucz się czytać"
ITEM.uniqueID = "audiobook_reading"
ITEM.model = "models/props_lab/reciever01d.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Słuchając tego prostego urządzenia poprawisz swoją zdolność czytania."
ITEM.category = "Audiobooks"

ITEM.functions.Listen = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()
		
		character:SetCanread(true)
		
		client:NotifyLocalized("Czuję się teraz znacznie lepszy w czytaniu.")
	end
}