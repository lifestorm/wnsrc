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

ENT.Model = {"models/gunship.mdl"}
ENT.StartHealth = 440

--ENT.CustomBlood_Particle = {"blood_impact_synth_01"}
ENT.BloodColor = "White"

ENT.HeliLights = false
ENT.Heli_CanCrash = false
ENT.Heli_CanBomb = false
ENT.CrashAlarmSound = "npc/combine_gunship/gunship_crashing1.wav"
ENT.HasRockets = false

ENT.RotorSound = "npc/combine_gunship/engine_rotor_loop1.wav"
ENT.ShootSound = "npc/combine_gunship/gunship_weapon_fire_loop6.wav"

ENT.SoundTbl_Idle = {"NPC_CombineGunship.PatrolPing"}
ENT.SoundTbl_Alert = {"NPC_CombineGunship.SeeEnemy"}
ENT.SoundTbl_CombatIdle = {"NPC_CombineGunship.SeeEnemy"}
ENT.SoundTbl_CallForHelp = {"NPC_CombineGunship.SeeEnemy"}
ENT.SoundTbl_Pain = {"NPC_CombineGunship.Pain"}
ENT.SoundTbl_Breath = {"NPC_CombineGunship.RotorBlastSound"}
ENT.SoundTbl_Investigate = {"NPC_CombineGunship.SearchPing"}
ENT.SoundTbl_LostEnemy = {"NPC_CombineGunship.SearchPing"}
ENT.SoundTbl_OnReceiveOrder = {"NPC_CombineGunship.SearchPing"}

ENT.BreathSoundLevel = 90
ENT.IdleSoundLevel = 130
ENT.CombatIdleSoundLevel = 130
ENT.OnReceiveOrderSoundLevel = 130
ENT.InvestigateSoundLevel = 130
ENT.LostEnemySoundLevel = 130
ENT.AlertSoundLevel = 130
ENT.CallForHelpSoundLevel = 130
ENT.PainSoundLevel = 130

ENT.DeathCorpseSkin = 1
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC

ENT.GibOnDeathDamagesTable = {"UseDefault"}
ENT.HasGibOnDeathSounds = true

ENT.BulletSpread = 0.03
ENT.BulletsUntilReload = 30

ENT.AimYawPoseParam = "flex_horz"
ENT.AimPitchPoseParam = "flex_vert"
ENT.FlipAimPitchPoseParam = false

ENT.MaxBCannonDistFromEnemy = 250
ENT.BCannonCooldown = 4

