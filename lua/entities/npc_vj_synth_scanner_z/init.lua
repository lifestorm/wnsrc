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
ENT.Model = {"models/shield_scanner.mdl"}
ENT.StartHealth = 60
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.IdleAlwaysWander = true
ENT.SightAngle = 100

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.HasItemDropsOnDeath = true
ENT.ItemDropsOnDeathChance = 2
ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
}

ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true
ENT.AnimTbl_RangeAttack = {"openup"}
ENT.TimeUntilRangeAttackProjectileRelease = 2.8
ENT.NextRangeAttackTime = 6
ENT.DisableDefaultRangeAttackCode = true
ENT.RangeToMeleeDistance = 0
ENT.RangeDistance = 400

ENT.Aerial_FlyingSpeed_Calm = 120
ENT.Aerial_FlyingSpeed_Alerted = 240
ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.AA_ConstantlyMove = true
ENT.AA_MinWanderDist = 500

ENT.ConstantlyFaceEnemy = true
ENT.ConstantlyFaceEnemyDistance = 10000

ENT.NoChaseAfterCertainRange = true
ENT.NoChaseAfterCertainRange_CloseDistance = 0

ENT.GibOnDeathDamagesTable = {"UseDefault"}
ENT.HasGibOnDeathSounds = false

ENT.SoundTbl_Alert = {"NPC_SScanner.Alert"}
ENT.SoundTbl_Investigate = {"NPC_SScanner.Alert"}
ENT.SoundTbl_CombatIdle = {"NPC_SScanner.Idle"}
ENT.SoundTbl_Breath = {"NPC_SScanner.Combat"}
ENT.SoundTbl_Pain = {"NPC_SScanner.Pain"}
ENT.SoundTbl_Death = {"NPC_SScanner.Die"}

ENT.DeathSoundLevel = 130
ENT.BreathSoundLevel = 90

ENT.NextRandomFlash = 50
ENT.FlashDistance = 10000
ENT.RedLightDist = ENT.RangeDistance*1.25

ENT.CrashChance = 2

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Eyebase_T", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(15, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}

function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("NOTE: Controlling is not really supported for this SNPC!!")

end

function ENT:CustomOnInitialize()

	self:SetCollisionBounds(Vector(10, 10, 10), Vector(-10, -10, -10))

	self.Mines = GetConVar("vj_zippycombines_scanner_mines"):GetInt()

	timer.Simple(0.01,function()

		if IsValid(self) then

			if !self.IsThrownScanner then
				self:SetPos(self:GetPos() + Vector(0,0,50))
			end

		end

	end)

	--self:SetBloodColor(BLOOD_COLOR_MECH)

end

function ENT:CustomOnThink()
	if IsValid(self.Mine) then
		self.Mine.VJ_NPC_Class = self.VJ_NPC_Class
	end
end

function ENT:CustomOnThink_AIEnabled()

	if self.Mines == 0 then
		self.HasRangeAttack = false
	end

	if self.HasRangeAttack then
		self.NoChaseAfterCertainRange_FarDistance = self.RangeDistance
	else
		self.NoChaseAfterCertainRange_FarDistance = 750
	end

	local tr = util.TraceLine({
	start = self:GetPos(),
	endpos = self:GetPos() + self:GetUp() * -125,
	filter = self:GetEnemy(),
	mask = MASK_NPCWORLDSTATIC,
	})
	if tr.HitWorld then
		self:SetVelocity((self:GetPos() - tr.HitPos) * (15 / self:GetPos():Distance(tr.HitPos)))
	end

	if IsValid(self:GetEnemy()) && self:GetPos():Distance(self:GetEnemy():GetPos()) < self.FlashDistance && self:Visible(self:GetEnemy()) then
		--self.CallForHelp = true
		if self.NextRandomFlash != 0 then
			self.NextRandomFlash = self.NextRandomFlash - 1
		end
		if self.NextRandomFlash == 0 then
			self:CustomOnCallForHelp()
		end
	else
		--self.CallForHelp = true
	end

	if (!self.SpotlightOn && !IsValid(self:GetEnemy())) or (!self.SpotlightOn && IsValid(self:GetEnemy()) && self:GetEnemy():GetPos():Distance(self:GetPos()) > self.RedLightDist) then
		if IsValid(self.AngryLight) then
			self.AngryLight:Remove()
		end
		self.SpotlightOn = true
		self:EmitSound( "HL2Player.FlashLightOn", 100, 100)
		self.Spotlight = ents.Create("point_spotlight")
		self.Spotlight:SetPos( self:GetAttachment(5).Pos )
		self.Spotlight:SetAngles( self:GetAngles() )
		self.Spotlight:SetKeyValue( "spawnflags", "1" + "2" )
		self.Spotlight:SetKeyValue( "spotlightlength", "100" )
		self.Spotlight:SetKeyValue( "spotlightwidth", "10" )
		self.Spotlight:SetColor(Color(150,150,150,255))
		self.Spotlight:SetParent(self)
		self.Spotlight:Spawn()
		self.Spotlight:Activate()
	end
	if self.SpotlightOn && IsValid(self:GetEnemy()) && self:GetEnemy():GetPos():Distance(self:GetPos()) < self.RedLightDist then
		self.AngryLight = ents.Create( "env_sprite" )
		self.AngryLight:SetKeyValue( "model","sprites/blueflare1.spr" )
		self.AngryLight:SetKeyValue( "rendercolor","255 50 0" )
		self.AngryLight:SetPos( self:GetPos() )
		self.AngryLight:SetMoveType( MOVETYPE_NONE )
		self.AngryLight:SetParent( self )
		self.AngryLight:Fire( "SetParentAttachment", "light" )
		self.AngryLight:SetKeyValue( "scale","0.4" )
		self.AngryLight:SetKeyValue( "rendermode","9" )
		self.AngryLight:Spawn()
		self:DeleteOnRemove(self.AngryLight)
		self.SpotlightOn = false
		self:EmitSound( "HL2Player.FlashLightOff", 100, 100)
		self.Spotlight:SetParent()
		self.Spotlight:Fire("lightoff")
		self.Spotlight:Fire("kill",self.Spotlight, 0.5)
	end

