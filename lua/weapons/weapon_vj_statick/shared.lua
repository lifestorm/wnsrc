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
SWEP.Base 						= "weapon_vj_melee_base_v2"



SWEP.PrintName					= "Shocker VJ"
SWEP.Author 					= "Comrade Communist"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.SwayScale 					= 1 -- Default is 1, The scale of the viewmodel sway
end
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_stunbaton.mdl"
SWEP.WorldModel					= "models/weapons/w_stunbaton.mdl"
SWEP.HoldType 					= "melee"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.IsVJBaseWeapon				= true
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= math.random(22,27) -- Damage
SWEP.Primary.PlayerDamage		= "Double" -- Only applies for players | "Same" = Same as self.Primary.Damage, "Double" = Double the self.Primary.Damage OR put a number to be different from self.Primary.Damage
SWEP.Primary.Force				= math.random(1,2) -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 10000000 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 1.3 -- How much recoil does the player get?
SWEP.NPC_TimeUntilFires	 		= math.random(0.4,0.8)
SWEP.NPC_NextPrimaryFire 		= 1.093
SWEP.Primary.Delay				= 0.8 -- Time until it can shoot again
SWEP.Primary.Automatic			= false -- Is it automatic?


SWEP.UseHands				= true
SWEP.ViewModelFOV			= 50

function SWEP:CustomOnThink() 
self.Owner.Weapon_FiringDistanceFar = math.random(35,45)
self.Owner.Weapon_FiringDistanceClose = math.random(-100,-1000)

self.Owner.WeaponReloadAnimationFaceEnemy = false
self.Owner.HasWeaponBackAway = false
self.Owner.AllowWeaponReloading = true
self.Owner.CanCrouchOnWeaponAttack = false
self.Owner.RunAwayOnUnknownDamage = false
self.Owner.MoveOrHideOnDamageByEnemy = false
self.Owner.DisableWeaponReloadAnimation = true
self.Owner.WaitForEnemyToComeOut = false
self.Owner.NoWeapon_UseScaredBehavior = false
self.Owner.RunFromEnemy_Distance = 0
end

function SWEP:CustomOnInitialize()
self.Owner.MeleeAttackDamage = math.random(20,30)
self.Owner.NextMeleeAttackTime = math.random(0.9,1.3)

self.Owner.AnimTbl_MeleeAttack = {"swing","pica_1"}
self.Owner.DefaultSoundTbl_MeleeAttack = {"Flesh.ImpactHard"}
self.Owner.DefaultSoundTbl_MeleeAttackMiss = {"Weapon_Melee.MacheteLight"}

self.Owner.AnimTbl_WeaponAttack = {ACT_IDLE}
end