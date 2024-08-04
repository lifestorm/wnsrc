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

ITEM.name = "Zawór wody"
ITEM.model = "models/props/de_nuke/hr_nuke/metal_pipe_001/metal_pipe_001_gauge_valve_low.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Zawór regulujący przepływ wody."
ITEM.category = "Tools"

ITEM.functions.Place = {
	name = "Użyj na zbiorniku wody",
	tip = "equipTip",
	icon = "icon16/link_add.png",
	OnRun = function(itemTable)
		if (SERVER) then
			local client = itemTable.player
			PLUGIN:PlaceValve(client, itemTable)

			return false
		end
	end,

	OnCanRun = function(itemTable)
		if IsValid(itemTable.entity) then return false end
	end
}

function ITEM:OnTransferred(curInv, inventory)
	if (SERVER) then
		if self.waterCache and IsValid(self.waterCache) then
			self.waterCache.HasPotPlaced = nil
		end
	end
end