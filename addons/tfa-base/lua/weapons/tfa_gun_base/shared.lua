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

SWEP.Category = "" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep.
SWEP.Author = "TheForgottenArchitect"
SWEP.Contact = "theforgottenarchitect"
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.Skin = 0 --Viewmodel skin
SWEP.Spawnable = false
SWEP.IsTFAWeapon = true

SWEP.LoopedReload = false
SWEP.ShotgunEmptyAnim = false
SWEP.ShotgunEmptyAnim_Shell = true
SWEP.ShotgunStartAnimShell = false --shotgun start anim inserts shell

SWEP.Secondary.IronSightsEnabled = true

SWEP.RegularMoveSpeedMultiplier = 1

SWEP.FireSoundAffectedByClipSize = true

SWEP.Primary.Damage = -1
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.NumShots = 1
SWEP.Primary.Force = -1
SWEP.Primary.Knockback = -1
SWEP.Primary.Recoil = 1
SWEP.Primary.RPM = 600
SWEP.Primary.RPM_Semi = -1
SWEP.Primary.RPM_Burst = -1
SWEP.Primary.StaticRecoilFactor = 0.5
SWEP.Primary.KickUp = 0.5
SWEP.Primary.KickDown = 0.5
SWEP.Primary.KickRight = 0.5
SWEP.Primary.KickHorizontal = 0.5
SWEP.Primary.DamageType = nil
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.Spread = 0
SWEP.Primary.DisplaySpread = true
SWEP.Primary.SpreadMultiplierMax = -1 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = -1 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = -1 --How much the spread recovers, per second.
SWEP.Primary.SpreadRecoveryDelay = 0
SWEP.Primary.IronAccuracy = 0
SWEP.Primary.Range = -1--1200
SWEP.Primary.RangeFalloff = -1--0.5
SWEP.Primary.PenetrationMultiplier = 1
SWEP.Primary.DryFireDelay = nil

--[[Actual clientside values]]--

SWEP.DrawAmmo                       = true              -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox              = false             -- Should draw the weapon info box
SWEP.BounceWeaponIcon               = false             -- Should the weapon icon bounce?

local sv_tfa_jamming = GetConVar("sv_tfa_jamming")
local sv_tfa_jamming_mult = GetConVar("sv_tfa_jamming_mult")
local sv_tfa_jamming_factor = GetConVar("sv_tfa_jamming_factor")
local sv_tfa_jamming_factor_inc = GetConVar("sv_tfa_jamming_factor_inc")

-- RP owners always like realism, so this feature might be something they like. Enable it for them!
TFA_AUTOJAMMING_ENABLED = string.find(engine.ActiveGamemode(), 'rp') or
	string.find(engine.ActiveGamemode(), 'roleplay') or
	string.find(engine.ActiveGamemode(), 'nutscript') or
	string.find(engine.ActiveGamemode(), 'serious') or
	TFA_ENABLE_JAMMING_BY_DEFAULT

SWEP.CanJam = tobool(TFA_AUTOJAMMING_ENABLED)

SWEP.JamChance = 0.04
SWEP.JamFactor = 0.06

SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.BoltAction_Forced = false
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.7

SWEP.MuzzleAttachment = "1"
SWEP.ShellAttachment = "2"

SWEP.MuzzleFlashEnabled = true
SWEP.MuzzleFlashEffect = nil
SWEP.MuzzleFlashEffectSilenced = "tfa_muzzleflash_silenced"
SWEP.CustomMuzzleFlash = true

SWEP.EjectionSmokeEnabled = true

SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = nil --Defaults to blowback

SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype

SWEP.StatusLengthOverride = {} --Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
SWEP.SequenceLengthOverride = {} --Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceTimeOverride = {} --Like above but changes animation length to a target
SWEP.SequenceRateOverride = {} --Like above but scales animation length rather than being absolute

SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0, -1, 0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.BlowbackAllowAnimation = false

SWEP.ProceduralHolsterEnabled = nil
SWEP.ProceduralHolsterTime = 0.3
SWEP.ProceduralHolsterPosition = Vector(3, 0, -5)
SWEP.ProceduralHolsterAngle = Vector(-40, -30, 10)

SWEP.IsProceduralReloadBased = false --Do we reload using lua instead of a .mdl animation
SWEP.ProceduralReloadTime = 1 --Time to take when procedurally reloading, including transition in (but not out)

SWEP.Blowback_PistolMode_Disabled = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_DRAW_EMPTY] = true,
	[ACT_VM_IDLE_EMPTY] = true,
	[ACT_VM_HOLSTER_EMPTY] = true,
	[ACT_VM_DRYFIRE] = true,
	[ACT_VM_FIDGET] = true,
	[ACT_VM_FIDGET_EMPTY] = true
}

SWEP.Blowback_Shell_Enabled = true
SWEP.Blowback_Shell_Effect = "ShellEject"

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Customize_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintFOVOffset = 5
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation

SWEP.IronSightTime = 0.3
SWEP.IronSightsSensitivity = 1

SWEP.InspectPosDef = Vector(9.779, -11.658, -2.241)
SWEP.InspectAngDef = Vector(24.622, 42.915, 15.477)

SWEP.SprintViewModelPosition = Vector(0,0,0)
SWEP.SprintViewModelAngle = Vector(0,0,0)
SWEP.AllowSprintAttack = false --Shoot while sprinting?

SWEP.CrouchViewModelPosition = Vector(0, -1, -.5)
SWEP.CrouchViewModelAngle = Vector(0, 0, 0)

SWEP.Primary.RecoilLUT_IronSightsMult = 0.5
SWEP.Primary.RecoilLUT_AnglePunchMult = 0.25
SWEP.Primary.RecoilLUT_ViewPunchMult = 1

SWEP.EventTable = {}

SWEP.RTMaterialOverride = nil
SWEP.RTOpaque = false
SWEP.RTCode = nil--function(self) return end
SWEP.RTBGBlur = true

SWEP.ViewModelPosition = Vector(0,0,0)
SWEP.ViewModelAngle = Vector(0,0,0)
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.AdditiveViewModelPosition = true

SWEP.AllowIronSightsDoF = true

SWEP.Primary.DisplayFalloff = true

SWEP.IronAnimation = {
	--[[
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Idle_To_Iron", --Number for act, String/Number for sequence
		["value_empty"] = "Idle_To_Iron_Dry",
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Idle_Iron", --Number for act, String/Number for sequence
		["value_empty"] = "Idle_Iron_Dry"
	}, --Looping Animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Iron_To_Idle", --Number for act, String/Number for sequence
		["value_empty"] = "Iron_To_Idle_Dry",
		["transition"] = true
	}, --Outward transition
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Fire_Iron", --Number for act, String/Number for sequence
		["value_last"] = "Fire_Iron_Last",
		["value_empty"] = "Fire_Iron_Dry"
	} --What do you think
	]]--
}

SWEP.SprintAnimation = {
	--[[
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Idle_to_Sprint", --Number for act, String/Number for sequence
		["value_empty"] = "Idle_to_Sprint_Empty",
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Sprint_", --Number for act, String/Number for sequence
		["value_empty"] = "Sprint_Empty_",
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Sprint_to_Idle", --Number for act, String/Number for sequence
		["value_empty"] = "Sprint_to_Idle_Empty",
		["transition"] = true
	} --Outward transition
	]]--
}

SWEP.ShootAnimation = {--[[
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "shoot_loop_start", --Number for act, String/Number for sequence
		["value_is"] = "shoot_loop_iron_start"
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "shoot_loop", --Number for act, String/Number for sequence
		["value_is"] = "shoot_loop_iron",
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "shoot_loop_end", --Number for act, String/Number for sequence
		["value_is"] = "shoot_loop_iron_end"
	}]]--
}

SWEP.FirstDeployEnabled = nil--Force first deploy enabled

--[[Dont edit under this unless you know what u r doing]]

SWEP.IronSightsProgress = 0
SWEP.CLIronSightsProgress = 0
SWEP.SprintProgress = 0
SWEP.WalkProgress = 0
SWEP.SpreadRatio = 0
SWEP.CrouchingRatio = 0
SWEP.SmokeParticles = {
	pistol = "tfa_ins2_weapon_muzzle_smoke",
	smg = "tfa_ins2_weapon_muzzle_smoke",
	grenade = "tfa_ins2_weapon_muzzle_smoke",
	ar2 = "tfa_ins2_weapon_muzzle_smoke",
	shotgun = "tfa_ins2_weapon_muzzle_smoke",
	rpg = "tfa_ins2_weapon_muzzle_smoke",
	physgun = "tfa_ins2_weapon_muzzle_smoke",
	crossbow = "tfa_ins2_weapon_muzzle_smoke",
	melee = "tfa_ins2_weapon_muzzle_smoke",
	slam = "tfa_ins2_weapon_muzzle_smoke",
	normal = "tfa_ins2_weapon_muzzle_smoke",
	melee2 = "tfa_ins2_weapon_muzzle_smoke",
	knife = "tfa_ins2_weapon_muzzle_smoke",
	duel = "tfa_ins2_weapon_muzzle_smoke",
	camera = "tfa_ins2_weapon_muzzle_smoke",
	magic = "tfa_ins2_weapon_muzzle_smoke",
	revolver = "tfa_ins2_weapon_muzzle_smoke",
	silenced = "tfa_ins2_weapon_muzzle_smoke"
}
--[[ SWEP.SmokeParticles = {
	pistol = "weapon_muzzle_smoke",
	smg = "weapon_muzzle_smoke",
	grenade = "weapon_muzzle_smoke",
	ar2 = "weapon_muzzle_smoke",
	shotgun = "weapon_muzzle_smoke_long",
	rpg = "weapon_muzzle_smoke_long",
	physgun = "weapon_muzzle_smoke_long",
	crossbow = "weapon_muzzle_smoke_long",
	melee = "weapon_muzzle_smoke",
	slam = "weapon_muzzle_smoke",
	normal = "weapon_muzzle_smoke",
	melee2 = "weapon_muzzle_smoke",
	knife = "weapon_muzzle_smoke",
	duel = "weapon_muzzle_smoke",
	camera = "weapon_muzzle_smoke",
	magic = "weapon_muzzle_smoke",
	revolver = "weapon_muzzle_smoke_long",
	silenced = "weapon_muzzle_smoke"
}--]]
--[[
SWEP.SmokeParticles = {
	pistol = "smoke_trail_controlled",
	smg = "smoke_trail_tfa",
	grenade = "smoke_trail_tfa",
	ar2 = "smoke_trail_tfa",
	shotgun = "smoke_trail_wild",
	rpg = "smoke_trail_tfa",
	physgun = "smoke_trail_tfa",
	crossbow = "smoke_trail_tfa",
	melee = "smoke_trail_tfa",
	slam = "smoke_trail_tfa",
	normal = "smoke_trail_tfa",
	melee2 = "smoke_trail_tfa",
	knife = "smoke_trail_tfa",
	duel = "smoke_trail_tfa",
	camera = "smoke_trail_tfa",
	magic = "smoke_trail_tfa",
	revolver = "smoke_trail_tfa",
	silenced = "smoke_trail_controlled"
}
]]--

