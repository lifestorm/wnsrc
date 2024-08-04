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
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
ENT.Model = {"models/vj_mortarsynth_z.mdl"}
ENT.StartHealth = 80
ENT.SightDistance = 10000
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.BloodColor = "Yellow"

ENT.AA_MoveAccelerate = 8 -- The NPC will gradually speed up to the max movement speed as it moves towards its destination | Calculation = FrameTime * x
ENT.AA_MoveDecelerate = 8 -- The NPC will slow down as it approaches its destination | Calculation = MaxSpeed / x
ENT.Aerial_FlyingSpeed_Calm = 150 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking compared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 300 -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running compared to ground SNPCs
ENT.AA_GroundLimit = 150 -- If the NPC's distance from itself to the ground is less than this, it will attempt to move up

ENT.HasItemDropsOnDeath = true
ENT.ItemDropsOnDeathChance = 2
ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
}

ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true
ENT.RangeDistance = 1500
ENT.TimeUntilRangeAttackProjectileRelease = 1
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.RangeToMeleeDistance = 0
ENT.DisableDefaultRangeAttackCode = true
ENT.NextRangeAttackTime = 1

ENT.ConstantlyFaceEnemy = true
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Both" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = ENT.MortarMaxDist -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = true

ENT.CanFlinch = 1
ENT.FlinchChance = 1
ENT.NextFlinchTime = 3
ENT.AnimTbl_Flinch = {"mortar_flinch_left","mortar_flinch_right"}
ENT.FlinchAnimationDecreaseLengthAmount = 1

ENT.VJC_Data = {
	CameraMode = 1,
	ThirdP_Offset = Vector(0, 0, 0),
	FirstP_Bone = "Eye Bone Base",
	FirstP_Offset = Vector(20, 0, 10),
	FirstP_ShrinkBone = false,
}

ENT.SoundTbl_Breath = {"npc/scanner/combat_scan_loop6.wav"}
ENT.BreathSoundLevel = 80
ENT.BreathSoundPitch = VJ_Set(80, 90)

/*ENT.IdleSoundLevel = 80
ENT.AlertSoundLevel = 80
ENT.CombatIdleSoundLevel = 80
ENT.PainSoundLevel = 80

ENT.IdleSoundPitch = VJ_Set(170, 190)
ENT.CombatIdleSoundPitch = VJ_Set(170, 190)
ENT.AlertSoundPitch = VJ_Set(170, 190)
ENT.PainSoundPitch1 = 170
ENT.PainSoundPitch2 = 190*/

ENT.MortarMinDist = 400
ENT.MortarMaxDist = 6000
ENT.NextMortarTime = 0

function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("NOTE: Controlling is not really supported for this SNPC!!")

end

function ENT:CustomOnInitialize()

	self:SetCollisionBounds(Vector(-35, -35, -15), Vector(35, 35, 15))
	timer.Simple(0.01,function() if IsValid(self) then self:SetPos(self:GetPos() + Vector(0,0,50)) end end)
	--self:SetBloodColor(BLOOD_COLOR_MECH)

end

function ENT:RemoveExpLight(TheLight)

	timer.Simple(0.1,function() if IsValid(TheLight) then TheLight:Remove() end end)

end

function ENT:MortarPathObstructed(ShootHeightRatio)
	local Dist = self:GetEnemy():GetPos():Distance(self:GetPos())

	local tr = util.TraceLine({
	start = self:GetPos(),
	endpos = ((self:GetPos() + self:GetEnemy():GetPos()) * 0.5) + Vector(0,0,10000),
	mask = MASK_NPCWORLDSTATIC,
	})
	local ShootDist = math.Clamp(Dist / 4,250,2000)
	local MortarUpDist2 = math.Clamp((tr.HitPos.z - self:GetPos().z) * ShootHeightRatio,250,ShootDist)

	local tr = util.TraceLine({
	start = self:GetPos(),
	endpos = ((self:GetPos() + self:GetEnemy():GetPos()) * 0.5) + Vector(0,0,MortarUpDist2),
	mask = MASK_NPCWORLDSTATIC,
	})
	if tr.HitWorld then return true end

	local tr = util.TraceLine({
	start = ((self:GetPos() + self:GetEnemy():GetPos()) * 0.5) + Vector(0,0,MortarUpDist2),
	endpos = self:GetEnemy():GetPos(),
	mask = MASK_NPCWORLDSTATIC,
	})
	if tr.HitWorld then return true end
end

