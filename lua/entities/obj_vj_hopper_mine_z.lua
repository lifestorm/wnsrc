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
ENT.PrintName		= "Hopper Mine"
ENT.Author 			= "Zippy"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= ""
ENT.Category		= "VJ Base"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Model = {"models/props_combine/combine_mine01.mdl"}
ENT.SolidType = SOLID_VPHYSICS
ENT.RemoveOnHit = false

ENT.NextFixTime = 5
ENT.TimeUntilAttack = 5
ENT.CheckingForEnemies = true

ENT.DoesRadiusDamage = true
ENT.RadiusDamageRadius = 375
ENT.RadiusDamage = 0
ENT.RadiusDamageForce = 150

ENT.VJ_NPC_Class = {"CLASS_COMBINE"}

ENT.DecalTbl_OnCollideDecals = {"Scorch"}

ENT.HopperHealth = 130

function ENT:IsAlly(ent)

	if GetConVar("ai_disabled"):GetInt() == 1 then return true end
	if ent:GetClass() == "obj_vj_bullseye" then return true end -- workaround to fix hopper mines attacking vj controller bullseye

    if !ent.VJ_NPC_Class then return false end

    for _,npcclass in pairs(ent.VJ_NPC_Class) do
        for _,mynpcclass in pairs(self.VJ_NPC_Class) do
            if npcclass == mynpcclass then
                return true
            end
        end
    end

end

function ENT:CustomOnInitialize()

	self:SetPoseParameter( "blendstates", 65 )
	self.Light = ents.Create( "env_sprite" )
	self.Light:SetKeyValue( "model","sprites/blueflare1.spr" )
	self.Light:SetKeyValue( "rendercolor","0 50 255" )
	self.Light:SetPos( self:GetPos() + self:GetUp() * 12 )
	self.Light:SetMoveType( MOVETYPE_NONE )
	self.Light:SetParent( self )
	self.Light:SetKeyValue( "scale","0.3" )
	self.Light:SetKeyValue( "rendermode","9" )
	self.Light:Spawn()
	self:DeleteOnRemove(self.Light)

end

function ENT:CustomPhysicsObjectOnInitialize(phys)

	phys:Wake()
	phys:EnableGravity(true)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
	phys:SetMass(300)
	phys:SetDamping(phys:GetDamping(), 4)

end

function ENT:CanDeploy()
	local tr2 = util.TraceLine({
	start = self:GetPos(),
	endpos = self:GetPos() + self:GetUp() * -10,
	filter = self,
	mask = MASK_NPCWORLDSTATIC
	})

	if tr2.Hit then return true end
end

function ENT:CustomOnThink()

	if self.Destroyed then
		return
	end

	if self.IsDeployed && !self.Alerted && !self.AttackConfirmed then
		self.Light:SetKeyValue( "rendercolor","50 255 0" )
	elseif self.Alerted or self.AttackConfirmed then
		self.Light:SetKeyValue( "rendercolor","255 50 0" )
	else
		self.Light:SetKeyValue( "rendercolor","0 50 255" )
	end

	local vel = self:GetPhysicsObject():GetVelocity()
	local velX = math.floor(math.abs(vel.x))
	local velY = math.floor(math.abs(vel.y))
	local velZ = math.floor(math.abs(vel.z))
	if self.NextFixTime != 0 && !self.IsDeployed && Vector(velX,velY,velZ) == Vector(0,0,0) then
		self.NextFixTime = self.NextFixTime - 1
	end
	if !self:CanDeploy() && self.NextFixTime == 0 && !self.IsDeployed then
		self.NextFixTime = 5
		self:GetPhysicsObject():SetVelocity(Vector(0,0,350))
		self:GetPhysicsObject():AddAngleVelocity(Vector(0,700,0))
		self:EmitSound( "NPC_CombineMine.Hop", 100, 100)
	elseif self.NextFixTime == 0 then
		self.NextFixTime = 5
	end

	if self:CanDeploy() && !self.Deploying && !self.IsDeployed then
		self.Deploying = true
		timer.Simple(1,function()
			if IsValid(self) && !self.IsDestroyed then
				if self:CanDeploy() && !self.IsDestroyed then
					self.IsDeployed = true
					self:EmitSound( "NPC_CombineMine.CloseHooks", 100, 100)
					self:SetPoseParameter( "blendstates", 0 )
					self:SetMoveType(MOVETYPE_NONE)
				elseif !self.IsDestroyed then
					self.Deploying = false
				end
			end
		end)
	end

	if self.IsDeployed then
		for _,v in pairs (ents.FindInSphere(self:GetPos(),500)) do
			self.EnemyFound = false
			local tr = util.TraceLine({
			start = self:GetPos() + self:OBBCenter(),
			endpos = v:GetPos() + v:OBBCenter(),
			mask = MASK_BLOCKLOS
			})
			if ( (v:IsPlayer() && GetConVar("ai_ignoreplayers"):GetInt() == 0) or v:IsNPC() ) && !tr.HitWorld && !self:IsAlly(v) then
				self.EnemyFound = true
				break
			end
		end
		if self.EnemyFound then
			self.Alerted = true
		else
			self.Alerted = false
		end
	end

	if self.Alerted && !self.PlayingAlertSound then
		self.PlayingAlertSound = true
		self:EmitSound( "NPC_CombineMine.TurnOn", 100, 100)
	elseif !self.Alerted && self.PlayingAlertSound then
		self.PlayingAlertSound = false
		self:EmitSound( "NPC_CombineMine.TurnOff", 100, 100)
	end

	self.EnemyTable = {}
	for k,v in pairs (self.EnemyTable) do
		if !IsValid(v) then
			table.remove(self.EnemyTable, k)
		end
	end
	for _,v in pairs (ents.FindInSphere(self:GetPos(),400)) do
		local tr = util.TraceLine({
		start = self:GetPos() + self:OBBCenter(),
		endpos = v:GetPos() + v:OBBCenter(),
		mask = MASK_BLOCKLOS
		})
		if ( (v:IsPlayer() && GetConVar("ai_ignoreplayers"):GetInt() == 0) or v:IsNPC() ) && !self:IsAlly(v) && !tr.HitWorld then
			table.insert(self.EnemyTable, v)
		end
	end
	for _,v in pairs (self.EnemyTable) do
		if v:GetPos():Distance(self:GetPos()) > 400 then
			table.remove(self.EnemyTable, k)
		end
	end

	if self.Alerted && !self.AttackConfirmed && self.TimeUntilAttack != 0 then
		self.TimeUntilAttack = self.TimeUntilAttack - 1
	end
	if self.TimeUntilAttack == 0 && !self.AttackConfirmed && IsValid(self.EnemyTable[1]) then
		self.AttackConfirmed = true
		self.RemoveOnHit = true
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:GetPhysicsObject():SetVelocity((table.Random(self.EnemyTable):GetPos() - self:GetPos()) + Vector(0,0,350))
		self:GetPhysicsObject():RotateAroundAxis( self:GetPos(), 1800 )
		self:SetPoseParameter( "blendstates", 65 )
		self:EmitSound( "NPC_CombineMine.OpenHooks", 100, 100)
		sound.EmitHint( SOUND_DANGER, self:GetPos(), self.RadiusDamageRadius, 0.5, self )
	end

