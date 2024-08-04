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
/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
ENT.Model = {"models/combine_dropship.mdl"}
ENT.StartHealth = 700
ENT.TurningSpeed = 10
ENT.SightAngle = 100
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.VJ_IsHugeMonster = true
ENT.Aerial_AnimTbl_Calm = {"cargo_idle"}
ENT.Aerial_AnimTbl_Alerted = {"cargo_idle"}

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true
ENT.DisableDefaultRangeAttackCode = true
ENT.DisableRangeAttackAnimation = true
ENT.RangeAttackAngleRadius = 100
ENT.RangeDistance = 4000
ENT.RangeToMeleeDistance = 0
ENT.TimeUntilRangeAttackProjectileRelease = 0
ENT.NextRangeAttackTime = 6

ENT.Passive_RunOnTouch = false
ENT.Passive_RunOnDamage = false
ENT.Passive_AlliesRunOnDamage = false

ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.AA_GroundLimit = 500
ENT.Aerial_FlyingSpeed_Calm = 450
ENT.Aerial_FlyingSpeed_Alerted = 600

ENT.ConstantlyFaceEnemy = true
ENT.ConstantlyFaceEnemy_IfAttacking = true
ENT.ConstantlyFaceEnemyDistance = 10000

--ENT.SoundTbl_Breath = {"NPC_CombineDropship.NearRotorLoop"}
ENT.BreathSoundLevel = 90

ENT.DeathCorpseBodyGroup = VJ_Set(1, 1)

ENT.NextDustTime = 0
ENT.FlexForwardOutput = 0
ENT.NextSoldierTime = 18
ENT.SoldiersSpawned = 0
ENT.CurrentSoldierIdx = 1

local dropTables = {
	{
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_ar2"},
	{class="npc_vj_overwatch_shotgunner_z",weapon="weapon_vj_spas12_mk2_z"},
	{class="npc_vj_overwatch_elite_z",weapon="weapon_vj_ar2"},
	{class="npc_vj_overwatch_sniper_z",weapon="weapon_vj_combine_sniper_rifle_z"},
	},

	{
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_overwatch_soldier_z",weapon="weapon_vj_ar2"},
	{class="npc_vj_overwatch_shotgunner_z",weapon="weapon_vj_spas12_mk2_z"},
	{class="npc_vj_hunter2_z",weapon=""},
	{class="npc_vj_hunter2_z",weapon=""},
	},

	{
	{class="npc_vj_novaprospekt_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_novaprospekt_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_novaprospekt_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_novaprospekt_soldier_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_novaprospekt_soldier_z",weapon="weapon_vj_ar2"},
	{class="npc_vj_novaprospekt_soldier_z",weapon="weapon_vj_ar2"},
	{class="npc_vj_novaprospekt_shotgunner_z",weapon="weapon_vj_spas12_mk2_z"},
	},

	{
	{class="npc_vj_civil_protection_z",weapon="weapon_vj_stunstick_z"},
	{class="npc_vj_civil_protection_z",weapon="weapon_vj_9mmpistol"},
	{class="npc_vj_civil_protection_z",weapon="weapon_vj_9mmpistol"},
	{class="npc_vj_civil_protection_z",weapon="weapon_vj_9mmpistol"},
	{class="npc_vj_civil_protection_z",weapon="weapon_vj_smg1"},
	{class="npc_vj_civil_protection_elite_z",weapon="weapon_vj_mp5k_z"},
	{class="npc_vj_civil_protection_elite_z",weapon="weapon_vj_mp5k_z"},
	},

	{
	{class="npc_vj_rollermine_z",weapon=""},
	{class="npc_vj_rollermine_z",weapon=""},
	{class="npc_vj_rollermine_z",weapon=""},
	{class="npc_vj_rollermine_z",weapon=""},
	{class="npc_vj_rollermine_z",weapon=""},
	{class="npc_vj_rollermine_z",weapon=""},
	{class="npc_vj_rollermine_z",weapon=""},
	},

	{
	{class="npc_vj_rollermine_explosive_z",weapon=""},
	{class="npc_vj_rollermine_explosive_z",weapon=""},
	{class="npc_vj_rollermine_explosive_z",weapon=""},
	{class="npc_vj_rollermine_explosive_z",weapon=""},
	{class="npc_vj_rollermine_explosive_z",weapon=""},
	{class="npc_vj_rollermine_explosive_z",weapon=""},
	{class="npc_vj_rollermine_explosive_z",weapon=""},
	},

	{
	{class="npc_vj_vortigaunt_synth_z",weapon=""},
	{class="npc_vj_vortigaunt_synth_z",weapon=""},
	{class="npc_vj_vortigaunt_synth_z",weapon=""},
	{class="npc_vj_vortigaunt_synth_z",weapon=""},
	{class="npc_vj_vortigaunt_synth_z",weapon=""},
	},

	{
	{class="npc_vj_hunter2_z",weapon=""},
	{class="npc_vj_hunter2_z",weapon=""},
	{class="npc_vj_hunter2_z",weapon=""},
	},

	{
	{class="npc_vj_combine_apc_z",weapon=""},
	},

	{
	{class="npc_vj_overwatch_assassin_z",weapon="weapon_vj_assassin_pistols_z"},
	{class="npc_vj_overwatch_assassin_z",weapon="weapon_vj_assassin_pistols_z"},
	{class="npc_vj_overwatch_assassin_z",weapon="weapon_vj_assassin_pistols_z"},
	{class="npc_vj_assassin_synth_z",weapon=""},
	{class="npc_vj_assassin_synth_z",weapon=""},
	},

	{
	{class="npc_vj_strider_synth_z",weapon=""},
	},
}

