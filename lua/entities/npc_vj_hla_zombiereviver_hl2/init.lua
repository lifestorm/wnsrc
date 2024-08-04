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

ENT.Model = {"models/creatures/zombies/zombie_classic_reviver.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_bcrab_hl2"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
ENT.GodMode = false
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
-- ====== Death Animation Variables ====== --
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed one.
--ENT.DeathCorpseBodyGroup = VJ_Set(0,1) -- #1 = the category of the first bodygroup | #2 = the value of the second bodygroup | Set -1 for #1 to let the base decide the corpse's 
ENT.DeathCorpseSetBoneAngles = true -- This can be used to stop the corpse glitching or flying on death
ENT.DeathCorpseApplyForce = false -- Disables the damage force on death | Useful for SNPCs with Death Animations
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.DeathCorpseSetBodyGroup = true -- Should it get the models bodygroups and set it to the corpse? When set to false, it uses the model's default bodygroups
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Melee Attack Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 20
ENT.MeleeAttackDamageType = DMG_SHOCK -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_MeleeAttack = {} -- Melee Attack Animations
	-- ====== Distance Variables ====== --
ENT.MeleeAttackDistance = 20 -- How close does it have to be until it attacks?
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.MeleeAttackReps = 1 -- How many times does it run the melee attack code?
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Range Attack Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackAnimationFaceEnemy = false -- Should it face the enemy while playing the range attack animation?
ENT.RangeAttackEntityToSpawn = "obj_vj_zombie_reviver_zap" -- The entity that is spawned when range attacking
	-- ====== Animation Variables ====== --
ENT.AnimTbl_RangeAttack = {"ACT_RANGE_ATTACK"} -- Range Attack Animations
	-- ====== Distance Variables ====== --
ENT.RangeDistance = 250 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 20 -- How close does it have to be until it uses melee?
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.TimeUntilRangeAttackProjectileRelease = 4.7 -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 4 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 30 -- Forward/Backward spawning position for range attack
ENT.RangeAttackPos_Right = 0 -- Right/Left spawning position for range attack
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.FootStepTimeWalk = .75 -- Next foot step sound when it is walking
ENT.BreathSoundLevel = 80
--------------------------------------------------------------------------------------------------------------------
ENT.FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
--ENT.SoundTbl_Breath = {"CReatures/zombie_revived/extra_electrics_emerge_01.wav","CReatures/zombie_revived/extra_electrics_emerge_02.wav","CReatures/zombie_revived/extra_electrics_emerge_03.wav","CReatures/zombie_revived/extra_electrics_emerge_04.wav","CReatures/zombie_revived/extra_electrics_submerge_01.wav","CReatures/zombie_revived/extra_electrics_submerge_02.wav","CReatures/zombie_revived/extra_electrics_submerge_03.wav","CReatures/zombie_revived/extra_electrics_submerge_04.wav"}
--ENT.SoundTbl_Alert = {"npc/zombie/vox/alert_01.wav","npc/zombie/vox/alert_02.wav","npc/zombie/vox/alert_03.wav","npc/zombie/vox/alert_04.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/zombie/zo_attack1.wav","npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"CReatures/zombie_revived/vox_shockwave_tell_01.wav","CReatures/zombie_revived/vox_shockwave_tell_02.wav","CReatures/zombie_revived/vox_shockwave_tell_03.wav"}
ENT.SoundTbl_RangeAttack = {"CReatures/zombie_revived/shockwave_shoot_01.wav","CReatures/zombie_revived/shockwave_shoot_02.wav"}
ENT.SoundTbl_Impact = {"physics/bullet_impacts/flesh_npc_01.wav",
					   "physics/bullet_impacts/flesh_npc_02.wav",
					   "physics/bullet_impacts/flesh_npc_03.wav",
				   	   "physics/bullet_impacts/flesh_npc_04.wav",
				   	   "physics/bullet_impacts/flesh_npc_05.wav",
				   	   "physics/bullet_impacts/flesh_npc_06.wav",
				   	   "physics/bullet_impacts/flesh_npc_07.wav",
				   	   "physics/bullet_impacts/flesh_npc_08.wav"}
ENT.SoundTbl_Pain = {"creatures/headcrab_reviver/vox/pain_01.wav","creatures/headcrab_reviver/vox/pain_02.wav","creatures/headcrab_reviver/vox/pain_03.wav","creatures/headcrab_reviver/vox/pain_04.wav","creatures/headcrab_reviver/vox/pain_05.wav","creatures/headcrab_reviver/vox/pain_06.wav"}
//ENT.SoundTbl_Death = {"npc/zombie/vox/death_01.wav","npc/zombie/vox/death_02.wav","npc/zombie/vox/death_03.wav","npc/zombie/vox/death_04.wav","npc/zombie/vox/death_05.wav","npc/zombie/vox/death_06.wav","npc/zombie/vox/death_07.wav","npc/zombie/vox/death_08.wav","npc/zombie/vox/death_09.wav"}
--------------------------------------------------------------------------------------------------------------------
ENT.ShootLayer = {"CReatures/zombie_revived/shockwave_shoot_layer_01.wav",
				  "CReatures/zombie_revived/shockwave_shoot_layer_02.wav",
				  "CReatures/zombie_revived/shockwave_shoot_layer_03.wav"}
ENT.FleshImpactLayer = {"physics/bullet_impacts/flesh_layer_01.wav",
					    "physics/bullet_impacts/flesh_layer_02.wav"}
ENT.ShockwaveTell = {"CReatures/zombie_revived/shockwave_tell_01.wav","CReatures/zombie_revived/shockwave_tell_02.wav","CReatures/zombie_revived/shockwave_tell_03.wav"}
ENT.ShockwaveTellBase = {"CReatures/zombie_revived/shockwave_tell_bass_01.wav","CReatures/zombie_revived/shockwave_tell_bass_02.wav","CReatures/zombie_revived/shockwave_tell_bass_03.wav"}
ENT.ShockwaveYell = {"CReatures/zombie_revived/vox_shockwave_yell_01.wav","CReatures/zombie_revived/vox_shockwave_yell_02.wav","CReatures/zombie_revived/vox_shockwave_yell_03.wav","CReatures/zombie_revived/vox_shockwave_yell_04.wav","CReatures/zombie_revived/vox_shockwave_yell_05.wav"}
ENT.ShockwaveRise = {"CReatures/zombie_revived/shockwave_rise_01.wav","CReatures/zombie_revived/shockwave_rise_02.wav","CReatures/zombie_revived/shockwave_rise_03.wav"}
ENT.ShockwaveRiseBase = {"CReatures/zombie_revived/shockwave_rise_bass_01.wav","CReatures/zombie_revived/shockwave_rise_bass_02.wav","CReatures/zombie_revived/shockwave_rise_bass_03.wav"}
ENT.GruntHard = {"creatures/headcrab_reviver/vox/grunt_hard_01.wav","creatures/headcrab_reviver/vox/grunt_hard_02.wav","creatures/headcrab_reviver/vox/grunt_hard_03.wav","creatures/headcrab_reviver/vox/grunt_hard_04.wav","creatures/headcrab_reviver/vox/grunt_hard_05.wav"}
ENT.GruntShort = {"creatures/headcrab_reviver/vox/grunt_short_01.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_02.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_03.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_04.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_05.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_06.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_07.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_08.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_09.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_10.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_11.wav"}
ENT.GruntSoft = {"creatures/headcrab_reviver/vox/grunt_soft_01.wav","creatures/headcrab_reviver/vox/grunt_soft_02.wav","creatures/headcrab_reviver/vox/grunt_soft_03.wav","creatures/headcrab_reviver/vox/grunt_soft_04.wav","creatures/headcrab_reviver/vox/grunt_soft_05.wav"}
ENT.HostEmerge = {"creatures/headcrab_reviver/host_emerge_01.wav","creatures/headcrab_reviver/host_emerge_02.wav"}
ENT.ReviverNodeDamage = {"damage/reviver_node_damage_01.wav","damage/reviver_node_damage_02.wav","damage/reviver_node_damage_03.wav","damage/reviver_node_damage_04.wav"}
ENT.AbandonGurgle = {"CReatures/zombie_revived/vox_abandon_gurgle_01.wav","CReatures/zombie_revived/vox_abandon_gurgle_02.wav","CReatures/zombie_revived/vox_abandon_gurgle_03.wav"}
ENT.HostAbandonBurst = {"creatures/headcrab_reviver/host_abandon_burst_01.wav","creatures/headcrab_reviver/host_abandon_burst_02.wav","creatures/headcrab_reviver/host_abandon_burst_03.wav"}
ENT.HostAbandonCrack = {"creatures/headcrab_reviver/host_abandon_crack_01.wav","creatures/headcrab_reviver/host_abandon_crack_02.wav","creatures/headcrab_reviver/host_abandon_crack_03.wav"}
ENT.HostAbandonPop = {"creatures/headcrab_reviver/host_abandon_Pop_01.wav","creatures/headcrab_reviver/host_abandon_Pop_02.wav"}
ENT.HostAbandonSnap = {"creatures/headcrab_reviver/host_abandon_Snap_01.wav","creatures/headcrab_reviver/host_abandon_Snap_02.wav","creatures/headcrab_reviver/host_abandon_Snap_03.wav"}
ENT.HostMovementGoreLayer = {"creatures/headcrab_reviver/host_movement_gore_Layer_01.wav",
				 "creatures/headcrab_reviver/host_movement_gore_Layer_02.wav",
				 "creatures/headcrab_reviver/host_movement_gore_Layer_03.wav",
				 "creatures/headcrab_reviver/host_movement_gore_Layer_04.wav",
				 "creatures/headcrab_reviver/host_movement_gore_Layer_05.wav",
				 "creatures/headcrab_reviver/host_movement_gore_Layer_06.wav",
				 "creatures/headcrab_reviver/host_movement_gore_Layer_07.wav",
				 "creatures/headcrab_reviver/host_movement_gore_Layer_08.wav"}
ENT.RevivedGrunt = {"creatures/zombie_revived/vox_grunt_misc_01.wav",
				 "creatures/zombie_revived/vox_grunt_misc_02.wav",
				 "creatures/zombie_revived/vox_grunt_misc_03.wav",
				 "creatures/zombie_revived/vox_grunt_misc_04.wav",
				 "creatures/zombie_revived/vox_grunt_misc_05.wav",
				 "creatures/zombie_revived/vox_grunt_misc_06.wav",
				 "creatures/zombie_revived/vox_grunt_misc_07.wav",
				 "creatures/zombie_revived/vox_grunt_misc_08.wav",
				 "creatures/zombie_revived/vox_grunt_misc_09.wav",
				 "creatures/zombie_revived/vox_grunt_misc_10.wav",
				 "creatures/zombie_revived/vox_grunt_misc_11.wav",
				 "creatures/zombie_revived/vox_grunt_misc_12.wav"}
ENT.RevivedScreech = {"creatures/zombie_revived/vox_revived_screech_01.wav","creatures/zombie_revived/vox_revived_screech_02.wav"}
ENT.secondHit = false
ENT.RangeSound  = {"CReatures/zombie_revived/shockwave_shoot_01.wav","CReatures/zombie_revived/shockwave_shoot_02.wav"}
ENT.child = nil
ENT.inflation = 0
ENT.funds = false
ENT.Classic = false
ENT.ReviverSpawned = false
ENT.NodePos = 0
ENT.childs = nil
ENT.start = false
ENT.count = 3
ENT.Transitioning = false
ENT.googoogaagaa = {"CReatures/headcrab_reviver/bullet_revived_absorb_01.wav","CReatures/headcrab_reviver/bullet_revived_absorb_02.wav","CReatures/headcrab_reviver/bullet_revived_absorb_03.wav"}
ENT.bingbongmarcos = {"CReatures/zombie_revived/extra_electrics_emerge_01.wav","CReatures/zombie_revived/extra_electrics_emerge_02.wav","CReatures/zombie_revived/extra_electrics_emerge_03.wav","CReatures/zombie_revived/extra_electrics_emerge_04.wav"}
ENT.saradutae = {"CReatures/zombie_revived/extra_electrics_submerge_01.wav","CReatures/zombie_revived/extra_electrics_submerge_02.wav","CReatures/zombie_revived/extra_electrics_submerge_03.wav","CReatures/zombie_revived/extra_electrics_submerge_04.wav"}
ENT.HostSubmerge = {"creatures/headcrab_reviver/host_Submerge_01.wav","creatures/headcrab_reviver/host_Submerge_02.wav"}
ENT.PLSOWKR = false
--------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.StartHealth = 90 -- 30
		self.inflation = 0.1
	else
		self.StartHealth = 66 -- 22
		self.inflation = 0.25
	end
end

function ENT:CustomOnInitialize()
	if self.ReviverSpawned == true then
		if self.Classic == true then
			self:SetModel("models/creatures/zombies/zombie_classic_reviver.mdl")
		end
		timer.Simple(.4,function()
			if self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND3" then
				VJ_EmitSound(self,"creatures/zombie_revived/getup_medium",75,100)
				timer.Simple(1.8,function()
					if self:IsValid() then
						VJ_EmitSound(self,self.RevivedScreech,75,100)
					end
				end)
			elseif self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND1" then
				VJ_EmitSound(self,"creatures/zombie_revived/getup_short",75,100)
				timer.Simple(2.2,function()
					if self:IsValid() then
						VJ_EmitSound(self,self.RevivedScreech,75,100)
					end
				end)
			elseif self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND2" then
				VJ_EmitSound(self,"creatures/zombie_revived/getup_long",75,100)
				timer.Simple(3.4,function()
					if self:IsValid() then
						VJ_EmitSound(self,self.RevivedScreech,75,100)
					end
				end)
			end
		end)
		timer.Simple(1,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.HostEmerge,75,100)
			end
		end)
		timer.Simple(2,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.HostMovementGoreLayer,75,100)
			end
		end)
		self:SetCollisionBounds(Vector(-7.231248, -20.733604, -0.361949),Vector(7.616591, 20.296774, 71.092735))
	else
		local node = ents.Create("npc_vj_hla_reviver_node")
		node:SetModel("models/creatures/headcrabs/node_headcrab.mdl")
		node:SetOwner(self)
		node:SetPersistent(true)
		if IsValid(self) then
			node:Spawn()
			if math.random(1,3) == 1 then
				node:SetParent(self,1)
				node:SetPos(self:GetAttachment(self:LookupAttachment("head_attachment")).Pos)
				node:SetLocalPos(Vector(1,-1,-1))
				node:SetAngles(self:GetAngles()+Angle(0,30,90))
				ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,1)
				self.NodePos = "head"
				self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
				self.AnimTbl_Walk = {ACT_WALK_STIMULATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
				self.AnimTbl_Run = {ACT_WALK_STIMULATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			elseif math.random(1,3) == 2 then
				node:SetParent(self,2)
				node:SetPos(self:GetAttachment(self:LookupAttachment("arm_lower_L_TWIST1_attachment")).Pos)
				node:SetLocalPos(Vector(0,0,0))
				node:SetAngles(self:GetAngles()+Angle(0,0,90))
				ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,2)
				self.NodePos = "arm_l"
				self.AnimTbl_IdleStand = {ACT_IDLE_RELAXED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
				self.AnimTbl_Walk = {ACT_WALK_RELAXED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
				self.AnimTbl_Run = {ACT_WALK_RELAXED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			else
				node:SetParent(self,3)
				node:SetPos(self:GetAttachment(self:LookupAttachment("arm_lower_R_TWIST1_attachment")).Pos)
				node:SetLocalPos(Vector(0,0,0))
				node:SetAngles(self:GetAngles()+Angle(0,0,90))
				ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,3)
				self.NodePos = "arm_r"
				self.AnimTbl_IdleStand = {ACT_IDLE_AGITATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
				self.AnimTbl_Walk = {ACT_WALK_AGITATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
				self.AnimTbl_Run = {ACT_WALK_AGITATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			end
			self.child = node
		end
	end
end

function ENT:CustomAttackCheck_MeleeAttack()
	if self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM1" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM2" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM3" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM4" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM5" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND1" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND2" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND3" or self.GodMode == true then
		return false
	else
		return true
	end
end -- Not returning true will not let the melee attack code run!

function ENT:CustomAttackCheck_RangeAttack()
	if self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM1" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM2" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM3" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM4" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_ARM5" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND1" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND2" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_STAND3" or self.GodMode == true then
		return false
	else
		return true
	end
end -- Not returning true will not let the melee attack code run!

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if hitgroup == 11 and self.NodePos == "head" or hitgroup == 12 and self.NodePos == "arm_l" or hitgroup == 14 and self.NodePos == "arm_r" or hitgroup == 15 and self.NodePos == "leg_l" or hitgroup == 16 and self.NodePos == "leg_r" then
--		dmginfo:SetDamage(self.inflation)
		dmginfo:ScaleDamage(self.inflation)
		if self.ReviverSpawned == true then
			if self.childs:IsValid() then
				self.childs:VJ_ACT_PLAYACTIVITY("ACT_FLINCH_PHYSICS",true,0.444444,false)
			end
		else
			if self.child:IsValid() then
				self.child:VJ_ACT_PLAYACTIVITY("ACT_FLINCH_PHYSICS",true,0.444444,false)
			end
		end
		ParticleEffect("blood_impact_reviver_node_electrical",dmginfo:GetDamagePosition(),self:GetAngles())
	else
		dmginfo:ScaleDamage(0)
		VJ_EmitSound(self,self.googoogaagaa,75,100)
	end
	
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		if self:Health() <= 61 and self:Health() > 31 and self.count == 3 then -- +1
			self.GodMode = true
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.childs,self.saradutae,75,100)
					VJ_EmitSound(self.childs,self.HostEmerge,75,100)
				end
			else
				if self.child:IsValid() then
					self.child:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.child,self.saradutae,75,100)
					VJ_EmitSound(self.child,self.HostEmerge,75,100)
				end
			end
			self:StopParticles()
			if self.NodePos == "head" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM3",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Arm_L()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM1",true,2.26667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM2",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM4",true,2.16667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM5",true,2.23333,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_L()
				end
			end
			timer.Simple(1.3,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(true)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(true)
						end
					end
				end
			end)
			self.count = 2
		end
		if self:Health() <= 31 and self.count == 2 then -- +1
			self.GodMode = true
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.childs,self.saradutae,75,100)
					VJ_EmitSound(self.childs,self.HostEmerge,75,100)
				end
			else
				if self.child:IsValid() then
					self.child:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.child,self.saradutae,75,100)
					VJ_EmitSound(self.child,self.HostEmerge,75,100)
				end
			end
			self:StopParticles()
			if self.NodePos == "head" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM3",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Arm_L()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM1",true,2.26667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM2",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM4",true,2.16667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM5",true,2.23333,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_L()
				end
			end
			timer.Simple(1.3,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(true)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(true)
						end
					end
				end
			end)
			self.count = 1
		end
	else
		if self:Health() <= 45 and self:Health() > 23 and self.count == 3 then -- +1
			self.GodMode = true
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.childs,self.saradutae,75,100)
					VJ_EmitSound(self.childs,self.HostEmerge,75,100)
				end
			else
				if self.child:IsValid() then
					self.child:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.child,self.saradutae,75,100)
					VJ_EmitSound(self.child,self.HostEmerge,75,100)
				end
			end
			self:StopParticles()
			if self.NodePos == "head" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM3",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Arm_L()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM1",true,2.26667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM2",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM4",true,2.16667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM5",true,2.23333,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_L()
				end
			end
			timer.Simple(1.3,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(true)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(true)
						end
					end
				end
			end)
			self.count = 2
		end
		if self:Health() <= 23 and self.count == 2 then -- +1
			self.GodMode = true
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.childs,self.saradutae,75,100)
					VJ_EmitSound(self.childs,self.HostEmerge,75,100)
				end
			else
				if self.child:IsValid() then
					self.child:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.16667,false)
					VJ_EmitSound(self.child,self.saradutae,75,100)
					VJ_EmitSound(self.child,self.HostEmerge,75,100)
				end
			end
			self:StopParticles()
			if self.NodePos == "head" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM3",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Arm_L()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM1",true,2.26667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_R()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "arm_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM2",true,1.66667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Leg_L()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_l" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM4",true,2.16667,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_R()
				end
			elseif self.NodePos == "leg_r" then
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM5",true,2.23333,false,0.25)
				if math.random(1,4) == 1 then
					self:Head()
				elseif math.random(1,4) == 2 then
					self:Arm_L()
				elseif math.random(1,4) == 3 then
					self:Arm_R()
				else
					self:Leg_L()
				end
			end
			timer.Simple(1.3,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(true)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(true)
						end
					end
				end
			end)
			self.count = 1
		end
	end
