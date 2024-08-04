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

AddCSLuaFile("cl_init.lua") -- Make sure clientside
AddCSLuaFile("shared.lua")  -- and shared scripts are sent.

include('shared.lua')

function ENT:SpawnFunction(ply, tr)
    if !tr.Hit then return end

    local SpawnPos = tr.HitPos + tr.HitNormal * 16
    local ent = ents.Create(self.ClassName)
    ent:SetPos(SpawnPos)
    ent:Spawn()
    ent:Activate()

	ix.saveEnts:SaveEntity(ent)

    return ent
end

function ENT:Initialize()
	local path = "models/fruity/new_combine_monitor2"
	self:SetModel(self.tv and "models/props_c17/tv_monitor01.mdl" or !self.small and path..".mdl" or path.."_small.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local physics = self:GetPhysicsObject()

	if (physics and IsValid(physics)) then
		physics:EnableMotion(false)
		physics:Wake()
	end

	if (self.OnInitialize) then
		self:OnInitialize()
	end
end
