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

ITEM.name = "Writing Base"
ITEM.model = "models/error.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.identifier = "base"
ITEM.description = ""
ITEM.category = "Writing"
ITEM.bAllowMultiCharacterInteraction = true

function ITEM:GetName()
	local title = self:GetData("title")
	if title and title != "" then return title end

	return self.name
end

function ITEM:GetDescription()
	return "A "..self.identifier.." to read or write on."
end

function ITEM:SetBodygroups(bodygroups)
	self:SetData("bodygroups", bodygroups)
end

function ITEM:GetModelBodygroups()
	return self:GetData("bodygroups") or ""
end

ITEM.functions.Write = {
	name = "Read/Write",
	tip = "Read/Write on this object.",
	icon = "icon16/text_align_center.png",
	OnRun = function(item)
		local client = item.player
		if !IsValid(client) then return false end

		if (SERVER) then
			PLUGIN:OpenWriting(client, item)
		end

		return false
	end
}
