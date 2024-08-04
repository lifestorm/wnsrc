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

local sv_cheats_cv = GetConVar("sv_cheats")
local host_timescale_cv = GetConVar("host_timescale")
local ts

local en_cvar = GetConVar("sv_tfa_soundscale")

hook.Add("EntityEmitSound", "zzz_TFA_EntityEmitSound", function(soundData)
	local ent = soundData.Entity
	local modified
	local weapon

	if ent:IsWeapon() then
		weapon = ent
	elseif ent:IsNPC() or ent:IsPlayer() then
		weapon = ent:GetActiveWeapon()
	end

	if IsValid(weapon) and weapon.IsTFA and weapon.IsTFAWeapon then
		if weapon.GonnaAdjuctPitch then
			soundData.Pitch = soundData.Pitch * weapon.RequiredPitch
			weapon.GonnaAdjuctPitch = false
			modified = true
		end

		if weapon.GonnaAdjustVol then
			soundData.Volume = soundData.Volume * weapon.RequiredVolume
			weapon.GonnaAdjustVol = false
			modified = true
		end
	end

	if not en_cvar then return modified end
	if not en_cvar:GetBool() then return modified end
	ts = game.GetTimeScale()

	if sv_cheats_cv:GetBool() then
		ts = ts * host_timescale_cv:GetFloat()
	end

	if engine.GetDemoPlaybackTimeScale then
		ts = ts * engine.GetDemoPlaybackTimeScale()
	end

	if ts ~= 1 then
		soundData.Pitch = math.Clamp(soundData.Pitch * ts, 0, 255)
		return true
	end

	return modified
end)
