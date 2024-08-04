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

TFA.Particles = TFA.Particles or {}
TFA.Particles.FlareParts = {}
TFA.Particles.VMAttachments = {}

TFA.Particles.PCFParticles = TFA.Particles.PCFParticles or {}

TFA.Particles.PCFParticles["tfa_muzzle_rifle"] = "tfa_muzzleflashes"
TFA.Particles.PCFParticles["tfa_muzzle_sniper"] = "tfa_muzzleflashes"
TFA.Particles.PCFParticles["tfa_muzzle_energy"] = "tfa_muzzleflashes"
TFA.Particles.PCFParticles["tfa_muzzle_energy"] = "tfa_muzzleflashes"
TFA.Particles.PCFParticles["tfa_muzzle_gauss"] = "tfa_muzzleflashes"

-- TFA.Particles.PCFParticles["weapon_muzzle_smoke_long"] = "csgo_fx"
-- TFA.Particles.PCFParticles["weapon_muzzle_smoke"] = "csgo_fx"

TFA.Particles.PCFParticles["tfa_ins2_weapon_muzzle_smoke"] = "tfa_ins2_muzzlesmoke"
TFA.Particles.PCFParticles["tfa_ins2_weapon_shell_smoke"] = "tfa_ins2_shellsmoke"
TFA.Particles.PCFParticles["tfa_bullet_smoke_tracer"] = "tfa_ballistics"
TFA.Particles.PCFParticles["tfa_bullet_fire_tracer"] = "tfa_ballistics"
TFA.Particles.PCFParticles["tfa_ins2_shell_eject"] = "tfa_ins2_ejectionsmoke"

--legacy
TFA.Particles.PCFParticles["smoke_trail_tfa"] = "tfa_smoke"
TFA.Particles.PCFParticles["smoke_trail_controlled"] = "tfa_smoke"

TFA.Particles.SmokeLightingMin = Vector(0.15, 0.15, 0.15)
TFA.Particles.SmokeLightingMax = Vector(0.75, 0.75, 0.75)
TFA.Particles.SmokeLightingClamp = 1

local addedparts = {}
local cachedparts = {}

function TFA.Particles.Initialize()
	for k, v in pairs(TFA.Particles.PCFParticles) do
		if not addedparts[v] then
			game.AddParticles("particles/" .. v .. ".pcf")
			addedparts[v] = true
		end

		if not cachedparts[k] and not string.find(k, "DUMMY") then
			PrecacheParticleSystem(k)
			cachedparts[k] = true
		end
	end
end

hook.Add("InitPostEntity", "TFA.Particles.Initialize", TFA.Particles.Initialize)
TFA.Particles.Initialize()
