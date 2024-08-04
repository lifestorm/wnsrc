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
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------
*/
ENT.Model = "models/weapons/w_miniguno.mdl" -- Leave empty if using more than one model 

ENT.StartHealth = 0
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} 
ENT.SquadName = "combine" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.PlayerFriendly = false -- Makes the SNPC friendly to the player and HL2 Resistance

-- Tank Base
ENT.Tank_AngleDiffuseNumber = 0
ENT.Tank_UseNegativeAngleDiffuseNumber = true -- true
ENT.Tank_AngleDiffuseGeneralNumber = 100
ENT.Tank_UsesRightAngles = false --true

ENT.ShellSpawnPos = Vector(-175,0,83)
ENT.ShellLightPos = Vector(-164,0,77)
ENT.ShellMuzzlePos = Vector(-163,0,77)
ENT.ShellParticlePos1 = Vector(-165,0,78)
ENT.ShellParticlePos2 = Vector(-165,0,78)

/*
ENT.ShellSpawnPos = Vector(0,225,20)
ENT.ShellLightPos = Vector(0,225,12)
ENT.ShellMuzzlePos = Vector(0,225,12)
ENT.ShellParticlePos1 = Vector(0,225,18)
ENT.ShellParticlePos2 = Vector(0,225,18)
*/

ENT.MG1SpawnPos = Vector(-69,14,83)
ENT.MG1MuzzlePos = Vector(-63,14,81)
ENT.MG1SpawnPos_muzzle = Vector(-63,14,81)

ENT.Tank_SeeFar = 3600 -- If the enemy is higher than this number, than don't shoot!
ENT.Tank_SeeLimit = 8000 -- How far can it see?
ENT.ShellShootUp = -14 --10
ENT.Tank_NotFacingTargetShootPos = -280
ENT.Tank_SeeClose = 140 -- If the enemy is closer than this number, than don't shoot!

ENT.Tank_MG_Damage = 9
ENT.Tank_MG_Cone = 7
ENT.MGShootUp = 30
ENT.MG1_Sound = "weapons/expode3.wav"

ENT.Sonicblastattackrange = 1200
ENT.Sonicblastcharging = 0
ENT.Sonicblastcharged = 0
ENT.Sonicblastdamage = 80
ENT.Sonicblast_AngleDiffuseGeneralNumber01 = 27
ENT.Sonicblast_AngleDiffuseGeneralNumber02 = 20
ENT.Sonicblast_AngleDiffuseGeneralNumber03 = 15
ENT.Sonicblastfiring = 0
ENT.Sonicblastcooldown = 0
ENT.Sonicblastcooldown_timer = 4
ENT.Sonicblastradius01 = 740
ENT.Sonicblastradius02 = 960
ENT.Sonicblastradius03 = 1280

util.AddNetworkString("vj_mili_tiger_shooteffects")

---------------------------------------------------------------------------------------------------------------------------------------------

function ENT:CustomOnSchedule()
	if self.Dead == true then return end

	if self:GetEnemy() == nil then
		if self.Tank_ResetedEnemy == false then
		self.Tank_ResetedEnemy = true
		self:ResetEnemy() end
		//self:FindEnemySphere()
	else
		self.Tank_ResetedEnemy = false
		EnemyPos = self:GetEnemy():GetPos()
		EnemyPosToSelf = self:GetPos():Distance(EnemyPos)
		if EnemyPosToSelf > self.Tank_SeeLimit then -- If more than this, Don't fire!
			self.Tank_Status = 1
		elseif EnemyPosToSelf < self.Tank_SeeFar && EnemyPosToSelf > self.Tank_SeeClose then -- Between this two numbers than fire!
			self.Tank_Status = 0
		else
			self.Tank_Status = 1
		end
	end
end


function ENT:RangeAttack_Base()
if self.Tank_ProperHeightShoot == false then return end

local function Timer_ShellAttack()
	self:RangeAttack_Shell()
	self.FiringShell = false
end

if self.Tank_ShellReady == false && self.Tank_ShellRecharging == 0 then	

	self.Tank_ShellReady = true
end

if self.Dead == false then
	timer.Create( "timer_shell_attack"..self.Entity:EntIndex(), 0.6, 1, Timer_ShellAttack ) 
	
	end

end


