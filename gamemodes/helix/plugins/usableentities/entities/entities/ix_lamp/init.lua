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

	self:SetNetVar("enabled", false)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:Use()
	local data = PLUGIN.usableEntityLookup[string.lower(self:GetModel())]

	self:EmitSound(data.sound or "buttons/lightswitch2.wav")
	self:SetNetVar("enabled", !self:GetNetVar("enabled"))

	if (data.changeSkin) then
		self:SetSkin(self:GetNetVar("enabled") and 1 or 0)
	end
end
