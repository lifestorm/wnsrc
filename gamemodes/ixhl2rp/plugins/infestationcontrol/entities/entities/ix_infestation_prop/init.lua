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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

local PLUGIN = PLUGIN

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)
	
	local physicsObject = self:GetPhysicsObject()
	
	if (IsValid(physicsObject)) then
		physicsObject:Wake()
		physicsObject:EnableMotion(false)
	end
end

function ENT:OnRemove()
	if (ix.shuttingDown) then return end
	
	if (self:GetCore()) then
		local identification = self:GetInfestation()

		if (identification) then
			local infestation = ix.infestation.stored[identification]

			if (infestation) then
				PLUGIN:UpdateInfestation(identification, nil)
			end
		end
	end
end

function ENT:OnSprayed(color)
	self:SetSprayed(true)
	self:SetMaterial("models/antlion/antlion_innards")
	self:SetColor(color)
	
	timer.Simple(1800, function()
		if (self and IsValid(self)) then
			self:Remove()
		end
	end)

	if (self:GetCore()) then
		local identification = self:GetInfestation()

		if (identification) then
			local infestation = ix.infestation.stored[identification]

			if (infestation) then
				PLUGIN:UpdateInfestation(identification, nil)
			end
		end
	end
end

function ENT:OnHarvested(client, damageType)
	local OnHarvested = ix.infestation.types[self:GetType()].OnHarvested

	if (OnHarvested) then
		local success = OnHarvested(self, client, damageType)

		if (success) then
			self:SetHarvested(true)
			self:SetColor(Color(127, 127, 127))
		end
	end
end

function ENT:StartTouch(entity)
	local StartTouch = ix.infestation.types[self:GetType()].StartTouch

	if (StartTouch) then
		StartTouch(self, entity)
	end
end

function ENT:EndTouch(entity)
	local EndTouch = ix.infestation.types[self:GetType()].EndTouch

	if (EndTouch) then
		EndTouch(self, entity)
	end
end

function ENT:OnTakeDamage(damageInfo)
	if (!self:GetHarvested() and (damageInfo:GetDamageType() == DMG_SLASH or damageInfo:GetDamageType() == DMG_CLUB)) then
		local attacker = damageInfo:GetAttacker()

		if (attacker:IsPlayer()) then
			self:OnHarvested(attacker, damageInfo:GetDamageType())
		end
	end
end
