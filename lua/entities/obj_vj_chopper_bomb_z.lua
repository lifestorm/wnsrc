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
ENT.PrintName		= "Helicopter Bomb"
ENT.Author 			= "Zippy"
ENT.Spawnable = false

ENT.Model = {"models/combine_helicopter/helicopter_bomb01.mdl"}
ENT.RemoveOnHit = false -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.

ENT.DoesRadiusDamage = true
ENT.RadiusDamageRadius = 400
ENT.RadiusDamage = 75
ENT.RadiusDamageForce = 150

ENT.ExplodeTime = 4
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	sound.EmitHint(SOUND_DANGER,self:GetPos(),self.RadiusDamageRadius,self.ExplodeTime,self)

	timer.Simple(self.ExplodeTime, function() if IsValid(self) then self:Explode() end end)

    self.SoundLoop = CreateSound(self, "npc/attack_helicopter/aheli_mine_seek_loop1.wav")
    self.SoundLoop:SetSoundLevel(90)
	self.SoundLoop:Play()
    self.SoundLoop:ChangePitch(200,self.ExplodeTime)

	self.NextBlink = CurTime()
	self.StartTime = CurTime()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Blink()
	for i = 1,2 do
		local light = ents.Create( "env_sprite" )
		light:SetKeyValue( "model","sprites/blueflare1.spr" )
		light:SetKeyValue( "rendercolor","255 15 0" )
		light:SetPos( self:GetAttachment(i).Pos )
		light:SetParent( self,i )
		light:SetKeyValue( "scale","0.33" )
		light:SetKeyValue( "rendermode","7" )
		light:Spawn()
		self:DeleteOnRemove(light)

		local expLight = ents.Create("light_dynamic")
		expLight:SetKeyValue("brightness", "1")
		expLight:SetKeyValue("distance", "125")
		expLight:Fire("Color", "255 15 0")
		expLight:SetPos(self:GetAttachment(i).Pos)
		expLight:Spawn()
		expLight:Fire("TurnOn", "", 0)
		expLight:SetParent(self,i)

		timer.Simple(0.2,function() if IsValid(expLight) then expLight:Remove()  end end)
		timer.Simple(0.1,function() if IsValid(light) then light:Remove()  end end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:EnableDrag(false)
	phys:SetMass(0.1)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Explode()
	self:DeathEffects()
	self:Remove()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local lifetime = CurTime() - self.StartTime
	if self.NextBlink < CurTime() then
		self:Blink()
		self.NextBlink = CurTime() + (self.ExplodeTime - lifetime)/self.ExplodeTime*0.5
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects()
	ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0), nil)

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )

	self:EmitSound( "Explo.ww2bomb", 130, 100)

	local attacker = self:GetOwner()
	if !IsValid(attacker) then attacker = self end

	util.VJ_SphereDamage(attacker, self, self:GetPos(), self.RadiusDamageRadius, self.RadiusDamage, DMG_BLAST, true, true)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.SoundLoop:Stop()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------