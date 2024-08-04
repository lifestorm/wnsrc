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
ENT.PrintName		= "Assassin Flechette"
ENT.Author 			= "Zippy"
ENT.Spawnable = false

ENT.Model = {"models/weapons/hunter_flechette.mdl"}

ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 5 -- How much damage should it do when it hits something
ENT.DirectDamageType = bit.bor(DMG_SLASH, DMG_SHOCK, DMG_NEVERGIB) -- Damage type

ENT.CollideCodeWithoutRemoving = true
ENT.RemoveOnHit = false -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:DrawShadow(false)
	util.SpriteTrail(self, 1, Color(75,75,75), true, 2, 0, 0.35, 0.008, "trails/tube")
	--ParticleEffectAttach("hunter_flechette_trail",PATTACH_ABSORIGIN_FOLLOW,self,0)

	self.grenadeprop = ents.Create("prop_dynamic")
	self.grenadeprop:SetModel("models/weapons/w_hopwire.mdl")
	self.grenadeprop:SetPos(self:GetAttachment(1).Pos+self:GetForward()*2)
	self.grenadeprop:SetAngles(self:GetAngles())
	self.grenadeprop:SetParent(self,1)
	self.grenadeprop:Spawn()
	self.grenadeprop:SetModelScale(1)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Blink()
	if !self:GetAttachment(1) then return end

	local light = ents.Create( "env_sprite" )
	light:SetKeyValue( "model","sprites/blueflare1.spr" )
	light:SetKeyValue( "rendercolor","0 125 255" )
	light:SetPos( self:GetAttachment(1).Pos )
	light:SetParent( self,1 )
	light:SetKeyValue( "scale","0.5" )
	light:SetKeyValue( "rendermode","7" )
	light:Spawn()
	self:DeleteOnRemove(light)

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "1")
    expLight:SetKeyValue("distance", "75")
    expLight:Fire("Color", "0 125 255")
    expLight:SetPos( self:GetAttachment(1).Pos )
    expLight:Spawn()
    expLight:Fire("TurnOn", "", 0)
    expLight:SetParent(self,1)

    timer.Simple(0.2,function() if IsValid(expLight) then expLight:Remove()  end end)
    timer.Simple(0.1,function() if IsValid(light) then light:Remove()  end end)

	self:EmitSound("buttons/button17.wav",80,math.random(135, 140))
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(false)
	phys:EnableDrag(false)
	phys:SetMass(0.1)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local parent = self:GetParent()
	if parent:IsPlayer() && !parent:Alive() then
		self:Remove()
	end

	if self:WaterLevel() > 0 then
		self:GetPhysicsObject():EnableGravity(true)
		self:Explode()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Explode(deploy_hopwire)
	local blastradius = 175
	local time_until_explode = 1

	if !deploy_hopwire then
		sound.EmitHint(SOUND_DANGER,self:GetPos(),blastradius*1.5,time_until_explode,self)

		local blip_reps = 6
		timer.Create("HopWireBlipTimer" .. self:EntIndex(), time_until_explode/blip_reps, blip_reps, function() if IsValid(self) then
			self:Blink()
		end end)
	end
	timer.Simple(time_until_explode, function() if IsValid(self) then

		if deploy_hopwire then
			local hopwire = ents.Create("obj_vj_hopwire_z")
			hopwire:SetPos(self:GetPos()-self:GetForward()*10)
			hopwire:SetOwner(self:GetOwner())
			hopwire:Spawn()
			hopwire.Target = self.Target
			hopwire.VJ_NPC_Class = self.VJ_NPC_Class
			if IsValid(self.Target) then
				hopwire:GetPhysicsObject():SetVelocity((self.Target:GetPos()-self:GetPos()):GetNormalized()*300)
			else
				hopwire:GetPhysicsObject():SetVelocity(self:GetForward()*-300)
			end

			self:EmitSound("weapons/tripwire/hook.wav",80,math.random(90, 110), 0.75)
			self:EmitSound("npc/ministrider/flechette_explode" .. math.random(1, 3) .. ".wav" , 80, math.random(160, 170), 0.66,  CHAN_WEAPON)
			ParticleEffect("Weapon_Combine_Ion_Cannon_i",self:GetPos(),Angle(0,0,0))
			--ParticleEffect("explosion_turret_break_b",self:GetPos(),Angle(0,0,0))
		else
			-- local realisticRadius = true

			-- self:EmitSound("npc/ministrider/flechette_explode" .. math.random(1, 3) .. ".wav" , 100, math.random(80, 90), 0.66,  CHAN_WEAPON)

			-- --ParticleEffect("hunter_projectile_explosion_1", self:GetPos(), Angle(0,0,0))
			-- ParticleEffect("hunter_projectile_explosion_2k", self:GetPos(), Angle(0,0,0))
			-- effects.BeamRingPoint(  self:GetPos(), 0.35, 0, blastradius*2, 13, 13, Color(0,75,255) )
			-- util.ScreenShake(self:GetPos(), 6, 200, 0.66, blastradius*4)

			-- -- local explosion = ents.Create("env_explosion")
			-- -- explosion:SetPos(self:GetPos())
			-- -- explosion:Fire("Explode")
			-- -- explosion:Fire("Kill")

			-- local expLight = ents.Create("light_dynamic")
			-- expLight:SetKeyValue("brightness", "4")
			-- expLight:SetKeyValue("distance", "400")
			-- expLight:Fire("Color", "0 75 255")
			-- expLight:SetPos(self:GetPos())
			-- expLight:Spawn()
			-- expLight:Fire("TurnOn", "", 0)
			-- timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)

			-- local attacker = self:GetOwner()
			-- if !IsValid(attacker) then attacker = self end

			-- util.VJ_SphereDamage(attacker, self, self:GetPos(), blastradius, 9, bit.bor(DMG_DISSOLVE, DMG_SHOCK, DMG_SONIC), true, realisticRadius)
			local hopwire = ents.Create("obj_vj_hopwire_z")
			hopwire:SetPos(self:WorldSpaceCenter())
			hopwire:SetOwner(self:GetOwner())
			hopwire:Spawn()
			hopwire.Target = self.Target
			hopwire.VJ_NPC_Class = self.VJ_NPC_Class
			hopwire.ExplodeTime = 0
			hopwire:Explode()
		end

		self:Remove()
	end end)

