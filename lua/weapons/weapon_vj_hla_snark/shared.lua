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
SWEP.PrintName					= "Snark"
SWEP.Author 					= ""
SWEP.Contact					= ""
SWEP.Purpose					= "This weapon is made for NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Half-Life: Alyx"
SWEP.HoldType 					= "grenade"
SWEP.Spawnable					= true
SWEP.AdminOnly					= false -- Is this weapon admin only?
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ View Model Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel = "models/weapons/v_vr_xen_snark.mdl"
SWEP.UseHands = false -- Should this weapon use Garry's Mod hands? (The model must support it!)
SWEP.ViewModelFOV = 90 -- Player FOV for the view model
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel = "models/weapons/w_vr_xen_snark.mdl" -- The world model (Third person, when a NPC is holding it, on ground, etc.)
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(90, -10, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-3, 1, 0)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand" -- The bone it will use as the main point (Owner's bone)
-- ====== Deployment Variables ====== --
SWEP.AnimTbl_Deploy = {ACT_VM_PICKUP}
SWEP.HasDeploySound = false -- Does the weapon have a deploy sound?
SWEP.DeploySound = {"creatures/snark/draw_admire01.wav"} -- Sound played when the weapon is deployed
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ General Player Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Inventory-Related Variables ====== --
SWEP.Slot = 4 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6)
	-- ====== Secondary Fire Variables ====== --
SWEP.AnimTbl_SecondaryFire = {ACT_VM_SECONDARYATTACK}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Primary Fire Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.DisableBulletCode = true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.Primary.ClipSize = 1 -- Max amount of bullets per clip
SWEP.Primary.Delay = 0.25 -- Time until it can shoot again
SWEP.Primary.TakeAmmo = 0 -- How much ammo should it take from the clip after each shot? | 0 = Unlimited clip
SWEP.Primary.Automatic = false -- Is it automatic?
SWEP.Primary.Ammo = "Snark" -- Ammo type
SWEP.AnimTbl_PrimaryFire = {ACT_VM_THROW}
	-- ====== Sound Variables ====== --
SWEP.Primary.Sound = {"creatures/snark/vox_jump_01.wav","creatures/snark/vox_jump_02.wav"}
----------------------------------------
function SWEP:CustomOnInitialize()
	timer.Simple(1,function()
		if IsValid(self) then
			self.AnimTbl_Deploy = {ACT_VM_DRAW}
		end
	end)
end

function SWEP:CustomOnThink()
	if self:GetOwner():IsPlayer() and self:GetOwner():IsSprinting() == true then
		self.AnimTbl_Idle = {ACT_VM_SPRINT_IDLE}
	else
		self.AnimTbl_Idle = {ACT_VM_IDLE}
	end
end

function SWEP:CustomOnPrimaryAttackEffects(owner)
	local snark = ents.Create("npc_vj_hla_snark")
	snark:SetPos(self:GetOwner():GetPos()+Vector(0,0,60)+self:GetOwner():GetForward()*50+self:GetOwner():GetRight()*7)
	snark:SetAngles(snark:GetAngles()+Angle(0,(self:GetOwner():GetAngles().Y),0))
	snark:Spawn()
	snark:SetVelocity(self:GetOwner():GetAimVector() * 700)
--	snark.VJ_NPC_Class = {"CLASS_ALIEN_MILITARY","CLASS_SNARK","CLASS_XEN","CLASS_PLAYER_ALLY"}
--	snark.FriendsWithAllPlayerAllies = true
	
	return false
end -- Return false to disable the base effects

function SWEP:CustomOnFireAnimationEvent(pos, ang, event, options)
	if options == "snark_drawadmire" then
		VJ_EmitSound(self,"creatures/snark/draw_admire01.wav",75,100)
	end
	return false
end
-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base