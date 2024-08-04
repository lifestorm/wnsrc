--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.base = "base_genericequipable"
ITEM.name = "Armband"
ITEM.description = "A piece of fabric material worn around the arm."
ITEM.model = "models/willardnetworks/armband.mdl"
ITEM.category = "misc"
ITEM.color = Color(255, 255, 255)

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local name = tooltip:GetRow("name")
		name:SetBackgroundColor(self.color)
	end
end

function ITEM:OnEquipped(client)
	local armbands = client:GetNetVar("armbands", {})
	armbands[self.name[1]:lower() .. self.name:Right(#self.name - 1)] = self.color

	client:SetNetVar("armbands", armbands)
end

function ITEM:OnUnequipped(client)
	local armbands = client:GetNetVar("armbands", {})
	armbands[self.name[1]:lower() .. self.name:Right(#self.name - 1)] = nil

	client:SetNetVar("armbands", armbands)
end
