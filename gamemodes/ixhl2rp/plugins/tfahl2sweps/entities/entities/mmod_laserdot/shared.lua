--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if SERVER then AddCSLuaFile("shared.lua") end

ENT.Type			= "anim"
ENT.PrintName		= "HL2 MMod RPG Laser Spot"
ENT.Author			= "Upset"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "DrawLaser")
end

if SERVER then

function ENT:Initialize()
	self:DrawShadow(false)
end

function ENT:Suspend(flSuspendTime)
	self:SetDrawLaser(false)
	timer.Simple(flSuspendTime, function()
		if self and IsValid(self) then
			self:Revive()
		end
	end)
end

function ENT:Revive()
	self:SetDrawLaser(true)
end

else

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local laser = Material("sprites/redglow1")

function ENT:DrawTranslucent()
	if !self:GetDrawLaser() then return end
	local owner = self:GetOwner()
	if !owner or !IsValid(owner) or !owner:Alive() then return end
	local tr = owner:GetEyeTrace()
	local pos = tr.HitPos
	local norm = tr.HitNormal
	local scale = 16.0 + math.Rand(-4.0, 4.0)

	render.SetMaterial(laser)
	render.DrawSprite(pos + norm * 3 - EyeVector() * 4, 1 * scale, 1 * scale, Color(255,255,255,255))	
end

function ENT:Think()
	local owner = self:GetOwner()
	if IsValid(owner) then
		self:SetRenderBoundsWS(LocalPlayer():EyePos(), owner:GetEyeTrace().HitPos)
	end
end

end