SWEP.Inspecting = false
SWEP.InspectingProgress = 0
SWEP.LuaShellRequestTime = -1
SWEP.BobScale = 0
SWEP.SwayScale = 0
SWEP.BoltDelay = 1
SWEP.ProceduralHolsterProgress = 0
SWEP.BurstCount = 0
SWEP.DefaultFOV = 90
SWEP.m_WeaponDeploySpeed = 255

--[[ Localize Functions  ]]
local function l_Lerp(v, f, t)
	return f + (t - f) * v
end
local l_mathApproach = math.Approach
local l_CT = CurTime
--[[Frequently Reused Local Vars]]
local stat --Weapon status
local ct  = 0--Curtime, frametime, real frametime
local sp = game.SinglePlayer() --Singleplayer
local developer = GetConVar("developer")

function SWEP:NetworkVarTFA(typeIn, nameIn)
	if not self.TrackedDTTypes then
		self.TrackedDTTypes = {
			Angle = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31},
			Bool = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31},
			Entity = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31},
			Float = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31},
			Int = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31},
			String = {0, 1, 2, 3},
			Vector = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31},
		}

		if istable(self.dt) then
			local meta = getmetatable(self.dt)

			if istable(meta) and isfunction(meta.__index) then
				local name, value = debug.getupvalue(meta.__index, 1)

				if name == "datatable" and istable(value) then
					for variableName, variableData in SortedPairs(value) do
						if istable(variableData) and isstring(variableData.typename) and isnumber(variableData.index) then
							local trackedData = self.TrackedDTTypes[variableData.typename]

							if trackedData then
								table.RemoveByValue(trackedData, variableData.index)
							end
						end
					end
				end
			end
		end
	end

	if not self.TrackedDTTypes[typeIn] then
		error("Variable type " .. typeIn .. " is invalid")
	end

	local gatherindex = table.remove(self.TrackedDTTypes[typeIn], 1)

	if gatherindex then
		(self["NetworkVar_TFA"] or self["NetworkVar"])(self, typeIn, gatherindex, nameIn)
		return
	end

	local get = self["GetNW2" .. typeIn]
	local set = self["SetNW2" .. typeIn]

	self["Set" .. nameIn] = function(_self, value)
		set(_self, nameIn, value)
	end

	self["Get" .. nameIn] = function(_self, def)
		return get(_self, nameIn, def)
	end

	if developer:GetBool() then
		print("[TFA Base] developer 1: Variable " .. nameIn .. " can not use DTVars due to " .. typeIn .. " index exhaust")
	end
end

local IsFirstTimePredicted = IsFirstTimePredicted

--[[
Function Name:  SetupDataTables
Syntax: Should not be manually called.
Returns:  Nothing.  Simple sets up DTVars to be networked.
Purpose:  Networking.
]]
function SWEP:SetupDataTables()
	self.TrackedDTTypes = nil
	self.NetworkVar_TFA = self.NetworkVar

	--self:NetworkVarTFA("Bool", "IronSights")
	self:NetworkVarTFA("Bool", "IronSightsRaw")
	self:NetworkVarTFA("Bool", "Sprinting")
	self:NetworkVarTFA("Bool", "Silenced")
	self:NetworkVarTFA("Bool", "ReloadLoopCancel")
	self:NetworkVarTFA("Bool", "Walking")
	self:NetworkVarTFA("Bool", "Customizing")

	self.GetShotgunCancel = self.GetReloadLoopCancel
	self.SetShotgunCancel = self.SetReloadLoopCancel

	self:NetworkVarTFA("Bool", "FlashlightEnabled")
	self:NetworkVarTFA("Bool", "Jammed")
	self:NetworkVarTFA("Bool", "FirstDeployEvent")
	self:NetworkVarTFA("Bool", "IsCyclingSafety")
	self:NetworkVarTFA("Bool", "SafetyCycleAnimated")
	self:NetworkVarTFA("Bool", "HasPlayedEmptyClick")

	self:NetworkVarTFA("Float", "StatusEnd")
	self:NetworkVarTFA("Float", "NextIdleAnim")
	self:NetworkVarTFA("Float", "NextLoopSoundCheck")
	self:NetworkVarTFA("Float", "JamFactor")
	self:NetworkVarTFA("Float", "EventTimer")
	self:NetworkVarTFA("Float", "LastGunFire")

	self:NetworkVarTFA("Int", "StatusRaw")
	self:NetworkVarTFA("Int", "FireMode")
	self:NetworkVarTFA("Int", "LastActivity")
	self:NetworkVarTFA("Int", "BurstCount")
	self:NetworkVarTFA("Int", "ShootStatus")
	self:NetworkVarTFA("Int", "EventStatus1")
	self:NetworkVarTFA("Int", "EventStatus2")
	self:NetworkVarTFA("Int", "EventStatus3")
	self:NetworkVarTFA("Int", "EventStatus4")
	self:NetworkVarTFA("Int", "EventStatus5")
	self:NetworkVarTFA("Int", "EventStatus6")
	self:NetworkVarTFA("Int", "EventStatus7")
	self:NetworkVarTFA("Int", "EventStatus8")

	self:NetworkVarTFA("Bool", "RecoilLoop")
	self:NetworkVarTFA("Bool", "RecoilThink")

	self:NetworkVarTFA("Float", "RecoilInProgress")
	self:NetworkVarTFA("Float", "RecoilInWait")
	self:NetworkVarTFA("Float", "RecoilLoopProgress")
	self:NetworkVarTFA("Float", "RecoilLoopWait")
	self:NetworkVarTFA("Float", "RecoilOutProgress")

	self:NetworkVarTFA("Float", "LastRecoil")

	if not self.get_event_status_lut then
		self.get_event_status_lut = {}
		self.set_event_status_lut = {}

		for i = 1, 8 do
			self.get_event_status_lut[i] = self['GetEventStatus' .. i]
			self.set_event_status_lut[i] = self['SetEventStatus' .. i]
		end
	end

	self:NetworkVarTFA("Entity", "SwapTarget")

	self:NetworkVarNotify("Customizing", self.CustomizingUpdated)

	self:NetworkVarTFA("Float", "SpreadRatio")
	self:NetworkVarTFA("Float", "IronSightsProgress")
	self:NetworkVarTFA("Float", "ProceduralHolsterProgress")
	self:NetworkVarTFA("Float", "InspectingProgress")
	self:NetworkVarTFA("Float", "JumpRatio")
	self:NetworkVarTFA("Float", "CrouchingRatio")

	self:NetworkVarTFA("Float", "ViewPunchBuild")
	self:NetworkVarTFA("Float", "ViewPunchP")
	self:NetworkVarTFA("Float", "ViewPunchY")

	self:NetworkVarTFA("Float", "SprintProgress")
	self:NetworkVarTFA("Float", "WalkProgress")
	self:NetworkVarTFA("Float", "LastVelocity")

	self:NetworkVarTFA("Int", "AnimCycle")

	self:NetworkVarTFA("Vector", "QueuedRecoil")
	self:NetworkVarTFA("Float", "PrevRecoilAngleTime")
	self:NetworkVarTFA("Angle", "PrevRecoilAngle")

	self:NetworkVarTFA("Bool", "CustomizeUpdated")
	self:NetworkVarTFA("Bool", "IronSightsOldFinal")

	function self.NetworkVar(self2, typeIn, slotIn, nameIn)
		return self2:NetworkVarTFA(typeIn, nameIn)
	end

	self:NetworkVarTFA("Float", "StatusStart")
	self:NetworkVarTFA("Float", "LastSafetyShoot")

	self:NetworkVarTFA("Int", "LastSequence")
	self:NetworkVarTFA("Int", "DownButtons")
	self:NetworkVarTFA("Int", "LastPressedButtons")

	self:NetworkVarTFA("Float", "LastReloadPressed")

	self:NetworkVarTFA("Float", "LastIronSightsPressed")

	self.GetStatus = self.GetStatusRaw
	self.GetIronSights = self.GetIronSightsOldFinal
	self.GetIronSightsDirect = self.GetIronSightsOldFinal

	hook.Run("TFA_SetupDataTables", self)
end

function SWEP:GetStatusProgress(unpredicted)
	if self:GetStatus() == TFA.Enum.STATUS_IDLE then return 1 end
	local StatusStart = self:GetStatusStart()

	if StatusStart <= 0 then return end
	local StatusEnd = self:GetStatusEnd()

	if StatusStart > StatusEnd then return 1 end

	local time = unpredicted and (l_CT() + (self.CurTimePredictionAdvance or 0)) or l_CT()
	if StatusStart >= time then return 0 end
	if StatusEnd <= time then return 1 end

	return (time - StatusStart) / (StatusEnd - StatusStart)
end

function SWEP:GetStatusProgressTime(unpredicted)
	if self:GetStatus() == TFA.Enum.STATUS_IDLE then return 0 end
	local StatusStart = self:GetStatusStart()

	if StatusStart <= 0 then return end
	local StatusEnd = self:GetStatusEnd()

	if StatusStart > StatusEnd then return 0 end

	local time = unpredicted and (l_CT() + (self.CurTimePredictionAdvance or 0)) or l_CT()
	if StatusEnd <= time then return 0 end

	return StatusEnd - time
end

function SWEP:SetStatus(statusIn, timeOn)
	self:SetStatusRaw(statusIn)
	self:SetStatusStart(l_CT())

	if timeOn ~= nil then
		self:SetStatusEnd(timeOn)
	end
end

function SWEP:ScheduleStatus(statusIn, timeFor)
	self:SetStatusRaw(statusIn)
	local time = l_CT()
	self:SetStatusStart(time)
	self:SetStatusEnd(time + timeFor)
end

function SWEP:ExtendStatus(timeFor)
	self:SetStatusEnd(self:GetStatusEnd() + timeFor)
end

function SWEP:ExtendStatusTo(timeFor)
	self:SetStatusEnd(math.max(self:GetStatusEnd(), timeFor))
end

--[[
Function Name:  Initialize
Syntax: Should not be normally called.
Notes:   Called after actual SWEP code, but before deploy, and only once.
Returns:  Nothing.  Sets the intial values for the SWEP when it's created.
Purpose:  Standard SWEP Function
]]

local PistolHoldTypes = {
	["pistol"] = true,
	["357"] = true,
	["revolver"] = true
}
local MeleeHoldTypes = {
	["melee"] = true,
	["melee2"] = true,
	["knife"] = true
}

local patch_blacklist

