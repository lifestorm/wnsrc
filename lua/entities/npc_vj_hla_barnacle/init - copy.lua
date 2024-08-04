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
ENT.Model = {"models/creatures/barnacle.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_SMALL_CENTERED
ENT.SightDistance = 1024 -- How far it can see
ENT.StartHealth = 24
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.CanTurnWhileStationary = false -- Can the NPC turn while it's stationary?
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_BARNACLE","CLASS_XEN"} -- NPCs with the same class with be allied to each other
--ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
--ENT.GodMode = true -- Immune to everything
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.DeathCorpseEntityClass = "prop_vj_animatable" -- The entity class it creates | "UseDefaultBehavior" = Let the base automatically detect the type
	-- ====== Death Animation Variables ====== --
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"ACT_DIESIMPLE"} -- Death Animations
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {"ACT_SMALL_FLINCH"} -- If it uses normal based animation, use this
------ Melee Attack Variables ------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
	-- ====== Animation Variables ====== --
ENT.MeleeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.MeleeAttackAngleRadius = 180 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.MeleeAttackDamageAngleRadius = 180 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
 -- Custom --
ENT.SHUTUP = false
ENT.ASNDFANDJASBF = false
ENT.BRUH = false
ENT.WHYAREYOUDOINGTHISTOME = yo_mama
ENT.STOOOOOOOOOOOOOOOOOOOP = yo_mama_and_fat
ENT.normal = false
ENT.EASTCOASTPLAN = false
ENT.MicrosoftExcel = yomama
-----------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(-12,-12,-48),Vector(12,12,0))
--	self:SetPersistent(true)
--	self:SetPos(self:GetPos()+self:GetUp()*30)
/*
	self:SetNoDraw(true)
	local barnacle = ents.Create("npc_barnacle")
	barnacle:SetPos(self:GetPos())
	barnacle:SetAngles(self:GetAngles())
	barnacle:Spawn()
	barnacle:Activate()
	barnacle:SetHealth(24)
	barnacle:SetMaxHealth(24)
	barnacle:SetCollisionBounds(Vector(-12,-12,-48),Vector(12,12,10))
	barnacle:SetModel("models/creatures/barnacle.mdl")
	self:DeleteOnRemove(barnacle)
*/

--	constraint.CreateKeyframeRope(self:GetPos(),5,"creatures/barnacle/barnacle_tongue_skin_yomama.vmt", Entity Constraint, Entity Ent1, Vector LPos1, number Bone1, Entity Ent2, Vector LPos2, number Bone2, table kv )
end

