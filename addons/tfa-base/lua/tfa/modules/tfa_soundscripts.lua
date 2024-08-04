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

sound.Add({
	name = "Weapon_Bow.1",
	channel = CHAN_STATIC,
	volume = 1.0,
	sound = {"weapons/tfbow/fire1.wav", "weapons/tfbow/fire2.wav", "weapons/tfbow/fire3.wav"}
})

sound.Add({
	name = "Weapon_Bow.boltpull",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	sound = {"weapons/tfbow/pull1.wav", "weapons/tfbow/pull2.wav", "weapons/tfbow/pull3.wav"}
})

sound.Add({
	name = "TFA.NearlyEmpty",
	channel = CHAN_USER_BASE + 15,
	volume = 1,
	pitch = 100,
	level = 65,
	sound = "weapons/tfa/lowammo.wav"
})

sound.Add({
	name = "TFA.Bash",
	channel = CHAN_USER_BASE + 14,
	volume = 1.0,
	sound = {"weapons/tfa/bash1.wav", "weapons/tfa/bash2.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.BashWall",
	channel = CHAN_USER_BASE + 14,
	volume = 1.0,
	sound = "weapons/melee/rifle_swing_hit_world.wav",
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.BashFlesh",
	channel = CHAN_USER_BASE + 14,
	volume = 1.0,
	sound = {"weapons/melee/rifle_swing_hit_infected7.wav", "weapons/melee/rifle_swing_hit_infected8.wav", "weapons/melee/rifle_swing_hit_infected9.wav", "weapons/melee/rifle_swing_hit_infected10.wav", "weapons/melee/rifle_swing_hit_infected11.wav", "weapons/melee/rifle_swing_hit_infected12.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.IronIn",
	channel = CHAN_USER_BASE + 13,
	volume = 1.0,
	sound = {"weapons/tfa/ironin.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.IronOut",
	channel = CHAN_USER_BASE + 13,
	volume = 1.0,
	sound = {"weapons/tfa/ironout.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "Weapon_Pistol.Empty2",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	level = 80,
	sound = {"weapons/pistol/pistol_empty.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "Weapon_AR2.Empty2",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	level = 80,
	sound = {"weapons/ar2/ar2_empty.wav"},
	pitch = {97, 103}
})

sound.Add({
	name = "TFA.LowAmmo",
	channel = CHAN_USER_BASE + 15,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = ")weapons/tfa/lowammo_indicator_automatic.wav"
})
sound.Add({
	name = "TFA.LowAmmo_Dry",
	channel = CHAN_USER_BASE + 15,
	volume = 1.0,
	level = 75,
	pitch = 100,
	sound = ")weapons/tfa/lowammo_dry_automatic.wav"
})

local ammos = {
	["Handgun"] = "handgun",
	["Shotgun"] = "shotgun",
	["AutoShotgun"] = "shotgun_auto",
	["MachineGun"] = "mg",
	["AssaultRifle"] = "ar",
	["DMR"] = "dmr",
	["Revolver"] = "revolver",
	["Sniper"] = "sr",
	["SMG"] = "smg",
	["SciFi"] = "scifi",
	["GL"] = "gl",
}
for k,v in pairs(ammos) do
	sound.Add({
		name = "TFA.LowAmmo." .. k, -- "TFA.LowAmmo.Handgun"
		channel = CHAN_USER_BASE + 15,
		volume = 1.0,
		level = 75,
		pitch = 100,
		sound = ")weapons/tfa/lowammo_indicator_" .. v .. ".wav"
	})
	sound.Add({
		name = "TFA.LowAmmo." .. k .. "_Dry", -- "TFA.LowAmmo.Handgun_Dry"
		channel = CHAN_USER_BASE + 15,
		volume = 1.0,
		level = 75,
		pitch = 100,
		sound = ")weapons/tfa/lowammo_dry_" .. v .. ".wav"
	})
end