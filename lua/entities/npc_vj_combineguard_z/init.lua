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


ENT.Model = {"models/VJ_Combine_guard_Z.mdl"}
ENT.StartHealth = 290
ENT.TurningSpeed = 15 -- How fast it can turn
ENT.PoseParameterLooking_TurningSpeed = 20 -- How fast does the parameter turn?
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.HasItemDropsOnDeath = true
ENT.ItemDropsOnDeathChance = 1
ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
"item_healthvial",
"weapon_frag",
"item_ammo_ar2_altfire",
}

ENT.AnimTbl_MeleeAttack = {"punch01","punch02"} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = 0.3 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 200 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 300 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?

ENT.FireGunDist = {
    min = ENT.MeleeAttackDamageDistance,
    max = 3000,
}

ENT.GuardAttackDelay = {
    min = 3.5,
    max = 5,
}
ENT.GrenadeAttackDelay = {
    min = 6,
    max = 8,
}

ENT.SoundTbl_MeleeAttack = {"NPC_Hunter.ChargeHitEnemy"}


ENT.GeneralSoundPitch1 = 80
ENT.GeneralSoundPitch2 = 85

ENT.Guard_Mech_Noises = {
"npc/vj_combine_guard_z/cguard_noise1.wav",
"npc/vj_combine_guard_z/cguard_noise2.wav",
"npc/vj_combine_guard_z/cguard_noise3.wav",
"npc/vj_combine_guard_z/cguard_noise4.wav",
"npc/vj_combine_guard_z/cguard_noise5.wav",
"npc/vj_combine_guard_z/cguard_noise6.wav",
}

ENT.SoundTbl_FootStep = {
"npc/combine_soldier/gear1.wav",
"npc/combine_soldier/gear2.wav",
"npc/combine_soldier/gear3.wav",
"npc/combine_soldier/gear4.wav",
"npc/combine_soldier/gear5.wav",
"npc/combine_soldier/gear6.wav",
}

ENT.SoundTbl_Idle = {
"npc/combine_soldier/vo/gridsundown46.wav",
"npc/combine_soldier/vo/noviscon.wav",
"npc/combine_soldier/vo/ovewatchorders3ccstimboost.wav",
"npc/combine_soldier/vo/reportallpositionsclear.wav",
"npc/combine_soldier/vo/reportallradialsfree.wav",
"npc/combine_soldier/vo/reportingclear.wav",
"npc/combine_soldier/vo/sectorissecurenovison.wav",
"npc/combine_soldier/vo/sightlineisclear.wav",
"npc/combine_soldier/vo/stabilizationteamhassector.wav",
"npc/combine_soldier/vo/stabilizationteamholding.wav",
"npc/combine_soldier/vo/teamdeployedandscanning.wav",
"npc/combine_soldier/vo/unitisclosing.wav",
"npc/combine_soldier/vo/wehavenontaggedviromes.wav",
}

ENT.SoundTbl_IdleDialogue = ENT.SoundTbl_Idle

ENT.SoundTbl_IdleDialogueAnswer = {
"npc/combine_soldier/vo/copy.wav",
"npc/combine_soldier/vo/copythat.wav",
}

ENT.SoundTbl_Investigate = {
"npc/combine_soldier/vo/motioncheckallradials.wav",
"npc/combine_soldier/vo/overwatchreportspossiblehostiles.wav",
"npc/combine_soldier/vo/prepforcontact.wav",
"npc/combine_soldier/vo/readycharges.wav",
"npc/combine_soldier/vo/readyextractors.wav",
"npc/combine_soldier/vo/readyweapons.wav",
"npc/combine_soldier/vo/readyweaponshostilesinbound.wav",
"npc/combine_soldier/vo/stayalert.wav",
"npc/combine_soldier/vo/stayalertreportsightlines.wav",
"npc/combine_soldier/vo/weaponsoffsafeprepforcontact.wav",
"npc/combine_soldier/vo/confirmsectornotsterile.wav",
}