function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("NOTE: Controlling is not really supported for this SNPC!!")

end

function ENT:CustomOnInitialize()

	local dropidx = math.Clamp(GetConVar("vj_zippycombines_dropship_snpcs"):GetInt(), 0,11)
	if dropidx == 0 then
		dropidx = math.random(1, 11)
	end
	self.DropTable = dropTables[dropidx]

	-- self.SoldierAmount = 7
	-- if dropidx == 7 then -- Vorts
	-- 	self.SoldierAmount = 5
	-- elseif dropidx == 8 then -- Hunters
	-- 	self.SoldierAmount = 3
	-- end

	timer.Simple(0,function() self:SetPos( self:GetPos() + Vector(0,0,200) ) end)

	self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("cargo_idle"))}
	--self:EmitSound( "NPC_CombineDropship.RotorLoop", 100, 100)

	if dropidx == 9 then
		self.APC = ents.Create("prop_dynamic")
		self.APC:SetModel("models/combine_apc.mdl")
		self.APC:SetParent(self)
		self.APC:SetPos(self:GetPos() - self:GetUp()*15)
		self.APC:SetAngles(self:GetAngles()+Angle(0,-90,0))

		self.DeployDist = 750

		self:SetCollisionBounds( Vector (160,160,150) , Vector (-160,-160,50) )
	elseif dropidx == 11 then
		self.Strider = ents.Create("prop_dynamic")
		self.Strider:SetModel("models/combine_strider.mdl")
		self.Strider:SetParent(self)
		self.Strider:SetPos(self:GetPos() - self:GetUp()*100)
		self.Strider:SetAngles(self:GetAngles())
		self.Strider:ResetSequence("carried")

		self.DeployDist = 1500

		self:SetCollisionBounds( Vector (160,160,150) , Vector (-160,-160,50) )
	else
		self.Container = ents.Create("prop_dynamic")
		self.Container:SetModel("models/combine_dropship_container.mdl")
		self.Container:SetParent(self)
		self.Container:SetPos(self:GetPos())
		self.Container:SetAngles(self:GetAngles())

		self.ContainerPhys = ents.Create("prop_dynamic")
		self.ContainerPhys:SetModel("models/props_wasteland/cargo_container01b.mdl")
		self.ContainerPhys:SetParent(self.Container)
		self.ContainerPhys:SetPos(self.Container:GetPos() + self.Container:GetForward() * -50 + self.Container:GetUp() * 15)
		self.ContainerPhys:SetAngles(self.Container:GetAngles() + Angle(0,90,0))
		self.ContainerPhys:SetNoDraw(true)
		self.ContainerPhys:DrawShadow(false)

		self.DeployDist = 1750

		self:SetCollisionBounds( Vector (75,100,200) , Vector (-150,-100,-40) )
	end

    self.AngleNoiseOffset = math.Rand(0, 2*math.pi)
    self.pitchAdd_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.rollAdd_NoiseSpeedOffset = math.Rand(0.9, 1.1)

    self.MoveNoiseOffset = math.Rand(0,2*math.pi)
    self.MoveX_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.MoveY_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.MoveZ_NoiseSpeedOffset = math.Rand(0.9, 1.1)

	self.CurrentAimPoseParamAng = Angle(0,0,0)

    self.EngineSound1 = CreateSound(self,"npc/combine_gunship/dropship_engine_distant_loop1.wav")
    self.EngineSound1:SetSoundLevel(130)
	self.EngineSound1:Play()
	self.EngineSound1:ChangePitch(90)
	self.EngineSound1:ChangeVolume(0.75)

    self.EngineSound2 = CreateSound(self,"npc/combine_gunship/dropship_onground_loop1.wav")
    self.EngineSound2:SetSoundLevel(100)
	self.EngineSound2:Play()
	self.EngineSound2:ChangePitch(110)

    self.ShootSound = CreateSound(self,"npc/combine_gunship/gunship_fire_loop1.wav")
    self.ShootSound:SetSoundLevel(130)

    self.AlarmSound = CreateSound(self,"npc/combine_gunship/dropship_dropping_pod_loop1.wav")
    self.AlarmSound:SetSoundLevel(120)
