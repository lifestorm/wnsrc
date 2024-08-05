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
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/creatures/barnacle.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.SightDistance = 1024 -- How far it can see
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.StartHealth = 24
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.CanTurnWhileStationary = false -- If set to true, the SNPC will be able to turn while it's a stationary SNPC
ENT.HullType = HULL_SMALL_CENTERED
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_BARNACLE","CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamageType = DMG_ALWAYSGIB -- Type of Damage
ENT.AnimTbl_MeleeAttack = {"ACT_BARNACLE_BITE_SMALL_THINGS"} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackAngleRadius = 180 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.MeleeAttackDamageAngleRadius = 180 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC

ENT.CallForHelp = false -- Does the SNPC call for help?
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"ACT_SMALL_FLINCH"} -- If it uses normal based animation, use this
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"ACT_DIESIMPLE"} -- Death Animations
ENT.DeathCorpseEntityClass = "prop_vj_animatable" -- The entity class it creates | "UseDefaultBehavior" = Let the base automatically detect the type
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.Barnacle_LastHeight = 180
ENT.Barnacle_CurEnt = NULL
ENT.Barnacle_CurEntMoveType = MOVETYPE_WALK
ENT.Barnacle_Status = 0
ENT.Barnacle_NextPullSoundT = 0
ENT.BRUH = false
ENT.normal = false
ENT.EASTCOASTPLAN = false
ENT.MicrosoftExcel = yomama
ENT.DeathOne = {"creatures/barnacle/death_one_01.wav","creatures/barnacle/death_one_02.wav"}
ENT.PullGrunt = {"creatures/barnacle/pull_grunt_01.wav",
				 "creatures/barnacle/pull_grunt_02.wav",
				 "creatures/barnacle/pull_grunt_03.wav",
				 "creatures/barnacle/pull_grunt_04.wav",
				 "creatures/barnacle/pull_grunt_05.wav",
				 "creatures/barnacle/pull_grunt_06.wav",
				 "creatures/barnacle/pull_grunt_07.wav",
				 "creatures/barnacle/pull_grunt_08.wav",
				 "creatures/barnacle/pull_grunt_09.wav",
				 "creatures/barnacle/pull_grunt_10.wav",
				 "creatures/barnacle/pull_grunt_11.wav",
				 "creatures/barnacle/pull_grunt_12.wav",
				 "creatures/barnacle/pull_grunt_13.wav"}
ENT.BitePull = {"creatures/barnacle/bite_pull_01.wav",
				"creatures/barnacle/bite_pull_02.wav",
				"creatures/barnacle/bite_pull_03.wav",
				"creatures/barnacle/bite_pull_04.wav",
				"creatures/barnacle/bite_pull_05.wav",
				"creatures/barnacle/bite_pull_06.wav",
				"creatures/barnacle/bite_pull_07.wav",
				"creatures/barnacle/bite_pull_08.wav",
				"creatures/barnacle/bite_pull_09.wav"}
