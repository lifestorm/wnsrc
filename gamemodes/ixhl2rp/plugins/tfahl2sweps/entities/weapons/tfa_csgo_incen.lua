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
name = "TFA_CSGO_INCENDGRENADE.Bounce",
channel = CHAN_ITEM,
level = 75,
volume = 0.6,
sound = "arccw_go/incgrenade/inc_grenade_bounce-1.wav"
} )
sound.Add(
{
name = "TFA_CSGO_INCENDGRENADE.PullPin_Grenade_Start",
channel = CHAN_WEAPON,
level = 65,
sound = "arccw_go/incgrenade/pinpull_start.wav"
} )
sound.Add(
{
name = "TFA_CSGO_INCENDGRENADE.PullPin_Grenade",
channel = CHAN_WEAPON,
level = 65,
sound = "arccw_go/incgrenade/pinpull.wav"
} )
sound.Add(
{
name = "TFA_CSGO_INCENDGRENADE.Draw",
channel = CHAN_ITEM,
level = 65,
volume = 0.5,
sound = "arccw_go/incgrenade/inc_grenade_draw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_INCENDGRENADE.Throw",
channel = CHAN_WEAPON,
level = 65,
sound = "arccw_go/incgrenade/inc_grenade_throw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_IncGrenade.Bounce",
channel = CHAN_ITEM,
level = 75,
volume = 0.6,
sound = "arccw_go/incgrenade/inc_grenade_bounce-1.wav"
} )
sound.Add(
{
name = "TFA_CSGO_IncGrenade.PullPin_Grenade_Start",
channel = CHAN_WEAPON,
level = 65,
sound = "arccw_go/incgrenade/pinpull_start.wav"
} )
sound.Add(
{
name = "TFA_CSGO_IncGrenade.PullPin_Grenade",
channel = CHAN_WEAPON,
level = 65,
sound = "arccw_go/incgrenade/pinpull.wav"
} )
sound.Add(
{
name = "TFA_CSGO_IncGrenade.Draw",
channel = CHAN_ITEM,
level = 65,
volume = 0.5,
sound = "arccw_go/incgrenade/inc_grenade_draw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_IncGrenade.Throw",
channel = CHAN_WEAPON,
level = 65,
sound = "arccw_go/incgrenade/inc_grenade_throw.wav"
} )
sound.Add(
{
name = "TFA_CSGO_Inferno.Start_IncGrenade",
channel = CHAN_WEAPON,
level = 95,
sound = { "arccw_go/incgrenade/inc_grenade_detonate_1.wav",
"arccw_go/incgrenade/inc_grenade_detonate_2.wav",
"arccw_go/incgrenade/inc_grenade_detonate_3.wav" }
} )
sound.Add(
{
name = "TFA_CSGO_IncGrenade.Start",
channel = CHAN_WEAPON,
level = 95,
sound = { "arccw_go/incgrenade/inc_grenade_detonate_1.wav",
"arccw_go/incgrenade/inc_grenade_detonate_2.wav",
"arccw_go/incgrenade/inc_grenade_detonate_3.wav" }
} )

SWEP.Category				= "TFA CS:GO Grenades"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Incendiary Grenade"		-- Weapon name (Shown on HUD)	
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
SWEP.ViewModel				= "models/weapons/arccw_go/v_eq_incendiarygrenade.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/arccw_go/w_eq_incendiarygrenade_thrown.mdl"	-- Weapon world model
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
SWEP.Primary.Ammo			= "csgo_incend"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug


SWEP.Primary.Damage = 100
SWEP.Primary.Round 			= ("tfa_csgo_thrownincen")	--NAME OF ENTITY GOES HERE

SWEP.Velocity = 850 -- Entity Velocity
SWEP.Velocity_Underhand = 375 -- Entity Velocity

SWEP.Delay = 0.05 -- Delay to fire entity
SWEP.Delay_Underhand = 0.2 -- Delay to fire entity

SWEP.MoveSpeed = 245/260 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed  = 245/260*0.8 --Multiply the player's movespeed by this when sighting.

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1.8,
        Forward = 3.2,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 180
        },
		Scale = 0.8
}

function SWEP:ChoosePullAnim()
	if !self:OwnerIsValid() then return end
	
	self.Owner:SetAnimation(PLAYER_RELOAD)
	--self:ResetEvents()
	local tanim=ACT_VM_PULLPIN
	local success = true
	self:SendWeaponAnim(ACT_VM_PULLPIN)
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	return success, tanim
end

function SWEP:ThrowStart()
	if self:Clip1()>0 then
		self:ChooseShootAnim()
		self:SetNWBool("Ready",false)
		local bool = self:GetNWBool("Underhanded",false)
		if bool then
			timer.Simple(self.Delay_Underhand,function()
				if IsValid(self) and self:OwnerIsValid() then self:Throw() end
			end)
		else
			timer.Simple(self.Delay,function()
				if IsValid(self) and self:OwnerIsValid() then self:Throw() end
			end)
		end
		
	end
end