function ENT:CustomInitialize()

	self:SetNoDraw(true)
	self.Tank_ShellRecharging = 0
	self.Tank_MGRecharging = 0
	self.Tank_MGbulletfired = 0
	self.Tank_gunanglevalues = 0
	
	self.TankGunLevel = 0
	self.TankGunismoving = 0 

	timer.Simple(0.1,function()
	
	if self:IsValid() then 
	if self:GetParent():IsValid() then 
	if self.Dead == true then return end

	self.Wheel = ents.Create("prop_dynamic")
    self.Wheel:SetModel("models/weapons/w_miniguno.mdl")
	self.Wheel:SetPos(self:GetParent():LocalToWorld(Vector(-55.9,0,76))) -- -29.7 -33.7 --(Vector(-45.5,-5.0,88.0))) --( self:GetPos() + self:GetForward()*-8 + self:GetRight()*0 + self:GetUp()*0 )
	self.Wheel:SetParent( self )
	self.Wheel:SetAngles( self:GetAngles() )
	self.Wheel:Spawn()
	self.Wheel:SetNoDraw(true)
	self:DeleteOnRemove(self.Wheel)
	
	self.Whee2 = ents.Create("prop_dynamic")
    self.Whee2:SetModel("models/weapons/w_miniguno.mdl")
	self.Whee2:SetPos(self:GetParent():GetPos() + Vector(-250,0,40))

	self.Whee2:SetParent( self.Wheel )
	self.Whee2:SetAngles( self:GetAngles() )
	self.Whee2:Spawn()
	self:DeleteOnRemove(self.Whee2)
	self.Whee2:SetNoDraw(false)
	self.Whee2.Owner = self
	
	self.Whee2a = ents.Create("prop_dynamic")
    self.Whee2a:SetModel("models/weapons/w_miniguno.mdl")
	self.Whee2a:SetPos(self:GetParent():GetPos() + Vector(0,0,0))
	self.Whee2a:SetParent( self )
	self.Whee2a:SetAngles( self:GetAngles() )
	self.Whee2a:Spawn()
	self:DeleteOnRemove(self.Whee2a)
	self.Whee2a:SetNoDraw(false)
	self.Whee2a.Owner = self
	end end
	end)

end

