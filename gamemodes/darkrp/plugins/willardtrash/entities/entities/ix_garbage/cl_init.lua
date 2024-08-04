--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnPopulateEntityInfo(container)
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText("Trash")
	name:SizeToContents()
end

function ENT:Initialize()

end

function ENT:Think()

end
