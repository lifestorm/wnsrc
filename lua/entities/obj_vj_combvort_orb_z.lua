--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Heal Orb"
ENT.Author 			= "Zippy"
ENT.Spawnable = false

ENT.Model = {"models/spitball_medium.mdl"}

ENT.DoesRadiusDamage = true
ENT.RadiusDamage = 10
ENT.RadiusDamageRadius = 50
ENT.RadiusDamageType = bit.bor(DMG_NEVERGIB, DMG_DISSOLVE, DMG_SHOCK)

ENT.HealAmt = 10
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

	local effectdata = EffectData()
	effectdata:SetEntity(self)
	util.Effect("combvort_orbfx", effectdata)

	self:SetNoDraw(true)
	self:DrawShadow(false)

	local timer_name = "vj_homingtimer_z" .. self:EntIndex()
	timer.Create(timer_name, 0.05, 0, function()
		if IsValid(self) && self.Target && IsValid(self.Target) then

			local own = self:GetOwner()
			local enemyvisible = false

			local idealang = ( self.Target:GetPos()+self.Target:OBBCenter() - self:GetPos() ):Angle()
			local ang = LerpAngle(self.TrackRatio,self:GetAngles(),idealang)
			self:SetAngles(ang)
			self:GetPhysicsObject():SetVelocity( self:GetForward()*self.Speed )

			local targetdist = self:GetPos():Distance(self.Target:GetPos())
			if targetdist < 100 then
				timer.Remove(timer_name)
			end

		else
			timer.Remove(timer_name)
		end
	end)

	timer.Simple(5, function() if IsValid(self) then
		self:DeathEffects()
		self:Remove()
	end end)

	local light = ents.Create( "env_sprite" )
	light:SetKeyValue( "model","sprites/blueflare1.spr" )
	light:SetKeyValue( "rendercolor","0 50 255" )
	light:SetKeyValue( "renderamt","0.75" )
	light:SetPos( self:GetPos() )
	light:SetParent( self )
	light:SetKeyValue( "scale","0.5" )
	light:SetKeyValue( "rendermode","9" )
	light:Spawn()
	self:DeleteOnRemove(light)

	self.DynLight = ents.Create("light_dynamic")
	self.DynLight:SetKeyValue("brightness", "1")
	self.DynLight:SetKeyValue("distance", "150")
	self.DynLight:Fire("Color", "0 75 255")
	self.DynLight:SetPos(self:GetPos())
	self.DynLight:SetParent(self)
	self.DynLight:Spawn()
	self.DynLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.DynLight)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(false)
	phys:EnableDrag(false)
	phys:SetMass(0.1)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink() end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsAlly(ent)

    if !ent.VJ_NPC_Class then return end

    for _,npcclass in pairs(ent.VJ_NPC_Class) do
        for _,mynpcclass in pairs(self.VJ_NPC_Class) do
            if npcclass == mynpcclass then
                return true
            end
        end
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data)
	effects.BeamRingPoint( self:GetPos(), 0.2, 0, self.RadiusDamageRadius*1.25, 10, 3, Color(0,75,255) )

	local ent_healed = false
	local do_damage_effect = true

	for _,ent in pairs( ents.FindInSphere(self:GetPos(), self.RadiusDamageRadius) ) do
		if self:IsAlly(ent) && ent:GetClass() != "npc_vj_vortigaunt_synth_z" && ent != self then
			if ent:Health() < ent:GetMaxHealth() then
				ent:SetHealth( math.Clamp(ent:Health()+self.HealAmt, 0, ent:GetMaxHealth()) )
				ent_healed = true
			end
			do_damage_effect = false
		end
	end

	if ent_healed then
		self:EmitSound("items/smallmedkit1.wav",85,math.random(90, 110))
	end
	if do_damage_effect then
		if data && !self:IsAlly(data.HitEntity) && (data.HitEntity:IsNPC() or data.HitEntity:IsPlayer()) then
			ParticleEffect("Weapon_Combine_Ion_Cannon_i",self:GetPos(),Angle(0,0,0))
			self:EmitSound("npc/vortsynth/vort_attack_shoot" .. math.random(1, 3) .. ".wav",85,math.random(160, 170),0.75,CHAN_WEAPON)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------