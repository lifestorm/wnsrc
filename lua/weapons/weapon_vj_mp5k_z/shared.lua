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
SWEP.Base = "weapon_vj_smg1"
SWEP.PrintName = "MP5K"
SWEP.Author = "Zippy"
SWEP.Category = "VJ Base"

SWEP.MadeForNPCsOnly = true
SWEP.WorldModel = "models/weapons/w_mp5k.mdl"

SWEP.Primary.Damage				= 6 -- Damage
SWEP.Primary.ClipSize			= 30 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 0.12 -- Time until it can shoot again
SWEP.Primary.Sound				= {"weapons/mp5k_comb/mp5k_fire2.wav"}
SWEP.Primary.DistantSound		= {"weapons/mp5k_comb/mp5k_fire_dist.wav"}

SWEP.NPC_HasSecondaryFire = false -- Can the weapon have a secondary fire?
---------------------------------------------------------------------------------------------------------------------------------------------