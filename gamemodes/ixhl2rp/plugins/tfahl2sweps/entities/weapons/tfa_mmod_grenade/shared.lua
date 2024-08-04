--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include("fonts.lua")

SWEP.WepSelectFont		= "TitleFont"
SWEP.WepSelectLetter	= "k"

-- Variables that are used on both client and server
SWEP.Gun = ("tfa_mmod_grenade") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end

-- SWEP Bases Variables
GRENADE_TIMER	= 2.5 //Seconds

GRENADE_PAUSED_NO			= 0
GRENADE_PAUSED_PRIMARY		= 1
GRENADE_PAUSED_SECONDARY	= 2

GRENADE_DAMAGE_RADIUS = 250.0

SWEP.FiresUnderwater = true
SWEP.Category				= "TFA MMOD"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "GRENADE"		-- Weapon name (Shown on HUD)	
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
SWEP.ViewModel				= "models/weapons/c_grenade.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/items/grenadeammo.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_nade_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.DisableIdleAnimations = false

SWEP.ProceduralHoslterEnabled = true
SWEP.ProceduralHolsterTime = 0.0
SWEP.ProceduralHolsterPos = Vector(0, 0, 0)
SWEP.ProceduralHolsterAng = Vector(0, 0, 0)

SWEP.Primary.RPM				= 120		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Grenade"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("mmod_frag")	--NAME OF ENTITY GOES HERE

SWEP.Velocity = 1200 -- Entity Velocity
SWEP.Velocity_Underhand = 350 -- Entity Velocity

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

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	}
}

SWEP.WalkAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "walk", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
}

SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

DEFINE_BASECLASS (SWEP.Base)

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	--self:ResetEvents()
	local mybool = self:GetNW2Bool("Underhanded", false)
	local tanim = mybool and ACT_VM_SECONDARYATTACK or ACT_VM_THROW or ACT_VM_HAULBACK
	if not self.SequenceEnabled[ACT_VM_SECONDARYATTACK] then
		tanim = ACT_VM_THROW
	end
	local success = true
	self:SendViewModelAnim(tanim)

	if game.SinglePlayer() then
		self:CallOnClient("AnimForce", tanim)
	end

	self.lastact = tanim

	return success, tanim
end

function SWEP:ChoosePullAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChoosePullAnim then
		self.Callback.ChoosePullAnim(self)
	end

	self:GetOwner():SetAnimation(PLAYER_RELOAD)
	--self:ResetEvents()
	local tanim = ACT_VM_PULLPIN
	local success = true
	local bool = self:GetNW2Bool("Underhanded", false)
	
	if not bool then
		tanim = ACT_VM_PULLBACK_LOW
	else
		tanim = ACT_VM_PULLPIN
	end
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce", tanim)
	end
	
	self:SendViewModelAnim(tanim)
	
	self.lastact = tanim

	return success, tanim
end

function SWEP:Throw()
	local pOwner = self.Owner;
	if self:Clip1() > 0 then
		local bool = self:GetNW2Bool("Underhanded", false)
		local own = self:GetOwner()

		if not bool then
			self:ThrowGrenade( pOwner )
		elseif self.Owner:KeyDown( IN_DUCK ) and bool then
			self:RollGrenade( pOwner );
		else
			self:LobGrenade( pOwner );
		end
	end

	self:TakePrimaryAmmo(1)
	self:DoAmmoCheck()
end

-- NEW FUNCTIONS

// check a throw from vecSrc.  If not valid, move the position back along the line to vecEye
function SWEP:CheckThrowPosition( pPlayer, vecEye, vecSrc )

	local tr;

	tr = {}
	tr.start = vecEye
	tr.endpos = vecSrc
	tr.mins = -Vector(4.0+2,4.0+2,4.0+2)
	tr.maxs = Vector(4.0+2,4.0+2,4.0+2)
	tr.mask = MASK_PLAYERSOLID
	tr.filter = pPlayer
	tr.collision = pPlayer:GetCollisionGroup()
	local trace = util.TraceHull( tr );

	if ( trace.Hit ) then
		vecSrc = tr.endpos;
	end

	return vecSrc

end

function SWEP:ThrowGrenade( pPlayer )

if ( !CLIENT ) then
	local	vecEye = pPlayer:EyePos();
	local 	vecShoot = pPlayer:GetShootPos();
	local	vForward, vRight;

	vForward = pPlayer:EyeAngles():Forward();
	vRight = pPlayer:EyeAngles():Right();
	local vecSrc = vecEye + vForward * 18.0 + vRight * 8.0;
	vecSrc = self:CheckThrowPosition( pPlayer, vecEye, vecSrc );
