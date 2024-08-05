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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	self:SetIsOccupied(false)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:OnOptionSelected(client, option, data)
	if (!istable(data) or !isstring(data.actName) or data.actName != self:GetValidActName() or !isnumber(data.sequenceID) or self:GetIsOccupied()) then
		return
	end

	local _, sequence, sequenceData = PLUGIN:RestingEntity_FindSequenceNameAndDataByID(self:GetModel(), client, data.actName, data.sequenceID)

	if (!sequence) then
		return
	end

	client.ixRestingInfo = {
		entity = self,
		enterPos = {client:GetPos(), client:EyeAngles()},
		seatOccupyFunc = self.SetIsOccupied
	}

	local angleYawOffset, rightOffset, forwardOffset, upOffset

	if (istable(sequenceData)) then
		angleYawOffset = sequenceData.angleYawOffset
		rightOffset = sequenceData.rightOffset or 1
		forwardOffset = sequenceData.forwardOffset or 1
		upOffset = sequenceData.upOffset or 1
	else
		rightOffset, forwardOffset, upOffset = zero_angle, 1, 1, 1
	end

	local clientNewAngles = self:GetAngles()

	if (angleYawOffset) then
		clientNewAngles:Add(Angle(0, angleYawOffset, 0))
	end

	client:SetAngles(clientNewAngles)
	client:SetPos(self:GetPos() + self:GetRight() * rightOffset + self:GetForward() * forwardOffset + self:GetUp() * upOffset)
	client:SetCollisionGroup(COLLISION_GROUP_WORLD)

	self.occupier = client
	self:SetIsOccupied(true)

	PLUGIN:EnterUntimedAct(client, sequence)
end

function PLUGIN:OnRemove()
	if (IsValid(self.occupier)) then
		local enterPos = self.occupier.ixRestingInfo.enterPos

		self.occupier:SetCollisionGroup(COLLISION_GROUP_NONE)
		self.occupier:SetPos(enterPos[1])
		self.occupier:SetEyeAngles(enterPos[2])

		self.occupier.ixRestingInfo = nil
		self.occupier:LeaveSequence()
	end
end
