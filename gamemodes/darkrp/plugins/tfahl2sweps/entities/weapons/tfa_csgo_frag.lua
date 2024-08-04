--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

sound.Add(
{
name = "TFA_CSGO_FRAGGRENADE.PullPin_Grenade",
channel = CHAN_WEAPON,
level = 65,
sound = "weapons/tfa_csgo/hegrenade/pinpull.wav"
} )
sound.Add(
{
name = "TFA_CSGO_FRAGGRENADE.PullPin_Grenade_Start",
channel = CHAN_WEAPON,
level = 65,
sound = "weapons/tfa_csgo/hegrenade/pinpull_start.wav"
} )
sound.Add(
{
name = "TFA_CSGO_FRAGGRENADE.Bounce",
channel = CHAN_ITEM,
level = 75,
volume = 0.6,
sound = "weapons/tfa_csgo/hegrenade/he_bounce-1.wav"
} )
sound.Add(
{
name = "TFA_CSGO_FRAGGRENADE.Throw",
channel = CHAN_WEAPON,
level = 65,
sound = "weapons/tfa_csgo/hegrenade/grenade_throw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_FRAGGRENADE.Draw",
channel = CHAN_ITEM,
level = 65,
volume = 0.5,
sound = "weapons/tfa_csgo/hegrenade/he_draw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_HEGrenade.PullPin_Grenade",
channel = CHAN_WEAPON,
level = 65,
sound = "weapons/tfa_csgo/hegrenade/pinpull.wav"
} )
sound.Add(
{
name = "TFA_CSGO_HEGrenade.PullPin_Grenade_Start",
channel = CHAN_WEAPON,
level = 65,
sound = "weapons/tfa_csgo/hegrenade/pinpull_start.wav"
} )
sound.Add(
{
name = "TFA_CSGO_HEGrenade.Bounce",
channel = CHAN_ITEM,
level = 75,
volume = 0.6,
sound = "weapons/tfa_csgo/hegrenade/he_bounce-1.wav"
} )
sound.Add(
{
name = "TFA_CSGO_HEGrenade.Throw",
channel = CHAN_WEAPON,
level = 65,
sound = "weapons/tfa_csgo/hegrenade/grenade_throw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_HEGrenade.Draw",
channel = CHAN_ITEM,
level = 65,
volume = 0.5,
sound = "weapons/tfa_csgo/hegrenade/he_draw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_BaseGrenade.ExplodeOld",
channel = CHAN_WEAPON,
level = 140,
sound = { "weapons/tfa_csgo/hegrenade/explode3.wav",
"weapons/tfa_csgo/hegrenade/explode4.wav",
"weapons/tfa_csgo/hegrenade/explode5.wav" }
} )
sound.Add(
{
name = "TFA_CSGO_BaseGrenade.Explode",
channel = CHAN_WEAPON,
level = 140,
sound = { --"weapons/tfa_csgo/hegrenade/hegrenade_detonate01.wav",
"weapons/tfa_csgo/hegrenade/hegrenade_detonate_02.wav",
"weapons/tfa_csgo/hegrenade/hegrenade_detonate_03.wav" }
} )

SWEP.Category				= "TFA CS:GO Grenades"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "High Explosive Grenade"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 40			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 2			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "grenade"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_eq_fraggrenade.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_frag.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_csnade_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true

SWEP.ProceduralHoslterEnabled = true
SWEP.ProceduralHolsterTime = 0.0
SWEP.ProceduralHolsterPos = Vector(0, 0, 0)
SWEP.ProceduralHolsterAng = Vector(0, 0, 0)

SWEP.Primary.RPM				= 30		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "csgo_frag"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("tfa_csgo_thrownfrag")	--NAME OF ENTITY GOES HERE

SWEP.Velocity = 750 -- Entity Velocity
SWEP.Velocity_Underhand = 375 -- Entity Velocity

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1,
        Forward = 3,
        },
        Ang = {
        Up = -1,
        Right = -2,
        Forward = 178
        },
		Scale = 1
}

SWEP.MoveSpeed = 245/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 245/260*0.8 --Multiply the player's movespeed by this when sighting.
