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

	self.seatsOccupiers = {}

	self:SetIsFirstSeatOccupied(false)
	self:SetIsSecondSeatOccupied(false)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:OnOptionSelected(client, option, data)
	if (!istable(data) or !isstring(data.actName) or !isnumber(data.sequenceID)) then
		return
	end

	local bIsSitAct = data.actName == "Sit"
	local bIsDownAct = data.actName == "Down"

	if (!bIsSitAct and !bIsDownAct) then
		return
	end

	local bIsFirstSeatOccupied = self:GetIsFirstSeatOccupied()
	local bIsSecondSeatOccupied = self:GetIsSecondSeatOccupied()
	local seatsOccupyFuncs = {}

	if (bIsSitAct) then
		if (!bIsFirstSeatOccupied) then
			seatsOccupyFuncs[1] = self.SetIsFirstSeatOccupied
		elseif (!bIsSecondSeatOccupied) then
			seatsOccupyFuncs[2] = self.SetIsSecondSeatOccupied
		else
			return
		end
	elseif (!bIsFirstSeatOccupied and !bIsSecondSeatOccupied) then
		seatsOccupyFuncs[1] = self.SetIsFirstSeatOccupied
		seatsOccupyFuncs[2] = self.SetIsSecondSeatOccupied
	else
		return
	end

	local entityData, sequence, sequenceData = PLUGIN:RestingEntity_FindSequenceNameAndDataByID(self:GetModel(), client, data.actName, data.sequenceID)

	if (!sequence) then
		return
	end

	client.ixRestingInfo = {
		entity = self,
		enterPos = {client:GetPos(), client:EyeAngles()},
		seatsOccupyFuncs = seatsOccupyFuncs
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

	if (!seatsOccupyFuncs[1] and entityData.secondOffsets) then
		local secondOffsets = entityData.secondOffsets

		rightOffset = rightOffset * (secondOffsets.rightOffset or 1)
		forwardOffset = forwardOffset * (secondOffsets.forwardOffset or 1)
		upOffset = upOffset * (secondOffsets.upOffset or 1)
	end

	local clientNewAngles = self:GetAngles()

	if (angleYawOffset) then
		clientNewAngles:Add(Angle(0, angleYawOffset, 0))
	end

	client:SetAngles(clientNewAngles)
	client:SetPos(self:GetPos() + self:GetRight() * rightOffset + self:GetForward() * forwardOffset + self:GetUp() * upOffset)
	client:SetCollisionGroup(COLLISION_GROUP_WORLD)

	for k, func in pairs(seatsOccupyFuncs) do
		self.seatsOccupiers[k] = client
		func(self, true)
	end

	PLUGIN:EnterUntimedAct(client, sequence)
end

function PLUGIN:OnRemove()
	for _, client in pairs(self.seatsOccupiers) do
		local enterPos = client.ixRestingInfo.enterPos

		client:SetCollisionGroup(COLLISION_GROUP_NONE)
		client:SetPos(enterPos[1])
		client:SetEyeAngles(enterPos[2])

		client.ixRestingInfo = nil
		client:LeaveSequence()
	end
end
