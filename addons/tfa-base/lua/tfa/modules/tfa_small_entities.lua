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

-- This file contain aliases/slight modifications which do not deserve their own Lua file

weapons.Register({
	Base = "tfa_nade_base",
	AllowUnderhanded = true,
}, "tfa_cssnade_base")

weapons.Register({
	Base = "tfa_gun_base",
	Shotgun = true,
}, "tfa_shotty_base")

weapons.Register({
	Base = "tfa_gun_base",
}, "tfa_akimbo_base")

if SERVER then
	AddCSLuaFile("tfa/3dscoped_base.lua")
end

local SWEP_ = include("tfa/3dscoped_base.lua")
local SWEP = table.Copy(SWEP_)
SWEP.Secondary = {}

SWEP.Secondary.ScopeZoom = 1
SWEP.Secondary.UseACOG = false
SWEP.Secondary.UseMilDot = false
SWEP.Secondary.UseSVD = false
SWEP.Secondary.UseParabolic = false
SWEP.Secondary.UseElcan = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.RTScopeFOV = 6
SWEP.RTScopeAttachment = 3 --Anchor the scope shadow to this
SWEP.Scoped = false
SWEP.BoltAction = false
SWEP.ScopeLegacyOrientation = false --used to align with eyeangles instead of vm angles
SWEP.ScopeAngleTransforms = {}
--{"P",1} --Pitch, 1
--{"Y",1} --Yaw, 1
--{"R",1} --Roll, 1
SWEP.ScopeOverlayTransforms = {0, 0}
SWEP.ScopeOverlayTransformMultiplier = 0.8
SWEP.RTMaterialOverride = 1
SWEP.IronSightsSensitivity = 1
SWEP.ScopeShadow = nil
SWEP.ScopeReticule = nil
SWEP.ScopeDirt = nil
SWEP.ScopeReticule_CrossCol = false
SWEP.ScopeReticule_Scale = {1, 1}
--[[End of Tweakable Parameters]]--
SWEP.Scoped_3D = true
SWEP.BoltAction_3D = false

SWEP.Base = "tfa_bash_base"

weapons.Register(SWEP, "tfa_3dbash_base")

SWEP = table.Copy(SWEP_)
SWEP.Secondary = {}

SWEP.Secondary.ScopeZoom = 0
SWEP.Secondary.UseACOG = false
SWEP.Secondary.UseMilDot = false
SWEP.Secondary.UseSVD = false
SWEP.Secondary.UseParabolic = false
SWEP.Secondary.UseElcan = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.RTScopeFOV = 6
SWEP.RTScopeAttachment = 3
SWEP.Scoped = false
SWEP.BoltAction = false
SWEP.ScopeLegacyOrientation = false --used to align with eyeangles instead of vm angles
SWEP.ScopeAngleTransforms = {}
--{"P",1} --Pitch, 1
--{"Y",1} --Yaw, 1
--{"R",1} --Roll, 1
SWEP.ScopeOverlayTransforms = {0, 0}
SWEP.ScopeOverlayTransformMultiplier = 0.8
SWEP.RTMaterialOverride = 1
SWEP.IronSightsSensitivity = 1
SWEP.ScopeShadow = nil
SWEP.ScopeReticule = nil
SWEP.ScopeDirt = nil
SWEP.ScopeReticule_CrossCol = false
SWEP.ScopeReticule_Scale = {1, 1}
--[[End of Tweakable Parameters]]--
SWEP.Scoped_3D = true
SWEP.BoltAction_3D = false

SWEP.Base = "tfa_gun_base"

weapons.Register(SWEP, "tfa_3dscoped_base")

weapons.Register({
	Base = "tfa_gun_base",

	Secondary = {
		ScopeZoom = 0,
		UseACOG = false,
		UseMilDot = false,
		UseSVD = false,
		UseParabolic = false,
		UseElcan = false,
		UseGreenDuplex = false,
	},

	Scoped = true,
	BoltAction = false,
}, "tfa_scoped_base")

