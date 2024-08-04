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
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/opfor/gonome.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("npc_vj_gonome_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?


ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.9 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_gonome_acid" -- The entity that is spawned when range attacking
ENT.RangeDistance = 1000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 400 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = false -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "Mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 1.8 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 1 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 2.0999999937415 -- How much time until it can use any attack again? | Counted in Seconds
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasBloodParticle = true -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true -- Does it spawn a decal when damaged?
ENT.HasBloodPool = true -- Does it have a blood pool?
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.PushProps = true -- Should it push props when trying to move?

-- ====== Projectile Spawn Position Variables ====== --
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "hand_right" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.RangeAttackPos_Up = 20 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 10 -- Forward/ Backward spawning position for range attack
ENT.RangeAttackPos_Right = 10 -- Right/Left spawning position for range attack


ENT.HasDeathAnimation = false -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"Diebackward"} -- Death Animations


ENT.ConstantlyFaceEnemy = false -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2000 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {"jump1"} -- Melee Attack Animations
ENT.LeapDistance = 400 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 150 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.7 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 8 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 1.0476190654599 -- How much time until it can use any attack again? | Counted in Seconds
//ENT.LeapAttackExtraTimers = {0.5,0.6} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.TimeUntilLeapAttackVelocity = 0.2 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 300 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
ENT.LeapAttackDamage = GetConVarNumber("npc_vj_gonome_d_leap")
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
-- Miscellaneous ---------------------------------------------------------------------------------------------------------------------------------------------	
ENT.AnimTbl_IdleStand = {"Idle1","Idle2"} -- The idle animation when AI is enabled

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"Flinch"} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_BeforeRangeAttack = {"gonome/gonome_eat.wav"}
ENT.SoundTbl_FootStep = {"gonome/gonome_step1.wav","gonome/gonome_step2.wav","gonome/gonome_step3.wav","gonome/gonome_step4.wav"}
ENT.SoundTbl_Idle = {"gonome/gonome_idle1.wav","gonome/gonome_idle2.wav","gonome/gonome_idle3.wav"}
ENT.SoundTbl_MeleeAttack = {"gonome/gonome_melee1.wav","gonome/gonome_melee2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zombie/claw_miss1.wav","zombie/claw_miss2.wav"}
ENT.SoundTbl_RangeAttack = {"gonome/gonome_melee1.wav","gonome/gonome_melee2.wav"}
ENT.SoundTbl_Pain = {"gonome/gonome_pain1.wav","gonome/gonome_pain2.wav","gonome/gonome_pain3.wav","gonome/gonome_pain4.wav"}
ENT.SoundTbl_Death = {"gonome/gonome_death2.wav","gonome/gonome_death3.wav","gonome/gonome_death4.wav"}
ENT.SoundTbl_LeapAttackDamage = {"gonome/gonome_melee1.wav","gonome/gonome_melee2.wav"}
ENT.SoundTbl_LeapAttackJump = {"gonome/gonome_run.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(22, 22, 90), Vector(-22, -22, 0))
	
end

function ENT:MultipleMeleeAttacks()
    local randattack = math.random(1,2)

		if randattack == 1 then
		self.MeleeAttackDistance = 38
		self.TimeUntilMeleeAttackDamage = 0.6
		self.MeleeAttackAnimationFaceEnemy = false
		self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
		self.MeleeAttackExtraTimers = {1.0} 
		self.MeleeAttackDamage = GetConVarNumber("npc_vj_gonome_d")
		self.MeleeAttackDamageDistance = 120
		self.MeleeAttackDamageType = DMG_SLASH
		self.NextAnyAttackTime_Melee = 1.621621600723 
		elseif randattack == 2 then
		self.MeleeAttackDistance = 35
		self.TimeUntilMeleeAttackDamage = 0.7
		self.MeleeAttackAnimationFaceEnemy = false
		self.AnimTbl_MeleeAttack = {"vjseq_attack2"}
		self.MeleeAttackExtraTimers = {0.9,1.2,1.4} 
		self.MeleeAttackDamage = GetConVarNumber("npc_vj_gonome_d")
		self.MeleeAttackDamageDistance = 100
		self.MeleeAttackDamageType = DMG_SLASH
		self.NextAnyAttackTime_Melee = 1.7999999141693
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
		bloodeffect:SetScale(120)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter())
		effectdata:SetScale(1)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
		//ParticleEffect("antlion_gib_02",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
	end
	
	
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
     return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(-10,20),math.random(-10,20),math.random(10,20))))*2 + self:GetUp()*200
end



/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/