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
ENT.Model = {"models/combine_apc2.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1100
ENT.SquadName = "combine" 
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 5000 -- How far it can see
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.CanTurnWhileStationary = false -- If set to true, the SNPC will be able to turn while it's a stationary SNPC
ENT.FindEnemy_UseSphere = true
ENT.DeathEntityType = "apchl2_hull" 
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.PlayerFriendly = false
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.DisableRangeAttackAnimation = false -- if true, it will disable the animation code
ENT.AnimTbl_RangeAttack = {"fire"} -- Range Attack Animations
ENT.RangeDistance = 3200 -- This is how far away it can shoot
ENT.WaitBeforeDeathTime = 0
ENT.RangeToMeleeDistance = 1 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 180 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.TimeUntilRangeAttackProjectileRelease = 0.1 -- How much time until the projectile code is ran?
ENT.RangeAttackReps = 4 -- How many times does it run the projectile code?
ENT.NextRangeAttackTime = 0.1 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.2 -- How much time until it can use any attack again? | Counted in Seconds
ENT.AllowIgnition = false -- Can this SNPC be set on fire?
ENT.Immune_Physics = true -- Immune to Physics
ENT.Immune_Bullet = true -- Immune to Bullets
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation
ENT.ImmuneDamagesTable = {DMG_BULLET,DMG_BUCKSHOT,DMG_PHYSGUN,DMG_AIRBOAT,DMG_AIRBOAT,DMG_SLASH,DMG_CRUSH  }

-- Tank Base
ENT.Tank_GunnerENT = ""
ENT.Tank_SpawningAngle = 360
ENT.Tank_CollisionBoundSize = 0
ENT.Tank_CollisionBoundUp = 0
ENT.Tank_AngleDiffuseNumber = 0 --270
ENT.Tank_ForwardSpead = 450 -- Forward speed
ENT.Tank_MoveAwaySpeed = 450 -- Move away speed
ENT.Tank_UseGetRightForSpeed = false -- Should it use GetRight instead of GetForward when driving?
ENT.Tank_SeeFar = 2250 -- If the enemy is higher than this number, than don't shoot!
ENT.Tank_SeeLimit = 5000 -- How far can it see?
ENT.Tank_SeeClose = 250 -- If the enemy is closer than this number, than move!
ENT.Tank_TurningSpeed = 4.75
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Breath = {"vehicles/apc/apc_idle1.wav"}
ENT.SoundTbl_Death = {"weapons/expode3.wav"}

-- Custom
ENT.LAV_CurrentParameter = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup) 

end
function ENT:Tank_GunnerSpawnPosition2()
	return self:GetPos() +self:GetUp()*30 +self:GetRight()*0 +self:GetForward()*0
end
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.apc_movingsd)
	if self.Gunner:IsValid() then
	self.Gunner:Remove()
	end
end