end

function ENT:CustomOnThink()
	if math.random(1,5) == 5 then
		if math.random(1,2) == 1 then
			if math.random(1,2) == 1 then
				self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK3"}
				self.MeleeAttackReps = 2
				self.TimeUntilMeleeAttackDamage = 0.85 -- This counted in seconds | This calculates the time until it hits something
			else
				self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK1"}
				self.MeleeAttackReps = 1
				self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
			end
		else
			self.AnimTbl_MeleeAttack = {"ACT_ZOM_SWATLEFTLOW","ACT_ZOM_SWATRIGHTLOW","ACT_ZOM_SWATLEFTMID","ACT_ZOM_SWATRIGHTMID"}
			self.MeleeAttackReps = 1
			self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
		end
	else
		if math.random(1,3) == 1 then
			self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK2"}
			self.MeleeAttackReps = 2
			self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
		elseif math.random(1,3) == 2 then
			self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK4"}
			self.MeleeAttackReps = 1
			self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
		else
			self.AnimTbl_MeleeAttack = {"vjseq_zombie_lunge_forward_01"}
			self.MeleeAttackReps = 3
			self.TimeUntilMeleeAttackDamage = 0.75 -- This counted in seconds | This calculates the time until it hits something
		end
	end
end

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	if evOptions == "zombierevived_footstep" then
		VJ_EmitSound(self,self.FootStep,70,100)
	end
