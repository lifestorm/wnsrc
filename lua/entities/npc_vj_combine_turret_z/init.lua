--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include("shared.lua")
/*--------------------------------------------------
	=============== Creature SNPC Base ===============
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
	INFO: Used as a base for creature SNPCs.
--------------------------------------------------*/

ENT.Model = {"models/Combine_turrets/Floor_turret.mdl"}
ENT.StartHealth = 90
ENT.SightAngle = 70
ENT.SightDistance = 3000
ENT.PoseParameterLooking_TurningSpeed = 30
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.HasMeleeAttack = false
ENT.DisableTakeDamageFindEnemy = true
ENT.Medic_CanBeHealed = false
ENT.LastSeenEnemyTimeUntilReset = 0

ENT.CallForHelp = false

ENT.HasItemDropsOnDeath = false
ENT.ItemDropsOnDeathChance = 2
ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
}

ENT.HasRangeAttack = true
ENT.RangeAttackAngleRadius = ENT.SightAngle
ENT.DisableRangeAttackAnimation = true
ENT.DisableDefaultRangeAttackCode = true
ENT.RangeDistance = ENT.SightDistance
ENT.RangeToMeleeDistance = 0
ENT.TimeUntilRangeAttackProjectileRelease = 0
ENT.NextRangeAttackTime = 0.05

ENT.SoundTbl_Breath = {"NPC_FloorTurret.Move",}
ENT.SoundTbl_Idle = {"NPC_FloorTurret.Ping"}
ENT.SoundTbl_LostEnemy = {"NPC_FloorTurret.Retract"}
ENT.SoundTbl_Alert = {"NPC_FloorTurret.Deploy"}
ENT.SoundTbl_Death = {"NPC_FloorTurret.Die"}
ENT.SoundTbl_RangeAttack = {"NPC_FloorTurret.Shoot"}

ENT.NextSoundTime_LostEnemy = VJ_Set(0, 0)
ENT.NextSoundTime_Alert = VJ_Set(0, 0)
ENT.NextSoundTime_Idle = VJ_Set(2, 5.5)
ENT.IdleSoundChance = 1
ENT.IdleSounds_NoRegularIdleOnAlerted = true

ENT.LostEnemySoundLevel = 90
ENT.AlertSoundLevel = 90

--ENT.GibOnDeathDamagesTable = {"All"}
ENT.HasGibOnDeathSounds = false

function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("NOTE: Controlling is not really supported for this SNPC!!")

end

function ENT:CustomOnInitialize()

	self.TurretLight = ents.Create( "env_sprite" )
	self.TurretLight:SetKeyValue( "model","sprites/blueflare1.spr" )
	self.TurretLight:SetKeyValue( "rendercolor","50 255 0" )
	self.TurretLight:SetPos( self:GetPos() )
	self.TurretLight:SetMoveType( MOVETYPE_NONE )
	self.TurretLight:SetParent( self )
	self.TurretLight:Fire( "SetParentAttachment", "light" )
	self.TurretLight:SetKeyValue( "scale","0.2" )
	self.TurretLight:SetKeyValue( "rendermode","9" )
	self.TurretLight:Spawn()
	self:DeleteOnRemove(self.TurretLight)

	self.AllowFiring = false
	self.HasPlayedActivateSound = false
	self.TurretDamaged = false

	--self:SetBloodColor(BLOOD_COLOR_MECH)

end

function ENT:CustomOnThink()

	self.NextFlinchTime = math.random(3,6)

	if self:Health() <= self.StartHealth * 0.5 then
		if self.TurretDamaged == false then
			ParticleEffect("smoke_gib_01", self:GetPos() + self:OBBCenter(), self:GetAngles(), self)
			self.Spark1 = ents.Create("env_spark")
			self.Spark1:SetKeyValue("MaxDelay","1")
			self.Spark1:SetKeyValue("Magnitude","1")
			self.Spark1:SetKeyValue("Spark Trail Length","1")
			self.Spark1:SetAngles(self:GetAngles())
			self.Spark1:SetParent(self)
			self:DeleteOnRemove(self.Spark1)
			self.Spark1:Spawn()
			self.Spark1:Activate()
			self.Spark1:Fire("StartSpark", "", 0)
			self.TurretDamaged = true
		end
		self.Spark1:SetPos(self:GetPos() + self:OBBCenter() + self:GetUp() * math.random(-20,20) + self:GetRight() * math.random(-10,10) + self:GetForward() * math.random(-10,10))
	elseif self.TurretDamaged then
		self:StopParticles()
		self.Spark1:Remove()
		self.TurretDamaged = false
	end

