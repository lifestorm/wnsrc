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

local function CreateReplConVar(cvarname, cvarvalue, description, ...)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description, ...)
end -- replicated only on clients, archive/notify on server

-- Shared Convars

if GetConVar("sv_tfa_changelog") == nil then
	CreateReplConVar("sv_tfa_changelog", "1", "Enable changelog?")
end

if GetConVar("sv_tfa_soundscale") == nil then
	CreateReplConVar("sv_tfa_soundscale", "1", "Scale sound pitch in accordance to timescale?")
end

if GetConVar("sv_tfa_weapon_strip") == nil then
	CreateReplConVar("sv_tfa_weapon_strip", "0", "Allow the removal of empty weapons?")
end

if GetConVar("sv_tfa_spread_legacy") == nil then
	CreateReplConVar("sv_tfa_spread_legacy", "0", "Use legacy spread algorithms?")
end

if GetConVar("sv_tfa_cmenu") == nil then
	CreateReplConVar("sv_tfa_cmenu", "1", "Allow custom context menu?")
end

if GetConVar("sv_tfa_cmenu_key") == nil then
	CreateReplConVar("sv_tfa_cmenu_key", "-1", "Override the inspection menu key?  Uses the KEY enum available on the gmod wiki. -1 to not.")
end

if GetConVar("sv_tfa_range_modifier") == nil then
	CreateReplConVar("sv_tfa_range_modifier", "0.5", "This controls how much the range affects damage.  0.5 means the maximum loss of damage is 0.5.")
end

if GetConVar("sv_tfa_allow_dryfire") == nil then
	CreateReplConVar("sv_tfa_allow_dryfire", "1", "Allow dryfire?")
end

if GetConVar("sv_tfa_penetration_hardlimit") == nil then
	CreateReplConVar("sv_tfa_penetration_hardlimit", "100", "Max number of objects we can penetrate through.")
end

if GetConVar("sv_tfa_bullet_penetration_power_mul") == nil then
	CreateReplConVar("sv_tfa_bullet_penetration_power_mul", "1", "Power multiplier. 1 or 1.5 for CS 1.6 experience, 0.25 for semi-realistic behavior")
end

if GetConVar("sv_tfa_penetration_hitmarker") == nil then
	CreateReplConVar("sv_tfa_penetration_hitmarker", "1", "Should penetrating bullet send hitmarker to attacker?")
end

if GetConVar("sv_tfa_damage_multiplier") == nil then
	CreateReplConVar("sv_tfa_damage_multiplier", "1", "Multiplier for TFA base projectile damage.")
end

if GetConVar("sv_tfa_damage_multiplier_npc") == nil then
	CreateReplConVar("sv_tfa_damage_multiplier_npc", "1", "Multiplier for TFA base projectile damage for NPCs.")
end

if GetConVar("sv_tfa_damage_mult_min") == nil then
	CreateConVar("sv_tfa_damage_mult_min", "0.95", {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE}, "This is the lower range of a random damage factor.")
end

if GetConVar("sv_tfa_damage_mult_max") == nil then
	CreateReplConVar("sv_tfa_damage_mult_max", "1.05", "This is the higher range of a random damage factor.")
end

if GetConVar("sv_tfa_melee_damage_npc") == nil then
	CreateReplConVar("sv_tfa_melee_damage_npc", "1", "Damage multiplier against NPCs using TFA Melees.")
end

if GetConVar("sv_tfa_melee_damage_ply") == nil then
	CreateReplConVar("sv_tfa_melee_damage_ply", "0.65", "Damage multiplier against players using TFA Melees.")
end

if GetConVar("sv_tfa_melee_blocking_timed") == nil then
	CreateReplConVar("sv_tfa_melee_blocking_timed", "1", "Enable timed blocking?")
end

if GetConVar("sv_tfa_melee_blocking_anglemult") == nil then
	CreateReplConVar("sv_tfa_melee_blocking_anglemult", "1", "Players can block attacks in an angle around their view.  This multiplies that angle.")
end