end

function ENT:CustomAttackCheck_RangeAttack()
	if self:GetEnemy():IsOnGround() then
		return true
	else
		return false
	end
end -- Not returning true will not let the range attack code run!

function ENT:RangeAttackCode_GetShootPos(projectile)
	return (self:GetPos()+self:GetForward()*200 - self:LocalToWorld(Vector(0, 0, 0)))*2 + self:GetUp()*1
end

function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	VJ_EmitSound(self,self.ShootLayer,75,100)
	VJ_EmitSound(self,self.ShockwaveYell,75,100)
end -- Called after Spawn()

/*
function ENT:CustomRangeAttackCode()
	if self:GetEnemy() and self:GetEnemy():IsOnGround()  and self.secondHit == false then
		self.secondHit = true
		timer.Simple(4.65,function()
			if self:IsValid() and self:GetSequenceActivity(self:GetSequence()) == ACT_RANGE_ATTACK1 then
				VJ_EmitSound(self,self.RangeSound,self.RangeAttackSoundLevel,100)
				util.ParticleTracerEx( "zombie_reviver_blue", self:GetPos(),self:GetAttachment(self:LookupAttachment("range_attack")).Pos+self:GetForward()*300, false, self:EntIndex(), 2)
				for _,x in pairs(ents.FindAlongRay(self:GetPos(),self:GetAttachment(self:LookupAttachment("range_attack")).Pos+self:GetForward()*300)) do
					util.VJ_SphereDamage(self,self,x:GetPos(),5,GetConVarNumber("vj_hla_rcrab_d1"),DMG_SHOCK,true,false)
					self.secondHit = false
				end
			else
				self.secondHit = false
			end
		end)
	end
end
*/