ENT.SoundTbl_CombatIdle = {
"npc/combine_soldier/vo/thatsitwrapitup.wav",
"npc/combine_soldier/vo/gosharp.wav",
"npc/combine_soldier/vo/hardenthatposition.wav",
"npc/combine_soldier/vo/gosharpgosharp.wav",
"npc/combine_soldier/vo/targetmyradial.wav",
"npc/combine_soldier/vo/goactiveintercept.wav",
"npc/combine_soldier/vo/unitisinbound.wav",
"npc/combine_soldier/vo/unitismovingin.wav",
"npc/combine_soldier/vo/sweepingin.wav",
"npc/combine_soldier/vo/executingfullresponse.wav",
"npc/combine_soldier/vo/containmentproceeding.wav",
"npc/combine_soldier/vo/callhotpoint.wav",
"npc/combine_soldier/vo/callcontacttarget1.wav",
"npc/combine_soldier/vo/prosecuting.wav",
}

ENT.SoundTbl_Alert = {
"npc/combine_soldier/vo/contact.wav",
"npc/combine_soldier/vo/viscon.wav",
"npc/combine_soldier/vo/alert1.wav",
"npc/combine_soldier/vo/contactconfirmprosecuting.wav",
"npc/combine_soldier/vo/contactconfim.wav",
"npc/combine_soldier/vo/outbreak.wav",
"npc/combine_soldier/vo/fixsightlinesmovein.wav",
}

ENT.SoundTbl_GrenadeAttack = {
"npc/combine_soldier/vo/extractoraway.wav",
"npc/combine_soldier/vo/extractorislive.wav",
}

ENT.SoundTbl_OnKilledEnemy = {
"npc/combine_soldier/vo/targetcompromisedmovein.wav",
"npc/combine_soldier/vo/targetblackout.wav",
"npc/combine_soldier/vo/affirmativewegothimnow.wav",
"npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav",
"npc/combine_soldier/vo/overwatchtargetcontained.wav",
"npc/combine_soldier/vo/overwatchtarget1sterilized.wav",
"npc/combine_soldier/vo/onecontained.wav",
"npc/combine_soldier/vo/payback.wav",
}

ENT.SoundTbl_AllyDeath = {
"npc/combine_soldier/vo/heavyresistance.wav",
"npc/combine_soldier/vo/overwatchrequestreinforcement.wav",
"npc/combine_soldier/vo/overwatchrequestreserveactivation.wav",
"npc/combine_soldier/vo/overwatchrequestskyshield.wav",
"npc/combine_soldier/vo/overwatchrequestwinder.wav",
"npc/combine_soldier/vo/overwatchsectoroverrun.wav",
"npc/combine_soldier/vo/onedutyvacated.wav",
"npc/combine_soldier/vo/sectorisnotsecure.wav",
"npc/combine_soldier/vo/onedown.wav",
}

ENT.SoundTbl_Hurt = {
"npc/combine_soldier/vo/requestmedical.wav",
"npc/combine_soldier/vo/requeststimdose.wav",
"npc/combine_soldier/vo/coverhurt.wav",
}

ENT.SoundTbl_Pain = table.Add({"npc/combine_soldier/pain1.wav","npc/combine_soldier/pain2.wav","npc/combine_soldier/pain3.wav"},ENT.SoundTbl_Hurt)

ENT.SoundTbl_LostEnemy = {
"npc/combine_soldier/vo/skyshieldreportslostcontact.wav",
"npc/combine_soldier/vo/lostcontact.wav",
}

ENT.SoundTbl_Death = {
"npc/combine_soldier/die1.wav",
"npc/combine_soldier/die2.wav",
"npc/combine_soldier/die3.wav",
}

ENT.SoundTbl_RadioOn = {
"npc/combine_soldier/episodic_vo/on1.wav",
"npc/combine_soldier/episodic_vo/on2.wav",
}

