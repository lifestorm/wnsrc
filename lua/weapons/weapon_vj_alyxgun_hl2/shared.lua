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
SWEP.PrintName					= "Alyx Pistol"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 1 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 1 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.SwayScale 					= 4 -- Default is 1, The scale of the viewmodel sway
SWEP.UseHands					= true
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= math.random(0.1,0.2,0.3,0.4,0.5,0.6) -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.8 -- This i added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_pistol.mdl"
SWEP.WorldModel					= "models/weapons/w_alyx_gun.mdl"
SWEP.HoldType 					= "pistol"
SWEP.Spawnable					= false
SWEP.AdminSpawnable				= false
SWEP.Primary.Force				= 0 -- Force applied on the object the bullet hits
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= math.random(9,11) -- Damage
SWEP.Primary.ClipSize			= 30 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 0.15 -- Time until it can shoot again
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.Primary.Sound				= {"alyx_gun/alyx_gun_fire4.wav"}
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?

SWEP.Primary.AllowFireInWater	= true -- If true, you will be able to use primary fire in water
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_PistolShell1"
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.4 -- Time until it can shoot again after deploying the weapon
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound				= true -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound				= "weapons/pistol/pistol_reload1.wav"
SWEP.Reload_TimeUntilAmmoIsSet	= 1 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 1.4 -- How much time until the player can play idle animation, shoot, etc.
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= math.random(0.10,0.20) -- How much time until it plays the idle animation after attacking(Primary)
SWEP.NPC_CustomSpread	 		= 1
function SWEP:CustomOnInitialize()

self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}
self.Owner.AnimTbl_Walk = {ACT_WALK}

 end

function SWEP:CustomOnThink() 
if self.Owner.SquadName == "alyx" then
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_IDLE_SMG1}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SHOTGUN}
self.Owner.AnimTbl_Run = {ACT_RUN_AIM_SHOTGUN}
self.Owner.AnimTbl_Walk = {ACT_WALK_AIM_SHOTGUN}
end
end
if self.Owner.SquadName == "resistance" then
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}

self.Owner.AnimTbl_Walk = {ACT_WALK}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_MELEE}
self.Owner.AnimTbl_Run = {ACT_RUN_CROUCH}
self.Owner.AnimTbl_Walk = {ACT_WALK}
end
end
if self.Owner.SquadName == "barney" then
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}

self.Owner.AnimTbl_Walk = {ACT_WALK}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_MELEE}
self.Owner.AnimTbl_Run = {ACT_RUN_CROUCH}
self.Owner.AnimTbl_Walk = {ACT_WALK}
end
end
if self.Owner.SquadName == "metrocopga" then
self.Owner.HoldType 					= "smg"
self.Owner.AnimTbl_WeaponAttack = {ACT_RANGE_ATTACK_SMG1}
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_WALK_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "metrocop" then
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}

self.Owner.AnimTbl_Walk = {ACT_WALK}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_PISTOL}
self.Owner.AnimTbl_Run = {ACT_RUN_PISTOL}
self.Owner.AnimTbl_Walk = {ACT_WALK_PISTOL}
end
end
if self.Owner.SquadName == "metrocops" then
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}

self.Owner.AnimTbl_Walk = {ACT_IDLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_PISTOL}
self.Owner.AnimTbl_Run = {ACT_RUN_PISTOL}
self.Owner.AnimTbl_Walk = {ACT_WALK_PISTOL}
end
end
end