end

function ENT:MovementThink()

    local sin = math.sin
    local time = CurTime()

    local AngleNoiseSpeedMult = 2
    local pitchAdd_noise = sin(time*self.pitchAdd_NoiseSpeedOffset*AngleNoiseSpeedMult + self.AngleNoiseOffset) 
    local rollAdd_noise = sin(time*self.rollAdd_NoiseSpeedOffset*AngleNoiseSpeedMult + self.AngleNoiseOffset)

	if self.ContainerDeployed or self.IsDeployingContainer or self.DeployingAPC or self.DeployingStrider or self.StriderUnfolding then
		self:SetAngles(self.DeployAngle)
	else
    	self:SetAngles( self:GetAngles() + Angle(pitchAdd_noise*0.5, 0, rollAdd_noise*0.5) )
	end

    local MoveNoiseIntensity = 15
    local move_x_noise = sin(time*self.MoveX_NoiseSpeedOffset + self.MoveNoiseOffset) 
    local move_y_noise = sin(time*self.MoveY_NoiseSpeedOffset + self.MoveNoiseOffset) 
    local move_z_noise = sin(time*self.MoveZ_NoiseSpeedOffset + self.MoveNoiseOffset)

    if self.AA_CurrentMovePos or self.MovementType == VJ_MOVETYPE_STATIONARY then
        self:SetVelocity(  Vector(move_x_noise,move_y_noise,move_z_noise)*MoveNoiseIntensity )
    else
        self:SetLocalVelocity(  Vector(move_x_noise,move_y_noise,move_z_noise)*MoveNoiseIntensity )
    end

end