end

function ENT:CustomOnThink_AIEnabled()

	if self.Alerted then
		self.TurretLight:SetKeyValue( "rendercolor","255 50 0" )
		self:SetSequence("idlealert")
		if self.HasPlayedActivateSound == false then
			VJ_EmitSound(self,"NPC_FloorTurret.Activate",100,100)
			self.HasPlayedActivateSound = true
		end
		if self.AllowFiring == false then
			timer.Simple(0.75,function() if self:IsValid() then self.AllowFiring = true end end)
		end
	else
		self.TurretLight:SetKeyValue( "rendercolor","50 255 0" )
		self.AllowFiring = false
		self.HasPlayedActivateSound = false
	end

end

function ENT:CustomAttackCheck_RangeAttack()

	if self.AllowFiring then
		return true
	else
		return false
	end

end

-- function ENT:CustomOnCallForHelp(ally)

-- 	self:EmitSound( "NPC_FloorTurret.Alarm", 110, 100, 1, CHAN_AUTO, SND_NOFLAGS)
-- 	timer.Simple(1.5,function() if self:IsValid() then self:EmitSound( "NPC_FloorTurret.Alarm", 110, 100, 1, CHAN_AUTO, SND_STOP) end end)

-- end

function ENT:CustomRangeAttackCode()

	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "3")
	expLight:SetKeyValue("distance", "150")
	expLight:Fire("Color", "0 25 255")
	expLight:SetPos(self:GetPos() + self:GetUp() * 50)
	expLight:Spawn()
	expLight:Activate()
	expLight:SetParent(self,1)
	expLight:Fire("TurnOn", "", 0)
	timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
	self:DeleteOnRemove(expLight)

	ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self,1)

	VJ_EmitSound(self,"NPC_FloorTurret.Shoot",100,100)

	local bullet = {
	Src = self:GetAttachment(1).Pos,
	Dir = self:GetEnemy():GetPos() + self:GetUp() * 10 + self:GetEnemy():OBBCenter() - self:GetAttachment(1).Pos,
	Spread = Vector(175 / (self.RangeDistance / self:GetEnemy():GetPos():Distance(self:GetPos())),175 / (self.RangeDistance / self:GetEnemy():GetPos():Distance(self:GetPos())),0),
	Damage = 4,
	TracerName = "AR2Tracer",
	-- Callback = function(attacker, tracer)
	-- 	local effectdata = EffectData()
	-- 	effectdata:SetOrigin(tracer.HitPos)
	-- 	effectdata:SetNormal(tracer.HitNormal)
	-- 	effectdata:SetRadius( 5 )
	-- 	util.Effect( "cball_bounce", effectdata )
	-- end,
	}

	self:FireBullets(bullet)

end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	if !dmginfo:IsExplosionDamage() or dmginfo:GetDamageType() == DMG_CRUSH then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.33 )

        if math.random(1, 3) == 1 then
			self:EmitSound("weapons/fx/rics/ric1.wav", 82, math.random(85, 115))
			
			local spark = ents.Create("env_spark")
			spark:SetPos(dmginfo:GetDamagePosition())
			spark:Spawn()
			spark:Fire("StartSpark", "", 0)
			spark:Fire("StopSpark", "", 0.001)
			self:DeleteOnRemove(spark)
		end
	end

end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)

	ParticleEffectAttach("explosion_turret_break_pre_smoke",PATTACH_POINT_FOLLOW,corpseEnt,2)
	ParticleEffect("explosion_turret_break_sparks",self:GetPos() + self:OBBCenter(),corpseEnt:GetAngles())
	ParticleEffect("explosion_turret_break_fire",self:GetPos() + self:OBBCenter(),corpseEnt:GetAngles())

end

function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)

	self.HasItemDropsOnDeath = true

	ParticleEffect("explosion_turret_break",self:GetPos(),self:GetAngles())
	VJ_EmitSound(self,"NPC_FloorTurret.Destruct",100,100)

	self:CreateGibEntity("obj_vj_gib","models/combine_turrets/floor_turret_gib1.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,30)), CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/combine_turrets/floor_turret_gib2.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,30)), CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/combine_turrets/floor_turret_gib3.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,30)), CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/combine_turrets/floor_turret_gib4.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,30)), CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/combine_turrets/floor_turret_gib5.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,30)), CollideSound = {"SolidMetal.ImpactSoft"}})
	return true

end

/*--------------------------------------------------
	=============== Creature SNPC Base ===============
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
	INFO: Used as a base for creature SNPCs.
--------------------------------------------------*/