do
	local string_sub = string.sub

	function patch_blacklist(input, structure_version)
		local target = {}

		for key in pairs(input) do
			target[TFA.RemapStatPath(key, TFA.LatestDataVersion, structure_version)] = true
		end

		table.Empty(input)

		setmetatable(input, {
			__index = target,
			__newindex = function(_, key, value)
				target[TFA.RemapStatPath(key, TFA.LatestDataVersion, structure_version)] = value
			end
		})

		return target
	end
end

function SWEP:Initialize()
	local self2 = self:GetTable()

	if self2.HasInitialized then
		ErrorNoHalt(debug.traceback("SWEP:Initialize was called out of order", 2) .. "\n")
		return
	end

	self2.HasInitialized = true

	--TFA.MigrateStructure(self, self2, self:GetClass(), true)

	hook.Run("TFA_PreInitialize", self)

	self2.DrawCrosshairDefault = self2.DrawCrosshair

	if not self2.BobScaleCustom or self2.BobScaleCustom <= 0 then
		self2.BobScaleCustom = 1
	end

	TFA.UnfoldBaseClass(self2.Primary)
	TFA.UnfoldBaseClass(self2.Secondary)

	TFA.UnfoldBaseClass(self2.Primary.PenetrationMaterials)

	TFA.UnfoldBaseClass(self2.AttachmentTableOverride)

	--[[for k, v in pairs(self2.AttachmentTableOverride) do
		if istable(v) and k ~= "BaseClass" then
			TFA.MigrateStructure(self, v, self:GetClass(), false)
		end
	end]]

	self2.Primary.BaseClass = nil
	self2.Secondary.BaseClass = nil

	if self2.Primary.DisplayIronSpread == nil then
		self2.Primary.DisplayIronSpread = self2.Primary.DisplaySpread
	end

	self2.Primary_TFA = table.Copy(self2.Primary)
	self2.Secondary_TFA = table.Copy(self2.Secondary)

	self2.BobScale = 0
	self2.SwayScaleCustom = 1
	self2.SwayScale = 0
	self2.SetSilenced(self, self2.Silenced or self2.DefaultSilenced)
	self2.Silenced = self2.Silenced or self2.DefaultSilenced
	self2.InitializeAnims(self)
	self2.InitializeMaterialTable(self)
	self2.PatchAmmoTypeAccessors(self)
	self2.FixRPM(self)
	self2.FixIdles(self)
	self2.FixIS(self)
	self2.FixCone(self)
	self2.FixProjectile(self)
	self2.AutoDetectMuzzle(self)
	self2.AutoDetectDamage(self)
	self2.AutoDetectDamageType(self)
	self2.AutoDetectForce(self)
	self2.AutoDetectPenetrationPower(self)
	self2.AutoDetectKnockback(self)
	self2.AutoDetectSpread(self)
	self2.AutoDetectRange(self)
	self2.AutoDetectLowAmmoSound(self)
	self2.IconFix(self)
	self2.CreateFireModes(self)
	self2.FixAkimbo(self)
	self2.FixSprintAnimBob(self)
	self2.FixWalkAnimBob(self)

	table.Merge(self2.Primary, self2.Primary_TFA)
	table.Merge(self2.Secondary, self2.Secondary_TFA)

	TFA.UnfoldBaseClass(self2.StatCache_Blacklist)
	self2.StatCache_Blacklist_Real = patch_blacklist(self2.StatCache_Blacklist, self2.TFADataVersion)

	TFA.UnfoldBaseClass(self2.Attachments)
	TFA.UnfoldBaseClass(self:GetStatRaw("ViewModelElements", TFA.LatestDataVersion))
	TFA.UnfoldBaseClass(self2.ViewModelBoneMods)
	TFA.UnfoldBaseClass(self2.EventTable)

	TFA.UnfoldBaseClass(self2.Blowback_PistolMode_Disabled)
	TFA.UnfoldBaseClass(self2.IronAnimation)
	TFA.UnfoldBaseClass(self2.SprintAnimation)
	TFA.UnfoldBaseClass(self2.ShootAnimation)
	TFA.UnfoldBaseClass(self2.SmokeParticles)

	self2.ClearStatCache(self)

	self2.InitAttachments(self)

	self2.WorldModelBodygroups = self:GetStatRawL("WorldModelBodygroups")
	self2.ViewModelBodygroups = self:GetStatRawL("ViewModelBodygroups")

	if not self:GetStatRawL("AimingDownSightsSpeedMultiplier") then
		self:SetStatRawL("AimingDownSightsSpeedMultiplier", self:GetStatRawL("RegularMoveSpeedMultiplier") * 0.8)
	end

	if isnumber(self2.GetStatL(self, "Skin")) then
		self:SetSkin(self:GetStatL("Skin"))
	end

	self:SetNextLoopSoundCheck(-1)
	self:SetShootStatus(TFA.Enum.SHOOT_IDLE)

	if SERVER and self:GetOwner():IsNPC() then
		local seq = self:GetOwner():LookupSequence("shootp1")

		if MeleeHoldTypes[self2.DefaultHoldType or self2.HoldType] then
			if self:GetOwner():GetSequenceName(seq) == "shootp1" then
				self:SetWeaponHoldType("melee2")
			else
				self:SetWeaponHoldType("melee")
			end
		elseif PistolHoldTypes[self2.DefaultHoldType or self2.HoldType] then
			if self:GetOwner():GetSequenceName(seq) == "shootp1" then
				self:SetWeaponHoldType("pistol")
			else
				self:SetWeaponHoldType("smg")
			end
		else
			self:SetWeaponHoldType(self2.DefaultHoldType or self2.HoldType)
		end

		if self:GetOwner():GetClass() == "npc_citizen" then
			self:GetOwner():Fire( "DisableWeaponPickup", "", 0 )
		end

		self:GetOwner():SetKeyValue("spawnflags", "256")

		return
	end

	hook.Run("TFA_Initialize", self)
end

function SWEP:NPCWeaponThinkHook()
	local self2 = self:GetTable()

	if not self:GetOwner():IsNPC() then
		hook.Remove("TFA_NPCWeaponThink", self)
		return
	end

	self2.Think(self)
end

--[[
Function Name:  Deploy
Syntax: self:Deploy()
Notes:  Called after self:Initialize().  Called each time you draw the gun.  This is also essential to clearing out old networked vars and resetting them.
Returns:  True/False to allow quickswitch.  Why not?  You should really return true.
Purpose:  Standard SWEP Function
]]

function SWEP:Deploy()
	local self2 = self:GetTable()
	hook.Run("TFA_PreDeploy", self)
	local ply = self:GetOwner()

	self2.IsNPCOwned = ply:IsNPC()

	if IsValid(ply) and IsValid(ply:GetViewModel()) then
		self2.OwnerViewModel = ply:GetViewModel()
	end

	if SERVER and self:GetStatL("FlashlightAttachment", 0) > 0 and IsValid(ply) and ply:IsPlayer() and ply:FlashlightIsOn() then
		if not self:GetFlashlightEnabled() then
			self:ToggleFlashlight(true)
		end

		ply:Flashlight(false)
	end

	if not self:VMIV() then
		print("Invalid VM on owner: ")
		print(ply)

		return
	end

	if not self2.HasDetectedValidAnimations then
		self:CacheAnimations()
	end

	local _, tanim, ttype = self:ChooseDrawAnim()

	if sp then
		self:CallOnClient("ChooseDrawAnim", "")
	end

	local len = self:GetActivityLength(tanim, false, ttype)

	self:ScheduleStatus(TFA.Enum.STATUS_DRAW, len)
	self:SetFirstDeployEvent(true)

	self:SetNextPrimaryFire(ct + len)
	self:SetIronSightsRaw(false)

	if not self:GetStatL("PumpAction") then
		self:SetReloadLoopCancel( false )
	end

	self:SetBurstCount(0)

	self:SetIronSightsProgress(0)
	self:SetSprintProgress(0)
	self:SetInspectingProgress(0)
	self:SetProceduralHolsterProgress(0)

	if self:GetCustomizing() then
		self:ToggleCustomize()
	end

	self2.DefaultFOV = TFADUSKFOV or ( IsValid(ply) and ply:GetFOV() or 90 )

	self:ApplyViewModelModifications()
	self:CallOnClient("ApplyViewModelModifications")

	local v = hook.Run("TFA_Deploy", self)

	if v ~= nil then return v end

	return true
end

--[[
Function Name:  Holster
Syntax: self:Holster( weapon entity to switch to )
Notes:  This is kind of broken.  I had to manually select the new weapon using ply:ConCommand.  Returning true is simply not enough.  This is also essential to clearing out old networked vars and resetting them.
Returns:  True/False to allow holster.  Useful for animations.
Purpose:  Standard SWEP Function
]]
function SWEP:Holster(target)
	local self2 = self:GetTable()

	local v = hook.Run("TFA_PreHolster", self, target)
	if v ~= nil then return v end

	if not IsValid(target) then
		self2.InspectingProgress = 0

		return true
	end

	if not IsValid(self) then return end

	stat = self:GetStatus()

	if not TFA.Enum.HolsterStatus[stat] then
		if stat == TFA.Enum.STATUS_RELOADING_WAIT and self:Clip1() <= self:GetStatL("Primary.ClipSize") and (not self:GetStatL("Primary.DisableChambering")) and (not self:GetStatL("LoopedReload")) then
			self:ResetFirstDeploy()

			if sp then
				self:CallOnClient("ResetFirstDeploy", "")
			end
		end

		local success, tanim, ttype = self:ChooseHolsterAnim()

		if IsFirstTimePredicted() then
			self:SetSwapTarget(target)
		end

		self:ScheduleStatus(TFA.Enum.STATUS_HOLSTER, success and self:GetActivityLength(tanim, false, ttype) or (self:GetStatL("ProceduralHolsterTime") / self:GetAnimationRate(ACT_VM_HOLSTER)))

		return false
	elseif stat == TFA.Enum.STATUS_HOLSTER_READY or stat == TFA.Enum.STATUS_HOLSTER_FINAL then
		self:ResetViewModelModifications()

		return true
	end
end

function SWEP:FinishHolster()
	local self2 = self:GetTable()

	self:CleanParticles()

	local v2 = hook.Run("TFA_Holster", self)

	if self:GetOwner():IsNPC() then return end
	if v2 ~= nil then return v2 end

	if SERVER then
		local ent = self:GetSwapTarget()
		self:Holster(ent)

		if IsValid(ent) and ent:IsWeapon() then
			self:GetOwner():SelectWeapon(ent:GetClass())

			if ent.IsTFAWeapon then
				ent:ApplyViewModelModifications()
				ent:CallOnClient("ApplyViewModelModifications")
			end

			self2.OwnerViewModel = nil
		end
	end
end

--[[
Function Name:  OnRemove
Syntax: self:OnRemove()
Notes:  Resets bone mods and cleans up.
Returns:  Nil.
Purpose:  Standard SWEP Function
]]
function SWEP:OnRemove()
	local self2 = self:GetTable()

	if self2.CleanParticles then
		self2.CleanParticles(self)
	end

	if self2.ResetViewModelModifications then
		self2.ResetViewModelModifications(self)
	end

	return hook.Run("TFA_OnRemove", self)