function ENT:CustomOnThink_AIEnabled()

	if IsValid(self:GetEnemy()) && !self:Visible(self:GetEnemy()) && !self.VJ_IsBeingControlled then

		if self.MovementType == VJ_MOVETYPE_AERIAL then
			self.MovementType = VJ_MOVETYPE_STATIONARY
		end

		local cur_vel = self:GetVelocity()

		self:SetVelocity( -cur_vel*0.5 )

	elseif self.MovementType == VJ_MOVETYPE_STATIONARY then

		self.MovementType = VJ_MOVETYPE_AERIAL

	end


	if self.Flinching or self.RangeAttacking then
		self.MortarAllowed = false
	else
		self.MortarAllowed = true
	end
	if self.NextMortarTime != 0 then
		self.NextMortarTime = self.NextMortarTime - 1
	end

	if IsValid(self:GetEnemy()) then

		local tr = util.TraceLine({
		start = self:GetEnemy():GetPos(),
		endpos = self:GetEnemy():GetPos() + Vector(0,0,10000),
		mask = MASK_NPCWORLDSTATIC,
		})
		local EnemyUpDist = math.abs(tr.HitPos.z - self:GetEnemy():GetPos().z)
		local ShootHeightRatio = math.Clamp(EnemyUpDist / 6000,0.01,0.33)

		local tr1 = util.TraceLine({
		start = self:GetPos(),
		endpos = ((self:GetPos() + self:GetEnemy():GetPos()) * 0.5) + Vector(0,0,10000),
		mask = MASK_NPCWORLDSTATIC,
		})
		local MortarUpDist1 = math.abs((tr1.HitPos.z - self:GetPos().z) * 0.75)
		local MinShootHeight = 100
		local Dist = self:GetEnemy():GetPos():Distance(self:GetPos())

		local enemypos2D = Vector( self:GetEnemy():GetPos().x , self:GetEnemy():GetPos().y , 0 )
		local selfpos2D = Vector( self:GetPos().x , self:GetPos().y , 0 )
		local Dist2D = enemypos2D:Distance(selfpos2D)

		if MortarUpDist1 < MinShootHeight then

			self.NoChaseAfterCertainRange_FarDistance = 400
			self.NoChaseAfterCertainRange_CloseDistance = 0
			self.PreventRangeAttack = false

		elseif !self:MortarPathObstructed(ShootHeightRatio) && self.NextMortarTime == 0 && !self.RangeAttacking && !self.Flinching && Dist2D < self.MortarMaxDist && Dist2D > self.MortarMinDist && MortarUpDist1 > MinShootHeight && !self.StillRangeAttacking && !self.VJ_IsBeingControlled then
			
			self.PreventRangeAttack = true
			self.MortarAttacking = true
			self.HasRangeAttack = false
			self.NextMortarTime = math.random(60,60)
			self:VJ_ACT_PLAYACTIVITY("mortar_shoot",true,1,true)
			timer.Simple(2,function() if IsValid(self) then
				self.HasRangeAttack = true
				self.PreventRangeAttack = false
				self.MortarAttacking = false
			end end)

			timer.Simple(0.8,function() if IsValid(self) && IsValid(self:GetEnemy()) && self.MortarAllowed then

				local alien_projectile = GetConVar("vj_zippycombines_mortarsynth_firealienprojectile"):GetInt() == 1
				local ShootPos = self:GetPos() + self:GetForward() * -10 + self:GetUp() * 25
	
				self:EmitSound( "weapons/mortar/mortar_fire1.wav", 100, math.random(110, 130), 1, CHAN_AUTO )

				if alien_projectile then
					ParticleEffect( "hunter_muzzle_flash",ShootPos, self:GetAngles() )

					local expLight = ents.Create("light_dynamic")
					expLight:SetKeyValue("brightness", "4")
					expLight:SetKeyValue("distance", "200")
					expLight:Fire("Color", "0 75 255")
					expLight:SetPos(ShootPos)
					expLight:Spawn()
					expLight:Activate()
					expLight:Fire("TurnOn", "", 0)
					self:RemoveExpLight(expLight)
				end
				local Mortar = ents.Create("obj_vj_mortar_z")
				
				if alien_projectile then
					Mortar.alien_projectile = true
				end

				local tr2 = util.TraceLine({
				start = self:GetPos(),
				endpos = ((self:GetPos() + self:GetEnemy():GetPos()) * 0.5) + Vector(0,0,10000),
				mask = MASK_NPCWORLDSTATIC,
				})
				local ShootDist = math.Clamp(Dist / 4,250,2000)
				local MortarUpDist2 = math.Clamp((tr2.HitPos.z - self:GetPos().z) * ShootHeightRatio,250,ShootDist)
				Mortar:SetOwner(self)
				Mortar:SetPos(ShootPos)



				Mortar:Spawn()
				Mortar:GetPhysicsObject():SetVelocity(((self:GetEnemy():GetPos()) - self:GetPos()) / (MortarUpDist2 * 0.0033) + Vector(0,0,MortarUpDist2))

			end end)
			self.NoChaseAfterCertainRange_FarDistance = 600
			self.NoChaseAfterCertainRange_CloseDistance = 0
		
		else

			self.PreventRangeAttack = false

		end
	end

