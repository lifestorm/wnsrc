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
SWEP.PrintName					= "Xen Grenade"
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
SWEP.ViewModel = "models/weapons/c_vr_xen_grenade.mdl"
SWEP.UseHands = true -- Should this weapon use Garry's Mod hands? (The model must support it!)
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/weapons/w_vr_xen_grenade.mdl" -- The world model (Third person, when a NPC is holding it, on ground, etc.)
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0, 0, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(2, 3, -0.5)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand" -- The bone it will use as the main point (Owner's bone)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ General Player Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Inventory-Related Variables ====== --
SWEP.Slot = 4 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6)
	-- ====== Reload Variables ====== --
SWEP.AnimTbl_Reload = {ACT_VM_DRAW}
SWEP.Reload_TimeUntilAmmoIsSet = 0.25 -- Time until ammo is set to the weapon
	-- ====== Secondary Fire Variables ====== --
SWEP.AnimTbl_SecondaryFire = {ACT_VM_SECONDARYATTACK}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Primary Fire Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.DisableBulletCode = true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.Primary.ClipSize = 1 -- Max amount of bullets per clip
SWEP.Primary.Delay = 0.5 -- Time until it can shoot again
SWEP.Primary.TakeAmmo = 0 -- How much ammo should it take from the clip after each shot? | 0 = Unlimited clip
SWEP.Primary.Automatic = false -- Is it automatic?
SWEP.Primary.Ammo = "Grenade" -- Ammo type
SWEP.AnimTbl_PrimaryFire = {ACT_VM_THROW}
----------------------------------------
function SWEP:CustomOnPrimaryAttackEffects(owner)
	local grenade = ents.Create("obj_vj_xen_grenade")
	grenade:SetPos(self:GetOwner():GetPos()+Vector(0,0,60)+self:GetOwner():GetForward()*20+self:GetOwner():GetRight()*7)
	grenade:Spawn()
	grenade:Activate()
	
	local phys = grenade:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(self:GetOwner():GetAimVector() * 1000)
	end
	
	return false
end -- Return false to disable the base effects

-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base