function ENT:CustomOnRangeAttack_BeforeStartTimer(seed)
	VJ_EmitSound(self,self.ShockwaveTell,75,100)
	VJ_EmitSound(self,self.ShockwaveTellBase,75,100)
	ParticleEffectAttach("reviver_node_zombie_fx_ab",PATTACH_POINT_FOLLOW,self,1)
	timer.Simple(2.4,function()
		if self:IsValid() then
			VJ_EmitSound(self,self.ShockwaveRise,75,100)
			VJ_EmitSound(self,self.ShockwaveRiseBase,75,100)
		end
	end)
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,60,100)
	VJ_EmitSound(self,self.ReviverNodeDamage,60,100)
end

function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	if hitgroup == 11 and self.NodePos == "head" or hitgroup == 12 and self.NodePos == "arm_l" or hitgroup == 14 and self.NodePos == "arm_r" or hitgroup == 15 and self.NodePos == "leg_l" or hitgroup == 16 and self.NodePos == "leg_r" then
		if self.NodePos == "head" then
			self.AnimTbl_Death = {ACT_DIE_HEADSHOT}
		elseif self.NodePos == "arm_l" then
			self.AnimTbl_Death = {ACT_DIE_CHESTSHOT}
		elseif self.NodePos == "arm_r" then
			self.AnimTbl_Death = {ACT_DIE_GUTSHOT}
		elseif self.NodePos == "leg_l" then
			self.AnimTbl_Death = {ACT_DIESIMPLE}
		elseif self.NodePos == "leg_r" then
			self.AnimTbl_Death = {ACT_DIEVIOLENT}
		end
		if self.ReviverSpawned == true then
			if self.childs:IsValid() then
				self.childs:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,31,false)
			end
		else
			if self.child:IsValid() then
				self.child:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,31,false)
			end
		end
		VJ_EmitSound(self,self.saradutae,75,100)
		VJ_EmitSound(self,self.HostSubmerge,75,100)
			timer.Simple(0.4,function()
				if self:IsValid() then
					VJ_EmitSound(self,self.RevivedGrunt,75,100)
				end
			end)
			timer.Simple(1.1,function()
				if self:IsValid() then
					VJ_EmitSound(self,self.RevivedGrunt,75,100)
				end
			end)
			timer.Simple(1.3,function()
				if self:IsValid() then
					VJ_EmitSound(self,self.saradutae,75,100)
					VJ_EmitSound(self,self.HostSubmerge,75,100)
					VJ_EmitSound(self,self.HostMovementGoreLayer,75,100)
					ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,50),self:GetAngles())
				end
			end)
		timer.Simple(0,function()//3.5
			if self:IsValid() then
				local crab = ents.Create("npc_vj_hla_rcrab")
				crab:SetPos(self:GetPos()+self:GetForward()*-0.5)
				crab:SetAngles(self:GetAngles())
				crab:SetParent(self)
				timer.Simple(2.66667,function()
					if self:IsValid() and self.ReviverSpawned == false and self.child:IsValid() or self:IsValid() and self.ReviverSpawned == true and self.childs:IsValid() then
						VJ_EmitSound(self,self.HostMovementGoreLayer,75,100)
						ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,30),self:GetAngles())
						timer.Simple(1,function()
							if self:IsValid() then
								VJ_EmitSound(self,self.AbandonGurgle,75,100)
								VJ_EmitSound(self,self.HostAbandonCrack,75,100)
								ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,30),self:GetAngles())
							end
						end)
						timer.Simple(1.2,function()
							if self:IsValid() then
								VJ_EmitSound(self,self.HostAbandonBurst,75,100)
								ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,30),self:GetAngles())
							end
						end)
						timer.Simple(1.65,function()
							if self:IsValid() then
								VJ_EmitSound(self,self.HostMovementGoreLayer,75,100)
								ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,30),self:GetAngles())
							end
						end)
						timer.Simple(2.1,function()
							if self:IsValid() then
								VJ_EmitSound(self,self.HostAbandonSnap,75,100)
								ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,50),self:GetAngles())
							end
						end)
						timer.Simple(2.3,function()
							if self:IsValid() then
								VJ_EmitSound(self,self.HostAbandonPop,75,100)
								ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,30),self:GetAngles())
							end
						end)
						crab:Spawn()
						crab.GodMode = true
						crab:VJ_DoSetEnemy(self:GetEnemy(),false,false)
						crab:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,4,false)
						if self.ReviverSpawned == true then
							self.childs:SetNoDraw(true)
						else
							self.child:SetNoDraw(true)
						end
						timer.Simple(1,function()
							if crab:IsValid() then
								VJ_EmitSound(crab,self.HostEmerge,75,100)
								ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,30),self:GetAngles())
								VJ_EmitSound(crab,"creatures/headcrab_reviver/vox/host_abandon_a.wav",75,100)
								timer.Simple(1,function()
									if crab:IsValid() then
										VJ_EmitSound(crab,"creatures/headcrab_reviver/vox/host_abandon_b.wav",75,100)
										timer.Simple(1,function()
											if crab:IsValid() then
												VJ_EmitSound(crab,"creatures/headcrab_reviver/vox/host_abandon_c.wav",75,100)
												VJ_EmitSound(crab,"creatures/headcrab_reviver/host_abandon_exit.wav",75,100)
												ParticleEffect("blood_impact_red_01",self:GetPos()+Vector(0,0,30),self:GetAngles())
												crab.GodMode = false
											end
										end)
									end
								end)
							end
						end)
					end
				end)
				timer.Simple(5,function()
					if crab:IsValid() and self:IsValid() then
						crab:SetParent(nil)
					end
				end)
			end
		end)
	end
