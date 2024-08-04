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

function EFFECT:Init(data)
	local ply = data:GetEntity()
	local ent

	if IsValid(ply) and ply:IsPlayer() then
		ent = ply:GetActiveWeapon()
	end

	local sfac = (IsValid(ent) and ent.Primary and ent.Primary.Damage) and math.sqrt(ent.Primary.Damage / 30) or 1
	local sfac_sqrt = math.sqrt(sfac)
	local posoffset = data:GetOrigin()
	local forward = data:GetNormal()
	local emitter = ParticleEmitter(posoffset)

	for i = 0, math.Round(8 * sfac) do
		local p = emitter:Add("particle/particle_smokegrenade", posoffset)
		p:SetVelocity(90 * math.sqrt(i) * forward)
		p:SetAirResistance(400)
		p:SetStartAlpha(math.Rand(255, 255))
		p:SetEndAlpha(0)
		p:SetDieTime(math.Rand(0.75, 1) * (1 + math.sqrt(i) / 3))
		local iclamped = math.Clamp(i, 1, 8)
		local iclamped_sqrt = math.sqrt(iclamped / 8) * 8
		p:SetStartSize(math.Rand(1, 1) * sfac_sqrt * iclamped_sqrt)
		p:SetEndSize(math.Rand(1.5, 1.75) * sfac_sqrt * iclamped)
		p:SetRoll(math.Rand(-25, 25))
		p:SetRollDelta(math.Rand(-0.05, 0.05))
		p:SetColor(255, 255, 255)
		p:SetLighting(true)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
return false
end