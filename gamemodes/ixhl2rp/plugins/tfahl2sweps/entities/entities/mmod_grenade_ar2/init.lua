--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
include( 'outputs.lua' )


MAX_AR2_NO_COLLIDE_TIME = 0.2

AR2_GRENADE_MAX_DANGER_RADIUS	= 300

// Moved to HL2_SharedGameRules because these are referenced by shared AmmoDef functions
local    sk_plr_dmg_smg1_grenade	= 100;
local    sk_npc_dmg_smg1_grenade	= 50;
local    sk_max_smg1_grenade		= 3;

local	  sk_smg1_grenade_radius		= 250;

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self:Precache( );
	self.Entity:SetModel( "models/Items/AR2_Grenade.mdl");
	self.Entity:PhysicsInit( SOLID_VPHYSICS );
	self.Entity:SetMoveCollide( MOVECOLLIDE_FLY_BOUNCE );

	// Hits everything but debris
	self.Entity:SetCollisionGroup( COLLISION_GROUP_PROJECTILE );
	self.Entity:GetPhysicsObject():SetBuoyancyRatio( 0 ) 

	self.Entity:SetCollisionBounds(Vector(-3, -3, -3), Vector(3, 3, 3));
//	self.Entity:SetCollisionBounds(Vector(0, 0, 0), Vector(0, 0, 0));

	self.Entity:NextThink( CurTime() + 0.1 );

	if( self:GetOwner() && self:GetOwner():IsPlayer() ) then
		self.m_flDamage = sk_plr_dmg_smg1_grenade;
	else
		self.m_flDamage = sk_npc_dmg_smg1_grenade;
	end

	self.m_DmgRadius	= sk_smg1_grenade_radius;
	self.m_takedamage	= DAMAGE_YES;
	self.m_bIsLive		= true;
	self.m_iHealth		= 1;

	self.Entity:SetGravity( 400 / 600 );	// use a lower gravity for grenades to make them easier to see
	self.Entity:SetFriction( 0.8 );
	self.Entity:SetSequence( 0 );

	self.m_fDangerRadius = 100;

	self.m_fSpawnTime = CurTime();
	
	ParticleEffectAttach("hl2mmod_weapon_smg_grenadetrail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	self:OnInitialize();

end


//-----------------------------------------------------------------------------
// Purpose:  The grenade has a slight delay before it goes live.  That way the
//			 person firing it can bounce it off a nearby wall.  However if it
//			 hits another character it blows up immediately
// Input  :
// Output :
//-----------------------------------------------------------------------------
function ENT:Think()

	self:OnThink()

	self.Entity:NextThink( CurTime() + 0.05 );

	if (!self.m_bIsLive) then
		// Go live after a short delay
		if (self.m_fSpawnTime + MAX_AR2_NO_COLLIDE_TIME < CurTime()) then
			self.m_bIsLive  = true;
		end
	end

	// If I just went solid and my velocity is zero, it means I'm resting on
	// the floor already when I went solid so blow up
	if (self.m_bIsLive) then
		if (self.Entity:GetVelocity():Length() == 0.0 ||
			self.Entity:GetGroundEntity() != NULL ) then
			// self:Detonate();
		end
	end

	// The old way of making danger sounds would scare the crap out of EVERYONE between you and where the grenade
	// was going to hit. The radius of the danger sound now 'blossoms' over the grenade's lifetime, making it seem
	// dangerous to a larger area downrange than it does from where it was fired.
	if( self.m_fDangerRadius <= AR2_GRENADE_MAX_DANGER_RADIUS ) then
		self.m_fDangerRadius = self.m_fDangerRadius + ( AR2_GRENADE_MAX_DANGER_RADIUS * 0.05 );
	end

end

/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide( data, physobj )

	self:Touch( data.HitEntity )
	self.PhysicsCollide = function( ... ) return end

end

function ENT:Detonate()

	if (!self.m_bIsLive) then
		return;
	end
	self.m_bIsLive		= false;
	self.m_takedamage	= DAMAGE_NO;

	if(self.m_hSmokeTrail) then
		self.m_hSmokeTrail:Remove();
		self.m_hSmokeTrail = NULL;
	end

	self:DoExplodeEffect()

	local vecForward = self.Entity:GetVelocity();
	vecForward = VectorNormalize(vecForward);
	local		tr;
	tr = {};
	tr.start = self.Entity:GetPos();
	tr.endpos = self.Entity:GetPos() + 60*vecForward;
	tr.mask = MASK_SHOT;
	tr.filter = self;
	tr.collision = COLLISION_GROUP_NONE;
	tr = util.TraceLine ( tr);

	if self:WaterLevel() < 3 then
		local explode = ents.Create( "info_particle_system" )
		explode:SetKeyValue( "effect_name", "hl2mmod_explosion_grenade_noaftersmoke" )
		explode:SetOwner( self.Owner )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:Activate()
		explode:Fire( "start", "", 0 )
		explode:Fire( "kill", "", 30 )
	end

	self:OnExplode( tr );

	self.Entity:EmitSound( self.Sound.Explode );

	util.ScreenShake( self.Entity:GetPos(), 25.0, 150.0, 1.0, 750, SHAKE_START );

	util.BlastDamage ( self.Entity, self:GetOwner(), self.Entity:GetPos(), self.m_DmgRadius, self.m_flDamage );

	self.Entity:Remove();

end

function ENT:Precache()

	util.PrecacheModel("models/Items/AR2_Grenade.mdl");

end