function ENT:CustomOnThink_AIEnabled()
	if self.Dead == true then return end
	//print(self:GetEnemy())
	//if self.Tank_ShellReady == true then print("Tank_ShellReady = true") else print("Tank_ShellReady = false") end
	//if self.Tank_FacingTarget == true then print("Tank_FacingTarget = true") else print("Tank_FacingTarget = false") end
	//if self.FiringShell == true then print("FiringShell = true") else print("FiringShell = false") end

	//self:FindEnemySphere()
	//print(self:GetEnemy())
	
	if self:GetParent():GetEnemy() != nil && self:GetEnemy() == nil then
	self:SetEnemy(self:GetParent():GetEnemy())
	end
	
	if self.Tank_GunnerIsTurning == true then
	
	//self:TANK_MOVINGSOUND()
	VJ_STOPSOUND(self.tank_movingsd) 
	
	else

	VJ_STOPSOUND(self.tank_movingsd) 
	
	end
	
	self:CustomOnSchedule()
	
	if self.Tank_FacingTarget == false then self.FiringShell = false end
	if self.Tank_ShellReady == false then self.FiringShell = false end
	if self.Tank_Status == 0 then
		if self:GetEnemy() == nil then
		self.Tank_Status = 1
		self.Tank_GunnerIsTurning = false
	else

	local fucktraces1 = { start = self:GetParent():GetPos(), endpos = self:GetParent():GetPos() + self:GetParent():GetUp()*-15, filter = self:GetParent() }
	local tr1 = util.TraceEntity( fucktraces1, self:GetParent() )
	
	local phys2 = self:GetParent():GetPhysicsObject()
	local Angle_Enemy = (self:GetEnemy():GetPos() - self:GetPos() /*+ Vector(80,0,80)*/):Angle()
	local Angle_Current = self:GetAngles()
	if self.Tank_UseNegativeAngleDiffuseNumber == true then
	Angle_Diffuse = self:AngleDiffuse(Angle_Enemy.y,Angle_Current.y-self.Tank_AngleDiffuseNumber) else -- Cannon looking direction
	Angle_Diffuse = self:AngleDiffuse(Angle_Enemy.y,Angle_Current.y+self.Tank_AngleDiffuseNumber) end -- Cannon looking direction
	local Heigh_Ratio = (self:GetEnemy():GetPos().z - self:GetPos().z ) / self:GetPos():Distance(Vector(self:GetEnemy():GetPos().x,self:GetEnemy():GetPos().y,self:GetPos().z))

		if self.Wheel != nil then
	
	if math.abs(Heigh_Ratio) < 0.35 && (self:GetEnemy():GetPos().z >= self:GetPos().z) && math.abs(Heigh_Ratio) >= 0.15 then 
	
	if self.TankGunLevel == 1 then
	
	self.Tank_ProperHeightShoot = true 
	
	else
	
	if self.TankGunLevel == 0 then
		
	if self.TankGunismoving != 1 then
	self.TankGunismoving = 1
	timer.Simple(0.25, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(3,0,0)) end end)
	timer.Simple(0.5, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(3,0,0)) end end)
	timer.Simple(0.75, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(3,0,0)) end end)
	timer.Simple(1.0, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(3,0,0)) end end)
	timer.Simple(1.25, function() if self.Dead == false then 
	self.TankGunismoving = 0 
	self.TankGunLevel = 1
	end end)
	
	end
	end

	self.Tank_ProperHeightShoot = false 
	
	end

	end
	
	
	if math.abs(Heigh_Ratio) < 0.15 then 
	
	if self.TankGunLevel == 0 then
	
	self.Tank_ProperHeightShoot = true 
	
	else
	
	if self.TankGunLevel == 1 then
		
	if self.TankGunismoving != 1 then
	self.TankGunismoving = 1
	timer.Simple(0.25, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(-3,0,0)) end end)
	timer.Simple(0.5, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(-3,0,0)) end end)
	timer.Simple(0.75, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(-3,0,0)) end end)
	timer.Simple(1.0, function() if self.Dead == false then self.Wheel:SetLocalAngles( self.Wheel:GetLocalAngles() + Angle(-3,0,0)) end end)
	timer.Simple(1.25, function() if self.Dead == false then 
	self.TankGunismoving = 0 
	self.TankGunLevel = 0 
	end end)
	
	end
	end

	self.Tank_ProperHeightShoot = false 
	
	end
	
	else 
	
	if math.abs(Heigh_Ratio) >= 0.35 then 
	self.Tank_ProperHeightShoot = false 
	end
	
	end
	
	end

	self.Tank_GunnerIsTurning = false
	if math.abs(Angle_Diffuse) < self.Tank_AngleDiffuseGeneralNumber && self.FiringShell == false && math.abs(Heigh_Ratio) < 0.35 && self:GetPos():Distance(self:GetEnemy():GetPos()) > self.Tank_SeeClose then
	-- If the diffuse and the height and the enemy distance is higher than the self.Tank_SeeClose than shoot!
	if (math.abs(Heigh_Ratio) < 0.35 && self.TankGunLevel == 1 && math.abs(Heigh_Ratio) >= 0.15 && (self:GetEnemy():GetPos().z >= self:GetPos().z)) || (math.abs(Heigh_Ratio) < 0.15 && self.TankGunLevel == 0) then
	
		self.Tank_GunnerIsTurning = false
		self.FiringShell = true
		self.Tank_FacingTarget = true
		if self:Visible(self:GetEnemy()) then
		if GetConVarNumber("vj_npc_norange") == 0 then
		self:RangeAttack_Base() end end
	end
		
	elseif Angle_Diffuse > self.Tank_AngleDiffuseGeneralNumber then
		//self:SetLocalAngles( self:GetLocalAngles() + Angle(0,2,0))
		

		
		self:SetLocalAngles( self:GetLocalAngles() + Angle(0,math.random(1.15,2),0))
		self.Tank_GunnerIsTurning = true
		self.Tank_FacingTarget = false
		self.FiringShell = false

	elseif Angle_Diffuse < -self.Tank_AngleDiffuseGeneralNumber then
		//self:SetLocalAngles( self:GetLocalAngles() + Angle(0,-2,0))
		
		

		
		
		self:SetLocalAngles( self:GetLocalAngles() + Angle(0,math.random(-2.15,-3),0))
		self.Tank_GunnerIsTurning = true
		self.Tank_FacingTarget = false
		self.FiringShell = false
		
	end
  end
 end