end

--[[
Function Name:  OnDrop
Syntax: self:OnDrop()
Notes:  Resets bone mods and cleans up.
Returns:  Nil.
Purpose:  Standard SWEP Function
]]
function SWEP:OnDrop()
	local self2 = self:GetTable()

	if self2.CleanParticles then
		self2.CleanParticles(self)
	end

	-- if self2.ResetViewModelModifications then
	--  self:ResetViewModelModifications()
	-- end

	return hook.Run("TFA_OnDrop", self)
end

function SWEP:OwnerChanged() -- TODO: sometimes not called after switching weapon ???
	if not IsValid(self:GetOwner()) and self.ResetViewModelModifications then
		self:ResetViewModelModifications()
	end

	if SERVER then
		if self.IsNPCOwned and (not IsValid(self:GetOwner()) or not self:GetOwner():IsNPC()) then
			self:SetClip1(self:GetMaxClip1())
			self:SetClip2(self:GetMaxClip2())
		end
	end
end

--[[
Function Name:  Think
Syntax: self:Think()
Returns:  Nothing.
Notes:  This is blank.
Purpose:  Standard SWEP Function
]]
function SWEP:Think()
	local self2 = self:GetTable()
	self2.CalculateRatios(self)

	if self:GetOwner():IsNPC() and SERVER then
		if self2.ThinkNPC then self2.ThinkNPC(self) end
		self2.Think2(self, false)
	end

	stat = self2.GetStatus(self)

	if (not sp or SERVER) and not self:GetFirstDeployEvent() then
		self2.ProcessEvents(self, sp or IsFirstTimePredicted())
	end

	-- backward compatibility
	self2.AnimCycle = self:GetAnimCycle()

	if (not sp or SERVER) and ct > self:GetNextIdleAnim() and (TFA.Enum.ReadyStatus[stat] or (stat == TFA.Enum.STATUS_SHOOTING and TFA.Enum.ShootLoopingStatus[self:GetShootStatus()])) then
		self:ChooseIdleAnim()
	end

	self2.ProcessLoopFire(self)
end

function SWEP:PlayerThink(plyv, is_working_out_prediction_errors)
	if not self:NullifyOIV() then return end

	self:Think2(is_working_out_prediction_errors)
end

local sv_cheats = GetConVar("sv_cheats")
local host_timescale = GetConVar("host_timescale")

local function Clamp(a, b, c)
	if a < b then return b end
	if a > c then return c end
	return a
end

local Lerp = Lerp

function SWEP:ShouldPlaySafetyAnim()
	if self:IsSafety() then
		return not self.SprintProgressUnpredicted2 or self.SprintProgressUnpredicted2 < 0.3
	end

	if not TFA.FriendlyEncounter then return false end
	return not self:GetIronSights() and (self:GetLastGunFire() + 1 < CurTime()) and (not self.SprintProgressUnpredicted2 or self.SprintProgressUnpredicted2 < 0.3)
end

function SWEP:PlayerThinkCL(plyv)
	local self2 = self:GetTable()

	if not self:NullifyOIV() then return end

	self:SmokePCFLighting()

	if sp then
		self:Think2(false)
	end

	local ft = RealFrameTime() * game.GetTimeScale() * (sv_cheats:GetBool() and host_timescale:GetFloat() or 1)

	if self2.GetStatL(self, "BlowbackEnabled") then
		if not self2.Blowback_PistolMode or self:Clip1() == -1 or self:Clip1() > 0.1 or self2.Blowback_PistolMode_Disabled[self:GetLastActivity()] or self2.Blowback_PistolMode_Disabled[self:GetLastSequence()] or self2.Blowback_PistolMode_Disabled[self:GetLastSequenceString()] then
			self2.BlowbackCurrent = l_mathApproach(self2.BlowbackCurrent, 0, self2.BlowbackCurrent * ft * 15)
		end

		self2.BlowbackCurrentRoot = l_mathApproach(self2.BlowbackCurrentRoot, 0, self2.BlowbackCurrentRoot * ft * 15)
	end

	local is = self2.GetIronSights(self)
	local spr = self2.GetSprinting(self)
	local walk = self2.GetWalking(self)
	local status = self2.GetStatus(self)

	local ist = is and 1 or 0
	local ist2 = TFA.Enum.ReloadStatus[self:GetStatus()] and ist * .25 or ist

	local reloadBlendMult, reloadBlendMult2 = 1, 1

	if not self:GetStatL("LoopedReload") and (status == TFA.Enum.STATUS_RELOADING or status == TFA.Enum.STATUS_RELOADING_WAIT) and self2.ReloadAnimationEnd and self2.ReloadAnimationStart then
		local time = l_CT()
		local progress = Clamp((time - self2.ReloadAnimationStart) / (self2.ReloadAnimationEnd - self2.ReloadAnimationStart), 0, 1)

		reloadBlendMult = TFA.Cubic(math.max(
			Clamp(progress - 0.7, 0, 0.3) / 0.3,
			Clamp(0.1 - progress, 0, 0.1) / 0.1
		))

		reloadBlendMult2 = (1 + reloadBlendMult) / 2
	elseif TFA.Enum.ReloadStatus[status] then
		reloadBlendMult = 0
		reloadBlendMult2 = 0.5
	end

	local fidgetBlendMult = 1

	if status == TFA.Enum.STATUS_FIDGET then
		local progress = self:GetStatusProgress(true)

		fidgetBlendMult = TFA.Cubic(math.max(
			Clamp(progress - 0.8, 0, 0.2) / 0.2,
			Clamp(0.1 - progress, 0, 0.1) / 0.1
		))
	end

	local sprt = spr and reloadBlendMult or 0
	local sprt2 = spr and (fidgetBlendMult * reloadBlendMult) or 0
	local sprt3 = spr and reloadBlendMult2 or 0

	local walkt = walk and 1 or 0

	local IronSightsPosition = self2.GetStatL(self, "IronSightsPosition", self2.SightsPos)
	local IronSightsAngle = self2.GetStatL(self, "IronSightsAngle", self2.SightsAng)

	if IronSightsPosition then
		self2.IronSightsPositionCurrent = self2.IronSightsPositionCurrent or Vector(IronSightsPosition)
		self2.IronSightsAngleCurrent = self2.IronSightsAngleCurrent or Vector(IronSightsAngle)

		self2.IronSightsPositionCurrent.x = Lerp(ft * 11, self2.IronSightsPositionCurrent.x, IronSightsPosition.x)
		self2.IronSightsPositionCurrent.y = Lerp(ft * 11, self2.IronSightsPositionCurrent.y, IronSightsPosition.y)
		self2.IronSightsPositionCurrent.z = Lerp(ft * 11, self2.IronSightsPositionCurrent.z, IronSightsPosition.z)

		self2.IronSightsAngleCurrent.x = Lerp(ft * 11, self2.IronSightsAngleCurrent.x, self2.IronSightsAngleCurrent.x - math.AngleDifference(self2.IronSightsAngleCurrent.x, IronSightsAngle.x))
		self2.IronSightsAngleCurrent.y = Lerp(ft * 11, self2.IronSightsAngleCurrent.y, self2.IronSightsAngleCurrent.y - math.AngleDifference(self2.IronSightsAngleCurrent.y, IronSightsAngle.y))
		self2.IronSightsAngleCurrent.z = Lerp(ft * 11, self2.IronSightsAngleCurrent.z, self2.IronSightsAngleCurrent.z - math.AngleDifference(self2.IronSightsAngleCurrent.z, IronSightsAngle.z))
	end

	local adstransitionspeed = is and (12.5 / (self:GetStatL("IronSightTime") / 0.3)) or (spr or walk) and 7.5 or 12.5

	local ply = self:GetOwner()
	local velocity = self2.LastUnpredictedVelocity or ply:GetVelocity()

	local jr_targ = math.min(math.abs(velocity.z) / 500, 1)
	self2.JumpRatioUnpredicted = l_mathApproach((self2.JumpRatioUnpredicted or 0), jr_targ, (jr_targ - (self2.JumpRatioUnpredicted or 0)) * ft * 20)
	self2.CrouchingRatioUnpredicted = l_mathApproach((self2.CrouchingRatioUnpredicted or 0), ((ply:Crouching() or self2.KeyDown(self, IN_DUCK)) and ply:OnGround() and not ply:InVehicle()) and 1 or 0, ft / self2.ToCrouchTime)

	self2.IronSightsProgressUnpredicted = l_mathApproach(self2.IronSightsProgressUnpredicted or 0, ist, (ist - (self2.IronSightsProgressUnpredicted or 0)) * ft * adstransitionspeed * 1.2)
	self2.IronSightsProgressUnpredicted2 = l_mathApproach(self2.IronSightsProgressUnpredicted2 or 0, ist, (ist - (self2.IronSightsProgressUnpredicted2 or 0)) * ft * adstransitionspeed * 0.4)
	self2.IronSightsProgressUnpredicted3 = l_mathApproach(self2.IronSightsProgressUnpredicted3 or 0, ist2, (ist2 - (self2.IronSightsProgressUnpredicted3 or 0)) * ft * adstransitionspeed * 0.7)
	self2.SprintProgressUnpredicted = l_mathApproach(self2.SprintProgressUnpredicted or 0, sprt, (sprt - (self2.SprintProgressUnpredicted or 0)) * ft * adstransitionspeed)
	self2.SprintProgressUnpredicted2 = l_mathApproach(self2.SprintProgressUnpredicted2 or 0, sprt2, (sprt2 - (self2.SprintProgressUnpredicted2 or 0)) * ft * adstransitionspeed)
	self2.SprintProgressUnpredicted3 = l_mathApproach(self2.SprintProgressUnpredicted3 or 0, sprt3, (sprt3 - (self2.SprintProgressUnpredicted3 or 0)) * ft * adstransitionspeed)

	if is and not self2.VM_IronPositionScore then
		self2.VM_IronPositionScore = Clamp(self2.GetStatL(self, "ViewModelPosition"):Distance(self2.IronSightsPositionCurrent or self2.GetStatL(self, "IronSightsPosition", self2.GetStat(self, "SightsPos", vector_origin))) / 7, 0, 1)
	elseif not is and self2.VM_IronPositionScore and self2.IronSightsProgressUnpredicted2 <= 0.08 then
		self2.VM_IronPositionScore = nil
	end

	if self2.IronSightsProgressUnpredicted2 >= 0.8 and not self2.VM_IsScopedIn then
		self2.VM_IsScopedIn = true
	--elseif self2.IronSightsProgressUnpredicted2 <= 0.1 and self2.VM_IsScopedIn then
	elseif self2.IronSightsProgressUnpredicted2 <= 0.15 then
		self2.VM_IsScopedIn = false
	end

	local customizingTarget = self:GetCustomizing() and 1 or 0
	self2.CustomizingProgressUnpredicted = l_mathApproach((self2.CustomizingProgressUnpredicted or 0), customizingTarget, (customizingTarget - (self2.CustomizingProgressUnpredicted or 0)) * ft * 5)

	self2.WalkProgressUnpredicted = l_mathApproach((self2.WalkProgressUnpredicted or 0), walkt, (walkt - (self2.WalkProgressUnpredicted or 0)) * ft * adstransitionspeed)

	if status ~= TFA.Enum.STATUS_FIREMODE or not self:GetIsCyclingSafety() then
		local safetyTarget = self:ShouldPlaySafetyAnim() and (fidgetBlendMult * reloadBlendMult) or 0
		self2.SafetyProgressUnpredicted = l_mathApproach(self2.SafetyProgressUnpredicted or 0, safetyTarget, (safetyTarget - (self2.SafetyProgressUnpredicted or 0)) * ft * adstransitionspeed * 0.7)
	elseif status == TFA.Enum.STATUS_FIREMODE and self:GetIsCyclingSafety() then
		if not self:ShouldPlaySafetyAnim() then
			local safetyTarget = 0

			if self:GetSafetyCycleAnimated() then
				self2.SafetyProgressUnpredicted = l_mathApproach(self2.SafetyProgressUnpredicted or 0, safetyTarget, (safetyTarget - (self2.SafetyProgressUnpredicted or 0)) * ft * adstransitionspeed * 1.1)
			else
				self2.SafetyProgressUnpredicted = l_mathApproach(self2.SafetyProgressUnpredicted or 0, safetyTarget, (safetyTarget - (self2.SafetyProgressUnpredicted or 0)) * ft * adstransitionspeed)
			end
		else
			local safetyTarget = fidgetBlendMult * reloadBlendMult

			if not self:GetSafetyCycleAnimated() then
				self2.SafetyProgressUnpredicted = l_mathApproach(self2.SafetyProgressUnpredicted or 0, safetyTarget, (safetyTarget - (self2.SafetyProgressUnpredicted or 0)) * ft * adstransitionspeed * 0.7)
			end
		end
	end