---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.Gunner = ents.Create("npc_hl2_apc_rocket")
	self.Gunner:Spawn()
	self.Gunner:SetPos(self:Tank_GunnerSpawnPosition2())
	self.Gunner:SetAngles(self:GetAngles())
	self.Gunner:SetParent( self )
	self:PhysicsInit( SOLID_BBOX )
	self:SetAngles(self:GetAngles()+Angle(0,self.Tank_SpawningAngle,0))
	self:SetCollisionBounds(Vector(135, 80, 85), Vector(-135, -80, -7.35))
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(12000)
	end
	self.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
	self.DeathCorpseEntityClass = self.DeathEntityType -- The entity class it creates | "UseDefaultBehavior" = Let the base automatically detect the type
    local WheelPos = Vector( 0, 0, 0 )
	
		self.damage_showsmoke = 0
	self.damage_showfire = 0

	self.radiotalking = 0
	self.combatidletalkingtimer = 0
	self.combatreinforcetimer = 0
	self.KT_NextSoldierSpawnT = 0
	self.KT_GoingToSpawnThem = false
	self.KT_Spawnedsoldier = 0
	self.rancombatreinforce = 0
	
	self.gunnerlastangles = 0
	self.gunnerlastgunlevel = 0
	self.damage_showsmokes = 0
	self.driving = 0
	self.nostopdriving = 0
	self.nostopdrivingwhenfrontblocked = 0
	self.IsBlockedOnTheFront = 0
	self.targetpath1 = 0	--Vector to move to

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local parameter = self:GetPoseParameter("aim_yaw")
	if parameter != self.LAV_CurrentParameter then
		self.lav_turningsd = CreateSound(self, "vehicles/apc/apc_idle1.wav") 
		self.lav_turningsd:SetSoundLevel(80)
		self.lav_turningsd:PlayEx(70,100)
	else
		VJ_STOPSOUND(self.lav_turningsd)
	end
	self.LAV_CurrentParameter = parameter
	
		local phys_Tank_fix = self.Entity:GetPhysicsObject()
	if phys_Tank_fix:IsValid() && phys_Tank_fix:GetVelocity():Length() < 5 then
		phys_Tank_fix:AddVelocity(self:GetUp():GetNormal()*9)
	end

	if GetConVarNumber("vj_npc_noidleparticle") == 1 then return end
	if self.damage_showfire == 0 then
	if self:Health() <= self:GetMaxHealth()*0.8 then 
 	local corpsess = ents.Create("prop_physics")
	corpsess:SetModel("models/Gibs/helicopter_brokenpiece_01.mdl")
	corpsess:SetPos(self:GetPos() +self:GetUp()*90 +self:GetRight()*-30)
	corpsess:SetAngles(self:GetAngles())
	corpsess:Spawn()
	corpsess:SetColor(self:GetColor())
	corpsess:SetMaterial(self:GetMaterial())
	corpsess:GetPhysicsObject():AddVelocity( Vector( math.Rand( -600, 600 ), math.Rand( -600, 600 ), 100 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess:SetCollisionGroup(1) else corpsess:SetCollisionGroup(0) end
	corpsess:Ignite( math.Rand( 8, 10 ), 0 )
	if self.Fadecorpsess == true then corpsess:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end	
		self.damage_showfire = 1
	self.dmgexplo_position1 = self:GetPos()
	
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter())
		effectdata:SetScale(190) 
		util.Effect( "Explosion", effectdata )

	self:EmitSound("weapons/expode4.wav",85,100)
	util.BlastDamage(self,self,self.dmgexplo_position1,120,40)
	local effectdata = EffectData()
	effectdata:SetOrigin(self.dmgexplo_position1) -- the vector of were you want the effect to spawn
	util.Effect( "Explosion", effectdata )
	util.Effect( "Explosion", effectdata )
	local effectdata2 = EffectData()
	effectdata2:SetOrigin(self.dmgexplo_position1) -- the vector of were you want the effect to spawn
	effectdata2:SetScale( 500 ) -- how big the particles are, can even be 0.1 or 0.6
	util.Effect( "HelicopterMegaBomb", effectdata2 ) -- Add as many as you want
	self:VJ_ACT_PLAYACTIVITY("flinchhead",true,self.DeathFlinchTime,false,0,{SequenceDuration=self.DeathFlinchTime})
	end

	end
	if self.damage_showsmoke == 0 then
	if self:Health() <= self:GetMaxHealth()*0.5 then 
			self.damage_showsmoke = 1
 	local corpsess3 = ents.Create("prop_physics")
	corpsess3:SetModel("models/Gibs/helicopter_brokenpiece_02.mdl")
	corpsess3:SetPos(self:GetPos() +self:GetUp()*90 +self:GetRight()*-30)
	corpsess3:SetAngles(self:GetAngles())
	corpsess3:Spawn()
	corpsess3:SetColor(self:GetColor())
	corpsess3:SetMaterial(self:GetMaterial())
	corpsess3:GetPhysicsObject():AddVelocity( Vector( math.Rand( -600, 600 ), math.Rand( -600, 600 ), 100 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess3:SetCollisionGroup(1) else corpsess3:SetCollisionGroup(0) end
	corpsess3:Ignite( math.Rand( 8, 10 ), 0 )
	if self.Fadecorpsess == true then corpsess3:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess3:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end
	
	self.dmgexplo_position2 = self:GetPos()
			local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter()) -- the vector of were you want the effect to spawn
		effectdata:SetScale(190) -- how big the particles are, can even be 0.1 or 0.6
		util.Effect( "Explosion", effectdata )
	self:EmitSound("weapons/expode4.wav",85,100)
	util.BlastDamage(self,self,self.dmgexplo_position2,120,40)
	local effectdata = EffectData()
	effectdata:SetOrigin(self.dmgexplo_position2) -- the vector of were you want the effect to spawn
	util.Effect( "Explosion", effectdata )
	util.Effect( "Explosion", effectdata )
	local effectdata2 = EffectData()
	effectdata2:SetOrigin(self.dmgexplo_position2) -- the vector of were you want the effect to spawn
	effectdata2:SetScale( 500 ) -- how big the particles are, can even be 0.1 or 0.6
	util.Effect( "HelicopterMegaBomb", effectdata2 ) -- Add as many as you want
	end

	end
		if self.damage_showsmokes == 0 then
		
	if self:Health() < (self.StartHealth*0.3) then
				self.damage_showsmokes = 1

			self.Spark1 = ents.Create("env_spark")
			self.Spark1:SetKeyValue("MaxDelay",0.01)
			self.Spark1:SetKeyValue("Magnitude","8")
			self.Spark1:SetKeyValue("Spark Trail Length","3")
			self:GetNearDeathSparkPositions()
			self.Spark1:SetAngles(self:GetAngles())
			self.Spark1:SetParent(self)
			self.Spark1:Spawn()
			self.Spark1:Activate()
			self.Spark1:Fire("StartSpark", "", 0)
			self.Spark1:Fire("kill", "", 0.1)
			self:DeleteOnRemove(self.Spark1)	
 	local corpsess2 = ents.Create("prop_physics")
	corpsess2:SetModel("models/Gibs/helicopter_brokenpiece_03.mdl")
	corpsess2:SetPos(self:GetPos() +self:GetUp()*90 +self:GetRight()*-30)
	corpsess2:SetAngles(self:GetAngles())
	corpsess2:Spawn()
	corpsess2:SetColor(self:GetColor())
	corpsess2:SetMaterial(self:GetMaterial())
	corpsess2:GetPhysicsObject():AddVelocity( Vector( math.Rand( -600, 600 ), math.Rand( -600, 600 ), 100 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess2:SetCollisionGroup(1) else corpsess2:SetCollisionGroup(0) end
	corpsess2:Ignite( math.Rand( 8, 10 ), 0 )
	if self.Fadecorpsess == true then corpsess2:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess2:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end			
						local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter()) 
		effectdata:SetScale(190) 
		util.Effect( "Explosion", effectdata )
	self:EmitSound("weapons/expode4.wav",85,100)
			self.Tank_NextLowHealthSmokeT = CurTime() + math.random(4,6)

	end
end
end
function ENT:GetNearDeathSparkPositions()
	local randpos = math.random(1,7)
	if randpos == 1 then return self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*90 +self:GetUp()*60 +self:GetRight()*-40) else
	if randpos == 2 then return self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*50 +self:GetUp()*50 +self:GetRight()*40) end
	if randpos == 3 then return self.Spark1:SetLocalPos(self:GetPos()+self:GetUp()*90 +self:GetRight()*40 +self:GetForward()*20) end 
	if randpos == 4 then return self.Spark1:SetLocalPos(self:GetPos()+self:GetUp()*90 +self:GetRight()*60) end
	if randpos == 5 then return self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*30 +self:GetUp()*70 +self:GetRight()*70) end
	if randpos == 6 then return self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*80 +self:GetUp()*40 +self:GetRight()*30) end
	if randpos == 7 then return self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*60 +self:GetUp()*70 +self:GetRight()*50) end
	end