end

function ENT:Head()
	timer.Simple(15,function()
		if self:IsValid() then
			ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,1)
			self.NodePos = "head"
			self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_WALK_STIMULATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
			self.AnimTbl_Run = {ACT_WALK_STIMULATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM3",true,2.8,false)
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:SetParent(self,1)
					self.childs:SetPos(self:GetAttachment(self:LookupAttachment("head_attachment")).Pos)
					self.childs:SetLocalPos(Vector(3,2,-1))
					self.childs:SetAngles(self:GetAngles()+Angle(0,30,90))
				end
			else
				if self.child:IsValid() then
					self.child:SetParent(self,1)
					self.child:SetPos(self:GetAttachment(self:LookupAttachment("head_attachment")).Pos)
					self.child:SetLocalPos(Vector(3,2,-1))
					self.child:SetAngles(self:GetAngles()+Angle(0,30,90))
				end
			end
			timer.Simple(1,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.childs,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.childs,self.HostEmerge,75,100)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.child,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.child,self.HostEmerge,75,100)
						end
					end
					self.GodMode = false
				end
			end)
		end
	end)
end

function ENT:Arm_L()
	timer.Simple(15,function()
		if self:IsValid() then
			ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,2)
			self.NodePos = "arm_l"
			self.AnimTbl_IdleStand = {ACT_IDLE_RELAXED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_WALK_RELAXED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
			self.AnimTbl_Run = {ACT_WALK_RELAXED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM1",true,1.66667,false)
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:SetParent(self,2)
					self.childs:SetPos(self:GetAttachment(self:LookupAttachment("arm_lower_L_TWIST1_attachment")).Pos)
					self.childs:SetLocalPos(Vector(0,0,0))
					self.childs:SetAngles(self:GetAngles()+Angle(0,0,90))
				end
			else
				if self.child:IsValid() then
					self.child:SetParent(self,2)
					self.child:SetPos(self:GetAttachment(self:LookupAttachment("arm_lower_L_TWIST1_attachment")).Pos)
					self.child:SetLocalPos(Vector(0,0,0))
					self.child:SetAngles(self:GetAngles()+Angle(0,0,90))
				end
			end
			timer.Simple(1,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.childs,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.childs,self.HostEmerge,75,100)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.child,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.child,self.HostEmerge,75,100)
						end
					end
					self.GodMode = false
				end
			end)
		end
	end)
