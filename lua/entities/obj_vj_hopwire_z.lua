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
ENT.PrintName		= "Hopwire"
ENT.Author 			= "Zippy"
ENT.Spawnable = false

ENT.Model = {"models/weapons/w_hopwire.mdl"}
ENT.RemoveOnHit = false -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.

ENT.JumpTime = 2
ENT.ExplodeTime = 1
ENT.AttackRadius = 300
ENT.BeamDamage = 15
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Blink()
	local light = ents.Create( "env_sprite" )
	light:SetKeyValue( "model","sprites/blueflare1.spr" )
	light:SetKeyValue( "rendercolor","0 125 255" )
	light:SetPos( self:GetPos() )
	light:SetParent( self )
	light:SetKeyValue( "scale","0.5" )
	light:SetKeyValue( "rendermode","7" )
	light:Spawn()
	self:DeleteOnRemove(light)

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "1")
    expLight:SetKeyValue("distance", "75")
    expLight:Fire("Color", "0 125 255")
    expLight:SetPos(self:GetPos())
    expLight:Spawn()
    expLight:Fire("TurnOn", "", 0)
    expLight:SetParent(self)

    timer.Simple(0.2,function() if IsValid(expLight) then expLight:Remove()  end end)
    timer.Simple(0.1,function() if IsValid(light) then light:Remove()  end end)

    self:EmitSound("buttons/button17.wav",80,math.random(120, 125))
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    sound.EmitHint(SOUND_DANGER,self:GetPos(),self.AttackRadius,self.JumpTime+self.ExplodeTime,self)

    timer.Simple(self.JumpTime, function() if IsValid(self) then
        self:Explode()
    end end)

    local blip_reps = 6
    timer.Create("HopWireBlipTimer" .. self:EntIndex(), (self.JumpTime+self.ExplodeTime)/blip_reps, blip_reps, function() if IsValid(self) then
        self:Blink()
    end end)

	local light = ents.Create( "env_sprite" )
	light:SetKeyValue( "model","sprites/blueflare1.spr" )
	light:SetKeyValue( "rendercolor","0 125 255" )
	light:SetPos( self:GetPos() )
	light:SetParent( self )
	light:SetKeyValue( "scale","0.25" )
	light:SetKeyValue( "rendermode","7" )
	light:Spawn()
	self:DeleteOnRemove(light)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
    if !IsValid(self.Target) && IsValid(self:GetOwner()) && IsValid(self:GetOwner():GetEnemy()) then
        self.Target = self:GetOwner():GetEnemy()
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Beam(pos, ent_filter)
    local attacker = self:GetOwner()
    if !IsValid(attacker) then attacker = self end

    if !ent_filter then ent_filter = {} end
    table.insert(ent_filter, self)

    local tr = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() + (pos - self:GetPos()):GetNormalized()*self.AttackRadius,
        mask = MASK_SHOT,
        filter = ent_filter,
    })

    util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam", self:GetPos(), tr.HitPos, false, self:EntIndex(), 0)
    util.VJ_SphereDamage(attacker, self, tr.HitPos, 8, self.BeamDamage, bit.bor(DMG_DISSOLVE, DMG_SHOCK, DMG_SONIC), true, false)
    --local hitEnts = util.VJ_SphereDamage(attacker, self, tr.HitPos, 8, self.BeamDamage, bit.bor(DMG_DISSOLVE, DMG_SHOCK, DMG_SONIC), true, false)
    -- print("BEAM HITENTS:")
    -- PrintTable(hitEnts)
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
local beam_amount = 10

function ENT:Explode()
    if self.ExplodeTime > 0 then
        if IsValid(self.Target) then
            self:GetPhysicsObject():SetVelocity( (self.Target:GetPos() - self:GetPos()):GetNormalized()*300 + Vector(0,0,300) )
        else
            self:GetPhysicsObject():SetVelocity( Vector(0,0,400) )
        end

        self:EmitSound("weapons/tripwire/deploy.wav",80,math.random(90, 110), 0.75)
    end

	timer.Simple(self.ExplodeTime, function() if IsValid(self) then
        local expLight = ents.Create("light_dynamic")
        expLight:SetKeyValue("brightness", "4")
        expLight:SetKeyValue("distance", "400")
        expLight:Fire("Color", "0 75 255")
        expLight:SetPos(self:GetPos())
        expLight:Spawn()
        expLight:Fire("TurnOn", "", 0)
        timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)

		local attacker = self:GetOwner()
		if !IsValid(attacker) then attacker = self end

        ParticleEffect("grenade_explosion_01", self:GetPos(), Angle(0,0,0), nil)
        ParticleEffect( "Weapon_Combine_Ion_Cannon_Explosion_f", self:GetPos(), self:GetAngles() )
        effects.BeamRingPoint( self:GetPos(), 0.2, 0, self.AttackRadius, 12, 12, Color(0,75,255) )

        util.ScreenShake(self:GetPos(), 6, 200, 0.66, self.AttackRadius*2)
        --util.VJ_SphereDamage(attacker, self, self:GetPos(), self.AttackRadius*0.5, self.BeamDamage, bit.bor(DMG_DISSOLVE, DMG_SHOCK, DMG_BLAST), true, false)

        local struck_ents = {}
        for _,ent in pairs(ents.FindInSphere(self:GetPos(), self.AttackRadius)) do
            if beams_done == beam_amount then break end

            if (ent:IsNPC() or ent:IsPlayer()) && !self:IsAlly(ent) then
                self:Beam(ent:GetPos()+ent:OBBCenter(), struck_ents)
                table.insert(struck_ents, ent)
                --print("struck", ent)
            end
        end

        for i = 1,beam_amount - #struck_ents do
            self:Beam(self:GetPos()+VectorRand()*self.AttackRadius, struck_ents)
            --print("random beam")
        end

        self:EmitSound("weapons/stunstick/alyx_stunner1.wav",90,math.random(70, 80), 0.85)
        self:EmitSound(table.Random({"weapons/mortar/mortar_explode1.wav","weapons/mortar/mortar_explode2.wav","weapons/mortar/mortar_explode3.wav"}),90,math.random(105, 110), 0.85)

		self:Remove()
	end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:EnableDrag(false)
	phys:SetMass(0.1)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------