end

function ENT:CustomOnTakeDamage(dmginfo)

	if self:IsAlly(dmginfo:GetInflictor()) then
		dmginfo:SetDamage(0)
		return
	end

	if dmginfo:GetDamagePosition() == Vector(0,0,0) then
		self.MineDamagePos = self:GetPos() + self:OBBCenter() + self:GetUp() * math.random(-20,20) + self:GetRight() * math.random(-10,10) + self:GetForward() * math.random(-10,10)
	else
		self.MineDamagePos = dmginfo:GetDamagePosition()
	end



	if !dmginfo:IsExplosionDamage()  then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.5 )
		if math.random(1, 4) == 1 then
			self:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 92, math.random(70, 90))
			self.Spark1 = ents.Create("env_spark")
			self.Spark1:SetPos(dmginfo:GetDamagePosition())
			self.Spark1:Spawn()
			self.Spark1:Fire("StartSpark", "", 0)
			self.Spark1:Fire("StopSpark", "", 0.001)
			self:DeleteOnRemove(self.Spark1)
		end
	end

	self.HopperHealth = self.HopperHealth - dmginfo:GetDamage()
	if self.HopperHealth <= 0 && !self.Destroyed then
		self.RemoveOnHit = false
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetPoseParameter( "blendstates", 65 )
		if IsValid(self.Light) then
			self.Light:Remove()
		end
		local Spark = ents.Create("env_spark")
		Spark:SetKeyValue("MaxDelay","1")
		Spark:SetKeyValue("Magnitude","2")
		Spark:SetKeyValue("Spark Trail Length","2")
		Spark:SetAngles(self:GetAngles())
		Spark:SetParent(self)
		Spark:SetPos(self:GetPos() + self:GetUp() * 12)
		Spark:Spawn()
		Spark:Activate()
		Spark:Fire("StartSpark", "", 0)
		Spark:Fire("StopSpark", "", 4)
		--ParticleEffectAttach("explosion_turret_break_pre_smoke",PATTACH_ABSORIGIN_FOLLOW,self,0)
		ParticleEffect("explosion_turret_break_sparks",self:GetPos() + self:OBBCenter(),self:GetAngles())
		ParticleEffect("explosion_turret_break_fire",self:GetPos() + self:OBBCenter(),self:GetAngles())
		self:EmitSound( "NPC_CeilingTurret.Die", 100, 100)
		self:EmitSound( "NPC_SScanner.Shoot", 80, 100)
		if IsValid(self:GetPhysicsObject()) then
			self:GetPhysicsObject():SetVelocity(Vector(math.random(-50,50),math.random(-50,50),150))
		end
		ZIPPYCOMBINES_FadeAndRemove(self,20)
		self.Destroyed = true
	end

end

function ENT:DeathEffects(data, phys)

	if self.Destroyed then return end

	if IsValid(self:GetOwner()) then
		self.Attacker = self:GetOwner()
	else
		self.Attacker = self
	end
	util.VJ_SphereDamage(self.Attacker,self,self:GetPos(),self.RadiusDamageRadius,60,DMG_BLAST,true,true,false,false)
	ParticleEffect("grenade_explosion_01", self:GetPos(), Angle(0,0,0), nil)
	ParticleEffect("Explosion_2_Chunks", self:GetPos(), Angle(0,0,0), nil)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )
	self:EmitSound( "Explo.ww2bomb", 130, 100)

end
/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/