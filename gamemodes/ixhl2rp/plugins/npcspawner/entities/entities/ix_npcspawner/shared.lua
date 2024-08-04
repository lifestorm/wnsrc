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
ENT.PrintName = "NPC Spawner"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Enabled")
	self:NetworkVar("String", 0, "NPCClass")
	self:NetworkVar("Float", 1, "PlayerNoSpawnRange")
	self:NetworkVar("Float", 2, "MaxNPCs")
	self:NetworkVar("Float", 3, "SpawnInterval")
	self:NetworkVar("Vector", 4, "SpawnPosStart")
	self:NetworkVar("Vector", 5, "SpawnPosEnd")	
end 
function ENT:SpawnAreaPosition(startPosition, endPosition)
	local center = LerpVector(0.5, startPosition, endPosition)
	local min = WorldToLocal(startPosition, angle_zero, center, angle_zero)
	local max = WorldToLocal(endPosition, angle_zero, center, angle_zero)

	return center, min, max
end