end

function ENT:APC_RUNOVER_DAMAGECODE(argent)
// if self.HasMeleeAttack == false then return end
if argent == NULL or argent == nil then return end
if GetConVarNumber("vj_npc_nomelee") == 1 then return end

local function Tank_DoDamage()
	if GetConVarNumber("vj_npc_dif_normal") == 1 then argent:TakeDamage(8,self,self) end -- Normal
	if GetConVarNumber("vj_npc_dif_easy") == 1 then argent:TakeDamage(8 /2,self,self) end -- Easy
	if GetConVarNumber("vj_npc_dif_hard") == 1 then argent:TakeDamage(8 *1.5,self,self) end -- Hard
	if GetConVarNumber("vj_npc_dif_hellonearth") == 1 then argent:TakeDamage(8 *2.5,self,self) end  -- Hell On Earth
	VJ_DestroyCombineTurret(self,argent)
	argent:SetVelocity(self:GetForward()*-800)
end

	if (argent:IsNPC() && argent:Disposition(self) == 1 && argent:Health() > 0) then
	if !argent:IsPlayer() && argent.IsVJBaseSNPC == true && argent.VJ_IsHugeMonster == false then
		Tank_DoDamage()
		self:APC_RUNOVER_SOUND()
	end
	if (argent:IsNPC() && argent.IsVJBaseSNPC != true && !table.HasValue(self.TankTbl_DontRunOver,argent:GetClass())) or (argent:IsPlayer() && self.PlayerFriendly == false && GetConVarNumber("ai_ignoreplayers") == 0 && argent:Alive() && self.Tank_IsMoving == true) then
		Tank_DoDamage()
		self:APC_RUNOVER_SOUND()
	end
 end