end

function ENT:RangeAttack_Shell()
	if self.Dead == true then return end
	if self.Tank_ShellRecharging == 1 then return end
	if self.Dead == false then if GetConVarNumber("ai_disabled") == 0 then
	if self.Tank_ProperHeightShoot == false then return end
	if /*self.Tank_FacingTarget == true &&*/ IsValid(self:GetEnemy()) && self:GetEnemy() != NULL && self:GetEnemy() != nil then
	if self:Visible(self:GetEnemy()) then
	if self.HasSounds == true then
	if GetConVarNumber("vj_npc_sd_rangeattack") == 0 then

	self:EmitSound("weapons/stinger_fire1.wav",500,100,0.8) end end
	//self:StartShootEffects()
	self.FireLight1 = ents.Create("light_dynamic")
	self.FireLight1:SetKeyValue("brightness", "4")
	self.FireLight1:SetKeyValue("distance", "400")
	self.FireLight1:SetPos(self.Whee2:LocalToWorld(self.ShellLightPos))
	self.FireLight1:SetLocalAngles(self:GetAngles())
	self.FireLight1:Fire("Color", "255 150 60")
	self.FireLight1:SetParent(self)
	self.FireLight1:Spawn()
	self.FireLight1:Activate()
	self.FireLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.FireLight1)
	timer.Simple(0.1,function() if self.Dead == false then self.FireLight1:Remove() end end)
	local panis1= "smoke_exhaust_01"
	local panis2 = "Advisor_Pod_Steam_Continuous"
	timer.Simple(0.1, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.2, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.3, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.4, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.5, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.6, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.7, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.8, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.9, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.1, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.2, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.3, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.4, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.5, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.6, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.7, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.8, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(1.9, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.1, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.2, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.3, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.4, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.5, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.6, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.7, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.8, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(2.9, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(3, function() if self.Dead == false then self:StartShootEffects() end end)
	timer.Simple(0.1, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.2, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.3, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.4, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.5, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.6, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.7, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.8, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.9, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(1, function() if self.Dead == false then ParticleEffect(panis1,self.Whee2:LocalToWorld(self.ShellParticlePos1),Angle(0,90,0),self) end end)
	timer.Simple(0.1, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.2, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.3, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.4, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.5, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.6, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.7, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.8, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.9, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(1, function() if self.Dead == false then ParticleEffect(panis2,self.Whee2:LocalToWorld(self.ShellParticlePos2),Angle(0,90,0),self) end end)
	timer.Simple(0.2, function() if self.Dead == false then self:StopParticles() end end)
	timer.Simple(0.4, function() if self.Dead == false then self:StopParticles() end end)
	timer.Simple(0.6, function() if self.Dead == false then self:StopParticles() end end)
	timer.Simple(0.8, function() if self.Dead == false then self:StopParticles() end end)
	timer.Simple(1.01, function() if self.Dead == false then self:StopParticles() end end)
	util.ScreenShake( self:GetPos(), 100, 200, 1, 2500 )
	local flash = ents.Create("env_muzzleflash")
		flash:SetPos(self.Whee2:LocalToWorld(self.ShellMuzzlePos))
		flash:SetKeyValue("scale","4")
		if self.Tank_UsesRightAngles == true then
		flash:SetKeyValue("angles",tostring(self:GetRight():Angle())) else
		flash:SetKeyValue("angles",tostring((self:GetForward()*-1):Angle())) end
		flash:Fire( "Fire", 0, 0 )
	local dust = EffectData()
		dust:SetOrigin(self:GetParent():GetPos())
		dust:SetScale(500)
		util.Effect( "ThumperDust", dust )
	if self.Tank_FacingTarget == true then
	ShootPos = (self:GetEnemy():GetPos()-self:GetPos() + self:GetUp()*-self.ShellShootUp) end
	if self.Tank_FacingTarget == false then
	if self.Tank_UsesRightAngles == true then
	ShootPos = (self:GetRight()*self.Tank_NotFacingTargetShootPos) else
	ShootPos = (self:GetForward()*self.Tank_NotFacingTargetShootPos) end end
	if self:GetEnemy():GetClass() == "npc_vj_mili_tiger_red" or self:GetEnemy():GetClass() == "npc_vj_mili_tiger_redg" or self:GetEnemy():GetClass() == "npc_vj_milifri_tiger_red" or self:GetEnemy():GetClass() == "npc_vj_milifri_tiger_redg" then
	ShootPos = (self:GetEnemy():GetPos()-self:GetPos() + self:GetUp()*-self.ShellShootUp) end
	
	
	local physe = self:GetEnemy():GetPhysicsObject()
	
	
	if physe != nil then
	if physe:IsValid() then
	if physe:GetVelocity():Length() > 30 then
	if self.Tank_FacingTarget == true then
	if self:GetPos():Distance(self:GetEnemy():GetPos()) > 250 then
	
	local physe_enemypos = self:GetEnemy():GetPos()
	
	if physe:GetVelocity():Length() > 600 then
	physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity():GetNormalized()*100
	else
	
	if self:GetPos():Distance(self:GetEnemy():GetPos()) > 250 && self:GetPos():Distance(self:GetEnemy():GetPos()) < 1450 then
	physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(2,4))*0.1)
	end
	
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 1450 && self:GetPos():Distance(self:GetEnemy():GetPos()) < 2150 then
	physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(5,7))*0.1)
	end
	
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 2150 && self:GetPos():Distance(self:GetEnemy():GetPos()) < 4500 then
	physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(6,7))*0.1)
	end
	
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 4500 && self:GetPos():Distance(self:GetEnemy():GetPos()) < 6000 then
	physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(7,8))*0.1)
	end
	
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 6000 && self:GetPos():Distance(self:GetEnemy():GetPos()) < 9900 then
	physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(7,9))*0.1)
	end
	
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 9900 then
	physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(8,9))*0.1)
	end
	
		if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 300 && (math.random(1,10) > 4) then
		
			physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(0,1))*0.1)
			
		end
		
		if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 3300 && (math.random(1,4) >= 3) then
		
			physe_enemypos = self:GetEnemy():GetPos() + physe:GetVelocity()*((math.random(9,11))*0.1)
			
		end
	
	end
	
	ShootPos = (physe_enemypos - self:GetPos() + self:GetUp()*-self.ShellShootUp)
	
	end
	end
	end
	end
	end
	