function ENT:CustomOnThink()

	self:MovementThink()

	if IsValid(self.Soldier) && self.ContainerDeployed && self.DropshipDropPoint && self.Soldier:GetPos():Distance(self.DropshipDropPoint) < 175 then

		local dir = (self.Soldier:GetPos() - self.DropshipDropPoint):GetNormalized()

		local soldierclass = self.Soldier:GetClass()

		if soldierclass != "npc_vj_rollermine_z" && soldierclass != "npc_vj_rollermine_explosive_z" then
			self.Soldier:SetVelocity( Vector(dir.x ,dir.y ,0) * 300 )
			self.Soldier:SetAngles(Angle(0,self.Container:GetAngles().y,0))
		end

	end

	-- local tr = util.TraceLine({
	-- start = self:GetPos(),
	-- endpos = self:GetPos() + self:GetUp() * -10000,
	-- mask = MASK_NPCWORLDSTATIC,
	-- })
	-- if self.NextDustTime != 0 then
	-- 	self.NextDustTime = self.NextDustTime - 1
	-- end
	-- if self:GetPos():Distance(tr.HitPos) <= 400 && self.NextDustTime == 0 then
	-- 	if !self.CloseToGround then
	-- 		self.CloseToGround = true
	-- 		self:EmitSound("NPC_CombineDropship.OnGroundRotorLoop", 100, 100)
	-- 	end
	-- 	self.NextDustTime = 2
	-- 	local effectdata = EffectData()
	-- 	effectdata:SetOrigin(tr.HitPos)
	-- 	effectdata:SetEntity( self )
	-- 	effectdata:SetScale( 90 )
	-- 	util.Effect( "ThumperDust", effectdata )
	-- elseif self:GetPos():Distance(tr.HitPos) > 400 && self.CloseToGround then
	-- 	self.CloseToGround = false
	-- 	self:EmitSound("NPC_CombineDropship.OnGroundRotorLoop", 100, 100, 1, CHAN_AUTO, SND_STOP)
	-- end

end

function ENT:IsOnGroundCheck()

	self.DroppingContainer = true
	timer.Simple(1.5,function() if IsValid(self) then

		local center = self:OBBCenter()
		local OBBmins = self:OBBMins() * 0.66
		local OBBmaxs = self:OBBMaxs() * 0.66

		local tr_FINAL = util.TraceHull({
			start = self:GetPos() + Vector(center.x,center.y,center.z),
			endpos = self:GetPos() + Vector(center.x,center.y,center.z - 110),
			mins = OBBmins,
			maxs = OBBmaxs,
			filter = self,
		})

		if tr_FINAL.HitWorld or self:IsOnGround() then

			--print("tr_FINAL.HitWorld: " .. tostring(tr_FINAL.HitWorld))
			--print("self:IsOnGround(): " .. tostring(self:IsOnGround()))

			self.Behavior = VJ_BEHAVIOR_PASSIVE
			self:SetCollisionBounds( Vector (160,160,150) , Vector (-160,-160,50) )
			self.Container:ResetSequence(self.Container:LookupSequence("open"))
			self.ContainerDeployed = true
			self.IsDeployingContainer = false
			self.Container:SetParent(nil)
			self:VJ_ACT_PLAYACTIVITY("idle",true,1,false)
			self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("idle"))}
			self.Aerial_AnimTbl_Calm = {"idle"}
			self.Aerial_AnimTbl_Alerted = {"idle"}
			--ZIPPYCOMBINES_FadeAndRemove(self.Container,30)
	else
		self.DroppingContainer = false
	end
	end end)

end

local strider_deploydist_ground = 625