end

function ENT:CustomOnAlert(ent)

	self.TurningUseAllAxis = true

end

function ENT:CustomOnResetEnemy()

	self.TurningUseAllAxis = false

end

function ENT:CustomOnCallForHelp(ally)

	self.NextRandomFlash = 50

	if !self.IsDoingFlash then
		self.IsDoingFlash = true
		local expLight = ents.Create("light_dynamic")
		expLight:SetKeyValue("brightness", "5")
		expLight:SetKeyValue("distance", "300")
		expLight:Fire("Color", "255 255 255")
		expLight:SetPos(self:GetPos())
		expLight:Spawn()
		expLight:Activate()
		expLight:Fire("TurnOn", "", 0)
		timer.Simple(0.2,function() if IsValid(expLight) then expLight:Remove() end end)
		self:DeleteOnRemove(expLight)

		self.Flash1 = ents.Create( "env_sprite" )
		self.Flash1:SetKeyValue( "model","sprites/blueflare1.spr" )
		self.Flash1:SetKeyValue( "rendercolor","125 125 125" )
		self.Flash1:SetPos( self:GetPos() )
		self.Flash1:SetMoveType( MOVETYPE_NONE )
		self.Flash1:SetParent( self )
		self.Flash1:Fire( "SetParentAttachment", "light" )
		self.Flash1:SetKeyValue( "scale","5" )
		self.Flash1:SetKeyValue( "rendermode","9" )
		self.Flash1:Spawn()
		self.Flash2 = ents.Create( "env_sprite" )
		self.Flash2:SetKeyValue( "model","sprites/blueflare1.spr" )
		self.Flash2:SetKeyValue( "rendercolor","255 255 255" )
		self.Flash2:SetPos( self:GetPos() )
		self.Flash2:SetMoveType( MOVETYPE_NONE )
		self.Flash2:SetParent( self )
		self.Flash2:Fire( "SetParentAttachment", "light" )
		self.Flash2:SetKeyValue( "scale","2.5" )
		self.Flash2:SetKeyValue( "rendermode","9" )
		self.Flash2:Spawn()
		timer.Simple(0.1,function() if IsValid(self) then self.Flash1:Remove() end end)
		timer.Simple(0.1,function() if IsValid(self) then self.Flash2:Remove() end end)
		timer.Simple(1,function() if IsValid(self) then self.IsDoingFlash = false end end)

		if math.random(1,2) == 1 then
			self:EmitSound( "NPC_SScanner.TakePhoto", 100, 100)
		else
			self:EmitSound( "NPC_SScanner.Attackflash", 100, 100)
		end
	end

end

function ENT:CustomOnRangeAttack_AfterStartTimer(seed)

	self.Mine = ents.Create("obj_vj_hopper_mine_z")
	self.Mine:SetPos(self:GetPos())
	self.Mine:SetOwner(self)
	self.Mine:SetMoveType( MOVETYPE_NONE )
	self.Mine:SetParent(self,3)
	timer.Simple(0.5,function() if IsValid(self) then self.Mine:Spawn() end end)
	timer.Simple(self.TimeUntilRangeAttackProjectileRelease + 0.1,function() if IsValid(self) && self.Mine:GetParent() == self then self.Mine:Remove() end end)

end

function ENT:CustomRangeAttackCode()

	self.Mine:SetParent(nil)
	self.Mine:SetMoveType( MOVETYPE_VPHYSICS )
	self.Mine:SetPos(self:GetAttachment(3).Pos)
	self:VJ_ACT_PLAYACTIVITY("closeup",true,1,true)
	self.Mines = self.Mines - 1

