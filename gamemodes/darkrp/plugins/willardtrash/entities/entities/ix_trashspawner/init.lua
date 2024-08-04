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

function ENT:Initialize()
	self:SetModel("models/props_junk/Shoe001a.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetNoDraw(true)
	local phys = self:GetPhysicsObject()
	phys:SetMass(120)

	self:SetupNextSpawn()

	self:CallOnRemove(
		"KillParentTimer",
		function(ent)
			ent.dead = true
			timer.Remove("spawner_trash_"..ent:EntIndex())
	end)
end

function ENT:SetupNextSpawn()
	if (self.dead) then return end

	local variation = ix.config.Get("Trash Spawner Respawn Variation") * 60
	local duration = math.max(ix.config.Get("Trash Spawner Respawn Time") * 60 + math.random(-variation, variation), 60)
	self:SetNetVar("ixNextTrashSpawn", CurTime() + duration)

	local uniqueID = "spawner_trash_"..self:EntIndex()
	if (timer.Exists(uniqueID)) then timer.Remove(uniqueID) end

	timer.Create(uniqueID, duration, 1, function()
		if (IsValid(self)) then
			self:SetNetVar("ixNextTrashSpawn", -1)
			self.trashEnt = ents.Create("ix_garbage")
			if (IsValid(self.trashEnt)) then
				self.trashEnt:SetPos(self:GetPos())
				self.trashEnt.ixSpawner = self
				self.trashEnt:Spawn()
				self.trashEnt:CallOnRemove(
					"RestartTrashTimer",
					function(ent)
						if (IsValid(ent.ixSpawner)) then
							ent.ixSpawner:SetupNextSpawn()
						end
				end)
			end
		end
	end)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:PhysicsUpdate(physicsObject)
	if (!self:IsPlayerHolding() and !self:IsConstrained()) then
		physicsObject:SetVelocity( Vector(0, 0, 0) )
		physicsObject:Sleep()
	end
end

function ENT:Use(activator, caller)
	return
end

function ENT:CanTool(player, trace, tool)
	return false
end
