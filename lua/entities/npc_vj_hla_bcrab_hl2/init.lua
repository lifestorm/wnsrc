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
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 35
ENT.Model = {"models/creatures/headcrabs/headcrab_poison.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_TINY
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_zombieclassic","npc_vj_hla_zombiearmored","npc_vj_hla_zombiereviver","npc_vj_hla_zombiegunner","npc_vj_hla_zombieclassic_hl2","npc_vj_hla_bcrab_hl2"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Miscellaneous Variables ====== --
ENT.PushProps = true -- Should it push props when trying to move?
//ENT.AnimTbl_IdleStand = {"ACT_IDLE","ACT_IDLE2"}
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.UsesBoneAngle = true -- This can be used to stop the corpse glitching or flying on death
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 3 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
------ Melee Attack Variables ------
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
------ Leap Attack Variables ------
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackDamage = 99
ENT.LeapAttackDamageType = DMG_POISON -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_LeapAttack = {} -- Melee Attack Animations
ENT.LeapAttackAnimationFaceEnemy = false -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
ENT.NextLeapAttackTime = 1.5 -- How much time until it can use a leap attack?
	-- ====== Distance Variables ====== --
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go?
ENT.LeapAttackAngleRadius = 10 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.FootStepTimeRun = .1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = .5 -- Next foot step sound when it is walking
	-- ====== File Path Variables ====== --
ENT.SoundTbl_Idle = {"npc/headcrab_poison/ph_idle1.wav","npc/headcrab_poison/ph_idle2.wav","npc/headcrab_poison/ph_idle3.wav"}
ENT.SoundTbl_LeapAttackJump = {"npc/headcrab_poison/ph_jump1.wav","npc/headcrab_poison/ph_jump2.wav","npc/headcrab_poison/ph_jump3.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/headcrab_poison/ph_poisonbite1.wav","npc/headcrab_poison/ph_poisonbite2.wav","npc/headcrab_poison/ph_poisonbite3.wav"}
ENT.SoundTbl_Pain = {"npc/headcrab_poison/ph_pain1.wav","npc/headcrab_poison/ph_pain2.wav","npc/headcrab_poison/ph_pain3.wav"}
ENT.SoundTbl_Death = {"npc/headcrab_poison/ph_rattle1.wav","npc/headcrab_poison/ph_rattle2.wav","npc/headcrab_poison/ph_rattle3.wav"}
ENT.SoundTbl_FootStep = {"npc/headcrab_poison/ph_step1.wav","npc/headcrab_poison/ph_step2.wav","npc/headcrab_poison/ph_step3.wav","npc/headcrab_poison/ph_step4.wav"}
 -- Custom --
ENT.Alert = {"npc/headcrab_poison/ph_warning1.wav","npc/headcrab_poison/ph_warning2.wav","npc/headcrab_poison/ph_warning3.wav"}
ENT.Warning = {"npc/headcrab_poison/ph_scream1.wav","npc/headcrab_poison/ph_scream2.wav","npc/headcrab_poison/ph_scream3.wav"}
ENT.FleshImpactLayer = {"physics/bullet_impacts/flesh_layer_01.wav",
					    "physics/bullet_impacts/flesh_layer_02.wav"}
ENT.BodyImpact = {"npc/headcrab_poison/ph_wallhit1.wav","npc/headcrab_poison/ph_wallhit2.wav"}
ENT.Jump1 = false
ENT.Idle2 = false
ENT.Idle3 = false
ENT.Drowning = false
ENT.Running = false
ENT.sibuyas = false
ENT.olevels = false
ENT.BRUH = false
-----------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if self:WaterLevel() == 3 then
		self.AnimTbl_IdleStand = {ACT_HEADCRAB_DROWN} -- The idle animation when AI is enabled
		self.AnimTbl_Walk = {ACT_HEADCRAB_DROWN}
		self.AnimTbl_Run = {ACT_HEADCRAB_DROWN}
		self.DisableWandering = true -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = true -- Disables the SNPC chasing the enemy
	else
		self.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.DisableWandering = false -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = false -- Disables the SNPC chasing the enemy
	end
end

function ENT:CustomOnLeapAttack_BeforeStartTimer()
	timer.Simple(.4,function()
		if self:IsValid() then
			VJ_EmitSound(self,self.Warning,75,100)
		end
	end)
end

function ENT:CustomOnAlert(ent)
	if self:WaterLevel() ~= 3 and self.olevels == false then
		self:VJ_ACT_PLAYACTIVITY("ACT_HEADCRAB_THREAT_DISPLAY",true,1.5,false)
		timer.Simple(.5,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.Alert,75,100)
			end
		end)
		timer.Simple(1.5,function()
			if self:IsValid() then
				self.olevels = true
			end
		end)
	end