end

local UnPredictedCurTime = UnPredictedCurTime

--[[
Function Name:  Think2
Syntax: self:Think2().  Called from Think.
Returns:  Nothing.
Notes:  Essential for calling other important functions.
Purpose:  Standard SWEP Function
]]
function SWEP:Think2(is_working_out_prediction_errors)
	local self2 = self:GetTable()

	ct = l_CT()

	if not is_working_out_prediction_errors then
		if CLIENT then
			self2.CurTimePredictionAdvance = ct - UnPredictedCurTime()
		end

		if self2.LuaShellRequestTime > 0 and ct > self2.LuaShellRequestTime then
			self2.LuaShellRequestTime = -1
			self2.MakeShell(self)
		end

		if not self2.HasInitialized then
			self:Initialize()
		end

		if not self2.HasDetectedValidAnimations then
			self2.CacheAnimations(self)
			self2.ChooseDrawAnim(self)
		end

		self2.InitAttachments(self)

		self2.ProcessBodygroups(self)

		self2.ProcessHoldType(self)
		self2.ReloadCV(self)
		self2.IronSightSounds(self)
		self2.ProcessLoopSound(self)
	end

	self2.ProcessFireMode(self)

	if (not sp or SERVER) and self:GetFirstDeployEvent() then
		self2.ProcessEvents(self, sp or not is_working_out_prediction_errors)
	end

	--if is_working_out_prediction_errors then return end

	if not sp or SERVER then
		self2.IronSights(self)
	end

	self2.ProcessStatus(self)
end

SWEP.IronSightsReloadEnabled = false
SWEP.IronSightsReloadLock = true

function SWEP:IronSights()
	local self2 = self:GetTable()
	local owent = self:GetOwner()
	if not IsValid(owent) then return end

	ct = l_CT()
	stat = self:GetStatus()

	local issprinting = self:GetSprinting()
	local iswalking = self:GetWalking()

	local issighting = self:GetIronSightsRaw()
	local isplayer = owent:IsPlayer()
	local old_iron_sights_final = self:GetIronSightsOldFinal()

	if TFA.Enum.ReloadStatus[stat] and self2.GetStatL(self, "IronSightsReloadLock") then
		issighting = old_iron_sights_final
	end

	if issighting and isplayer and owent:InVehicle() and not owent:GetAllowWeaponsInVehicle() then
		issighting = false
		self:SetIronSightsRaw(false)
	end

	-- self:SetLastSightsStatusCached(false)
	local userstatus = issighting

	if issprinting then
		issighting = false
	end

	if issighting and not TFA.Enum.IronStatus[stat] and (not self:GetStatL("IronSightsReloadEnabled") or not TFA.Enum.ReloadStatus[stat]) then
		issighting = false
	end

	if issighting and self:IsSafety() then
		issighting = false
	end

	if stat == TFA.Enum.STATUS_FIREMODE and self:GetIsCyclingSafety() then
		issighting = false
	end

	if self2.GetStatL(self, "BoltAction") or self2.GetStatL(self, "BoltAction_Forced") then
		if stat == TFA.Enum.STATUS_SHOOTING then
			if not self2.LastBoltShoot then
				self2.LastBoltShoot = l_CT()
			end

			if l_CT() > self2.LastBoltShoot + self2.BoltTimerOffset then
				issighting = false
			end
		elseif (stat == TFA.Enum.STATUS_IDLE and self:GetReloadLoopCancel(true)) or stat == TFA.Enum.STATUS_PUMP then
			issighting = false
		else
			self2.LastBoltShoot = nil
		end
	end

	if old_iron_sights_final ~= issighting and self2.Sights_Mode == TFA.Enum.LOCOMOTION_LUA then -- and stat == TFA.Enum.STATUS_IDLE then
		self:SetNextIdleAnim(-1)
	end

	local smi = (self2.Sights_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Sights_Mode == TFA.Enum.LOCOMOTION_ANI)
		and old_iron_sights_final ~= issighting

	local spi = (self2.Sprint_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Sprint_Mode == TFA.Enum.LOCOMOTION_ANI)
		and self2.sprinting_updated

	local wmi = (self2.Walk_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Walk_Mode == TFA.Enum.LOCOMOTION_ANI)
		and self2.walking_updated

	local cmi = (self2.Customize_Mode == TFA.Enum.LOCOMOTION_HYBRID or self2.Customize_Mode == TFA.Enum.LOCOMOTION_ANI)
		and self:GetCustomizeUpdated()

	self:SetCustomizeUpdated(false)

	if
		(smi or spi or wmi or cmi) and
		(self:GetStatus() == TFA.Enum.STATUS_IDLE or
			(self:GetStatus() == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting()))
		and not self:GetReloadLoopCancel()
	then
		local toggle_is = old_iron_sights_final ~= issighting

		if issighting and self:GetSprinting() then
			toggle_is = true
		end

		local success, _ = self:Locomote(toggle_is and (self2.Sights_Mode ~= TFA.Enum.LOCOMOTION_LUA), issighting, spi, issprinting, wmi, iswalking, cmi, self:GetCustomizing())

		if not success and (toggle_is and smi or spi or wmi or cmi) then
			self:SetNextIdleAnim(-1)
		end
	end

	self:SetIronSightsOldFinal(issighting)

	return userstatus, issighting
end

SWEP.is_sndcache_old = false

function SWEP:IronSightSounds()
	local self2 = self:GetTable()

	local is = self:GetIronSights()

	if SERVER or IsFirstTimePredicted() then
		if is ~= self2.is_sndcache_old and hook.Run("TFA_IronSightSounds", self) == nil then
			if is then
				self:EmitSound(self:GetStatL("Secondary.IronSightsInSound", "TFA.IronIn"))
			else
				self:EmitSound(self:GetStatL("Secondary.IronSightsOutSound", "TFA.IronOut"))
			end
		end

		self2.is_sndcache_old = is
	end
end

local legacy_reloads_cv = GetConVar("sv_tfa_reloads_legacy")
local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")

SWEP.Primary.Sound_DryFire = Sound("Weapon_Pistol.Empty2") -- dryfire sound, played only once
SWEP.Primary.Sound_DrySafety = Sound("Weapon_AR2.Empty2") -- safety click sound
SWEP.Primary.Sound_Blocked = Sound("Weapon_AR2.Empty") -- underwater click sound
SWEP.Primary.Sound_Jammed = Sound("Default.ClipEmpty_Rifle") -- jammed click sound

SWEP.Primary.SoundHint_Fire = true
SWEP.Primary.SoundHint_DryFire = true

local function Dryfire(self, self2, reload)
	if not dryfire_cvar:GetBool() and reload then
		self:Reload(true)
	end

	if self2.GetHasPlayedEmptyClick(self) then return end

	self2.SetHasPlayedEmptyClick(self, true)

	if SERVER and self:GetStatL("Primary.SoundHint_DryFire") then
		sound.EmitHint(SOUND_COMBAT, self:GetPos(), 500, 0.2, self:GetOwner())
	end

	if self:GetOwner():IsNPC() or self:KeyPressed(IN_ATTACK) then
		local enabled, tanim, ttype = self:ChooseDryFireAnim()

		if enabled then
			self:SetNextPrimaryFire(l_CT() + self:GetStatL("Primary.DryFireDelay", self:GetActivityLength(tanim, true, ttype)))
			return
		end
	end

	if IsFirstTimePredicted() then
		self:EmitSound(self:GetStatL("Primary.Sound_DryFire"))
	end
end

function SWEP:CanPrimaryAttack()
	local self2 = self:GetTable()

	local v = hook.Run("TFA_PreCanPrimaryAttack", self)

	if v ~= nil then
		return v
	end

	stat = self:GetStatus()

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		if self:GetStatL("LoopedReload") and TFA.Enum.ReloadStatus[stat] then
			self:SetReloadLoopCancel(true)
		end

		return false
	end

	if self:IsSafety() then
		if IsFirstTimePredicted() then
			self:EmitSound(self:GetStatL("Primary.Sound_DrySafety"))

			if SERVER and self:GetStatL("Primary.SoundHint_DryFire") then
				sound.EmitHint(SOUND_COMBAT, self:GetPos(), 200, 0.2, self:GetOwner())
			end
		end

		if l_CT() < self:GetLastSafetyShoot() + 0.2 then
			self:CycleSafety()
			-- self:SetNextPrimaryFire(l_CT() + 0.1)
		end

		self:SetLastSafetyShoot(l_CT() + 0.2)

		return
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:GetStatL("Primary.ClipSize") <= 0 and self:Ammo1() < self:GetStatL("Primary.AmmoConsumption") then
		Dryfire(self, self2)
		return false
	end

	if self:GetPrimaryClipSize(true) > 0 and self:Clip1() < self:GetStatL("Primary.AmmoConsumption") then
		Dryfire(self, self2, true)
		return false
	end

	if self2.GetStatL(self, "Primary.FiresUnderwater") == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextPrimaryFire(l_CT() + 0.5)
		self:EmitSound(self:GetStatL("Primary.Sound_Blocked"))
		return false
	end

	self2.SetHasPlayedEmptyClick(self, false)

	if l_CT() < self:GetNextPrimaryFire() then return false end

	local v2 = hook.Run("TFA_CanPrimaryAttack", self)

	if v2 ~= nil then
		return v2
	end

	if self:CheckJammed() then
		if IsFirstTimePredicted() then
			self:EmitSound(self:GetStatL("Primary.Sound_Jammed"))
		end

		local typev, tanim = self:ChooseAnimation("shoot1_empty")

		if typev ~= TFA.Enum.ANIMATION_SEQ then
			self:SendViewModelAnim(tanim)
		else
			self:SendViewModelSeq(tanim)
		end

		self:SetNextPrimaryFire(l_CT() + 1)

		return false
	end

	return true
