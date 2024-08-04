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

ENT.PopulateEntityInfo = true

function ENT:OnPopulateEntityInfo(container)
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText("Kuş Yuvası")
	name:SizeToContents()

	local description = container:AddRow("description")
	description:SetText("Tahta çubuklardan, yapraklardan vb. apılmış küçük bir kuş yuvası.")
	description:SizeToContents()

	local progress = container:AddRow("progress")
	progress:SetText("Çubuklar: " .. self:GetNetVar("progress", 0) .. "/30")
	progress:SetBackgroundColor(derma.GetColor("Info", container))
	progress:SizeToContents()
end

