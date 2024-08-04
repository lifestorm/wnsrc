--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


--Main function
function EFFECT:Init(data)
	--Muzzle and desired position vectors
	local StartPos = self:GetTracerShootPos(self.Position, data:GetEntity(), data:GetAttachment())
	local HitPos = data:GetOrigin()

	if (data:GetEntity():IsValid() and StartPos and HitPos) then
		local FlameEmitter = ParticleEmitter(StartPos)
			--Amount of particles to create
			for i=0, 8 do
				if (!FlameEmitter) then return end

				--Pool of flame sprites
				local FlameMat = {}
				FlameMat[1] = "effects/muzzleflash2"
				FlameMat[2] = "effects/muzzleflash2edit"
				FlameMat[3] = "effects/muzzleflash3"

				local FlameParticle = FlameEmitter:Add(FlameMat[math.random(1,3)], StartPos)

				if (math.random(1,16) == 16) then
					FlameParticle = FlameEmitter:Add("sprites/heatwave", StartPos)
				end

				if (FlameParticle) then
					FlameParticle:SetVelocity(((HitPos - StartPos):GetNormal() * math.random(1720,1820)) + (VectorRand() * math.random(142,172)))
					FlameParticle:SetLifeTime(0)
					FlameParticle:SetDieTime(0.52)
					FlameParticle:SetStartAlpha(math.random(92,132))
					FlameParticle:SetEndAlpha(0)
					FlameParticle:SetStartSize(math.random(4,6))
					FlameParticle:SetEndSize(math.random(32,52))
					FlameParticle:SetRoll(math.Rand(-360, 360))
					FlameParticle:SetRollDelta(math.Rand(-7.2, 7.2))
					FlameParticle:SetAirResistance(math.random(128, 256))
					FlameParticle:SetCollide(true)
					FlameParticle:SetGravity(Vector(0, 0, 64))
				end
			end
		FlameEmitter:Finish()

		local SmokeEmitter = ParticleEmitter(StartPos)
			--Amount of particles to create
			for i=0, 2 do
				if (!SmokeEmitter) then return end

				SmokeParticle = SmokeEmitter:Add("particle/smokesprites_000" .. math.random(1,8) .. "", StartPos)

				if (SmokeParticle) then
					SmokeParticle:SetVelocity(((HitPos - StartPos):GetNormal() * math.random(1720,1820)) + (VectorRand() * math.random(152,182)))
					SmokeParticle:SetLifeTime(0)
					SmokeParticle:SetDieTime(math.Rand(0.92, 1.72))
					SmokeParticle:SetStartAlpha(math.random(52,92))
					SmokeParticle:SetEndAlpha(0)
					SmokeParticle:SetStartSize(math.random(8,10))
					SmokeParticle:SetEndSize(math.random(62,82))
					SmokeParticle:SetRoll(math.Rand(-360, 360))
					SmokeParticle:SetRollDelta(math.Rand(-5.2, 5.2))
					SmokeParticle:SetAirResistance(math.random(132, 262))
					SmokeParticle:SetCollide(true)
					SmokeParticle:SetGravity(Vector(0, 0, -92))
					SmokeParticle:SetLighting(1)
				end
			end
		SmokeEmitter:Finish()
	end
end

--Kill effect
function EFFECT:Think()
	return false
end

--Unused
function EFFECT:Render() end
