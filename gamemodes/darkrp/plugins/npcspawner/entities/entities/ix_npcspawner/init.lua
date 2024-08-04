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
	self:SetModel("models/props_junk/sawblade001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD) 
	self:DrawShadow(false)

	self:SetEnabled(false)
	self:SetNPCClass("npc_zombie")
	self:SetSpawnPosStart(self:GetPos() + (self:GetForward() * 60 + self:GetRight()*40))
	self:SetSpawnPosEnd(self:GetPos() + (self:GetForward() * -60 + self:GetRight()*-40 + self:GetUp()*128))

	self:SetPlayerNoSpawnRange(1000)
	self:SetMaxNPCs(5)
	self:SetSpawnInterval(300)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end
function ENT:RandomPos(mins, maxs)
	return mins + Vector(math.random(), math.random(), math.random()) * (maxs - mins)
end
function ENT:SpawnNPC()
	local position = self:RandomPos(self:GetSpawnPosStart(), self:GetSpawnPosEnd())
	
	position.z = position.z + 10

	local NPC = ents.Create(self:GetNPCClass())
	NPC:SetPos(position)
	NPC:SetNetVar("SpawnerID", self:EntIndex())
	NPC:Spawn()

	local isStuck = util.TraceEntity({
		start = NPC:GetPos(),
		endpos = NPC:GetPos(),
		filter = NPC
	}, NPC).StartSolid

	if (isStuck) then
		NPC:DropToFloor()

		local positions = ix.util.FindEmptySpace(NPC)

		for _, v in ipairs(positions) do
			NPC:SetPos(v)

			isStuck = util.TraceEntity({
				start = NPC:GetPos(),
				endpos = NPC:GetPos(),
				filter = NPC
			}, NPC).StartSolid

			if (!isStuck) then
				return
			end
		end

		-- If the NPC is still stuck just give up and put it on top of the spawner.
		NPC:SetPos(self:GetPos())
	end
end

function ENT:CanSpawnNPC()
	if (!self:GetEnabled()) then return false end

	local NPCs = {}

	for _, NPC in ipairs(ents.FindByClass(self:GetNPCClass())) do
		if (NPC:GetNetVar("SpawnerID", 0) == self:EntIndex()) then
			NPCs[#NPCs + 1] = true
		end
	end

	if (#NPCs >= self:GetMaxNPCs()) then return false end

	local nearbyPlayers = {}
	
	for _, entity in ipairs(ents.FindInSphere(self:GetPos(), self:GetPlayerNoSpawnRange())) do
		if (entity:IsPlayer()) then
			nearbyPlayers[#nearbyPlayers + 1] = true
		end
	end

	if (#nearbyPlayers > 0) then return false end

	return true
end

function ENT:SetupTimer(isEnabled)
	local identifier = "NPCSpawner" .. self:EntIndex()

	if (isEnabled) then
		if (timer.Exists(identifier)) then
			timer.Adjust(identifier, self:GetSpawnInterval(), 0, function()
				if (self:CanSpawnNPC()) then
					self:SpawnNPC()
				end
			end)
		else
			timer.Create(identifier, self:GetSpawnInterval(), 0, function()
				if (self:CanSpawnNPC()) then
					self:SpawnNPC()
				end
			end)
		end
	else
		if (timer.Exists(identifier)) then
			timer.Remove(identifier)
		end
	end
end

function ENT:OnRemove()
	local identifier = "NPCSpawner" .. self:EntIndex()

	if (timer.Exists(identifier)) then
		timer.Remove(identifier)
	end
end

function ENT:Use(activator)
	if (activator:IsAdmin()) then
		net.Start("NPCSpawner_Edit")
			net.WriteEntity(self)
			net.WriteBool(self:GetEnabled())
			net.WriteString(self:GetNPCClass())
			net.WriteFloat(self:GetPlayerNoSpawnRange())
			net.WriteFloat(self:GetMaxNPCs())
			net.WriteFloat(self:GetSpawnInterval())
		net.Send(activator)
	end
end