function ENT:DeployFinish()

	self.AlarmSound:Stop()
	self.ContainerDeployed = false
	self.ContainerUsed = true
	self.DropshipDropPoint = nil

	if self.Container then
		self.Container:ResetSequence(self.Container:LookupSequence("close"))
		self.Container:SetParent(self)
		self.Container:SetPos(self:GetPos())
		self.Container:SetAngles(self:GetAngles())
		self.ContainerPhys:Remove()
		self:VJ_ACT_PLAYACTIVITY("cargo_idle",true,1,false)
		self.MovementType = VJ_MOVETYPE_AERIAL
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("cargo_idle"))}
		self.Aerial_AnimTbl_Calm = {"cargo_idle"}
		self.Aerial_AnimTbl_Alerted = {"cargo_idle"}
	end

	if self.APC then
		local apcNPC = ents.Create("npc_vj_combine_apc_z")
		apcNPC:SetPos(self.APC:GetPos())
		apcNPC:SetAngles(self.APC:GetAngles() + Angle(0,90,0))
		apcNPC.VJ_NPC_Class = self.VJ_NPC_Class
		apcNPC:Spawn()
		self.APC:Remove()
		self.DeployingAPC = false
		self:VJ_ACT_PLAYACTIVITY("idle",true,1,false)
		self.MovementType = VJ_MOVETYPE_AERIAL
		self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("idle"))}
		self.Aerial_AnimTbl_Calm = {"idle"}
		self.Aerial_AnimTbl_Alerted = {"idle"}
		self:SetVelocity(Vector(0,0,100))
	elseif self.Strider then
		local duration = 5

		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos()-Vector(0,0,strider_deploydist_ground),
			mask = MASK_NPCWORLDSTATIC,
		})

		local striderNPC = ents.Create("npc_vj_strider_synth_z")
		striderNPC:SetPoseParameter("body_height",500)
		striderNPC:SetPos(tr.HitPos)
		striderNPC:SetAngles(Angle(0,self.Strider:GetAngles().y,0))
		striderNPC.VJ_NPC_Class = self.VJ_NPC_Class
		striderNPC:Spawn()
		striderNPC:VJ_ACT_PLAYACTIVITY("deploy",true,duration,false)
		striderNPC.IsBeingDroppedByDropship = true
		striderNPC:SetNoDraw(true)

		timer.Simple(0.2, function() if IsValid(striderNPC) && IsValid(self) then striderNPC:SetNoDraw(false) self.Strider:Remove() end end)

		self.StriderUnfolding = true
		timer.Simple(duration-2, function() if IsValid(striderNPC) && IsValid(self) then
			self.StriderUnfolding = false
			self.MovementType = VJ_MOVETYPE_AERIAL
			self:VJ_ACT_PLAYACTIVITY("idle",true,1,false)
			self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("idle"))}
			self.Aerial_AnimTbl_Calm = {"idle"}
			--striderNPC:EmitSound("NPC_Strider.Footstep")
		end end)

		timer.Simple(duration, function() if IsValid(striderNPC) then striderNPC.IsBeingDroppedByDropship = false end end)

		self.DeployingStrider = false

		--self:SetVelocity(Vector(0,0,100))
	end

	local fadetime = GetConVar("vj_zippycombines_dropship_fadetime"):GetInt()
	if fadetime > -1 then
		ZIPPYCOMBINES_FadeAndRemove(self,fadetime)
		if self.Container then
			ZIPPYCOMBINES_FadeAndRemove(self.Container,fadetime)
		end
	end

end

