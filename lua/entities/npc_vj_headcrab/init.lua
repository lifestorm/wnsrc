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
-----------------------------------------------*/
ENT.Model = {"models/halflife/headcrab.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("npc_vj_headcrab_h")
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_TINY
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {"jump"} -- Melee Attack Animations
ENT.LeapDistance = 400 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 150 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.6 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 3 -- How much time until it can use a leap attack?
//ENT.NextAnyAttackTime_Leap = 0.4 -- How much time until it can use any attack again? | Counted in Seconds
//ENT.LeapAttackExtraTimers = {0.3} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.TimeUntilLeapAttackVelocity = 0.2 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 300 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
ENT.LeapAttackDamage = 10
ENT.LeapAttackAnimationFaceEnemy = true 
ENT.LeapToMeleeDistance = 50 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.2 -- Next foot step sound when it is walking
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {""}
ENT.SoundTbl_Idle = {"npc/headcrab/idle1.wav","npc/headcrab/idle2.wav","npc/headcrab/idle3.wav"}
ENT.SoundTbl_Alert = {"npc/headcrab/alert1.wav"}
ENT.SoundTbl_Pain = {"npc/headcrab/pain1.wav","npc/headcrab/pain2.wav","npc/headcrab/pain3.wav"}
ENT.SoundTbl_Death = {"npc/headcrab/die1.wav","npc/headcrab/die2.wav"}
ENT.SoundTbl_BeforeLeapAttack = {"npc/headcrab/attack1.wav","npc/headcrab/attack2.wav","npc/headcrab/attack3.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/headcrab/headbite.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"npc/headcrab/headbite.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(10,10),math.random(1,1),math.random(24,27))))*5 + self:GetUp()*40
end
function ENT:CustomAttackCheck_RangeAttack() 

local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","vortigaunt_hand_glow")
		bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("rightclaw")).Pos)
		bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("rightclaw")).Ang)
		bloodeffect:SetParent(self)
		bloodeffect:Fire("SetParentAttachment","rightclaw")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0.3)
		bloodeffect:Fire("Kill","",1.3)
		
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","vortigaunt_hand_glow")
		bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("leftclaw")).Pos)
		bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("leftclaw")).Ang)
		bloodeffect:SetParent(self)
		bloodeffect:Fire("SetParentAttachment","leftclaw")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0.3)
		bloodeffect:Fire("Kill","",1.3)

local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","striderbuster_break_lightning")
		bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("rightclaw")).Pos)
		bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("rightclaw")).Ang)
		bloodeffect:SetParent(self)
		bloodeffect:Fire("SetParentAttachment","rightclaw")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0.3)
		bloodeffect:Fire("Kill","",1.3)

local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","striderbuster_break_lightning")
		bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("leftclaw")).Pos)
		bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("leftclaw")).Ang)
		bloodeffect:SetParent(self)
		bloodeffect:Fire("SetParentAttachment","leftclaw")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0.3)
		bloodeffect:Fire("Kill","",1.3)
return true 
end 

function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
		bloodeffect:SetScale(120)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter())
		effectdata:SetScale(1)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
		//ParticleEffect("antlion_gib_02",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
	end
	
	
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	return true
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/