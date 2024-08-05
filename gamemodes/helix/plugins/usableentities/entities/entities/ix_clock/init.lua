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
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetNetVar("enabled", true)
	self:SetNetVar("lastTime", 0)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:Use()
	local isEnabled = self:GetNetVar("enabled")
	self:EmitSound("buttons/lightswitch2.wav")
	
	if (isEnabled) then
		self:SetNetVar("lastTime", StormFox2 and ix.date.GetFormatted(StormFox2.Time.TimeToString()) or ix.date.GetFormatted("%H:%M"))
		self:SetNetVar("enabled", false)
	else
		self:SetNetVar("enabled", true)
		self:SetNetVar("lastTime", nil)
	end
end