function ENT:CustomOnThink_AIEnabled() -- i had to look at hlr1 barnacle code for reference 
	local tr = util.TraceLine( {
	start = self:GetPos(),
	endpos = self:GetPos() + self:GetUp() * -1024,
	filter = self
	} )
	/*
	local dude = ents.Create("prop_dynamic")
	
	if self.EASTCOASTPLAN == false then
		self.EASTCOASTPLAN = true
		dude:SetModel("models/spitball_Medium.mdl")
		dude:SetPos(tr.HitPos)
		dude:SetParent(self)
		dude:SetPersistent(true)
		dude:Spawn()
		dude:Activate()
		self:DeleteOnRemove(dude)
	--	constraint.Rope(self,dude,1,1,self:GetPos(),dude:GetPos(),self:GetPos():Distance(dude:GetPos()),1,1,20,"creatures/barnacle/barnacle_tongue_skin_yomama.vmt",false)
		grab = constraint.CreateKeyframeRope(self:GetPos(),1.5,"cable/cable2",self,self,self:WorldToLocal(self:GetBonePosition(1)),1,dude,dude:WorldToLocal(dude:GetPos()),0)
		grab:SetColor(Color(150,25,25,255))
	end
	
	dude:SetPos(self:GetPos()-Vector(0,0,1))
	*/
	if IsValid(tr.Entity) and tr.Entity:GetClass() ~= "worldspawn"  and tr.Entity == self:GetEnemy() then
	
		self.STOOOOOOOOOOOOOOOOOOOP = tr.Entity
		self:SetPoseParameter("tongue_height", self:GetPos():Distance(tr.HitPos + self:GetUp()*125))
		
		if self.MicrosoftExcel ~= self.STOOOOOOOOOOOOOOOOOOOP then
			self.STOOOOOOOOOOOOOOOOOOOP:SetMoveType(self.WHYAREYOUDOINGTHISTOME)
			self.STOOOOOOOOOOOOOOOOOOOP:RemoveEFlags(EFL_IS_BEING_LIFTED_BY_BARNACLE)
			self.STOOOOOOOOOOOOOOOOOOOP = yo_mama_and_fat
		end
		
		if self.SHUTUP == false then
			self.SHUTUP = true
			self.STOOOOOOOOOOOOOOOOOOOP:AddEFlags(EFL_IS_BEING_LIFTED_BY_BARNACLE)
			if self.STOOOOOOOOOOOOOOOOOOOP:IsPlayer() then
				self.WHYAREYOUDOINGTHISTOME = self.STOOOOOOOOOOOOOOOOOOOP:GetMoveType()
				self.STOOOOOOOOOOOOOOOOOOOP:SetMoveType(MOVETYPE_NONE)
			elseif self.STOOOOOOOOOOOOOOOOOOOP:IsNPC() then
				self.WHYAREYOUDOINGTHISTOME = self.STOOOOOOOOOOOOOOOOOOOP:GetMoveType()
				self.STOOOOOOOOOOOOOOOOOOOP:StopMoving()
				self.STOOOOOOOOOOOOOOOOOOOP:SetMoveType(MOVETYPE_FLY)
				self.STOOOOOOOOOOOOOOOOOOOP:SetVelocity(Vector(0,0,2))
			end
			self.ASNDFANDJASBF = true
		end
				
		if self.ASNDFANDJASBF == true then -- and self.STOOOOOOOOOOOOOOOOOOOP:GetPos():Distance(self:GetPos()) >= 20
			if self.STOOOOOOOOOOOOOOOOOOOP:IsPlayer() then
				self.MeleeAttackDistance = 0 -- How close does it have to be until it attacks?
				self.MeleeAttackDamageDistance = 0
				self.MeleeAttackDamage = 0
				self.AnimTbl_MeleeAttack = {"ACT_BARNACLE_SLURP"}
				if self.normal == false then
					self.normal = true
					timer.Simple(1,function()
						if self:IsValid() and IsValid(self.STOOOOOOOOOOOOOOOOOOOP) then
							self.STOOOOOOOOOOOOOOOOOOOP:TakeDamage(10,self,self)
							self.normal = false
						end
					end)
				end
			elseif self.STOOOOOOOOOOOOOOOOOOOP:IsNPC() then
				self.MeleeAttackDistance = 125 -- How close does it have to be until it attacks?
				self.MeleeAttackDamageDistance = 50
				self.MeleeAttackDamage = self.STOOOOOOOOOOOOOOOOOOOP:GetMaxHealth()
			--	if self.STOOOOOOOOOOOOOOOOOOOP:GetPos():Distance(self:GetPos()) < 20 then
			--		self.STOOOOOOOOOOOOOOOOOOOP:StopMoving()
			--	else
					self.AnimTbl_MeleeAttack = {"ACT_BARNACLE_BITE_SMALL_THINGS"}
					self.STOOOOOOOOOOOOOOOOOOOP:SetPos(LerpVector(0.05,self.STOOOOOOOOOOOOOOOOOOOP:GetPos(),self:GetPos()+self:GetUp()*-25)) -- -100
			--	end
			end
		end
	end
	self:SetPoseParameter("tongue_height", self:GetPos():Distance(tr.HitPos + self:GetUp()*193))
end

function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self:SetPos(self:GetPos()-self:GetUp()*5)
end

function ENT:CustomOnDoKilledEnemy(ent, attacker, inflictor)
	self.SHUTUP = false
	self.ASNDFANDJASBF = false
end

function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	if IsValid(self.STOOOOOOOOOOOOOOOOOOOP) then
		self.STOOOOOOOOOOOOOOOOOOOP:SetMoveType(self.WHYAREYOUDOINGTHISTOME)
		self.STOOOOOOOOOOOOOOOOOOOP:RemoveEFlags(EFL_IS_BEING_LIFTED_BY_BARNACLE)
		self.STOOOOOOOOOOOOOOOOOOOP = yo_mama_and_fat
	end
end

function ENT:CustomOnRemove()
	if IsValid(self.STOOOOOOOOOOOOOOOOOOOP) then
		self.STOOOOOOOOOOOOOOOOOOOP:SetMoveType(self.WHYAREYOUDOINGTHISTOME)
		self.STOOOOOOOOOOOOOOOOOOOP:RemoveEFlags(EFL_IS_BEING_LIFTED_BY_BARNACLE)
		self.STOOOOOOOOOOOOOOOOOOOP = yo_mama_and_fat
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/