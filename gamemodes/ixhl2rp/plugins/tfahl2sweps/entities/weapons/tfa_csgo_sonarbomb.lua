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
name = "TFA_CSGO_Sensor.Equip",
channel = CHAN_WEAPON,
level = 65,
volume = 0.4,
sound = "weapons/tfa_csgo/sensorgrenade/sensor_equip.wav"
} )
sound.Add(
{
name = "TFA_CSGO_Sensor.Activate",
channel = CHAN_WEAPON,
level = 65,
volume = 0.5,
sound = "weapons/tfa_csgo/sensorgrenade/sensor_arm.wav"
} )
sound.Add(
{
name = "TFA_CSGO_Sensor.Land",
channel = CHAN_STATIC,
level = 65,
volume = 0.7,
sound = "weapons/tfa_csgo/sensorgrenade/sensor_land.wav"
} )
sound.Add(
{
name = "TFA_CSGO_Sensor.WarmupBeep",
channel = CHAN_STATIC,
level = 75,
volume = 0.3,
sound = "weapons/tfa_csgo/sensorgrenade/sensor_detect.wav"
} )
sound.Add(
{
name = "TFA_CSGO_Sensor.DetectPlayer_Hud",
channel = CHAN_STATIC,
level = 65,
volume = 0.5,
sound = "weapons/tfa_csgo/sensorgrenade/sensor_detecthud.wav"
} )
sound.Add(
{
name = "TFA_CSGO_Sensor.Detonate",
channel = CHAN_STATIC,
level = 140,
volume = 1.0,
sound = "weapons/tfa_csgo/sensorgrenade/sensor_explode.wav"
} )

SWEP.Category				= "TFA CS:GO Grenades"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Tactical Awareness Grenade"		-- Weapon name (Shown on HUD)	
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
SWEP.ViewModel				= "models/weapons/tfa_csgo/c_sonar_bomb.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_csgo/w_eq_sensorgrenade.mdl"	-- Weapon world model
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
SWEP.Primary.Ammo			= "csgo_sonarbomb"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("tfa_csgo_thrownsonar")	--NAME OF ENTITY GOES HERE

SWEP.Velocity = 750 -- Entity Velocity
SWEP.Velocity_Underhand = 375 -- Entity Velocity

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2,
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
