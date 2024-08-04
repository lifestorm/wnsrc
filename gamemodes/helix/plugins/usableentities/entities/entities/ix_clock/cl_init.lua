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
	local time = StormFox2 and ix.date.GetFormatted(StormFox2.Time.TimeToString()) or ix.date.GetFormatted("%H:%M")
	local lastTime = self:GetNetVar("lastTime")

	local description = container:AddRow("description")
	description:SetFont("TitlesFontNoClamp")
	description:SetText(self:GetNetVar("enabled") and time or lastTime)
	description:SizeToContents()
end