if (CLIENT) then return end
	local SpawnBlaserRod = ents.Create("obj_vj_tank_shella")
	local OwnerPos = self:GetShootPos()
	local OwnerAng = self:GetAimVector():Angle()
	OwnerPos = OwnerPos + OwnerAng:Forward()*-20 + OwnerAng:Up()*-9 + OwnerAng:Right()*math.random(0,0)
	if self:IsPlayer() then SpawnBlaserRod:SetPos(OwnerPos) else SpawnBlaserRod:SetPos(self:GetAttachment(self:LookupAttachment("muzzle")).Pos) end
	if self:IsPlayer() then SpawnBlaserRod:SetAngles(OwnerAng) else SpawnBlaserRod:SetAngles(self:GetAngles()) end
	SpawnBlaserRod:SetOwner(self)
	SpawnBlaserRod:Activate()
	SpawnBlaserRod:Spawn()
	
	local phy = SpawnBlaserRod:GetPhysicsObject()
	if phy:IsValid() then
		if self:IsPlayer() then
		phy:ApplyForceCenter(self:GetAimVector() * 4000) else //200000
		//phy:ApplyForceCenter((self:GetEnemy():GetPos() - self:GetPos()) * 4000)
		phy:ApplyForceCenter(((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()+self:GetEnemy():GetUp()*math.random(6045,6045)) - self:GetPos()+self:OBBCenter()+self:GetEnemy():GetUp()*math.random(-45,-45)) * 4500)
		//data.Dir = (Entity:GetEnemy():GetPos()+Entity:GetEnemy():OBBCenter()+Entity:GetEnemy():GetUp()*-45) -Entity:GetPos()+Entity:OBBCenter()+Entity:GetEnemy():GetUp()*-4500
		end
	end
		self.Tank_ShellReady = false
		self.FiringShell = false

		self.Tank_ShellRecharging = 1
		timer.Simple((1.15 + (math.random(0,6))*0.1), function() if self.Dead == false then self.Tank_ShellRecharging = 0 end end)
		else
		self.Tank_ShellReady = false
		self.FiringShell = false
		self.Tank_FacingTarget = false
	end
   end
  end
 end
end




/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/