ENT.SoundTbl_RadioOff = {
"npc/combine_soldier/episodic_vo/off1.wav",
"npc/combine_soldier/episodic_vo/off2.wav",
"npc/combine_soldier/episodic_vo/off2.wav",
}

ENT.FootStepTimeRun = 0.3
ENT.FootStepTimeWalk = 0.5
ENT.FootStepSoundLevel = 85
ENT.FootStepPitch = VJ_Set(false, false)

ENT.IdleSoundLevel = 85
ENT.IdleDialogueSoundLevel = 85
ENT.IdleDialogueAnswerSoundLevel = 85
ENT.CombatIdleSoundLevel = 90
ENT.InvestigateSoundLevel = 90
ENT.LostEnemySoundLevel = 85
ENT.AlertSoundLevel = 90
ENT.WeaponReloadSoundLevel = 90
ENT.GrenadeAttackSoundLevel = 90
ENT.OnGrenadeSightSoundLevel = 90
ENT.OnDangerSightSoundLevel = 90
ENT.OnKilledEnemySoundLevel = 90
ENT.AllyDeathSoundLevel = 90
ENT.PainSoundLevel = 90
ENT.DeathSoundLevel = 90

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(sdData, sdFile)

	if !( (VJ_HasValue(self.SoundTbl_Pain, sdFile) && !VJ_HasValue(self.SoundTbl_Hurt, sdFile)) or VJ_HasValue(DefaultSoundTbl_MedicAfterHeal, sdFile) or VJ_HasValue(self.DefaultSoundTbl_MeleeAttack, sdFile) or VJ_HasValue(self.SoundTbl_NovaProspektIdle, sdFile)  ) then

        self:EmitSound(table.Random(self.SoundTbl_RadioOn),90,math.random(85, 115))
        timer.Simple(SoundDuration(sdFile), function() if IsValid(self) && sdData:IsPlaying() then self:EmitSound(table.Random(self.SoundTbl_RadioOff),70,math.random(85, 115)) end end)
    
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

    self:SetBodygroup(1, 1)
    self:SetCollisionBounds(Vector(-22,-22,0), Vector(22,22,80))
    self.NextGuardAttackTime = CurTime()
    self.NextGrenadeAttack = CurTime()

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterStartTimer(seed)

    --self:EmitSound(table.Random(self.Guard_Mech_Noises), 78, math.random(60, 70))

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFootStepSound()

    self:EmitSound("npc/vj_combine_guard_z/cguard_footstep_walk0" .. math.random(1, 9) .. ".wav", self.FootStepSoundLevel, math.random(90, 110))

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:UpdateFirePos()

    local tr_EndPos = self:GetPos() + self:GetForward() * 200

    if IsValid(self:GetEnemy()) then

        tr_EndPos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter()

        -- if math.random(1, 2) == 1 then
        --     tr_EndPos = tr_EndPos + self:GetEnemy():GetVelocity()*0.5
        -- end

    end

    if self.FirePos then
        tr_EndPos = self.FirePos
    end

    local tr = util.TraceLine({
        start = self:GetAttachment(1).Pos,
        endpos = tr_EndPos,
        mask = MASK_SHOT,
        filter = self,
    })

    self.FirePos = tr.HitPos
    self:SetNWVector("VJCombGuardZFirePos", self.FirePos)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChargeGun()

    self.GunCharging = true
    self:SetNWBool("VJCombGuardZGunCharging", true)
    self.HasPoseParameterLooking = false -- Start using manual poseparameters instead.

    self:UpdateFirePos()

    local assumed_time_until_fire = 0.92
    timer.Simple(assumed_time_until_fire, function() if IsValid(self) then self.GunCharging = false self:SetNWBool("VJCombGuardZGunCharging", false) end end)

    util.ScreenShake(self:GetAttachment(1).Pos, 4, 200, assumed_time_until_fire*3, 2000)

    --self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 100,  math.random(110, 120))
    self:EmitSound("weapons/cguard/charging.wav", 100, math.random(90, 100) , 1)

    local light = ents.Create("light_dynamic")
    light:SetKeyValue("brightness", "3")
    light:SetKeyValue("distance", "250")
    light:Fire("Color", "0 75 255")
    light:SetPos(self:GetAttachment(1).Pos)
    light:Spawn()
    light:SetParent(self,1)
    light:Fire("TurnOn", "", 0)
    timer.Simple(assumed_time_until_fire,function() if IsValid(light) then light:Remove() end end)
    self:DeleteOnRemove(light)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoGuardExplosion(pos)

    ParticleEffect("Weapon_Combine_Ion_Cannon_Explosion", pos, Angle(0,0,0), nil)
    sound.Play("beams/beamstart5.wav", pos, 130, math.random(90, 110))

    local realisticRadius = true
    local ExplodeDist = 150
    local ExplodeDamage = 60

    util.VJ_SphereDamage(self, self,  pos, ExplodeDist, ExplodeDamage, bit.bor(DMG_BLAST, DMG_DISSOLVE, DMG_SHOCK), true, realisticRadius)

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "8")
    expLight:SetKeyValue("distance", "650")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(pos)
    expLight:Spawn()
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.2,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireGun()

    self:EmitSound("npc/vj_combine_guard_z/cguard_fire.wav", 140, math.random(80, 100))

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "5")
    expLight:SetKeyValue("distance", "400")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(self:GetAttachment(1).Pos)
    expLight:Spawn()
    expLight:SetParent(self,1)
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.2,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)

    --self:UpdateFirePos()

    ParticleEffect( "hunter_muzzle_flash",self:GetAttachment(1).Pos, self:GetAttachment(1).Ang, self )
    util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam",self:GetAttachment(1).Pos,self.FirePos,false,self:EntIndex(),1)
    self:DoGuardExplosion(self.FirePos)

    self.FirePos = nil
    self.HasPoseParameterLooking = true

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)

    if ev == 13 then
        self:ChargeGun()
    elseif ev == 12 then
        self:FireGun()
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartFiringGuardGun()

    if self.GuardGunFiring then return end
    self.GuardGunFiring = true

    local firetime = 2.5

    --self:EmitSound(table.Random(self.Guard_Mech_Noises), 78, math.random(60, 70))
    self:VJ_ACT_PLAYACTIVITY("fire", true, firetime, false)

    timer.Simple(firetime, function() if IsValid(self) then
        self.GuardGunFiring = false
    end end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:EnemyIsInFireDist()

    local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos())

    if enemydist > self.FireGunDist.min && enemydist < self.FireGunDist.max then
        return true
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GrenadeAttack()

    if self.GrenadeAttacking then return end
    self.GrenadeAttacking = true

    local total_time = 1.5
    local fire_time = 0.9

    --self:EmitSound(table.Random(self.Guard_Mech_Noises), 80, math.random(60, 70))
    self:EmitSound(table.Random(self.SoundTbl_GrenadeAttack), 80, math.random(self.GeneralSoundPitch1, self.GeneralSoundPitch2), 1, CHAN_VOICE )
    self:VJ_ACT_PLAYACTIVITY("grenade", true, total_time, true)

    timer.Simple(fire_time, function() if IsValid(self) then

        local targetpos = self:GetPos() + self:GetForward() * 300

        if IsValid(self:GetEnemy()) then

            if self:Visible(self:GetEnemy()) then

                targetpos = self:GetEnemy():GetPos()

                -- if math.random(1, 2) == 1 then
                --     targetpos = targetpos + self:GetEnemy():GetVelocity()
                -- end

            elseif self.PotentialGrenadePos then

                targetpos = self.PotentialGrenadePos

            end

        end

        self:EmitSound("weapons/mortar/mortar_fire1.wav",100,math.random(90, 110))

        local grenade = ents.Create("obj_vj_extractor_z")
        grenade:SetPos(self:GetAttachment(2).Pos)
        grenade:Spawn()
        grenade:GetPhysicsObject():SetVelocity(targetpos - self:GetPos() + Vector(0,0,200))
        grenade:SetOwner(self)

    end end)

    timer.Simple(total_time, function() if IsValid(self) then
        self.GrenadeAttacking = false
        self.NextGrenadeAttack = CurTime() + math.Rand(self.GrenadeAttackDelay.min, self.GrenadeAttackDelay.max)
    end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
function ENT:BlackHole()

    local suckradius = 125

    if !self.BlackHoleLight then
        self.BlackHoleLight = ents.Create("light_dynamic")
        self.BlackHoleLight:SetKeyValue("brightness", "3")
        self.BlackHoleLight:SetKeyValue("distance", "250")
        self.BlackHoleLight:Fire("Color", "0 75 255")
        self.BlackHoleLight:SetPos(self.FirePos)
        self.BlackHoleLight:Spawn()
        self.BlackHoleLight:Fire("TurnOn", "", 0)
        self:DeleteOnRemove(self.BlackHoleLight)

        local effectdata = EffectData()
        effectdata:SetStart(self.FirePos)
        effectdata:SetMagnitude(1)
        effectdata:SetEntity(self)
        effectdata:SetAttachment(0)
        effectdata:SetScale(1.5)
        util.Effect("cguard_warp", effectdata)
    end

    local effectdata = EffectData()
    effectdata:SetStart(self.FirePos)
    util.Effect("cguard_suck", effectdata)

    for _,ent in pairs(ents.FindInSphere(self.FirePos, suckradius)) do

        -- local tr = util.TraceLine({
        --     start = self.FirePos,
        --     endpos = ent:GetPos()+ent:OBBCenter(),
        --     mask = MASK_NPCWORLDSTATIC,
        -- })

        if ent != self && ent:IsSolid() then

            local dir = (self.FirePos - ent:GetPos()):GetNormalized()

            if (ent:IsNPC() or ent:IsPlayer()) && !self:IsAlly(ent) && !ent.VJ_IsHugeMonster then
                ent:SetVelocity(Vector(dir.x,dir.y,0) * 138)
            end

            if ent:GetMoveType() == MOVETYPE_VPHYSICS then

                local physobj = ent:GetPhysicsObject()

                if IsValid(physobj) then
                    physobj:ApplyForceCenter(dir * 3000)
                end
            
            end

        end
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.GunCharging then

        if self.FirePos then
            sound.EmitHint( SOUND_DANGER, self.FirePos, 300, 0.5, self )
        end

        self:BlackHole(self.FirePos)

		ParticleEffectAttach("hunter_shield_impactglow", PATTACH_POINT_FOLLOW, self, 1)
    else
        if self.BlackHoleLight && IsValid(self.BlackHoleLight) then
            self.BlackHoleLight:Remove()
            self.BlackHoleLight = nil
        end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("MOUSE2 (secondary attack key): Fire Gun")
	ply:ChatPrint("SPACE (jump key): Fire Grenade")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()

    local enemy = self:GetEnemy()

    if self.VJ_IsBeingControlled then

        if IsValid(enemy) then self.PotentialGrenadePos = enemy:GetPos() end

        local controller = self.VJ_TheController

        if self.NextGrenadeAttack < CurTime() && controller:KeyDown(IN_JUMP) && !self.GuardGunFiring then
            self:GrenadeAttack()
        end

        if controller:KeyDown(IN_ATTACK2) && !self.GrenadeAttacking then
            self:StartFiringGuardGun()
        end

    elseif IsValid(enemy) then 
    
        if self.NextGuardAttackTime < CurTime() && self:EnemyIsInFireDist() then

            if self.NextGrenadeAttack < CurTime() && (math.random(1, 3) == 1 or !self:Visible(enemy)) && enemy:IsOnGround() then
                self:GrenadeAttack()
            end

            if self:Visible(enemy) then

                self.PotentialGrenadePos = enemy:GetPos()
            
                if !self.GrenadeAttacking then
                    self:StartFiringGuardGun()
                end

            end

            self.NextGuardAttackTime = CurTime() + math.Rand(self.GuardAttackDelay.min, self.GuardAttackDelay.max)

        end

    end


    if self.FirePos then

        local fireang = (self.FirePos - self:GetPos()):Angle()
        self:SetIdealYawAndUpdate(fireang.y)

        self:SetPoseParameter("aim_pitch",self:WorldToLocalAngles(fireang).x + 15 )
        self:SetPoseParameter("aim_yaw",self:WorldToLocalAngles(fireang).y )
    
    end


    if self.GrenadeAttacking or self.GuardGunFiring then
        self.HasMeleeAttack = false
    else
        self.HasMeleeAttack = true
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoSpark(pos,intensity)

    intensity = intensity or 1

	local spark = ents.Create("env_spark")
	spark:SetKeyValue("Magnitude",tostring(intensity))
	spark:SetKeyValue("Spark Trail Length",tostring(intensity))
	spark:SetPos(pos)
	spark:Spawn()
	spark:Fire("StartSpark", "", 0)
	timer.Simple(0.1, function() if IsValid(spark) then spark:Remove() end end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

    self.Bleeds = true

    local infl = dmginfo:GetInflictor()
    local comballdamage = false

    if infl && IsValid(infl) then
        if infl:GetClass() == "prop_combine_ball" then
            infl:Fire("Explode")
            comballdamage = true
        end

        if !infl.DamagedVJ_ZHunter && infl:GetClass() == "obj_vj_combineball" then
            infl.DamagedVJ_ZHunter = true
            infl:DeathEffects()
            comballdamage = true
        end
    end

    if !dmginfo:IsExplosionDamage() then

        if dmginfo:IsBulletDamage() then
            if math.random(1, 4) == 1 then
                self:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav", 92, math.random(70, 90))
            else
                self.Bleeds = false
                dmginfo:SetDamage(dmginfo:GetDamage()*0.1)
            end
        else
            dmginfo:ScaleDamage(0.5)
        end

        if math.random(1, 4) == 1 then
            self:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 92, math.random(70, 90))
            self.Spark1 = ents.Create("env_spark")
            self.Spark1:SetPos(dmginfo:GetDamagePosition())
            self.Spark1:Spawn()
            self.Spark1:Fire("StartSpark", "", 0)
            self.Spark1:Fire("StopSpark", "", 0.001)
            self:DeleteOnRemove(self.Spark1)
        end

    else

        self:DoSpark(dmginfo:GetDamagePosition(), 3)

        if comballdamage then
            dmginfo:SetDamage(150)
        end
        --self:EmitSound(table.Random(self.Guard_Mech_Noises), 80, math.random(60, 70))

    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled() self.Bleeds = true end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
    if self.HasGibDeathParticles == true then -- Taken from black mesa SNPCs I think Xdddddd
        local bloodeffect = EffectData()
        bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
        bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
        bloodeffect:SetScale(200)
        util.Effect("VJ_Blood1",bloodeffect)
    end

    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,55)),Ang = self:GetAngles() + Angle(0,-90,0),Vel = self:GetRight() * math.Rand(50,50) + self:GetForward() * math.Rand(-200,200)})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,55)),Ang = self:GetAngles() + Angle(0,-90,0),Vel = self:GetRight() * math.Rand(50,50) + self:GetForward() * math.Rand(-200,200)})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/brain_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,60)),Ang = self:GetAngles() + Angle(0,-90,0)})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/heart_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,35))})
    for i = 1, 2 do
        self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)

    corpseEnt:SetBodygroup(1,0)
    self:CreateGibEntity("obj_vj_gib","models/cguard_gun.mdl",{BloodType = "", CollideSound = {"SolidMetal.ImpactSoft"}})

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------