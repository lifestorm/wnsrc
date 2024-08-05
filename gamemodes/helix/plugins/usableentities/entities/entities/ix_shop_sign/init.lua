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
	self:SetModel("models/sleepjie/opensign2.mdl")
	self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_NONE)

    self:SetSkin(1)

    local physObj = self:GetPhysicsObject()

    if IsValid(physObj) then
        physObj:EnableMotion(false)
        physObj:Sleep()
    end
end

function ENT:Use()
    self:ToggleState()
end

function ENT:ToggleState()
    local state = not self.enabled
    self.enabled = state
    self:SetSkin(state and 0 or 1)
    self:EmitSound("buttons/lightswitch2.wav")
end