end

function SWEP:EmitGunfireLoop()
	local self2 = self:GetTable()
	local tgtSound = self:GetStatL("Primary.LoopSound")

	if self:GetSilenced() then
		tgtSound = self:GetStatL("Primary.LoopSoundSilenced", tgtSound)
	end

	if (not sp and SERVER) or not self:IsFirstPerson() then
		tgtSound = self:GetSilenced() and self:GetStatL("Primary.LoopSoundSilenced_World", tgtSound) or self:GetStatL("Primary.LoopSound_World", tgtSound)
	end

	if self:GetNextLoopSoundCheck() < 0 or (l_CT() >= self:GetNextLoopSoundCheck() and self2.LastLoopSound ~= tgtSound) then
		if self2.LastLoopSound ~= tgtSound and self2.LastLoopSound ~= nil then
			self:StopSound(self2.LastLoopSound)
		end

		self2.LastLoopSound = tgtSound
		self2.GunfireLoopIFTPHack = true

		self:EmitSoundNet(tgtSound)
	end

	self:SetNextLoopSoundCheck(CurTime() + self:GetFireDelay())
end

function SWEP:EmitGunfireSound(soundscript)
	self:EmitSoundNet(soundscript)
end

local sv_tfa_nearlyempty = GetConVar("sv_tfa_nearlyempty")

SWEP.LowAmmoSoundThreshold = 0.33

function SWEP:EmitLowAmmoSound()
	if not sv_tfa_nearlyempty:GetBool() then return end

	local self2 = self:GetTable()

	if not self2.FireSoundAffectedByClipSize then return end

	local clip1, maxclip1 = self:Clip1(), self:GetMaxClip1()
	if clip1 <= 0 then return end

	local nextclip1 = clip1 - self:GetStatL("Primary.AmmoConsumption", 1)
	if self:GetStatL("IsAkimbo") then
		nextclip1 = nextclip1 - self:GetAnimCycle()
	end

	local mult = nextclip1 / maxclip1
	if mult >= self2.LowAmmoSoundThreshold then return end

	local soundname = (nextclip1 <= 0) and self:GetStatL("LastAmmoSound", "") or self:GetStatL("LowAmmoSound", "")

	if soundname and soundname ~= "" then
		self2.GonnaAdjustVol = true
		self2.RequiredVolume = 1 - (mult / math.max(self2.LowAmmoSoundThreshold, 0.01))

		self:EmitSound(soundname)
	end
end

function SWEP:TriggerAttack(tableName, clipID)
	local self2 = self:GetTable()
	local ply = self:GetOwner()

	local fnname = clipID == 2 and "Secondary" or "Primary"

	if TFA.Enum.ShootReadyStatus[self:GetShootStatus()] then
		self:SetShootStatus(TFA.Enum.SHOOT_IDLE)
	end

	if self2.CanBeSilenced and (ply.KeyDown and self:KeyDown(IN_USE)) and (SERVER or not sp) then
		local _, tanim = self:ChooseSilenceAnim(not self:GetSilenced())
		self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, self:GetActivityLength(tanim, true))

		return
	end

	self["SetNext" .. fnname .. "Fire"](self, self2["GetNextCorrected" .. fnname .. "Fire"](self, self2.GetFireDelay(self)))

	if self:GetMaxBurst() > 1 then
		self:SetBurstCount(math.max(1, self:GetBurstCount() + 1))
	end

	if self:GetStatL("PumpAction") and self:GetReloadLoopCancel() then return end

	self:SetStatus(TFA.Enum.STATUS_SHOOTING, self["GetNext" .. fnname .. "Fire"](self))
	self:ToggleAkimbo()
	self:IncreaseRecoilLUT()

	local ifp = IsFirstTimePredicted()

	local _, tanim = self:ChooseShootAnim(ifp)

	if not sp or not self:IsFirstPerson() then
		ply:SetAnimation(PLAYER_ATTACK1)
	end

	if SERVER and self:GetStatL(tableName .. ".SoundHint_Fire") then
		sound.EmitHint(bit.bor(SOUND_COMBAT, SOUND_CONTEXT_GUNFIRE), self:GetPos(), self:GetSilenced() and 500 or 1500, 0.2, self:GetOwner())
	end

	if self:GetStatL(tableName .. ".Sound") and ifp and not (sp and CLIENT) then
		if ply:IsPlayer() and self:GetStatL(tableName .. ".LoopSound") and (not self:GetStatL(tableName .. ".LoopSoundAutoOnly", false) or self2.Primary_TFA.Automatic) then
			self:EmitGunfireLoop()
		else
			local tgtSound = self:GetStatL(tableName .. ".Sound")

			if self:GetSilenced() then
				tgtSound = self:GetStatL(tableName .. ".SilencedSound", tgtSound)
			end

			if (not sp and SERVER) or not self:IsFirstPerson() then
				tgtSound = self:GetSilenced() and self:GetStatL(tableName .. ".SilencedSound_World", tgtSound) or self:GetStatL(tableName .. ".Sound_World", tgtSound)
			end

			self:EmitGunfireSound(tgtSound)
		end

		self:EmitLowAmmoSound()
	end

	self2["Take" .. fnname .. "Ammo"](self, self:GetStatL(tableName .. ".AmmoConsumption"))

	if self["Clip" .. clipID](self) == 0 and self:GetStatL(tableName .. ".ClipSize") > 0 then
		self["SetNext" .. fnname .. "Fire"](self, math.max(self["GetNext" .. fnname .. "Fire"](self), l_CT() + (self:GetStatL(tableName .. ".DryFireDelay", self:GetActivityLength(tanim, true)))))
	end

	self:ShootBulletInformation()
	self:UpdateJamFactor()
	local _, CurrentRecoil = self:CalculateConeRecoil()
	self:Recoil(CurrentRecoil, ifp)

	-- shouldn't this be not required since recoil state is completely networked?
	if sp and SERVER then
		self:CallOnClient("Recoil", "")
	end

	if self:GetStatL(tableName .. ".MuzzleFlashEnabled", self:GetStatL("MuzzleFlashEnabled")) and (not self:IsFirstPerson() or not self:GetStatL(tableName .. ".AutoDetectMuzzleAttachment", self:GetStatL("AutoDetectMuzzleAttachment"))) then
		self:ShootEffectsCustom()
	end

	if self:GetStatL(tableName .. ".EjectionSmoke", self:GetStatL("EjectionSmoke")) and CLIENT and ply == LocalPlayer() and ifp and not self:GetStatL(tableName .. ".LuaShellEject", self:GetStatL("LuaShellEject")) then
		self:EjectionSmoke()
	end

	self:DoAmmoCheck(clipID)

	-- Condition self:GetStatus() == TFA.Enum.STATUS_SHOOTING is always true?
	if self:GetStatus() == TFA.Enum.STATUS_SHOOTING and self:GetStatL("PumpAction") then
		if self["Clip" .. clipID](self) == 0 and self:GetStatL("PumpAction.value_empty") then
			self:SetReloadLoopCancel(true)
		elseif (self:GetStatL(tableName .. ".ClipSize") < 0 or self["Clip" .. clipID](self) > 0) and self:GetStatL("PumpAction.value") then
			self:SetReloadLoopCancel(true)
		end
	end

	self:RollJamChance()
end

function SWEP:PrimaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	self:PrePrimaryAttack()

	if hook.Run("TFA_PrimaryAttack", self) then return end

	self:TriggerAttack("Primary", 1)

	self:PostPrimaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)
end

function SWEP:PrePrimaryAttack()
	-- override
end

function SWEP:PostPrimaryAttack()
	-- override
end

function SWEP:CanSecondaryAttack()
	-- override
end

function SWEP:SecondaryAttack()
	self:PreSecondaryAttack()

	if hook.Run("TFA_SecondaryAttack", self) then return end

	if not self:GetStatL("Secondary.IronSightsEnabled", false) and self.AltAttack and self:GetOwner():IsPlayer() then
		self:AltAttack()
		self:PostSecondaryAttack()
		return
	end

	self:PostSecondaryAttack()
end

function SWEP:PreSecondaryAttack()
	-- override
end

function SWEP:PostSecondaryAttack()
	-- override
end

function SWEP:GetLegacyReloads()
	return legacy_reloads_cv:GetBool()
end

do
	local bit_band = bit.band

	function SWEP:KeyDown(keyIn)
		return bit_band(self:GetDownButtons(), keyIn) == keyIn
	end

	function SWEP:KeyPressed(keyIn)
		return bit_band(self:GetLastPressedButtons(), keyIn) == keyIn
	end
end

if SERVER and sp then
	util.AddNetworkString("tfa_reload_blending")
elseif CLIENT and sp then
	net.Receive("tfa_reload_blending", function()
		local self = net.ReadEntity()
		if not IsValid(self) then return end
		self.ReloadAnimationStart = net.ReadDouble()
		self.ReloadAnimationEnd = net.ReadDouble()
	end)
end

