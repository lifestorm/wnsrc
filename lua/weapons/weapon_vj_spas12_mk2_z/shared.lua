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
SWEP.Base = "weapon_vj_spas12"
SWEP.Author = "Zippy"
SWEP.PrintName = "SPAS-12 MK2"

SWEP.NPC_CustomSpread = 1 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy
SWEP.NPC_ExtraFireSound = {"weapons/shotgun/shotgun_cock.wav"} -- Plays an extra sound after it fires (Example: Bolt action sound)
SWEP.NPC_FiringDistanceScale = 1 -- Changes how far the NPC can fire | 1 = No change, x < 1 = closer, x > 1 = farther
--SWEP.MadeForNPCsOnly = true

SWEP.Primary.ClipSize			= 8 -- Max amount of bullets per clip
SWEP.Primary.Damage = 6 -- Damage
SWEP.Primary.PlayerDamage = "Same" -- Only applies for players | "Same" = Same as self.Primary.Damage, "Double" = Double the self.Primary.Damage OR put a number to be different from self.Primary.Damage
SWEP.Primary.NumberOfShots = 8 -- How many shots per attack?

SWEP.Primary.DistantSoundLevel = 130 -- Distant sound level
SWEP.Primary.DistantSoundVolume	= 0.75 -- Distant sound volume

SWEP.Primary.Sound = {"weapons/shotgun/shotgun_dbl_fire.wav"}
SWEP.Primary.DistantSound = {"weapons/shotgun/shotgun_dbl_fire7.wav","weapons/shotgun/shotgun_fire6.wav","weapons/shotgun/shotgun_fire7.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_AfterShoot()
    if !self.DoubleBlasting && math.random(1, 2)==1 then
        timer.Simple(0.1, function() if IsValid(self) && self:Clip1() > 0 then
            self.DoubleBlasting = true
            self:PrimaryAttack()
            self.DoubleBlasting = false
        end end)
    end

	timer.Simple(0.2, function()
		if IsValid(self) && IsValid(self:GetOwner()) && self:GetOwner():IsPlayer() then
			self:EmitSound(Sound("weapons/shotgun/shotgun_cock.wav"), 80, 100)
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------