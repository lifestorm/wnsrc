--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "HLA IRIFLE V2"
SWEP.Author 					= ""
SWEP.Contact					= ""
SWEP.Purpose					= "This weapon is made for NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Half-Life: Alyx"
SWEP.MadeForNPCsOnly = true -- Is this weapon meant to be for NPCs only?
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/weapons/w_vr_irifle.mdl" -- The world model (Third person, when a NPC is holding it, on ground, etc.)
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0, 90, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(-3, 0, 1)
SWEP.WorldModel_CustomPositionBone = "hand_R" -- The bone it will use as the main point (Owner's bone)
SWEP.NPC_NextPrimaryFire = 0.9
SWEP.NPC_TimeUntilFireExtraTimers = {0.1,0.3,0.5,0.7} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	-- ====== Reload Variables ====== --
SWEP.NPC_HasReloadSound = true -- Should it play a sound when the base detects the SNPC playing a reload animation?
SWEP.NPC_CanBePickedUp = false -- Can this weapon be picked up by NPCs? (Ex: Rebels)
------ Primary Stuff ------
SWEP.Primary.Damage = 12 -- Damage
SWEP.Primary.ClipSize = 30 -- Max amount of bullets per clip
SWEP.Primary.Sound = {"weapons/w_hla_irifle/wpn_combine_ar_fire_body_01.wav","weapons/w_hla_irifle/wpn_combine_ar_fire_body_02.wav","weapons/w_hla_irifle/wpn_combine_ar_fire_body_03.wav","weapons/w_hla_irifle/wpn_combine_ar_fire_body_04.wav"}
SWEP.Primary.DistantSound = {"weapons/w_hla_irifle/wpn_combine_ar_fire_tail_01.wav","weapons/w_hla_irifle/wpn_combine_ar_fire_tail_02.wav","weapons/w_hla_irifle/wpn_combine_ar_fire_tail_03.wav","weapons/w_hla_irifle/wpn_combine_ar_fire_tail_04.wav"}
	-- ====== Effect Variables ====== --
SWEP.PrimaryEffects_MuzzleFlash = true
----------------------------------------
SWEP.AR2LFE = {"weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_lfe_01.wav","weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_lfe_02.wav","weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_lfe_03.wav","weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_lfe_04.wav"}
SWEP.AR2HEAD = {"weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_head_01.wav","weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_head_02.wav","weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_head_03.wav","weapons/W_HLA_IRIFLE/wpn_combine_ar_fire_head_04.wav"}
----------------------------------------
function SWEP:CustomOnInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.Damage = 18
	else
		self.Damage = 12
	end
end

function SWEP:CustomOnPrimaryAttack_AfterShoot()
	VJ_EmitSound(self,self.AR2HEAD,75,100)
	VJ_EmitSound(self,self.AR2LFE,75,100)
end
-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base