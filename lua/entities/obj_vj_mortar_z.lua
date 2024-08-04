--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Mortar"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "VJ Base"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Model = {"models/spitball_large.mdl"}
ENT.PhysicsInitType = SOLID_VPHYSICS
ENT.MoveType = MOVETYPE_VPHYSICS
ENT.MoveCollideType = MOVECOLLIDE_FLY_BOUNCE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.SolidType = SOLID_CUSTOM
ENT.ShouldSetOwner = true

ENT.PaintDecalOnDeath = true
ENT.DecalTbl_DeathDecals = {"Scorch"}

--ENT.SoundTbl_Idle = {"npc/vort/health_charge.wav"}
ENT.SoundTbl_OnRemove = {"weapons/mortar/mortar_explode1.wav","weapons/mortar/mortar_explode2.wav","weapons/mortar/mortar_explode3.wav"}

ENT.OnRemoveSoundLevel = 140
ENT.OnRemoveSoundPitch = VJ_Set(110, 120)

ENT.IdleSoundPitch1 = 170
ENT.IdleSoundPitch2 = 200
ENT.IdleSoundLevel = 80

ENT.DoesRadiusDamage = true
ENT.RadiusDamageRadius = 250
ENT.RadiusDamageUseRealisticRadius = true
ENT.RadiusDamage = 40
ENT.RadiusDamageType = bit.bor(DMG_DISSOLVE, DMG_SHOCK, DMG_BLAST)
ENT.RadiusDamageForce = 75

ENT.RemoveOnHit = true
ENT.CollideCodeWithoutRemoving = false

ENT.ShakeWorldOnDeath = true
ENT.ShakeWorldOnDeathAmplitude = 8
ENT.ShakeWorldOnDeathRadius = 3000
ENT.ShakeWorldOnDeathDuration = 1
ENT.ShakeWorldOnDeathFrequency = 200