if GetConVar("sv_tfa_melee_blocking_deflection") == nil then
	CreateReplConVar("sv_tfa_melee_blocking_deflection", "1", "For weapons that can deflect bullets ( e.g. certain katans ), can you deflect bullets?  Set to 1 to enable for parries, or 2 for all blocks.")
end

if GetConVar("sv_tfa_melee_blocking_timed") == nil then
	CreateReplConVar("sv_tfa_melee_blocking_timed", "1", "Enable timed blocking?")
end

if GetConVar("sv_tfa_melee_blocking_stun_enabled") == nil then
	CreateReplConVar("sv_tfa_melee_blocking_stun_enabled", "1", "Stun NPCs on block?")
end

if GetConVar("sv_tfa_melee_blocking_stun_time") == nil then
	CreateReplConVar("sv_tfa_melee_blocking_stun_time", "0.65", "How long to stun NPCs on block.")
end

if GetConVar("sv_tfa_melee_doordestruction") == nil then
	CreateReplConVar("sv_tfa_melee_doordestruction", "1", "Allow players to bash open doors?")
end

if GetConVar("sv_tfa_door_respawn") == nil then
	CreateReplConVar("sv_tfa_door_respawn", "-1", "Time for doors to respawn; -1 for never.")
end

if GetConVar("sv_tfa_npc_randomize_atts") == nil then
	CreateReplConVar("sv_tfa_npc_randomize_atts", "1", "Randomize NPC's weapons attachments.")
end

local cv_dfc
if GetConVar("sv_tfa_default_clip") == nil then
	cv_dfc = CreateReplConVar("sv_tfa_default_clip", "-1", "How many clips will a weapon spawn with? Negative reverts to default values.")
else
	cv_dfc = GetConVar("sv_tfa_default_clip")
end

local function TFAUpdateDefaultClip()
	local dfc = cv_dfc:GetInt()
	local weplist = weapons.GetList()
	if not weplist or #weplist <= 0 then return end

	for _, v in pairs(weplist) do
		local cl = v.ClassName and v.ClassName or v
		local wep = weapons.GetStored(cl)

		if wep and (wep.IsTFAWeapon or string.find(string.lower(wep.Base and wep.Base or ""), "tfa")) then
			if not wep.Primary then
				wep.Primary = {}
			end

			if not wep.Primary.TrueDefaultClip then
				wep.Primary.TrueDefaultClip = wep.Primary.DefaultClip
			end

			if not wep.Primary.TrueDefaultClip then
				wep.Primary.TrueDefaultClip = 0
			end

			if dfc < 0 then
				wep.Primary.DefaultClip = wep.Primary.TrueDefaultClip
			else
				if wep.Primary.ClipSize and wep.Primary.ClipSize > 0 then
					wep.Primary.DefaultClip = wep.Primary.ClipSize * dfc
				else
					wep.Primary.DefaultClip = wep.Primary.TrueDefaultClip * 1
				end
			end
		end
	end
end

hook.Add("InitPostEntity", "TFADefaultClipPE", TFAUpdateDefaultClip)

if TFAUpdateDefaultClip then
	TFAUpdateDefaultClip()
end

--if GetConVar("sv_tfa_default_clip") == nil then

cvars.AddChangeCallback("sv_tfa_default_clip", function(convar_name, value_old, value_new)
	TFAUpdateDefaultClip()
end, "TFAUpdateDefaultClip")

local function sv_tfa_range_modifier()
	for k, v in ipairs(ents.GetAll()) do
		if v.IsTFAWeapon and v.Primary_TFA.RangeFalloffLUT_IsConverted then
			v.Primary_TFA.RangeFalloffLUT = nil
			v:AutoDetectRange()
		end
	end
end

cvars.AddChangeCallback("sv_tfa_range_modifier", sv_tfa_range_modifier, "TFA")

sv_tfa_range_modifier()

if CLIENT then
	hook.Add("InitPostEntity", "sv_tfa_range_modifier", sv_tfa_range_modifier)
end

--end
if GetConVar("sv_tfa_unique_slots") == nil then
	CreateReplConVar("sv_tfa_unique_slots", "1", "Give TFA-based Weapons unique slots? 1 for true, 0 for false. RESTART AFTER CHANGING.")
