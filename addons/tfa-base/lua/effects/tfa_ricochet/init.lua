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

local RicochetColor = Color(255, 255, 255, 255)
local RicochetIDOffset = 33
local RicochetMat = Material("effects/yellowflare")
local cv_gv = GetConVar("sv_gravity")
local cv_sl = GetConVar("cl_tfa_fx_impact_ricochet_sparklife")
local cv_sc = GetConVar("cl_tfa_fx_impact_ricochet_sparks")

function EFFECT:Init(data)
	self.StartPos = data:GetOrigin()
	self.Dir = data:GetNormal()
	self.Dir:Normalize()
	self.Len = 128
	self.EndPos = self.StartPos + self.Dir * self.Len
	self.LifeTime = 0.1
	self.DieTime = CurTime() + self.LifeTime
	self.Grav = Vector(0, 0, -cv_gv:GetFloat())
	self.PartMult = data:GetMagnitude()
	self.SparkLife = cv_sl:GetFloat()
	local emitter = ParticleEmitter(self.StartPos)

	--Sparks
	for _ = 1, cv_sc:GetInt() * self.PartMult do
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

	--Impact
	local part = emitter:Add("effects/yellowflare", self.StartPos)
	part:SetStartAlpha(225)
	part:SetStartSize(64)
	part:SetDieTime(self.LifeTime)
	part:SetEndSize(0)
	part:SetEndAlpha(0)
	part:SetRoll(math.Rand(0, 360))
	part = emitter:Add("effects/yellowflare", self.StartPos)
	part:SetStartAlpha(255)
	part:SetStartSize(30 * self.PartMult)
	part:SetDieTime(self.LifeTime * 1.5)
	part:SetEndSize(0)
	part:SetEndAlpha(0)
	part:SetRoll(math.Rand(0, 360))
	emitter:Finish()
	local dlight = DynamicLight(LocalPlayer():EntIndex() + RicochetIDOffset)

	if (dlight) then
		dlight.Pos = self.StartPos
		dlight.r = 255
		dlight.g = 225
		dlight.b = 185
		dlight.Brightness = 2.75 * self.PartMult
		dlight.size = 48
		--dlight.DieTime 	= CurTime() + self.DieTime*0.7
		dlight.Decay = 1000 / math.max(0.01, math.min(self.SparkLife * 0.66, 1))
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
		render.SetMaterial(RicochetMat)
		local color = ColorAlpha(RicochetColor, 255 * fDelta)
		local precision = 16
		local i = 1

		while i <= precision do
			render.DrawBeam(self.StartPos + self.Dir * self.Len * ((i - 1) / precision), self.StartPos + self.Dir * self.Len * (i / precision), 8 * fDelta * (1 - i / precision), 0.5, 0.5, color)
			i = i + 1
		end
	end
end