end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

	if dmginfo:IsBulletDamage() then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
        if math.random(1, 3) == 1 then
			self:EmitSound("weapons/fx/rics/ric1.wav", 82, math.random(85, 115))
			
			local spark = ents.Create("env_spark")
			spark:SetPos(dmginfo:GetDamagePosition())
			spark:Spawn()
			spark:Fire("StartSpark", "", 0)
			spark:Fire("StopSpark", "", 0.001)
			self:DeleteOnRemove(spark)
		end
	end

end

function ENT:Crash()

	local targetpos = self:GetPos() + self:GetForward() * 100 - Vector(0,0,100)
	if IsValid(self:GetEnemy()) then
		targetpos = self:GetEnemy():GetPos()
	end

	local crashdir = targetpos - self:GetPos()

	local CrashingScannerProp = ents.Create("base_gmodentity")
	CrashingScannerProp:SetModel(self:GetModel())
	CrashingScannerProp:SetPos(self:GetPos())
	CrashingScannerProp:SetAngles(crashdir:Angle())
	CrashingScannerProp:Spawn()
	CrashingScannerProp:SetMoveType(MOVETYPE_FLY)
	CrashingScannerProp:SetSolid(SOLID_VPHYSICS)
	CrashingScannerProp:ResetSequence("hoverclosed")
	CrashingScannerProp.VJ_NPC_Class = self.VJ_NPC_Class

	if IsValid(self.Mine) then
		self.Mine:SetPos(self.Mine:GetPos()-Vector(0,0,45))
	end

	CrashingScannerProp.Explode = function()
		util.VJ_SphereDamage(Entity(0),Entity(0),CrashingScannerProp:GetPos(),300,30,DMG_BLAST,true,true,false,false)
		ParticleEffect("grenade_explosion_01", CrashingScannerProp:GetPos(), Angle(0,0,0), nil)
		ParticleEffect("Explosion_2_Chunks", CrashingScannerProp:GetPos(), Angle(0,0,0), nil)
		local effectdata = EffectData()
		effectdata:SetOrigin(CrashingScannerProp:GetPos())
		util.Effect( "Explosion", effectdata )
		CrashingScannerProp:EmitSound( "Explo.ww2bomb", 130, 100)
		CrashingScannerProp:Remove()
	end

	CrashingScannerProp.Think = function()
		CrashingScannerProp:SetVelocity(crashdir:GetNormalized() * 15)
		CrashingScannerProp:SetAngles(CrashingScannerProp:GetAngles() + Angle(0,0,3))
		CrashingScannerProp:NextThink(CurTime())

		local tr = util.TraceLine({
			start = CrashingScannerProp:GetPos(),
			endpos = CrashingScannerProp:GetPos() + crashdir:GetNormalized() * 3000,
			filter = self
		})

		sound.EmitHint(SOUND_DANGER, tr.HitPos, 300, 0.5)
		return true
	end

	CrashingScannerProp.StartTouch = function()
		CrashingScannerProp:Explode()
	end

	timer.Simple(2, function() if IsValid(CrashingScannerProp) then CrashingScannerProp:Explode() end end)

end

function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)

	if math.random(1, self.CrashChance) == 1 then
		self:Crash()
	else
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib1.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib2.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib3.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib4.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib5.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
		self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib6.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
	end

	return true
end

function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)

	if IsValid(self.Mine) && self.Mine:GetParent() == self then
		self.Mine:SetParent()
		self.Mine:SetPos(self:GetAttachment(3).Pos)
		self.Mine:SetOwner(self)
	end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect( "Explosion", effectdata )
	--ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0), nil)

end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)

	self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib1.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
	self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib6.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
	ParticleEffectAttach("electrical_arc_01_system", PATTACH_ABSORIGIN_FOLLOW, corpseEnt, 0)
	local Spark = ents.Create("env_spark")
	Spark:SetKeyValue("MaxDelay","1")
	Spark:SetKeyValue("Magnitude","2")
	Spark:SetKeyValue("Spark Trail Length","2")
	Spark:SetAngles(corpseEnt:GetAngles())
	Spark:SetParent(corpseEnt)
	Spark:SetPos(corpseEnt:GetPos())
	Spark:Spawn()
	Spark:Activate()
	Spark:Fire("StartSpark", "", 0)
	Spark:Fire("StopSpark", "", 4)
	corpseEnt:DeleteOnRemove(Spark)

	if math.random(1, self.CrashChance) == 1 then -- Crash

		self:Crash()

		corpseEnt:Remove()
	end

end

function ENT:CustomOnRemove()

	if IsValid (self.Spotlight) then
		self.Spotlight:SetParent()
		self.Spotlight:Fire("lightoff")
		self.Spotlight:Fire("kill",self.Spotlight, 0.5)
	end

end
/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/