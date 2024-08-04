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

ITEM.name = "[Audio Player] Learn to Read"
ITEM.uniqueID = "audiobook_reading"
ITEM.model = "models/props_lab/reciever01d.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Listening to this rustic device will improve your reading capability."
ITEM.category = "Audiobooks"

ITEM.functions.Listen = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()
		
		character:SetCanread(true)
		
		client:NotifyLocalized("I feel much better at reading now.")
	end
}