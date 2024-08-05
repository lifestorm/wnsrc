--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local PenetColor = Color(255, 255, 255, 255)
local PenetMat = Material("trails/smoke")
local PenetMat2 = Material("effects/yellowflare")
local cv_gv = GetConVar("sv_gravity")
local cv_sl = GetConVar("cl_tfa_fx_impact_ricochet_sparklife")

--local cv_sc = GetConVar("cl_tfa_fx_impact_ricochet_sparks")
local DFX = {
	["AR2Tracer"] = true,
	["Tracer"] = true,
	["GunshipTracer"] = true,
	["GaussTracer"] = true,
	["AirboatGunTracer"] = true,
	["AirboatGunHeavyTracer"] = true
}

function EFFECT:Init(data)
	self.StartPos = data:GetOrigin()
	self.Dir = data:GetNormal()
	self.Dir:Normalize()
	self.Len = 32
	self.EndPos = self.StartPos + self.Dir * self.Len
	self.LifeTime = 0.75
	self.DieTime = CurTime() + self.LifeTime
	self.Thickness = 1
	self.Grav = Vector(0, 0, -cv_gv:GetFloat())
	self.PartMult = data:GetRadius()
	self.SparkLife = cv_sl:GetFloat()
	self.WeaponEnt = data:GetEntity()
	if not IsValid(self.WeaponEnt) then return end

	if self.WeaponEnt.TracerPCF then
		local traceres = util.QuickTrace(self.StartPos, self.Dir * 9999999, Entity(math.Round(data:GetScale())))
		self.EndPos = traceres.HitPos or self.StartPos
		local efn = self.WeaponEnt.TracerName
		local spos = self.StartPos
		local cnt = math.min(math.Round(data:GetMagnitude()), 6000)

		timer.Simple(cnt / 1000000, function()
			TFA.ParticleTracer(efn, spos, traceres.HitPos or spos, false)
		end)

		return
	end

	local tn = self.WeaponEnt.BulletTracerName

	if tn and tn ~= "" and not DFX[tn] then
		local fx = EffectData()
		fx:SetStart(self.StartPos)
		local traceres = util.QuickTrace(self.StartPos, self.Dir * 9999999, Entity(math.Round(data:GetScale())))
		self.EndPos = traceres.HitPos or self.StartPos
		fx:SetOrigin(self.EndPos)
		fx:SetEntity(self.WeaponEnt)
		fx:SetMagnitude(1)
		util.Effect(tn, fx)
		SafeRemoveEntityDelayed(self, 0)
		--Sparks
		--Impact

		return
	else
		local emitter = ParticleEmitter(self.StartPos)
		--[[
		for i = 1, cv_sc:GetFloat() * self.PartMult * 0.1 do
			local part = emitter:Add("effects/yellowflare", self.StartPos)
			part:SetVelocity((self.Dir + VectorRand() * 0.5) * math.Rand(75, 185))
			part:SetDieTime(math.Rand(0.25, 1) * self.SparkLife)
			part:SetStartAlpha(255)
			part:SetStartSize(math.Rand(2, 4))
			part:SetEndSize(0)
			part:SetRoll(0)
			part:SetGravity(self.Grav)
			part:SetCollide(true)
			part:SetBounce(0.55)
			part:SetAirResistance(0.5)
			part:SetStartLength(0.2)
			part:SetEndLength(0)
			part:SetVelocityScale(true)
			part:SetCollide(true)
		end
		]]
		--
		local part = emitter:Add("effects/select_ring", self.StartPos)
		part:SetStartAlpha(225)
		part:SetStartSize(1)
		part:SetDieTime(self.LifeTime / 5)
		part:SetEndSize(0)
		part:SetEndAlpha(0)
		part:SetRoll(math.Rand(0, 360))
		part:SetColor(200, 200, 200)
		part = emitter:Add("effects/select_ring", self.StartPos)
		part:SetStartAlpha(255)
		part:SetStartSize(1.5 * self.PartMult)
		part:SetDieTime(self.LifeTime / 6)
		part:SetEndSize(0)
		part:SetEndAlpha(0)
		part:SetRoll(math.Rand(0, 360))
		part:SetColor(200, 200, 200)
		emitter:Finish()
	end
end

function EFFECT:Think()
	if self.DieTime and (CurTime() > self.DieTime) then return false end

	return true
end

function EFFECT:Render()
	if self.DieTime then
		local fDelta = (self.DieTime - CurTime()) / self.LifeTime
		fDelta = math.Clamp(fDelta, 0, 1)
		render.SetMaterial(PenetMat)
		local color = ColorAlpha(PenetColor, 32 * fDelta)
		local precision = 16
		local i = 1

		while i <= precision do
			render.DrawBeam(self.StartPos + self.Dir * self.Len * ((i - 1) / precision), self.StartPos + self.Dir * self.Len * (i / precision), self.Thickness * fDelta * (1 - i / precision), 0.5, 0.5, color)
			i = i + 1
		end

		render.SetMaterial(PenetMat2)
		i = 1

		while i <= precision do
			render.DrawBeam(self.StartPos + self.Dir * self.Len * ((i - 1) / precision), self.StartPos + self.Dir * self.Len * (i / precision), self.Thickness / 3 * 2 * fDelta * (1 - i / precision), 0.5, 0.5, color)
			i = i + 1
		end
	end
end