end

function ENT:Tank_GunnerSpawnPosition()
	return self:LocalToWorld( Vector( 2.11, 0.3, 57.4 ) )  --self:GetPos() +self:GetUp()*60 +self:GetRight()*0 +self:GetForward()*-0.5 ---50 --+self:GetUp()*-1 --+self:GetRight()*-3.5 +self:GetForward()*-5
end

function ENT:Tank_GunnerSpawnPosition2()
	return self:GetPos() +self:GetUp()*30 +self:GetRight()*0 +self:GetForward()*0
end

function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.Tank_movingsd)

end

function ENT:APC_MOVINGSOUND()
	if self.HasSounds == true && GetConVarNumber("vj_npc_sd_footstep") == 0 then
	self.Tank_movingsd = CreateSound(self,"apc_firstgear_loop1.ogg") self.Tank_movingsd:SetSoundLevel(80)
	
	self.Tank_movingsd:PlayEx(1,100)
	end
end

function ENT:CustomOnSchedule()
	if self:Health() <= 0 or self.Dead == true then return end

	self:IdleSoundCode()

	if self:GetEnemy() == nil then
		if self.Tank_ResetedEnemy == false then
		self.Tank_ResetedEnemy = true
		self:ResetEnemy() end
	else
		EnemyPos = self:GetEnemy():GetPos()
		EnemyPosToSelf = self:GetPos():Distance(EnemyPos)
		if EnemyPosToSelf > self.Tank_SeeLimit then -- If larger than this number than, move
			self.Tank_Status = 0
			
		elseif EnemyPosToSelf < self.Tank_SeeFar && EnemyPosToSelf > self.Tank_SeeClose then -- If between this two numbers, stay still
			self.Tank_Status = 1
			
		else
			self.Tank_Status = 0
		end
	end
end

