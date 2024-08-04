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
SWEP.PrintName					= "SMG1"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.UseHands					= true
end
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_smg1.mdl"
SWEP.WorldModel					= "models/weapons/w_smg1.mdl"
SWEP.HoldType 					= "smg"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.Primary.Force				= 0 -- Force applied on the object the bullet hits
SWEP.NPC_NextPrimaryFireT2 = math.random(6.5,10)
	SWEP.NPC_TimeUntilFires	 		= math.random(6.5,10)	-- How much time until the bullet/projectile is fired?
SWEP.NPC_NextSecondaryFire 		= math.random(10.093,15.093)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= math.random(5,7) -- Damage
SWEP.Primary.ClipSize			= 45 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 0.09 -- Time until it can shoot again
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= {"Weapon_SMG1.Single"}
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?
SWEP.Primary.DistantSound		= {"Weapon_SMG1.NPC_Single"}
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_PistolShell1"
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.1 -- How much time until it plays the idle animation after attacking(Primary)
SWEP.NPC_NextPrimaryFire 		= math.random(0.09,0.19)
SWEP.NPC_CustomSpread	 		= 1



SWEP.NPC_HasSecondaryFire = true -- Can the weapon have a secondary fire?
SWEP.NPC_SecondaryFireEnt = "obj_vj_hl2_shell" -- The entity to fire, this only applies if self:NPC_SecondaryFire() has NOT been overridden!
SWEP.NPC_SecondaryFireChance = 1 -- Chance that the secondary fire is used | 1 = always
SWEP.NPC_SecondaryFireNext = VJ_Set(3, 8) -- How much time until the secondary fire can be used again?
SWEP.NPC_SecondaryFireDistance = 2000 -- How close does the owner's enemy have to be for it to fire?
SWEP.NPC_HasSecondaryFireSound = true -- Can the secondary fire sound be played?
SWEP.NPC_SecondaryFireSound = {"vj_mili_tank/tank_fire"..math.random(1,4)..".wav"} -- The sound it plays when the secondary fire is used
SWEP.NPC_SecondaryFireSoundLevel = 75 -- The sound level to use for the secondary firing sound

SWEP.AnimTbl_SecondaryFire		= {ACT_VM_SECONDARYATTACK}
SWEP.Secondary.DistantSound		= {"n_toz34_shot.mp3"}
function SWEP:CustomOnThink() 

if self.Owner.SquadName == "resistance" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_RPG}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE_RELAXED}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE_RELAXED}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN_RPG}
self.Owner.AnimTbl_Walk = {ACT_WALK_RPG_RELAXED}
end
end
if self.Owner.SquadName == "metrocop" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then

self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SMG1}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "metrocopg" then

self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "combine" then
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_IDLE_SMG1}
end
end
if self.Owner.SquadName == "combine_elit" then
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_IDLE_SMG1}
end
end
if self.Owner.SquadName == "metrocops" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then

self.Owner.AnimTbl_Run = {ACT_RUN}
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Walk = {ACT_IDLE_SMG1}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
end

