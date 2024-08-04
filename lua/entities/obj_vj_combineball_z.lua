--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- This is just a regular VJ Base combine ball, but it explodes on impact with enemies.

AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_combineball"
ENT.PrintName		= "Impact Combine Ball"
ENT.Author 			= "DrVrej" -- Edited by Zippy.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.DirectDamage = 30
ENT.ExplosionDamage = 30
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPhysicsCollide(data, phys)
	local owner = self:GetOwner()
	local hitEnt = data.HitEntity
	if IsValid(owner) then
        local hit_enemy = ( (hitEnt != owner) && (owner:IsPlayer() or owner:DoRelationshipCheck(hitEnt)) )

		if (VJ_IsProp(hitEnt)) or hit_enemy then
			self:CustomOnDoDamage_Direct(data, phys, hitEnt)
			local dmgInfo = DamageInfo()
			dmgInfo:SetDamage(self.DirectDamage)
			dmgInfo:SetDamageType(self.DirectDamageType)
			dmgInfo:SetAttacker(owner)
			dmgInfo:SetInflictor(self)
			dmgInfo:SetDamagePosition(data.HitPos)
			hitEnt:TakeDamageInfo(dmgInfo, self)
			VJ_DestroyCombineTurret(owner, hitEnt)
            self:DeathEffects()
		end
	else
		self:CustomOnDoDamage_Direct(data, phys, hitEnt)
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamage(self.DirectDamage)
		dmgInfo:SetDamageType(self.DirectDamageType)
		dmgInfo:SetAttacker(self)
		dmgInfo:SetInflictor(self)
		dmgInfo:SetDamagePosition(data.HitPos)
		hitEnt:TakeDamageInfo(dmgInfo, self)
		VJ_DestroyCombineTurret(self, hitEnt)
	end

	if (hitEnt:IsNPC() or hitEnt:IsPlayer()) then return end
	
	self:OnBounce(data,phys)

	local dataF = EffectData()
	dataF:SetOrigin(data.HitPos)
	util.Effect("cball_bounce", dataF)

	dataF = EffectData()
	dataF:SetOrigin(data.HitPos)
	dataF:SetNormal(data.HitNormal)
	dataF:SetScale(50)
	util.Effect("AR2Impact", dataF)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local color1 = Color(255, 255, 225, 32)
local color2 = Color(255, 255, 225, 64)

function ENT:DeathEffects(data, phys)
	local myPos = self:GetPos()
	effects.BeamRingPoint(myPos, 0.2, 12, 1024, 64, 0, color1, {material="sprites/lgtning.vmt", framerate=2, flags=0, speed=0, delay=0, spread=0})
	effects.BeamRingPoint(myPos, 0.5, 12, 1024, 64, 0, color2, {material="sprites/lgtning.vmt", framerate=2, flags=0, speed=0, delay=0, spread=0})

	local effectData = EffectData()
	effectData:SetOrigin(myPos)
	util.Effect("cball_explode", effectData)

	VJ_EmitSound(self, "weapons/physcannon/energy_sing_explosion2.wav", 150)
	util.ScreenShake(myPos, 20, 150, 1, 1250)
	util.VJ_SphereDamage(self, self, myPos, 400, self.ExplosionDamage, bit.bor(DMG_SONIC, DMG_BLAST), true, true, {DisableVisibilityCheck=true, Force=80})

	self:Remove()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------