function ENT:CustomOnThink_AIEnabled()

	if self.ContainerDeployed then
		local dist = self:GetPos():Distance(self.Container:GetPos())

		if dist < 40 then
			self:SetVelocity(Vector(0,0,18))
		else
			self.PosAquired = true
		end

		if self.PosAquired then
			self:SetVelocity(-self:GetVelocity()*0.3)
		end
	elseif self.DeployingStrider or self.StriderUnfolding then
		self:SetVelocity(-self:GetVelocity()*0.3)
	end

	local tr_startdeploy = util.TraceHull({
	start = self:GetPos(),
	endpos = self:GetPos() + self:GetUp() * -10000,
	mask = MASK_NPCWORLDSTATIC,
	})

	if ((IsValid(self:GetEnemy()) && self:GetEnemy():GetPos():Distance(self:GetPos()) < self.DeployDist)) && (math.abs(self:GetEnemy():GetPos().z - tr_startdeploy.HitPos.z) < 200 or self:GetEnemy().MovementType == VJ_MOVETYPE_AERIAL) && !(self.IsDeployingContainer or self.DeployingAPC or self.DeployingStrider) && !self.ContainerDeployed && !self.ContainerUsed then
		local yaw_difference = self:WorldToLocalAngles( ( self:GetEnemy():GetPos()-self:GetPos() ):Angle() ).y
		
		if math.abs(yaw_difference) < 22.5 then
			self.MovementType = VJ_MOVETYPE_STATIONARY
			self.Behavior = VJ_BEHAVIOR_PASSIVE
			self.ConstantlyFaceEnemy = false
			self.ConstantlyFaceEnemy_IfAttacking = false
			self.ConstantlyFaceEnemyDistance = 0
			self.CombatFaceEnemy = false -- If enemy exists and is visible
			self.DeployAngle = Angle(0,self:GetAngles().y,0)
			self.AlarmSound:Play()
			self.AlarmSound:ChangePitch(math.random(105,115))

			if self.APC then
				self.DeployingAPC = true
			elseif self.Strider then
				self.DeployingStrider = true
			else
				self.IsDeployingContainer = true
			end

		end
	end
	if self.IsDeployingContainer or self.DeployingAPC or self.DeployingStrider then

		local tr_too_close_for_strider = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos()-Vector(0,0,strider_deploydist_ground*0.75),
			mask = MASK_NPCWORLDSTATIC,
		})

		local downspeed = 4
		if self.DeployingStrider then

			if tr_too_close_for_strider.Hit then
				downspeed = -8 -- Go up if strider is too close to ground
			else
				downspeed = 8
			end
		elseif self.DeployingAPC then
			downspeed = 8
		end

		self:SetVelocity(Vector(-self:GetVelocity().x,-self:GetVelocity().y,-downspeed))

		if self.IsDeployingContainer && !self.DroppingContainer then
			self:IsOnGroundCheck()
		end

		if self.APC then
			local deploydist_ground = 100
			local tr = util.TraceEntity({start = self.APC:GetPos(), endpos = self.APC:GetPos()-Vector(0,0,deploydist_ground), mask=MASK_NPCWORLDSTATIC}, self.APC)
			if tr.HitWorld then
				self:DeployFinish()
			end
		elseif self.Strider then
			local tr = util.TraceLine({
				start = self:GetPos(),
				endpos = self:GetPos()-Vector(0,0,strider_deploydist_ground),
				mask = MASK_NPCWORLDSTATIC,
			})
			if tr.Hit && !tr_too_close_for_strider.Hit then
				self:DeployFinish()
			end
		end

	end


	if self.Container then
		if self.NextSoldierTime != 0 && self.ContainerDeployed then
			self.NextSoldierTime = self.NextSoldierTime - 1
		end
		if self.ContainerDeployed && self.NextSoldierTime == 0 && self.SoldiersSpawned < table.Count(self.DropTable) then
			
			self.DropshipDropPoint = self.Container:GetPos()

			local SoldierType = self.DropTable[self.CurrentSoldierIdx].class

			self.Soldier = ents.Create(SoldierType)
			self.Soldier:SetPos(self.Container:GetPos() - Vector(0,0,30))
			self.Soldier:SetAngles(Angle(0,self.Container:GetAngles().y,0))
			self.Soldier.IsBeingDroppedByDropship = true
			self.Soldier:Spawn()
			--self.Soldier.CanFlinch = 0
			self.ContainerPhys:SetSolid(SOLID_VPHYSICS)
			timer.Simple(2,function() if IsValid(self.Soldier) then self.Soldier.IsBeingDroppedByDropship = false end end)
			timer.Simple(1.5,function() if IsValid(self.ContainerPhys) then self.ContainerPhys:SetSolid(SOLID_NONE) end end)
			self.Soldier.VJ_NPC_Class = self.VJ_NPC_Class

			local wep = self.DropTable[self.CurrentSoldierIdx].weapon
			if wep != "" then
				self.Soldier:Give(wep)
			end

			if SoldierType == "npc_vj_rollermine_z" or SoldierType == "npc_vj_rollermine_explosive_z" then
				self.Soldier:RollTo(self.Container:GetPos() + self.Container:GetForward() * 400, 1.5, true)
				self.Soldier:SetPos(self.Container:GetPos() + Vector(0,0,15))
			elseif SoldierType == "npc_vj_hunter2_z" then
				self.Soldier:VJ_ACT_PLAYACTIVITY("jump_rail",true,3,false)
				self.Soldier:SetVelocity(self.Soldier:GetForward() * 200 + Vector(0,0,100))
			elseif SoldierType == "npc_vj_vortigaunt_synth_z" then
				self.Soldier:VJ_ACT_PLAYACTIVITY("jump_down128",true,3,false)
				self.Soldier:SetVelocity(self.Soldier:GetForward() * 100 + Vector(0,0,50))
			elseif SoldierType == "npc_vj_overwatch_assassin_z" or SoldierType == "npc_vj_assassin_synth_z" then
				if SoldierType == "npc_vj_assassin_synth_z" then
					self.Soldier:VJ_ACT_PLAYACTIVITY("falling",true,0.4,false)
				else
					self.Soldier:VJ_ACT_PLAYACTIVITY("jumploop",true,0.4,false)
				end
				self.Soldier:SetVelocity(self.Soldier:GetForward() * 150 + Vector(0,0,75))
			else
				self.Soldier:VJ_ACT_PLAYACTIVITY("dropship_deploy",true,2,false)
			end
		
			self.SoldiersSpawned = self.SoldiersSpawned + 1
			self.NextSoldierTime = 18
			self.CurrentSoldierIdx = self.CurrentSoldierIdx + 1
		elseif self.SoldiersSpawned >= table.Count(self.DropTable) && self.NextSoldierTime == 0 && !self.ContainerUsed then

			self:DeployFinish()

		end
	end


	-- for _,v in pairs( ents.FindByClass("npc_vj_dropship_z") ) do
	-- 	if v != self && v:GetPos():Distance(self:GetPos()) < 500 then
	-- 		self:SetVelocity((self:GetPos() - v:GetPos()) * (40 / self:GetPos():Distance(v:GetPos())))
	-- 	end
	-- end


	local FlySpeed = self.Aerial_FlyingSpeed_Alerted
	if math.floor(self:GetVelocity():Distance(self:GetForward() * FlySpeed)) == FlySpeed or
	math.ceil(self:GetVelocity():Distance(self:GetForward() * FlySpeed)) == FlySpeed then
		self.FlexForwardInput = 0.3
	else
		self.FlexForwardInput = 1.3 - (self:GetVelocity():Distance(self:GetForward() * FlySpeed) / FlySpeed)
	end
	if self.FlexForwardInput > 0 then
		self.FlexForwardOutput = math.Clamp(self.FlexForwardOutput + 0.1,-1,self.FlexForwardInput)
	else
		self.FlexForwardOutput = math.Clamp(self.FlexForwardOutput - 0.1,self.FlexForwardInput,1)
	end
	self:SetPoseParameter("cargo_body_accel", self.FlexForwardOutput)


	if self.Container then
		if self.IsShooting && IsValid(self:GetEnemy()) && self.Container:GetParent() == self then
			if !self.HasStartedShooting then
				self.ShootSound:Play()
				self.ShootSound:ChangePitch(math.random(80,90))
				self.HasStartedShooting = true
			end
			local expLight = ents.Create("light_dynamic")
			expLight:SetKeyValue("brightness", "5")
			expLight:SetKeyValue("distance", "250")
			expLight:Fire("Color", "0 75 255")
			expLight:SetPos(self.Container:GetAttachment(3).Pos)
			expLight:Spawn()
			expLight:Activate()
			expLight:SetParent(self.Container,3)
			expLight:Fire("TurnOn", "", 0)
			timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
			self:DeleteOnRemove(expLight)
			ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self.Container,3)
			local bullet = {
			Src = self.Container:GetAttachment(3).Pos,
			Dir = (self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter() ) - self.Container:GetAttachment(3).Pos,
			Spread = Vector(100 / (self.RangeDistance / self:GetEnemy():GetPos():Distance(self:GetPos())),100 / (self.RangeDistance / self:GetEnemy():GetPos():Distance(self:GetPos())),0),
			Damage = 4,
			Force = 50,
			TracerName = "AR2Tracer",
			-- Callback = function(attacker, tracer)
			-- 	local effectdata = EffectData()
			-- 	effectdata:SetOrigin(tracer.HitPos)
			-- 	effectdata:SetNormal(tracer.HitNormal)
			-- 	effectdata:SetRadius( 5 )
			-- 	util.Effect( "cball_bounce", effectdata )
			-- end,
			}
			self.Container:FireBullets(bullet)
			--self:EmitSound( "Weapon_AR2.NPC_Single", 100, 100, 0.25, CHAN_AUTO )
		elseif self.IsShooting && (self.Container:GetParent() != self or !IsValid(self:GetEnemy())) then
			self.IsShooting = false
			self.HasStartedShooting = false
			self:EmitSound( "NPC_CombineGunship.CannonStopSound", 100, 100)
			self.ShootSound:Stop()
		end
	end

