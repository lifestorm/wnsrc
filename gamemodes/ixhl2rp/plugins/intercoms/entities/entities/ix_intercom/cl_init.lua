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
local glowMaterial = Material("sprites/glow04_noz")

function ENT:OnPopulateEntityInfo(container)
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText("Faction Intercom")
	name:SizeToContents()
	
	local description = container:AddRow("description")
	description:SetText("A one-way stationary intercom locked to a specific channel.")
	description:SizeToContents()
	
	local channelID = self:GetChannel() or ""
	local channel = ix.radio.channels[channelID]

	if (!channel) then return end

	local channelRow = container:AddRow("channel")
	channelRow:SetText("Channel: " .. string.upper(channelID))
	channelRow:SetBackgroundColor(channel.color)
	channelRow:SizeToContents()
end

function ENT:Draw()
	self:DrawModel()

	local channelID = self:GetChannel() or ""
	local channel = ix.radio.channels[channelID]

	if (!channel) then return end

	render.SetMaterial(glowMaterial)
	render.DrawSprite(self:GetPos() + self:GetUp() * 2.6 + self:GetRight() * 2.3 + self:GetForward() * -3.1, 3, 3, channel.color)
end