function SWEP:Reload(released)
	local self2 = self:GetTable()

	self:PreReload(released)

	if hook.Run("TFA_PreReload", self, released) then return end

	local isplayer = self:GetOwner():IsPlayer()
	local vm = self:VMIV()

	if isplayer and not vm then return end

	if not self:IsJammed() then
		if self:Ammo1() <= 0 then return end
		if self:GetStatL("Primary.ClipSize") < 0 then return end
	end

	if not released and not self:GetLegacyReloads() then return end
	if self:GetLegacyReloads() and not dryfire_cvar:GetBool() and not self:KeyDown(IN_RELOAD) then return end
	if self:KeyDown(IN_USE) then return end

	stat = self:GetStatus()

	if self:GetStatL("PumpAction") and self:GetReloadLoopCancel() then
		if stat == TFA.Enum.STATUS_IDLE then
			self:DoPump()
		end
	elseif TFA.Enum.ReadyStatus[stat] or (stat == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting()) or self:IsJammed() then
		if self:Clip1() < self:GetPrimaryClipSize() or self:IsJammed() then
			if hook.Run("TFA_Reload", self) then return end
			self:SetBurstCount(0)

			if self:GetStatL("LoopedReload") then
				local _, tanim, ttype = self:ChooseShotgunReloadAnim()

				if self:GetStatL("ShotgunStartAnimShell") then
					self:SetStatus(TFA.Enum.STATUS_RELOADING_LOOP_START_EMPTY)
				elseif self2.ShotgunEmptyAnim then
					local _, tg = self:ChooseAnimation("reload_empty")
					local action = tanim

					if type(tg) == "string" and tonumber(tanim) and tonumber(tanim) > 0 and isplayer then
						if ttype == TFA.Enum.ANIMATION_ACT then
							action = vm:GetSequenceName(vm:SelectWeightedSequenceSeeded(tanim, self:GetSeedIrradical()))
						else
							action = vm:GetSequenceName(tanim)
						end
					end

					if action == tg and self:GetStatL("ShotgunEmptyAnim_Shell") then
						self:SetStatus(TFA.Enum.STATUS_RELOADING_LOOP_START_EMPTY)
					else
						self:SetStatus(TFA.Enum.STATUS_RELOADING_LOOP_START)
					end
				else
					self:SetStatus(TFA.Enum.STATUS_RELOADING_LOOP_START)
				end

				self:SetStatusEnd(ct + self:GetActivityLength(tanim, true, ttype))
				--self:SetNextPrimaryFire(ct + self:GetActivityLength( tanim, false ) )
			else
				local _, tanim, ttype = self:ChooseReloadAnim()

				self:SetStatus(TFA.Enum.STATUS_RELOADING)

				if self:GetStatL("IsProceduralReloadBased") then
					self:SetStatusEnd(ct + self:GetStatL("ProceduralReloadTime"))
				else
					self:SetStatusEnd(ct + self:GetActivityLength(tanim, true, ttype))
					self:SetNextPrimaryFire(ct + self:GetActivityLength(tanim, false, ttype))
				end

				if CLIENT then
					self2.ReloadAnimationStart = ct
					self2.ReloadAnimationEnd = ct + self:GetActivityLength(tanim, false, ttype)
				elseif sp then
					net.Start("tfa_reload_blending", true)
					net.WriteEntity(self)
					net.WriteDouble(ct)
					net.WriteDouble(ct + self:GetActivityLength(tanim, false, ttype))
					net.Broadcast()
				end
			end

			if not sp or not self:IsFirstPerson() then
				self:GetOwner():SetAnimation(PLAYER_RELOAD)
			end

			if self:GetStatL("Primary.ReloadSound") and IsFirstTimePredicted() then
				self:EmitSound(self:GetStatL("Primary.ReloadSound"))
			end

			self:SetNextPrimaryFire( -1 )
		elseif released or self:KeyPressed(IN_RELOAD) then--if self:GetOwner():KeyPressed(IN_RELOAD) or not self:GetLegacyReloads() then
			self:CheckAmmo()
		end
	end

	self:PostReload(released)

	hook.Run("TFA_PostReload", self)
end

function SWEP:PreReload(released)
	-- override
end

function SWEP:PostReload(released)
	-- override
end

function SWEP:Reload2(released)
	local self2 = self:GetTable()

	local ply = self:GetOwner()
	local isplayer = ply:IsPlayer()
	local vm = self:VMIV()

	if isplayer and not vm then return end

	if self:Ammo2() <= 0 then return end
	if self:GetStatL("Secondary.ClipSize") < 0 then return end
	if not released and not self:GetLegacyReloads() then return end
	if self:GetLegacyReloads() and not dryfire_cvar:GetBool() and not self:KeyDown(IN_RELOAD) then return end
	if self:KeyDown(IN_USE) then return end

	stat = self:GetStatus()

	if self:GetStatL("PumpAction") and self:GetReloadLoopCancel() then
		if stat == TFA.Enum.STATUS_IDLE then
			self:DoPump()
		end
	elseif TFA.Enum.ReadyStatus[stat] or ( stat == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting() ) then
		if self:Clip2() < self:GetSecondaryClipSize() then
			if self:GetStatL("LoopedReload") then
				local _, tanim, ttype = self:ChooseShotgunReloadAnim()

				if self2.ShotgunEmptyAnim  then
					local _, tg = self:ChooseAnimation("reload_empty")
					local action = tanim

					if type(tg) == "string" and tonumber(tanim) and tonumber(tanim) > 0 and isplayer then
						if ttype == TFA.Enum.ANIMATION_ACT then
							action = vm:GetSequenceName(vm:SelectWeightedSequenceSeeded(tanim, self:GetSeedIrradical()))
						else
							action = vm:GetSequenceName(tanim)
						end
					end

					if action == tg and self:GetStatL("ShotgunEmptyAnim_Shell") then
						self:SetStatus(TFA.Enum.STATUS_RELOADING_LOOP_START_EMPTY)
					else
						self:SetStatus(TFA.Enum.STATUS_RELOADING_LOOP_START)
					end
				else
					self:SetStatus(TFA.Enum.STATUS_RELOADING_LOOP_START)
				end

				self:SetStatusEnd(ct + self:GetActivityLength(tanim, true, ttype))
				--self:SetNextPrimaryFire(ct + self:GetActivityLength( tanim, false ) )
			else
				local _, tanim, ttype = self:ChooseReloadAnim()

				self:SetStatus(TFA.Enum.STATUS_RELOADING)

				if self:GetStatL("IsProceduralReloadBased") then
					self:SetStatusEnd(ct + self:GetStatL("ProceduralReloadTime"))
				else
					self:SetStatusEnd(ct + self:GetActivityLength(tanim, true, ttype))
					self:SetNextPrimaryFire(ct + self:GetActivityLength(tanim, false, ttype))
				end

				if CLIENT then
					self2.ReloadAnimationStart = ct
					self2.ReloadAnimationEnd = ct + self:GetActivityLength(tanim, false, ttype)
				end
			end

			if not sp or not self:IsFirstPerson() then
				ply:SetAnimation(PLAYER_RELOAD)
			end

			if self:GetStatL("Secondary.ReloadSound") and IsFirstTimePredicted() then
				self:EmitSound(self:GetStatL("Secondary.ReloadSound"))
			end

			self:SetNextPrimaryFire( -1 )
		elseif released or self:KeyPressed(IN_RELOAD) then--if ply:KeyPressed(IN_RELOAD) or not self:GetLegacyReloads() then
			self:CheckAmmo()
		end
	end
end

function SWEP:DoPump()
	if hook.Run("TFA_Pump", self) then return end

	local _, tanim, activityType = self:PlayAnimation(self:GetStatL("PumpAction"))

	self:ScheduleStatus(TFA.Enum.STATUS_PUMP, self:GetActivityLength(tanim, true, activityType))
	self:SetNextPrimaryFire(l_CT() + self:GetActivityLength(tanim, false, activityType))
	self:SetNextIdleAnim(math.max(self:GetNextIdleAnim(), l_CT() + self:GetActivityLength(tanim, false, activityType)))
end

function SWEP:LoadShell()
	if hook.Run("TFA_LoadShell", self) then return end

	local _, tanim, ttype = self:ChooseReloadAnim()

	if self:GetActivityLength(tanim,true) < self:GetActivityLength(tanim, false, ttype) then
		self:SetStatusEnd(ct + self:GetActivityLength(tanim, true, ttype))
	else
		local sht = self:GetStatL("LoopedReloadInsertTime")
		if sht then sht = sht / self:GetAnimationRate(ACT_VM_RELOAD) end
		self:SetStatusEnd(ct + ( sht or self:GetActivityLength(tanim, true, ttype)))
	end

	return TFA.Enum.STATUS_RELOADING_LOOP
end

function SWEP:CompleteReload()
	if hook.Run("TFA_CompleteReload", self) then return end

	local maxclip = self:GetPrimaryClipSizeForReload(true)
	local curclip = self:Clip1()
	local amounttoreplace = math.min(maxclip - curclip, self:Ammo1())
	self:TakePrimaryAmmo(amounttoreplace * -1)
	self:TakePrimaryAmmo(amounttoreplace, true)
	self:SetJammed(false)
end

function SWEP:CheckAmmo()
	if hook.Run("TFA_CheckAmmo", self) then return end

	local self2 = self:GetTable()

	if self2.GetIronSights(self) or self2.GetSprinting(self) then return end

	--if self2.NextInspectAnim == nil then
	--  self2.NextInspectAnim = -1
	--end

	if self:GetOwner().GetInfoNum and self:GetOwner():GetInfoNum("cl_tfa_keys_inspect", 0) > 0 then
		return
	end

	if (self:GetActivityEnabled(ACT_VM_FIDGET) or self2.InspectionActions) and self:GetStatus() == TFA.Enum.STATUS_IDLE then--and CurTime() > self2.NextInspectAnim then
		local _, tanim, ttype = self:ChooseInspectAnim()
		self:ScheduleStatus(TFA.Enum.STATUS_FIDGET, self:GetActivityLength(tanim, false, ttype))
	end
end

local cv_strip = GetConVar("sv_tfa_weapon_strip")

function SWEP:DoAmmoCheck(clipID)
	if self:GetOwner():IsNPC() then return end
	if clipID == nil then clipID = 1 end
	local self2 = self:GetTable()

	if IsValid(self) and SERVER and cv_strip:GetBool() and self["Clip" .. clipID](self) == 0 and self["Ammo" .. clipID](self) == 0 then
		timer.Simple(.1, function()
			if SERVER and IsValid(self) and self:OwnerIsValid() then
				self:GetOwner():StripWeapon(self2.ClassName)
			end
		end)
	end
end

--[[
Function Name:  AdjustMouseSensitivity
Syntax: Should not normally be called.
Returns:  SWEP sensitivity multiplier.
Purpose:  Standard SWEP Function
]]

local fovv
local sensval
local sensitivity_cvar, sensitivity_fov_cvar, sensitivity_speed_cvar
if CLIENT then
	sensitivity_cvar = GetConVar("cl_tfa_scope_sensitivity")
	sensitivity_fov_cvar = GetConVar("cl_tfa_scope_sensitivity_autoscale")
	sensitivity_speed_cvar = GetConVar("sv_tfa_scope_gun_speed_scale")
end

function SWEP:AdjustMouseSensitivity()
	sensval = 1

	if self:GetIronSights() then
		sensval = sensval * sensitivity_cvar:GetFloat() / 100

		if sensitivity_fov_cvar:GetBool() then
			fovv = self:GetStatL("Secondary.OwnerFOV") or 70
			sensval = sensval * TFA.CalculateSensitivtyScale( fovv, nil, 1 )
		else
			sensval = sensval
		end

		if sensitivity_speed_cvar:GetFloat() then
			-- weapon heaviness
			sensval = sensval * self:GetStatL("AimingDownSightsSpeedMultiplier")
		end
	end

	sensval = sensval * l_Lerp(self:GetIronSightsProgress(), 1, self:GetStatL( "IronSightsSensitivity" ) )
	return sensval