end

function ENT:CustomAttackCheck_RangeAttack()

	if self.PreventRangeAttack then
		return false
	end
	return true

end

function ENT:CustomOnRangeAttack_AfterStartTimer(seed)

	timer.Create("MortarSynthPreRangeAttack" .. self:EntIndex(), 0.2, 3, function() if IsValid(self) then
		ParticleEffectAttach("st_elmos_fire_cp0", PATTACH_POINT_FOLLOW, self, 1)
		ParticleEffectAttach("st_elmos_fire_cp0", PATTACH_POINT_FOLLOW, self, 2)
	end end)

	local powerupsound = CreateSound(self,"npc/vort/health_charge.wav")
	powerupsound:SetSoundLevel(110)
	powerupsound:Play()
	powerupsound:ChangePitch(200, self.TimeUntilRangeAttackProjectileRelease)

	local Light = ents.Create("light_dynamic")
	Light:SetKeyValue("brightness", "3")
	Light:SetKeyValue("distance", "250")
	Light:Fire("Color", "0 75 255")
	Light:SetParent(self)
	Light:SetPos(self:GetPos())
	Light:Spawn()
	Light:Activate()
	Light:Fire("TurnOn", "", 0)
	timer.Simple(self.TimeUntilRangeAttackProjectileRelease,function() if IsValid(Light) then Light:Remove() end end)
	self:DeleteOnRemove(Light)

	self.StillRangeAttacking = true

	timer.Simple(self.TimeUntilRangeAttackProjectileRelease,function() if IsValid(self) then

		powerupsound:Stop()
		powerupsound = nil
		self:StopParticles()

	end end)

	timer.Simple(self.TimeUntilRangeAttackProjectileRelease + 0.8,function() if IsValid(self) then
		self.StillRangeAttacking = false
	end end)

end

function ENT:CustomRangeAttackCode()

	local enemy = self:GetEnemy()

	if IsValid(enemy) then

		local expLight = ents.Create("light_dynamic")
		expLight:SetKeyValue("brightness", "6")
		expLight:SetKeyValue("distance", "500")
		expLight:Fire("Color", "0 75 255")
		expLight:SetPos(self:GetPos())
		expLight:Spawn()
		expLight:Activate()
		expLight:Fire("TurnOn", "", 0)
		timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
		self:DeleteOnRemove(expLight)
	
		local source = self:GetPos()
		local tr = util.TraceLine({
			start = source,
			endpos = source + (enemy:WorldSpaceCenter() - (source+VectorRand(-30,30))):GetNormalized()*10000,
			mask = MASK_SHOT,
			filter = self,
		})
		local MortarStunPos = tr.HitPos

		local expLight2 = ents.Create("light_dynamic")
		expLight2:SetKeyValue("brightness", "6")
		expLight2:SetKeyValue("distance", "500")
		expLight2:Fire("Color", "0 75 255")
		expLight2:SetPos(MortarStunPos)
		expLight2:Spawn()
		expLight2:Activate()
		expLight2:Fire("TurnOn", "", 0)
		timer.Simple(0.1,function() if IsValid(expLight2) then expLight2:Remove() end end)
		self:DeleteOnRemove(expLight2)

		ParticleEffect( "hunter_projectile_explosion_2k", MortarStunPos, self:GetAngles() )

		self:VJ_ACT_PLAYACTIVITY("mortar_flinch_front",true,0.5,true)
		self:EmitSound( "npc/scanner/scanner_electric2.wav", 110, math.random(120,130), 1, CHAN_AUTO )

		util.ParticleTracerEx("electrical_arc_01",self:GetPos(),MortarStunPos,false,self:EntIndex(),1)
		util.ParticleTracerEx("electrical_arc_01",self:GetPos(),MortarStunPos,false,self:EntIndex(),2)
		util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Black",self:GetPos(),MortarStunPos,false,self:EntIndex(),3)
		ParticleEffectAttach("st_elmos_fire_cp0",PATTACH_POINT_FOLLOW,self,1)
		ParticleEffectAttach("st_elmos_fire_cp0",PATTACH_POINT_FOLLOW,self,2)
		ParticleEffectAttach("st_elmos_fire_cp0",PATTACH_POINT_FOLLOW,self,3)

		self.Spark1 = ents.Create("env_spark")
		self.Spark1:SetKeyValue("Magnitude","3")
		self.Spark1:SetKeyValue("Spark Trail Length","3")
		self.Spark1:SetPos(MortarStunPos)
		self.Spark1:SetAngles(self:GetAngles())
		self.Spark1:SetParent(self)
		self.Spark1:Spawn()
		self.Spark1:Activate()
		self.Spark1:Fire("StartSpark", "", 0)
		self.Spark1:Fire("StopSpark", "", 0.001)
		self:DeleteOnRemove(self.Spark1)

		util.VJ_SphereDamage(self,self,MortarStunPos,100,10, bit.bor(DMG_NEVERGIB,DMG_DISSOLVE,DMG_SHOCK) ,true,true,false,false)

	end

