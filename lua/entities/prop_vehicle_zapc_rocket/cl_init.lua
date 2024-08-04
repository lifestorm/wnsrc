--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include('shared.lua')

function ENT:Initialize()
	self.Emitter = ParticleEmitter(Vector(0, 0, 0))
	self.NextSmoke = CurTime()
end

function ENT:Think()
	-- Verify the emitter is still there.
	if not self.Emitter then
		self.Emitter = ParticleEmitter(Vector(0, 0, 0))
		-- in case that fails AGAIN.
		if not self.Emitter then
			return
		end
	end
	
	if CurTime() >= self.NextSmoke then
		local vec = -self:GetForward()
		local part = self.Emitter:Add('particles/smokey', self:GetPos() + vec*45)
			part:SetVelocity(vec)
			part:SetDieTime(0.8)
			part:SetStartAlpha(math.Rand(50, 150))
			part:SetStartSize(math.Rand(8, 16))
			part:SetEndSize(math.Rand(16, 32))
			part:SetRoll(math.Rand(-0.3, 0.3))
			part:SetColor(190, 190, 190, 180, 128)
			local part = self.Emitter:Add('particles/flamelet5', self:GetPos() + vec*15)
			part:SetVelocity(vec)
			part:SetDieTime(0.1)
			part:SetStartAlpha(math.Rand(150, 255))
			part:SetStartSize(math.Rand(2, 4))
			part:SetEndSize(math.Rand(8, 16))
			part:SetRoll(math.Rand(-0.3, 0.3))
			part:SetColor(190, 190, 190, 180, 128)
		self.NextSmoke = CurTime() + 0.015
	end
end