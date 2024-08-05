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

include("shared.lua")

function ENT:Think()
	if (self:GetNetVar("enabled")) then
		local light = DynamicLight(self:EntIndex())
		local data = PLUGIN.usableEntityLookup[string.lower(self:GetModel())] -- I should optimize this...

		light.pos = self:GetPos() + (self:GetUp() * (data.upOffset or 1)) + (self:GetForward() * (data.forwardOffset or 1))
		light.r = data.color.r
		light.g = data.color.g
		light.b = data.color.b
		light.brightness = 1
		light.Decay = 1000
		light.Size = data.lightSize
		light.DieTime = CurTime() + 1
	end
end