end

function ENT:Arm_R()
	timer.Simple(15,function()
		if self:IsValid() then
			ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,3)
			self.NodePos = "arm_r"
			self.AnimTbl_IdleStand = {ACT_IDLE_AGITATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_WALK_AGITATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
			self.AnimTbl_Run = {ACT_WALK_AGITATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM2",true,1.8,false)
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:SetParent(self,3)
					self.childs:SetPos(self:GetAttachment(self:LookupAttachment("arm_lower_R_TWIST1_attachment")).Pos)
					self.childs:SetLocalPos(Vector(0,0,0))
					self.childs:SetAngles(self:GetAngles()+Angle(0,0,90))
				end
			else
				if self.child:IsValid() then
					self.child:SetParent(self,3)
					self.child:SetPos(self:GetAttachment(self:LookupAttachment("arm_lower_R_TWIST1_attachment")).Pos)
					self.child:SetLocalPos(Vector(0,0,0))
					self.child:SetAngles(self:GetAngles()+Angle(0,0,90))
				end
			end
			timer.Simple(1,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.childs,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.childs,self.HostEmerge,75,100)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.child,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.child,self.HostEmerge,75,100)
						end
					end
					self.GodMode = false
				end
			end)
		end
	end)
end

function ENT:Leg_L()
	timer.Simple(15,function()
		if self:IsValid() then
			ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,4)
			self.NodePos = "leg_l"
			self.AnimTbl_IdleStand = {ACT_IDLE_AIM_RELAXED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_RUN_RELAXED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
			self.AnimTbl_Run = {ACT_RUN_RELAXED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM4",true,2.26667,false)
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:SetParent(self,4)
					self.childs:SetPos(self:GetAttachment(self:LookupAttachment("leg_lower_L_attachment")).Pos)
					self.childs:SetLocalPos(Vector(5,3,0))
					self.childs:SetAngles(self:GetAngles()+Angle(0,0,-90))
				end
			else
				if self.child:IsValid() then
					self.child:SetParent(self,4)
					self.child:SetPos(self:GetAttachment(self:LookupAttachment("leg_lower_L_attachment")).Pos)
					self.child:SetLocalPos(Vector(5,3,0))
					self.child:SetAngles(self:GetAngles()+Angle(0,0,-90))
				end
			end
			timer.Simple(1,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.childs,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.childs,self.HostEmerge,75,100)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.child,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.child,self.HostEmerge,75,100)
						end
					end
					self.GodMode = false
				end
			end)
		end
	end)