end

function ENT:CustomOnThink()
	if self:GetEnemy() and self:GetEnemy():IsValid() then
		self.AnimTbl_Walk = {ACT_RUN}
	else
		self.AnimTbl_Walk = {ACT_WALK}
	end
	if self:WaterLevel() == 3 then
		self.HasLeapAttack = false
		if self.Drowning == false then
			self.Drowning = true
			self.AnimTbl_IdleStand = {ACT_HEADCRAB_DROWN} -- The idle animation when AI is enabled
			self.AnimTbl_Walk = {ACT_HEADCRAB_DROWN}
			self.AnimTbl_Run = {ACT_HEADCRAB_DROWN}
			self.DisableWandering = true -- Disables wandering when the SNPC is idle
			self.DisableChasingEnemy = true -- Disables the SNPC chasing the enemy
			self:VJ_ACT_PLAYACTIVITY("ACT_HEADCRAB_DROWN",true,5.4,false)
			timer.Simple(5.4,function()
				if self:IsValid() and self.Drowning == true then
					self.Drowning = false
					if self:WaterLevel() == 3 then
						self:TakeDamage(self:GetMaxHealth(),self,self)
					end
				end
			end)
		end
	else
		self.HasLeapAttack = true
		self.Drowning = false
		self.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.DisableWandering = false -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = false -- Disables the SNPC chasing the enemy
	end
end

function ENT:CustomOnLeapAttackVelocityCode()
	if self:GetEnemy():OBBMaxs().z > 75 or self:GetEnemy():OBBMaxs().z < 10 or self:GetPos():Distance(self:GetEnemy():GetPos()) > 300 then
		self:SetLocalVelocity((self:GetPos()+self:GetForward() - self:LocalToWorld(Vector(0, 0, 0)))*400 + self:GetForward()*self.LeapAttackVelocityForward + self:GetUp()*self.LeapAttackVelocityUp + self:GetRight()*self.LeapAttackVelocityRight)
--		return false
	elseif self:GetEnemy():OBBMaxs().z <= 36 then
		self:SetLocalVelocity(self:GetForward()*(self:GetPos():Distance(self:GetEnemy():GetPos()))*2 + self:GetUp()*(self:GetEnemy():OBBMaxs()+self:GetEnemy():OBBCenter())*4)
	else
		self:SetLocalVelocity(self:GetForward()*(self:GetPos():Distance(self:GetEnemy():GetPos()))*2 + self:GetUp()*(self:GetEnemy():OBBMaxs())*4)
	end
	return true
end -- Return true here to override the default velocity code

function ENT:MultipleLeapAttacks()
	if math.random(1,2) == 1 then
		self.AnimTbl_LeapAttack = {"vjseq_Tele_Attack_a"}
		self.TimeUntilLeapAttackDamage = 1.7 -- How much time until it runs the leap damage code?
		self.TimeUntilLeapAttackVelocity = 1.2 -- How much time until it runs the velocity code?
	else
		self.AnimTbl_LeapAttack = {"vjseq_Tele_Attack_b"}
		self.TimeUntilLeapAttackDamage = 2.0 -- How much time until it runs the leap damage code?
		self.TimeUntilLeapAttackVelocity = 1.5 -- How much time until it runs the velocity code?
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/