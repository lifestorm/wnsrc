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
ENT.PrintName = "Bed"
ENT.Spawnable = false
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsFirstSeatOccupied")
	self:NetworkVar("Bool", 1, "IsSecondSeatOccupied")
end

function ENT:GetEntityMenu(client)
	if (client:GetNetVar("actEnterAngle") or (self:GetIsFirstSeatOccupied() and self:GetIsSecondSeatOccupied())) then
		return
	end

	return PLUGIN:RestingEntity_FindValidSequenceOptions(self:GetModel(), client, "Down")
end