end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	if dmginfo:IsBulletDamage() then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)

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

function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)

	if dmginfo:GetDamage() < 20 then
		return false
	end

end

ENT.CrashChance = 1

function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect( "Explosion", effectdata )

	if math.random(1, self.CrashChance) == 1 then -- Crash

		local targetpos = self:GetPos() + self:GetForward() * 100 - Vector(0,0,100)
		if IsValid(self:GetEnemy()) then
			targetpos = self:GetEnemy():GetPos()
		end

		local crashdir = targetpos - self:GetPos()

		local CrashingScannerProp = ents.Create("base_gmodentity")
		CrashingScannerProp:SetModel(self:GetModel())
		CrashingScannerProp:SetPos(self:GetPos())
		CrashingScannerProp:SetAngles(crashdir:Angle())
		CrashingScannerProp:Spawn()
		CrashingScannerProp:SetMoveType(MOVETYPE_FLY)
		CrashingScannerProp:SetSolid(SOLID_VPHYSICS)
		CrashingScannerProp.VJ_NPC_Class = self.VJ_NPC_Class
		if file.Exists("autorun/server/sv_entdamageoverlay.lua", "LUA") then
			self:CopyEntDamageOverlays(CrashingScannerProp)
		end

		CrashingScannerProp.Explode = function()
			util.VJ_SphereDamage(Entity(0),Entity(0),CrashingScannerProp:GetPos(),300,40,DMG_BLAST,true,true,false,false)
			ParticleEffect("grenade_explosion_01", CrashingScannerProp:GetPos(), Angle(0,0,0), nil)
			ParticleEffect("Explosion_2_Chunks", CrashingScannerProp:GetPos(), Angle(0,0,0), nil)
			local effectdata = EffectData()
			effectdata:SetOrigin(CrashingScannerProp:GetPos())
			util.Effect( "Explosion", effectdata )
			CrashingScannerProp:EmitSound( "Explo.ww2bomb", 130, 100)
			CrashingScannerProp:Remove()
		end

		CrashingScannerProp.Think = function()
			CrashingScannerProp:SetVelocity(crashdir:GetNormalized() * 30)
			CrashingScannerProp:SetAngles(CrashingScannerProp:GetAngles() + Angle(0,0,3))
			CrashingScannerProp:NextThink(CurTime())
			local tr = util.TraceLine({
				start = CrashingScannerProp:GetPos(),
				endpos = CrashingScannerProp:GetPos() + crashdir:GetNormalized() * 3000,
				filter = self
			})

			sound.EmitHint(SOUND_DANGER, tr.HitPos, 300, 0.5)
			return true
		end

		CrashingScannerProp.StartTouch = function()
			CrashingScannerProp:Explode()
		end

		timer.Simple(2, function() if IsValid(CrashingScannerProp) then CrashingScannerProp:Explode() end end)
	
	else
	
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib4.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib5.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib2.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib1.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib6.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
	
	end

end

function ENT:CustomOnRemove()

	self:EmitSound( "NPC_Vortigaunt.ZapPowerup", 100, 150, 1, CHAN_AUTO, SND_STOP )

end
/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/