ENT.CanShootDownRockets = false
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomHeliInit()

	self.Bullseye = ents.Create("obj_vj_Bullseye")
	self.Bullseye:SetModel("models/hunter/plates/plate.mdl")
	self.Bullseye:SetParent(self,5)
	self.Bullseye:SetPos(self:GetAttachment(5).Pos - Vector(0,0,30))
	self.Bullseye:Spawn()
	self.Bullseye:SetNoDraw(true)
	self.Bullseye:DrawShadow(false)
	self.Bullseye:SetSolid(SOLID_NONE)
	self.Bullseye.VJ_NPC_Class = self.VJ_NPC_Class

    self.RotorBlastSoundLoop = CreateSound(self, "npc/combine_gunship/gunship_engine_loop3.wav")
    self.RotorBlastSoundLoop:SetSoundLevel(95)
    self.RotorBlastSoundLoop:Play()

    self.Antennas_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.Fins_NoiseSpeedOffset = math.Rand(0.9, 1.1)

    self.Body_vert_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.Body_horz_NoiseSpeedOffset = math.Rand(0.9, 1.1)

    self:SetCollisionBounds( Vector (185,185,95) , Vector (-185,-185,-30) )

    self.NextBCannon = CurTime()

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoGunAttack()

    local bullet_source = self:GetAttachment(1).Pos
    local fire_dir = (self.ShootPos - bullet_source):GetNormalized()

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "5")
    expLight:SetKeyValue("distance", "250")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(bullet_source)
    expLight:Spawn()
    expLight:SetParent(self,1)
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)
    ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self,1)

    self:FireBullets({
        Src = bullet_source,
        Dir = fire_dir,
		Damage = 3,
		Force = 25,
        TracerName = "AirboatGunTracer",
        Spread = Vector( self.BulletSpread,self.BulletSpread,self.BulletSpread ),
        Num = 1,
		Callback = function(attacker, tracer)
            if math.random(1, 2) == 1 then
                local effectdata = EffectData()
                effectdata:SetOrigin(tracer.HitPos)
                effectdata:SetNormal(tracer.HitNormal)
                effectdata:SetRadius( 10 )
			    util.Effect( "cball_bounce", effectdata )
            end
            effects.BeamRingPoint( tracer.HitPos, 0.2, 0, 70, 12, 12, Color(255,255,175) )
			util.VJ_SphereDamage(self,self,tracer.HitPos,20,3,DMG_SONIC,true,false,false,false)
		end,
    })

    if IsValid(self.EnemyRocket) && self.ShootPos:Distance(self.EnemyRocket:GetPos()) < 50 then
        local destroyed_rocket = ents.Create("obj_vj_destroyed_rocket_z")
        destroyed_rocket:SetPos(self.EnemyRocket:GetPos())
        destroyed_rocket:SetModel(self.EnemyRocket:GetModel())
        destroyed_rocket:Spawn()
    
        self.EnemyRocket:Fire("KillHierarchy")
    end

    self.BulletsFired = self.BulletsFired + 1

    if self.BulletsFired >= self.BulletsUntilReload then

        self:UnchargeGun()

        self.GunHasCooledDown = false
        timer.Simple(self.GunCooldownTime, function() if IsValid(self) then self.GunHasCooledDown = true end end)

        if self.Diving then self.Diving = false end
        self:ConsiderDive()

    end

    self.GunFiring = true

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AnimationThink()

    local sin = math.sin
    local time = CurTime()


    local noise_speed_mult = 2
    self.body_vert_noise = 13 + sin(time*self.Body_vert_NoiseSpeedOffset*noise_speed_mult)*13
    self.body_horz_noise = sin(time*self.Body_horz_NoiseSpeedOffset*noise_speed_mult)*5


    local fin_noise = 0.33 + sin(time*self.Fins_NoiseSpeedOffset*noise_speed_mult)*0.33
    local antenna_noise = 0.5 + sin(time*self.Antennas_NoiseSpeedOffset*noise_speed_mult)*0.5

    self:SetPoseParameter("fin_accel",fin_noise)
    self:SetPoseParameter("antenna_accel",antenna_noise)

    self:AddLayeredSequence(self:LookupSequence("prop_turn"),2)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:EnemyInBCannonDist()

    local tr = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() - Vector(0,0,10000),
        mask = MASK_NPCWORLDSTATIC,
    })

    local BombSpot = tr.HitPos

    if self:GetEnemy():GetPos():Distance(BombSpot) < self.MaxBCannonDistFromEnemy then
        return true
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoBCannon()
    if self.DoingBCannon or self.NextBCannon > CurTime() then return end
    self.DoingBCannon = true
    self:SetNWBool("VJGunshipZDoingBCannon", true)

    local time_until_fire = 1.15

    local chargeLight = ents.Create("light_dynamic")
    chargeLight:SetKeyValue("brightness", "5")
    chargeLight:SetKeyValue("distance", "400")
    chargeLight:Fire("Color", "0 75 255")
    chargeLight:SetPos(self:GetAttachment(4).Pos)
    chargeLight:Spawn()
    chargeLight:SetParent(self,4)
    chargeLight:Fire("TurnOn", "", 0)
    self:DeleteOnRemove(chargeLight)

    self:EmitSound( "NPC_Strider.Charge", 120, 100)


    timer.Simple(time_until_fire, function() if IsValid(self) then

        if IsValid(chargeLight) then chargeLight:Remove() end

        local tr_bcannon = util.TraceLine({
            start = self:GetPos(),
            endpos = self:GetPos() - Vector(0,0,10000),
            mask = MASK_NPCWORLDSTATIC,
        })

        local expLight = ents.Create("light_dynamic")
        expLight:SetKeyValue("brightness", "7")
        expLight:SetKeyValue("distance", "600")
        expLight:Fire("Color", "0 75 255")
        expLight:SetPos(self:GetAttachment(4).Pos)
        expLight:Spawn()
        expLight:SetParent(self,4)
        expLight:Fire("TurnOn", "", 0)
        timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
        self:DeleteOnRemove(expLight)

        local expLight2 = ents.Create("light_dynamic")
        expLight2:SetKeyValue("brightness", "8")
        expLight2:SetKeyValue("distance", "700")
        expLight2:Fire("Color", "0 75 255")
        expLight2:SetPos(tr_bcannon.HitPos)
        expLight2:Spawn()
        expLight2:Fire("TurnOn", "", 0)
        timer.Simple(0.1,function() if IsValid(expLight2) then expLight2:Remove() end end)
        self:DeleteOnRemove(expLight2)

        util.ScreenShake(tr_bcannon.HitPos, 16, 200, 1, 3000)

        util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam",self:GetAttachment(4).Pos,tr_bcannon.HitPos,false,self:EntIndex(),4)
        --ParticleEffect("grenade_explosion_01f", tr_bcannon.HitPos, Angle(0,0,0))

        local effectdata = EffectData()
        effectdata:SetOrigin(tr_bcannon.HitPos)
        effectdata:SetNormal(tr_bcannon.HitNormal)
        effectdata:SetRadius( 400 )
        effectdata:SetScale( 200 )
        util.Effect( "cball_bounce", effectdata )
        util.Effect( "AR2Explosion", effectdata )
        util.Effect( "ThumperDust", effectdata )
        util.Effect( "ThumperDust", effectdata )
        util.Effect( "ThumperDust", effectdata )

        util.Decal( "Scorch", tr_bcannon.HitPos + tr_bcannon.HitNormal, tr_bcannon.HitPos - tr_bcannon.HitNormal)

        local damage = 150
        
        util.VJ_SphereDamage(self,self,tr_bcannon.HitPos,self.MaxBCannonDistFromEnemy*1.5,damage,bit.bor(DMG_DISSOLVE,DMG_SHOCK,DMG_BLAST),true,true,false,false)
        
        self:EmitSound( "NPC_Strider.Shoot", 100, 120)
        sound.Play( "Weapon_Mortar.Impact", tr_bcannon.HitPos, 120, 100, 1 )

        self.DoingBCannon = false
        self:SetNWBool("VJGunshipZDoingBCannon", false)

        if self.Diving then
            self.Diving = false
            self.NextDiveTime = CurTime() + self.DiveCooldown
        end

        self.NextBCannon = CurTime() + self.BCannonCooldown
    
    end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DiveBehavior()
    local enemy = self:GetEnemy()
    if self.Diving && IsValid(enemy) && util.TraceLine({start = enemy:GetPos(), endpos = enemy:GetPos()-Vector(0,0,self.MaxBCannonDistFromEnemy), mask = MASK_NPCWORLDSTATIC}).Hit then
        self.Heli_MinChaseDist = self.MaxBCannonDistFromEnemy
        self.Heli_BackAwayFromEnemyDist = self.MaxBCannonDistFromEnemy
    else
        self.Heli_MinChaseDist = self.ShootDist
        self.Heli_BackAwayFromEnemyDist = 1000
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomHeliThink()

    self.Bullseye.VJ_NPC_Class = self.VJ_NPC_Class

    self:AnimationThink()

	if self.DoingBCannon then
		ParticleEffectAttach("hunter_shield_impact", PATTACH_POINT_FOLLOW, self, 4)
        -- local effectdata = EffectData()
        -- effectdata:SetStart(self:GetAttachment(4).Pos)
        -- util.Effect("cguard_suck", effectdata)
	end

    if IsValid(self:GetEnemy()) then
        if self:EnemyInBCannonDist() then
            self:DoBCannon()
        end
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()

    self.RotorSoundLoop:Stop()
    self.ShootGunLoop:Stop()
    self.RotorBlastSoundLoop:Stop()

    if self.CrashAlarm && self.CrashSound then
        self.CrashAlarm:Stop()
        self.CrashSound:Stop()
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	self:EmitSound("NPC_CombineGunship.Explode", 120, 100)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )
	self:EmitSound( "Explo.ww2bomb", 130, 100)
	ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0), nil)
    ParticleEffect( "striderbuster_explode_goop", self:GetPos(), self:GetAngles() )

	self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_sensorarray.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_eye.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_wing.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_engine.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
	
	self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_headsection.mdl",{Pos = self:LocalToWorld(Vector(150,0,0)), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*50, CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_midsection.mdl",{BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*50, CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_tailsection.mdl",{Pos = self:LocalToWorld(Vector(-150,0,0)), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*50, CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/gibs/gunship_gibs_nosegun.mdl",{Pos = self:LocalToWorld(Vector(250,0,0)), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*50, CollideSound = {"SolidMetal.ImpactSoft"}})

    return true

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)

	corpseEnt:GetPhysicsObject():SetVelocity(  self:GetVelocity() * 4 + Vector(0,0,250) )

	corpseEnt:EmitSound("NPC_CombineGunship.Explode", 120, 100)
	ParticleEffectAttach("env_fire_large_smoke", PATTACH_POINT_FOLLOW, corpseEnt, 5)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetAttachment(5).Pos)
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )
	self:EmitSound( "Explo.ww2bomb", 130, 100)
	timer.Simple(16,function() if IsValid(corpseEnt) then
		corpseEnt:StopParticles()
	end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	self.HasPainSounds = true -- If set to false, it won't play the pain sounds
	self.Bleeds = false

    local rotor_damage = dmginfo:GetDamagePosition():Distance(self:GetAttachment(5).Pos) < 75

	if !dmginfo:IsExplosionDamage() && !rotor_damage && !comballdamage then

		self.HasPainSounds = false -- If set to false, it won't play the pain sounds
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.1)

        if math.random(1, 4) == 1 then
            self.Bleeds = true
            self:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 92, math.random(70, 90))
            local spark = ents.Create("env_spark")
            spark:SetPos(dmginfo:GetDamagePosition())
            spark:Spawn()
            spark:Fire("StartSpark", "", 0)
            spark:Fire("StopSpark", "", 0.001)
            self:DeleteOnRemove(spark)
        end

	else
        self.Bleeds = true

		if rotor_damage then
            if dmginfo:IsExplosionDamage() then
                dmginfo:ScaleDamage(1.5)
            else
			    dmginfo:ScaleDamage(0.33)
            end
		end

        local spark = ents.Create("env_spark")
        spark:SetPos(dmginfo:GetDamagePosition())
        spark:SetKeyValue("Magnitude","2")
        spark:SetKeyValue("Spark Trail Length","2")
        spark:Spawn()
        spark:Fire("StartSpark", "", 0)
        spark:Fire("StopSpark", "", 0.001)
        self:DeleteOnRemove(spark)
	end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------