end

function ENT:CustomRangeAttackCode()
	if !self.Container then return end
	self:EmitSound( "NPC_CombineGunship.CannonStartSound", 100, 100)

	self.AttackDuration = math.random(2,4)
	timer.Simple(1,function() if IsValid(self) then self.IsShooting = true end end)
	timer.Simple(self.AttackDuration,function() if IsValid(self) && self.IsShooting then
		self.ShootSound:Stop()
		self.IsShooting = false
		self.HasStartedShooting = false
	end end)

end

function ENT:CustomOn_PoseParameterLookingCode(pitch, yaw, roll)
	self.CurrentAimPoseParamAng = LerpAngle(0.33, self.CurrentAimPoseParamAng, Angle(pitch, yaw, roll))

	-- if self.Behavior == VJ_BEHAVIOR_AGRESSIVE then
	-- 	self:SetPoseParameter("cargo_body_sway",self.CurrentAimPoseParamAng.y/90)
	-- else
	-- 	self:SetPoseParameter("cargo_body_sway",0)
	-- end

	if IsValid(self.Container) && self.Container:GetParent() == self then
		self.Container:SetPoseParameter("weapon_pitch",-self.CurrentAimPoseParamAng.x)
		self.Container:SetPoseParameter("weapon_yaw",self.CurrentAimPoseParamAng.y)
	end
