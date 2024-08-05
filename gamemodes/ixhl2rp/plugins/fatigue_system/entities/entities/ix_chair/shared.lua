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

ENT.Type = "anim"
ENT.PrintName = "Chair"
ENT.Spawnable = false
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsOccupied")
	self:NetworkVar("String", 0, "ValidActName")
end

function ENT:GetEntityMenu(client)
	if (client:GetNetVar("actEnterAngle") or self:GetIsOccupied()) then
		return
	end

	return PLUGIN:RestingEntity_FindValidSequenceOptions(self:GetModel(), client, self:GetValidActName())
end