local ammo = {
	["357"] = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "357",
		Category = "TFA Ammunition",
		Spawnable = true,
		AdminSpawnable = true,
		Class = "",
		MyModel = "models/Items/357ammo.mdl",
		AmmoCount = 25,
		AmmoType = "357",
		DrawText = true,
		TextColor = Color(225, 225, 225, 255),
		TextPosition = Vector(5, 0, 7.5),
		TextAngles = Vector(42, 90, 0),
		ShouldDrawShadow = true,
		ImpactSound = "Default.ImpactSoft",
		Damage = 50,
	},

	ar2 = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "Assault Ammo",
		Category = "TFA Ammunition",
		Spawnable = true,
		AdminSpawnable = true,
		Class = "",
		MyModel = "models/Items/BoxMRounds.mdl",
		AmmoCount = 100,
		AmmoType = "ar2",
		DrawText = true,
		TextColor = Color(5, 5, 5, 255),
		TextPosition = Vector(2, 1.5, 13.4),
		TextAngles = Vector(90, 90, 90),
		ShouldDrawShadow = true,
		ImpactSound = "Default.ImpactSoft",
		Damage = 35,
		Text = "Assault Ammo",
	},

	buckshot = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "Buckshot",
		Category = "TFA Ammunition",
		Spawnable = true,
		AdminSpawnable = true,
		Class = "",
		MyModel = "models/Items/BoxBuckshot.mdl",
		AmmoCount = 20,
		AmmoType = "buckshot",
		DrawText = true,
		TextColor = Color(225, 225, 225, 255),
		TextPosition = Vector(2, 3.54, 3),
		TextAngles = Vector(0, 90, 90),
		ShouldDrawShadow = true,
		ImpactSound = "Default.ImpactSoft",
		Damage = 40,
		Text = "Buckshot",
	},

	pistol = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "Pistol Rounds",
		Category = "TFA Ammunition",
		Spawnable = true,
		AdminSpawnable = true,
		Class = "",
		MyModel = "models/Items/BoxSRounds.mdl",
		AmmoCount = 100,
		AmmoType = "pistol",
		DrawText = true,
		TextColor = Color(255, 255, 255, 255),
		TextPosition = Vector(2, 1.5, 11.6),
		TextAngles = Vector(90, 90, 90),
		ShouldDrawShadow = true,
		ImpactSound = "Default.ImpactSoft",
		Damage = 40,
		Text = "Pistol Rounds",
	},

	smg = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "SMG Rounds",
		Category = "TFA Ammunition",
		Spawnable = true,
		AdminSpawnable = true,
		Class = "",
		MyModel = "models/Items/BoxSRounds.mdl",
		AmmoCount = 100,
		AmmoType = "smg1",
		DrawText = true,
		TextColor = Color(255, 255, 255, 255),
		TextPosition = Vector(2, 1.5, 11.6),
		TextAngles = Vector(90, 90, 90),
		ShouldDrawShadow = true,
		ImpactSound = "Default.ImpactSoft",
		Damage = 20,
		Text = "SMG Rounds",
	},

	smg1_grenade = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "SMG Grenade",
		Category = "TFA Ammunition",

		Spawnable = true,
		AdminSpawnable = true,

		MyModel = "models/items/tfa/ar2_grenade.mdl",

		AmmoType = "SMG1_Grenade",
		AmmoCount = 1,

		DamageThreshold = 15,
	},

	smg1_grenade_large = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "SMG Grenades",
		Category = "TFA Ammunition",

		Spawnable = true,
		AdminSpawnable = true,

		MyModel = "models/items/tfa/boxar2grenades.mdl",

		AmmoType = "SMG1_Grenade",
		AmmoCount = 5,

		DamageThreshold = 55,
	},

	sniper_rounds = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "Sniper Ammo",
		Category = "TFA Ammunition",
		Spawnable = true,
		AdminSpawnable = true,
		Class = "",
		MyModel = "models/Items/sniper_round_box.mdl",
		AmmoCount = 30,
		AmmoType = "SniperPenetratedRound",
		DrawText = true,
		TextColor = Color(185, 25, 25, 255),
		TextPosition = Vector(1, -1.45, 2.1),
		TextAngles = Vector(90, 0, 0),
		ShouldDrawShadow = true,
		ImpactSound = "Default.ImpactSoft",
		Damage = 80,
		Text = "Sniper Rounds",
		TextScale = 0.5,
	},

	winchester = {
		Type = "anim",
		Base = "tfa_ammo_base",
		PrintName = "Winchester Ammo",
		Category = "TFA Ammunition",
		Spawnable = true,
		AdminSpawnable = true,
		Class = "",
		MyModel = "models/Items/sniper_round_box.mdl",
		AmmoCount = 50,
		AmmoType = "AirboatGun",
		DrawText = true,
		TextColor = Color(185, 25, 25, 255),
		TextPosition = Vector(1, -1.45, 1.5),
		TextAngles = Vector(90, 0, 0),
		ShouldDrawShadow = true,
		ImpactSound = "Default.ImpactSoft",
		Damage = 30,
		Text = ".308",
	}
}

for ammoclass, ENT in pairs(ammo) do
	scripted_ents.Register(ENT, "tfa_ammo_" .. ammoclass)
end