function ENT:CustomOnThink_AIEnabled()
	if self.Dead == true then return end
	//timer.Simple(0.1, function() if self.Dead == false then ParticleEffect("smoke_exhaust_01",self:LocalToWorld(Vector(150,30,30)),Angle(0,0,0),self) end end)
	//timer.Simple(0.2, function() if self.Dead == false then self:StopParticles() end end)
	for _, v in pairs(ents.FindInSphere(self:GetPos(),100)) do
		self:Tank_RunOver(v)
	end

	local tr = util.TraceEntity({start = self:GetPos(), endpos = self:GetPos() + self:GetUp()*-5, filter = self}, self)
	if (tr.Hit) then // HitWorld
		local phys = self:GetPhysicsObject()
		if IsValid(phys) && phys:GetVelocity():Length() > 10 && self.Tank_Status == 0 then -- Moving
			self.Tank_IsMoving = true
			self:Tank_Sound_Moving()
			self:StartMoveEffects()
		else -- Not moving
			VJ_STOPSOUND(self.tank_movingsd)
			VJ_STOPSOUND(self.tank_tracksd)
			self.Tank_IsMoving = false
		end
	end
	if (!tr.Hit) then -- Not moving
		VJ_STOPSOUND(self.tank_movingsd)
		VJ_STOPSOUND(self.tank_tracksd)
		self.Tank_IsMoving = false
	end

	self:CustomOnSchedule()

	if self.Tank_Status == 0 && tr.Hit then
		if !IsValid(self:GetEnemy()) then
			self.Tank_Status = 1
		else
			//print((self:GetEnemy():GetPos() -self:GetPos() +Vector(0,0,80)):Angle())
			-- To make it go opposite:
				-- Change the +15 to -15 and -15 to 15
				-- Change the forwad spead(Tank_ForwardSpead) to their opposite quotation(+ to -)
				-- Change the turning speed(Tank_TurningSpeed) to their opposite quotation(+ to -)
			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				local Angle_Enemy = (self:GetEnemy():GetPos() - self:GetPos() +Vector(0,0,80)):Angle()
				local Angle_Current = self:GetAngles()
				local Angle_Diffuse = self:AngleDiffuse(Angle_Enemy.y,Angle_Current.y+self.Tank_AngleDiffuseNumber)
				local Heigh_Ratio = (self:GetEnemy():GetPos().z - self:GetPos().z ) / self:GetPos():Distance(Vector(self:GetEnemy():GetPos().x,self:GetEnemy():GetPos().y,self:GetPos().z))

				if Heigh_Ratio < 0.15 then -- If it is that high than move away from it
					-- To help the gunner shoot
					if self.Tank_UseGetRightForSpeed == true then
					phys:SetVelocity(self:GetRight():GetNormal()*self.Tank_MoveAwaySpeed) else
					phys:SetVelocity(self:GetForward():GetNormal()*self.Tank_MoveAwaySpeed) end
					if Angle_Diffuse > 15 then
						self:SetLocalAngles( self:GetLocalAngles() + Angle(0,self.Tank_TurningSpeed,0))
						phys:SetAngles(self:GetAngles())
					elseif Angle_Diffuse < -15 then
						self:SetLocalAngles( self:GetLocalAngles() + Angle(0,-self.Tank_TurningSpeed,0))
						phys:SetAngles(self:GetAngles())
					end
				//if self:GetEnemy().VJ_IsHugeMonster == false then
				elseif math.abs(Heigh_Ratio) > 1 && math.abs(Heigh_Ratio) < 0.6 then -- If it is that high than move toward it
					-- Run over
					if self.Tank_UseGetRightForSpeed == true then
					phys:SetVelocity(self:GetRight():GetNormal()*self.Tank_MoveAwaySpeed) else
					phys:SetVelocity(self:GetForward():GetNormal()*self.Tank_MoveAwaySpeed) end
					if Angle_Diffuse > 15 then
						self:SetLocalAngles( self:GetLocalAngles() + Angle(0,self.Tank_TurningSpeed,0))
						phys:SetAngles(self:GetAngles())
					elseif Angle_Diffuse < -15 then
						self:SetLocalAngles( self:GetLocalAngles() + Angle(0,-self.Tank_TurningSpeed,0))
						phys:SetAngles(self:GetAngles())
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttackCheck_RangeAttack()
	local pospara = self:GetPoseParameter("aim_yaw") -- Thanks Bizz!
	local viewcode = ((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()) - (self:GetPos() + self:OBBCenter())):Angle()
	local viewniger = math.abs(viewcode.y - (self:GetAngles().y + pospara))
	if viewniger >= 360 then viewniger = viewniger - 360 end
	if math.abs(viewniger) <= 10 then return true end
	return false