end

if GetConVar("sv_tfa_spread_multiplier") == nil then
	CreateReplConVar("sv_tfa_spread_multiplier", "1", "Increase for more spread, decrease for less.")
end

if GetConVar("sv_tfa_force_multiplier") == nil then
	CreateReplConVar("sv_tfa_force_multiplier", "1", "Arrow force multiplier (not arrow velocity, but how much force they give on impact).")
end

if GetConVar("sv_tfa_dynamicaccuracy") == nil then
	CreateReplConVar("sv_tfa_dynamicaccuracy", "1", "Dynamic acuracy?  (e.g.more accurate on crouch, less accurate on jumping.")
end

if GetConVar("sv_tfa_ammo_detonation") == nil then
	CreateReplConVar("sv_tfa_ammo_detonation", "1", "Ammo Detonation?  (e.g. shoot ammo until it explodes) ")
end

if GetConVar("sv_tfa_ammo_detonation_mode") == nil then
	CreateReplConVar("sv_tfa_ammo_detonation_mode", "2", "Ammo Detonation Mode?  (0=Bullets,1=Blast,2=Mix) ")
end

if GetConVar("sv_tfa_ammo_detonation_chain") == nil then
	CreateReplConVar("sv_tfa_ammo_detonation_chain", "1", "Ammo Detonation Chain?  (0=Ammo boxes don't detonate other ammo boxes, 1 you can chain them together) ")
end

if GetConVar("sv_tfa_scope_gun_speed_scale") == nil then
	CreateReplConVar("sv_tfa_scope_gun_speed_scale", "0", "Scale player sensitivity based on player move speed?")
end

if GetConVar("sv_tfa_bullet_penetration") == nil then
	CreateReplConVar("sv_tfa_bullet_penetration", "1", "Allow bullet penetration?")
end

if GetConVar("sv_tfa_bullet_doordestruction") == nil then
	CreateReplConVar("sv_tfa_bullet_doordestruction", "1", "Allow to shoot down doors?")
end

if GetConVar("sv_tfa_bullet_doordestruction_keep") == nil then
	CreateReplConVar("sv_tfa_bullet_doordestruction_keep", "0", "Don't shoot door off hinges")
end

if GetConVar("sv_tfa_npc_burst") == nil then
	CreateReplConVar("sv_tfa_npc_burst", "0", "Whenever NPCs should fire in bursts like they do with HL2 weapons.")
end

if GetConVar("sv_tfa_bullet_ricochet") == nil then
	CreateReplConVar("sv_tfa_bullet_ricochet", "0", "Allow bullet ricochet?")
end

if GetConVar("sv_tfa_bullet_randomseed") == nil then
	CreateReplConVar("sv_tfa_bullet_randomseed", "0", "Populate extra seed serverside? This will cause spread to be out of sync with server!")
end

if GetConVar("sv_tfa_debug") == nil then
	CreateReplConVar("sv_tfa_debug", "0", "Enable debug mode?")
end

if GetConVar("sv_tfa_holdtype_dynamic") == nil then
	CreateReplConVar("sv_tfa_holdtype_dynamic", "1", "Allow dynamic holdtype?")
end

if GetConVar("sv_tfa_arrow_lifetime") == nil then
	CreateReplConVar("sv_tfa_arrow_lifetime", "30", "Arrow lifetime.")
end

if GetConVar("sv_tfa_worldmodel_culldistance") == nil then
	CreateReplConVar("sv_tfa_worldmodel_culldistance", "-1", "-1 to leave unculled.  Anything else is feet*16.")
end

if GetConVar("sv_tfa_reloads_legacy") == nil then
	CreateReplConVar("sv_tfa_reloads_legacy", "0", "Enable legacy-style reloading?")
end

if GetConVar("sv_tfa_recoil_legacy") == nil then
	CreateReplConVar("sv_tfa_recoil_legacy", "0", "Enable legacy-style recoil? This will cause prediction issues in multiplayer. Always disabled for NPCs!")
