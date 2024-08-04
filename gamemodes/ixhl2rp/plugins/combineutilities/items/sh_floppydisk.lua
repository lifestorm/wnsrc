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

ITEM.name = "Dyskietka"
ITEM.model = "models/props/cs_office/computer_caseb_p9a.mdl"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Dyskietka na której można przechowywać informacje."
ITEM.category = "Technology"

function ITEM:GetName()
	if self:GetData("customName", false) then
		return self:GetData("customName", false)
	end

	return self.name
end

ITEM.functions.Place = {
	name = "Włóż do komputera",
	tip = "equipTip",
	icon = "icon16/link_add.png",
	OnRun = function(itemTable)
		if (SERVER) then
			local client = itemTable.player
			PLUGIN:InsertDisk(client, itemTable)

			return false
		end
	end,

	OnCanRun = function(itemTable)
		if IsValid(itemTable.entity) then return false end
	end
}

function ITEM:OnTransferred(curInv, inventory)
	if (SERVER) then
		if self.computer and IsValid(self.computer) then
			self.computer.hasDiskInserted = nil
		end
	end
end

ITEM.functions.Name = {
	name = "Nazwij dysk",
	tip = "equipTip",
	icon = "icon16/link_add.png",
	OnRun = function(itemTable)
		if (SERVER) then
			local client = itemTable.player
			if !client then return end

			netstream.Start(client, "SetFloppyDiskName", itemTable:GetData("customName", false), itemTable.id, itemTable:GetData("password", false))
		end

		return false
	end
}