end	
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self:GetAttachment(self:LookupAttachment("muzzle")).Pos
	bullet.Dir = (self:GetEnemy():GetPos()+ Vector(0,0,0)+self:GetEnemy():OBBCenter())-self:GetAttachment(self:LookupAttachment("muzzle")).Pos
	bullet.Spread = 0.000001
	bullet.Tracer = 1
	bullet.TracerName = "AirboatGunTracer"
	bullet.Force = 1
	bullet.Damage = 6
	bullet.AmmoType = "Ar2"
	bullet.Callback = function ( attacker, tr, dmginfo ) 
 		local dm = math.random(1,2)
				if ( dm == 1 ) then
			dmginfo:SetDamageType(DMG_AIRBOAT)
				elseif ( dm == 2 ) then		
			dmginfo:SetDamageType(DMG_AIRBOAT)
			else
			end
			end
			self:FireBullets(bullet)	
			
	ParticleEffectAttach("npc_lav_muzzleflash",PATTACH_POINT_FOLLOW,self,1)
	VJ_EmitSound(self,{"weapons/ar2/fire1.wav"},100,self:VJ_DecideSoundPitch(80,100))
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	self:Ignite(99999)
	end
	---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
	self.gunnerlastangles = self.Gunner:GetAngles()
	self.gunnerlastgunlevel = self.Gunner.Wheel:GetAngles()
	
	self.Gunner.Dead = true
	util.BlastDamage(self,self,self:GetPos(),400,100)
	util.ScreenShake(self:GetPos(),100,200,1,3000)
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter()) -- the vector of were you want the effect to spawn
		effectdata:SetScale(190) -- how big the particles are, can even be 0.1 or 0.6
		util.Effect( "Explosion", effectdata )
		ParticleEffect("vj_explosion2",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*60,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*50,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-60,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*70,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-70,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*85,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-85,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*30,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-30,Angle(0,0,0),nil)
		VJ_EmitSound(self,{"weapons/expode4.wav"},90,self:VJ_DecideSoundPitch(110,140))
 	local corpsess5 = ents.Create("prop_physics")
	corpsess5:SetModel("models/combine_apc_destroyed_gib01.mdl")
	corpsess5:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess5:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess5:Spawn()
	corpsess5:SetColor(self:GetColor())
	corpsess5:SetMaterial(self:GetMaterial())
	corpsess5:GetPhysicsObject():AddVelocity( Vector( math.Rand( -0, 0 ), math.Rand( -0, 0 ), 0 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess5:SetCollisionGroup(1) else corpsess5:SetCollisionGroup(0) end
	corpsess5:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess5:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess5:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end

 	local corpsess6 = ents.Create("prop_physics")
	corpsess6:SetModel("models/combine_apc_destroyed_gib02.mdl")
	corpsess6:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess6:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess6:Spawn()
	corpsess6:SetColor(self:GetColor())
	corpsess6:SetMaterial(self:GetMaterial())
	corpsess6:GetPhysicsObject():AddVelocity( Vector( math.Rand( -50, 50 ), math.Rand( -50, 50 ), 10 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess6:SetCollisionGroup(1) else corpsess6:SetCollisionGroup(0) end
	corpsess6:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess6:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess6:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end


 	local corpsess7 = ents.Create("prop_physics")
	corpsess7:SetModel("models/combine_apc_destroyed_gib03.mdl")
	corpsess7:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess7:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess7:Spawn()
	corpsess7:SetColor(self:GetColor())
	corpsess7:SetMaterial(self:GetMaterial())
	corpsess7:GetPhysicsObject():AddVelocity( Vector( math.Rand( -70, 70 ), math.Rand( -70, 70 ), 40 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess7:SetCollisionGroup(1) else corpsess7:SetCollisionGroup(0) end
	corpsess7:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess7:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess7:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end

 	local corpsess8 = ents.Create("prop_physics")
	corpsess8:SetModel("models/combine_apc_destroyed_gib04.mdl")
	corpsess8:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess8:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess8:Spawn()
	corpsess8:SetColor(self:GetColor())
	corpsess8:SetMaterial(self:GetMaterial())
	corpsess8:GetPhysicsObject():AddVelocity( Vector( math.Rand( -10, 10 ), math.Rand( -10, 10 ), 30 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess8:SetCollisionGroup(1) else corpsess8:SetCollisionGroup(0) end
	corpsess8:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess8:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess8:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end

 	local corpsess9 = ents.Create("prop_physics")
	corpsess9:SetModel("models/combine_apc_destroyed_gib05.mdl")
	corpsess9:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess9:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess9:Spawn()
	corpsess9:SetColor(self:GetColor())
	corpsess9:SetMaterial(self:GetMaterial())
	corpsess9:GetPhysicsObject():AddVelocity( Vector( math.Rand( -30, 30 ), math.Rand( -30, 30 ), 80 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess9:SetCollisionGroup(1) else corpsess9:SetCollisionGroup(0) end
	corpsess9:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess9:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess9:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end

 	local corpsess10 = ents.Create("prop_physics")
	corpsess10:SetModel("models/combine_apc_destroyed_gib06.mdl")
	corpsess10:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess10:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess10:Spawn()
	corpsess10:SetColor(self:GetColor())
	corpsess10:SetMaterial(self:GetMaterial())
	corpsess10:GetPhysicsObject():AddVelocity( Vector( math.Rand( -40, 40 ), math.Rand( -40, 40 ), 20 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess10:SetCollisionGroup(1) else corpsess10:SetCollisionGroup(0) end
	corpsess10:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess10:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess10:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end

 	local corpsess11 = ents.Create("prop_physics")
	corpsess11:SetModel("models/Gibs/helicopter_brokenpiece_01.mdl")
	corpsess11:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess11:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess11:Spawn()
	corpsess11:SetColor(self:GetColor())
	corpsess11:SetMaterial(self:GetMaterial())
	corpsess11:GetPhysicsObject():AddVelocity( Vector( math.Rand( -80, 80 ), math.Rand( -80, 80 ), 50 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess11:SetCollisionGroup(1) else corpsess11:SetCollisionGroup(0) end
	corpsess11:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess11:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess11:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end	
	
	 	local corpsess12 = ents.Create("prop_physics")
	corpsess12:SetModel("models/Gibs/helicopter_brokenpiece_02.mdl")
	corpsess12:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess12:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess12:Spawn()
	corpsess12:SetColor(self:GetColor())
	corpsess12:SetMaterial(self:GetMaterial())
	corpsess12:GetPhysicsObject():AddVelocity( Vector( math.Rand( -10, 10 ), math.Rand( -10, 10 ), 10 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess12:SetCollisionGroup(1) else corpsess12:SetCollisionGroup(0) end
	corpsess12:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess12:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess12:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end	
	
	
	
	 	local corpsess13 = ents.Create("prop_physics")
	corpsess13:SetModel("models/Gibs/helicopter_brokenpiece_03.mdl")
	corpsess13:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess13:SetAngles(self:GetAngles()+Angle(0,-90,0))
	corpsess13:Spawn()
	corpsess13:SetColor(self:GetColor())
	corpsess13:SetMaterial(self:GetMaterial())
	corpsess13:GetPhysicsObject():AddVelocity( Vector( math.Rand( -30, 30 ), math.Rand( -30, 30 ), 20 ) )
	if GetConVarNumber("ai_serverragdolls") == 0 then corpsess13:SetCollisionGroup(1) else corpsess13:SetCollisionGroup(0) end
	corpsess13:Ignite( 99 )
	if self.Fadecorpsess == true then corpsess13:Fire(self.FadecorpsessType, "", self.FadecorpsessTime) end
	if GetConVarNumber("vj_npc_corpsessfade") == 1 then corpsess13:Fire("kill", "", GetConVarNumber("vj_npc_corpsessfadetime")) end	
	
	
	
	
	
	
	
	end
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)
	if IsValid(self.Gunner) then
		self.Gunner.Dead = true
		if self:IsOnFire() then self.Gunner:Ignite(math.Rand(8,10),0) end
	end

	timer.Simple(0,function()
		if self:IsValid() then
			VJ_EmitSound(self,"weapons/expode5.wav",85,100)
			util.BlastDamage(self,self,self:GetPos(),200,40)
			util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2",self:GetPos(),Angle(0,0,0),nil) end
		end
	end)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	util.BlastDamage(self, self, self:GetPos(), 400, 40)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)

	-- Spawn the gunner
	if IsValid(self.Gunner) then
		local gunnercorpse = self.Gunner:CreateDeathCorpse(dmginfo,hitgroup)
		if IsValid(gunnercorpse) then table.insert(GetCorpse.ExtraCorpsesToRemove,gunnercorpse) end
			if self.Gunner:IsValid() then self.Gunner:Remove() end
	end

	-- Spawn the Soldier
	local panisrand = math.random(1,3)
	if panisrand == 1 then
		self:CreateExtraDeathCorpse("prop_ragdoll",VJ_PICKRANDOMTABLE(self.Tank_DeathSoldierModels),{Pos=self:GetPos()+self:GetUp()*90+self:GetRight()*-30,Vel=Vector(math.Rand(-600,600), math.Rand(-600,600),500)},function(extraent) extraent:Ignite(math.Rand(8,10),0) extraent:SetColor(Color(90,90,90)) end)
	end

	self:SetPos(Vector(self:GetPos().x,self:GetPos().y,self:GetPos().z +4)) -- Because the NPC is too close to the ground
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() - Vector(0, 0, 500),
		filter = self
	})
	util.Decal("Scorch",tr.HitPos+tr.HitNormal,tr.HitPos-tr.HitNormal)

	if self.HasGibDeathParticles == true then
		//self.FireEffect = ents.Create( "env_fire_trail" )
		//self.FireEffect:SetPos(self:GetPos()+self:GetUp()*70)
		//self.FireEffect:Spawn()
		//self.FireEffect:SetParent(GetCorpse)
		//ParticleEffectAttach("smoke_large_01b",PATTACH_ABSORIGIN_FOLLOW,GetCorpse,0)
		ParticleEffect("vj_explosion3",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() +self:GetForward()*-130,Angle(0,0,0),nil)
		ParticleEffect("vj_explosion2",self:GetPos() +self:GetForward()*130,Angle(0,0,0),nil)
		ParticleEffectAttach("smoke_burning_engine_01",PATTACH_ABSORIGIN_FOLLOW,GetCorpse,0)
		local explosioneffect = EffectData()
		explosioneffect:SetOrigin(self:GetPos())
		util.Effect("VJ_Medium_Explosion1",explosioneffect)
		util.Effect("Explosion", explosioneffect)
		local dusteffect = EffectData()
		dusteffect:SetOrigin(self:GetPos())
		dusteffect:SetScale(800)
		util.Effect("ThumperDust",dusteffect)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/