ENT.GruntUnhappy = {"creatures/barnacle/grunt_unhappy_01.wav","creatures/barnacle/grunt_unhappy_02.wav","creatures/barnacle/grunt_unhappy_03.wav","creatures/barnacle/grunt_unhappy_04.wav"}
ENT.GrabContact = {"creatures/barnacle/grab_contact_01.wav","creatures/barnacle/grab_contact_02.wav","creatures/barnacle/grab_contact_03.wav"}
ENT.GrabPlayer = {"creatures/barnacle/grab_player_01.wav","creatures/barnacle/grab_player_02.wav"}
ENT.BiteAttack = {"creatures/barnacle/bite_attack_a_01.wav","creatures/barnacle/bite_attack_a_02.wav","creatures/barnacle/bite_attack_b_01.wav","creatures/barnacle/bite_attack_b_02.wav"}
ENT.BiteDigest = {"creatures/barnacle/bite_digest_01.wav",
				 "creatures/barnacle/bite_digest_02.wav",
				 "creatures/barnacle/bite_digest_03.wav",
				 "creatures/barnacle/bite_digest_04.wav",
				 "creatures/barnacle/bite_digest_05.wav",
				 "creatures/barnacle/bite_digest_06.wav",
				 "creatures/barnacle/bite_digest_07.wav",
				 "creatures/barnacle/bite_digest_08.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(-12,-12,-45),Vector(12,12,0))
	self:SetPos(self:GetPos()+Vector(0,0,-1))
end

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	if evOptions == "barnacle_death_one" then
		VJ_EmitSound(self,self.DeathOne,80,100)
	elseif evOptions == "barnacle_death_three" then
		VJ_EmitSound(self,"creatures/barnacle/death_three.wav",80,100)
	elseif evOptions == "barnacle_death_four" then
		VJ_EmitSound(self,"creatures/barnacle/death_four.wav",80,100)
	elseif evOptions == "barnacle_pullgrunt" then
		VJ_EmitSound(self,self.PullGrunt,75,100)
	elseif evOptions == "barnacle_bitepull" then
		VJ_EmitSound(self,self.BitePull,75,100)
	elseif evOptions == "barnacle_grunt_unhappy" then
		VJ_EmitSound(self,self.GruntUnhappy,75,100)
	elseif evOptions == "barnacle_bite_attack" then
		VJ_EmitSound(self,self.BiteAttack,75,100)
	elseif evOptions == "barnacle_bite_digest" then
		VJ_EmitSound(self,self.BiteDigest,75,100)
	end
end

local velInitial = Vector(0, 0, 2)

function ENT:Barnacle_CalculateTongue()
	//print(self.Barnacle_LastHeight)
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetUp()*-self.Barnacle_LastHeight,
		filter = self
	})
	local trent = tr.Entity
	local trpos = tr.HitPos
	local height = self:GetPos():Distance(trpos)
	-- Increase the height by 10 every tick | minimum = 0, maximum = 1024
	self.Barnacle_LastHeight = math.Clamp(height + 10, 0, 1024)

	if IsValid(trent) && (trent:IsNPC() or trent:IsPlayer()) && self:CheckRelationship(trent) == D_HT && trent.VJ_IsHugeMonster != true then
		-- If the grabbed enemy is a new enemy then reset the enemy values
		if self.Barnacle_CurEnt != trent then
			self:Barnacle_ResetEnt()
			self.Barnacle_CurEntMoveType = trent:GetMoveType()
		end
		self.Barnacle_CurEnt = trent
		trent:AddEFlags(EFL_IS_BEING_LIFTED_BY_BARNACLE)
		if trent:IsNPC() then
			trent:StopMoving()
			trent:SetVelocity(velInitial)
			trent:SetMoveType(MOVETYPE_FLY)
		elseif trent:IsPlayer() then
			trent:SetMoveType(MOVETYPE_NONE)
			trent:SetPos(trent:GetPos() + trent:GetUp()*0.01) -- Set the position for the enemy
			//trent:AddFlags(FL_ATCONTROLS)
		end
		trent:SetGroundEntity(NULL)
		if height >= 50 then
			if trent:IsNPC() then
				local setpos = trent:GetPos() + trent:GetUp()*10
				setpos.x = trpos.x
				setpos.y = trpos.y
				trent:SetPos(setpos) -- Set the position for the enemy
				self.MeleeAttackDamage = trent:GetMaxHealth()
				self.AnimTbl_MeleeAttack = {"ACT_BARNACLE_BITE_SMALL_THINGS"}
				self.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
				self.MeleeAttackDamageDistance = 80 -- How far does the damage go?
				if self.BRUH == false then
					self.BRUH = true
					VJ_EmitSound(self,self.GrabContact,75,100)
				end
			elseif trent:IsPlayer() then
				self.MeleeAttackDamage = 0
				self.AnimTbl_MeleeAttack = {"ACT_BARNACLE_SLURP"}
				self.MeleeAttackDistance = 0 -- How close does it have to be until it attacks?
				self.MeleeAttackDamageDistance = 0 -- How far does the damage go?
				if self.EASTCOASTPLAN == false then
					self.EASTCOASTPLAN = true
					VJ_EmitSound(self,self.GrabPlayer,75,100)
				end
				if self.normal == false then
					self.normal = true
					timer.Simple(1,function()
						if self:IsValid() and IsValid(trent) then
							trent:TakeDamage(10,self,self)
							self.normal = false
						end
					end)
				end
			end
		end
		self:SetPoseParameter("tongue_height", self:GetPos():Distance(trpos + self:GetUp()*125))
		return true
	else
		self:Barnacle_ResetEnt()
	end
	self:SetPoseParameter("tongue_height", self:GetPos():Distance(trpos + self:GetUp()*193))
	return false
end

function ENT:Barnacle_ResetEnt()
	if !IsValid(self.Barnacle_CurEnt) then return end
	self.Barnacle_CurEnt:RemoveEFlags(EFL_IS_BEING_LIFTED_BY_BARNACLE)
	//self.Barnacle_CurEnt:RemoveFlags(FL_ATCONTROLS)
	self.Barnacle_CurEnt:SetMoveType(self.Barnacle_CurEntMoveType) -- Reset the enemy's move type
	self.Barnacle_CurEnt = NULL
	self.EASTCOASTPLAN = false
	self.BRUH = false
end

function ENT:CustomOnThink_AIEnabled()
	if self.Dead then return end
	local calc = self:Barnacle_CalculateTongue()
	if calc == true && self.Barnacle_Status != 1 then
		self.Barnacle_Status = 1
		self.NextIdleStandTime = 0
		self.AnimTbl_IdleStand = {"ACT_BARNACLE_SLURP"}
	elseif calc == false && self.Barnacle_Status != 0 then
		self.Barnacle_Status = 0
		self.NextIdleStandTime = 0
		self.AnimTbl_IdleStand = {"ACT_IDLE"}
	end
end

function ENT:GetDynamicOrigin()
	return self:GetPos() + self:GetUp()*-100 -- Override this to use a different position
end

function ENT:GetMeleeAttackDamageOrigin()
	return self:GetPos() + self:GetUp()*-100 -- Override this to use a different position
end

function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	self:Barnacle_ResetEnt()
	self.MicrosoftExcel = self:GetPoseParameter("tongue_height")
end

function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self:SetPos(self:GetPos()-self:GetUp()*5)
	timer.Simple(1,function()
		if IsValid(self) then
			self:CreateGibEntity("obj_vj_gib", "models/props/barnacle_debri/barnacle_debri_rib.mdl")
			self:CreateGibEntity("obj_vj_gib", "models/props/barnacle_debri/barnacle_debri_scapula.mdl")
			self:CreateGibEntity("obj_vj_gib", "models/props/barnacle_debri/barnacle_debri_skull.mdl")
			self:CreateGibEntity("obj_vj_gib", "models/props/barnacle_debri/barnacle_debri_spine.mdl")
		end
	end)
end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	corpseEnt:SetPoseParameter("tongue_height",self.MicrosoftExcel)
	corpseEnt:ResetSequence("barnacle_death_idle")
end

function ENT:CustomOnRemove()
	self:Barnacle_ResetEnt()
end