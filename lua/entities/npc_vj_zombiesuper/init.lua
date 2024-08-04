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
ENT.Model = {"models/ports/zombie_soldier_face.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("npc_vj_zombiesuper_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?
ENT.MeleeAttackDamageType = DMG_ACID -- Type of Damage
ENT.TimeUntilMeleeAttackDamage = 0.9 -- This counted in seconds | This calculates the time until it hits something
//ENT.NextAnyAttackTime_Melee = 1 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("npc_vj_zombiesuper_d")
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"vjseq_Attack1"} -- Range Attack Animations
//ENT.RangeAttackExtraTimers = (1.5)
ENT.RangeAttackEntityToSpawn = "obj_bms_acidspit" -- The entity that is spawned when range attacking
ENT.RangeDistance = 800 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 500 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 1 -- How much time until the projectile code is ran?
//ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
//ENT.NextAnyAttackTime_Range = 0.6 -- How much time until it can use any attack again? | Counted in Seconds
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasBloodParticle = true -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true -- Does it spawn a decal when damaged?
ENT.HasBloodPool = true -- Does it have a blood pool?
ENT.PushProps = true -- Should it push props when trying to move?
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2000 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.HasSoundTrack = true
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"Flinch", "Bigflinch", "Smallflinch", "Laflinch", "Liflinch", "Raflinch", "Riflinch"} -- If it uses normal based animation, use this
		-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_BeforeRangeAttack = {"zombie/zo_attack1.wav","zombie/zo_attack2.wav"}
ENT.SoundTbl_FootStep = {"player/pl_step1.wav","player/pl_step2.wav","player/pl_step3.wav","player/pl_step4.wav"}
ENT.SoundTbl_Idle = {"zombie/zo_idle1.wav","zombie/zo_idle2.wav","zombie/zo_idle3.wav","zombie/zo_idle4.wav"}
ENT.SoundTbl_Alert = {"zombie/zo_alert10.wav","zombie/zo_alert20.wav","zombie/zo_alert30.wav"}
ENT.SoundTbl_MeleeAttack = {"zombie/zo_attack1.wav","zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zombie/claw_miss1.wav","zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"zombie/zo_pain1.wav","zombie/zo_pain2.wav"} 
ENT.SoundTbl_Death = {"zombie/zo_pain1.wav","zombie/zo_pain2.wav"} 
ENT.SoundTbl_SoundTrack = {"music/zombieboss/hl1_song25_remix3.mp3","music/zombieboss/hl1_song15.mp3","music/zombieboss/hl1_song3.mp3","music/zombieboss/hl_song10.mp3","music/zombieboss/bms_end_credits.mp3","music/zombieboss/half_life_17.mp3"}
---------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
    return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(-30,30),math.random(-30,30),math.random(20,30))))*2 + self:GetUp()*300
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
    local randattack = math.random(1,2)

		if randattack == 1 then
		self.MeleeAttackDistance = 38
		self.TimeUntilMeleeAttackDamage = 0.9
		self.MeleeAttackAnimationFaceEnemy = false
		self.AnimTbl_MeleeAttack = {"vjseq_Attack1"}
		self.MeleeAttackExtraTimers = {1.5} 
		self.MeleeAttackDamage = GetConVarNumber("npc_vj_zombiecivilian_d")
		self.MeleeAttackDamageDistance = 80
		self.MeleeAttackDamageType = DMG_SLASH
		self.NextAnyAttackTime_Melee = 2.3333333101537
		elseif randattack == 2 then
		self.MeleeAttackDistance = 35
		self.TimeUntilMeleeAttackDamage = 1
		self.MeleeAttackAnimationFaceEnemy = false
		self.AnimTbl_MeleeAttack = {"vjseq_Attack2"}
		self.MeleeAttackExtraTimers = {} 
		self.MeleeAttackDamage = GetConVarNumber("npc_vj_zombiecivilian_d")
		self.MeleeAttackDamageDistance = 80
		self.MeleeAttackDamageType = DMG_SLASH 
        self.NextAnyAttackTime_Melee = 1.3333333333333
end
end

function ENT:CustomInitialize()
	self:SetBodygroup(1,1)
  self:SetCollisionBounds(Vector(13, 13, 74), -Vector(13, 13, 0))
end

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
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/