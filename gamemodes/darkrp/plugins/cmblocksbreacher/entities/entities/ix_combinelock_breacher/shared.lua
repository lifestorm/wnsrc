--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type = "anim"
ENT.PrintName = "Combine Lock Breacher"
ENT.Category = "HL2 RP"
ENT.Author = "Geferon"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Progress")
	self:NetworkVar("Bool", 0, "Breached")
end

local allowedClasses = {
	["ix_combinelock"] = true,
	["ix_combinelock_cwu"] = true,
	["ix_combinelock_dob"] = true,
	["ix_combinelock_cmru"] = true,
	["ix_combinelock_moe"] = true,
	["ix_grouplock"] = true
}

function ENT:SpawnToLock(lock)
	local entity = ents.Create("ix_combinelock_breacher")
	entity:Spawn()
	entity:Activate()
	entity:SetLock(lock)

	return entity
end

function ENT:SpawnFunction(client, trace)
	local traceEnt = trace.Entity

	if !(IsValid(traceEnt) and (traceEnt:IsDoor() or allowedClasses[traceEnt:GetClass()])) then
		return client:NotifyLocalized("dNotValid")
	end

	if (traceEnt:IsDoor() and !IsValid(traceEnt.ixLock)) then
		return client:NotifyLocalized("dNotValid")
	end

	local lockEnt = traceEnt
	if (traceEnt:IsDoor()) then
		lockEnt = traceEnt.ixLock
	end

	if IsValid(lockEnt.ixBreacher) then
		return client:NotifyLocalized("dNotValid")
	end

	local entity = self:SpawnToLock(lockEnt)

	return entity
end