function ENT:CustomOnInitialize()

	if math.random(1,2) == 1 then
		self.ShouldDoMortarEffect = true
	else
		self.ShouldDoMortarEffect = false
	end

	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:DrawShadow( false )
	self:SetColor( Color(0, 0, 255, 200) )

	if self.alien_projectile then

		self.Glow1 = ents.Create( "env_sprite" )
		self.Glow1:SetKeyValue( "rendercolor","0 100 255" )
		self.Glow1:SetKeyValue( "GlowProxySize","1.0" )
		self.Glow1:SetKeyValue( "HDRColorScale","1.0" )
		self.Glow1:SetKeyValue( "renderfx","14" )
		self.Glow1:SetKeyValue( "rendermode","3" )
		self.Glow1:SetKeyValue( "renderamt","150" )
		self.Glow1:SetKeyValue( "disablereceiveshadows","0" )
		self.Glow1:SetKeyValue( "mindxlevel","0" )
		self.Glow1:SetKeyValue( "maxdxlevel","0" )
		self.Glow1:SetKeyValue( "framerate","10.0" )
		self.Glow1:SetKeyValue( "model","sprites/blueflare1.spr" )
		self.Glow1:SetKeyValue( "spawnflags","0" )
		self.Glow1:SetKeyValue( "scale","1" )
		self.Glow1:SetPos( self:GetPos() )
		self.Glow1:Spawn()
		self.Glow1:SetParent( self )
		self:DeleteOnRemove(self.Glow1)

		self.Glow1 = ents.Create( "env_sprite" )
		self.Glow1:SetKeyValue( "rendercolor","0 20 50" )
		self.Glow1:SetKeyValue( "GlowProxySize","1.0" )
		self.Glow1:SetKeyValue( "HDRColorScale","1.0" )
		self.Glow1:SetKeyValue( "renderfx","14" )
		self.Glow1:SetKeyValue( "rendermode","3" )
		self.Glow1:SetKeyValue( "renderamt","150" )
		self.Glow1:SetKeyValue( "disablereceiveshadows","0" )
		self.Glow1:SetKeyValue( "mindxlevel","0" )
		self.Glow1:SetKeyValue( "maxdxlevel","0" )
		self.Glow1:SetKeyValue( "framerate","10.0" )
		self.Glow1:SetKeyValue( "model","sprites/blueflare1.spr" )
		self.Glow1:SetKeyValue( "spawnflags","0" )
		self.Glow1:SetKeyValue( "scale","5" )
		self.Glow1:SetPos( self:GetPos() )
		self.Glow1:Spawn()
		self.Glow1:SetParent( self )
		self:DeleteOnRemove(self.Glow1)

		self.BallLight = ents.Create("light_dynamic")
		self.BallLight:SetKeyValue("brightness", "3")
		self.BallLight:SetKeyValue("distance", "180")
		self.BallLight:SetLocalPos(self:GetPos())
		self.BallLight:SetLocalAngles( self:GetAngles() )
		self.BallLight:Fire("Color", "0 0 255")
		self.BallLight:SetParent(self)
		self.BallLight:Spawn()
		self.BallLight:Activate()
		self.BallLight:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.BallLight)

		ParticleEffectAttach("larvae_glow", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	
	else

		self.trail_lifetime = 1.8

		self:SetNoDraw(true)
		self.grenadeprop = ents.Create("prop_dynamic")
		self.grenadeprop:SetModel("models/weapons/ar2_grenade.mdl")
		self.grenadeprop:SetPos(self:GetPos())
		self.grenadeprop:SetAngles(self:GetAngles())
		self.grenadeprop:SetParent(self)
		self.grenadeprop:Spawn()
		self.grenadeprop:SetModelScale(2.25)
		util.SpriteTrail(self.grenadeprop, 0, Color(75,75,75), true, 14, 0, self.trail_lifetime, 0.008, "sprites/xbeam2")

		self.RadiusDamageType = DMG_BLAST

	end

end

function ENT:CustomPhysicsObjectOnInitialize(phys)

	phys:Wake()
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(-10)
	phys:SetMass( 0.1 )

end

function ENT:CustomOnThink()

	if !self.alien_projectile then
		self.grenadeprop:SetAngles(self:GetVelocity():Angle())
	end

	if self.alien_projectile then
		if self.ShouldDoMortarEffect then
			ParticleEffectAttach("extract_vorteat_juice", PATTACH_ABSORIGIN_FOLLOW, self, 0)
			self.ShouldDoMortarEffect = false
		else
			self.ShouldDoMortarEffect = true
		end
	else
		--something
	end

	if self:WaterLevel() > 1 then
		self:Remove()
	end

end

function ENT:DeathEffects()

	if self.alien_projectile then
	
		ParticleEffect( "Weapon_Combine_Ion_Cannon_Explosion_f", self:GetPos() - Vector(0,0,35), self:GetAngles() )
		ParticleEffect( "hunter_projectile_explosion_3b", self:GetPos(), self:GetAngles() )
		ParticleEffect("grenade_explosion_01", self:GetPos(), Angle(0,0,0), nil)
		ParticleEffect("Explosion_2_Chunks", self:GetPos(), Angle(0,0,0), nil)
		local expLight2 = ents.Create("light_dynamic")
		expLight2:SetKeyValue("brightness", "6")
		expLight2:SetKeyValue("distance", "500")
		expLight2:Fire("Color", "0 75 255")
		expLight2:SetPos(self:GetPos())
		expLight2:Spawn()
		expLight2:Activate()
		expLight2:Fire("TurnOn", "", 0)
		timer.Simple(0.1,function() if IsValid(expLight2) then expLight2:Remove() end end)
	
	else

		self.grenadeprop:SetParent(nil)
		self.grenadeprop:SetPos(self:GetPos())
		self.grenadeprop:SetNoDraw(true)
		local grenprop = self.grenadeprop
		timer.Simple(self.trail_lifetime, function() if IsValid(grenprop) then grenprop:Remove() end end)

		ParticleEffect("grenade_explosion_01", self:GetPos(), Angle(0,0,0), nil)
		ParticleEffect("Explosion_2_Chunks", self:GetPos(), Angle(0,0,0), nil)
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		util.Effect( "Explosion", effectdata )

	end

end
/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/