//	vForward.x = vForward.x + 0.1;
//	vForward.y = vForward.y + 0.1;

	local vecThrow;
	vecThrow = pPlayer:GetVelocity();
	vecThrow = vecThrow + vForward * 1200;
	local pGrenade = ents.Create( self.Primary.Round );
	pGrenade:SetPos( vecSrc );
	pGrenade:SetAngles( Angle(0,0,0) );
	pGrenade:SetOwner( pPlayer );
	pGrenade:Fire( "SetTimer", GRENADE_TIMER );
	pGrenade:Spawn()
	pGrenade:GetPhysicsObject():SetVelocity( vecThrow );
	pGrenade:GetPhysicsObject():AddAngleVelocity( Vector(600,math.random(-1200,1200),0) );

	if ( pGrenade ) then
		if ( pPlayer && !pPlayer:Alive() ) then
			vecThrow = pPlayer:GetVelocity();

			local pPhysicsObject = pGrenade:GetPhysicsObject();
			if ( pPhysicsObject ) then
				vecThrow = pPhysicsObject:SetVelocity();
			end
		end

		pGrenade.m_flDamage = self.Primary.Damage;
		pGrenade.m_DmgRadius = GRENADE_DAMAGE_RADIUS;
	end
end
end

function SWEP:LobGrenade( pPlayer )

if ( !CLIENT ) then
	local	vecEye = pPlayer:EyePos();
	local	vForward, vRight;
	local vecShoot = pPlayer:GetShootPos()

	vForward = pPlayer:EyeAngles():Forward();
	vRight = pPlayer:EyeAngles():Right();
	local vecSrc = vecEye + vForward * 18.0 + vRight * 8.0 + Vector( 0, 0, -8 );
	vecSrc = self:CheckThrowPosition( pPlayer, vecEye, vecSrc );

	local vecThrow;
	vecThrow = pPlayer:GetVelocity();
	vecThrow = vecThrow + vForward * 350 + Vector( 0, 0, 50 );
	local pGrenade = ents.Create( self.Primary.Round );
	pGrenade:SetPos( vecSrc );
	pGrenade:SetAngles( Angle(0,0,0) );
	pGrenade:SetOwner( pPlayer );
	pGrenade:Fire( "SetTimer", GRENADE_TIMER );
	pGrenade:Spawn()
	pGrenade:GetPhysicsObject():SetVelocity( vecThrow );
	pGrenade:GetPhysicsObject():AddAngleVelocity( Vector(200,math.random(-600,600),0) );

	if ( pGrenade ) then
		pGrenade.m_flDamage = self.Primary.Damage;
		pGrenade.m_DmgRadius = GRENADE_DAMAGE_RADIUS;
	end
end
end

function SWEP:RollGrenade( pPlayer )

if ( !CLIENT ) then
	// BUGBUG: Hardcoded grenade width of 4 - better not change the model :)
	local vecSrc;
	vecSrc = pPlayer:GetPos();
	vecSrc.z = vecSrc.z + 4.0;

	local vecFacing = pPlayer:GetAimVector( );
	// no up/down direction
	vecFacing.z = 0;
	vecFacing = VectorNormalize( vecFacing );
	local tr;
	tr = {};
	tr.start = vecSrc;
	tr.endpos = vecSrc - Vector(0,0,16);
	tr.mask = MASK_PLAYERSOLID;
	tr.filter = pPlayer;
	tr.collision = COLLISION_GROUP_NONE;
	tr = util.TraceLine( tr );
	if ( tr.Fraction != 1.0 ) then
		// compute forward vec parallel to floor plane and roll grenade along that
		local tangent;
		tangent = CrossProduct( vecFacing, tr.HitNormal );
		vecFacing = CrossProduct( tr.HitNormal, tangent );
	end
	vecSrc = vecSrc + (vecFacing * 18.0);
	vecSrc = self:CheckThrowPosition( pPlayer, pPlayer:GetPos(), vecSrc );

	local vecThrow;
	vecThrow = pPlayer:GetVelocity();
	vecThrow = vecThrow + vecFacing * 700;
	// put it on its side
	local orientation = Angle(0,pPlayer:GetLocalAngles().y,-90);
	// roll it
	local rotSpeed = Vector(0,0,720);
	local pGrenade = ents.Create( self.Primary.Round );
	pGrenade:SetPos( vecSrc );
	pGrenade:SetAngles( orientation );
	pGrenade:SetOwner( pPlayer );
	pGrenade:Fire( "SetTimer", GRENADE_TIMER );
	pGrenade:Spawn();
	pGrenade:GetPhysicsObject():SetVelocity( vecThrow );
	pGrenade:GetPhysicsObject():AddAngleVelocity( rotSpeed );

	if ( pGrenade ) then
		pGrenade.m_flDamage = self.Primary.Damage;
		pGrenade.m_DmgRadius = GRENADE_DAMAGE_RADIUS;
	end

end

	// player "shoot" animation
	pPlayer:SetAnimation( PLAYER_ATTACK1 );

end