end

if GetConVar("sv_tfa_recoil_mul_p") == nil then
	CreateReplConVar("sv_tfa_recoil_mul_p", "1", "Pitch kick multiplier for recoil")
end

if GetConVar("sv_tfa_recoil_mul_y") == nil then
	CreateReplConVar("sv_tfa_recoil_mul_y", "1", "Yaw kick multiplier for recoil")
end

if GetConVar("sv_tfa_recoil_mul_p_npc") == nil then
	CreateReplConVar("sv_tfa_recoil_mul_p_npc", "1", "Pitch kick multiplier for recoil for NPCs")
end

if GetConVar("sv_tfa_recoil_mul_y_npc") == nil then
	CreateReplConVar("sv_tfa_recoil_mul_y_npc", "1", "Yaw kick multiplier for recoil for NPCs")
end

if GetConVar("sv_tfa_recoil_viewpunch_mul") == nil then
	CreateReplConVar("sv_tfa_recoil_viewpunch_mul", "1", "Multiplier for viewpunch recoil (visual viewmodel recoil)")
end

if GetConVar("sv_tfa_recoil_eyeangles_mul") == nil then
	CreateReplConVar("sv_tfa_recoil_eyeangles_mul", "1", "Multiplier for eye angles recoil (real angle change recoil)")
end

if GetConVar("sv_tfa_fx_penetration_decal") == nil then
	CreateReplConVar("sv_tfa_fx_penetration_decal", "1", "Enable decals on the other side of a penetrated object?")
end

local cv_ironsights = GetConVar("sv_tfa_ironsights_enabled")

if cv_ironsights == nil then
	cv_ironsights = CreateReplConVar("sv_tfa_ironsights_enabled", "1", "Enable ironsights? Disabling this still allows scopes.")
end

local is_stats = {
	["data.ironsights"] = 0,
	["Secondary.IronSightsEnabled"] = false,
}

hook.Add("TFA_GetStat", "TFA_IronsightsConVarToggle", function(wep, stat, val)
	if not IsValid(wep) or is_stats[stat] == nil then return end

	if not cv_ironsights:GetBool() and not wep:GetStatRawL("Scoped") and not wep:GetStatRawL("Scoped_3D") then
		return is_stats[stat]
	end
end)

if GetConVar("sv_tfa_sprint_enabled") == nil then
	CreateReplConVar("sv_tfa_sprint_enabled", "1", "Enable sprinting? Disabling this allows shooting while IN_SPEED.")
end

if GetConVar("sv_tfa_attachments_alphabetical") == nil then
	CreateReplConVar("sv_tfa_attachments_alphabetical", "0", "Override weapon attachment order to be alphabetical.")
end

if GetConVar("sv_tfa_jamming") == nil then
	CreateReplConVar("sv_tfa_jamming", "1", "Enable jamming mechanics?")
end

if GetConVar("sv_tfa_jamming_mult") == nil then
	CreateReplConVar("sv_tfa_jamming_mult", "1", "Multiply jam chance by this value. You really should modify sv_tfa_jamming_factor_inc rather than this.")
end

if GetConVar("sv_tfa_jamming_factor") == nil then
	CreateReplConVar("sv_tfa_jamming_factor", "1", "Multiply jam factor by this value")
end

if GetConVar("sv_tfa_jamming_factor_inc") == nil then
	CreateReplConVar("sv_tfa_jamming_factor_inc", "1", "Multiply jam factor gain by this value")
end

if GetConVar("sv_tfa_nearlyempty") == nil then
	CreateReplConVar("sv_tfa_nearlyempty", "1", "Enable nearly-empty sounds")
end

if GetConVar("sv_tfa_fixed_crosshair") == nil then
	CreateReplConVar("sv_tfa_fixed_crosshair", "0", "Fix crosshair position on center of the screen (CS:GO style)")
end

if GetConVar("sv_tfa_weapon_weight") == nil then
	CreateReplConVar("sv_tfa_weapon_weight", "1", "Disabling this WILL break certain SWEPs and Mechanics. You were warned.")
end
