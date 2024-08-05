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
ENT.Model = {"models/creatures/snark.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 2
ENT.HullType = HULL_TINY
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ALIEN_MILITARY","CLASS_SNARK","CLASS_XEN"} -- NPCs with the same class with be allied to each other
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
------ Melee Attack Variables ------
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
------ Leap Attack Variables ------
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackDamage = 10
ENT.LeapAttackDamageType = DMG_ACID -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.LeapAttackAnimationFaceEnemy = false -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.TimeUntilLeapAttackDamage = 0.8 -- How much time until it runs the leap damage code?
ENT.TimeUntilLeapAttackVelocity = 0.5 -- How much time until it runs the velocity code?
ENT.NextLeapAttackTime = 0.25 -- How much time until it can use a leap attack?
ENT.LeapAttackAngleRadius = 10 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Distance Variables ====== --
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go? -- 50
	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply? -- 100
ENT.LeapAttackVelocityUp = 200 -- How much upward force should it apply? -- 225
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.SoundTbl_Idle = {"creatures/snark/vox_idle_01.wav","creatures/snark/vox_idle_02.wav","creatures/snark/vox_idle_03.wav","creatures/snark/vox_idle_04.wav","creatures/snark/vox_idle_05.wav","creatures/snark/vox_idle_06.wav"}
ENT.SoundTbl_LeapAttackJump = {"creatures/snark/vox_jump_01.wav","creatures/snark/vox_jump_02.wav"}
-- Custom
ENT.SKDSJAK = false
ENT.IdleTwitch = {"creatures/snark/vox_twitch_01.wav","creatures/snark/vox_twitch_02.wav","creatures/snark/vox_twitch_03.wav","creatures/snark/vox_twitch_04.wav","creatures/snark/vox_twitch_05.wav"}
ENT.IdleGroom = {"creatures/snark/groom_01.wav","creatures/snark/groom_02.wav","creatures/snark/groom_03.wav","creatures/snark/groom_04.wav"}
ENT.Land = {"creatures/snark/vox_land_01.wav","creatures/snark/vox_land_02.wav"}
-----------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	ParticleEffectAttach("snark_eye2",PATTACH_POINT_FOLLOW,self,1)
	
	local texture = ents.Create("env_projectedtexture")
	texture:SetParent(self,1)
	texture:SetPos(self:GetAttachment(1).Pos)
	texture:SetAngles(self:GetAngles())
	texture:SetKeyValue("texturename","effects/flashlight001")
	texture:SetKeyValue("enableshadows","true")
	texture:SetKeyValue("lightfov","100")
	texture:SetKeyValue("farz","25")
	texture:SetKeyValue("lightstrength","1.0")
	texture:SetKeyValue("lightcolor","33 255 0")
	texture:Spawn()
	
	self:DeleteOnRemove(texture)
end

function ENT:CustomOnThink_AIEnabled()
	if self.SKDSJAK == false then
		self.SKDSJAK = true
		if GetConVarNumber("vj_hla_enable_snark_dontdie") == 0 then
			timer.Simple(20,function()
				if self:IsValid() then
					util.BlastDamage(self,self,self:GetPos(),50,5)
					self:TakeDamage(999,self,self)
				end
			end)
		end
	end
end

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	if evOptions == "snark_idletwitch" then
		VJ_EmitSound(self,self.IdleTwitch,75,100)
	elseif evOptions == "snark_idlegroom" then
		VJ_EmitSound(self,self.IdleGroom,75,100)
	elseif evOptions == "snark_idle" then
		VJ_EmitSound(self,self.SoundTbl_Idle,75,100)
	end
end

function ENT:CustomOnLeapAttack_AfterStartTimer(seed)
	timer.Simple(1.4,function()
		if self:IsValid() then
			VJ_EmitSound(self,self.Land,75,100)
		end
	end)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/