end

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

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	if dmginfo:IsExplosionDamage() then
		self:DoSpark(dmginfo:GetDamagePosition(), 6)
	elseif dmginfo:IsBulletDamage() then
		dmginfo:SetDamage(0)
	else
		self:DoSpark(dmginfo:GetDamagePosition(), 2)
		dmginfo:SetDamage(dmginfo:GetDamage()*0.25)
	end

end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)

	corpseEnt:EmitSound("NPC_CombineGunship.Explode", 120, 100)
	ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0))
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )
	self:EmitSound( "Explo.ww2bomb", 130, 100)

	if IsValid(self.Container) then
		ParticleEffect("vj_explosion1", self.Container:GetPos(), Angle(0,0,0))
		self:CreateGibEntity("obj_vj_gib","models/container_chunk01.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk02.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk03.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk04.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk05.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk01.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk02.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk03.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk04.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/container_chunk05.mdl",{BloodType = "",Pos = self.Container:GetPos(), CollideSound = {"SolidMetal.ImpactSoft"}})
	end

	if IsValid(self.APC) then
		ParticleEffect("vj_explosion1", self.APC:GetPos(), Angle(0,0,0))
		self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib01.mdl",{Pos = self.APC:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*100, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib02.mdl",{Pos = self.APC:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib03.mdl",{Pos = self.APC:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib04.mdl",{Pos = self.APC:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib05.mdl",{Pos = self.APC:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
	end

	if IsValid(self.Strider) then
		ParticleEffect("vj_explosion1", self.Strider:GetPos(), Angle(0,0,0))
		ParticleEffect( "striderbuster_explode_goop", self.Strider:GetPos(), self:GetAngles() )
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib1.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib2.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib3.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib4.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib5.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib6.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib7.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})

		self:CreateGibEntity("prop_ragdoll","models/gibs/strider_head.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("prop_ragdoll","models/gibs/strider_weapon.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		
		self:CreateGibEntity("prop_ragdoll","models/gibs/strider_back_leg.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("prop_ragdoll","models/gibs/strider_left_leg.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("prop_ragdoll","models/gibs/strider_right_leg.mdl",{Pos = self.Strider:GetPos(), BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
	end
end

function ENT:CustomOnRemove()

	if IsValid(self.Container) && self.Container:GetParent() != self && !self.ContainerUsed then
		self.Container:Remove()
	end

	self.EngineSound1:Stop()
	self.EngineSound2:Stop()
	self.ShootSound:Stop()
	self.AlarmSound:Stop()

end
/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/