end

function ENT:Leg_R()
	timer.Simple(15,function()
		if self:IsValid() then
			ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,self,5)
			self.NodePos = "leg_r"
			self.AnimTbl_IdleStand = {ACT_IDLE_AIM_AGITATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_RUN_AGITATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
			self.AnimTbl_Run = {ACT_RUN_AGITATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM5",true,2.06667,false)
			if self.ReviverSpawned == true then
				if self.childs:IsValid() then
					self.childs:SetParent(self,5)
					self.childs:SetPos(self:GetAttachment(self:LookupAttachment("leg_lower_R_attachment")).Pos)
					self.childs:SetLocalPos(Vector(-5,-3,0))
					self.childs:SetAngles(self:GetAngles()+Angle(0,0,90))
				end
			else
				if self.child:IsValid() then
					self.child:SetParent(self,5)
					self.child:SetPos(self:GetAttachment(self:LookupAttachment("leg_lower_R_attachment")).Pos)
					self.child:SetLocalPos(Vector(-5,-3,0))
					self.child:SetAngles(self:GetAngles()+Angle(0,0,90))
				end
			end
			timer.Simple(1,function()
				if self:IsValid() then
					if self.ReviverSpawned == true then
						if self.childs:IsValid() then
							self.childs:SetNoDraw(false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.childs:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.childs,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.childs,self.HostEmerge,75,100)
						end
					else
						if self.child:IsValid() then
							self.child:SetNoDraw(false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,1,false)
							self.child:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,.5)
							VJ_EmitSound(self.child,self.bingbongmarcos,75,100)
							VJ_EmitSound(self.child,self.HostEmerge,75,100)
						end
					end
					self.GodMode = false
				end
			end)
		end
	end)
end
-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base