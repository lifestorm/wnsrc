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
ENT.PrintName = "Couch"
ENT.Spawnable = false
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsFirstSeatOccupied")
	self:NetworkVar("Bool", 1, "IsSecondSeatOccupied")
end

function ENT:GetEntityMenu(client)
	if (client:GetNetVar("actEnterAngle")) then
		return
	end

	local bIsFirstSeatOccupied = self:GetIsFirstSeatOccupied()
	local bIsSecondSeatOccupied = self:GetIsSecondSeatOccupied()

	if (bIsFirstSeatOccupied and bIsSecondSeatOccupied) then
		return
	end

	local model = self:GetModel()
	local options = PLUGIN:RestingEntity_FindValidSequenceOptions(model, client, "Sit")

	if (!bIsFirstSeatOccupied and !bIsSecondSeatOccupied) then
		local downOptions = PLUGIN:RestingEntity_FindValidSequenceOptions(model, client, "Down")

		for k, v in pairs(downOptions) do
			options[k] = v
		end
	end

	return options
end

