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
include('entities/dodgefunc.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by Mayhem, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/npc/creatures/antlion/antlion_spitter.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_MEDIUM
ENT.MaxJumpLegalDistance = VJ_Set(1000,1000) -- The max distance the NPC can jump (Usually from one node to another) | ( UP, DOWN )
ENT.VJ_NPC_Class = {"CLASS_ANTLION"} -- NPCs with the same class with be allied to each other
ENT.Burrowing = false
ENT.BurrowDelay = 0
ENT.Drowning = false
ENT.Flipped = false
---------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Blood-Related Variables ====== --
ENT.Bleeds = true
ENT.BloodColor = "Blue"

	-- ====== Melee Attack ====== --
ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 300
ENT.MeleeAttackAngleRadius = 20
ENT.MeleeAttackDamageType = DMG_SLASH
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextAnyAttackTime_Melee = false

	-- ====== Death Animations ====== --
ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"ACT_ANTLION_WORKER_EXPLODE"}
ENT.DeathAnimationTime = 10
ENT.HasDeathRagdoll = false

	-- ====== No Chase After Certain Distance Variables ====== --
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 2000 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 300 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Range Attack Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_antlion_spit" -- The entity that is spawned when range attacking
	-- ====== Animation Variables ====== --
ENT.AnimTbl_RangeAttack = {"Spitter_Attack"} -- Range Attack Animations
ENT.RangeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.RangeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the range attack animation?
	-- ====== Distance Variables ====== --
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 300 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 60 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 3 -- How much time until it can use a range attack?
ENT.NextRangeAttackTime_DoRand = 6 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
	-- ====== Projectile Spawn Position Variables ====== --
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "Spit" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.SoundTbl_Events = {
	------------------------------------------------------
	-- Footsteps -----------------------------------------
	------------------------------------------------------
    ["Foot_Rear"] = { 
	"npc/creatures/antlion/step/rear_01.mp3", 
	"npc/creatures/antlion/step/rear_02.mp3", 
	"npc/creatures/antlion/step/rear_03.mp3", 
	"npc/creatures/antlion/step/rear_04.mp3", 
	"npc/creatures/antlion/step/rear_05.mp3", 
	"npc/creatures/antlion/step/rear_06.mp3", 
	"npc/creatures/antlion/step/rear_07.mp3", 
	},
	["Foot_Front"] = { 
	"npc/creatures/antlion/step/front_01.mp3", 
	"npc/creatures/antlion/step/front_02.mp3", 
	"npc/creatures/antlion/step/front_03.mp3", 
	"npc/creatures/antlion/step/front_04.mp3", 
	"npc/creatures/antlion/step/front_05.mp3", 
	"npc/creatures/antlion/step/front_06.mp3", 
	"npc/creatures/antlion/step/front_07.mp3", 
	},
	["Stomp"] = { 
	"npc/creatures/antlion/step/stomp_01.mp3",	
	"npc/creatures/antlion/step/stomp_02.mp3", 
	"npc/creatures/antlion/step/stomp_03", 
	},
	------------------------------------------------------
	-- Foley ---------------------------------------------
	------------------------------------------------------
	["MeleeWhoosh"] = { 
	"npc/creatures/antlion/foley/attack_whoosh_01.mp3", 
	"npc/creatures/antlion/foley/attack_whoosh_02.mp3", 
	"npc/creatures/antlion/foley/attack_whoosh_03.mp3", 
	"npc/creatures/antlion/foley/attack_whoosh_04.mp3", 
	},
	["Body_Hard"] = { 
	"npc/creatures/antlion/foley/body_impact_hard_01.mp3", 
	"npc/creatures/antlion/foley/body_impact_hard_02.mp3", 
	"npc/creatures/antlion/foley/body_impact_hard_03.mp3", 
	},
	["Body_Soft"] = { 
	"npc/creatures/antlion/foley/body_impact_soft_01.mp3", 
	"npc/creatures/antlion/foley/body_impact_soft_02.mp3", 
	"npc/creatures/antlion/foley/body_impact_soft_03.mp3", 
	},
	["Body_VerySoft"] = { 
	"npc/creatures/antlion/foley/body_impact_very_soft_01.mp3", 
	"npc/creatures/antlion/foley/body_impact_very_soft_02.mp3", 
	"npc/creatures/antlion/foley/body_impact_very_soft_03.mp3", 
	},
	["Body_Slide"] = { 
	"npc/creatures/antlion/foley/body_slide_01.mp3", 
	"npc/creatures/antlion/foley/body_slide_02.mp3", 
	"npc/creatures/antlion/foley/body_slide_03.mp3", 
	"npc/creatures/antlion/foley/body_slide_04.mp3", 
	},
	["Body_Slide_Short"] = { 
	"npc/creatures/antlion/foley/body_slide_short_01.mp3", 
	"npc/creatures/antlion/foley/body_slide_short_02.mp3", 
	"npc/creatures/antlion/foley/body_slide_short_03.mp3", 
	"npc/creatures/antlion/foley/body_slide_short_04.mp3", 
	"npc/creatures/antlion/foley/body_slide_short_05.mp3", 
	"npc/creatures/antlion/foley/body_slide_short_06.mp3", 
	"npc/creatures/antlion/foley/body_slide_short_07.mp3", 
	},
	--[[["Walk"] = {
	"npc/creatures/antlion/foley/walk_01.mp3", 
	"npc/creatures/antlion/foley/walk_02.mp3", 
	"npc/creatures/antlion/foley/walk_03.mp3", 
	"npc/creatures/antlion/foley/walk_04.mp3", 
	"npc/creatures/antlion/foley/walk_05.mp3", 
	"npc/creatures/antlion/foley/walk_06.mp3", 
	"npc/creatures/antlion/foley/walk_07.mp3", 
	"npc/creatures/antlion/foley/walk_08.mp3", 
	"npc/creatures/antlion/foley/walk_09.mp3", 
	"npc/creatures/antlion/foley/walk_010.mp3", 
	},]]--
	["Wings_Buzz"] = { 
	"npc/creatures/antlion/wings/buzz_01.mp3", 
	"npc/creatures/antlion/wings/buzz_02.mp3", 
	"npc/creatures/antlion/wings/buzz_03.mp3", 
	"npc/creatures/antlion/wings/buzz_04.mp3", 
	"npc/creatures/antlion/wings/buzz_05.mp3", 
	"npc/creatures/antlion/wings/buzz_06.mp3", 
	"npc/creatures/antlion/wings/buzz_07.mp3", 
	"npc/creatures/antlion/wings/buzz_08.mp3", 
	},
	["Wings_Buzz_Quiet"] = { 
	"npc/creatures/antlion/wings/buzz_soft_01.mp3", 
	"npc/creatures/antlion/wings/buzz_soft_02.mp3", 
	"npc/creatures/antlion/wings/buzz_soft_03.mp3", 
	"npc/creatures/antlion/wings/buzz_soft_04.mp3", 
	"npc/creatures/antlion/wings/buzz_soft_05.mp3", 
	"npc/creatures/antlion/wings/buzz_soft_06.mp3", 
	"npc/creatures/antlion/wings/buzz_soft_07.mp3", 
	"npc/creatures/antlion/wings/buzz_soft_08.mp3", 
	},
	["Wings_Fly_End"] = { 
	"npc/creatures/antlion/wings/fly_end_01.mp3",	
	"npc/creatures/antlion/wings/fly_end_02.mp3", 
	"npc/creatures/antlion/wings/fly_end_03.mp3", 
	},
	["Wings_Fly_Start"] = { 
	"npc/creatures/antlion/wings/jump_01.mp3", 
	"npc/creatures/antlion/wings/jump_02.mp3", 
	"npc/creatures/antlion/wings/jump_03.mp3", 
	},
	["Wings_Single"] = { 
	"npc/creatures/antlion/wings/single_01.mp3", 
	"npc/creatures/antlion/wings/single_02.mp3", 
	"npc/creatures/antlion/wings/single_03.mp3", 
	"npc/creatures/antlion/wings/single_04.mp3", 
	"npc/creatures/antlion/wings/single_05.mp3", 
	},
	------------------------------------------------------
	-- Vocal/Vox -----------------------------------------
	------------------------------------------------------
	["Vox_Attack"] = { 
	"npc/creatures/antlion/vox/attack_01.mp3", 
	"npc/creatures/antlion/vox/attack_02.mp3", 
	"npc/creatures/antlion/vox/attack_03.mp3", 
	"npc/creatures/antlion/vox/attack_04.mp3", 
	"npc/creatures/antlion/vox/attack_05.mp3", 
	"npc/creatures/antlion/vox/attack_06.mp3", 
	"npc/creatures/antlion/vox/attack_07.mp3", 
	},
	["Vox_Attack_Tell"] = { 
	"npc/creatures/antlion/vox/attack_tell_01.mp3", 
	"npc/creatures/antlion/vox/attack_tell_02.mp3", 
	},
	["Vox_Pain"] = { 
	"npc/creatures/antlion/vox/pain_01.mp3", 
	"npc/creatures/antlion/vox/pain_02.mp3", 
	"npc/creatures/antlion/vox/pain_03.mp3", 
	"npc/creatures/antlion/vox/pain_04.mp3", 
	"npc/creatures/antlion/vox/pain_05.mp3", 
	"npc/creatures/antlion/vox/pain_06.mp3", 
	"npc/creatures/antlion/vox/pain_07.mp3", 
	"npc/creatures/antlion/vox/pain_08.mp3", 
	},
	["Vox_Grunt_Hard"] = { 
	"npc/creatures/antlion/vox/grunt_01.mp3", 
	"npc/creatures/antlion/vox/grunt_02.mp3", 
	"npc/creatures/antlion/vox/grunt_03.mp3", 
	"npc/creatures/antlion/vox/grunt_04.mp3", 
	"npc/creatures/antlion/vox/grunt_05.mp3", 
	"npc/creatures/antlion/vox/grunt_06.mp3", 
	},
	["Vox_Grunt_Soft"] = { 
	"npc/creatures/antlion/vox/grunt_soft_01.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_02.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_03.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_04.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_05.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_06.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_07.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_08.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_09.mp3", 
	},
	["Vox_Grunt_Soft_Quiet"] = { 
	"npc/creatures/antlion/vox/grunt_soft_01.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_02.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_03.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_04.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_05.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_06.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_07.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_08.mp3", 
	"npc/creatures/antlion/vox/grunt_soft_09.mp3", 
	},
	["Vox_Spawn"] = { 
	"npc/creatures/antlion/vox/spawn_01.mp3", 
	"npc/creatures/antlion/vox/spawn_02.mp3", 
	"npc/creatures/antlion/vox/spawn_03.mp3", 
	},
	["Vox_Warning"] = { 
	"npc/creatures/antlion/vox/warning_01.mp3", 
	"npc/creatures/antlion/vox/warning_02.mp3", 
	"npc/creatures/antlion/vox/warning_03.mp3", 
	"npc/creatures/antlion/vox/warning_04.mp3", 
	"npc/creatures/antlion/vox/warning_05.mp3", 
	"npc/creatures/antlion/vox/warning_06.mp3", 
	},
	["Vox_Click"] = { 
	"npc/creatures/antlion/clicks/click_01.mp3", 
	"npc/creatures/antlion/clicks/click_02.mp3", 
	"npc/creatures/antlion/clicks/click_03.mp3", 
	"npc/creatures/antlion/clicks/click_04.mp3", 
	"npc/creatures/antlion/clicks/click_05.mp3", 
	"npc/creatures/antlion/clicks/click_06.mp3", 
	"npc/creatures/antlion/clicks/click_07.mp3", 
	"npc/creatures/antlion/clicks/click_08.mp3", 
	"npc/creatures/antlion/clicks/click_09.mp3", 
	"npc/creatures/antlion/clicks/click_010.mp3", 
	},
	["Death"] = { 
	"npc/creatures/antlion/vox/death_01.mp3", 
	"npc/creatures/antlion/vox/death_02.mp3", 
	"npc/creatures/antlion/vox/death_03.mp3", 
	"npc/creatures/antlion/vox/death_04.mp3", 
	},
}
ENT.SoundTbl_Impact = {"player/damage/claw_01.mp3", "player/damage/claw_02.mp3", "player/damage/claw_03.mp3"}
ENT.SoundTbl_DamageByPlayer = {"npc/damage/bullet_damage_npc_01.mp3", "npc/damage/bullet_damage_npc_02.mp3", "npc/damage/bullet_damage_npc_03.mp3", "npc/damage/bullet_damage_npc_04.mp3", "npc/damage/bullet_damage_npc_04.mp3", "npc/damage/bullet_damage_npc_06.mp3", "npc/damage/bullet_damage_npc_07.mp3"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsDirt(pos)
    local tr = util.TraceLine({
        start = pos,
        endpos = pos -Vector(0,0,40),
        filter = self,
        mask = MASK_NPCWORLDSTATIC
    })
    local mat = tr.MatType
    return tr.HitWorld && (mat == MAT_SAND || mat == MAT_DIRT || mat == MAT_FOLIAGE || mat == MAT_SLOSH || mat == 85)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Dig(forceRemove)
    if self:IsDirt(self:GetPos()) then
		ParticleEffectAttach("AntlionFX_UndGroundMov",PATTACH_POINT_FOLLOW,self,0)
		self.CanInvestigate = false
        self:SetNoDraw(true)
		self:DrawShadow(false)
        self.IsDigging = true
		self:DoChangeMovementType(VJ_MOVETYPE_STATIONARY)
        timer.Simple(0.02,function()
            if IsValid(self) then
			VJ_CreateSound(self,"npc/creatures/antlion/dig/rumble_0"..math.random(1,2)..".mp3",80,100)
			local act = VJ_PICK({"UnBurrow01", "UnBurrow02", "UnBurrow03", "UnBurrow04"})
				self:VJ_ACT_PLAYACTIVITY(act,true,VJ_GetSequenceDuration(self,act),true)
                self.HasMeleeAttack = false
				self.HasRangeAttack = false
                timer.Simple(0.15,function() if IsValid(self) then self:SetNoDraw(false) end end)
                timer.Simple(VJ_GetSequenceDuration(self,act),function() if IsValid(self) then self.CanInvestigate = true self.HasMeleeAttack = true self.HasRangeAttack = true self.IsDigging = false self:DoChangeMovementType(VJ_MOVETYPE_GROUND) end end)
            end
        end)
    else
        if forceRemove then self:Remove() end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJC_Data = {
    CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Antlion.NewHead_Bone", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20, 64), Vector(-20, -20, 0))
	WingSFX = CreateSound(self, "npc/creatures/antlion/wings/loop_0"..math.random(1,2)..".wav")
	WingSFX:SetSoundLevel(70)
	self.LeftFlinchType = {"Flinch_Front_Left_01", "Flinch_Front_Left_02", "Flinch_Front_Left_03"}
	self.RightFlinchType = {"Flinch_Front_Right_01", "Flinch_Front_Right_02", "Flinch_Front_Right_03"}
	
	self.FrontLeftLeg_LimbHealth = (self.StartHealth*0.1)
	self.FrontRightLeg_LimbHealth = (self.StartHealth*0.1)
	self.BackLeftLeg_LimbHealth = (self.StartHealth*0.05)
	self.BackRightLeg_LimbHealth = (self.StartHealth*0.05)
	
	-- Dig Variables --
    self.IsDigging = false
    self:Dig()
	
	-- Attack Var --
	self.NextFlyAttackT = math.random(4,8)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	WingSFX:Stop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	WingSFX:Stop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local FrontLeftLeg 	= self:GetBodygroup(2)
	local FrontRightLeg = self:GetBodygroup(3)
	local BackLeftLeg 	= self:GetBodygroup(4)
	local BackRightLeg 	= self:GetBodygroup(5)
	
	if FrontRightLeg != 1 && FrontLeftLeg != 1 then
		self.MeleeAttackDistance = 75
		self.AnimTbl_MeleeAttack = {"attack1", "attack2", "attack3", "attack4", "attack5", "attack6", "attack7", "attack8", "attack9", "Evade_back", "evade_left", "evade_right", "pounce", "pounce2"}
		self.MeleeAttackDamageDistance = 80
		self.MeleeAttackDamage = 13
	elseif FrontRightLeg != 1 && FrontLeftLeg == 1 then
		self.MeleeAttackDistance = 75
		self.AnimTbl_MeleeAttack = {"attack1", "attack1_fl", "attack5", "attack8", "Evade_back", "evade_left", "evade_right", "pounce", "pounce2", "pounce_fl"}
		self.MeleeAttackDamageDistance = 80
		self.MeleeAttackDamage = 13
	elseif FrontRightLeg == 1 && FrontLeftLeg != 1 then
		self.MeleeAttackDistance = 75
		self.AnimTbl_MeleeAttack = {"attack1_fr", "attack3", "attack4", "attack9", "Evade_back", "evade_left", "evade_right", "pounce", "pounce2", "pounce_fr"}
		self.MeleeAttackDamageDistance = 80
		self.MeleeAttackDamage = 13
	elseif FrontRightLeg == 1 && FrontLeftLeg == 1 then
		self.MeleeAttackDistance = 75
		self.AnimTbl_MeleeAttack = {"Evade_back", "evade_left", "evade_right", "pounce", "pounce2", "pounce", "pounce2", "pounce", "pounce2", "attack1_FR_FL", "attack1_FR_FL_02", "attack1_FR_FL_03"}
		self.MeleeAttackDamageDistance = 80
		self.MeleeAttackDamage = 13
		
	end
	
	if CurTime() > self.NextFlyAttackT then
		if ((FrontRightLeg != 1 && FrontLeftLeg != 1) or (FrontRightLeg != 1 && FrontLeftLeg == 1) or (FrontRightLeg == 1 && FrontLeftLeg != 1)) then
			self.MeleeAttackDistance = 300
			self.MeleeAttackDamageDistance = 65
			self.MeleeAttackDamage = 17
			self.AnimTbl_MeleeAttack = {"Flyattack01All", "Flyattack02All", "Flyattack03All", "Flyattack04All", "Flyattack05All"}
			self.NextFlyAttackT = CurTime() +VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)+math.random(3,6)
		
		elseif FrontRightLeg == 1 && FrontLeftLeg == 1 then
			self.MeleeAttackDistance = 300
			self.MeleeAttackDamageDistance = 65
			self.MeleeAttackDamage = 17
			self.AnimTbl_MeleeAttack = {"Flyattack01All", "Flyattack02All", "Flyattack05All"}
			self.NextFlyAttackT = CurTime() +VJ_GetSequenceDuration(self,self.CurrentAttackAnimation)+math.random(3,6)
			
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Trajectory(start, goal, pitch)
	local g = physenv.GetGravity():Length()
	local vec = Vector(goal.x - start.x, goal.y - start.y, 0)
	local x = vec:Length()
	local y = goal.z - start.z
	if pitch > 90 then pitch = 90 end
	if pitch < -90 then pitch = -90 end
	pitch = math.rad(pitch)
	if y < math.tan(pitch)*x then
		magnitude = math.sqrt((-g*x^2)/(2*math.pow(math.cos(pitch), 2)*(y - x*math.tan(pitch))))
		vec.z = math.tan(pitch)*x
		return vec:GetNormalized()*magnitude
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	local aimAt = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
    local dist = TheProjectile:GetPos():Distance(aimAt)
	return self:Trajectory(TheProjectile:GetPos(), aimAt+self:GetEnemy():GetVelocity(), 25)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if !self.IsDigging && dmginfo:IsDamageType(8388608) then
		if self.Flipped == false then
			self.Flipped = true
			self:VJ_ACT_PLAYACTIVITY("ZapFlip",true,false,true)
			timer.Simple(VJ_GetSequenceDuration(self,"ZapFlip"),function() if IsValid(self) then self.Flipped = false end end)
		end
		self:SetGroundEntity(NULL)
		self:SetVelocity(dmginfo:GetDamageForce() *150 +(Vector(0,0,150)+(dmginfo:GetDamagePosition()-dmginfo:GetAttacker():GetPos())))
	end
	
	local FrontLeftLeg 	= self:GetBodygroup(2)
	local FrontRightLeg = self:GetBodygroup(3)
	local BackLeftLeg 	= self:GetBodygroup(4)
	local BackRightLeg 	= self:GetBodygroup(5)
	
	if hitgroup == 11 then dmginfo:SetDamage(0) end
	if hitgroup == 6 then
		if dmginfo:GetDamage() <= self.FrontLeftLeg_LimbHealth && self.FrontLeftLeg_LimbHealth > 0 && FrontLeftLeg != 1 then
			self.FrontLeftLeg_LimbHealth = (self.FrontLeftLeg_LimbHealth-dmginfo:GetDamage())
		else
			if FrontLeftLeg != 1 then
				self:SetBodygroup(2, 1)
				self:EmitSound("npc/damage/antlion_leg_dismember_0"..math.random(1,5)..".mp3", 80, 100, 1)
				ParticleEffect("spit_impact_blue",self:GetAttachment(6).Pos,Angle( 0, 0, 0 ),nil)
				self:VJ_ACT_PLAYACTIVITY(self.LeftFlinchType,true,false,true)
				
				if FrontRightLeg != 1 && BackLeftLeg != 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_1}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_1}
					self:SetHitboxSet(1)
					
				elseif FrontRightLeg == 1 && BackLeftLeg != 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(4)
				
				elseif FrontRightLeg != 1 && BackLeftLeg == 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FL_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_2}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_2}
					self:SetHitboxSet(2)
			
				elseif FrontRightLeg != 1 && BackLeftLeg == 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(14)
					
				elseif FrontRightLeg == 1 && BackLeftLeg != 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(13)
					
				elseif FrontRightLeg == 1 && BackLeftLeg == 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(12)
				
				elseif FrontRightLeg == 1 && BackLeftLeg == 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(11)
					
				end
			end
		end
		
	elseif hitgroup == 7 then
		if dmginfo:GetDamage() <= self.FrontRightLeg_LimbHealth && self.FrontRightLeg_LimbHealth > 0 && FrontRightLeg != 1 then
			self.FrontRightLeg_LimbHealth = (self.FrontRightLeg_LimbHealth-dmginfo:GetDamage())
		else
			if FrontRightLeg != 1 then
				self:SetBodygroup(3, 1)
				self:EmitSound("npc/damage/antlion_leg_dismember_0"..math.random(1,5)..".mp3", 80, 100, 1)
				ParticleEffect("spit_impact_blue",self:GetAttachment(7).Pos,Angle( 0, 0, 0 ),nil)
				self:VJ_ACT_PLAYACTIVITY(self.RightFlinchType,true,false,true)
				
				if FrontLeftLeg != 1 && BackLeftLeg != 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_3}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_3}
					self:SetHitboxSet(3)
				
				elseif FrontLeftLeg == 1 && BackLeftLeg != 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(4)
				
				elseif FrontLeftLeg != 1 && BackLeftLeg != 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_RR"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_5}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_5}
					self:SetHitboxSet(5)
			
				elseif FrontLeftLeg != 1 && BackLeftLeg == 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(15)
					
				elseif FrontLeftLeg == 1 && BackLeftLeg != 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(13)
					
				elseif FrontLeftLeg == 1 && BackLeftLeg == 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(12)
				
				elseif FrontLeftLeg == 1 && BackLeftLeg == 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(11)

				end
			end
		end
		
	elseif hitgroup == 12 then
		if dmginfo:GetDamage() <= self.BackLeftLeg_LimbHealth && self.BackLeftLeg_LimbHealth > 0 && BackLeftLeg != 1 then
			self.BackLeftLeg_LimbHealth = (self.BackLeftLeg_LimbHealth-dmginfo:GetDamage())
		else
			if BackLeftLeg != 1 then
				self:SetBodygroup(4, 1)
				
				if FrontLeftLeg != 1 && FrontRightLeg != 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_6}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_6}
					self:SetHitboxSet(6)
				
				elseif FrontLeftLeg != 1 && FrontRightLeg != 1 && BackRightLeg == 1 then
					self:VJ_ACT_PLAYACTIVITY("Flinch_Rear_Legs",true,false,true)
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(8)
				
				elseif FrontLeftLeg == 1 && FrontRightLeg != 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FL_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_2}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_2}
					self:SetHitboxSet(2)
				
				elseif FrontLeftLeg != 1 && FrontRightLeg == 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(15)
					
				elseif FrontLeftLeg == 1 && FrontRightLeg != 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(14)
					
				elseif FrontLeftLeg == 1 && FrontRightLeg == 1 && BackRightLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(12)
					
				elseif FrontLeftLeg == 1 && FrontRightLeg == 1 && BackRightLeg == 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(11)
					
				end
			end
		end
		
	elseif hitgroup == 13 then
		if dmginfo:GetDamage() <= self.BackRightLeg_LimbHealth && self.BackRightLeg_LimbHealth > 0 && BackRightLeg != 1 then
			self.BackRightLeg_LimbHealth = (self.BackRightLeg_LimbHealth-dmginfo:GetDamage())
		else
			if BackRightLeg != 1 then
				self:SetBodygroup(5, 1)
				
				if FrontLeftLeg != 1 && FrontRightLeg != 1 && BackLeftLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_RR"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_7}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_7}
					self:SetHitboxSet(7)
				
				elseif FrontLeftLeg != 1 && FrontRightLeg != 1 && BackLeftLeg == 1 then
					self:VJ_ACT_PLAYACTIVITY("Flinch_Rear_Legs",true,false,true)
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(8)
					
				elseif FrontLeftLeg != 1 && FrontRightLeg == 1 && BackLeftLeg != 1 then
					self.AnimTbl_IdleStand = {"Idle_01_FR_RR"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_5}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_5}
					self:SetHitboxSet(5)
				
				elseif FrontLeftLeg == 1 && BackLeftLeg == 1 && FrontRightLeg != 1 then -- Front leg
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(14)
					
				elseif FrontRightLeg == 1 && BackLeftLeg == 1 && FrontLeftLeg != 1 then -- Front Leg
					self.AnimTbl_IdleStand = {"Idle_01_RR_RL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_8}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_8}
					self:SetHitboxSet(15)
					
				elseif FrontLeftLeg == 1 && FrontRightLeg == 1 && BackLeftLeg != 1 then -- Back Leg
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(13)
					
				elseif FrontLeftLeg == 1 && FrontRightLeg == 1 && BackLeftLeg == 1 then -- Back Leg
					self.AnimTbl_IdleStand = {"Idle_01_FR_FL"}
					self.AnimTbl_Walk = {ACT_VM_UNDEPLOY_4}
					self.AnimTbl_Run = {ACT_VM_UNDEPLOY_4}
					self:SetHitboxSet(11)
					
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(event,activator,caller,data)
	--//Wings\\--
	if event == "OpenWings" then
		self:SetBodygroup(1, 1)
		WingSFX:Stop()
		WingSFX = CreateSound(self, "npc/creatures/antlion/wings/loop_0"..math.random(1,2)..".wav")
		WingSFX:SetSoundLevel(70)
		WingSFX:Play()
	
	elseif event == "CloseWings" then
		self:SetBodygroup(1, 0)
		WingSFX:Stop()
		
	end
	
	--// Burrow/Emerge \\--
	if event == "BurrowOut" then
		self:StopParticles()
        VJ_CreateSound(self,"npc/creatures/antlion/dig/erupt_0"..math.random(1,5)..".mp3",80,100)
		ParticleEffectAttach("AntlionFX_UnBurrow",PATTACH_POINT_FOLLOW,self,0)
		util.ScreenShake(self:GetPos(), 16, 100, 0.5, 256)
		self:DrawShadow(true)
		
	elseif event == "BurrowIn" then
		ParticleEffectAttach("AntlionFX_UndGroundMov",PATTACH_POINT_FOLLOW,self,0)
        VJ_CreateSound(self,"npc/creatures/antlion/dig/dig_down_0"..math.random(1,5)..".mp3",80,100)
		ParticleEffectAttach("AntlionFX_Burrow",PATTACH_POINT_FOLLOW,self,0)
		util.ScreenShake(self:GetPos(), 16, 100, 0.5, 256)
		self:DrawShadow(false)
		
	end
	
	-- Turning Speed/Movement Adjustments --
	if string.StartWith(event, "TurnSpeed_") then
		local nb = tonumber(string.sub(event, 11))
		self:SetMaxYawSpeed(nb)
	end
	
	--//Melee Code\\--
	if event == "Hit" then
		self:MeleeAttackCode()
		
	elseif event == "Spit" then
		self:EmitSound("npc/creatures/antlion_ranged/poison_shoot.mp3", 80, 100, 1)
		ParticleEffectAttach("spit_impact_blue",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("Spit"))
		self:RangeAttackCode()
	end
	
	--//VFX\\--
	if event == "Explode" then
		self:StopParticles()
		util.ScreenShake(self:GetPos(),12,100,0.6,300)
		self:EmitSound("npc/damage/antlion_body_burst_0"..math.random(1,3)..".mp3", 80, 100, 1)
		self:EmitSound("npc/damage/break_npc_0"..math.random(1,3)..".mp3", 80, 100, 1)
		ParticleEffect("spit_impact_blue",self:GetAttachment(5).Pos,Angle( 0, 0, 0 ),nil)
		ParticleEffect("splat_nophys_blue",self:GetAttachment(5).Pos,Angle( 0, 0, 0 ),nil)
		SafeRemoveEntityDelayed(self, 0)
	end
	
	local event = string.Explode(" ",event)
    local eventType = event[1]
    local eventPara1 = event[2]
    local eventPara2 = event[3]
    local eventPara3 = event[4] -- You can make as many of these as you want, the number is based on how many separate words are in the event
    if eventType == "melee" then
        self.MeleeAttackDamageType = eventPara1
        self.MeleeAttackDamage = eventPara2
        self.MeleeAttackDamageDistance = eventPara3
        self:MeleeAttackCode()
    end
    if eventType == "snd" then
        VJ_CreateSound(self,self.SoundTbl_Events[eventPara1],eventPara2,eventPara3)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if !self.Drowning && !self.Flipped && self:IsDirt(self:GetPos()) && self:IsOnGround() && !self.Dead && !self.IsDigging && self:GetEnemy() != nil && !self.VJ_IsBeingControlled && !self.Burrowing && !self.Flinching && !self.RangeAttacking && !self.MeleeAttacking	then
		if math.random(1,20) == 1 && CurTime() > self.BurrowDelay then
			self:Burrow()
		end
	end
	
	if self:WaterLevel() >= 2 then
		if self.Drowning == false then
			self:SetVelocity(Vector(0,0,0))
			self.Drowning = true
			self:VJ_ACT_PLAYACTIVITY("Drown",true,5,true)
			timer.Simple(5,function() if IsValid(self) then self:TakeDamage(self:Health(), self, self) end end)
			self.HasDeathAnimation = false
			self.HasDeathRagdoll = true
		end
	end
	
	if !self.Drowning && !self.Flipped && self:IsDirt(self:GetPos()) && self:IsOnGround() && !self.Dead && !self.IsDigging && self.VJ_IsBeingControlled && !self.Burrowing && !self.Flinching && !self.RangeAttacking && !self.MeleeAttacking then
		if self.VJ_TheController:KeyDown(IN_DUCK) then
			self:Burrow()
		end
	end
	
	if !self.Drowning && !self.Flipped && self:IsOnGround() && !self.Dead && !self.IsDigging && self:GetEnemy() != nil && !self.Burrowing && !self.Flinching && !self.RangeAttacking && !self.MeleeAttacking then
		self:DoDodge(300, 5, "evade_Left", "evade_Right", "Evade_Back")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetFitAtPos(pos)
    local stepHeight = self.loco and self.loco:GetStepHeight() or self.GetStepSize and self:GetStepSize() or 24
    local stepPos = pos + Vector(0,0,stepHeight)
    local tr = util.TraceEntity({
        start = stepPos,
        endpos = stepPos,
        filter = self,
        mask = MASK_NPCSOLID
    }, self)
    return not tr.Hit and stepPos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindViablePos(curPos, fallback)
    curPos = curPos or self:GetPos()

    local nearestMesh = navmesh.GetNearestNavArea(curPos, false, 1024, false, true)
    local nearest = IsValid(nearestMesh) and nearestMesh:GetClosestPointOnArea(curPos)

    local nearestPos = nearest and self:GetFitAtPos(nearest)

    if nearestPos then -- Check if we can fit at the closest position
        return nearestPos
    else -- Check the center pos
        local center = IsValid(nearestMesh) and nearestMesh:GetCenter()
        local centerPos = center and self:GetFitAtPos(center)
        if centerPos then -- use the center position instead if we can
            return centerPos
        else
            local nearestMeshes = navmesh.Find(center or curPos, 1024, 64, 64)
            for k, v in pairs(nearestMeshes) do
                if nearestMeshes ~= nearestMesh then

                    local otherNearest = v:GetClosestPointOnArea(curPos)
                    local otherNearestPos = self:GetFitAtPos(otherNearest)
                    if otherNearestPos then
                        return otherNearestPos
                    else
                        local otherCenter = v:GetCenter()
                        local otherCenterPos = self:GetFitAtPos(otherCenter)
                        if otherCenterPos then
                            return otherCenter
                        end
                    end
                end
            end
        end
    end
    return fallback
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Burrow()
	local basePos = self:GetEnemy():GetPos() -- position we start looking from
	local dist = math.random(128,256) -- min and max distance outward
	local ang = Angle(0,math.random(0,360),0) -- find a random angle
	local pos = basePos + ang:Forward() * dist --- its all coming together
	local viable = self:FindViablePos(pos)
	
	if viable && self:IsDirt(viable) && self.Burrowing == false then
		self:VJ_ACT_PLAYACTIVITY("BurrowIn",true,VJ_GetSequenceDuration(self,"BurrowIn"),true)
        self.HasMeleeAttack = false
		self.HasRangeAttack = false
		self.Burrowing = true
		self:DrawShadow(false)
		self.GodMode = true
		timer.Simple(VJ_GetSequenceDuration(self,"BurrowIn"),function() if IsValid(self) then
				if IsValid(self) && !self.Dead then
					self:StopParticles()
					self.GodMode = false
					VJ_CreateSound(self,"npc/creatures/antlion/dig/rumble_0"..math.random(1,2)..".mp3",70,100)
					local act = VJ_PICK({"UnBurrow01", "UnBurrow02", "UnBurrow03", "UnBurrow04"})
					self:SetNoDraw(true)
					self:VJ_ACT_PLAYACTIVITY(act,true,VJ_GetSequenceDuration(self,act),true)
					self:SetPos(viable)
					self:DrawShadow(true)
					timer.Simple(0.15,function()
						if IsValid(self) then
							self:SetNoDraw(false)
						end 
					end)
					timer.Simple(VJ_GetSequenceDuration(self,act),function() if IsValid(self) then self.HasMeleeAttack = true self.HasRangeAttack = true self.Burrowing = false end end)
				end
			end
		end)
		self.BurrowDelay = CurTime()+math.random(15,20)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by Mayhem, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