end
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
function ENT:CustomOnCollideWithoutRemove(data, phys)
	local hitent = data.HitEntity

	if self:IsAlly(hitent) then
		self:Remove()
		return
	end

	if hitent:GetClass() == "func_breakable_surf" then
		hitent:Fire("Shatter")
		self:GetPhysicsObject():EnableGravity(true)
		self:Explode(true)
	elseif hitent:IsNPC() or hitent:IsPlayer() then
		self:EmitSound("npc/ministrider/flechette_flesh_impact" .. math.random(1, 4) .. ".wav" , 85, math.random(75, 85))

		self:SetPos(data.HitPos)
		self:SetParent(hitent)
		self:SetSolid(SOLID_NONE)
		self:Explode()

		self:FireBullets({
			Src = self:GetPos(),
			Dir = self:GetForward(),
			Tracer = 0,
			Damage = 0,
			Distance = 25,
		})
	else
		self:EmitSound("npc/ministrider/flechette_impact_stick" .. math.random(1, 5) .. ".wav" , 85, math.random(75, 85))

		self:SetPos(data.HitPos)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)

		self:Explode(true)
	end

	self:FireBullets({
		Src = self:GetPos(),
		Dir = self:GetForward(),
		Tracer = 0,
		Damage = 0,
		Distance = 25,
	})

	local light = ents.Create( "env_sprite" )
	light:SetKeyValue( "model","sprites/blueflare1.spr" )
	light:SetKeyValue( "rendercolor","0 125 255" )
	light:SetPos( self.grenadeprop:GetPos() )
	light:SetParent( self.grenadeprop )
	light:SetKeyValue( "scale","0.25" )
	light:SetKeyValue( "rendermode","7" )
	light:Spawn()
	self:DeleteOnRemove(light)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------