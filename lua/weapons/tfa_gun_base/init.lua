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

include("shared.lua")

include("common/ai_translations.lua")
include("common/anims.lua")
include("common/autodetection.lua")
include("common/utils.lua")
include("common/stat.lua")
include("common/attachments.lua")
include("common/bullet.lua")
include("common/effects.lua")
include("common/calc.lua")
include("common/akimbo.lua")
include("common/events.lua")
include("common/nzombies.lua")
include("common/ttt.lua")
include("common/viewmodel.lua")
include("common/skins.lua")

AddCSLuaFile("common/ai_translations.lua")
AddCSLuaFile("common/anims.lua")
AddCSLuaFile("common/autodetection.lua")
AddCSLuaFile("common/utils.lua")
AddCSLuaFile("common/stat.lua")
AddCSLuaFile("common/attachments.lua")
AddCSLuaFile("common/bullet.lua")
AddCSLuaFile("common/effects.lua")
AddCSLuaFile("common/calc.lua")
AddCSLuaFile("common/akimbo.lua")
AddCSLuaFile("common/events.lua")
AddCSLuaFile("common/nzombies.lua")
AddCSLuaFile("common/ttt.lua")
AddCSLuaFile("common/viewmodel.lua")
AddCSLuaFile("common/skins.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

AddCSLuaFile("client/effects.lua")
AddCSLuaFile("client/viewbob.lua")
AddCSLuaFile("client/hud.lua")
AddCSLuaFile("client/mods.lua")
AddCSLuaFile("client/laser.lua")
AddCSLuaFile("client/fov.lua")
AddCSLuaFile("client/flashlight.lua")
AddCSLuaFile("client/viewmodel.lua")
AddCSLuaFile("client/bobcode.lua")

SWEP.Weight = 60 -- Decides whether we should switch from/to this
SWEP.AutoSwitchTo = true -- Auto switch to
SWEP.AutoSwitchFrom = true -- Auto switch from

local sv_tfa_npc_burst = GetConVar("sv_tfa_npc_burst")

function SWEP:NPCShoot_Primary()
	if self:Clip1() <= 0 and self:GetMaxClip1() > 0 then
		self:GetOwner():SetSchedule(SCHED_RELOAD)
		return
	end

	return self:PrimaryAttack()
end

function SWEP:GetNPCRestTimes()
	if sv_tfa_npc_burst:GetBool() or self:GetStatL("NPCBurstOverride", false) then
		return self:GetStatL("NPCMinRest", self:GetFireDelay()), self:GetStatL("NPCMaxRest", self:GetFireDelay() * 2)
	end

	if self:GetStatL("Primary.Automatic") then
		return 0, 0
	else
		return self:GetFireDelay(), self:GetFireDelay() * 2
	end
end

function SWEP:GetNPCBurstSettings()
	if sv_tfa_npc_burst:GetBool() or self:GetStatL("NPCBurstOverride", false) then
		return self:GetStatL("NPCMinBurst", 1), self:GetStatL("NPCMinBurst", 6), self:GetStatL("NPCBurstDelay", self:GetFireDelay() * self:GetMaxBurst())
	end

	if self:GetMaxClip1() > 0 then
		local burst = self:GetMaxBurst()
		local value = math.ceil(self:Clip1() / burst)
		local delay = self:GetFireDelay() * burst

		if self:GetStatL("Primary.Automatic") then
			return math.min(4, value), math.min(12, value), delay
		else
			return 1, math.min(4, value), delay
		end
	else
		return 1, 30, self:GetFireDelay() * self:GetMaxBurst()
	end
end

function SWEP:GetNPCBulletSpread()
	return 1 -- we handle this manually, in calculate cone, recoil and shootbullet
end

function SWEP:CanBePickedUpByNPCs()
	return true
end

local sv_tfa_npc_randomize_atts = GetConVar("sv_tfa_npc_randomize_atts")

function SWEP:Equip(...)
	local owner = self:GetOwner()

	if owner:IsNPC() then
		self.IsNPCOwned = true

		if not self.IsFirstEquip and sv_tfa_npc_randomize_atts:GetBool() then
			self:RandomizeAttachments(true)
		end

		local function closure()
			self:NPCWeaponThinkHook()
		end

		hook.Add("TFA_NPCWeaponThink", self, function()
			ProtectedCall(closure)
		end)
	else
		self.IsNPCOwned = false
	end

	self.IsFirstEquip = true
	self.OwnerViewModel = nil
	self:EquipTTT(...)
end

TFA.FillMissingMetaValues(SWEP)
