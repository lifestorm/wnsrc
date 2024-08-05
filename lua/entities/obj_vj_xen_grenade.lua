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
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Xen Grenade"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Half-Life: Alyx"

ENT.Spawnable = true
ENT.AdminOnly = false

ENT.VJ_IsDetectableGrenade = true
ENT.VJ_IsPickupableDanger = true

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/weapons/w_vr_xen_grenade.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.MoveCollideType = nil
ENT.CollisionGroupType = nil
ENT.SolidType = SOLID_VPHYSICS
ENT.RemoveOnHit = false -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 250 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 80 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BLAST -- Damage type
ENT.RadiusDamageForce = 90 -- Put the force amount it should apply | false = Don't apply any force
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_Startup = {"world/infestation/xen_grenade_blip.wav"}
ENT.SoundTbl_OnRemove = {"world/infestation/xen_grenade_explode_01.mp3"}

-- Custom
ENT.FussTime = 3.4
ENT.TimeSinceSpawn = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	//if self:GetOwner():IsValid() && (self:GetOwner().GrenadeAttackFussTime) then
	//timer.Simple(self:GetOwner().GrenadeAttackFussTime,function() if IsValid(self) then self:DeathEffects() end end) else
	timer.Simple(self.FussTime,function() if IsValid(self) then self:DeathEffects() end end)
	//end
	self:SetSkin(1)
	ParticleEffectAttach("grenade_xen_b",PATTACH_POINT_FOLLOW,self,1)
	util.SpriteTrail(self,0,Color(0,255,191,255),false,15,10,0.5,1 / ( 20 + 20 ) * 0.5,"particle/beam_hotwhite.vmt")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self.TimeSinceSpawn = self.TimeSinceSpawn + 0.2
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage(dmginfo)
	if IsValid(self:GetPhysicsObject()) then
		self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPhysicsCollide(data, phys)
	local getVel = phys:GetVelocity()
	local curVelSpeed = getVel:Length()
	//print(curVelSpeed)
	if curVelSpeed > 500 then -- Or else it will go flying! 
		phys:SetVelocity(getVel * 0.25)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local defAngle = Angle(0, 0, 0)
local vecZ4 = Vector(0, 0, 4)
local vezZ100 = Vector(0, 0, 100)
--
function ENT:DeathEffects()
	local selfPos = self:GetPos()
	
	ParticleEffect("explosion_xen_grenade_1", selfPos, self:GetAngles()) -- +Vector(0,0,25)

	self:SetLocalPos(selfPos + vecZ4) -- Because the entity is too close to the ground
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() - vezZ100,
		filter = self
	})
	util.Decal(VJ_PICK(self.DecalTbl_DeathDecals), tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	
	self:DoDamageCode()
	self:SetDeathVariablesTrue(nil, nil, false)
	self:Remove()
end