end

--[[
Function Name:  TranslateFOV
Syntax: Should not normally be called.  Takes default FOV as parameter.
Returns:  New FOV.
Purpose:  Standard SWEP Function
]]

function SWEP:TranslateFOV(fov)
	local self2 = self:GetTable()

	self2.LastTranslatedFOV = fov

	local retVal = hook.Run("TFA_PreTranslateFOV", self,fov)

	if retVal then return retVal end

	self:CorrectScopeFOV()

	local nfov = l_Lerp(self2.IronSightsProgressUnpredicted3 or self:GetIronSightsProgress(), fov, fov * math.min(self:GetStatL("Secondary.OwnerFOV") / 90, 1))
	local ret = l_Lerp(self2.SprintProgressUnpredicted or self:GetSprintProgress(), nfov, nfov + self2.SprintFOVOffset)

	if self:OwnerIsValid() and not self2.IsMelee then
		local vpa = self:GetOwner():GetViewPunchAngles()

		ret = ret + math.abs(vpa.p) / 4 + math.abs(vpa.y) / 4 + math.abs(vpa.r) / 4
	end

	ret = hook.Run("TFA_TranslateFOV", self,ret) or ret

	return ret
end

function SWEP:GetPrimaryAmmoType()
	return self:GetStatL("Primary.Ammo") or ""
end

function SWEP:ToggleInspect()
	if self:GetOwner():IsNPC() then return false end -- NPCs can't look at guns silly

	local self2 = self:GetTable()

	if (self:GetSprinting() or self:GetIronSights() or self:GetStatus() ~= TFA.Enum.STATUS_IDLE) and not self:GetCustomizing() then return end

	self:SetCustomizing(not self:GetCustomizing())
	self2.Inspecting = self:GetCustomizing()
	self:SetCustomizeUpdated(true)

	--if self2.Inspecting then
	--  gui.EnableScreenClicker(true)
	--else
	--  gui.EnableScreenClicker(false)
	--end

	return self:GetCustomizing()
end

SWEP.ToggleCustomize = SWEP.ToggleInspect

function SWEP:GetIsInspecting()
	return self:GetCustomizing()
end

function SWEP:CustomizingUpdated(_, old, new)
	if old ~= new and self._inspect_hack ~= new then
		self._inspect_hack = new

		if new then
			self:OnCustomizationOpen()
		else
			self:OnCustomizationClose()
		end
	end
end

function SWEP:OnCustomizationOpen()
	-- override
	-- example:
	--[[
		if CLIENT then surface.PlaySound("ui/buttonclickrelease.wav") end
	]]
end

function SWEP:OnCustomizationClose()
	-- override
end

function SWEP:EmitSoundNet(sound)
	if CLIENT or sp then
		if sp and not IsFirstTimePredicted() then return end

		self:EmitSound(sound)

		return
	end

	local filter = RecipientFilter()
	filter:AddPAS(self:GetPos())

	if IsValid(self:GetOwner()) then
		filter:RemovePlayer(self:GetOwner())
	end

	net.Start("tfaSoundEvent", true)
	net.WriteEntity(self)
	net.WriteString(sound)
	net.Send(filter)
end

function SWEP:CanBeJammed()
	return self.CanJam and self:GetMaxClip1() > 0 and sv_tfa_jamming:GetBool()
end

-- Use this to increase/decrease factor added based on ammunition/weather conditions/etc
function SWEP:GrabJamFactorMult()
	return 1 -- override
end

function SWEP:UpdateJamFactor()
	local self2 = self:GetTable()
	if not self:CanBeJammed() then return self end
	self:SetJamFactor(math.min(100, self:GetJamFactor() + self2.JamFactor * sv_tfa_jamming_factor_inc:GetFloat() * self:GrabJamFactorMult()))
	return self
end

function SWEP:IsJammed()
	if not self:CanBeJammed() then return false end
	return self:GetJammed()
end

function SWEP:NotifyJam()
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
		ply:PrintMessage(HUD_PRINTCENTER, "#tfa.msg.weaponjammed")
		ply._TFA_LastJamMessage = RealTime() + 4
	end
end

function SWEP:CheckJammed()
	if not self:IsJammed() then return false end
	self:NotifyJam()
	return true
end

function SWEP:RollJamChance()
	if not self:CanBeJammed() then return false end
	if self:IsJammed() then return true end

	local chance = self:GetJamChance()
	local roll = util.SharedRandom('tfa_base_jam', math.max(0.002711997795105, math.pow(chance, 1.19)), 1, l_CT())

	if roll <= chance * sv_tfa_jamming_mult:GetFloat() then
		self:SetJammed(true)

		if IsFirstTimePredicted() then
			self:NotifyJam()
		end

		return true
	end

	return false
end

function SWEP:GrabJamChanceMult()
	return 1 -- override
end

function SWEP:GetJamChance()
	-- you can safely override this with your own logic if you desire
	local self2 = self:GetTable()
	if not self:CanBeJammed() then return 0 end
	return self:GetJamFactor() * sv_tfa_jamming_factor:GetFloat() * (self2.JamChance / 100) * self:GrabJamChanceMult()
end

SWEP.FlashlightSoundToggleOn = Sound("HL2Player.FlashLightOn")
SWEP.FlashlightSoundToggleOff = Sound("HL2Player.FlashLightOff")

function SWEP:ToggleFlashlight(toState)
	if toState == nil then
		toState = not self:GetFlashlightEnabled()
	end

	self:SetFlashlightEnabled(toState)
	self:EmitSoundNet(self:GetStatL("FlashlightSoundToggle" .. (toState and "On" or "Off")))
end

-- source engine save load
function SWEP:OnRestore()
	self:BuildAttachmentCache()

	self:InitializeAnims()
	self:InitializeMaterialTable()

	self:IconFix()

	do -- attempt to restore attachments; weapons DO have owner so we don't need the precautions
		local OldFD = self.IsFirstDeploy

		self.IsFirstDeploy = true -- so extmag attachments don't unload the clip
		for attName, sel in pairs(self.AttachmentCache or {}) do
			if sel then
				local att = TFA.Attachments.Atts[attName]

				if att and att.Attach then
					att:Attach(self)
				end
			end
		end
		self.IsFirstDeploy = OldFD
	end
end

-- lua autorefresh / weapons.Register
function SWEP:OnReloaded()
	-- queue to next game frame since gmod is a fucking idiot
	timer.Simple(0, function()
		if not self:IsValid() then return end

		local baseclassSelf = table.Copy(baseclass.Get(self:GetClass()))
		if not baseclassSelf then return end

		local self2 = self:GetTable()

		self2.Primary_TFA.RangeFalloffLUTBuilt = nil
		self2.Primary.RangeFalloffLUTBuilt = nil

		--TFA.MigrateStructure(self, baseclassSelf, self:GetClass(), true)
		--TFA.MigrateStructure(self, self2, self:GetClass(), true)

		if istable(baseclassSelf.Primary) then
			self2.Primary_TFA = table.Copy(baseclassSelf.Primary)
			TFA.UnfoldBaseClass(baseclassSelf.Primary)
		end

		if istable(baseclassSelf.Secondary) then
			self2.Secondary_TFA = table.Copy(baseclassSelf.Secondary)
			TFA.UnfoldBaseClass(baseclassSelf.Secondary)
		end

		self2.StatCache_Blacklist = baseclassSelf.StatCache_Blacklist
		TFA.UnfoldBaseClass(self2.StatCache_Blacklist)

		if self2.StatCache_Blacklist_Real then
			table.Merge(self2.StatCache_Blacklist, self2.StatCache_Blacklist_Real)
		end

		self2.StatCache_Blacklist_Real = patch_blacklist(self2.StatCache_Blacklist, self2.TFADataVersion)

		self2.event_table_warning = false
		self2.event_table_built = false

		self2.AutoDetectMuzzle(self)
		self2.AutoDetectDamage(self)
		self2.AutoDetectDamageType(self)
		self2.AutoDetectForce(self)
		self2.AutoDetectPenetrationPower(self)
		self2.AutoDetectKnockback(self)
		self2.AutoDetectSpread(self)
		self2.AutoDetectRange(self)
		self2.ClearStatCache(self)
	end)
end

function SWEP:ProcessLoopSound()
	if sp and not SERVER then return end
	if self:GetNextLoopSoundCheck() < 0 or ct < self:GetNextLoopSoundCheck() or self:GetStatus() == TFA.Enum.STATUS_SHOOTING then return end

	self:SetNextLoopSoundCheck(-1)

	local tgtSound = self:GetStatL("Primary.LoopSound")

	if self:GetSilenced() then
		tgtSound = self:GetStatL("Primary.LoopSoundSilenced", tgtSound)
	end

	if tgtSound then
		self:StopSoundNet(tgtSound)
	end

	if (not sp and SERVER) or not self:IsFirstPerson() then
		tgtSound = self:GetSilenced() and self:GetStatL("Primary.LoopSoundSilenced_World", tgtSound) or self:GetStatL("Primary.LoopSound_World", tgtSound)

		if tgtSound then
			self:StopSoundNet(tgtSound)
		end
	end

	tgtSound = self:GetStatL("Primary.LoopSoundTail")

	if self:GetSilenced() then
		tgtSound = self:GetStatL("Primary.LoopSoundTailSilenced", tgtSound)
	end

	if (not sp and SERVER) or not self:IsFirstPerson() then
		tgtSound = self:GetSilenced() and self:GetStatL("Primary.LoopSoundTailSilenced_World", tgtSound) or self:GetStatL("Primary.LoopSoundTail_World", tgtSound)
	end

	if tgtSound and (SERVER or self.GunfireLoopIFTPHack) then
		self:EmitSoundNet(tgtSound)
		self.GunfireLoopIFTPHack = false
	end
end

function SWEP:ProcessLoopFire()
	local self2 = self:GetTable()
	if sp and not IsFirstTimePredicted() then return end
	if (self:GetStatus() == TFA.Enum.STATUS_SHOOTING ) then
		if TFA.Enum.ShootLoopingStatus[self:GetShootStatus()] then
			self:SetShootStatus(TFA.Enum.SHOOT_LOOP)
		end
	else --not shooting
		if (not TFA.Enum.ShootReadyStatus[self:GetShootStatus()]) then
			if ( self:GetShootStatus() ~= TFA.Enum.SHOOT_CHECK ) then
				self:SetShootStatus(TFA.Enum.SHOOT_CHECK) --move to check first
			else --if we've checked for one more tick that we're not shooting
				self:SetShootStatus(TFA.Enum.SHOOT_IDLE) --move to check first
				if not ( self:GetSprinting() and self2.Sprint_Mode ~= TFA.Enum.LOCOMOTION_LUA ) then --assuming we don't need to transition into sprint
					self:PlayAnimation(self:GetStatL("ShootAnimation.out")) --exit
				end
			end
		end
	end
end
